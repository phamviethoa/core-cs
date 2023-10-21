#lang racket

(require test-engine/racket-tests)

;; NATURAL is one of:
;; - empty
;; - (cons "!" NATURAL)
;; interp. number of "!" in the list is number

(define N0 empty)         ; 0
(define N1 (cons "!" N0)) ; 1
(define N2 (cons "!" N1)) ; 2
(define N3 (cons "!" N2)) ; 3
(define N4 (cons "!" N3)) ; 4
(define N5 (cons "!" N4)) ; 5
(define N6 (cons "!" N5)) ; 6
(define N7 (cons "!" N6)) ; 7
(define N8 (cons "!" N7)) ; 8
(define N9 (cons "!" N8)) ; 9

;; These are the primitives that operate NATURAL:
(define (ZERO? n) (empty? n))  ; ANY         -> Boolean
(define (ADD1 n) (cons "!" n)) ; NATURAL     -> NATURAL
(define (SUB1 n) (rest n))     ; NATURAL[>0] -> NATURAL

;(define (fn-for-natural n)
  ;(cond [(ZERO? n) (...)]
        ;[else (... n
                   ;(fn-for-natural (SUB1 n)))]))

;; NATURAL, NATURAL -> NATURAL
;; Produce a + b

(check-expect (ADD N0 N2) N2)
(check-expect (ADD N2 N0) N2)
(check-expect (ADD N3 N4) N7)

;(define (ADD a b) N0) ; stub

(define (ADD a b)
  (cond [(ZERO? b) a]
        [else (ADD (ADD1 a) (SUB1 b))]))

;; NATURAL, NATURAL -> NATURAL
;; Produce a - b

(check-expect (SUB N0 N0) N0)
(check-expect (SUB N1 N0) N1)
(check-expect (SUB N5 N1) N4)

;(define (SUB a b) N0) ; stub

(define (SUB a b)
  (cond [(ZERO? b) a]
        [else (SUB (SUB1 a) (SUB1 b))]))

(test)
