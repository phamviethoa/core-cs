#lang racket

(require test-engine/racket-tests)

;; PROBLEM:
;; Imagine that you are designing a program that, among other things, has
;; information about the names of cities in its problem domain.

;; Design a data definition to represent the name of a city.


;; Data Definitions:

;; CityName is String
;; interp. the name of a city
(define CN1 "Boston")
(define CN2 "Vancouver")

; Template
;(define (fn-for-city-name cn)
  ;(... cn))

;; Template rules used:
;; - atomic non-distinct: String


;; Using CityName data definition above design a function that produces true if
;; the given city is the best in the world. (you are free to decide which city
;; is the best city in the world.)

;; Functions:

;; CityName -> Boolean
;; Produce true if the given city name is Dalat
;(define (is-best-city? cn) false) ; stub
(check-expect (is-best-city? "Hanoi") false)
(check-expect (is-best-city? "Dalat") true)

; Took template from the CityName
;(define (is-best-city? cn)
  ;(... cn))

(define (is-best-city? cn)
  (string=? cn "Dalat"))

(test)
