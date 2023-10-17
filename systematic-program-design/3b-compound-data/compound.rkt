#lang racket 

; PROBLEM: Design a data definition to represent hockey players, include both
; their first and last name.

(define-struct player (fn ln))
;; Player is (make-player String String)
;; interp. (make-player fn ln) is a hockey player with
          ;; fn is the first name
          ;; ln is the last name

(define P1 (make-player "Pham" "Hoa"))
(define P2 (make-player "Pham" "Chris"))

;(define (fn-for-player p)
  ;(... (player-fn p)
       ;(player-ln p)))

;; Template rules used:
;; - compound: 2 fields
