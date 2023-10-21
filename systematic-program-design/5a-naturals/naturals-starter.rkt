#lang racket

;; Natural is one of:
;; - 0
;; - (add1 Natural)
;; interp. a natural number

(define N1 0)
(define N2 (add1 0))
(define N3 (add1 N2))

;(define (fn-for-natural n)
  ;(cond [(zero? n) (...)]
        ;[else 
          ;(... ;n
               ;(fn-for-natural (sub1 n)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: 0
;; - compound: (add1 Natural)
;; - self-reference: (sub1 n) is Natural


; PROBLEM:
; A. Design a function that comsumes Natural number n and produces the sum of
; all the naturals in [0, n]
;
; B. Design a function that comsumes Natural number n and produces a list of all
; naturals of the form (cons n (cons n - 1 ... empty)) not including 0.

(require test-engine/racket-tests)

;; Functions:

;; Natural -> Natural
;; produce sum of Natural in [0, n]

(check-expect (sum 0) 0)
(check-expect (sum (add1 0)) (+ 0 1))
(check-expect (sum (add1 (add1 0))) (+ 0 1 2))

;(define (sum n) 0) ; stub

(define (sum n)
  (cond [(zero? n) 0]
        [else 
          (+ n (sum (sub1 n)))]))

;; Natural -> ListOfNatural
;; Produce list of all naturals of the form (cons n (cons n-1 ... empty) with
;; given natural number n

(check-expect (get-list-naturals 0) empty)
(check-expect (get-list-naturals (add1 0)) (cons 1 empty))
(check-expect (get-list-naturals (add1 (add1 0))) (cons 2 (cons 1 empty)))

;(define (get-list-naturals n) empty) ; stub


(define (get-list-naturals n)
  (cond [(zero? n) empty]
        [else 
          (cons n
               (get-list-naturals (sub1 n)))]))

(test)
