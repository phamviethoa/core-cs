#lang racket

; PROBLEM:
;
; (A) Design a data definition to represent an arbitrary number of images.
;
; (B) Design a function called arrange-images that comsumes an arbitrary number
; of images and lays them out left to right in increasing order of size.


(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

;; Constant:

(define I0 (square 0 "solid" "white"))
(define I1 (rectangle 50 10 "solid" "black"))
(define I2 (square 30 "solid" "red"))
(define I3 (square 60 "solid" "red"))

;; Data Definitions:

;; ListOfImage is one of:
;; - empty
;; - (cons Image ListOfImage)
;; interp. list of images

(define LOI1 empty)
(define LOI2 (cons (square 5 "solid" "black") empty))
(define LOI3 (cons (rectangle 10 5 "solid" "white") LOI2))

;(define (fn-for-loi loi) 
  ;(cond [(empty? loi) (...)]
        ;[else (... (first loi)
                   ;(fn-for-loi (rest loi)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Image ListOfImage)
;; - self-reference: (rest loi) is ListOfImage

(define (main i)
  (big-bang i ; Image
            (to-draw render))) ; Image -> Image

(define (render i) i)

;; Functions:

;; ListOfImage -> Image
;; Sort the given list of image by size (area) and then lay them out from left
;; to rignt in the screen

(check-expect (arrange-images empty) I0)

(check-expect (arrange-images (cons I1 empty)) 
             (beside/align "bottom" I1 I0))

(check-expect (arrange-images (cons I2 (cons I1 empty))) 
             (beside/align "bottom" I1 I2 I0))

(check-expect (arrange-images (cons I1 (cons I2 empty))) 
             (beside/align "bottom" I1 I2 I0))

;(define (arrange-images loi) I0) ; stub

(define (arrange-images loi) 
  (layout-images (sort-images loi)))

;; ListOfImage -> ListOfImage
;; Produce a ascending list of images by size (area) from given list of images

(check-expect (sort-images empty) empty)

(check-expect (sort-images (cons I1 empty)) (cons I1 empty))

(check-expect (sort-images (cons I1 (cons I2 (cons I3 empty))))
              (cons I1 (cons I2 (cons I3 empty))))

(check-expect (sort-images (cons I2 (cons I1 (cons I3 empty))))
              (cons I1 (cons I2 (cons I3 empty))))

(check-expect (sort-images (cons I3 (cons I1 (cons I2 empty))))
              (cons I1 (cons I2 (cons I3 empty))))

;(define (sort-images loi) loi) ; stub

(define (sort-images loi) 
  (cond [(empty? loi) empty]
        [else (insert (first loi)
                   (sort-images (rest loi)))]))

;; Image ListOfImage -> ListOfImage
;; Place the given image properly in the given list of images
;; ASSUM: the given list of images have been sort ascending

(check-expect (insert I1 empty) (cons I1 empty))

(check-expect (insert I1 (cons I2 (cons I3 empty)))
              (cons I1 (cons I2 (cons I3 empty))))

(check-expect (insert I2 (cons I1 (cons I3 empty)))
              (cons I1 (cons I2 (cons I3 empty))))

(check-expect (insert I3 (cons I1 (cons I2 empty)))
              (cons I1 (cons I2 (cons I3 empty))))

;(define (insert I0 loi) loi) ; stub

(define (insert i loi) 
  (cond [(empty? loi) (cons i empty)]
        [else (if (is-larger? i (first loi))
                   (cons (first loi) (insert i (rest loi)))
                   (cons i loi)
                   )]))

;; Image Image -> Boolean?
;; Prouce true if the area of first image is larger than the second one.

(check-expect (is-larger? I2 I1) true)
(check-expect (is-larger? I1 I1) false)
(check-expect (is-larger? I1 I2) false)

;(define (is-larger? I0 I1) true) ; stub

(define (is-larger? i1 i2) 
  (> (* (image-width i1) (image-height i1))
         (* (image-width i2) (image-height i2))))

;; ListOfImage -> Image
;; Layout given list of images from left to right on the screen

(check-expect (layout-images empty) I0)

(check-expect (layout-images (cons I1 empty)) 
             (beside/align "bottom" I1 I0))

(check-expect (layout-images (cons I1 (cons I2 empty))) 
             (beside/align "bottom" I1 I2 I0))

;(define (layout-images loi) I0) ; stub

(define (layout-images loi) 
  (cond [(empty? loi) I0]
        [else (beside/align "bottom" (first loi)
                   (layout-images (rest loi)))]))

(test)
