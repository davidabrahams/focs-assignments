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
  (display (myeval (read) op-list))
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

(define (get-value-from-key op lookup-list)
  (second (assq op lookup-list))
  )


(define (myeval sexpr op-list)
  (calculate sexpr op-list)
  )

(define (CHECK-FIRST-ELEM? lst word)
  (if (list? lst)
    (if (eq? (first lst) word)
      #t
      #f)
    #f)
  )

(define (first-elem-to-op elem lookup-list)
  (if (list? elem)
    (if (eq? (first elem) 'LAMBDA)
      (calculate elem lookup-list)
      (error "Got list without first element CLOSURE")
      )
    (get-value-from-key elem lookup-list)
    )
  )



(define (calculate x lookup-list)
  (if (CHECK-FIRST-ELEM? x 'DEFINE)
    (repl (append lookup-list (list (list (second x) (third x)))))
    (if (CHECK-FIRST-ELEM? x 'LAMBDA)
      (list 'CLOSURE (second x) (third x) lookup-list)
      (if (list? x)
        (let ([first-elem (first x)])
          (let ([op (first-elem-to-op first-elem lookup-list)])
            (apply
              op
              ; (get-value-from-key first-elem lookup-list)
              (map (lambda (l) (calculate l lookup-list)) (rest x))
              )
            )
          )
        (if (symbol? x)
          (get-value-from-key x lookup-list)
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