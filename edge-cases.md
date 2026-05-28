# Edge cases from the existing rule corpus

A survey of rules from `griechisch.scm`, `arisch.scm`,
`germanisch.scm`, and friends that exercise unusual or
boundary-condition features of the new language. Each entry has
the original Scheme rule, a translation to the new notation, and
an annotation about what makes it interesting. Together these
form a test suite for the parser and engine.


## A. Negated character class

The Scheme code uses `[^...]` in a few places, which is regex
"any segment EXCEPT these." Our spec does not have negation.

### A.1 ti → si (Rix §101)

```scheme
`(sub (sogr) (,(s "([^sk])ti" 1 "si")))
```

"ti becomes si, but only if not preceded by s or k."

In the new system: the LHS context is "any segment except s or k."
We'd define this by enumeration — every segment of `C` minus those:

```
class C.notSK = [ C.T C.D C.Tasp C.Dasp <r l m n y w z> H ]
# (i.e. C without s, without k or k!)

C.notSK "t" "i"  →  _ "s" _
```

**Notes:**
- The negated class becomes an explicit positive enumeration.
  This is verbose but transparent — the reader sees exactly what's
  in scope.
- Needs a class-difference primitive if it keeps coming up
  (`class X = C \ <s k>`), but it doesn't come up much.

### A.2 ^(<vok>)(['~]?)h(<vok>)([^'~])

```scheme
(s "^(<vok>)(['~]?)h(<vok>)([^'~])" "h" 1 2 3 4)
```

"At word start: vowel + (optional accent) + h + vowel + a segment
that is NOT accent-marked."

With markers as bit-fields, the `[^'~]` collapses entirely. It
was checking "the next character isn't a stress mark." But in our
model, accents aren't characters — they're marker bits on a
segment. So this rule has no `[^'~]` analog: we just don't
constrain the marker bits, which is the default.

```
$ V V' h V  ?? 
```

Hmm, this one is actually tricky linguistically — let me skip the
full translation and just note it. The original is hauchumsprung
(aspiration jump) at word start. The constraint was "the second
vowel itself doesn't carry an accent right after." In our system
the accent isn't a separate token; the `V` after the `h` either
has the bit set or it doesn't. To say "doesn't have it set," we
need an explicit unmarked match:

```
$ V V h V,  →  +"h" _ _ . _
```

`V,` matches a vowel with all marker bits clear — equivalent to
the old `[^'~]` constraint. **This is exactly what `,` is for.**


## B. Dot ("any segment")

### B.1 (.)tw  (Rix §104)

```scheme
(s "(.)tw" 1 "tš")
```

"Any segment + tw → segment + tš (and drop the w)."

This is "any one segment" as context. We don't have `.` in the
spec, but we have a fully general "any segment" class — `C ∪ V`,
typically named something like `Any`:

```
class Any = [ C V ]

Any "t" "w"  →  _ "t" "š"
```

The pattern is used to *anchor* a non-word-initial position: the
rule says "tw becomes tš, except at word start" (because word
start would be matched by `$` instead). In the new spec we'd
write this more directly:

```
Any "t" "w"  →  _ "t" "š"
```

— and rely on the rule simply not matching word-initial `tw`
because there's no preceding segment.

**Trade-off:** `Any` is a class declared in the alphabet. The
alternative is some kind of universal pattern that always matches
any one segment. I'd avoid the latter — make the user declare
`Any` if they want it. Keeps the language uniform.

### B.2 (.)h  ("any segment, then h")

```scheme
(s "(.)h" 1)
```

"Any segment + h → just the segment (delete the h)." Same pattern
as above; same translation.

```
Any "h"  →  _ .
```


## C. Optional accent that we're dropping

A huge fraction of the old rules thread the accent through with
`('?)` or `(['~]?)`. With markers riding along, all of these
collapse:

### C.1 Old style:

```scheme
(s "a('?)i̯" "αι" 1)
```

becomes

```
"a" "i̯"  →  "αι"
```

— marker on the `a` rides along to the `αι` automatically. The
output position is paired class-wise with input position 1.

But wait — `αι` is a different segment from `a`. If markers ride
along through pairing, the question is whether `a → "αι"` (literal
output) preserves the marker. Per the spec, literal outputs carry
the markers encoded in the glyph itself, NOT the markers from a
paired LHS. So an accented input `á` would produce unaccented `αι`
— losing the accent.

That's wrong for the original intent. So either:
- (i) Promote the literal to a class pairing: declare `class
  V.toGrk = [ ... ]` with the Greek-script outputs, then `V →
  V.toGrk`.
- (ii) Have a special "preserve markers" form for literal outputs:
  `"αι"_` or similar — meaning "literal αι with markers carried
  from the corresponding LHS position." Adds a syntax.

I'd go with (i): in the new system, the to-Greek-script conversion
is a class pairing, not a literal rewrite. This actually catches
the case where the old code lost track of accent through literal
substitutions.

### C.2 Old style with marker check:

```scheme
(s "(<vok>)('?)(w|y)" 1 2 (consonans->sonans 3))
```

Original: vowel + optional accent + (w or y) → vowel + accent +
(sonant version of the matched glide). The accent is preserved
verbatim.

```
class Glide       = < y  w  >
class Glide.syl   = < i  u  >

V Glide  →  _ Glide.syl
```

Marker rides from the V automatically. Three lines of bookkeeping
collapse to one rule.


## D. The metathesis case

### D.1 tk, tkw, tp

```scheme
(s "(t)(k|K|p)" 2 1)
```

"t + (k or K or p) → swap them."

Two LHS positions, two RHS positions, but the *order* swaps:

```
"t" [<k K p>]  →  _/2 _/1
```

Using explicit `/N` references on the RHS to swap. Both are
consuming (no `+`), so the counter advances normally but each
output explicitly says which LHS position to take.

This is a **good test case for `/N` on `_`.** It also stresses
the counter semantics: after `_/2` consumes (and advances counter
to 2), the next output is `_/1`, which still consumes (counter
advances to 3 = end). The /N reference is independent of which
LHS position is consumed at each step? Or does consuming follow
the /N?

**Spec needs clarifying.** I think `_/N` should copy LHS position
N but still consume the *next* position in counter order. That
keeps the counter as a separate concept from the /N reference.

Going to flag this for spec clarification.


## E. Inserted geminate from a class lookup

### E.1 Palatalization

```scheme
(s "(d|g)y" "ǰǰ")
(s "(k!|k)y" "čč")
```

"d or g + y → ǰǰ (double palatal)" and similar for tenuis.

Two LHS positions, RHS is a literal that uses TWO output
positions (the doubled segment):

```
<d g> "y"  →  "ǰ" "ǰ"
<k! k> "y"  →  "č" "č"
```

(Or using class column pairing if you want one rule for both
tenuis and media... but the literal-doubling form is simpler.)

**This is a good test:** RHS has 2 positions, LHS has 2 positions,
counter advances normally; both outputs are literal segments.
Sanity check that "the RHS doesn't need to consume what it
produces" — both outputs are independent of the matched glyphs.

But there's a subtle question: does the LHS `y` get consumed
(deleted) by the rule? Yes — every LHS position is consumed once.
The RHS doesn't reference position 2 (the `y`), but the position
is still consumed; its segment is just not emitted.


## F. Repeated reference on RHS

### F.1 hR-Dehnung with copied vowel

```scheme
(s "(<vok>)(['~]?)(<res>|w)h(<vok>)" 1 2 3 3 4)
```

The captured `(<res>|w)` appears TWICE on the RHS at positions 3
and 4. This is gemination by copying.

```
class ResW = [ <r l m n> <y w> ]

V ResW "h" V  →  _ _/2 _ _
```

Hmm wait — let me recount. LHS: V, ResW, "h", V (four positions).
RHS in old code: 1 2 3 3 4. Position 3 (the res-or-w) appears
twice. So:

```
V ResW "h" V  →  _ _ _/2 _
```

- Position 1: `_` = copy V (counter advances 1→2)
- Position 2: `_` = copy ResW (counter advances 2→3)
- Position 3: `_/2` = copy whatever was at LHS pos 2 again
  (counter advances 3→4)
- Position 4: `_` = copy final V

Wait, but the old rule omits the `h` — it does `1 2 3 3 4` without
the h. In our model, the LHS has 4 positions and the RHS must
consume all 4. So one of the positions must be the `h`
deletion. Reading the original output: `1 2 3 3 4`. That's the
vowel, the resonant, the resonant again, the final vowel. The h
is dropped. So the actual mapping is:

```
V ResW "h" V  →  _ _ _/2 _
```

But this has 4 RHS positions for 4 LHS positions, and the third
RHS output is `_/2` (a reference to LHS position 2, which was
already consumed at RHS position 2). Wait, that doesn't work
either — the counter walks 1→2→3→4, so at RHS position 3 the
counter is at 3 (the h), but `_/2` says "ignore counter, copy LHS
position 2." Does the consuming advance the counter or does it
skip?

**This needs to be clarified in the spec.** My proposed rule:
`_/N` is consuming (advances counter) and copies from N. So the
counter walks 1→2→3→4 with the h being consumed (at counter=3)
but produced as a copy of LHS position 2. Then RHS position 4
copies LHS position 4.

Net: vowel, resonant, COPY-of-resonant (replacing the h slot
visually), vowel.

That works. Let me try writing it with `+` for insertion to see
which reads better:

```
V ResW "h" V  →  _ _ +_/2 . _
```

- Position 1: `_` (V copy, counter 1→2)
- Position 2: `_` (ResW copy, counter 2→3)
- Position 3: `+_/2` (insert copy of pos 2, counter STAYS at 3)
- Position 4: `.` (delete the h, counter 3→4)
- Position 5: `_` (V copy, counter 4→5)

5 RHS positions, 4 LHS positions. Total consuming outputs: 4
(positions 1, 2, 4, 5). Matches LHS length. Inserts 1 segment.

**Either form works**; the second is more explicit about what's
inserted vs. consumed. I'd recommend the `+` form for clarity.


## G. Inserted vowel before/after based on context (the §83e case)

Already handled in the spec (the inserted-twice H.v). Restated
here as a test case:

```scheme
(s "(<s-res>)'(<lary>)(<kons>)"
   (laryngal->vokal 2) "'" (sonans->consonans 1) (laryngal->vokal 2) 3)
```

→

```
R.s' H C  →  +H.v/2,'  R.c,  H.v/2  _
```


## H. Word-final cluster cleanup

### H.1 Auslautvereinfachung

```scheme
(s "(<okklu>)+$")
```

"One or more stops at word end → delete all of them."

```
C.stop+  $  →  .
```

But our spec doesn't have `+`. Per the convention "write the
required occurrence explicitly, then `*`":

```
C.stop  C.stop*  $  →  . .
```

Wait — the `Class*` is uncapturable and may only have `_` on the
RHS. But here we want to delete the matched run entirely.

**This is a spec gap.** Either:
- Allow `.` at a `*` position (deletes the entire run).
- Or expand into separate rules for each possible run length.

I'd allow `.` at `*` positions. It's the only "transformation" of
a star span that doesn't introduce semantic questions (deletion
of a sequence is just deletion). Quick spec amendment.


### H.2 ^(<kons>)*@

```scheme
(s "^(<kons>)*@" 1 "i")
```

"Word start + any consonants + @ → keep the consonants + i."

```
$ C* "@"  →  _ "i"
```

`_` over a `C*` span = pass through the run unchanged. Then `@`
is consumed (deleted from RHS) and replaced with `"i"`. But the
RHS has 2 positions for 3 LHS positions — wait, `$` is a boundary,
not a position. So LHS is `C*`, `"@"` — 2 positions. RHS is `_`,
`"i"` — 2 outputs.

Actually `$` *is* a position in our spec (zero-width). It's an
LHS position. Let me check... yes, in §4.1 it's listed as one of
the pattern forms. So LHS: `$`, `C*`, `"@"` — 3 positions. RHS:
... we'd need 3 outputs but `$` shouldn't appear on RHS.

This is a tension. Either:
- `$` doesn't count as a position for the counter.
- Or RHS has an implicit zero-width "pass-through" for boundary
  positions.

I'd prefer the first: `$` is a zero-width *anchor*, not a position.
The counter walks only over non-boundary patterns.

So LHS positions are: `C*` (pos 1), `"@"` (pos 2). RHS:
`_` (consume pos 1), `"i"` (consume pos 2). Two positions each.

**This needs a spec clarification too.**


## I. Marker constraint on output

### I.1 The 1. Ersatzdehnung with marker forced

```scheme
(s "(<vok>)(['~]?)ln(<vok>)" (dehnung2 1) 2 "l" 3)
```

Vowel + (optional marker) + ln + vowel → long-vowel + marker + l +
vowel. The marker, if present, rides along to the long vowel.

```
V "l" "n" V  →  V.l . _ _
```

Counter: 1, 2, 3, 4. `V.l` pairs with V (markers ride along by
default). `.` deletes `l`. Wait, the old rule keeps the l and
deletes the n, not vice versa.

Let me re-read: `(dehnung2 1) 2 "l" 3 4`. Wait the old has 4
positions output, but LHS has 4 capture groups too. So: lengthen
1, keep 2 (marker), keep `l` (literal "l"), final vowel = 4. So
the original rule's LHS is: V, marker, ln (as two chars), V — 5
positions of regex but 4 capture groups. The output `(dehnung2 1)
2 "l" 3` has 4 elements: lengthened V, marker, literal l (which
replaces the original ln), V.

In our model:
```
V "l" "n" V  →  V.l _ . _
```

LHS 4 positions. RHS: V.l (paired with V, markers ride along),
"l" copied... wait, `_` would copy "l" but the original keeps "l"
unchanged anyway. Then `.` deletes "n". Then `_` copies V.

Net: long V (with markers from input V), l unchanged, n deleted,
V unchanged. That matches the original.


## J. Aspiration spread (Grimm continuation)

### J.1 Old: spirantization with optional res-yw

```scheme
(s "(<vok>)(<res-yw>)?f(<vok>|<res-yw>|$)" 1 2 "ƀ" 3)
```

Vowel + optional ResYW + f + (vowel or ResYW or word-end) →
voiced fricative.

```
class ResYW = [ <r l m n y w> ]
class V_or_RW_or_end = [ V ResYW ]   # plus $ via separate rule

V ResYW? "f" V         →  _ _ "ƀ" _
V ResYW? "f" ResYW     →  _ _ "ƀ" _
V ResYW? "f" $         →  _ _ "ƀ"
```

Three rules to cover the disjunction in the original final
context — because alternation with `$` doesn't compose nicely
(boundary vs. segment). All three use the optional-class `?` for
the ResYW.

**Test case for `?` on classes**: especially the case where the
`?` doesn't match.


## K. Rule chains with markers in classes

### K.1 Aryan retroflexion

```scheme
(s "(ṣ|ẓ)(<dental>)" 1 (dental->retroflex 2))
```

Retroflex-sibilant + dental → retroflex-sibilant + retroflex-stop.

```
class C.den2  = < t  d  t!  d! >
class C.retro2= < ṭ  ḍ  ṭ!  ḍ! >

[<ṣ ẓ>] C.den2  →  _ C.retro2
```

The dental→retroflex transformation is just a paired-class
output. Position 2 on RHS pairs with LHS position 2; matched
member index maps through to `C.retro2`.

**Test case for in-place class pairing across two parallel
column-aligned classes.**


## L. Cross-class union with literal — Bartholomae extended

```scheme
(s "(<mediaasp>)(s|z)?(<tenuis>|<media>)(!?)" ...)
```

Voiced-aspirate + optional sibilant + (tenuis or media) +
optional aspiration marker → ...

The `(!?)` at the end captures whether the *target stop* was
already aspirated. We've moved aspiration into the segment itself
(`p!` is one segment), so this optional aspiration matcher
disappears — it's just whether the matched stop is in `C.Tasp`
or `C.T`.

```
C.Dasp C.sibil? [C.T C.D C.Dasp]  →  C.D ?  [C.Dasp C.Dasp C.Dasp]
```

But what does RHS position 2 produce when LHS position 2 (the `?`)
didn't match? The spec says "produces nothing." So a missing-`?`
followed by a class on the RHS at that position: produces nothing
(the class is paired against an empty match — empty output).

When the LHS sibilant *did* match, RHS position 2 should produce
... the voiced sibilant of the matched one. We need a class
pairing here. The original output is "z!" (a literal). Let me
re-examine.

Old: optional sibilant on LHS, if present voices it. Output
position 2 from old: `(stimmhaft 2)`. So `s → z`, `z → z`.

```
class Sibil      = < s z >
class Sibil.vd   = < z z >

C.Dasp Sibil? [C.T C.D C.Dasp]  →  C.D Sibil.vd [C.Dasp C.Dasp C.Dasp]
```

When the `?` didn't match: RHS position 2 (Sibil.vd) outputs
nothing. When it did match: outputs the voiced counterpart.

**Test case for `?` interacting with paired class output.**


---

## Summary: gaps and clarifications needed in the spec

1. **`Class*` with `.` on RHS** — should be allowed (deletes the
   entire matched run). One-line spec amendment.

2. **`$` boundary and the position counter** — boundaries don't
   count as positions for the counter; they are zero-width
   anchors. The counter only walks non-boundary patterns.

3. **`_/N` and counter advancement** — `_/N` consumes (advances
   counter to the next slot) but copies from LHS position N. The
   /N reference is independent of which LHS position is consumed.
   So `_/N _/M` on the RHS consumes LHS positions 1 and 2 in
   order, copying from N and M respectively.

4. **Literal outputs and markers** — `"glyph"` produces a segment
   with markers as encoded in the glyph string. It does NOT pair
   with the LHS. If you want literal-with-marker-from-LHS, use a
   class pairing instead.

5. **Pattern `?` and paired class outputs** — when `?` doesn't
   match, the corresponding RHS position produces nothing
   (whether `_`, paired class, or `.`).

6. **A universal `Any` class** — not a special pattern, just a
   class the user can declare. Spec doesn't need changes.

7. **`[^...]` negated classes** — no engine support; user
   declares the positive complement.

8. **Marker `,` on LHS to match unmarked segments** — already in
   spec, useful for replacing the old `[^'~]` constraint.


## Translating these as test cases

These rules form a natural test suite for the parser and engine.
Each one exercises a specific feature. A test runner that loads
the rules, applies them to representative inputs, and checks
outputs would catch regressions across the whole feature surface.
