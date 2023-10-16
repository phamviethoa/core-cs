#lang racket

; PROBLEM: Imagine that you are designing a program to manage ticket sales for a
; theater. (Also imagine that the theater is perfectly rectangular in shape!)

; Design a data definition to represent a seat number in a row, where each row
; has 32 seets. (Just the seat number, not the row number)

;; Data Definitions:

;; SeatNum is Natural[1, 32]
;; interp. seat number in a row, 1 and 32 are aisle seats
(define SN1 1)
(define SN2 10)
(define SN3 32)

;; Template
;(define (fn-for-seat-num sn) 
  ;(... sn))

;; Template rules used:
;; - atomic non-distinct: Natural[1, 32]
