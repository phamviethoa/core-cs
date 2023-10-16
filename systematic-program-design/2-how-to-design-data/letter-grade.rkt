#lang racket

; PROBLEM: As part of designing system to keep track of student grades, you are
; asked to design a data definition to represent the letter grade in a course,
; which is one of A, B or C.


;; Data Definitions:

;; LetterGrade is one of:
;; - "A"
;; - "B"
;; - "C"
;; interp. the letter grade in a course.
;; Examples of data: <Examples are redundant for enumerations (but why?)>
(define G1 "A")
(define G2 "B")
(define G3 "C")

;; Template
;(define (fn-for-letter-grade g)
  ;(cond [(string=? g "A") (...)]
        ;[(string=? g "B") (...)]
        ;[(string=? g "C") (...)]))

;; Template rules used
;; - one of: 3 cases
;; - atomic distinct value: "A"
;; - atomic distinct value: "B"
;; - atomic distinct value: "C"
