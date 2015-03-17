(define match-rulelist
  (lambda (rules)
    (lambda (i)
      (lambda (match)
        (let ((m (or (irregex-match-substring match i)
                     "")))
          (apply-rules rules m))))))

(define match-do
  (lambda (f)
    (lambda (i)
      (lambda (match)
        (let ((m (irregex-match-substring match i)))
          (f m))))))

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
    (list (s "k(ʰ?)" "χ")
          (s "g(ʰ?)" "γ")
          (s "t(ʰ?)" "θ")
          (s "d(ʰ?)" "δ")
          (s "p(ʰ?)" "f")
          (s "b(ʰ?)" "β"))))

(define ->A
  (match-rulelist
    (list (s "$" "ʰ"))))

(define ->!A
  (match-rulelist
    (list (s "ʰ"))))

(define ->MA
  (match-rulelist
    (list (s "(.*)" (->A 1))
          (s "(.*)" (stimmhaft 1)))))

