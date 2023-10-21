#lang racket 

; PROBLEM:
;
; Eva is trying to decide where to go to university. One important factor for
; her is tuition costs. Eva is a visual thinker, and has taken Systematic
; Program Design, so she decides to design a program that will help her
; visualize the cost at different schools. She decide to start simply, knowing
; she can revise her  design later.
;
; The information she has so far is the names of some schools as well as their
; international tuition costs. She would like to be able to represent that
; information in bar charts.
;
; A. Design data definitions to represent the information Eva has.
; B. Design a function that consumes information about schools and their tuition
; and produces a bar charts.
; C. Design a function that consumes information about schools and their
; tuition and produces the school that have the tuition is smallest.

(require 2htdp/image)
(require test-engine/racket-tests)
(require 2htdp/universe)

;; Constant:

(define WIDTH 500)
(define HEIGHT 500)
(define CTR-X (/ WIDTH 2))
(define CTR-Y (/ HEIGHT 2))
(define SCALE 1/100)
(define MTS (empty-scene WIDTH HEIGHT))
(define BAR-WIDTH 20)
(define TEXT-COLOR "black")
(define TEXT-SIZE 15)

;; Data Definitions:

(define-struct school (name tuition))
;; School is (make-school String Natural)
;; interp. a school with school name and tuition cost in USA
(define S1 (make-school "KHTN" 9000))
(define S2 (make-school "BK" 5000))

;(define (fn-for-school s)
  ;(... (school-name s)
       ;(school-tuition s)))

;; Template rules used:
;; - compound: (make-school String Natural)

;; ListOfSchool is one of:
;; - empty
;; - (cons School ListOfSchool)
;; interp. list of schools
(define LOS1 empty)
(define LOS2 (cons S1 empty))
(define LOS3 (cons S2 (cons S1 empty)))

;(define (fn-for-los los)
  ;(cond [(empty? los) (...)]
        ;[else (... (fn-for-school (first los))
                   ;(fn-for-los (rest los)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons School ListOfSchool)
;;
;; - reference: School
;; - self-reference: (rest s) ListOfSchool


;; Functions:

(define (main los)
  (big-bang los ;; ListOfSchool
     (on-draw gen-bar-char))) ; ListOfSchool -> Image

;; ListOfSchool -> Image
;; Produce a bar chart showing tuition cost and name of given schools
;(define (gen-bar-char los) MTS) ; stub

(check-expect (gen-bar-char empty) (square 0 "solid" "white"))

(check-expect (gen-bar-char (cons (make-school "School 1" 8000) empty)) 
    (beside/align "bottom"
      (overlay/align "center" "bottom"
        (rotate 90 (text "School 1" TEXT-SIZE TEXT-COLOR))
        (rectangle BAR-WIDTH (* 8000 SCALE) "solid" "lightblue"))
      (square 0 "solid" "white")))

(check-expect (gen-bar-char (cons (make-school "School 1" 8000) 
                                  (cons (make-school "School 2" 10000) 
                                        empty))) 
    (beside/align "bottom"

      (overlay/align "center" "bottom"
        (rotate 90 (text "School 1" TEXT-SIZE TEXT-COLOR))
        (rectangle BAR-WIDTH (* 8000 SCALE) "solid" "lightblue"))

      (overlay/align "center" "bottom"
        (rotate 90 (text "School 2" TEXT-SIZE TEXT-COLOR))
        (rectangle BAR-WIDTH (* 10000 SCALE) "solid" "lightblue"))

      (square 0 "solid" "white")))

(define (gen-bar-char los)
    (cond [(empty? los) (square 0 "solid" "white")]
          [else (beside/align "bottom" 
                  (gen-single-bar (first los))
                  (gen-bar-char (rest los)))]))

;; School -> Image
;; Produce a single bar that show the given name and tuition cost of consumes
;; school.

;(define (gen-single-bar s) MTS) ; stub

(check-expect (gen-single-bar (make-school "School 1" 8000))
      (overlay/align "center" "bottom"
        (rotate 90 (text "School 1" TEXT-SIZE TEXT-COLOR))
        (rectangle BAR-WIDTH (* 8000 SCALE) "solid" "lightblue"))
      )

(define (gen-single-bar s)
      (overlay/align "center" "bottom"
        (rotate 90 (text (school-name s) TEXT-SIZE TEXT-COLOR))
        (rectangle BAR-WIDTH (* (school-tuition s) SCALE) "solid" "lightblue"))
      )

(test)
(main (cons (make-school "KHTN" 10000) LOS3))


















