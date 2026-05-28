(load "main.scm")

(define (run)
  (load "run-auslaut.scm"))

(define (run-test dest)
  (print "  " (symbol->string dest))
  (print (run-list 'urgerm1 dest (list
	"-ō"
	"-ōs"
	"-ōses"
	"-ōns"
	"-ōm"
	"-ōam"
	"-ōt"
	"-as"
	"-jas"
	"-iyas"
	"-ans"
	"-am"
	"-anam"
	"-aas"
	"-asa"
	"-esa"
	"-eyam"

	"-eyes"
	"-ins"
	"-ewes"
	"-uns"

	"-ē"
	"-ēN"
	"-ēt"
	"-ēs"

	"-ay"
	"-ayt"
	"-ays"

	"-ēy"
	"-ōy"
	"-ēw"
	"-ōw"
    ))))
(run-test 'urgerm)
(run-test 'got)
(run-test 'wgerm)
(run-test 'ahd)
(run-test 'as)
(run-test 'ae)

(define (run-vowels dest)
  (print "  " (symbol->string dest))
  (print (run-list 'urgerm1 dest (list
	"-a"
	"-e"
	"-i"
	"-u"
	"-ē"
	"-ī"
	"-ō"
	"-ū"
))))
;(run-vowels 'urgerm)
;(run-vowels 'got)
;(run-vowels 'wgerm)

