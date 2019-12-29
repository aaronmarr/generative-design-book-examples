#lang racket

(require colors)
(require racket/draw)

(define segment-count 33)
(define angle-step (/ 360 segment-count))

(define width 800)
(define height 800)

(define radius (/ width 2))

(define target (make-bitmap width height))
(define dc (new bitmap-dc% [bitmap target]))

(send dc set-pen "white" 1 'transparent)

(for ([current-angle (range 0 360 angle-step)])
  (define path (new dc-path%))

  (define fill-color
    (hsl->color
      (hsl
       (/ current-angle 360)
       0.6
       0.5)))

  (define point-x
    (+
     (/ width 2)
     (*
      (cos (degrees->radians current-angle))
      radius)))

  (define point-y
    (+
     (/ height 2)
     (*
      (sin (degrees->radians current-angle))
      radius)))

  (define point-x-prev
    (+
     (/ width 2)
     (*
      (cos (degrees->radians (- current-angle angle-step)))
      radius)))

  (define point-y-prev
    (+
     (/ height 2)
     (*
      (sin (degrees->radians (- current-angle angle-step)))
      radius)))

  (send path move-to (/ width 2) (/ height 2))

  (send path line-to point-x point-y)
  (send path line-to point-x-prev point-y-prev)
  (send path line-to (/ width 2) (/ height 2))

  (send path close)

  (send dc set-brush fill-color 'solid)
  (send dc draw-path path))

(send target save-file "test-file.png" 'png)
