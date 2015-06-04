(load "main.scm")

(define (run)
  (load "run-germ.scm"))

(define (run-germ)
  (print (run-list 'uridg 'urgerm (list
    "ph₂tér"
    "bʰréh₂ter"
    "méh₂ter"
    "bʰéndʰonom"
    ))))
(run-germ)

