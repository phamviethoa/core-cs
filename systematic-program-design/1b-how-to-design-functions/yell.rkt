#lang racket
(require test-engine/racket-tests)

; Problem: design a function called yell that consumes string like "hello" and
; add "!" to produce strings like "hello!"
; 
; Remember, when we say design, we mean follow the recipe.
;
; Leave behind commented out versions of the stub and template.

;; String -> String
;; Produce a given string with "!" was added to the end.
; stub: (define (yell str) "")

(check-expect (yell "hello") "hello!")
(check-expect (yell "hi") "hi!")

;(define (yell str) 
  ;(... str))

(define (yell str) 
  (string-append str "!"))
 
(test)
