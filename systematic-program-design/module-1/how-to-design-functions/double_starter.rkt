#lang racket

;PROBLEM:
;
;Design a function that comsumes a number and produces twice that number.
;Call your function double. Follow the HtDF recipe and show the stub and template.

(require test-engine/racket-tests)

; This is the Signature
;; Number -> Number

; This is the Purpose
;; Produce 2 times the given number

; this is the Stub
;(define (double n) 0)

; this is the Examples / Tests
(check-expect (double 1) 2)
(check-within (double 2.2) 4.4 0.1)
(check-expect (double -4) -8)
(check-expect (double 0) 0)

; this is the template
;(define (double n)
;  (... n))

; this is code the body
(define (double n)
  (* 2 n))

(test)
