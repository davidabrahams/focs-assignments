#lang racket


(define (tree_helper tree curr_depth)

    (if (list? tree)
        ; IF list
        (if (empty? tree)
            ; IF empty list
            curr_depth
            ; ELIF not empty list
            (max 
                (tree_helper (first tree) (+ curr_depth 1))
                (tree_helper (rest tree) curr_depth)
            )
        )
        ; ELIF number
        curr_depth
    )

)

(define (tree-max-depth tree)
    (tree_helper tree 0)
)

(define (tree-add1 tree)

    (if (list? tree)
        ; If list
        (if (empty? tree)
            ; if empty
            tree
            ; it not empty
            (cons (tree-add1 (first tree)) (tree-add1 (rest tree)))

        )
        ; else not list
        (+ tree 1)

    )

)

; (display (tree-add1 '(1 2 (3 4 5 6 (4 32 4 ))))) (newline) ;; -> 10



(display (tree-max-depth '(12 1))) (newline) ;; -> 10