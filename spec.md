# lga rule language — draft specification

This document describes the rule language for a sound-change
simulator. It is the inner core; an outer script layer (blocks,
conditionals, language tree, file inclusion) is provided by the
host language (TypeScript/JavaScript in the current implementation)
and is not described here.

The design is segment-based and class-driven. Sound classes are
declared as enumerated sets of segments; rules are positional
sequence rewrites. There is no feature system — natural classes
arise from how the author groups segments, not from a fixed
theoretical inventory.

---

## 1. Primitive elements

### 1.1 Segment

A **segment** is the atomic phonological unit. It has identity but
no internal structure: two segments are either the same segment or
they are not. There are no features, no diacritics, no internal
decomposition.

Each segment has a **name** — a non-whitespace identifier — which is
how the segment is written in rule text. Names may contain Unicode
letters, digits, and any printable symbol that is not reserved by
the language (see §6 for reserved characters).

Examples of valid segment names: `p`, `t`, `k`, `kʷ`, `H1`, `H₂`,
`p!`, `ā`, `ǰ`, `ṣ`, `þ`.

Each segment also has a **glyph** — the string of one or more
characters used to spell it in input text. By default, glyph equals
name; the alphabet declaration (§2) can override this.

### 1.2 Word

A **word** is a finite ordered sequence of segments, plus two
implicit boundary markers (one at each end). Each segment may
carry a bit-field of suprasegmental **markers** (§1.3). There is
no further structure: no syllables, no morpheme boundaries, no
parallel tone tier.

### 1.3 Markers (suprasegmental bits)

Each segment carries a small bit-field of **markers**. Markers
represent suprasegmental features that ride along with the
segment (stress, accent type, etc.) without affecting segment
identity: `a` and `á` are the same segment with different
marker bits.

The marker set is declared in the alphabet (§2). Each marker has
a name (a single non-alphanumeric character) and corresponds to
one bit. The two markers used in practice for Indo-European are:

| char | bit | linguistic meaning             |
| ---- | --- | ------------------------------ |
| `'`  | 0   | acute / stress                 |
| `~`  | 1   | circumflex (Greek)             |

Marker characters are reserved (see §6). Up to 8 markers may be
declared; this is a soft limit corresponding to a single byte.

When parsing input text, marker characters immediately following
a segment glyph apply to that segment. The special character `,`
**clears all marker bits**. `,` is not a marker itself; it is a
clear-all command, usable both in input text (to write an
explicitly-unmarked segment) and on the RHS of rules (to strip
markers from an output).

#### Marker matching on the LHS

A pattern may be followed by zero or more marker characters to
constrain the match. The constraint is interpreted as a **mask**:
the bits named in the pattern form a mask M; the segment matches
iff `(segment.markers AND M) != 0`. A pattern with no marker
characters places no constraint.

| pattern | matches                                                    |
| ------- | ---------------------------------------------------------- |
| `V`     | any vowel, marker-agnostic                                 |
| `V'`    | any vowel with the `'` bit set                             |
| `V~`    | any vowel with the `~` bit set                             |
| `V'~`   | any vowel with the `'` *or* `~` bit set (mask AND ≠ 0)     |
| `V,`    | any vowel with all marker bits clear (zero markers)        |

Note: `V'~` is the "any marked vowel" pattern, not the
"both-set" pattern. The bitmask is OR-shaped on the match side.

#### Marker behavior on the RHS

On the RHS, markers ride along by default through any pairing or
copy. Explicit marker characters override:

| RHS form | marker effect                                                  |
| -------- | -------------------------------------------------------------- |
| `_`      | copy segment + markers from current counter LHS                |
| `_/N`    | copy segment + markers from LHS position N                     |
| `Name`   | pair segment; markers ride along from paired LHS position      |
| `Name/N` | pair against N; markers ride along from N                      |
| `Name'`  | pair segment; *force* `'` bit set, other bits ride along       |
| `Name,`  | pair segment; *clear* all marker bits                          |
| `Name,'` | pair segment; clear all bits then set `'` (= explicit `'` only)|
| `+_/N`   | insert copy of N (segment + markers)                           |
| `+_,/N`  | insert copy of N's segment, markers cleared                    |
| `+_,'/N` | insert copy of N's segment, only `'` set                       |

The pattern `,` before other marker characters strips first,
then the named bits are set. This makes `Name,'` the canonical
way to write "explicitly stressed, nothing else."

Literal-glyph outputs (`"glyph"`, `+"glyph"`) carry the markers
encoded in the glyph string itself, parsed the same way as input
text. So `+"á"` is `+"a'"` — both produce an a-segment with the
`'` bit set.


### 1.4 Class

A **class** is a named ordered sequence of class members. A class
member is either:

- a **segment**, or
- a **class** (named or anonymous).

Classes serve two purposes:

- **As a set, in context positions.** When a rule mentions a class
  on the LHS in a non-target position, the class behaves as the set
  of all segments transitively reachable from it. The order of
  members is irrelevant for this use.
- **As an ordered sequence, in target/replacement positions.** When
  a rule names a class on the LHS in a target position and pairs it
  with a class on the RHS, members are zipped positionally — the
  i-th member of the LHS class maps to the i-th member of the RHS
  class. The order of members carries the mapping.

A class used both as set-of-segments and as positional-source must
satisfy both views; this is the author's responsibility.

There are no operations on classes other than enumeration and use.
Union is expressed by inclusion: a class whose members are other
classes acts as the union of those classes' segments.

---

## 2. Alphabet declaration

The **alphabet** is the set of segments recognized in the input
language. Anything not in the alphabet is a lexing error.

Syntax:

```
alphabet:
  <segment-list>
```

Each entry on the segment list is one of:

- A bare name. The segment's name is the bare name; its glyph
  equals the name.
- A name with explicit glyph: `name = "glyph"`. Used when the input
  text uses a different spelling than the rule text wants. (For
  example, declaring `H1 = "h₁"` would let input be written with
  the Unicode subscript while rules use the ASCII form.)

The segment list is whitespace-separated. Line breaks are
whitespace. Comments begin with `#` and run to end of line.

When lexing input text into a segment sequence, longer glyphs win:
if both `H` and `H1` are declared, the input string `H1...` is
parsed as the `H1` segment, not as `H` followed by `1`.

The alphabet block may also declare **markers** (§1.3): one
single non-alphanumeric character per bit, declared in order
from bit 0 upward.

Example:

```
alphabet:
  markers: ' ~                  # bit 0: acute, bit 1: circumflex

  # stops
  p   t   k          # tenuis
  b   d   g          # media
  p!  t!  k!         # tenuis aspirata (each is ONE segment)
  b!  d!  g!         # media aspirata
  # vowels
  a   e   i   o   u
  ā   ē   ī   ō   ū
  # laryngeals (with explicit glyphs)
  H1 = "h₁"
  H2 = "h₂"
  H3 = "h₃"
```

---

## 3. Class declaration

Syntax:

```
class <name> = <body>
```

The name is any identifier; the convention is that dotted names
(`C.T`, `C.pal`) group related classes for readability, but the dot
has no semantic meaning — names are opaque identifiers.

The body is one of two forms:

- **Grapheme sequence**: `< g1 g2 g3 ... >`. Each `gi` is a segment
  name. This is the most common form for classes whose members are
  individual segments.
- **Class composition**: `[ M1 M2 M3 ... ]`. Each `Mi` is either a
  class name or a grapheme sequence `<...>`. The members of the
  composed class are the concatenated members of the parts, in
  order.

Examples:

```
class C.T     = < p   t   k  >
class C.D     = < b   d   g  >
class C.Tasp  = < p!  t!  k! >
class C.Dasp  = < b!  d!  g! >

class C.lab   = < p   b   p!  b! >    # column across rows

class V       = [ V.s V.l ]           # union of two named classes
class C       = [ C.T C.D C.Tasp C.Dasp  <r l m n y w s z>  H ]
```

The `[...]` form never contains bare segment names; segment names
inside a composed class must be wrapped in a `<...>` group. This
keeps the distinction between class-composition and grapheme-
listing visually unambiguous.

There is no built-in negation (`[^...]`) or set-difference
operator. Because the alphabet is closed and known at load time,
the "everything except X" class can always be written as an
explicit enumeration of the complement. A future extension might
add `class X = A \ B` syntax as sugar; the engine support is
trivial (compute the difference of two segment sets at load time),
but it is not yet in the spec because the use cases are rare.

---

## 4. Rules

A **rule** is a sequence rewrite. Each rule has a left-hand side
(LHS) and a right-hand side (RHS), separated by `→`.

### 4.1 LHS

The LHS is a whitespace-separated sequence of **patterns**. Each
pattern occupies one position, except for `$` which is a zero-
width anchor (see below). Pattern forms:

| form                | meaning                                                                         |
| ------------------- | ------------------------------------------------------------------------------- |
| `"glyph"`           | matches exactly that segment                                                    |
| `<g1 g2 g3>`        | matches any one of the listed segments                                          |
| `Name`              | named class — matches any segment in that class                                 |
| `[M1 M2 ...]`       | composed class — matches any segment in any constituent                         |
| `$`                 | word boundary (start or end); zero-width anchor; not a position (see §4.1b)     |
| `Name?`             | optional: matches zero or one segment in the class (see §4.1a)                  |
| `Name*`             | star: matches zero or more segments in the class, uncapturable (see §4.1a)      |

Quantifiers (`?` and `*`) only attach to class patterns (named or
anonymous). Single literals and boundaries cannot be quantified.
The `+` quantifier does not exist; write `Name Name*` if you need
at-least-one.

A match of the LHS binds, for each position, the actual segment(s)
that matched there. Matching is leftmost; once a rule has fired at
a position, scanning continues after the matched span (no
overlapping matches within a single rule application).

### 4.1a Quantifier semantics

**`Name?` — optional, captured.**

Matches zero or one segment in the class. The position is still a
single LHS position. On the RHS:
- If the `?` matched a segment, normal pairing applies (`_` copies
  it, `Class` pairs against it, etc.).
- If the `?` matched nothing, the position is "empty": `_` and
  paired class outputs produce nothing. A literal RHS output still
  produces its segment. A `.` is fine (deletes nothing).

The position counter advances past a `?` whether it matched or
not. This means subsequent implicit pairings stay in sync with the
LHS layout.

**`Name*` — star, uncapturable.**

Matches zero or more consecutive segments, each a member of the
class. The matched run is treated as a black box: the RHS may
refer to it only via:
- `_` at the same position — produces the entire matched run
  unchanged (markers ride along, segment by segment).
- `.` at the same position — deletes the entire matched run.

It is an error to use any other RHS form at a `*` position. In
particular:
- No `/N` reference to a `*` position.
- No paired class transformation of a `*` position.

This restriction is deliberate: capturing a variable-length run
and then referring to "its second element" or "its class image"
opens semantic questions (which element? what alignment?) that the
language avoids by construction. Deletion is the one
"transformation" that is unambiguous on a run.

The position counter advances past a `*` (counting it as one LHS
position regardless of run length).

Matching is greedy with bounded backtracking: the engine eats as
many class members as possible, then backs off one at a time until
the rest of the LHS matches. The pattern set in practice has at
most one `*` per rule that could plausibly backtrack, and the run
is always anchored on both sides by a literal or class pattern, so
matching is O(word length) per rule application.

### 4.1b Word boundary

`$` is a **zero-width anchor**, not a position. It matches the
start or end of the word and contributes nothing to the position
counter.

A boundary may appear at most once on each end of the LHS:
- At the start of the LHS: matches word-initial position only.
- At the end of the LHS: matches word-final position only.

`$` never appears on the RHS. The boundary is an implicit feature
of the word; rules do not produce or remove boundaries.

If a rule's LHS has `$` at the start, the engine attempts to match
it only at word-initial position (not every offset). Same for `$`
at the end. This is the cheap way to anchor without a separate
notation.

### 4.2 RHS

The RHS is a whitespace-separated sequence of **outputs**. Each
output produces zero or more segments and may reference LHS
positions by index.

LHS positions are numbered 1, 2, 3, ... in source order. A
**position counter** walks the LHS as the RHS is read:
- A **consuming** output (no `+` prefix) consumes the LHS
  position at the current counter and then advances the counter.
- An **inserted** output (`+` prefix) does not consume an LHS
  position and does not advance the counter.

When an output uses a class or `_` without an explicit `/N`, it
pairs against the LHS position at the current counter value.
When an explicit `/N` is given, it pairs against LHS position N
regardless of the counter (and, if consuming, still advances
the counter as usual).

| form              | meaning                                                                                                  |
| ----------------- | -------------------------------------------------------------------------------------------------------- |
| `_`               | copy the segment matched at the current counter position                                                 |
| `_/N`             | copy the segment matched at LHS position N                                                               |
| `.`               | produce nothing — delete the consumed LHS position                                                       |
| `"glyph"`         | produce that specific literal segment                                                                    |
| `Name` or `[...]` | paired class output, paired against the current counter position                                         |
| `Name/N`          | paired class output, paired against LHS position N (see §4.3)                                            |
| `+"glyph"`        | insert a literal segment; consumes no LHS position                                                       |
| `+Name/N`         | insert a paired class segment, paired against LHS position N                                             |
| `+_/N`            | insert a copy of LHS position N (used for reduplication etc.)                                            |

`$` never appears on the RHS — boundaries are not produced; they
are inherent properties of the word.

Bare `+Name` without `/N` is an error: an inserted class output
has no LHS position to pair against by default, so the source
must be given explicitly.

#### Literal outputs do not inherit LHS markers

A literal output (`"glyph"` or `+"glyph"`) produces exactly the
segment encoded in the glyph string — including whatever markers
the glyph itself spells. It does **not** inherit markers from any
LHS position. If you want a literal-shaped output that carries
the markers of a matched LHS segment, use a class pairing instead
(declare a one-member class whose member is the desired output
segment, and pair against the LHS position).

#### Optional `?` positions on the RHS

When an LHS position is `Name?` and that `?` did not match (zero
occurrences), the corresponding RHS position produces nothing:
- `_` produces nothing.
- A paired class output produces nothing.
- `.` is legal and is a no-op.
- A literal output (`"glyph"`) still produces its segment — the
  RHS literal is independent of whether the LHS optional matched.

The position counter still advances past a `?` regardless of
whether it matched, so subsequent implicit pairings stay aligned
with LHS layout.

#### Example: insertion does not advance the counter

Greek §83e (accented syllabic R + H + C):

```
R.s  H  C  →  +H.v/2  R.c  H.v/2  _
   1   2  3
```

- `+H.v/2`: insertion, paired with LHS position 2 (the H).
  Counter stays at 1.
- `R.c`: consuming, implicit pair with counter = 1 (the R.s).
  Advances counter to 2.
- `H.v/2`: consuming, explicit /2 (still the H). Advances to 3.
- `_`: consuming, implicit pair with counter = 3 (the C).
  Advances to 4 (end).

All three LHS positions are consumed exactly once. The insertion
adds a new segment without disturbing the counter.

### 4.3 Pairing semantics

When the LHS at position *i* is a class (named, composed, or
anonymous via `<...>`) and the RHS at position *i* is also a class,
the two are **positionally paired**: the segment in the RHS class
at the same index as the matched LHS member is produced.

This is the central mechanism. Examples:

```
# Greek centum — one rule replacing four:
class C.pal = < č ǰ č! ǰ! >
class C.vel = < k g k! g! >
C.pal → C.vel
# matched č → produced k
# matched ǰ → produced g
# matched č! → produced k!
# matched ǰ! → produced g!
```

Pairing also works for composed classes when each constituent is
aligned to a constituent on the other side. Example (Bartholomae's
Law, voiced aspirate + any stop → media + voiced aspirate):

```
class C.T = < p t č k K >
class C.D = < b d ǰ g G >
class C.Dasp = < b! d! ǰ! g! G! >

C.Dasp [C.T C.D C.Dasp] → C.D [C.Dasp C.Dasp C.Dasp]
```

Here the LHS composed class `[C.T C.D C.Dasp]` has 15 members
(5 + 5 + 5). The RHS composed class `[C.Dasp C.Dasp C.Dasp]` also
has 15 members. If position 2 matches a member of `C.T` at column
*c*, the RHS produces `C.Dasp[c]`. The same column logic applies
for matches in `C.D` and `C.Dasp`. The author's responsibility is
ensuring that all classes participating in such a union are
column-aligned in the same order.

### 4.4 LHS / RHS shape

By the end of the RHS, the position counter must equal the number
of LHS positions: every LHS position is consumed exactly once.
The engine rejects rules where this invariant doesn't hold (e.g.
an RHS that consumes 2 outputs for a 3-position LHS, or vice
versa). This catches off-by-one mistakes at load time.

Extra outputs beyond the LHS length are only legal via the `+`
prefix (insertion). Fewer consuming outputs than LHS positions
are only legal if the missing positions are explicit `.`s.

In practice this means: count consuming outputs (no `+`) on the
RHS — that count must equal the LHS length.

### 4.5 Examples

Strip rule (one position to one position):

```
"z" → "s"          # z becomes s
```

Class to class:

```
C.Dasp → C.Tasp    # voiced aspirates become voiceless aspirates
```

Multi-position with context:

```
[<k K>] "þ" → _ "t"     # dorsal preserved, thorn becomes dental
```

Insertion at word boundary:

```
$ "y" → +"d" _          # word-initial y is strengthened to dy
```

Deletion conditioned by following segment:

```
H R.syl → H.v R.cons    # H before syllabic R: H vocalizes, R desyllabifies
```

Final-position deletion:

```
H → .                   # delete any laryngeal
```

---

## 5. Rule sets and application

A rule set is an ordered list of rules. When applied to a word,
each rule is scanned left-to-right and applied at every non-
overlapping match before moving on to the next rule. Source order
is application order. Rules do not re-fire on their own output
within a single rule application; the next rule sees the result.

Engine produces a **derivation trace** — for each rule, the word
before, the word after, and whether the rule matched anything.
This trace is the engine's primary output; the final form is just
the `after` field of the last entry.

---

## 5.5 Style note: positional alignment depends on declared structure

A union-positional rule like
`[C.T C.D C.Dasp] → [C.Dasp C.Dasp C.Dasp]` reads naturally as a
3-way class correspondence with one shared dimension (here: place)
preserved by the pairing. The expansion into 15 element-wise
mappings is an implementation detail; the rule is "voiced
aspirate + any stop → media + voiced aspirate, place preserved."

The compactness is genuine, not a trick. What makes it safe is
that the constituent classes (`C.T`, `C.D`, `C.Dasp`) really do
share that shared dimension in their member order. If a future
edit reorders one class without the others, the rule silently
miscomputes.

The grid assertion (§7) is the structural guarantee that makes
this safe: it tells the engine to refuse to load if the alignment
drifts. With the assertion in place, positional pairing is just
as trustworthy as enumeration, and substantially more compact.

A useful convention: when a rule relies on alignment along some
named dimension, mention it in a comment.

```
# Bartholomae: place preserved across the voicing transfer
C.Dasp [C.T C.D C.Dasp] → C.D [C.Dasp C.Dasp C.Dasp]
```


## 6. Reserved characters

The following characters are reserved by the rule language and may
not appear in segment names without escaping (mechanism TBD):

```
" < > [ ] = → $ . _ + / , # whitespace
```

Additionally, any character declared as a marker in the alphabet
becomes reserved for use as a marker following a segment name.
Marker characters are conventionally taken from `' ~ ` etc.

Note: `→` may also be spelled `->` in source if preferred (the
parser accepts both).

---

## 7. Assertions

The author can declare structural invariants the engine checks at
load time. Failure is a load-time error, not a runtime surprise.

### 7.1 Alphabet invariants

The alphabet declaration may be followed by assertions about its
contents. These exist to catch typos and accidentally-undeclared
segments before any rule fires.

```
assert no-duplicates                  # no segment declared twice
assert no-overlap                     # no segment's glyph is a prefix
                                      # of another (catches lexing
                                      # ambiguity even before
                                      # longest-match resolves it)
```

### 7.2 Class invariants

```
assert size(C.T) == size(C.D) == size(C.Tasp) == size(C.Dasp)
assert columns(C.T, C.D, C.Tasp, C.Dasp)
```

The `columns` assertion declares that the listed classes are
column-aligned: each class must have the same length, and the
constituent classes used in column-style union targets (§4.3) must
respect this alignment.

Stronger form: cross-check that row-classes and column-classes are
consistent (e.g. that `C.T[i]` for column-index *i* equals
`C.lab[0]` when row 0 is tenuis and column 0 is labial). This is
what catches a reordering of `C.D` that wasn't mirrored in
`C.lab`/`C.den`/etc.

```
assert grid(rows={C.T C.D C.Tasp C.Dasp},
            cols={C.lab C.den C.pal C.vel C.labv})
```

This says: the listed rows and columns form a consistent grid.
Internally the engine checks that the (row, col) intersection
matches in both directions for every cell.

### 7.3 Inventory closure

```
assert covers(C, all-consonants)      # C as a class covers every
                                      # consonant in the alphabet
```

Where `all-consonants` (etc.) is a sub-inventory the author
declares. The point is to catch the case where a new segment is
added to the alphabet but forgotten in the catch-all `C` class —
suddenly a rule like `C H C → _ H.v _` silently doesn't match
contexts involving the new segment.

The mechanism for declaring sub-inventories is open; one
possibility is grouping the alphabet itself:

```
alphabet:
  consonants:
    p t k ...
  vowels:
    a e i o u ...
  ...
```

This is sugar — the segments are still flat — but it lets
assertions reference the groups.


## 8. What is intentionally not in this spec

The following are needed for a complete system but are deferred:

- **Syllable structure and tone tiers.** Markers (§1.3) cover
  segment-attached suprasegmentals like stress and accent type.
  Genuine parallel tiers (syllable boundaries, tone melodies)
  are not yet expressible.
- **Multi-position references on the RHS** (e.g. `Name/1+2` for a
  segment determined by two LHS positions, as in coalescence).
- **Rule names / labels** for cross-referencing.
- **Outer script layer**: rule blocks, conditional inclusion by
  target language, language pipelines, the language tree. These
  are provided by the host language wrapper around the engine.
- **Loan / contact mechanisms**: introducing forms at non-root
  pipeline stages.
