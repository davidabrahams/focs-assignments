#lang racket

(define (factorial num)

  (cond
    [(= num 0) 1]
    [else (* num (factorial (- num 1)))]
  )

)

(define (fact-tail num)
  (fact-acum num 1)
)

(define (fact-acum num acum)
  (cond
    [(= num 0) acum]
    [else (fact-acum (- num 1) (* acum num))]
  )
)

(define (my-filter op lst)
  (if (empty? lst) 
    ; if empty
    lst
    
    ; if not empty
    (let ([filt-rest (my-filter op (rest lst))])
      (if (op (first lst))
        (cons (first lst) filt-rest)
        filt-rest
      )
    )
  )
)

(define (double x) (* 2 x))

(define (my-map op lst)
  (if (empty? lst) 
    ; if empty
    lst
    
    ; if not empty
    (let ([map-rest (my-map op (rest lst))])
        (cons (op (first lst)) map-rest)
    )
  )
)


(display (fact-tail 3)) (newline) ;; -> 10
(display (filter even? '(1 2 3 4 5 6))) (newline) ;; -> 10
(display (my-map double '(1 2 3 4 5 6))) (newline) ;; -> 10