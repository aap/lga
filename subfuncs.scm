;;;;
;;;; functions that transform submatches
;;;;

;; applies list of rules to the submatch i in a match
(define (match-rulelist rules)
  (lambda (i)
    (lambda (match)
      (let ((m (or (irregex-match-substring match i)
                   "")))
        (apply-rules rules m)))))

(define (match-do f)
  (lambda (i)
    (lambda (match)
      (let ((m (irregex-match-substring match i)))
        (f m)))))

(define match-print
  (match-do
    (lambda (s)
      (display "   ")
      (display s)
      (newline)
      s)))

(define laryngal->vokal
  (match-rulelist
    (list (s "H1" "e")
          (s "H2" "a")
          (s "H3" "o")
          (s "H" "a"))))

(define laryngal->langvokal
  (match-rulelist
    (list (s "H1" "ē")
          (s "H2" "ā")
          (s "H3" "ō")
          (s "H" "ā"))))

(define dehnung
  (match-rulelist
    (list (s "a" "ā")
          (s "e" "ē")
          (s "o" "ō")
          (s "i" "ī")
          (s "u" "ū"))))

(define dehnung2
  (match-rulelist
    (list (s "a" "ā")
          (s "e" "Ē")
          (s "o" "Ō")
          (s "i" "ī")
          (s "u" "ū"))))

(define kuerzung
  (match-rulelist
    (list (s "ā" "a")
          (s "ē|Ē" "e")
          (s "ō|Ō" "o")
          (s "ī" "i")
          (s "ū" "u"))))

(define dental->retroflex
  (match-rulelist
    (list (s "t" "ṭ")
          (s "d" "ḍ"))))

(define palatal->velar
  (match-rulelist
    (list (s "č" "k")
          (s "ǰ" "g"))))

(define labiovelar->velar
  (match-rulelist
    (list (s "K" "k")
          (s "G" "g"))))

(define velar->labiovelar
  (match-rulelist
    (list (s "k" "K")
          (s "g" "G"))))

(define sonans->consonans
  (match-rulelist
    (list (s "i" "y")
          (s "u" "w")
          (s "R" "r")
          (s "L" "l")
          (s "N" "n")
          (s "M" "m"))))

(define consonans->sonans
  (match-rulelist
    (list (s "y" "i")
          (s "w" "u")
          (s "r" "R")
          (s "l" "L")
          (s "n" "N")
          (s "m" "M"))))

(define stimmhaft
  (match-rulelist
    (list (s "K" "G")
          (s "k" "g")
          (s "č" "ǰ")
          (s "c" "j")
          (s "t" "d")
          (s "ṭ" "ḍ")
          (s "p" "b")
          (s "s" "z")
          (s "š" "ž"))))

(define stimmlos
  (match-rulelist
    (list (s "G" "K")
          (s "g" "k")
          (s "ǰ" "č")
          (s "j" "c")
          (s "d" "t")
          (s "ḍ" "ṭ")
          (s "b" "p")
          (s "z" "s")
          (s "ž" "š"))))

(define ->F
  (match-rulelist
    (list (s "k(!?)" "χ")
          (s "g(!?)" "γ")
          (s "t(!?)" "θ")
          (s "d(!?)" "δ")
          (s "p(!?)" "f")
          (s "b(!?)" "β"))))

(define depala
  (match-rulelist
    (list (s "ŕŕ" "r")
          (s "ĺĺ" "l")
          (s "ńń" "n"))))

(define ->A
  (match-rulelist
    (list (s "(!|$)" "!"))))

(define ->!A
  (match-rulelist
    (list (s "!"))))

(define ->M
  (match-rulelist
    (list (s "(.*)" (->!A 1))
          (s "(.*)" (stimmhaft 1)))))

(define ->MA
  (match-rulelist
    (list (s "(.*)" (->A 1))
          (s "(.*)" (stimmhaft 1)))))

(define ->T
  (match-rulelist
    (list (s "(.*)" (->!A 1))
          (s "(.*)" (stimmlos 1)))))

(define ->TA
  (match-rulelist
    (list (s "(.*)" (->A 1))
          (s "(.*)" (stimmlos 1)))))

