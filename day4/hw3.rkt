#lang racket

;;; Student Name: David Abrahams
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [x] I completed this assignment working with Bill Wong and Annabel Consilvio.

;;;;;;;;;;;
;; 1. assq

;; `assq` is a function that takes a key and an association list.
;;
;; It returns the corresponding key/value pair from the list
;; (*i.e.*, the pair whose key is *eq?* to the one it is given).
;;
;; If the key is not found in the list, `assq` returns `#f`.


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
        (list 'NOTT not)))

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

(define (evaluate op lookup-list)
	(second (assq op lookup-list))
	)

(define (calculate x lookup-list)
	(if (list? x)
		(
			(evaluate (first x) lookup-list)
			(calculate (second x) lookup-list)
			(calculate (third x) lookup-list)
			)
		x
		)
)


(display (assq 'GE operator-list)) (newline)
(display (evaluate 'EQ operator-list)) (newline)
(display (calculate '(LT 3 5) operator-list)) (newline)  ;; #t
;;;;;;;;;;;
;; 2. lookup-list

;; Add the ability to look up symbols to your evaluator.
;;
;; Add the `lookup-list` argument to your hw2 evaluator (or ours, from the solution set).
;; `(evaluate 'foo lookup-list)` should return whatever `'foo` is associated with in `lookup-list`.
