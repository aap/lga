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

    ;;; (H)i̯ im Anlaut -- gegen Rix §68,80e
    (s "^y" "dy")
    (s "^(<lary>)y" "y")

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
    ; Rix §80d, §82c
    (s "(<kons>|^)(<lary>)(<kons>)" 1 (laryngal->vokal 1) 2)
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
    (s "^(<lary>)(<s-res>)" (laryngal->vokal 1) (sonans->consonans 2))
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

    ;; Kw > Kʷ (Beibehaltung des Silbengewichts)
    (s "(<vok>)(['~]?)(<velar>)w" 1 2 (velar->labiovelar 3) (velar->labiovelar 3))
    (s "(<velar>)w" (velar->labiovelar 1))
    (s "(<velar>)(<labiovelar>)" 2 2)

    ;; Beseitigung von Geminaten (αἰπόλος < *ai̯g-kʷolos) -- nicht Rix
    ;; TODO: mehr Laute; möglicherweise nicht nach Kurzvokal
    (s "(<kurz-vok>)(['~]?)(<kons>)" 1 2 3 "#")
    (s "GG" "G") (s "KK" "K") (s "K!K!" "K!")
    (s "gg" "g") (s "kk" "k") (s "k!k!" "k!")
    (s "bb" "b") (s "pp" "p") (s "p!p!" "p!")
    (s "dd" "d") (s "tt" "t") (s "t!t!" "t!")
    (s "#")

    ;;; Okklusive neben s -- Rix §105
    ;; Assimilation über s; Tenuis vor s
    (s "(<media>)s(<tenuis>)([^!])" 1 "s" (stimmhaft 2) 3)
    (s "(<tenuisasp>)s(<tenuis>)([^!])" 1 "s" (->A 2) 3)
    (s "(<okklu>)s" (->T 1) "s")

    ; CsC -- Rix §87c
    ; s zwischen gleichen Konsonanten -- TODO: alle Fälle abgedeckt?
    (s "ks(<velar>)" "s" 1)
    (s "Ks(<labiovelar>)" "s" 1)
    (s "ts(<dental>)" "s" 1)
    (s "ps(<labial>)" "s" 1)
    (s "rsr" "sr") (s "lsl" "sl")

    ; vor s > h und Palatalisierung
    'urgr1

    ;;; s > h
; TODO: formulierung mit vokalen? o_O
    ; s > h \ ($|V)_(V|RV) -- Rix §88,89
    (s "(^|(<vok>)(['~]?))s((<vok>)|(<res>|w)(<vok>))" 1 "h" 4)
    ;; VRsV > VRhV in unbetonten Silben (Datierung?)
    (s "(<vok>)(<res>|w)s(<vok>)" 1 2 "h" 3)
    ;; VNsV > VNhV
    (s "(<vok>)(['~]?)(<nasal>)s(<vok>)" 1 2 3 "h" 4)

    ;; ab hier substrat-s

    ; sy,ys > yy -- Rix §89g, Lejeune §127
    ; TODO: Datierung
    ;       was neben Konsonant (Csy)? vermutlich verlust
    ;       was im Anlaut sy- (ὑμήν)
    (s "(<vok>)(['~]?)sy" 1 2 "yy")
    (s "^sy" "y")
    ; TODO: beispiele (-oi̯si > myk. -o-i)
    (s "ys(<vok>)" "yy" 1)

    ;;; Osthoff -- Rix §58,64
    ; Wohl nach *ns > *nh wegen μηνός < *mēnsós und
    ;      vor Verlust von Okklusiven im Auslaut
    ; *nh (und *nm, *u̯i̯?) nicht betroffen
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
    (s "(d|g)y" "dž")   ; ǰ
    (s "(k!|k)y" "tš")  ; č
    (s "(<labial>)y" "pč")

    ;;; TODO: Umgebung. nach Langvokal, Diphthong, Konsonant?
    ;; Datierung evtl. nachmyk. wegen u̯i̯ > ẅẅ nachmyk.
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
    `(sub (aiol) (,(s "ə" "o")))
    (s "ə" "a")

    (s "pč" "pt")

;;    ; WRONG
;;    ; heteromorphemisches ty
;;    (s "(t!|t)y" "ts")

    (s "^y(<vok>)" "h" 1)
    (s "(<vok>)(['~]?)y(<vok>)" 1 2 "h" 3)

    ;;
    ;; Mykenisch
    ;;
    'myk

    (s "dž" "ds")

    `(sub (el) (,(s "ē" "Ā")))

    ;;; Labiovelare > T/P -- Rix §96-99
    `(sub (not aiol) (,(s "K(i|ī)" "t" 1)))
    `(sub (not kypr aiol) (,(s "(<labiovelar>)(e|ē)" (labiovelar->dental 1) 2)))
    (s "(<labiovelar>)" (labiovelar->labial 1))
    ;; Assimilationen an Labiovelarreflexe
    (s "(<nasal>)(<labial>)" "m" 2)
    (s "(<nasal>)(<dental>)" "n" 2)
    (s "(<nasal>)(<velar>)" "ŋ" 2)

    ;; b,g > m,ŋ \ _n -- Rix §105
    (s "bn" "mn")
    (s "gn" "ŋn")

    ;;;; ca. 1000

    ;;; tw -- Rix §104
    `(sub (not kret) (,(s "^tw" "s")))
    (s "(.)tw" 1 "tš")
    ;;; tʰw -- unklar, aber vgl. -σθε ai. -dhvam
    ;(s "^t!w" "t!")
    (s "(.)t!w" 1 "st!")

    ;;; ds > sd
    ; vor CsC > ChC wegen ἔρδω < *u̯erzdō < *u̯erg̑i̯e/o-
    (s "ds" "sd")

    ;;; (N|T)sC > sC -- Rix §87c, Lejeune §134
    ; vor CsC > ChC wegen ἴσος < u̯idsu̯os und δεσπότης < *demspot-
    ; nach dz > zd wegen σύζυγος < *sun-dzugos
    (s "(<nasal>|<dental>)s(<kons>)" "s" 2)

    ;;; CsC -- Rix §87c, Lejeune §132-133
    ; TODO: πασταδ-/παρταδ- < parstad-
    ;       θύσθεν < *tʰurstʰen
    (s "(<res-yw>)s(<tenuis>|<tenuisasp>)" 1 "#s" 2)
    (s "(<kons>)s(<kons>)" 1 "h" 2)
    (s "(<tenuis>)h" (->A 1))
    (s "(<tenuisasp>)(<tenuis>)([^!])" 1 (->A 2) 3)
    (s "(<tenuisasp>)(<media>)([^!])" (->M 1) 2 3)
    (s "#")

    ;;; u̯i̯ > ẅẅ -- Rix §73
    ; Datierung? nach ChC > CC? das aber später und auch keine gute lösung
    (s "wy" "ẅẅ")

    ;;; Palatale ŕŕ ĺĺ ńń -- Rix §70
    ; TODO: Datierung? wohl nach myk.
    (s "(a|o)(['~]?)(ŕŕ|ńń|ẅẅ)" 1 2 "y" (depala 3))
    `(sub (kypr) (,(s "a(['~]?)ĺĺ" "a" 1 "yl")))
    (s "ĺĺ" "ll")
    `(sub (thess lesb) (,(s "(ŕŕ|ńń)" (depala 1) (depala 1))))

    ;;; 1. Ersatzdehnung/Gemination
    ;; Palataldehnung
    (s "(e|i|u)(['~]?)(ŕŕ|ńń|ẅẅ)" (dehnung2 1) 2 (depala 3))
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
;    (s "(<kons>)h(<kons>)" 1 2)
    ; TODO: prohorā aspirieren
;    (s "(<vok>)(['~]?)h(<vok>)" 1 2 3)
    (s "(<vok>)(['~]?)(<res>|w)h(<vok>)" 1 2 3 3 4)
    (s "(<vok>)(['~]?)h(<res>|w)(<vok>)" 1 2 3 3 4)
    (s "(.)h" 1)

    ;;; Cts > Cs (TODO: alle Konsonanten? Halbvokale/Diphthonge?)
; TODO: schließt noch Diphthonge ein!
    (s "(<kons>)ts" 1 "s")
    ;;; ts > ss/tt -- Rix §102,87
    `(sub (boiot kret) (,(s "ts" "tt")))
    (s "ts" "ss")
    ; ss > s nach Langvokal
    (s "(<lang-vok>)(['~]?)ss" 1 2 "s")
    `(sub (ion-att ark) (,(s "ss" "s")))

    ;;; ds -- Rix §102
    `(sub (boiot kret lak el) (,(s "sd" "dd")))
    (s "^dd" "d")

    ;;;; ca. 900

    ;;; ion. ā > ǣ
    `(sub (ion-att) (,(s "ā" "Ā")))

    ;;;; ca. 800

    ;;; 2. Ersatzdehnung/Diphthongierung
    ;; TODO: bei allen Vokale gleich? (nicht im kyrenischen)
    ;; VnsV
    ;; TODO: dialekte? sardor, arg, achaisch?
    `(sub (lesb) (,(s "(<vok>)(['~]?)ns(<vok>)" 1 2 "ys" 3)))
    `(sub (ion-att boiot el lak inseldor kypr)
          (,(s "(<vok>)(['~]?)ns(<vok>)" (dehnung2 1) 2 "s" 3)))
    ;; Vns$
    `(sub (lesb el) (,(s "(<vok>)(['~]?)ns$" 1 2 "ys")))
    `(sub (ion-att boiot lak inseldor)
          (,(s "(<vok>)(['~]?)ns$" (dehnung2 1) 2 "s")))
    ;; Vokaleinreihung
    ;; TODO: dialekte? inseldorisch einteilung (ost west)? thera?
    `(sub (not ion-att nwdor inseldor) (,(s "Ē" "ē")
                                        ,(s "Ō" "ō")))


    ;;; ältere Kontraktionen, TODO: datieren
    ; a,ā + e
    `(sub (ion-att) (,(s "(a|ā)'e" "ā~")
                     ,(s "(a|ā)e" "ā")))
    (s "(a|ā)'e" "ē~")
    (s "(a|ā)e" "ē")
    ; a+O
    (s "a'(o|ō|Ō)" "ō~")
    (s "a(o|ō|Ō)" "ō")
    ; att. a+e
    `(sub (att) (,(s "e'a" "ē~")
                 ,(s "ea" "ē")))
    ; att. e+o,ō
    `(sub (att) (,(s "e'o" "Ō~")
                 ,(s "e'ō" "ō~")
                 ,(s "eo([^'])" "Ō" 1)
                 ,(s "eō([^'])" "ō" 1)))
    ; e + ē
    (s "e'ē" "ē~")
    (s "eē" "ē")

    ;;; w > 0
    ; TODO: dialekte. vieles unklar
    ; V_V früh -- Buck §53
    `(sub (ion-att inseldor lesb kret ark) (,(s "(<vok>)(['~]?)w(<vok>)" 1 2 3)))
    ; _V später (TODO: wann > h?)
    `(sub (ion-att inseldor lesb) (,(s "^w(<vok>)(['~]?)s" "h" 1 2 "s")
                                   ,(s "^w(<vok>)" 1)
                                   ,(s "(<vok>)(['~]?)yw(<vok>)" 1 2 "yy" 3)
                                   ,(s "^hw" "h")))
    `(sub (ion-att inseldor) (,(s "^wr" "hr")))

    ;;; hR-
    ;; TODO: dialekte
    `(sub (ion-att) (,(s "^h(l|m|n)" 1)))

    ;;; att. ǣ > ā \ eir_
    `(sub (att) (,(s "(((e|ē|Ē|i|ī)(['~]?))|r|y)Ā" 1 "ā")))

    ;;;; ca. 700

    ;;; 3. Ersatzdehnung/Schwund; e+e, o+o Kontraktion
    ;; TODO: dialekte nach Rix §72; Bartoněk, Buck?
    ; [wo]arg?
    ; sw kret. erhalten
    `(sub (inselion ostion inseldor kret) (,(s "(^|(<vok>)(['~]?))(r|l|n|d|s)w" (dehnung2 1) 4)))
    `(sub (ion-att lesb lak) (,(s "(r|l|n|d|s)w" 1)))
    ; Kontraktion
    (s "e'e" "Ē~")
    (s "ee" "Ē")
    ; TODO: oe nicht in allen Dialekten
    (s "o'(o|e)" "Ō~")
    (s "o(o|e)" "Ō")
    ;; TODO: dialekte?
    `(sub (not ion-att nwdor sardor) (,(s "Ē" "ē")
                                      ,(s "Ō" "ō")))


    `(sub (att euboi boiot kret) (,(s "tš" "tt")))
    (s "^tt" "t")
    (s "tš" "ss")
    (s "^ss" "s")

    ;;; Psilose -- Rix §68
    `(sub (el lesb ostion inselion kret) (,(s "h")))

    ;;;; ca. homerisch; Sprachstufe der ionischen Archaismen
    'hom

    ; TODO: datierung? dialekte?
    `(sub (not el inselion) (,(s "Ā" "ē")))

    ;;; jüngere Kontraktionen; teilweise nach Einsetzen der Überlieferung
    ; o + a > ō (nach w > 0)
    (s "o'a" "ō~")
    (s "oa" "ō")
    ; ē + o,ō; TODO: genauere Bedinungen
    `(sub (att) (,(s "ē'ō" "ō~")))
    (s "ē(['~]?)(o|ō)" "e" (->acute 1) "ō")
    ; e + ē (nach ion. ā > ē)
    (s "e'ē" "ē~")
    (s "eē" "ē")
    ; ā + o,ō; TODO: datierung? dialekte (aiol, hom)?
    `(sub (dor) (,(s "ā(['~])ō" "ā~")
                 ,(s "āō" "ā")))
    `(sub (dor) (,(s "ā(['~])o" "ā~")
                 ,(s "(['~])(.*)āo" 1 2 "ā")
                 ,(s "āo([^'])" "ā" 1)))

    ))

