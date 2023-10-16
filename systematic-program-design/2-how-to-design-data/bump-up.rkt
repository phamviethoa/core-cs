#lang racket

(require test-engine/racket-tests)

; PROBLEM: Using the LetterGrade data definition below design a function that
; consumes a letter grade and produces the next higher letter grade. Call your
; function bump up.


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


;; Functions:
;; LetterGrade -> LetterGrade
;; Produce the next higher letter grade of the given letter grade (no change for
;; A)
;(define (bump-up g) "A") ; stub

(check-expect (bump-up "A") "A")
(check-expect (bump-up "B") "A")
(check-expect (bump-up "C") "B")

; <template get from the LetterGrade data definition>

(define (bump-up g)
  (cond [(string=? g "A") "A"]
        [(string=? g "B") "A"]
        [(string=? g "C") "B"]))

(test)


