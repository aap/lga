(define rules-urgerm
  (list
    ;;; *e neben *H3 und *o fallen zusammen
    (s "O" "o")

    (s "č" "k")
    (s "ǰ" "g")
    (s "(<vok>)('?)(<lary>)(<kons>|$)" (dehnung 1) 2 4)

    (s "p" "f")
    (s "t" "þ")
    (s "k" "x")

    (s "b([^!])" "p" 1)
    (s "d([^!])" "t" 1)
    (s "g([^!])" "k" 1)

    (s "b!" "ƀ")
    (s "d!" "đ")
    (s "g!" "ǥ")

    (s "(^|n)ƀ" 1 "b")
    (s "(^|n)đ" 1 "d")

    (s "(.)f(.*)'" 1 "ƀ" 2 "'")
    (s "(.)þ(.*)'" 1 "đ" 2 "'")
    (s "(.)x(.*)'" 1 "ǥ" 2 "'")

    (s "'" "")

    (s "o" "a")
    (s "ā" "ō")

    'urgerm
    ))
