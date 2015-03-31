(define rules-urgr
  (list
    (s "O" "o")
    (s "č" "k")
    (s "ǰ" "g")
    (s "Gʰ" "Kʰ")
    (s "gʰ" "kʰ")
    (s "jʰ" "cʰ")
    (s "dʰ" "tʰ")
    (s "bʰ" "pʰ")

    (s "z" "s")

    ;;; m > n
    ;;(s "m(s|$)" "n" 1)
    ;;(s "Ms" "Ns")

    ;;; (H)i̯ im Anlaut
    (s "^y(<vok>)" "dy" 1)
    (s "^(<lary>)y(<vok>)" "y" 2)
    (s "(<kons>)(H1|H2)$" 1 (laryngal->vokal 2))

    ;;; Laryngale
    (s "(i|u)('?)(<lary>)(<vok>)" 1 2 (sonans->consonans 1) 4)
    (s "(<kons>)(<kons>)(i|u)(H1|H2)$"
       1 2 3 (sonans->consonans 3) (laryngal->vokal 4))
    (s "(i|u)(H1|H2)$" (sonans->consonans 1) (laryngal->vokal 2))

    (s "(<vok>)('?)(<lary>)(<kons>|<s-res>|$)"
       (dehnung 1) 2 (sonans->consonans 4))

    (s "^(<lary>)(<kons>)" (laryngal->vokal 1) 2)
    (s "(<kons>)(<lary>)(<kons>)" 1 (laryngal->vokal 2) 3)

    (s "NH2$" "na")
    (s "(<kons>)(<lary>)(<s-res>)" 1 (laryngal->vokal 2) (sonans->consonans 3))
    (s "(<s-res>)(<lary>)(<kons>)"
       (sonans->consonans 1) (laryngal->langvokal 2) 3)
    (s "(<s-res>)'(<lary>)(<kons>)"
       (laryngal->vokal 2) "'" (sonans->consonans 1) (laryngal->vokal 2) 3)
    (s "^(<lary>)(<s-res>|u|ū)" (laryngal->vokal 1) (sonans->consonans 2))

    (s "<lary>" "")

    ;;; Labiovelar -> velar
    (s "(w|u|ū)('?)(<labiovelar>)" 1 2 (labiovelar->velar 3))
    (s "(<labiovelar>)(w|u|ū|y)" (labiovelar->velar 1) 2)

    ;;; Liguiden und Nasale
    (s "(<s-nasal>)(<vok>|<halbvok>)" "a" (sonans->consonans 1) 2)
    (s "(<s-nasal>)" "ə")
    (s "(<s-liquid>)($|<vok>|<halbvok>)" "ə" (sonans->consonans 1) 2)
    (s "(<s-liquid>)" (sonans->consonans 1) "ə")
    ;;; TODO: erst dialektal
    ;(s "ə" "a")

    ;;; Assimilationen (nach Labiovelarwandel noch mal!)
    (s "(<nasal>)(<labial>)" "m" 2)
    (s "(<nasal>)(<dental>|<velar>|<labiovelar>|s)" "n" 2)
    (s "my" "ny")

    ;;; tautosyllabisches ns > s (später noch mal (σύζυγος))
    ;;; TODO: vielleicht später? (nach dz > zd)
    (s "ns(<kons>)" s 1)

    ;;; Kontraktion
    (s "ee" "ē")
    (s "e'e" "ē~")
    (s "ee'" "ē'")
    (s "aa" "ā")
    (s "a'a" "ā~")
    (s "aa'" "ā'")
    (s "oo" "ō")
    (s "o'o" "ō~")
    (s "oo'" "ō'")
    (s "(<vok>)(['~]?)(i|u)" 1 2 (sonans->consonans 3))

    ;;; Konsonanten im Auslaut (Datierung unklar)
    (s "(<okklu>)+$")
    (s "m$" "n")

    ;;; s > h
    (s "^s(<vok>|<liquid>|n|w)" "h" 1)
      ;; TODO: manchmal aber sm
    (s "^sm" "hm")
    (s "(<vok>)(['~]?)s(<vok>)" 1 2 "h" 3)

    ;;; Palatalisierung
    ;;; TODO: ty hinter langvokal in tt-dialekten
    ;;;       tw (wohl nicht urgr (Allen 124))
    (s "(^|<kons>)(tʰ|t)y" 1 "s")
    (s "(tʰ|t)y" "ts")
    (s "dy" "dz")
    (s "(kʰ|k)y" "tč")
    (s "gy" "dz")   ;;; TODO: oder dǰ? (eigentlich ziemlich egal)
    (s "(<labial>)y" "pč")

    ;;; TODO: Umgebung. nach Langvokal, Diphthong, Konsonant?
    (s "ly" "ĺĺ")
    (s "ry" "ŕŕ")
    (s "ny" "ńń")

    'urgr

    ))

