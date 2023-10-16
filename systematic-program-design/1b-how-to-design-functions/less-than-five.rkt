#lang racket
(require test-engine/racket-tests)

; Design a problem to check if the length of a string is less than 5

;; String -> Boolean
;; Produce true of the length of given string is less than 5

(check-expect (less-than-five "Hello") false)
(check-expect (less-than-five "Hi") true)
(check-expect (less-than-five "Hello World") false)

;(define (less-than-five str) false) ; stub

;(define (less-than-five str)        ; template 
  ;(... str))

(define (less-than-five str) 
  (< (string-length str) 5))

(test)
