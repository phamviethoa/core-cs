#lang racket

(require test-engine/racket-tests)

; PROBLEM: Using the SeatNum data definition below, design a function that
; produces true if the given seat number is on the aisle.


;; Data Definitions:

;; SeatNum is a Natural[1, 32]
;; Interp. Seat numbers in a row, 1 and 32 are aisle seats.
(define SN1 1)
(define SN2 10)
(define SN3 32)

;(define (fn-for-seat-num s)
  ;(... s))

;; Template rules used:
;; - atomic non-distinct: Natural[1, 32]


;; Functions:

;; SeatNum -> Boolean
;; Produces true if the given seat number is 1 or 32 (aisle seats)
;(define (aisle? s) false) ; stub

(check-expect (aisle? 1) true)
(check-expect (aisle? 10) false)
(check-expect (aisle? 32) true)

;<use template from SeatNum>
;(define (fn-for-seat-num s)
  ;(... s))

(define (aisle? s)
  (or (= s 1) (= s 32)))

(test)
