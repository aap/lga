(define rules-urgerm
  (list
    ;;; *e neben *H3 und *o fallen zusammen
    (s "O" "o")

    (s "č" "k")
    (s "ǰ" "g")

    (s "(<s-res>|<vok>)H3w" 1 "gw")
    (s "(<s-res>)(<lary>)(<kons>)" 1 3)

    (s "R" "ur")
    (s "L" "ul")
    (s "M" "um")
    (s "N" "un")

    (s "(<vok>)('?)(<lary>)(<kons>|$)" (dehnung 1) 2 4)
    (s "(<kons>)(<lary>)(<kons>)" 1 "a" 3)
    (s "(<lary>)")

    (s "(<nasal>)(<dental>)" "n" 2)

    (s "(<dental>)(<dental>)" "ss")

    (s "(<media>|<mediaasp>)(<tenuis>)" (->T 1) 2)

    (s "(^|<vok>|<res>)('?)p" 1 2 "f")
    (s "(^|<vok>|<res>)('?)t" 1 2 "þ")
    (s "(^|<vok>|<res>)('?)k" 1 2 "x")
    (s "(^|<vok>|<res>)('?)K" 1 2 "X")

    (s "b!" "ƀ")
    (s "d!" "đ")
    (s "g!" "ǥ")
    (s "G!" "Ǥ")

    (s "b" "p")
    (s "d" "t")
    (s "g" "k")
    (s "G" "K")

    (s "(<vok>|<res>)f(<vok>|<res>)(.*)'" 1 "ƀ" 2 3 "'")
    (s "(<vok>|<res>)þ(<vok>|<res>)(.*)'" 1 "đ" 2 3 "'")
    (s "(<vok>|<res>)x(<vok>|<res>)(.*)'" 1 "ǥ" 2 3 "'")

    (s "X(<okklu>)" "x" 1)

    (s "(^|n|m)ƀ" 1 "b")
    (s "(^|n|m)đ" 1 "d")
    (s "(^|n|m)ǥ" 1 "g")

    (s "'")

    (s "o" "a")
    (s "ā" "ō")

    (s "ln" "ll")

    'urgerm
    ))
