#lang racket

(define-struct pos (x y))

(define P1 (make-pos 3 4))
(define P2 (make-pos 3 4))

P1

(pos-x P1)
(pos-y P1)

(pos? P2)
(pos? "Hello World!")
