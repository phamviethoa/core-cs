#lang racket

; PROBLEM:
;
; You've been asked to design a program having to do with all the owls in the
; owlery.
;
; A. Design a data definition to represent the weights of all the owls. For this
; problem call it ListOfNumber.
; B. Design a function that consumes the weights of owls and produces the total
; weight of all that owls.
; C. Design a function that consumes the weights of owls and produces the total
; number of owls.

;; Data Definitions:

;; ListOfNumber is one of:
;; - empty
;; - (cons Natural ListOfNumber)
;; interp. a list of number - (this interp. is not clear the meaning of number)
;; interp. each number in the list is a owl weight in ounces.

(define LON1 empty)
(define LON2 (cons 1 empty))
(define LON3 (cons 10 (cons 1 empty)))

;(define (fn-for-lon lon)
  ;(cond [(empty? lon) (...)]
        ;[else (... (first lon)
                   ;(fn-for-lon (rest lon)))]))

;; Template rules used:
;; - one of: 2 case
;; - atomic distinct: empty
;; - compound: (cons Natural ListOfNumber)
;; - self-reference: (rest lon) is ListOfNumber


;; Functions:

(require test-engine/racket-tests)

;; ListOfNumber -> Natural
;; Produce the total weight of all given list of weights of owls
;(define (calc-total lon) 0) ; stub

(check-expect (calc-total empty) 0)
(check-expect (calc-total (cons 1 empty)) (+ 1 0))
(check-expect (calc-total (cons 2 (cons 1 empty))) (+ 2 (+ 1 0)))

;; template use from ListOfNumber

(define (calc-total lon)
  (cond [(empty? lon) 0]
        [else (+ (first lon)
                   (calc-total (rest lon)))]))


;; ListOfNumber -> Natural
;; Produce the number of owls by given list of weights of owls.
;(define (cnt-owls lon) 0) ; stub

(check-expect (cnt-owls empty) 0)
(check-expect (cnt-owls (cons 5 empty)) (+ 1 0))
(check-expect (cnt-owls (cons 10 (cons 5 empty))) (+ 1 (+ 1 0)))
(check-expect (cnt-owls (cons 5 (cons 10 empty))) (+ 1 (+ 1 0)))

;; template use from ListOfNumber

(define (cnt-owls lon)
  (cond [(empty? lon) 0]
        [else (+ 1 (cnt-owls (rest lon)))]))

(test)
