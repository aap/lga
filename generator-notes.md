# Proto-form generator — design notes

> **Naming note:** "FIE" = Fantasy Indo-European. The generator
> emits FIE forms (PIE-shaped, but invented), which are then run
> through lauttool's sound-law pipelines as if they were real
> proto-forms.



A separate tool that emits plausible-PIE-shaped roots and morphological
derivatives, to be fed as input to lauttool. This is **complete
conlanging**: we are not trying to reconstruct attested PIE, we are
producing forms with the structural properties of PIE so the sound-
law pipeline has something realistic to chew on.

Output: a list of starred forms (`*XYZ-`) suitable as test input.
Either flat one-per-line or grouped by root (paradigm view).

Implementation language: TypeScript. Could be packaged as a library +
CLI + browser demo independently of the engine.


## 0. The FIE alphabet (canonical, locked)

This is the exact inventory the generator emits and lauttool will
parse. Written in scholarly notation. Each row is a separate segment;
multi-character glyphs (`kʷ`, `bʰ`, `h₁`, `r̥`) are one segment each.

### Stops (15 segments)

|             | labial | dental | palatovelar | velar | labiovelar |
| ----------- | ------ | ------ | ----------- | ----- | ---------- |
| voiceless   | p      | t      | k̑           | k     | kʷ         |
| voiced      | b      | d      | g̑           | g     | gʷ         |
| voiced asp. | bʰ     | dʰ     | g̑ʰ          | gʰ    | gʷʰ        |

### Laryngeals (3 segments)

| segment | name | coloring effect on adjacent e |
| ------- | ---- | ----------------------------- |
| h₁      | h-one | no color (stays e)            |
| h₂      | h-two | a-color (e → a)               |
| h₃      | h-three | o-color (e → o)             |

### Sibilant (1 segment)

`s`

### Resonants — non-syllabic (6 segments)

`r l m n y w`

### Resonants — syllabic (6 segments)

`r̥ l̥ m̥ n̥ i u`

Note: in zero grade, the syllabic counterpart of `y` is `i` and the
syllabic counterpart of `w` is `u`. These are written as plain
vowel letters, but they participate in alternations with `y`/`w`
under the phonological rules. The generator just emits whichever
form is appropriate for the grade.

### Vowels (4 segments)

| short | long |
| ----- | ---- |
| e     | ē    |
| o     | ō    |

Plus the syllabic resonants above when they fill the nucleus slot.

There is no `a` or `i` or `u` as a *root vowel*; the FIE root
template uses `e`/`o` only (plus zero grade producing syllabic
resonants). `a` arises only from h₂-coloring; `i`/`u` arise as
the syllabic alternants of `y`/`w` in zero grade. These three
*do* appear as actual segments in surface forms, but never as
the chosen root vowel.

### Total inventory

**35 segments**: 15 stops + 3 laryngeals + 1 sibilant + 6 plain
resonants + 6 syllabic resonants (including i/u) + 4 vowels.

### Suprasegmental markers

- `'` (acute): primary stress / accent. Bit 0.

Only one marker for FIE — the generator places the acute on
exactly one segment per (accented) form. No circumflex at the
proto-level; circumflex is a Greek innovation.

### Notation summary for the generator

The generator outputs segments as the glyphs above, with `'`
immediately following an accent-bearing vowel or syllabic
resonant (e.g. `*bʰér-`, `*pl̥h₂-mé-`).

The accent marker convention: on the *nucleus* (vowel or
syllabic resonant) of the accented syllable. So `*bʰér-` is
unambiguous; `*bʰŕ̥-` (accent on syllabic r) is also unambiguous
because the accent character follows the resonant.

For ASCII-only output, the generator can optionally use lga's
legacy stand-ins (`č̑` → `c\!`, `kʷ` → `K`, etc.), but the
default and primary format is scholarly notation.

### Mapping to lauttool input

This same set is what lauttool's alphabet declaration will list
when defining FIE as the source language:

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


## 1. Phoneme inventory (details and weighting)

The §0 inventory locks segment identity. This section covers how
the generator should *use* the inventory: relative weights and
generation-time refinements.

### `b` is rare

The plain voiced labial `b` is famously underrepresented in
attested PIE roots — many traditional reconstructions have
*none*. We treat it as available but heavily down-weighted (e.g.
1/20 the weight of other voiced stops). A `--no-b` switch lets the
user exclude it entirely.

### Stops by frequency

In the attested corpus, voiceless stops are most common, then
voiced aspirates, then plain voiced. Suggested weights:

| voicing      | weight |
| ------------ | ------ |
| voiceless    | 3      |
| voiced asp.  | 2      |
| voiced       | 1 (with b further reduced) |

### Place of articulation

Roughly even, with labial slightly less common (because of `b`),
labiovelar somewhat less common than other dorsals, palatovelar
slightly more common.

### Laryngeals

In real PIE, `h₂` is most frequent, `h₁` next, `h₃` rarest.
Suggested:

| laryngeal | weight |
| --------- | ------ |
| h₂        | 3      |
| h₁        | 2      |
| h₃        | 1      |


## 2. Root structure

The PIE root is a small phonotactic template. We model the most
common shapes:

### Template formalism

Let:
- `C` = any non-laryngeal consonant (stop, sibilant, or — for some
  positions — resonant)
- `R` = resonant (r l m n y w)
- `H` = laryngeal
- `T` = stop (not s, not R, not H)
- `V` = vowel slot (gets a grade — e, o, ē, ō, or zero)

The canonical templates, in decreasing frequency:

| template          | gloss                            | example       |
| ----------------- | -------------------------------- | ------------- |
| `C V C`           | minimal                          | `*sed-`       |
| `C V R`           | resonant-final                   | `*bʰer-`      |
| `R V C`           | resonant-initial                 | `*reǵ-`       |
| `C R V C`         | initial cluster                  | `*kleu-`      |
| `C V R C`         | medial resonant + final stop     | `*bʰergʰ-`    |
| `C R V R C`       | sonorant-rich                    | `*pleḱ-`      |
| `H V C`           | laryngeal-initial                | `*h₁es-`      |
| `C V H`           | laryngeal-final                  | `*peh₂-`      |
| `H V H`           | rare; laryngeal both sides       | `*h₂erh₃-`    |
| `C V R H`         | "set" roots (laryngeal-extended) | `*gʷelh₁-`    |

We add weights: `CVC` and `CVRC` are by far the most common.

### Slot fillers, refined

- **Initial C-slot** (the "anlaut" position): any stop, any laryngeal,
  `s`, or a resonant. Resonants are uncommon but possible.
- **Final C-slot**: any stop, any laryngeal, `s`. Resonants generally
  not (they go in the R-slot).
- **R-slots**: only the six resonants.
- **H-slots**: only laryngeals.


## 3. Phonotactic constraints

Real PIE roots obey statistical constraints that reduce the space
of "PIE-shaped" outputs significantly. The classic three (Meillet,
later formalized):

1. **No two plain voiced stops** in one root. `*beg-` is bad.
   (Famous and well-attested constraint; this is one of the main
   arguments for the glottalic theory.)

2. **No two voiced aspirates** in one root, EXCEPT initial+final
   `bʰ...dʰ`-shaped pairs which are sometimes attested but rare.
   Generator should treat this as "very rare," not "forbidden."

3. **No plain-voiced + voiced-aspirate** mix. `*bedʰ-` is bad.
   (The "voiced ... voiced-aspirate" constraint.)

Plus structural ones:

4. **No two laryngeals adjacent** in a root (without an intervening
   vowel or resonant).

5. **No same-place-of-articulation** in both stops. `*tet-` and
   `*ped-` are bad. (Obstruent dissimilation.)

6. **Initial s + stop allowed** (the famous `*sC-` cluster). `*sed-`
   is fine because s isn't a stop in the relevant sense; `*steh₂-`
   has the same shape.

Apply these as **filters**: generate a candidate, check constraints,
reject and retry if violated.


## 4. Ablaut

PIE has five ablaut grades, paired with the vowel slot:

| grade name      | vowel | example             |
| --------------- | ----- | ------------------- |
| full e-grade    | e     | `*sed-`             |
| full o-grade    | o     | `*sod-`             |
| zero grade      | ∅     | `*sd-`*             |
| lengthened e    | ē     | `*sēd-`             |
| lengthened o    | ō     | `*sōd-`             |

*Zero grade often makes adjacent resonants syllabic: `*bʰer-` →
`*bʰr̥-`. Also: zero-grade clusters that have no resonant nucleus
sometimes get an inserted schwa or are repaired by adjacent
laryngeal vocalization.

### Accent-ablaut coupling

This is the linguistically rich part. PIE prosody has a famous
correlation: the **accented syllable is in full grade; unaccented
syllables are in zero grade or o-grade**.

In paradigms with mobile accent (athematic stems), this produces
alternations like:

- nom. sg. `*pód-s` (accent on root, e-grade)
- gen. sg. `*ped-és` (accent on ending, root goes zero-grade in
  some classes)

For our purposes, we want to reproduce this **structural
correlation**, not necessarily the historical complexity:

- When we generate a paradigm cell, we decide which morph carries
  the accent.
- The accented morph gets a full grade (default e-grade).
- Unaccented morphs typically go zero-grade or o-grade.

This gives our generated paradigms the right ablaut alternations
without committing to specific Caland system / Narten-stem
analyses.


## 5. Derivational morphology

A small starter set of suffixes, each with its characteristic
ablaut/accent behavior. Enough to produce visibly different
"forms of the same root" for paradigm-view output.

### Verbal stem formants

| suffix       | name                | root grade | accent       | rough meaning           |
| ------------ | ------------------- | ---------- | ------------ | ----------------------- |
| `-e/o-`      | thematic present    | e or zero  | root or stem | imperfective            |
| `-ye/o-`    | yo-present          | zero       | stem         | iterative/causative     |
| `-ské/ó-`   | ské-present         | zero       | suffix       | inchoative              |
| `-né/n-`    | nasal infix         | zero       | varies       | active                  |
| `-eh₁-`     | stative             | zero       | suffix       | be-state                |
| `e- reduplication + `-o-` | perfect | o-grade    | root         | resultative state       |

### Nominal stem formants

| suffix       | name                | root grade  | accent        | rough meaning      |
| ------------ | ------------------- | ----------- | ------------- | ------------------ |
| `-o-`        | thematic noun       | e or o      | root or stem  | agent / object     |
| `-os` / -es- | s-stem neuter       | e           | root          | abstract           |
| `-tó-`       | to-verbal adj.      | zero        | suffix        | passive participle |
| `-nó-`       | no-verbal adj.      | zero        | suffix        | similar            |
| `-tér-`      | agent noun          | e           | suffix        | "doer of X"        |
| `-tro-`      | instrument noun     | e           | root          | "tool for X"       |
| `-mn̥`       | abstract neuter     | e or zero   | varies        | "act of X-ing"     |
| `-eh₂-`      | feminine / collect. | varies      | varies        | feminine           |

Each suffix is a record describing:
- the morphological glyph(s)
- the required root ablaut grade
- the accent placement (root, suffix, or "mobile" — picks one at gen
  time)

### Reduplication

The perfect uses initial-consonant reduplication with `e` infix:
`*bʰer- → *bʰé-bʰor-`. This is a regular operation: copy the
first consonant of the root, insert `e`, then the root in o-grade.

A few other reduplicated forms exist (the present reduplication
with `i`, e.g. `*sti-steh₂-` — actually some Greek presents like
ἵστημι preserve this). Less important for first cut.


## 6. Output structure

Two output modes:

### Flat mode

One form per line, no grouping:

```
*bʰergʰ-
*bʰr̥gʰ-tós
*bʰórgʰ-os
*h₂erh₃-
*h₂r̥h₃-tós
*sed-
*séd-os
...
```

### Paradigm mode

Grouped by root:

```yaml
- root: bʰergʰ
  template: CVRC
  meaning: (fantasy)
  forms:
    base:        *bʰergʰ-
    zero:        *bʰr̥gʰ-
    ograde:      *bʰorgʰ-
    to-adj:      *bʰr̥gʰ-tós
    yo-pres:     *bʰergʰ-ye-
    perf:        *bʰébʰorgʰ-
    s-stem:      *bʰérgʰos
    agent:       *bʰergʰtḗr-
- root: h₂erh₃
  template: HVRH
  forms:
    base:        *h₂erh₃-
    zero:        *h₂r̥h₃-
    ...
```

YAML or our own simple format — doesn't matter much. The paradigm
view is **the more useful output** for diagnosing engine behavior:
if Greek mangles one form of a root but handles others fine, it's
obvious which rule is the culprit.

We probably want a small CLI:

```
lauttool-gen --count 100 --template all > corpus.txt
lauttool-gen --count 50 --paradigms --format yaml > paradigms.yml
lauttool-gen --root bʰergʰ --paradigm > one-root.yml
```


## 7. Generation algorithm sketch

```
function generateRoot(opts):
  loop until valid:
    template = pickWeightedTemplate()
    root = template.fillSlots(inventory)
    if checkPhonotactics(root): return root

function generateForm(root, opts):
  grade = pickGrade(opts.distribution)
  morphology = pickMorphology(opts)
  return applyMorphology(applyGrade(root, grade), morphology)

function generateParadigm(root):
  cells = []
  for cell in selectedParadigmCells:
    cells.push(applyMorphology(root, cell.morph, cell.gradeOverride))
  return { root, cells }
```

The morphology applier is the trickiest part. It needs to know:
- How to insert a suffix.
- How to adjust accent based on the suffix's accent rule.
- How to adjust ablaut grade based on accent placement.
- How to handle reduplication.

But each of these is small. Maybe 50 lines of TS for the morphology
core.


## 8. What's deliberately NOT modeled

- **Inflection** (case endings, person/number). User said skip.
- **Real attested roots**. We're conlanging.
- **Semantic content**. Forms have shapes, not meanings.
- **Loanwords or borrowings**. Pure inherited material.
- **The Narten ablaut class**, the Caland system, exact stem-class
  distinctions. Suggested only structurally.


## 9. Why this is good

- **Test corpus generator**. Run output through Greek, Aryan, etc.,
  get expected-output snapshots. Any rule change → visible diff.
- **Demo material**. "Here's a randomly generated PIE root in 12
  daughter dialects" is a great talk slide.
- **Edge-case discoverer**. Random generation will hit combinations
  that hand-picked test sets miss.
- **Educational tool**. Other linguists could use it as a sandbox.
- **Genuinely fun.** Half of the joy of historical linguistics is
  watching forms evolve; this lets us watch *new* forms evolve
  through real sound laws.


## 10. Possible extensions later

- **Stress-PIE → Greek conlang** end-to-end demo: 1000 generated
  PIE roots → run through every Greek dialect → look at the
  resulting "fantasy Mycenaean" / "fantasy Lesbian" / etc.
- **Frequency-weighted templates** based on actual PIE corpus
  statistics if anyone has data.
- **Reflex tables**: for each generated root, show the predicted
  outcome in N daughter languages side by side. (This is what
  the derivation table view does, automatically.)
- **Plug into Wiktionary-style display**: format paradigms with
  morphological labels.
