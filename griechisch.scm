(define rules-urgr
  (list
    ;;; Ein Laut der Einfachheit halber
    (s "z" "s")

    ;;; *e neben *H3 und *o fallen zusammen
    (s "O" "o")

    ;;; Kentum -- Rix §92-94
    (s "č" "k")
    (s "ǰ" "g")

    ;;; MA > TA -- Rix §94
    (s "(<mediaasp>)" (stimmlos 1))

    ;;; Thorn -- Rix §91 -- Schindler 'A thorny problem'
    (s "(k|K)þ" 1 "t")
    (s "(k!|K!)þ" 1 "t!")

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
    (s "<lary>")

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
    ; s zwischen gleichen Konsonanten -- TODO: unschön; alle Fälle abgedeckt?
    (s "ksk" "sk") (s "gsg" "sg") (s "k!sk!" "sk!")
    (s "KsK" "sK") (s "GsG" "sG") (s "K!sK!" "sK!")
    (s "tst" "st") (s "dsd" "sd") (s "t!st!" "st!")
    (s "psp" "sp") (s "bsb" "sb") (s "p!sp!" "sp!")
    (s "rsr" "sr") (s "lsl" "sl")

    ;;; Okklusive vor s -- Rix §105
    (s "(<labial>)s" "ps")
    (s "(<dental>)s" "ts")
    (s "(<velar>)s" "ks")
    (s "(<labiovelar>)s" "Ks")

    ; vor s > h und Palatalisierung
    'urgr1

    ;;; s > h
    ; s > h \ (#|V)_(V|RV) -- Rix §88,89
    (s "(^|(<vok>)(['~]?))s((<vok>)|(<res>|w)(<vok>))" 1 "h" 4)
    ;; VRsV > VRhV in unbetonten Silben
    (s "(<vok>)(<res>|w)s(<vok>)" 1 2 "h" 3)
    ;; VNsV > VNhV
    (s "(<vok>)(['~]?)(<nasal>)s(<vok>)" 1 2 3 "h" 4)
    ; Rix §89g
    (s "sy" "yy")
    (s "ys" "yy")

    ;;; Osthoff -- Rix §64
    ; Wohl nach *ns > *nh wegen μηνός < *mēnsós und
    ;      vor Verlust von Okklusiven im Auslaut
    ; *nh (und *nm *u̯i̯?) nicht betroffen
    (s "nh" "#nh")
    (s "(<lang-vok>)(['~]?)(<res-yw>)(<kons>)" (kuerzung 1) 2 3 4)
    (s "#")

    ;;; Konsonanten im Auslaut (Datierung unklar) -- Rix §100
    ; nach *r̥C > *rəC wegen ὑπόδρα < *upo-dr̥k
    (s "(<okklu>)+$")
    ; Rix §77
    (s "m$" "n")

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

    ;;; Datierung unklar, vermutlich später und gestaffelt -- Rix §78
    (s "^m(<liquid>)" "b" 1)
    (s "m(<liquid>)" "bm" 1)
    (s "^n(<liquid>)" "d" 1)
    (s "n(<liquid>)" "nd" 1)

    ;;
    ;; Urgriechisch
    ;;
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

    ;;
    ;; Mykenisch
    ;;
    'myk

    (s "dž" "ds")

    `(sub (el) (,(s "ē" "ā")))

    ;;;; ca. 1000

    ;;; tw -- Rix §104
    `(sub (not kret) (,(s "^tw" "s")))
    (s "(.)tw" 1 "tš")
    ;;; tʰw -- unklar, aber vgl. -σθε ai. -dhvam
    (s "^t!w" "t!")
    (s "t!w" "st!")

    ;;; ds > sd
    ; vor CsC > ChC wegen ἔρδω < *u̯erzdō < *u̯erg̑i̯e/o-
    (s "ds" "sd")

    ;;; (N|T)sC > sC -- Rix §87c
    ; vor CsC > ChC wegen ἴσος < u̯idsu̯os und δεσπότης < *demspot-
    ; nach dz > zd wegen σύζυγος < *sun-dzugos
    (s "(<nasal>|<dental>)s(<kons>)" "s" 2)

    ;;; CsC -- Rix §87c
    (s "(<kons>)s(<kons>)" 1 "h" 2)
    (s "(<tenuis>)h" (->A 1))
    (s "h(<tenuis>)([^!])" (->A 1) 2) ; TODO: beispiele?
    (s "(<tenuisasp>)(<tenuis>)([^!])" 1 (->A 2) 3)

    ;;; Labiovelare > T/P -- Rix §96-99
    `(sub (not ach aiol) (,(s "K(i|ī)" "t" 1)
                         ,(s "(<labiovelar>)(e|ē)" (labiovelar->dental 1) 2)))
    (s "(<labiovelar>)" (labiovelar->labial 1))
    ;; Assimilationen an Labiovelarreflexe
    (s "(<nasal>)(<labial>)" "m" 2)
    (s "(<nasal>)(<dental>)" "n" 2)
    (s "(<nasal>)(<velar>)" "ŋ" 2)

    ;; b,g > m,ŋ \ _n -- Rix §105
    (s "bn" "mn")
    (s "gn" "ŋn")

    ;;; Palatale ŕŕ ĺĺ ńń -- Rix §70
    ; TODO: Datierung? wohl nach myk.
    (s "(a|o)(['~]?)(ŕŕ|ńń)" 1 2 "y" (depala 3))
    `(sub (kypr) (,(s "a(['~]?)ĺĺ" "a" 1 "yl")))
    (s "ĺĺ" "ll")
    `(sub (thess lesb) (,(s "(ŕŕ|ńń)" (depala 1) (depala 1))))

    ;;; 1. Ersatzdehnung/Gemination
    ;; Palataldehnung
    (s "(e|i|u)(['~]?)(ŕŕ|ńń)" (dehnung2 1) 2 (depala 3))
    ;; Rh/hR-Dehnung
    `(sub (not thess lesb) (,(s "(<vok>)(['~]?)(<res>|w)h(<vok>)"
                                (dehnung2 1) 2 3 4)
                            ,(s "(<vok>)(['~]?)h(<res>|w)(<vok>)"
                                (dehnung2 1) 2 3 4)))
    ;; ln-Dehnung
    `(sub (not thess lesb) (,(s "(<vok>)(['~]?)ln(<vok>)" (dehnung2 1) 2 "l" 3)))
    (s "(<vok>)(['~]?)ln(<vok>)" 1 2 "ll" 3)
    ;; 7 vs. 5 Langvokale
    `(sub (not ion-att nwdor sardor) (,(s "Ē" "ē")
                                      ,(s "Ō" "ō")))

    ;; ws > wh
    ; TODO: dialektal rs > rh (oder später rs > rr ?)
    (s "(<vok>)(['~])(w)s(<vok>)" 1 2 3 "h" 4)

    ;; Gemination und Hauchumsprung
    (s "^(<vok>)(['~]?)h(<vok>)([^'~])" "h" 1 2 3 4)
    (s "^(<vok>)(['~]?)(<res>|w)h" "h" 1 2 3 "h")
    (s "(<kons>)h(<kons>)" 1 2)
    ; TODO: prohorā aspirieren
    (s "(<vok>)(['~]?)h(<vok>)" 1 2 3)
    (s "(<vok>)(['~]?)(<res>|w)h(<vok>)" 1 2 3 3 4)
    (s "(<vok>)(['~]?)h(<res>|w)(<vok>)" 1 2 3 3 4)

    ;;; Cts > Cs (TODO: alle Konsonanten? Halbvokale/Diphthonge?)
    (s "(<kons>)ts" 1 "s")
    ;;; ts > ss/tt -- Rix §102,87
    `(sub (boiot kret) (,(s "ts" "tt")))
    (s "ts" "ss")
    ; ss > s nach Langvokal oder Diphthong
    (s "(<vok>)(['~]?)(y|w)ss" 1 2 3 "s")
    (s "(<lang-vok>)(['~]?)ss" 1 2 "s")
    `(sub (ion-att ark) (,(s "ss" "s")))

    ;;; dz -- Rix §102
    `(sub (boiot kret lak el) (,(s "sd" "dd")))
    (s "^dd" "d")


    ;;; ion. ā > ǣ
    `(sub (ion-att) (,(s "ā" "Ā")))

    ;;; 2. Ersatzdehnung/Diphthongierung
    ;; TODO: bei allen Vokale gleich? (nicht im kyrenischen)
    ;; VnsV
    ;; TODO: dialekte? sardor, arg, achaisch?
    `(sub (lesb) (,(s "(<vok>)(['~]?)ns(<vok>)" 1 2 "ys" 3)))
    `(sub (ion-att boiot el lak inseldor kypr)
          (,(s "(<vok>)(['~]?)ns(<vok>)" (dehnung2 1) 2 "s" 3)))
    ;; Vns#
    `(sub (lesb el) (,(s "(<vok>)(['~]?)ns$" 1 2 "ys")))
    `(sub (ion-att boiot lak inseldor)
          (,(s "(<vok>)(['~]?)ns$" (dehnung2 1) 2 "s")))
    ;; Vokaleinreihung
    ;; TODO: dialekte? inseldorisch einteilung (ost west)? thera?
    `(sub (not ion-att nwdor inseldor) (,(s "Ē" "ē")
                                        ,(s "Ō" "ō")))


    ;;; w -- Teil 1
    ;; TODO: dialekte
    `(sub (ion-att) (,(s "^hw" "h")
                     ,(s "^w(<vok>)" 1)
                     ,(s "^wr" "hr")
                     ,(s "(<vok>)(['~]?)w(<vok>)" 1 2 3)))

    ;;; hR-
    ;; TODO: dialekte
    `(sub (ion-att) (,(s "^h(l|m|n)" 1)))

    ;;; att. ǣ > ā \ eir_
    `(sub (att) (,(s "(((e|ē|Ē|i|ī)(['~]?))|r)Ā" 1 "ā")))


    ;;; 3. Ersatzdehnung/Schwund
    ;; TODO: dialekte nach Rix §72; Bartoněk?
    `(sub (ion inseldor kret) (,(s "(^|(<vok>)(['~]?))(r|l|n|d|s)w" (dehnung2 1) 4)))
    `(sub (ion-att lesb lak) (,(s "(r|l|n|d|s)w" 1)))
    ;; TODO: dialekte?
    `(sub (not ion-att nwdor sardor) (,(s "Ē" "ē")
                                      ,(s "Ō" "ō")))


    `(sub (att euboi boiot kret) (,(s "tš" "tt")))
    (s "^tt" "t")
    (s "tš" "ss")
    (s "^ss" "s")

    `(sub (ion-att) (,(s "Ā" "ē")))

    ;;; Psilose -- Rix §68
    `(sub (lesb ion el kret) (,(s "h")))
    ))

