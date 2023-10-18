#lang racket

; produce the a empty list
empty

; cons primitive: add a new value to a list
(define L1 (cons 1 empty))
(define L2 (cons 2 (cons 1 empty)))

L1
L2

; first primitive: produce the first value in given list
(first L1)
(first L2)

; rest primitive: produce the list after the first element
(rest L1)
(rest L2)

; empty? primitive: produce true if the given list is empty
(empty? empty)
(empty? L1)
