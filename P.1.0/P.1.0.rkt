#lang racket

(require colors)
(require racket/draw)

(define target (make-bitmap 720 720))
(define dc (new bitmap-dc% [bitmap target]))

(define angle-in-deg (random 360))

(define bg-size 720)
(define fg-size (random bg-size))
(define offset (/ (- bg-size fg-size) 2))

(define bg-color
  (make-object
   color%
   (hsl->color
    (hsl
     (/ angle-in-deg 360)
     0.5
     0.5))))

(define fg-color
  (make-object
   color%
   (hsl->color
    (hsl
     (/ ((lambda (deg)
           (if (<= deg 179)
               (+ deg 180)
               (- deg 180))) angle-in-deg) 360)
     0.5
     0.5))))

(send dc set-pen "white" 1 'transparent)
(send dc set-brush bg-color 'solid)
(send dc draw-rectangle
      0 0
      bg-size bg-size)

(send dc set-brush fg-color 'solid)
(send dc draw-rectangle
      offset offset
      fg-size fg-size)

(send target save-file "test-file.png" 'png)
