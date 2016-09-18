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

(define (run-repl)
  (display "welcome to my repl.  type some scheme-ish")
  (repl operator-list))

(define (repl op-list)
  (display "> ")
  (display (mini-eval (read) op-list))
  (newline)
  (repl op-list))

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


(define (mini-eval sexpr op-list)
  (calculate sexpr op-list)
  )

(define (SPECIAL-CHECK? lst word)
  (if (list? lst)
    (if (eq? (first lst) word)
      #t
      #f)
    #f)
  )

(define (my-zip l1 l2)
  (if (or (null? l1) (null? l2))
      l2
      (cons (list (first l1) (first l2)) (my-zip (rest l1) (rest l2)))
      )
  )

(define (op-to-lambda op)
  (if (SPECIAL-CHECK? op 'LAMBDA) 
    (list 'lambda (second op) (third op))
    op
    )
  )

(define (calculate x lookup-list)
  (if (SPECIAL-CHECK? x 'DEFINE)
    (repl (append lookup-list (list (list (second x) (third x)))))
    (if (SPECIAL-CHECK? x 'LAMBDA) 
      (list 'CLOSURE (second x) (third x) lookup-list)
      (if (list? x)

        (if (SPECIAL-CHECK? (first x) 'CLOSURE)
          (calculate (third (first x)) (append lookup-list (my-zip (second (first x)) (rest x))))
          (
            (get-operator (first x) lookup-list)
            (calculate (second x) lookup-list)
            (calculate (third x) lookup-list)
            )
        )
        (if (symbol? x)
          (get-operator x lookup-list)
          x
          )
        )
      )
    )
  )

(run-repl)

;; Run this by typing (run-repl)  at scheme.
;; Note that you do not need to quote what you type in; 
;;   it is read as though it were quoted already.