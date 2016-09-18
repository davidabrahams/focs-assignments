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

(display "enter a number")
(print-square (read))

(define (run-repl)
  (display "welcome to my repl.  type some scheme-ish")
  (repl))

(define (repl)
  (display "> ")
  (display (myeval (read)))
  (newline)
  (repl))

(define (myeval sexpr)
  sexpr)

;; Run this by typing (run-repl)  at scheme.
;; Note that you do not need to quote what you type in; 
;;   it is read as though it were quoted already.