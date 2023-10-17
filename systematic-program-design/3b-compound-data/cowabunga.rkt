#lang racket

; PROBLEM: As we learn in the cat world program, cats have a mind of their own.
; When they reach the edge they just keep walking out of the window.

; Cows on the other hand are docile creatures. They stay inside the fence,
; walking back and forth nicely.

; Design a world program with the following behaviour:
; - A cow walks back and forth across the screen.
; - When it gets to an edge it changes direction and goes back the other way
; - When you start the program it should be possible to control how fast a
; walker your cow is.
; Pressing space make it change direction right away.

; One your program works here is something you can try for fun. If you rotate
; the images of the cow slightly, and you vary the image you use as the cow
; moves, you can make it appear as if the cow is wadding as it walks across the
; screen.

; Also to make it look better, arrange for the cow to change direction when its
; nose hits the edge of the window, not the center of its body.


;; Domain Analysis:

;; Constant:
;; - width
;; - height
;; - ctr-y
;; - mts
;; - cow images

;; Changing:
;; - x coordinate of cow
;; - x velocity of cow

;; big-bang options:
;; - on-tick
;; - to-draw
;; - on-key

;; Implementation:

(require 2htdp/image)
(require 2htdp/universe)
(require test-engine/racket-tests)

;; Constant:
(define WIDTH 400)
(define HEIGHT 200)
(define CTR-Y (/ HEIGHT 2))
(define MTS (empty-scene WIDTH HEIGHT))
(define COW-IMG (scale 1/10 (bitmap "photos/cow.png")))
(define REV-COW-IMG (flip-horizontal COW-IMG))

;; Data Definitions:
(define-struct cow (x dx))
;; Cow is (make-cow Natural[0, WIDTH], Integer)
;; interp. (make-cow x dx) is a cow with x coordinate x and velocity dx.
        ;; the x is the center of the cow
        ;; x is in screen coordinates (pixels)
        ;; dx is in pixels per tick

(define C1 (make-cow 10 2)) ; at 10, moving left -> right 2 pixels per tick
(define C2 (make-cow 0 -2)) ; at 0, moving right - left 2 pixels per tickt

;(define (fn-for-cow c) 
  ;(... (cow-x c)
       ;(cow-dx c)))

;; Template rules used:
;; - compound: 2 fields


;; Functions:

(define (main c)
  (big-bang c ; Cow
            (on-tick advance-cow) ; Cow -> Cow
            (on-key handle-key) ; Cow KeyEvent -> Cow
            (to-draw render))) ; Cow -> Image


;; Cow dx -> Cow
;; produce next cow, by update the velocity dx with given velocity
;(define (update-cow-velocity c dx) (make-cow 0 0)); stub

(check-expect (cow-x (update-cow-velocity (make-cow 0 2) 0)) 0)
(check-expect (cow-dx (update-cow-velocity (make-cow 0 2) 0)) 0)

(check-expect (cow-x (update-cow-velocity (make-cow 10 2) -2)) 10)
(check-expect (cow-dx (update-cow-velocity (make-cow 10 2) -2)) -2)

(check-expect (cow-x (update-cow-velocity (make-cow 10 -2) 2)) 10)
(check-expect (cow-dx (update-cow-velocity (make-cow 10 -2) 2)) 2)

(check-expect (cow-x (update-cow-velocity (make-cow 10 2) 0)) 10)
(check-expect (cow-dx (update-cow-velocity (make-cow 10 2) 0)) 0)


(define (update-cow-velocity c dx) 
  (make-cow (cow-x c) dx))


;; Cow -> Cow
;; Produce next cow, by advancing it cow-dx pixel(s). 
;; if cow reaches the edge then change direction of the cow 
;(define (advance-cow c) (make-cow 0 0)) ; stub

(check-expect (cow-x (advance-cow (make-cow 50 2))) (+ 50 2))
(check-expect (cow-dx (advance-cow (make-cow 50 2))) 2)

(check-expect (cow-x (advance-cow (make-cow 50 -2))) (+ 50 -2))
(check-expect (cow-dx (advance-cow (make-cow 50 -2))) -2)

;; Test change direction
(check-expect (cow-x (advance-cow (make-cow 0 -2))) 2)
(check-expect (cow-dx (advance-cow (make-cow 0 -2))) 2)

(check-expect (cow-x (advance-cow (make-cow WIDTH 2))) (+ WIDTH -2))
(check-expect (cow-dx (advance-cow (make-cow WIDTH 2))) -2)

(define (advance-cow c) 
  (cond [(<= (cow-x c) 0) (make-cow (+ 0 (abs (cow-dx c))) (abs (cow-dx c)))]
        [(>= (cow-x c) WIDTH) (make-cow (+ WIDTH (- (abs (cow-dx c)))) (- (abs (cow-dx c))))]
        [else (make-cow (+ (cow-x c) (cow-dx c)) (cow-dx c))]))


;; Cow KeyEvent -> Cow
;; Press space key to change the cow moving direction
;(define (handle-key c key)
  ;(cond [(key=? key " ") (make-cow 0 0)]
        ;[else (make-cow 0 0)])) ;stub

(check-expect (cow-x (handle-key (make-cow 10 2) " ")) 10)
(check-expect (cow-dx (handle-key (make-cow 10 2) " ")) (- 2))

(check-expect (cow-x (handle-key (make-cow 10 -2) " ")) 10)
(check-expect (cow-dx (handle-key (make-cow 10 -2) " ")) (- -2))

(check-expect (cow-x (handle-key (make-cow 10 -2) "a")) 10)
(check-expect (cow-dx (handle-key (make-cow 10 -2) "a")) -2)

(define (handle-key c key)
  (cond [(key=? key " ") (make-cow (cow-x c) (- (cow-dx c)))]
        [else c]))


;; Cow -> Image
;; Render the given cow on the MTS
;; if cow move left -> right, use COW-IMG
;; if cow move right -> left use REV-COW-IMG
;(define (render c)
  ;MTS) ; stub

(check-expect (render (make-cow 10 2)) (place-image COW-IMG 10 CTR-Y MTS))
(check-expect (render (make-cow 10 -2)) (place-image REV-COW-IMG 10 CTR-Y MTS))

;; Error: 1 function do 2 tasks -> use helper functions
;(define (render c) 
  ;(cond [(>= (cow-dx c) 0) (place-image COW-IMG (cow-x c) CTR-Y MTS)]
        ;[else (place-image REV-COW-IMG (cow-x c) CTR-Y MTS)]))

(define (render c) 
  (place-image (choose-img c) (cow-x c) CTR-Y MTS))

;; Cow -> Image
;; Produce the property cow image by given Cow dx
;; If cow-dx is >= 0 (left -> right) then produce COW-IMG
;; If cow-dx is < 0 (right -> left) then produce REV-COW-IMG
;(define (choose-img c) COW-IMG) ; stub

(check-expect (choose-img (make-cow 10 2)) COW-IMG)
(check-expect (choose-img (make-cow 10 -2)) REV-COW-IMG)

(define (choose-img c) 
  (if (>= (cow-dx c) 0) COW-IMG REV-COW-IMG))

(test)

(display "Input velocity: ")
(define VELOCITY (string->number (read-line (current-input-port) 'any)))

(main (make-cow 0 VELOCITY))





