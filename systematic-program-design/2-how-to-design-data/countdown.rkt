#lang racket

; PROBLEM: Consider desigining the system for controlling a New Year's Eve
; display. Design a data definition to represent the current state of the
; countdown, which falls into one of three categories:
; - not yet started
; - from 10 to 1 seconds before midnight
; - complete (Happy New Year!)


;; Data Definitions:

;; CountDown is one of:
;; - false
;; - Natural[1, 10]
;; - "complete"
;; interp.
;;  false means countdown has not yet started.
;;  Natural[1, 10] means countdown is running and how many seconds left.
;;  "complete" means countdown is over.
;; Examples:
(define CD1 false)
(define CD2 7)
(define CD3 "complete")

;(define (fn-for-count-donw cd) 
  ;(cond [(false? cd) (...)] 
        ;[(string=? cd "complete") (...)]
        ;[(and (number? cd) (>= cd 1) (<= x 10)) (... cd)]))

;(define (fn-for-count-donw cd) 
  ;(cond [(false? cd) (...)] 
        ;[(number? cd) (... cd)]
        ;[else (...)]))

;; Template rules used:
;; - one of: 3 cases
;; - atomic distinct: false
;; - atomic distinct: "complete"
;; - atomic non-distinct: Natural[1, 10]
