;;;;
;;;; main file
;;;;

(require-extension utf8)
(require-extension irregex)
(require-extension srfi-1)

(define s+ string-append)

;;;
;;; assoc lists
;;;

(define sound-classes '())
(define phonological-rules '())
(define prettyprint-rules '())

;;; TODO: clean up the mess
;; Associates a name with a set of sounds
(define (set-class key value)
  (let ((x (assoc key sound-classes)))
    (if x
        (set-cdr! x value)
        (set! sound-classes (cons (cons key value) sound-classes)))))

;; Associates a name with a list of rules to get to phonetic representation
(define (set-phono-rules key value)
  (let ((x (assoc key phonological-rules)))
    (if x
        (set-cdr! x value)
        (set! phonological-rules (cons (cons key value) phonological-rules)))))

;; Associates a name with a list of rules to pretty-print words
(define (set-pretty-rules key value)
  (let ((x (assoc key prettyprint-rules)))
    (if x
        (set-cdr! x value)
        (set! prettyprint-rules (cons (cons key value) prettyprint-rules)))))


(define (lookup key alist)
  (let ((x (assoc key alist)))
    (if x
        (cdr x)
        '())))

(define (l key)
  (lookup key sound-classes))

;;;
;;; tree and rule functions
;;;

;; makes a list of all languages between start and end language based on a tree
(define (make-path tree start end)
  (define (find-start tree)
    (cond ((atom? tree)
           (if (eq? tree start)
               tree
               '()))
          ((eq? (car tree) start)
           tree)
          (else (let loop ((t (cdr tree)))
                  (if (null? t)
                      '()
                      (let ((s (find-start (car t))))
                        (if (null? s)
                            (loop (cdr t))
                            s)))))))
  (define (to-end tree)
    (cond ((atom? tree)
           (if (eq? tree end)
               (cons tree '())
               '()))
          ((eq? (car tree) end)
           (cons end '()))
          (else (let loop ((t tree))
                  (if (null? t)
                      '()
                      (let ((p (to-end (car t))))
                        (if (null? p)
                            (loop (cdr t))
                            (cons (car tree) p))))))))
  (to-end (find-start tree)))

;; make a list of rules that apply to the language development in path
(define (make-rules tree path)
  (define start (car path))
  (define end (car (reverse path)))
  (define (rule-applies? langlist)
    (or (null? langlist)
        (if (equal? (car langlist) 'not)
            (eq? '() (lset-intersection eq? path (cdr langlist)))
            (not (eq? '() (lset-intersection eq? path langlist))))))
  (define (find-start tree)
    (cond ((null? tree)
           '())
          ((eq? (car tree) start)
           (cdr tree))
          ((and (list? (car tree))
                (eq? 'br (caar tree)))
           (let ((l (find-start (caddar tree))))
             (if (null? l)
                 (find-start (cdr tree))
                 l)))
          (else (find-start (cdr tree)))))
  (define (to-end tree)
    (cond ((or (null? tree)
               (eq? (car tree) end))
           '())
          ((procedure? (car tree))
           (cons (car tree) (to-end (cdr tree))))   ; better use tail recursion
          ((and (list? (car tree))
                (rule-applies? (cadar tree)))
           (case (caar tree)
             ((br) (to-end (caddar tree)))
             ((sub) (append (to-end (caddar tree)) (to-end (cdr tree))))
             (else (to-end (cdr tree)))))
          (else (to-end (cdr tree)))))
  (to-end (find-start tree)))

;;;
;;; helper functions
;;;

;; convert list of strings to single string with one original string per line
(define (make-words lst)
  (if (null? lst)
      '()
      (let ((s (make-words (cdr lst))))
        (if (null? s)
            (car lst)
            (s+ (car lst) "\n" s)))))

;; make regex substitute function
(define (s pattern . subst)
  (let ((pat (string->irregex (make-regex pattern) 'utf8 'fast 'm)))
    (lambda (word)
      (apply irregex-replace/all (cons pat (cons word subst))))))

;; compile regex containing custom character classes
(define (make-regex s)
  (let loop ((classes sound-classes)
             (s s))
    (if (null? classes)
        s
        (loop (cdr classes)
              (irregex-replace/all (s+ "<"
                                       (symbol->string (caar classes))
                                       ">")
                                   s
                                   (cdar classes))))))

;; apply a list of rules to a string, return transformed string
(define (apply-rules rules words)
  (if (null? rules)
      words
      (apply-rules (cdr rules)
                   ((car rules) words))))

;; runs 'words' from language 'from' through language 'to'
(define (run-list from to words)
  (let ((r1 (make-rules rules (make-path lang-tree from to)))
        (r2 (lookup from phonological-rules))
        (r3 (lookup to prettyprint-rules)))
    (print (apply-rules r3
                        (apply-rules r1
                                     (apply-rules r2 (make-words words)))))))

;;;
;;; data
;;;

;; tree of languages
;;  an atom is a leaf language
;;  a list's car is a language, the cdr its children
(define lang-tree
  '(uridg (urgr1 (urgr (nwgr (dor (nwdor phok lokr aitol)
                                  (sardor kor meg oarg)
                                  (sdor el lak inseldor warg kret))
                             (aiol boiot (thess wthess othess) lesb))
                       (sogr (ach myk ark kypr pamph)
                             (ion-att ion att euboi))))
          (urar (urir ap
                      (urav aav jav))
                (uria ved))
          urgerm
          ))

;; sound classes
;; TODO: these should be changeable by the rules
(set-class 'kurz-vok "e|E|o|O|a|A|i|u|ə")
(set-class 'lang-vok "ē|Ē|ō|Ō|ā|Ā|ī|ū")
(set-class 'vok (s+ (l 'kurz-vok) "|" (l 'lang-vok)))
(set-class 'liquid "r|ŕ|l|ĺ")
(set-class 's-liquid "R|L")
(set-class 'nasal "m|n|ṇ|ň|ñ|ń|ṅ")
(set-class 's-nasal "M|N")
(set-class 'halb-vok "y|w")
(set-class 'res (s+ (l 'liquid) "|" (l 'nasal)))
(set-class 'res-yw (s+ (l 'res) "|" (l 'halb-vok)))
(set-class 's-res (s+ (l 's-liquid) "|" (l 's-nasal)))
(set-class 'lary "H1|H2|H3|H")
(set-class 'sibil "s|š|ṣ|ś|z!|z|ž!|ž|ẓ!|ẓ")
(set-class 'labial "b!|p!|b|p")
(set-class 'dental "d!|t!|d|t")
(set-class 'retroflex "ḍ!|ṭ!|ḍ|ṭ")
(set-class 'palatal "ǰ!|č!|ǰ|č")
(set-class 'palatal2 "j!|c!|j|c")
(set-class 'velar "g!|k!|g|k")
(set-class 'labiovelar "G!|K!|G|K")
(set-class 'okklu (s+ (l 'labial) "|" (l 'dental) "|" (l 'retroflex)
                      "|" (l 'palatal) "|" (l 'palatal2) "|" (l 'velar)
                      "|" (l 'labiovelar)))
(set-class 'kons (s+ (l 'res) "|" (l 'halb-vok) "|" (l 'sibil) "|"
                     (l 'okklu) "|" (l 'lary)))
(set-class 'media "b|d|ḍ|ǰ|j|g|G")
(set-class 'tenuis "p|t|ṭ|č|c|k|K")
(set-class 'mediaasp "b!|d!|ḍ!|ǰ!|j!|g!|G!")
(set-class 'tenuisasp "p!|t!|ṭ!|č!|c!|k!|K!")

(load "subfuncs.scm")
(load "rules.scm")
