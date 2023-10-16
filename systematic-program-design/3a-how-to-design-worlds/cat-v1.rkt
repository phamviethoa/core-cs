#lang racket

; PROBLEM:
; Use the how to design world recipe to design an interactive program in which
; a cat starts at the left edge of the display and then walks across the screen
; to the right. When the cat reaches the right edge it should just keep going
; right off the screen.

; Once your design is complete revise it and add a new feature, which is that
; pressing the space key should cause the cat to go back to the left edge of the
; screen. When you do this, go all the way back to your domain analysis and
; incorporate the new feature.

; To help you get started, here is a picture of a cat, which we have taken from
; the 2nd edition of the How to Design Programs book on which this course based.


;; Domain  Analysis:

;; 1. Sketching 2 or 3 images that reflect different state of the program.

;; 2. Constant:
;; - width of the screen
;; - height of the screen
;; - y coordinate of the cat (ctr-y)
;; - mts
;; - cat image
;; - cat speed

;; 3. Changing:
;; - x coordinate of the cat

;; 4. Big-bang options:
;; - on-tick
;; - to-draw


;; Build The Actual Program:

(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

;; A Cat that walks from left to right across the screen.

;; 1. Constant: (Constant)

(define WIDTH 600)
(define HEIGHT 400)
(define CTR-Y (/ HEIGHT 2))
(define MTS (empty-scene WIDTH HEIGHT))
(define CAT-IMG (square 50 "solid" "black"))
(define SPEED 5)

;; 2. Data Definitions: (Changing)

;; Cat is Number
;; Interp. x position of the cat in screen coordinates.

(define C1 0)
(define C2 (/ WIDTH 2))
(define C3 WIDTH)

;(define (fn-for-cat c)
  ;(... c))

;; Template rules used:
;; - atomic non-distinct: Number


;; 3. Functions:

(define (main c)
  (big-bang c ; Cat
            (on-tick advance-cat) ; Cat -> Cat
            (to-draw render))) ; Cat -> Image

;; Cat -> Cat
;; Produce the next cat, by advancing it SPEED pixel(s) to right

;(define (advance-cat c) 0) ; stub

(check-expect (advance-cat 3) (+ 3 SPEED))
(check-expect (advance-cat 0) (+ 0 SPEED))

; use template from Cat

(define (advance-cat c)
  (+ c SPEED))

;; Cat -> Image
;; Render the cat image at approriate place on MTS

;(define (render c) MTS) ; stub

(check-expect (render 4) (place-image CAT-IMG 4 CTR-Y MTS))

; use the template from Cat

(define (render c)
  (place-image CAT-IMG c CTR-Y MTS))

(test)
(main 0)




















