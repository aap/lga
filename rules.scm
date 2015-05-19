;(load "arisch.scm")
(load "griechisch.scm")
;(load "germanisch.scm")

(define rules
  (list
    'uridg
;    `(br (urar) ,rules-urar)
    `(br (urgr) ,rules-urgr)
;    `(br (urgerm) ,rules-urgerm)
    ))

;;
;; This stuff is still really, really ugly :(
;;

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
        ))

(let ((rules (list (s "ʰ" "!")
                   (s "kʷ" "K")
                   (s "gʷ" "G")
                   (s "i̯" "y")
                   (s "u̯" "w")
                   (s "́" "'"))))
  (set-phono-rules 'urgr1 rules)
  (set-phono-rules 'urgr rules))

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

(set-pretty-rules 'urgerm
  (list (s "'" "́")))

(let ((rules (list (s "!" "ʰ")
                   (s "G" "gʷ")
                   (s "K" "kʷ")
                   (s "w" "u̯")
                   (s "y" "i̯")
                   (s "ā" "ā")
                   (s "ē" "ɛ̄")
                   (s "ī" "ī")
                   (s "ō" "ɔ̄")
                   (s "ū" "ū")
                   (s "Ā" "ǣ")
                   (s "Ē" "ē")
                   (s "Ō" "ō")
                   (s "'" "́"))))
  (set-pretty-rules 'urgr1 rules)
  (set-pretty-rules 'urgr rules)
  (set-pretty-rules 'lesb rules)
  (set-pretty-rules 'ion-att rules)
  (set-pretty-rules 'ion rules)
  (set-pretty-rules 'euboi rules)
  (set-pretty-rules 'att rules)
  (set-pretty-rules 'kret rules)
  (set-pretty-rules 'dor rules)
  (set-pretty-rules 'sdor rules)
  (set-pretty-rules 'sardor rules)
  (set-pretty-rules 'inseldor rules)
  (set-pretty-rules 'kypr rules)
  (set-pretty-rules 'thess rules)
  (set-pretty-rules 'boiot rules)
  (set-pretty-rules 'el rules)
  (set-pretty-rules 'kor rules)
  (set-pretty-rules 'ark rules)
  )

