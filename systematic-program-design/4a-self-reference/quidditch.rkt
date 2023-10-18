#lang racket

(require test-engine/racket-tests)

; PROBLEM: Imagine that you are designing a program that will keep track of your
; favorite Quiddictch teams.
;
; Design a data definition to represent a list of Quiddictch teams.


; Information:
; - McGill
; - UBC

; Data:
; - "McGill"
; - empty
; - (cons "McGill"
;         (cons "UBC" empty))

; Data Definitions:

;; ListOfString is one of:
;; - empty
;; - (cons String ListOfString)
;; interp. a list of strings
(define LOS1 empty)
(define LOS2 (cons "UBC" empty))
(define LOS3 (cons "McGill" (cons "UBC" empty)))

; Template
;(define (fn-for-los los)
  ;(cond [(empty? los) (...)]
        ;[else 
         ;(... (first los) 
              ;(fn-for-los (rest los)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons String ListOfString)
;; - self-reference: (rest los) is ListOfString


;; PROBLEM: We want to know whether your list of favorite Quiddictch teams
;; includes UBC! Design a function that consumes ListOfString and produces true
;; if the list includes "UBC"


;; ListOfString -> Boolean
;; Produce true if the given list of string contains "UBC"
;(define (contain-ubc? los) false) ; stub

(check-expect (contain-ubc? empty) false)
(check-expect (contain-ubc? (cons "UBC" empty)) true)
(check-expect (contain-ubc? (cons "McGill" empty)) false)
(check-expect (contain-ubc? (cons "McGill" (cons "UBC" empty))) true)
(check-expect (contain-ubc? (cons "UBC" (cons "McGill" empty))) true)

(define (contain-ubc? los)
  (cond [(empty? los) false]
        [else 
         (or (string=? (first los) "UBC")
              (contain-ubc? (rest los)))]))

(test)







