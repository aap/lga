;(load "arisch.scm")
(load "griechisch.scm")

(define rules
  (list
    'uridg
;    `(br (urar) ,rules-urar)
    `(br (urar) '())
    `(br (urgr) ,rules-urgr)
    ))

(set-phono-rules 'uridg
  (list (s "ʰ" "!")
        (s "kʷ" "K")
        (s "gʷ" "G")
        (s "k̑" "č")
        (s "g̑" "ǰ")
        (s "i̯" "y")
        (s "u̯" "w")
        (s "m̥" "M")
        (s "n̥" "N")
        (s "r̥" "R")
        (s "l̥" "L")
        (s "h₁" "H1")
        (s "h₂" "H2")
        (s "h₃" "H3")
        (s "́" "'")
        ;;;
        (s "e('?)H2" "a" 1 "H2")
        (s "H2e" "H2a")
        ;;; umgefärbtes e noch von o verschieden
        (s "e('?)H3" "O" 1 "H3")
        (s "H3e" "H3O")
        ;;; TODO: bedingungen für stimmhaftwerdung
        (s "s(G|g|ǰ|d|b|r|l|m|n)" "z" 1)
        (s "(G|g|ǰ|d|b|r|l|m|n)(!?)s" 1 2 "z")
        ;;; TODO: stimmtonassimilation; uridg? (gr. μίσγω < migsk̑oh₂)
        ;(s "(K|k|č|t|p)(s|z)?(G|g|ǰ|d|b)" (stimmhaft 1) (stimmhaft 2) 3)
        ;(s "(G|g|ǰ|d|b)(s|z)?(K|k|č|t|p)" (stimmlos 1) (stimmlos 2) 3)
        ))

(set-pretty-rules 'ved
  (list (s "ē" "e")
        (s "ō" "o")
        (s "R" "ṛ")
        (s "!" "h")
        (s "'" "́")))

(set-pretty-rules 'urav
  (list (s "!" "ʰ")
        (s "χ" "x")
        (s "'" "́")))

(set-pretty-rules 'urgr
  (list (s "!" "ʰ")
        (s "G" "gʷ")
        (s "K" "kʷ")
        (s "w" "u̯")
        (s "y" "i̯")
        (s "'" "́")))
