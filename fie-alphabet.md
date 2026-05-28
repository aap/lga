# FIE alphabet (canonical)

The exact segment inventory for Fantasy Indo-European, the source
language fed into lauttool's sound-law pipelines. This document is
the authoritative reference; the lauttool alphabet declaration is
written from it.

Each row is one segment. Multi-character glyphs (`kʷ`, `bʰ`, `h₁`,
`r̥`) are one segment each — the lexer matches longest first.


## Stops (15)

|             | labial | dental | palatovelar | velar | labiovelar |
| ----------- | ------ | ------ | ----------- | ----- | ---------- |
| voiceless   | p      | t      | k̑           | k     | kʷ         |
| voiced      | b      | d      | g̑           | g     | gʷ         |
| voiced asp. | bʰ     | dʰ     | g̑ʰ          | gʰ    | gʷʰ        |


## Laryngeals (3)

`h₁` `h₂` `h₃`

Coloring effect on adjacent `e`: h₁ no color (stays `e`), h₂
a-color (`e` → `a`), h₃ o-color (`e` → `o`). The coloring is a
sound-law effect, not a property of the segment — laryngeals are
just three distinct segments at this level.


## Sibilant (1)

`s`


## Resonants — non-syllabic (6)

`r` `l` `m` `n` `y` `w`


## Resonants — syllabic (6)

`r̥` `l̥` `m̥` `n̥` `i` `u`

The syllabic alternants of `y` and `w` are written as plain vowel
letters `i` and `u`. They alternate with `y`/`w` under
phonological rules.


## Vowels (4)

| short | long |
| ----- | ---- |
| e     | ē    |
| o     | ō    |

There is no `a` as a root vowel; `a` arises only from h₂-coloring
during the sound-law derivation. `i`/`u` arise only as the
syllabic alternants of `y`/`w`.


## Inventory total

**35 segments**: 15 stops + 3 laryngeals + 1 sibilant + 6 plain
resonants + 6 syllabic resonants + 4 vowels.


## Suprasegmental markers (1)

| char | bit | meaning            |
| ---- | --- | ------------------ |
| `'`  | 0   | acute / primary stress |

Only one marker at the FIE level. Circumflex (`~`) is a Greek
innovation and is not in the source-language inventory.

The acute attaches to the nucleus (vowel or syllabic resonant)
of the accented syllable. Example: `*bʰér-` has the accent on
the `e`; `*bʰŕ̥-` (zero grade) has it on the syllabic `r̥`.


## Lauttool alphabet declaration

```
alphabet:
  markers: '

  # stops
  p   t   k̑   k   kʷ
  b   d   g̑   g   gʷ
  bʰ  dʰ  g̑ʰ  gʰ  gʷʰ

  # laryngeals
  h₁  h₂  h₃

  # sibilant
  s

  # plain resonants
  r   l   m   n   y   w

  # syllabic resonants
  r̥   l̥   m̥   n̥   i   u

  # vowels
  e   o
  ē   ō
```
