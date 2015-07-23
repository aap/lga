(load "main.scm")

(define run
  (lambda () (load "run-gr.scm")))

(define (run-contr dest)
  (print "  " (symbol->string dest))
  (print (run-list 'urgr1 dest (list
    "enīkae"
    "nīkáei̯"
    "tīmáomen"
    " ́-āo"
    "i̯ā~u̯os"
    "lāu̯ós"
    "nasu̯ós"
    "au̯sṓs"
    "lāu̯okrínēs"
    "-ā́sōm"
    "tʰeāu̯ōrós"
    "potei̯dā́u̯ōn"
    "koināu̯ṓn"
    "u̯étesa"
    "kréu̯as"
    "-éās"
    "génesos"
    "tʰesós"
    "su̯ādéu̯os"
    "pʰiléi̯ō nt i"
    "pʰiléi̯oi̯"
    "-ē~os"
    "hikʷkʷóu̯anaks"
    )))
  (newline))
;(run-contr 'att)
;(run-contr 'ostion)
;(run-contr 'hom)
;(run-contr 'lesb)
;(run-contr 'boiot)
;(run-contr 'kret)

(define (run-misc dest)
  (print "  " (symbol->string dest))
  (print (run-list 'uridg dest (list
;    "u̯eu̯r̥h₁mh₁nos"
;    "u̯r̥h₁mn̥"
;    "h₂ensíi̯eh₂"
    "demspot-"
    "u̯idsu̯os"
    "orsmā́"
    "h₂eu̯sriom"
    "u̯erg̑i̯oh₂"
    "ph₂n̥tih₂"
    "kʷelesi̯etai̯"
    "gelosi̯os"
    )))
  (print (run-list 'urgr1 dest (list
    "plangi̯ō"
    "si̯umēn"
    )))
  (print (run-list 'urgr dest (list
    "sundžugos"
    )))
  (newline))
;(run-misc 'urgr)
;(run-misc 'att)
;(run-misc 'oarg)

(define (run-y dest)
  (print "  " (symbol->string dest))
  (print (togrk (run-list 'urgr1 dest (list
    "káu̯i̯ō"
    "au̯i̯etós"
    "glukéu̯i̯a"
    "eu̯réu̯i̯a"
    "díu̯i̯os"
    "élai̯u̯om"
    "elái̯u̯ā"
    "ai̯u̯ési"
    "pói̯u̯ā"
    ))))
  (newline))
;(run-y 'urgr)
;(run-y 'att)
;(run-y 'lesb)

(define (run-labvel dest)
  (print "  " (symbol->string dest))
  (print (run-list 'uridg dest (list
    "kʷis"
    "kʷe"
    "kʷidkʷe"
    "gʷou̯kʷolos"
    "gʷih₃os"
    "h₁ln̥gʰus"
    "kʷukʷlos"
    "penkʷe"
    "gʷelbʰus"
    "gʷʰeni̯oh₂"
    "gʷʰonos"
    "gʷm̥i̯oh₂"
    "kʷoineh₂"
    "kʷinu̯oh₂"
    "snigʷʰm̥"
    "ogʷʰis"
    "penkʷtos"
    "kʷl̥Him"
    "-gʷʰnet"
    "sens"
    )))
  (newline))
;(run-labvel 'urgr1)
;(run-labvel 'urgr)
;(run-labvel 'att)
;(run-labvel 'lesb)
;(run-labvel 'ark)

(define (run-ky dest)
  (print "  " (symbol->string dest))
  (print (run-list 'urgr1 dest (list
    "ki̯ā́meron"
    "pʰuláki̯ō"
    "glṓki̯a"
    "tu̯éi̯sō"
    "tʰu̯ari̯ós"
    )))
  (print (run-list 'uridg dest (list
    "kʷétu̯r̥es"
    "-dʰu̯e"
    )))
  (newline))
;(run-ky 'ostion)
;(run-ky 'euboi)
;(run-ky 'att)
;(run-ky 'boiot)
;(run-ky 'kret)
;(run-ky 'sdor)

(define (run-s-test dest)
  (print "  " (symbol->string dest))
  (print (run-list 'urgr1 dest (list
    "asa"
    "a'sa"
    "asra"
    "a'sra"
    "asla"
    "a'sla"
    "asma"
    "a'sma"
    "asna"
    "a'sna"
    "aswa"
    "a'swa"
    "sa"
    "sra"
    "sla"
    "sma"
    "sna"
    "swa"
    )))
  (newline))
;(run-s-test 'urgr)
;(run-s-test 'att)

(define (run-2ed dest)
  (print "  " (symbol->string dest))
  (print (run-list 'urgr1 dest (list
    "-ánti̯a"
    "-ónti̯a"
    "-énti̯a"
    "-áns"
    "-óns"
    "-éns"
    )))
  (newline))
;(run-2ed 'urgr)
;(run-2ed 'lesb)
;(run-2ed 'thess)
;(run-2ed 'boiot)
;(run-2ed 'ostion)
;(run-2ed 'el)
;(run-2ed 'ark)
;(run-2ed 'kret)
;(run-2ed 'inseldor)

(define (run-wau dest)
  (print "  " (symbol->string dest))
  (print (run-list 'urgr1 dest (list
    "kalu̯ós"
    "ksénu̯os"
    "kórwā"
    "néwā"
    "kʰṓrā"
    "du̯ei̯nós"
    "dédu̯imen"
    )))
  (newline))
;(run-wau 'att)
;(run-wau 'ostion)
;(run-wau 'inseldor)
;(run-wau 'kret)
;(run-wau 'el)
;(run-wau 'kor)
;(run-wau 'ark)
;(run-wau 'boiot)
;(run-wau 'lesb)

(define (run-s dest)
  (print "  " (symbol->string dest))
  (print (run-list 'urgr1 dest (list
    "ploksmós"
    "ekstrós"
    "ai̯ksmā́"
    "persnā́"
    "orsmā́"
    "parstádes"
    "tʰúrstʰen"
    "prosorā́"
    "akóu̯sō"

    "éu̯sō"
    "éserpon"
    "iserós"

    "īsáomai̯"
    "isáni̯ō"
    "esús"
    "īsā́tro-"
    "witswos"
    )))
  (newline))
;(run-s 'urgr)
;(run-s 'att)
;(run-s 'lesb)

(define (run-1ed dest)
  (print "  " (symbol->string dest))
  (print (run-list 'urgr1 dest (list
    "korsā́"
    "akou̯sā́"
    "au̯sṓs"
    "ou̯satós"
    "kórsā"
    "akóu̯sō"
    "éu̯sō"
    "au̯si̯ō"
    "kʰésras"
    " selásnā"
    "kʰánsas"
    "énemsa"
    "kʷélson"
    "nasu̯ós"
    "gʷolnā́"
    "mēnsós"
    "mḗns"
    )))
  (newline))
;(run-1ed 'urgr)
;(run-1ed 'att)
;(run-1ed 'inseldor)
;(run-1ed 'kret)
;(run-1ed 'lesb)

(define (run-pala dest)
  (print "  " (symbol->string dest))
  (print (run-list 'uridg dest (list
    "gʷm̥i̯oh₂"
    "komi̯os"
    "ali̯os"
    )))
  (print (run-list 'urgr1 dest (list
    "katʰari̯ō"
    "pʰtʰeri̯ō"
    "oi̯ktiri̯ō"
    "kteni̯ō"
    "krini̯ō"
    "pluni̯ō"
    )))
  (newline))
;(run-pala 'ion-att)
;(run-pala 'kypr)
;(run-pala 'thess)
;(run-pala 'boiot)

(define (run-myk)
  (let ((dest 'ion-att))
    (print (run-list 'uridg dest (list
      "Hi̯os"
      "trei̯es"
      "dh₃tis"
      "di̯ḗu̯s"
      "di̯ḗm"
      "toti̯os"
      "medʰi̯os"
      "podsi"
      "mr̥tós"
      "h₂n̥rós"
      )))
    (run-list 'urgr dest (list
      "pantsa"
      ))))
;(run-myk)

(define (run-gr)
  (print (run-list 'uridg 'urgr (list
    "k̑r̥d-"
    "gʷr̥Hus"
    "Hi̯ēkʷr̥"
    "pl̥th₂ús"
    "tn̥tos"
    "n̥-"
    "dek̑m̥"
    ""

    "h₁esti"
    "h₂enti"
    "h₃ekʷse-"
    "h₃onkos"
    "h₁ite"
    "h₁urus"
    "h₂ugsontm̥"
    "h₂udei̯e-"
    "h₁r̥sk̑e-"
    "h₃n̥bʰl̥-"
    "h₂u̯eh₁ti"
    "h₁regʷos"
    "h₂nēr"
    "i̯ugóm"
    "i̯eu̯-"
    "pleh₁istom"
    "-eh₂ei̯"
    "deh₃eti"
    "h₂ih₂eu̯s-"
    "h₃bʰruHes"
    "teh₂i̯u-"
    "bʰoh₂neh₂"
    "opih₃kʷeh₂"
    "dʰh₁tos"
    "h₂enh₁mos"
    "dʰh₁s-"
    "ph₂tēr"
    "h₂erh₃trom"
    "dh₃tos"
    ""

    "gʷl̥h₁tos"
    "g̑n̥h₁tos"
    "k̑r̥h₂tos"
    "tl̥h₂tos"
    "str̥h₃tos"
    "n̥h₁gretos"
    "n̥h₂mertēs"
    "n̥h₃bʰeles-"
    "k̑ŕ̥h₂sn-"
    "g̑ń̥h₁tis"
    "stestŕ̥h₃toi̯"
    ""

    "gʷl̥h₁ent"
    "k̑m̥h₂ont"
    "u̯l̥h₃isk̑etoi̯"
    "dʰidʰh₁n̥tés"
    ""

    "septm̥"
    "su̯ek̑uros"
    "sreu̯e-"
    "snei̯gʷʰo-"
    "smer-"
    "smerd-"
    "seg̑ʰoh₂"
    "dek̑siteros"
    "obʰsom"
    "h₁esti"
    "u̯esperos"
    "misdʰos"
    "osdos"
    "migsk̑oh₂"
    ""

    "-os"
    "-om"
    "-osi̯o"
    "-oso"
    "-ōi̯"
    "-oh₁"
    "-oi̯"
    "-ons"
    "-ōn"
    "-ōi̯s"
    "-oi̯si"
    "-eh₂"
    "h₃okʷih₁"
    "trih₂"
    "doruh₂"
    "k̑ŕ̥h₂sn̥h₂"
    "gʷelh₁mn̥h₂"
    ""

    "somh₂os"
    "n̥seh₂u̯n̥tos"
    "égʷeh₂n̥t"
    "Hi̯ugʷih₃ḗs"
    "bʰéroh₂"
    "bʰéronti"
    ""

    "eh₃r̥to"
    "teh₂m̥"
    "eu̯eu̯kʷom"
    "tekþn̥i̯h₂"
    "enemsm̥"
    "demspotis"
    "sedleh₂"
    "tiktoh₂"
    "kʷidkʷe"
    ""
    "i̯ugom"
    ))))
;(run-gr)

(define (run-gr-kw dest)
  (print "  " (symbol->string dest))
  (print (run-list 'uridg dest (list
    "ai̯gkʷólos"
    "h₁ék̑u̯os"
    )))
  (newline))
;(run-gr-kw 'urgr)
;(run-gr-kw 'att)

(define (run-gr-s)
  (print (run-list 'uridg 'att (list
    "au̯si̯ō"
    "psde-"
    "pn̥dʰskoh₂"
    "dikskos"
    "legʰskeh₂"
    "migskoh₂"
    "u̯oi̯dtʰh₂e"  ; lautgesetzlich?
    "u̯iddʰi"
    "parstádes"
    "tʰúrstʰen"
    "bʰte"
    "bte"
    "pte"
    "dʰte"
    "dte"
    "tte"
    "gʷʰte"
    "gʷte"
    "kʷte"
    "gʰte"
    "gte"
    "kte"
    ""

    "bʰdʰe"
    "bdʰe"
    "pdʰe"
    "dʰdʰe"
    "ddʰe"
    "tdʰe"
    "gʷʰdʰe"
    "gʷdʰe"
    "kʷdʰe"
    "gʰdʰe"
    "gdʰe"
    "kdʰe"
    ""

    "bʰde"
    "bde"
    "pde"
    "dʰde"
    "dde"
    "tde"
    "gʷʰde"
    "gʷde"
    "kʷde"
    "gʰde"
    "gde"
    "kde"
    ""

    "kþe"
    "gʰþe"
    "gʷʰþe"
    ""

    "tu̯e-"
    "etu̯e-"
    ))))
(run-gr-s)

