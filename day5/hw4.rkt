#lang racket

;;; Student Name: David Abrahams
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [x] I completed this assignment with assistance from Annabel lConsilvio. We worked together!

(define (print-square x)
  (display "the square of ")
  (display x)
  (display " is ")
  (display (* x x)))

; (display "enter a number")
; (print-square (read))

(define (run-repl)
  (display "welcome to my repl.  type some scheme-ish")
  (repl))

(define (repl)
  (display "> ")
  (display (myeval (read)))
  (newline)
  (repl))


(define operator-list
  (list (list 'ADD +)
    (list 'SUB -)
    (list 'MUL *)
    (list 'DIV /)
    (list 'GT >)
    (list 'LT <)
    (list 'GE >=)
    (list 'LE <=)
    (list 'EQ =)
    (list 'NEQ (lambda (x y) (not (= x y))))
    (list 'ANND (lambda (x y) (and x y)))
    (list 'ORR (lambda (x y) (or x y)))
    (list 'NOTT not)
    )
  )

(define (assq op op-list)
  (if (null? op-list)
    ; if op-list is null
    #f
    (let ([first-elem (first op-list)])
      (if (eq? op (first first-elem))
        first-elem
        (assq op (rest op-list))
        )
      )
    )
  )

(define (get-operator op lookup-list)
  (second (assq op lookup-list))
  )


(define (myeval sexpr)
  (calculate sexpr operator-list)
  )

(define (DEFINE? lst)
  (if (list? lst)
    (if (eq? (first lst) 'DEFINE)
      #t
      #f)
    #f)
  )

(define (calculate x lookup-list)
  (if (list? x)
    (
      (get-operator (first x) lookup-list)
      (calculate (second x) lookup-list)
      (calculate (third x) lookup-list)
      )
    x
    )
)

(run-repl)

;; Run this by typing (run-repl)  at scheme.
;; Note that you do not need to quote what you type in; 
;;   it is read as though it were quoted already.