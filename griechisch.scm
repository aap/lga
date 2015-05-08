(define rules-urgr
  (list
    ;;; *e neben *H3 und *o fallen zusammen
    (s "O" "o")

    ;;; Kentum -- Rix §92-94
    (s "č" "k")
    (s "ǰ" "g")

    ;;; MA > TA -- Rix §94
    (s "(<mediaasp>)" (stimmlos 1))

    ;;; Ein Laut der Einfachheit halber
    (s "z" "s")

    ;;; Rix §106c
    (s "(<dental>)(<dental>)" "s" 2)

    ;;; (H)i̯ im Anlaut -- gegen Rix §68,80e
    (s "^y(<vok>)" "dy" 1)
    (s "^(<lary>)y(<vok>)" "y" 2)

    ;;; Laryngale -- Rix §79-85
    ; Rix §85d
    (s "(<kons>)(H1|H2)$" 1 (laryngal->vokal 2))
    ; Rix §85
    (s "(<kons>)(<kons>)(i|u)(H1|H2)$"
       1 2 3 (laryngal->vokal 4))
    (s "(i|u)(H1|H2)$" (sonans->consonans 1) (laryngal->vokal 2))
    ; Dehnung -- Rix §82b,84,85a
    (s "(<vok>)('?)(<lary>)(<kons>|<s-res>|$)"
       (dehnung 1) 2 (sonans->consonans 4))
    ; Rix §80d
    (s "^(<lary>)(<kons>)" (laryngal->vokal 1) 2)
    ; Rix §82c
    (s "(<kons>)(<lary>)(<kons>)" 1 (laryngal->vokal 2) 3)
    ; Rix §85c
    (s "NH2$" "na")
    ; Rix §84
    (s "(<kons>)(<lary>)(<s-res>)" 1 (laryngal->vokal 2) (sonans->consonans 3))
    ; Rix §83e
    (s "(<s-res>)(<lary>)(<kons>)"
       (sonans->consonans 1) (laryngal->langvokal 2) 3)
    (s "(<s-res>)'(<lary>)(<kons>)"
       (laryngal->vokal 2) "'" (sonans->consonans 1) (laryngal->vokal 2) 3)
    ; Rix §79bc
    (s "^(<lary>)(u|ū|<s-res>)" (laryngal->vokal 1) (sonans->consonans 2))
    ; kompletter Verlust -- Rix §79a,81a,82d,84
    (s "<lary>" "")

    ;;; vor Labiovelar > Velar wegen εἶπον -- nicht bei Rix
    (s "wew" "wey")

    ;;; Labiovelar > Velar -- Rix §97
    (s "(w|u|ū)('?)(<labiovelar>)" 1 2 (labiovelar->velar 3))
    (s "(<labiovelar>)(w|u|ū|y)" (labiovelar->velar 1) 2)

    ;;; Liquiden und Nasale
    ; Rix §76
    (s "(<s-nasal>)(<vok>|<halb-vok>)" "a" (sonans->consonans 1) 2)
    (s "(<s-nasal>)" "ə")
    ; Rix §75
    (s "(<s-liquid>)($|<vok>|<halb-vok>)" "ə" (sonans->consonans 1) 2)
    (s "(<s-liquid>)" (sonans->consonans 1) "ə")

    ;;; Assimilationen (nach Labiovelarwandel noch mal!) -- Rix §78
    (s "(<nasal>)(<labial>)" "m" 2)
    ; gegen Rix nicht *ms > *ns wegen ἔνειμα < *enemsa (oder analog?)
    (s "(<nasal>)(<dental>|<velar>|<labiovelar>)" "n" 2)
    ; Rix §77
    (s "my" "ny")

    ;;; 1. Kontraktion (nach Laryngalverlust)
    ;; TODO: Langvokale? gibt es die überhaupt?
    ; Rix §81
    (s "ee" "ē")
    (s "e'e" "ē~")
    (s "aa" "ā")
    (s "a'a" "ā~")
    (s "oo" "ō")
    (s "o'o" "ō~")
    ; i,u > y,w
    (s "(i|u)('?)(<vok>)" 1 2 (sonans->consonans 1) 3)
    (s "(<vok>)(['~]?)(i|u)" 1 2 (sonans->consonans 3))

    ;;; Thorn -- Rix §91 -- Schindler 'A thorny problem'
    (s "(k|K)þ" 1 "t")
    (s "(k!|K!)þ" 1 "t!")

    ;;; Osthoff -- Rix §64
    ; TODO: Datierung unklar, wohl vor Verlust von Okklusiven im Auslaut
    ;       aber ōrto < eh3rto (vermutlich analog augmentiert)
    (s "(<lang-vok>)(['~]?)(<res-yw>)(<kons>)" (kuerzung 1) 2 3 4)

    ;;; Konsonanten im Auslaut (Datierung unklar) -- Rix §100
    ; nach *r̥C > *rəC wegen ὑπόδρα < *upo-dr̥k
    (s "(<okklu>)+$")
    ; Rix §77
    (s "m$" "n")

    ;;; unmittelbare Assimilation -- Rix §106a
    ; TODO: früher (idg); phonologisch?
    (s "(<okklu>)(<media>)([^!])" (->M 1) 2 3)
    (s "(<okklu>)(<tenuis>)([^!])" (->T 1) 2 3)
    (s "(<okklu>)(<tenuisasp>)([^!])" (->TA 1) 2 3)

    ;; Beseitigung von Geminaten (αἰπόλος < *ai̯g-kʷolos) -- nicht Rix
    ;; TODO: mehr Laute; vermutlich nicht nach Kurzvokal
    (s "k(k|K)" 1)
    (s "g(g|G)" 1)
    (s "pp" "p")
    (s "bb" "b")
    (s "tt" "t")
    (s "dd" "d")

    ;; Kw > Kʷ (Beibehaltung des Silbengewichts)
    (s "(<kurz-vok>)('?)(<velar>)w(<vok>)" 1 2 3 (velar->labiovelar 3) 4)
    (s "(<velar>)w" (velar->labiovelar 1))

    ;;; Assimilation über s -- Rix §105
    (s "(<media>)s(<tenuis>)([^!])" 1 "s" (stimmhaft 2) 3)
    (s "(<tenuisasp>)s(<tenuis>)([^!])" 1 "s" (->A 2) 3)

    ; CsC -- Rix §87c
    ;  tautosyllabisches [mn]s > s später noch mal (σύζυγος)
    (s "(<nasal>|<dental>)s(<kons>)" "s" 2)
    ; s zwischen gleichen Konsonanten -- TODO: unschön; alle Fälle abgedeckt?
    (s "ksk" "sk") (s "gsg" "sg") (s "k!sk!" "sk!")
    (s "KsK" "sK") (s "GsG" "sG") (s "K!sK!" "sK!")
    (s "psp" "sp") (s "bsb" "sb") (s "p!sp!" "sp!")
    (s "lsr" "sr") (s "lsl" "sl")

    ;;; Okklusive vor s -- Rix §105
    (s "(<labial>)s" "ps")
    (s "(<dental>)s" "ts")
    (s "(<velar>)s" "ks")
    (s "(<labiovelar>)s" "Ks")

    ;;; s > h
    ; Rix §86b -- TODO: *si̯-?
    (s "^s(<vok>|<liquid>|n|w)" "h" 1)
    ; Rix §86c -- TODO: manchmal aber sm
    (s "^sm" "hm")
    ; Rix §89f
    (s "(<vok>)(['~]?)s(<vok>)" 1 2 "h" 3)
    ; Rix §89g -- TODO: ys > yy laut Rix
    (s "sy" "yy")

    ;;; Palatalisierung -- TODO -- Rix §102
    ;;; TODO: ty hinter langvokal in tt-dialekten
    ;;;       tw (wohl nicht urgr (Allen 124))
    (s "^(t!|t)y" "s")
    (s "(t!|t)y" "ts")
    (s "(d|g)y" "dž")
    (s "(k!|k)y" "tš")
    (s "(<labial>)y" "pč")

    ;;; TODO: Umgebung. nach Langvokal, Diphthong, Konsonant?
    (s "ly" "ĺĺ")
    (s "ry" "ŕŕ")
    (s "ny" "ńń")

    ;;; Datierung? -- Rix §105
    (s "dl" "ll")

    ;;; tk, tkw, tp Metathese -- Rix §106 (etwas anders)
    (s "(t)(k|K|p)" 2 1)

    'urgr

    ; ti > si -- Rix §101
    ;  Kein wirkliches (ausnahmsloses) Lautgesetz;
    ;    schwierig einigermaßen zufriedenstellend zu formulieren.
    `(sub (sogr) (,(s "([^sk])ti" 1 "si")))

    ; TODO: wann o?
    (s "ə" "a")

    (s "pč" "pt")

    ; heteromorphemisches ty
    (s "(t!|t)y" "ts")

    (s "^y(<vok>)" "h" 1)
    (s "(<vok>)(['~]?)y(<vok>)" 1 2 "h" 3)

    'myk

    ; Rix §102
    (s "dž" "dz")
    `(sub (boiot kret lak el) (,(s "^dz" "d")
                               ,(s "dz" "dd")))
    (s "dz" "zd")

    ; ts > ss/tt -- Rix §102
    `(sub (boiot kret) (,(s "ts" "tt")))
    `(sub (not boiot kret) (,(s "ts" "ss")))
    (s "(<kons>)ss" 1 "s")
    (s "(<vok>)(['!]?)(y|w)ss" 1 2 3 "s")
    (s "(<lang-vok>)(['!]?)ss" 1 2 "s")
    `(sub (ion-att) (,(s "ss" "ss")))

    ))

