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

;; Functions:

;; Image -> Image
;; Produce the comsumes image and draw it to the screen.

(check-expect (render (square 10 "solid" "black")) (square 10 "solid" "black"))

;(define (render i) (square 0 "solid" "black")) ; stub

(define (render i) i)


;; ListOfImage -> Images
;; Lays given images out left to right in increasing order of size (size is area
;; of image).

(check-expect (arrange-images empty) (square 0 "solid" "white"))
(check-expect (arrange-images (cons (rectangle 50 10 "solid" "black") empty)) 
             (beside/align "bottom" 
                           (rectangle 50 10 "solid" "black")
                           (square 0 "solid" "white")))

(check-expect (arrange-images (cons (square 30 "solid" "red") 
                                    (cons (rectangle 50 10 "solid" "black") 
                                          empty))) 
             (beside/align "bottom" 
                           (rectangle 50 10 "solid" "black")
                           (square 30 "solid" "red")
                           (square 0 "solid" "white")))

(check-expect (arrange-images (cons (rectangle 50 10 "solid" "black") 
                                    (cons (square 30 "solid" "red") 
                                          empty))) 
             (beside/align "bottom" 
                           (rectangle 50 10 "solid" "black")
                           (square 30 "solid" "red")
                           (square 0 "solid" "white")))

;(define (arrange-images loi) (square 0 "solid" "black")) ;stub

(define (arrange-images loi) 
  (cond [(empty? loi) (square 0 "solid" "white")]
        [else (beside/align "bottom" (first (arrange loi))
                   (arrange-images (rest (arrange loi))))]))

;; ListOfImage -> Image
;; lay given list of image out left to right

(check-expect (layout-image empty) (square 0 "solid" "white"))

(check-expect (layout-image (cons (square 10 "solid" "black") empty)) 
              (beside/align "bottom"
                            (square 10 "solid" "black")
                            (square 0 "solid" "white")))

(check-expect (layout-image (cons (square 10 "solid" "black")
                                  (cons (square 20 "solid" "blue") 
                                        empty))) 
              (beside/align "bottom"
                            (square 10 "solid" "black")
                            (square 20 "solid" "blue")
                            (square 0 "solid" "white")))

;(define (layout-image loi) empty) ; stub

(define (layout-image loi) 
  (cond [(empty? loi) (square 0 "solid" "white")]
        [else (beside/align "bottom" 
                  (first loi)
                  (layout-image (rest loi)))]))

;; (cons Image ListOfImage) -> ListOfImage
;; Produce a ListOfImage that the increasing order from given list of images

(check-expect (arrange (cons (rectangle 50 10 "solid" "black") empty)) 
              (cons (rectangle 50 10 "solid" "black") empty))

(check-expect (arrange (cons (square 30 "solid" "red") 
                             (cons (rectangle 50 10 "solid" "black") 
                                          empty))) 
          (cons (rectangle 50 10 "solid" "black") 
                (cons (square 30 "solid" "red") 
                      empty)))

(check-expect (arrange (cons (rectangle 50 10 "solid" "black") 
                                    (cons (square 30 "solid" "red") 
                                          empty))) 
          (cons (rectangle 50 10 "solid" "black") 
                (cons (square 30 "solid" "red") 
                      empty)))

;(define (arrange loi) loi) ; stub

(define (arrange loi) 
  (cond [(empty? (rest loi)) loi]
        [else (cons (min-img loi) (arrange (rest-larger loi)))]))

;; (cons Image ListOfImage) -> Image
;; Produce the image that have the smallest area from given list of image

(check-expect (min-img (cons (rectangle 50 10 "solid" "black") empty)) 
              (rectangle 50 10 "solid" "black"))

(check-expect (min-img (cons (square 30 "solid" "red") 
                                    (cons (rectangle 50 10 "solid" "black") 
                                          empty))) 
              (rectangle 50 10 "solid" "black"))

(check-expect (min-img (cons (rectangle 50 10 "solid" "black") 
                                    (cons (square 30 "solid" "red") 
                                          empty))) 
              (rectangle 50 10 "solid" "black"))

;(define (min-img loi) (square 0 "solid" "black")) ; stub

(define (min-img loi) 
  (cond [(empty? (rest loi)) (first loi)]
        [(if (<= (area (first loi)) (area (min-img (rest loi))))
              (first loi)
              (min-img (rest loi)))]))


;; Image -> Natural
;; Produce the area of given image

(check-expect (area (square 0 "solid" "black")) 
              (* (image-width (square 0 "solid" "black"))
                 (image-height (square 0 "solid" "black"))))

(check-expect (area (rectangle 0 0 "solid" "black")) 
              (* (image-width (rectangle 0 0 "solid" "black"))
                 (image-height (rectangle 0 0 "solid" "black"))))

(check-expect (area (square 30 "solid" "black")) 
              (* (image-width (square 30 "solid" "black"))
                 (image-height (square 30 "solid" "black"))))

(check-expect (area (rectangle 10 20 "solid" "black")) 
              (* (image-width (rectangle 10 20 "solid" "black"))
                 (image-height (rectangle 10 20 "solid" "black"))))

;(define (area i) 0) ; stub

(define (area i) 
  (* (image-width i)
     (image-height i)))

;; (cons Image ListOfImage) -> ListOfImage
;; Produce the list of image except the smallest image from the given list of
;; image.

(check-expect (rest-larger (cons (square 30 "solid" "red") 
                                    (cons (rectangle 50 10 "solid" "black") 
                                          empty))) 
              (cons (square 30 "solid" "red") empty))

(check-expect (rest-larger (cons (rectangle 50 10 "solid" "black") 
                                    (cons (square 30 "solid" "red") 
                                          empty))) 
              (cons (square 30 "solid" "red") empty))

(check-expect (rest-larger (cons (rectangle 50 10 "solid" "black") 
                                    (cons (square 30 "solid" "red") 
                                          (cons (square 50 "solid" "red")
                                                empty))))
              (cons (square 30 "solid" "red") 
                    (cons (square 50 "solid" "red") 
                          empty)))

(check-expect (rest-larger (cons (square 30 "solid" "red") 
                                    (cons (rectangle 50 10 "solid" "black") 
                                          (cons (square 50 "solid" "red")
                                                empty))))
              (cons (square 30 "solid" "red") 
                    (cons (square 50 "solid" "red") 
                          empty)))

(check-expect (rest-larger (cons (square 50 "solid" "red") 
                                    (cons (rectangle 50 10 "solid" "black") 
                                          (cons (square 30 "solid" "red")
                                                empty))))
              (cons (square 50 "solid" "red") 
                    (cons (square 30 "solid" "red") 
                          empty)))

;(define (rest-larger loi) loi) ; stub

(define (rest-larger loi) 
  (cond [(empty? (rest (rest loi))) (if (<= (area (first loi)) (area (first (rest
                                                                       loi))))
                                      (rest loi)
                                      (cons (first loi) empty))]
        [else (if (equal? (first loi) (min-img loi))
              (rest loi)
              (cons (first loi) (rest-larger (rest loi))))]))

(test)

;(main (arrange-images (cons (square 50 "solid" "black")
                            ;(cons (square 10 "solid" "red") 
                                  ;(cons (square 30 "solid" "blue")
                                        ;(cons (square 25 "outline" "yellow")
                                            ;empty))))))
