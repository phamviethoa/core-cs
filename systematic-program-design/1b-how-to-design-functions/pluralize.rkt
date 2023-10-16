#lang racket
(require test-engine/racket-tests)

;; String -> String
;; Produce a given string with "s" added to the end.
;; stub: (define (pluralize str) "")
(check-expect (pluralize "cat") "cats")
(check-expect (pluralize "dogs") "dogss")
;; template: (define (pluralize str) (... str))

(define (pluralize str) 
  (string-append str "s"))

(test)

