#lang racket
(require test-engine/racket-tests)

; PROBLEM: design a function called area that comsumes the lenght of one side of
; a square and produces the area of the square

;; Number -> Number
;; Produce the area of a square by the given length of one side
;(define (area n) 0)

(check-expect (area 5) 25)
(check-expect (area 2) 4)

;(define (area n) 
  ;(... n))

(define (area n) 
  (* n n))

(test)
