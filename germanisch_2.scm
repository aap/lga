(define rules-urgerm
  (list
    ;;; *e neben *H3 und *o fallen zusammen
    (s "O" "o")

    (s "č" "k")
    (s "ǰ" "g")

    (s "R" "ur")
    (s "L" "ul")
    (s "M" "um")
    (s "N" "un")

    (s "(<vok>)('?)(<lary>)(<kons>|$)" (dehnung 1) 2 4)
    (s "^(<kons>)(<lary>)(<kons>)" 1 "a" 3)
    (s "<lary>")

    (s "m(<dental>)" "n" 1)

    (s "t$")

    (s "(<media>)(<tenuis>)" (->T 1) 2)

    (s "(^|<vok>|<res-yw>)('?)p" 1 2 "f")
    (s "(^|<vok>|<res-yw>)('?)t" 1 2 "þ")
    (s "(^|<vok>|<res-yw>)('?)k" 1 2 "x")

    (s "b!" "ƀ")
    (s "d!" "đ")
    (s "g!" "ǥ")

    (s "b" "p")
    (s "d" "t")
    (s "g" "k")

    (s "(<vok>)(<res-yw>)?f(<vok>|<res-yw>|$)" 1 2 "ƀ" 3)
    (s "(<vok>)(<res-yw>)?þ(<vok>|<res-yw>|$)" 1 2 "đ" 3)
    (s "(<vok>)(<res-yw>)?x(<vok>|<res-yw>|$)" 1 2 "ǥ" 3)
    (s "(<vok>)(<res-yw>)?s(<vok>|<res-yw>|$)" 1 2 "z" 3)

    (s "(^|n)ƀ" 1 "b")
    (s "(^|n)đ" 1 "d")
    (s "(^|n)ǥ" 1 "g")
    
    (s "'")

    (s "o" "a")
    (s "ā" "ō")

    (s "e(<nasal>)(<kons>|f|þ|h|ƀ|đ|ǥ)" "i" 1 2)

    (s "(<vok>)(.*)e([^r])" 1 2 "i" 3)

    'urgerm
    ))
