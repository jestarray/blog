#lang racket
(require pollen/decode txexpr)
(require pollen/setup)
(require pollen/core)
(require pollen/pagetree)


(provide (all-defined-out)) ;make everything global in this file

;(define command-char #\◊)
(module setup racket/base
  (provide (all-defined-out))
  (require pollen/setup)
  (define project-server-port 1111)
  (define publish-directory (path->complete-path (build-path 'up "out")))
  (define current-project-root (current-directory))
  (define block-tags (append (list 'summary) default-block-tags))) ;tags that aren't wrapped in p

(define (root . elements)
  (txexpr 'root empty (decode-elements elements
                                       #:txexpr-elements-proc (compose1 decode-paragraphs)
                                       #:string-proc (compose1 smart-quotes smart-dashes))))

;Number -> List<Number>
; returns a list of powers of two
(define (pot n)
  (cond [(= n 0) '()]
        [else (cons (expt 2 (- n 1)) (pot (- n 1)))]))

; String or Number -> Txexpr
;returns 2^n rendered correctly in html
(define (2^ n #:style [style '()])
  (define s 
    (cond [(string? n) n]
          [(number? n) (number->string n)]))
  (txexpr 'span style (list "2" (txexpr 'sup empty (list s)))))

; Number -> List<txexpr>
; returns a list of powers of 2 html subscript
(define (two-subscripts n)
  (cond [(= n 0) '()]
        [else (cons (2^ (- n 1)) (two-subscripts (- n 1)))]))

;List<T> -> thead<tr<th>>
; takes a list of values and produces table headings
(define (table-headings l #:style [style empty])
  (txexpr 'thead style (list (txexpr 'tr empty (map (lambda (i)
                                                      (txexpr 'th empty (list (cond [(number? i) (number->string i)]
                                                                                    [(char? i) (string i)]
                                                                                    [else i])))) l)))))

;List<List<T>> or List<T>...N -> tbody<tr<td>>
; takes a list of values and produces table entries
(define (table-entries . l)
  (define c (first (first l))) ; Primitive or list
  (define convert-to-2d (cond
                          [(and (list? c) (symbol? (first c))) l] ;if already list and first el is a symbol
                          [(list? c) (car l)] ; if called like (list (list d1 d2) (list d3 d4)) ; already defined each row in a list
                          [else l])) ; if called (list 1 2 3) (list 1 2 3) in which case already a 2d list because of rest
  (define (process-items row) (map (lambda (i)
                                     (txexpr 'td empty (list (cond [(number? i) (number->string i)]
                                                                   [(char? i) (string i)]
                                                                   [else i])))) row))
  (txexpr 'tbody empty (map (lambda (r) (txexpr 'tr empty (process-items r))) convert-to-2d)))

;thead<tr<th>> -> xml table
; can take 1 heading, or list of them
(define (table headings #:caption [caption empty] #:style [style empty] . entries )
  (txexpr 'table style (append (match caption 
                                 [s #:when (string? caption) (list (txexpr 'caption empty (list s)))]
                                 [s #:when (and (not (empty? caption)) (symbol? (car caption))) (list (txexpr 'caption empty (list s)))]
                                 [_ (list (txexpr 'caption empty caption))]) 
                               (cond [(symbol? (car headings)) (list headings)]
                                     [else headings]) entries)))

;List<List<Key,Value>> -> txexpr
(define (summaryc attr . h)
  (txexpr 'summary attr h))

;String String -> txexpr
(define (q heading . content)
  (txexpr 'details empty (append (list (summaryc (list '(class "question")) heading)) content)))

;String String -> txexpr
(define (step heading . content)
  (txexpr 'details '((open "true")) (append (list (summaryc (list '(class "step")) heading)) content)))

;String String -> txexpr
(define (more-examples . content)
  (txexpr 'details empty (append (list (summaryc (list '(class "more-examples")) "Extra Examples")) content)))

;accepts only the uid, not the full url
(define (yt link)
  (txexpr 'details empty (list (txexpr
                                'summary '((style "color:red;")) (list "Youtube")) (txexpr 'iframe
                                                                                           (list  (cons 'srcdoc (cons (string-append "<style>*{padding:0;margin:0;overflow:hidden}html,body{height:100%}img,span{position:absolute;width:100%;top:0;bottom:0;margin:auto}span{height:1.5em;text-align:center;font:48px/1.5 sans-serif;color:white;text-shadow:0 0 0.5em black}</style><a href=https://www.youtube.com/embed/" link "?autoplay=1><img src=https://img.youtube.com/vi/" link "/hqdefault.jpg><span>▶</span></a>") empty))
                                                                                                  '(allow "picture-in-picture") '(allowfullscreen "true") '(loading "lazy") '(width "560") '(height "315")) empty))))

; String -> String
; flips the bits
(define (bnot s)
  (define (flip i) (if (char=? i #\0) #\1 #\0))
  (list->string (map flip (string->list s))))

; String String -> String
; add two binary numbers and returns a binary sum
(define (binary-sum a b)
  (~r (+ (string->number (string-append "#b" a))
         (string->number (string-append "#b" b))) #:base 2))

;Number -> List<Char>
;use padded version for padding negative numbers
; NEGATIVE NUMBERS HAVE TO ACCOUNT FOR BIT WIDTH
(define (deci->binary  n #:width [width 0])
  (define conv (~r #:base 2 (abs n)))
  ; Number -> Binary String
  (define (pad n)
    (define pad-zeros (make-list (abs (- (string-length conv) width)) #\0))
    (cond
      [(positive? n) (string-append (list->string pad-zeros) conv)]
      [(negative? n)
       (define flipped (bnot (list->string (append pad-zeros (string->list conv)))))
       (string-append "-" (binary-sum flipped "1"))]
      ))
  (define t (cond
              [(= n 0) (make-string width #\0)]
              [(positive? width) (pad n)]
              [(and (= width 0) (negative? n)) (raise-user-error "must provide #:width to convert negative")]
              [else
               conv]))
  (string->list t))

;String -> txexpr
;returns hashlink id of an h2
(define (sub-heading s)
  (define slug (string-downcase (string-replace s " " "_")))
  (txexpr 'h2 (list (cons 'id (cons slug empty))) (list (txexpr 'a (list '(class "anchor") (cons 'href (cons (string-append "#" slug) empty))) (list "#")) s)))

;List<T..N> -> List<T..N>
;removes special characters and converts racket data types to strings from list
(define (clean l)
  (define s1 (filter (lambda (x) (if (and (string? x) (string=? x "\n")) #f #t)) l))
  (map (lambda (x) (cond [(number? x) (number->string x)]
                         [else x])) s1))

;...T -> <li>i</li>
; takes a racket list and convers them to txexpr html list of items
(define (list->li . l)
  (define first (car l))
  (define (aux i) (map (lambda (x) (txexpr 'li empty (list x))) i))
  (cond [(list? first) (aux (clean first))]
        [else (aux (clean l))])
  )

(define (steps . l)
  (txexpr 'ol (list '(class "steps")) (list->li l)))

;Number Number -> Table
; converts a number in decimal to binary with a small bit table
; supports highlighting msb for negative numbers
(define (deci->bin-table num bits #:caption [caption empty])
  (define bin (deci->binary num #:width bits))
  (define headings (pot bits))
  (define discrim (cond [(positive? num) (cons headings bin)]
                        [(negative? num) (cons (append (list (highlight-first headings)) (rest headings))
                                               (append (list (highlight-first (rest bin))) (rest (rest bin))))]))
  (define h (car discrim))
  (define e (cdr discrim))
  (table #:caption caption (table-headings h) (table-entries e)))

; highlight first element
; List<T> -> txexpr<span T>
(define (highlight-first lst)
  (define t (car lst))
  (define discrim (cond [(number? t) (number->string t)]
                        [(char? t) (string t)]
                        [else t]))
  (txexpr 'span '((style "color:red;")) (list discrim)))

;highlight the first element red 
; List<Char> -> Txexpr<Span "" <Span "">>
(define (highlight-msb lst)
  (txexpr 'span empty (list (txexpr 'span '((style "color:red;")) (list (list->string (list (car lst))))) (list->string (rest lst)))))

; Number -> List<List<String Number Number>>
; returns the binary division string method of converting decimal to binary
(define (deci->bin-div n)
  (define (aux n acc)
    (define quo (quotient n 2))
    (cond [(= n 0) acc]
          [else
           (aux quo (cons (list (string-append (number->string n) "/2") quo (remainder n 2)) acc))]))
  (reverse (aux n '())))

(define (layout-spread-row . items)
  (txexpr 'div '((class "layout-spread-row")) items))

(define (p-img path #:style [style empty])
  (txexpr 'img (list (append (cons 'src (cons path empty)) style)) empty)
  )

; string path relative to image folder, e.g "/images"
(define (img-row #:width [width "10vh"] . paths)
  (txexpr 'div '((class "layout-spread-row wrap")) (map (lambda (i) (txexpr 'img (list (cons 'src (cons i empty)) '(style "width: 10vh") ) empty)) paths)
          ))

(define (max-bit-table f caption)
  (table #:caption caption (table-headings (list "Decimal" "Binary")) (table-entries (f '()))))

(define (max-unsigned-limit-table bits)
  (define MAX (expt 2 bits))
  (define (aux acc)
    (define LEN (length acc))
    (cond [(= LEN MAX) (reverse acc)]
          [else
           (aux (cons (list LEN (list->string (deci->binary LEN #:width bits))) acc))]))
  (max-bit-table aux "unsigned"))

(define (max-signed-limit-table bits)
  (define MAX (expt 2 bits))
  (define MAX-NEG (/ MAX -2))
  (define (aux acc)
    (define LEN (length acc))
    (define count (+ MAX-NEG LEN))
    (cond [(= LEN MAX) (reverse acc)]
          [else
           (define r (deci->binary count #:width bits) )
           (aux (cons (list count (cond [(negative? count) (highlight-msb (rest r))]
                                        [else (list->string r)])
           
                            ) acc))]))
  (max-bit-table aux "signed"))

;alias to html <time> because racket already reserves namespace
(define (ptime #:style [style empty] . c)
  (txexpr 'time style c))

; String -> String
; example.html -> example
(define (trim-ext s)
  (string-replace s (bytes->string/utf-8 (path-get-extension s)) "" #:all? #f)
  )

; List<Page> -> txexpr
; pass in the (rest) of page-tree root

(define (generate-toc ls)
  (define (wrap j)
    (define imp (dynamic-require (string-append (symbol->string j) ".pm") 'doc))
    (define file-name (trim-ext (path->string (file-name-from-path (symbol->string j)))))
    (txexpr 'li empty (list (cond [(not (select 'time imp)) ""]
                                  [else (string-append (select 'time imp) " --- ")]) (txexpr 'a (list (cons 'href (cons (symbol->string j) '()))) (list (select 'h1 imp))))))
  (define (sec i) (txexpr 'ul '((style "list-style-type: none;")) (map wrap i)))
  (map sec ls)
  )


;(generate-toc (list (list 'misc/EvolvedSimplicity.html)))
;(generate-toc (list (list (build-path (current-directory) "misc" "EvolvedSimplicity.html"))))