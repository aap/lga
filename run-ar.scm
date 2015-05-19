(load "main.scm")

(define run
  (lambda () (load "run-ar.scm")))

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
