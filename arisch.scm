(define rules-urar '())

(let* (
  (rules-uria (list
    (s "R('?)(<vok>)" "I" 1 "r" 2)
    (s "ṝ('?)" "Ī" 1 "r")
    (s "ã('?)" "ā" 1 "m")
    (s "(<labial>|m)I" 1 "u")
    (s "I" 1 "i")
    (s "(<labial>|m)Ī" 1 "ū")
    (s "Ī" 1 "ī")
    (s "@" "i")
    (s "ṣ(r|R)" "s" 1)
    ;;; assimilationen (TODO: wann?)
    (s "(<nasal>)(<velar>)" "ṅ" 2)
    (s "(<nasal>)(<palatal2>)" "ñ" 2)
    (s "(<nasal>)(<retroflex>)" "ṇ" 2)
    (s "(<nasal>)(<dental>)" "n" 2)
    (s "(<nasal>)(<labial>)" "m" 2)
    ;;; Sibilanten
    (s "ž" "ẓ")
    (s "š" "ṣ")
    (s "(z|ẓ)ʰ" 1)
    (s "(<okklu>)(<sibil>)(<okklu>)" 1 3)
    ;;; Retroflektierung
    (s "(ṣ|ẓ)(<dental>)" 1 (dental->retroflex 2))
    ;;; Sibilanten 2
    (s "(<palatal>)(<sibil>)" (palatal->velar 1) 2)
    (s "(<velar>)(<sibil>)" "kṣ")
    (s "(<sibil>)(<sibil>)(<kons>)" 2 3)
      ;;; TODO: datierung
    (s "(<labial>)(<sibil>)" "ps")
    (s "(<dental>)(<sibil>)" "ts")
    (s "ẓẓ|ṣṣ" "ṭṣ")
    ;;; Auslautvereinfachung
    (s "ṣṭ$" "ṭ")
    (s "(<res>|<sibil>|<okklu>)(<kons>)*$" 1)
    ;;; Sibilanten 3
    (s "zz|ss" "ts")
    (s "ṭṣ" "kṣ")
    ;;; Palatale
    (s "ǰ" "j")
    (s "čʰ" "cʰ")
    (s "č" "ś")
    (s "jʰ" "h")
    ;;; sk (TODO: wann?)
    (s "(<kurz-vok>)sś" 1 "ccʰ")
    (s "sś" "cʰ")
    ;;; Stimmhafte Sibilanten
    (s "(i|u|y|w)('?)(z|ẓ)" (dehnung 1) 2)
    ;;; TODO: oder o
    (s "a('?)(z|ẓ)" "e" 1)
    'uria
    (s "(a|ā)('?)u" 1 2 "w")
    (s "(a|ā)('?)i" 1 2 "y")
    (s "wy" "WY")
    (s "a('?)y(<kons>|h|$)" "ē" 1 2)
    (s "ā('?)y(<kons>|h|$)" "a" 1 "i" 2)
    (s "a('?)w(<kons>|h|$)" "ō" 1 2)
    (s "ā('?)w(<kons>|h|$)" "a" 1 "u" 2)
    (s "WY" "wy")
    (s "w" "v")
    'ved))

  (rules-urav (list
    ;;; Laryngalvokal
    (s "^(<kons>)*@" 1 "i")
    (s "@(<kons>)*$" "i" 1)
    ;;; primäre palatale
    (s "č" "s")
    (s "ǰ" "z")
    ;;; tenuis -> frikativ (auch mehrmals in clustern)
    (s "(<tenuis>)(<kons>)" (->F 1) 2)
    (s "(<tenuis>)(<kons>)" (->F 1) 2)
    (s "(<tenuis>)(<kons>)" (->F 1) 2)
    ;;;
    (s "(<sibil>)(<sibil>)" 2)
    ;;; ə < a
    (s "a('?)(<nasal>)$" "ə" 1 2)
    ;;;
    (s "a('?)w(<kons>|$)" "a" 1 "o" 2)
    (s "a('?)y(<kons>|$)" "a" 1 "ē" 2)
    (s "ā('?)w(<kons>|$)" "ā" 1 "u" 2)
    (s "ā('?)y(<kons>|$)" "ā" 1 "i" 2)
    (s "(.)w" 1 "uu")
    (s "(.)y" 1 "ii")
    (s "w" "v")
    'urav))

  (rules-urir (list
    (s "ã" "ā")
    (s "R('?)(<kons>)" "ə" 1 "r" 2)
    (s "R('?)(<vok>)" "a" 1 "r" 2)
    (s "ṝ('?)" "a" 1 "r")
    (s "ʰ")
    'urir
    `(r (urav) ,rules-urav)))

  (urar (list
    ;;; satem
    (s "K" "k")
    (s "G" "g")
    ;;; Zusammenfall þ und s
    (s "(<velar>|<palatal>)þy" 1 "y")
    (s "þ" "s")
    ;;; H2 aspiration
    (s "(<media>|<tenuis>)(ʰ?)H2" 1 "ʰ")
    ;;; laryngalzusammenfall
    (s "<lary>" "H")
    ;;; Brugmann
    (s "o('?)(<kons>)(<vok>|<s-res>)" "ō" 1 2 3)
    ;;; zusammenfall o und o-gefärbtes e
    (s "O" "o")
    ;;; palatalisierung
    (s "k(ʰ?)(e|ē|i|ī)" "c" 1 2)
    (s "g(ʰ?)(e|ē|i|ī)" "j" 1 2)
    ;;; e,o > a
    (s "e|o" "a")
    (s "ē|ō" "ā")
    ;;; zusammenfall l und r
    (s "l" "r")
    (s "L" "R")
    ;;; BARTHOLOMAE
    (s "(<mediaasp>)(s|z)?(<tenuis>|<media>)(ʰ?)"
       (->!A 1) (stimmhaft 2) (->MA 3))
    (s "(<mediaasp>)(s|z)" (->!A 1) "zʰ")
    ;;; RUKI
    (s "(i|ī|u|ū|y|w|<velar>|<palatal>|r|R)('?)s" 1 2 "š")
    (s "(i|ī|u|ū|y|w|<velar>|<palatal>|r|R)('?)z" 1 2 "ž")
    ;;; Palatale vor Dentalen
    (s "č(<dental>)" "š" 1)
    (s "ǰ(<dental>)" "ž" 1)
    ;;;
    (s "(šs)|(čš)" "šš")
    (s "(žz)|(ǰž)" "žž")
    ;;; nasale
    (s "(N|M)('?)(H?)(<vok>|y|w|m)" "a" 2 (sonans->consonans 1) 4)
    (s "N('?)H(<kons>)" "ā" 1 2)
    (s "M('?)H(<kons>)" "ã" 1 2)
    (s "<s-nasal>('?)(<kons>)" "a" 1 2)
    ;;; R
    (s "R('?)H(<vok>)" "R" 1 2)
    (s "R('?)H(<kons>)" "ṝ" 1 2)
    ;;; laryngalverlust  (wann?)
    (s "(<vok>)('?)(<lary>)(<kons>|$)" (dehnung 1) 2 4)
    (s "^H" "")
    (s "(<kons>)H(<vok>)" 1 2)
    (s "(i|u)H(a|ā)" 1 (sonans->consonans 1) 2)
    (s "(<vok>)('?)H(<vok>)" 1 2 3)
    (s "(<kons>)H(<kons>)" 1 "@" 2)
    'urar
    `(r (uria) ,rules-uria)
    `(r (urir) ,rules-urir))))

  (set! rules-urar urar))

