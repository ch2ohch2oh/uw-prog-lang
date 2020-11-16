
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; 97/100 not perfect but I am ok with it

;; 1
(define (sequence low high stride)
  (if (> low high)
      '()
      (cons low (sequence (+ low stride) high stride))))

;; 2
(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))

;; 3
(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [(= (remainder n (length xs)) 0) (car xs)]
        [#t (list-nth-mod (cdr xs) (- (remainder n (length xs)) 1))]))

;; 4
(define (stream-for-n-steps s n)
  (if (= 0 n)
      null
      (let ([pr (s)])
        (cons (car pr) (stream-for-n-steps (cdr pr) (- n 1))))))

;; 5
;; A stream is a thunk that when called produces a pair
(define (funny-number-stream)
  (letrec ([f (lambda (x)
                (cons (if (= 0 (remainder x 5)) (- 0 x) x)
                      (lambda () (f (+ x 1)))))])
    (f 1)))

;; 6
(define (dan-then-dog)
  (letrec ([f (lambda (x)
                (if (= x 0)
                    (cons "dan.jpg" (lambda () (f 1)))
                    (cons "dog.jpg" (lambda () (f 0)))))])
    (f 0)))

;; 7
(define (stream-add-zero s)
  (let ([p (s)])
    (lambda ()
      (cons (cons 0 (car p)) (stream-add-zero (cdr p))))))

;; 8
(define (cycle-lists xs ys)
  (letrec ([f (lambda (n)
                (cons (cons (list-nth-mod xs n) (list-nth-mod ys n))
                      (lambda () (f (+ n 1)))))])
    (lambda () (f 0))))

;; 9
(define (vector-assoc v vec)
  (letrec ([f (lambda (i) (if (>= i (vector-length vec))
                              #f
                              (if (equal? v (car (vector-ref vec i)))
                                  (vector-ref vec i)
                                  (f (+ i 1)))))])
  (f 0)))

;; 10
(define (cached-assoc xs n)
  (letrec ([cache (make-vector n (cons #f #f))]
           [next 0]
           [f (lambda (v)
                (let ([ans (vector-assoc v cache)])
                  (if ans
                      ans
                      (let ([new-ans (assoc v xs)])
                        (if new-ans
                            (begin
                              (vector-set! cache next new-ans)
                              (set! next (remainder (+ next 1) n))
                              new-ans)
                            new-ans)))))])
    f))
