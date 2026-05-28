(define rules-urgerm '())

(let* (
  (rules-wgerm (list

    (s "ay$" "Ē")

    (s "z$")

    ;; only for -ais....is this correct? maybe -z raises?
    (s "ay$" "ī")

    (s "(<lang-vok>)$" (kuerzung 1))
    (s "N$")

    ;; TODO: not so sure about this
    `(sub (ae) (,(s "ew$" "ō")))

    `(sub (ahd) (,(s "E" "e")))

    `(sub (as ae) (,(s "(<lang-vok>)(s)?$" (kuerzung 1) 2)
                   ,(s "o(s)?$" "A" 1)
                   ,(s "a(s)?$" "E" 1)))

    ;; TODO: correct formulation
    `(sub (ahd as) (,(s "e(<kons>)*(u|w)" "i" 1 2)))

    ;; TODO: not so sure about this; needed for -ewes > -i
    `(sub (ahd as) (,(s "w$")))

    ;; very late; see Hogg merger of unstressed vowels
    `(sub (ae) (,(s "A" "a")
                ,(s "E" "e")
                ,(s "i$" "e")))
	;; spelling
    `(sub (as) (,(s "A" "å")
                ,(s "E" "æ")))
  ))
  

  (urgerm (list
    (s "O" "o")

;    (s "o" "a")
;    (s "ā" "ō")

    'urgerm1

    (s "s$" "z")
    (s "<nasal>$" "N")

    'urgerm
    (s "(a|o)" "A")
    (s "(Ā|ō)" "Ā")

    ; other environments too
    `(sub (not got) (,(s "Ā$" "ū")))

    (s "N$")

    ;; TODO: correct formulation
    (s "eyA" "ēA")

    (s "e(<kons>)*(i|y)" "i" 1 2)
    (s "ez" "iz")
    (s "e$" "i")	;; just a guess

    (s "ē$" "Ē")
    `(sub (not got) (,(s "Ē$" "Ā")))
    (s "Ay$" "Ē")
    `(sub (got) (,(s "Ē$" "Ā")))

'wgerm
    (s "(<lang-vok>)(y|w)?$" (kuerzung 1) 2 "%")
    (s "(<kurz-vok>)(<okklu>|<sibil>)?$" 2)
    (s "%")

    (s "i(i|y)" "ī")

    (s "t$")

    ;; which rule depends on OHG o-a.pl. -a
;    `(sub (wgerm) (,(s "(<vok>)(<nasal>)(<sibil>)" (dehnung 1) "N" 3)
    `(sub (wgerm) (,(s "(<vok>)(<nasal>)(<sibil>)" 1 "N" 3)
                   ,(s "ĀN" "āN")
		  ))

    (s "Ā" "ō")
    (s "A" "a")

    (s "ss" "s")
    (s "sz" "s")

    `(sub (got) (,(s "e" "i")
                 ,(s "z$" "s")
                 ,(s "iw(<kons>)(<kons>|$)" "yu" 1 2)))

    'got

    ; wgerm dialects
    `(br (wgerm) ,rules-wgerm)

    )))
    (set! rules-urgerm urgerm))
