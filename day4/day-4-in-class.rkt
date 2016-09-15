#lang racket

(define (list-len-helper lst acc)
    (if (null? lst)
        acc
        (list-len-helper (rest lst) (+ acc 1))
        )
    )

(define (list-length lst)
    (list-len-helper lst 0)
    )

(define (count-evens-helper lst acc)
    (if (null? lst)
        acc
        (count-evens-helper (rest lst)
            (+ acc (if (even? (first lst)) 1 0))
            )
        )
    )

(define (count-evens lst)
    (count-evens-helper lst 0)
    )

(define (list-square lst)
    (if (null? lst) lst
        (cons
            (expt (first lst) 2)
            (list-square (rest lst))
            )
        )
    )

(define (list-addn lst n)
    (if (null? lst) lst
        (cons
            (+ (first lst) n)
            (list-addn (rest lst) n)
            )
        )
    )

(define (filter-even lst)
    (filter even? lst)
    )

(define (filter-positive lst)
    (filter positive? lst)
    )


(define (filter-gt lst lower-bound)
    (filter
        (lambda (x) (>= x lower-bound))
        lst)
    )

(display (list-length '(1 2 3))) (newline)  ;; 3
(display (list-length '(1 2 3 3 2))) (newline)  ;; 5
(display (count-evens '(1 2 3 3 2 4 6))) (newline)  ;; 4
(display (list-square '(1 2 3))) (newline)  ;; (1 4 9)
(display (list-addn '(1 2 3) 2)) (newline)  ;; (3 4 5)
(display (filter-even '(1 2 3))) (newline)  ;; (2)
(display (filter-gt '(1 2 3 50 100) 25)) (newline)  ;; (50 100)