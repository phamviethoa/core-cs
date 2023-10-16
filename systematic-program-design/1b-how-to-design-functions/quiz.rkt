#lang racket
(require test-engine/racket-tests)
(require 2htdp/image)

; PROBLEM: design a fuction that consumes two images and produces true if the
; first is larger than the second.

;; Image, Image -> Boolean
;; Produce true of the first given image is larger than the second one. (Base on
;; the image area)

(check-expect (is-larger-than? (rectangle 3 4 "solid" "black") (rectangle 5 6
                                                                          "solid"
                                                                          "black")) false)
(check-expect (is-larger-than? (rectangle 3 4 "solid" "black") (rectangle 3 4
                                                                          "solid"
                                                                          "black")) false)
(check-expect (is-larger-than? (rectangle 5 6 "solid" "black") (rectangle 3 4
                                                                          "solid"
                                                                          "black")) true)

;(define (is-larger-than? img1 img2) false) ;stub

;(define (is-larger-than? img1 img2)        ;template
  ;(... img1 img2))

(define (is-larger-than? img1 img2) 
  (> (* (image-width img1) (image-height img1)) (* (image-width img2)
                                                   (image-height img2))))

(test)
