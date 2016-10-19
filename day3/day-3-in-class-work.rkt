#lang racket

;;;;;;;;;;
;;; Day 3 in class work


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

(define (my-append l1 l2)

    (if (null? l1)

        ;; l1 is empty
        (if (null? l2)
            ;; l2 is empty
            l2
            ;; l2 is not empty
            (cons (first l2) (my-append l1 (rest l2)))
            )
        ;; l1 is not empty
        (cons (first l1) (my-append (rest l1) l2))
        )
    )

(define (my-zip l1 l2)
    (if (or (null? l1) (null? l2))
        l2
        (cons (list (first l1) (first l2)) (my-zip (rest l1) (rest l2)))
        )
    )

(define (my-reverse l1)
    (if (null? l1)
        l1
        (append (my-reverse (rest l1)) (list (first l1)))
        )
    )

(display (my-append '(1 2 3) '(4 5 6))) (newline)
(display (my-append '(1 2 3) '(4 5 6))) (newline)
(display (my-zip '(1 2 3) '(4 5 6))) (newline)
(display (my-zip '(1 2 3) '(a b c d e f g))) (newline)
(display (reverse '(1 2 3))) (newline)

;;;;;;;;;;;
;; 3.  While we're reimplementing built-ins, implement my-append (just like built in append)
;;     It takes two lists and returns a list containing all of the elements of the originals, in order.
;;     Note that it is purely functional, i.e., it doesn't MODIFY either of the lists that it is passed.

;; (append '(1 2 3) '(4 5 6)) --> '(1 2 3 4 5 6)

;; You might want to draw out the box and pointer structures for the original two lists
;; as well as for the new list.  Confirm with a member of the instructional staff....





;;;;;;;;;;;
;; 4.  zip takes two lists, and returns a list of elements of size two, until one of the lists runs out.

;; (zip '(1 2 3) '(4 5 6)) ;; --> '((1 4) (2 5) (3 6))
;; (zip '(1 2 3) '(a b c d e f g)) ;; --> '((1 a) (2 b) (3 c))

;; Implement `zip`.




;;;;;;;;;;;;
;; 5.  Last built-in (for now):  (my-)reverse.
;;     Takes a list, returns a new list with the elements reversed.

;; (reverse '(1 2 3)) --> '(3 2 1)



;;;;;;;;;;;;
;; More puzzles:
;;
;;  - (count elt lst) returns the number of times that elt appears in lst
;;  - (remove-dups lst) returns a new list that contains the elements of lst but without repeats
;;       (remove-dups '(1 2 3 1 4 5 2 4 6)) --> '(1 2 3 4 5 6)
;;  - reverse reverses a list, but doesn't reverse sublists in a tree.  (Try it and see.)
;;    Write deep-reverse, which reverses all sublists as well.
;;  - Which of these can you implement using tail recursion?
