# lga — core data structures

Draft. Companion to `spec.md`. Describes the runtime
representation; not the source-text format. Pseudocode is
TypeScript-flavored but the design is language-agnostic.


## Segment

A segment is an interned reference — an integer ID into the
alphabet's segment table. Equality is integer equality.

```ts
type SegmentId = number
```

The alphabet (below) owns the table mapping IDs to records:

```ts
interface SegmentRecord {
  id: SegmentId
  name: string        // identifier used in rule text (e.g. "p!")
  glyph: string       // string used in input/output text (default: name)
}
```

Two reasons for this shape:
- Equality, hashing, and set membership are all O(1) on integers.
- Engine traces refer to segments by ID; display code looks up the
  name/glyph from the alphabet when rendering.


## Marker bits

A small unsigned integer per segment instance. Up to 8 bits.

```ts
type Markers = number   // bit-field; 0 means "no markers"
```

The alphabet declares the bit-to-character mapping:

```ts
interface MarkerSpec {
  char: string        // e.g. "'", "~"
  bit: number         // 0..7
}
```

The clear-all sentinel `,` is not a marker; it is handled at the
parser level and never appears in the runtime representation.


## Alphabet

```ts
interface Alphabet {
  segments: SegmentRecord[]               // ordered, indexed by id
  byName: Map<string, SegmentId>          // name → id
  byGlyph: TrieOrSorted<SegmentId>        // for longest-match lexing
  markers: MarkerSpec[]                   // bit assignments
  markerByChar: Map<string, number>       // char → bit index
}
```

The `byGlyph` structure exists for the input-text lexer (§2 of the
spec — longer glyphs win). A simple sorted list (longest first)
plus a linear scan is fine for the sizes involved (~100 segments).
A trie is mild overkill but cheap.


## Word / Token

A word is a flat sequence of (segment, markers) pairs. The
boundaries `$` are *not* stored in the word; they are inferred at
match time from the start/end indices.

```ts
interface Token {
  seg: SegmentId
  markers: Markers
}

type Word = Token[]
```

Words are immutable. Rule application produces a new word; the
engine emits both the before and after as separate Word values in
the derivation trace (cheap because tokens are small and most of
the array is shared in the trace's mental model — though in practice
just allocating fresh arrays is fine).


## Class

A class is an ordered list of members. A member is either a
segment ID or another class. Classes have names; anonymous classes
(from `<...>` or `[...]` in rule text) get synthetic names or live
inline.

```ts
interface Class {
  name: string                    // "" for anonymous
  members: ClassMember[]
}

type ClassMember =
  | { kind: "seg", id: SegmentId }
  | { kind: "class", cls: Class }
```

Two views are computed (lazily or eagerly):

```ts
interface Class {
  // ...
  flatSegments(): SegmentId[]     // ordered concatenation of all
                                  // transitively-reachable segments;
                                  // used for positional pairing
  segSet(): Set<SegmentId>        // dedup'd; used for context matching
}
```

The `flatSegments` view preserves order — this is what makes
positional pairing work. For Bartholomae's `[C.T C.D C.Dasp]`, the
flat list is 15 segments in column-aligned order.

For context-position use (where a class is a set), `segSet` answers
"is this segment a member" in O(1).


## Pattern (LHS atom)

One element of an LHS. Five flavors:

```ts
type Pattern =
  | { kind: "literal", seg: SegmentId, markerMask: Markers }
  | { kind: "class", cls: Class, markerMask: Markers }
  | { kind: "boundary" }                                  // $
  | { kind: "optional", cls: Class, markerMask: Markers } // class?, zero-or-one
  | { kind: "star", cls: Class, markerMask: Markers }     // class*, uncapturable

interface PatternMatch {
  patternIndex: number          // which LHS position
  start: number                 // word index where match starts
  end: number                   // exclusive
  members: number[]             // for class patterns: index into
                                // flatSegments() of which member matched
                                //   (-1 for literal / boundary / star)
  matchedTokens: Token[]        // copy of the actual tokens matched
                                //   (length > 1 only for "star")
}
```

`markerMask` is the LHS marker constraint. A mask of 0 means "no
constraint" (matches any marker bits). A non-zero mask matches iff
`(token.markers & mask) != 0` per the OR-style spec (§1.3). A
special value (e.g. -1) encodes the `,` form: "matches iff markers
== 0."

The `members` field is the key bookkeeping for pairing: when a
class pattern matches segment X, we record *which index of
flatSegments(class) it was* — that index drives the RHS pairing
lookup.


## Output (RHS atom)

One element of an RHS. Each output produces zero or one segments
(stars on the RHS are not supported; ban them at the parser).

```ts
type Output =
  | { kind: "copy", consume: boolean, source?: number }
        // _ or _/N. source undefined → "current counter".
  | { kind: "delete" }
        // . — must be a consuming output
  | { kind: "literal", token: Token, consume: boolean }
        // "glyph" or +"glyph"
  | { kind: "pair", consume: boolean, cls: Class, source?: number,
      markerOp: MarkerOp }
        // Class or Class/N, with optional +
  | { kind: "starCopy", consume: boolean, source?: number }
        // for star-matched LHS, the run-of-matched-tokens passes
        // through with optional marker modification

interface MarkerOp {
  clearAll: boolean             // true if `,` was in the suffix
  setBits: Markers              // bits explicitly set after `,`
                                //   0 if no explicit markers
}
```

Semantics of `MarkerOp` applied to incoming markers `M`:
1. If `clearAll`, M becomes 0.
2. M |= setBits.
3. If neither was set (the default), M is unchanged.

This gives the "ride along by default" behavior, with `Name'`
forcing a bit, `Name,` clearing all, and `Name,'` doing both.


## Rule

```ts
interface Rule {
  source: string                // original source-text line, for trace
  lhs: Pattern[]
  rhs: Output[]
  // sanity-checked at load time:
  //   number of consuming outputs in rhs == lhs.length
  //   every /N reference is in range
  //   every +X with a class has a /N
}
```


## Rule application

```ts
interface AppliedMatch {
  start: number                   // word index
  patternMatches: PatternMatch[]  // one per lhs position
  outputTokens: Token[]           // result of applying rhs
}

function applyRule(rule: Rule, word: Word): {
  result: Word
  matches: AppliedMatch[]          // non-overlapping, left-to-right
}
```

The scanner walks the word left to right. At each index, attempt
to match the LHS starting there. If it matches, record the match
and the produced tokens; resume scanning *after* the matched span
(no overlapping matches within one rule application). If no match,
advance by one and try again.


## Trace

```ts
interface TraceStep {
  rule: Rule
  before: Word
  after: Word
  matches: AppliedMatch[]   // empty if no match
}

type Trace = TraceStep[]
```

The trace is the engine's primary output. Final word = last step's
`after`. Test runner compares last word against expected. Derivation
table renders trace as a list of rule applications, showing
before/after side by side, with non-firing rules visible but greyed.


## Notes on what's NOT in this representation

- **No regex NFA.** The matcher is a straight sequence walker with
  one greedy `*` quantifier. Doesn't need backtracking for the
  rule set we have (only ~5 rules use `*`, none ambiguously).
- **No syllable tree, no autosegmental tiers.** Words are flat.
- **No symbolic feature lookup.** Class membership is set
  containment; pairing is index lookup.
- **No optional matching primitive on the LHS.** Rules with
  optional elements are duplicated by the host language.
- **No rule names or cross-references.** Each rule stands alone;
  the host language groups them into blocks.

The whole engine is roughly:
  Alphabet + Class table + Rule list → Word in → Trace out.

A first prototype is maybe 500 lines of TypeScript. The parser
(source text → these data structures) is comparable in size; could
be hand-written or use a small PEG-style helper.
