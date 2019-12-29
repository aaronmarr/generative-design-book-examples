#lang racket

(require colors)
(require racket/draw)

(define width 800)
(define height 400)

(define target (make-bitmap width height))
(define dc (new bitmap-dc% [bitmap target]))

(define step-x (/ 360 4))
(define step-y (/ 360 8))

(send dc set-pen "white" 1 'transparent)

(for ([grid-y (range 0 400 step-y)])
  (for ([grid-x (range 0 800 step-x)])
    (define fill-color
      (make-object
       color%
       (hsl->color
        (hsl
         (/ grid-x width)
         (/ (- height grid-y) height)
         0.5))))
    (send dc set-brush fill-color 'solid)
    (send dc draw-rectangle grid-x grid-y step-x step-y)))

(send target save-file "test-file.png" 'png)
