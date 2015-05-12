(load "main.scm")

(define run
  (lambda () (load "run.scm")))

(define (run-test)
  (run-list 'uridg 'urgr (list
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
;(run-test) (newline)

(define (run-2ed dest)
  (print "  " (symbol->string dest))
  (run-list 'urgr1 dest (list
    "-ánti̯a"
    "-ónti̯a"
    "-énti̯a"
    "-áns"
    "-óns"
    "-éns"
    ))
  (newline))
(run-2ed 'urgr)
(run-2ed 'lesb)
(run-2ed 'thess)
(run-2ed 'boiot)
(run-2ed 'ion)
(run-2ed 'el)
(run-2ed 'ark)
(run-2ed 'kret)
(run-2ed 'inseldor)

(define (run-wau dest)
  (print "  " (symbol->string dest))
  (run-list 'urgr1 dest (list
    "kalu̯ós"
    "ksénu̯os"
    "kórwā"
    "néwā"
    "kʰṓrā"
    ))
  (newline))
;(run-wau 'att)
;(run-wau 'ion)
;(run-wau 'inseldor)
;(run-wau 'kret)
;(run-wau 'el)
;(run-wau 'kor)
;(run-wau 'ark)
;(run-wau 'boiot)
;(run-wau 'lesb)

(define (run-1ed dest)
  (print "  " (symbol->string dest))
  (run-list 'urgr1 dest (list
    "korsā́"
    "akou̯sā́"
    "au̯sṓs"
    "ou̯satós"
    "kórsā"
    "akóu̯sō"
    "éu̯sō"
    "kʰésras"
    " selásnā"
    "kʰánsas"
    "énemsa"
    "kʷélson"
    "nasu̯ós"
    ))
  (newline))
;(run-1ed 'urgr)
;(run-1ed 'att)
;(run-1ed 'kret)
;(run-1ed 'lesb)

(define (run-pala dest)
  (print "  " (symbol->string dest))
  (run-list 'uridg dest (list
    "gʷm̥i̯oh₂"
    "komi̯os"
    "ali̯os"
    ))
  (run-list 'urgr1 dest (list
    "katʰari̯ō"
    "pʰtʰeri̯ō"
    "oi̯ktiri̯ō"
    "kteni̯ō"
    "krini̯ō"
    "pluni̯ō"
    ))
  (newline))
;(run-pala 'ion-att)
;(run-pala 'kypr)
;(run-pala 'thess)
;(run-pala 'boiot)

(define (run-myk)
  (let ((dest 'ion-att))
    (run-list 'uridg dest (list
      "Hi̯os"
      "trei̯es"
      "dh₃tis"
      "di̯ḗu̯s"
      "di̯ḗm"
      "toti̯os"
      "medʰi̯os"
      "podsi"
      ))
    (run-list 'urgr dest (list
      "pantsa"
      ))))
;(run-myk)

(define run-gr
  (lambda ()
    (run-list 'uridg 'urgr (list
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

(define (run-gr-test)
  (run-list 'uridg 'urgr (list
    "ai̯gkʷolos"
    "h₁ék̑u̯os"
    )))
;(run-gr-test)

(define (run-gr-s)
  (run-list 'uridg 'urgr (list
    "pn̥dʰskoh₂"
    "dikskos"
    "legʰskeh₂"
    "migskoh₂"
    "u̯oidtʰh₂e"
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
    )))
;(run-gr-s)

(define run-test
  (lambda ()
    (run-list 'uridg 'ved (list
      "-ak̑da-"
      "-ak̑d"
      "-ak̑ta-"
      "-ak̑t"
      "-ak̑dʰa-"
      "-ak̑dʰ"
      "-ak̑tʰa-"
      "-ak̑tʰ"
      "-ag̑da-"
      "-ag̑d"
      "-ag̑ta-"
      "-ag̑t"
      "-ag̑dʰa-"
      "-ag̑dʰ"
      "-ag̑tʰa-"
      "-ag̑tʰ"
      "-ag̑ʰda-"
      "-ag̑ʰd"
      "-ag̑ʰta-"
      "-ag̑ʰt"
      "-ag̑ʰdʰa-"
      "-ag̑ʰdʰ"
      "-ag̑ʰtʰa-"
      "-ag̑ʰtʰ"
      ""
      "-aksa-"
      "-aks"
      "-agsa-"
      "-ags"
      "-agʰsa-"
      "-agʰs"
      "-ak̑sa-"
      "-ak̑s"
      "-ag̑sa-"
      "-ag̑s"
      "-ag̑ʰsa-"
      "-ag̑ʰs"
      ""
      "-aksta-"
      "-akst"
      "-agsta-"
      "-agst"
      "-agʰsta-"
      "-agʰst"
      "-ak̑sta-"
      "-ak̑st"
      "-ag̑sta-"
      "-ag̑st"
      "-ag̑ʰsta-"
      "-ag̑ʰst"
      ""
      "-ask̑a-"
      "-ask̑"
      ""
      "-assa-"
      "-ass"
      "-atsa-"
      "-ats"
      "-ista-"
      "-ist"
      "-issa-"
      "-iss"
      ""
      "du̯ei̯sti"
      "du̯ei̯ssi"
      "du̯ei̯smi"
      "adu̯ei̯st"
      "adu̯ei̯ss"
      "adu̯ei̯sm̥"
      "eHi̯āg̑st"
      "eHi̯ag̑sta"
      "u̯ék̑ti"
      "ug̑ʰtós"
      ))))
;(run-test)

(define run-av
  (lambda ()
    (run-list 'uridg 'urav (list
      "kok̑so-"
      "kr̥tá-"
      "poti-"
      "krátu-"
      "u̯oktro-"
      "tu̯ām"
      "méntro-"
      "sn̥ti̯o-"))))
;(run-av)

(define run-ved
  (lambda ()
    (run-list 'uridg 'ved (list
      "bʰeu̯dʰsi̯eti"
      "upopdós"
      "nigʷtós"
      "bʰn̥dʰtós "
      "bʰéreti"
      "bʰéromes"
      "bʰéronti"
      "g̑ómbʰos"
      "kʷekʷórh₂e"
      "kʷekʷóre"
      "g̑ónh₁os"
      "h₃rḗg̑-"
      "Hi̯ág̑etoi̯"
      "kʷṓk̑ei̯eti"
      "h₁éi̯ti"
      "tréi̯es"
      "élēi̯kʷsm̥"
      "u̯ĺ̥kʷōi̯s"
      "néu̯i̯os"
      "h₃éu̯is"
      "i̯ugóm"
      "su̯ek̑rúHs"
      "dʰuh₂mós"
      "gʷm̥tis"
      "mn̥tís"
      "mn̥i̯étoi̯"
      "g̑n̥h₁tós"
      "k̑m̥h₂tós"
      "linékʷti"
      "pl̥h₁nós"
      "h₂énh₁ti"
      "h₂u̯ḗn̥tos"
      "mléu̯h₂ti"
      "pn̥th₂és"
      "meg̑h₂és"
      "u̯isóm"
      "misdʰós"
      "nisdós"
      "tisrós"
      "tisth₂eti"
      "k̑þi̯eh₂inós"
      "g̑ʰþi̯és"
      "dʰéu̯gʰti"
      "dʰéu̯gʰsi"
      "dʰéu̯gʰmi"
      "dʰugʰmés"
      "dʰugʰth₃é"
      "dʰugʰénti"
      "léi̯g̑ʰmi"
      "léi̯g̑ʰsi"
      "léi̯g̑ʰti"
      "lig̑ʰmés"
      "lig̑ʰth₂é"
      "lig̑ʰénti"
      "gʷʰénti"
      "gʷʰnénti"
      "k̑m̥tóm"
      "gʷóh₃us"
      "gʷh₃éu̯s"
      "gʷh₃éu̯ei̯"
      "sekʷh₂ō"
      "kʷe"
      "h₁esmi"
      "h₁esi"
      "h₁esti"
      "h₁smés"
      "h₁sénti"
      "gʷm̥sk̑eti"
      "sk̑eh₁i̯eh₂"
      "ok̑tṓ"
      "eHi̯āg̑st"
      "eHi̯ag̑sta"
      "u̯ék̑ti"
      "ug̑ʰtós"
      ))))
;(run-ved)
