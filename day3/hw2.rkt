#lang racket

;;; Student Name: David Abrahams [change to your name]
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [ ] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___

;;; 1.  Create a calculator that takes one argument: a list that represents an expression.

(define (get-nth lst n)
    (if (empty? lst)

        '()

        (if (= n 0)
            ; if n = 0
            (first lst)
            ; elif n != 0
            (get-nth (rest lst) (- n 1))
        )
    )
)

(define (calculate x)

    (if (list? x)
        (if (empty? x)
            ; if x is empty
            x
            ; if x not empty

            (let ([fun (get-nth x 0)])
            (let ([n1 (calculate (get-nth x 1))])
            (let ([n2 (calculate (get-nth x 2))])
                (if (eq? fun 'ANND)
                    (and n1 n2)
                (if (eq? fun 'ORR)
                    (or n1 n2)
                (if (eq? fun 'NOTT)
                    (not n1)
                (if (eq? fun 'GT)
                    (> n1 n2)
                (if (eq? fun 'LT)
                    (< n1 n2)
                (if (eq? fun 'GE)
                    (>= n1 n2)
                (if (eq? fun 'LE)
                    (<= n1 n2)
                (if (eq? fun 'EQ)
                    (= n1 n2)
                (if (eq? fun 'NEQ)
                    (not (= n1 n2))
                (if (eq? fun 'ADD)
                    (+ n1 n2)
                (if (eq? fun 'SUB)
                    (- n1 n2)
                (if (eq? fun 'MUL)
                    (* n1 n2)
                (if (eq? fun 'DIV)
                    (/ n1 n2)
                0 ; DEFAULT CASE
                ))))))))))))) ; end of ifs
            ))) ; end of lets
        ) ; end if empty

        ; x is not a list
        x

    ) ; end if list
)

(calculate 3) ;; --> 7
(calculate '(ADD 3 4)) ;; --> 7
(calculate '(SUB 4 2)) ;; --> 2
(calculate '(MUL 4 4)) ;; --> 16
(calculate '(DIV 4 4)) ;; --> 1

;;; 2. Expand the calculator's operation to allow for arguments that are themselves well-formed arithmetic expressions.

(calculate '(ADD 3 (MUL 4 5))) ;; --> 23   ;; what is the equivalent construction using list?
(calculate '(SUB (ADD 3 4) (MUL 5 6))) ;; --> -23

;;; 3. Add comparators returning booleans (*e.g.*, greater than, less than, …).
;; Note that each of these takes numeric arguments (or expressions that evaluate to produce numeric values),
;; but returns a boolean.  We suggest operators `GT`, `LT`, `GE`, `LE`, `EQ`, `NEQ`.

    (calculate '(GT (ADD 3 4) (MUL 5 6))) ;; --> #f
    (calculate '(LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6))))) ;; --> #t

;;; 4. Add boolean operations ANND, ORR, NOTT

(calculate '(ANND (GT (ADD 3 4) (MUL 5 6)) (LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6)))))) ;; --> #f
(calculate '(NOTT (ANND (GT (ADD 3 4) (MUL 5 6)) (LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6))))))) ;; --> #t

;;; 5. Add IPH

; (calculate '(IPH (GT (ADD 3 4) 7) (ADD 1 2) (ADD 1 3))) ;; -> 4
