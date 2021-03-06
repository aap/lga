;(load "arisch.scm")
(load "griechisch.scm")
;(load "germanisch.scm")

(define rules
  (list
    'uridg
;    `(br (urar) ,rules-urar)
    `(br (urgr1) ,rules-urgr)
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
        (s "\u0301" "'")  ; combining acute
        ;;;
        (s "e('?)H2" "a" 1 "H2")
        (s "H2e" "H2a")
        ;;; umgefärbtes e noch von o verschieden
        (s "e('?)H3" "O" 1 "H3")
        (s "H3e" "H3O")
        ;;; TODO: bedingungen für stimmhaftwerdung
        (s "s(G|g|ǰ|d|b|r|l|m|n)" "z" 1)
        (s "(G|g|ǰ|d|b|r|l|m|n)(!?)s" 1 2 "z")
        ;;; TT -> TsT
        (s "(<dental>)(<dental>)" 1 "s" 2)
        ))

(let ((rules (list (s "ʰ" "!")
                   (s "kʷ" "K")
                   (s "gʷ" "G")
                   (s "i̯" "y")
                   (s "u̯" "w")
                   (s "\u0301" "'")))) ; combining acute
  (set-phono-rules 'urgr1 rules)
  (set-phono-rules 'urgr rules))

(set-pretty-rules 'ved
  (list (s "ē" "e")
        (s "ō" "o")
        (s "R" "ṛ")
        (s "!" "h")
        (s "'" "\u0301"))) ; combining acute

(set-pretty-rules 'urav
  (list (s "!" "ʰ")
        (s "χ" "x")
        (s "'" "\u0301"))) ; combining acute

(set-pretty-rules 'urgerm
  (list (s "'" "́")))

(let ((rules (list (s "!" "ʰ")
                   (s "G" "gʷ")
                   (s "K" "kʷ")
                   (s "w" "u̯")
                   (s "y" "i̯")
                   (s "ā" "ā")
                   (s "ē" "ɛ̄")
                   (s "ī" "ī")
                   (s "ō" "ɔ̄")
                   (s "ū" "ū")
                   (s "Ā" "ǣ")
                   (s "Ē" "ē")
                   (s "Ō" "ō")
                   (s "~" "\u0303")     ; combining tidle
                   (s "'" "\u0301"))))  ; combining acute
  (set-pretty-rules 'urgr1 rules)
  (set-pretty-rules 'urgr rules)
  (set-pretty-rules 'lesb rules)
  (set-pretty-rules 'ion-att rules)
  (set-pretty-rules 'ostion rules)
  (set-pretty-rules 'inselion rules)
  (set-pretty-rules 'hom rules)
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
  (set-pretty-rules 'warg rules)
  (set-pretty-rules 'oarg rules)
  (set-pretty-rules 'ark rules)
  )

(define usegrkalphabet #f)

(define (togrk str)
 (define rules (list
                    (s "u̯u̯" "u̯")
                    (s "i̯i̯" "i̯")
                    (s "\u0301" "'")   ; combining acute

                    (s "a(['~]?)i̯" "αι" 1)
                    (s "a" "α")
                    (s "ā(['~]?)i̯" "ᾱ" 1 "ι")
                    (s "ā" "ᾱ")
                    (s "e(['~]?)i̯" "ει" 1)
                    (s "e" "ε")
                    (s "ē" "ε̄ι")
                    (s "ɛ̄(['~]?)i̯" "η" 1 "ι")
                    (s "ɛ̄" "η")
                    (s "o(['~]?)i̯" "οι" 1)
                    (s "o" "ο")
                    (s "ō" "ο̄")
                    (s "ɔ̄(['~]?)i̯" "ω" 1 "ι")
                    (s "ɔ̄" "ω")
                    (s "u(['~]?)i̯" "υι" 1)
                    (s "u̯" "ϝ")
                    (s "u" "υ")
                    (s "ū" "ῡ")
                    (s "i" "ι")
                    (s "ī" "ῑ")

                    (s "b" "β")
                    (s "g" "γ")
                    (s "d" "δ")
                    (s "sd" "ζ")
                    (s "tʰ" "θ")
                    (s "k" "κ")
                    (s "l" "λ")
                    (s "m" "μ")
                    (s "n" "ν")
                    (s "ks" "ξ")
                    (s "p" "π")
                    (s "r" "ρ")
                    (s "s$" "ς")
                    (s "s" "σ")
                    (s "t" "τ")
                    (s "pʰ" "φ")
                    (s "kʰ" "χ")
                    (s "ps" "ψ")
                    (s "'" "\u0301")   ; combining acute
                    (s "~" "\u0303")   ; combining tilde
                    ))
 (if usegrkalphabet
     (apply-rules rules str)
     str))

(set-pretty-rules 'urgerm
  (list (s "x" "h")
        (s "X" "ƕ")
        (s "(<vok>)('?)(w|y)" 1 2 (consonans->sonans 3))
        (s "y" "j")))

