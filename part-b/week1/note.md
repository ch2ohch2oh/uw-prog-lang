## Week 1

Unlike ML, Racket has no static type system.
Most errors need to be checked at runtime.

## Racket syntax

A term in Racket is either:
- An atom. eg #t, #f, 123, "hi", ...
- A special form, e.g. `define`, `lambda` ...
- A sequence of terms in parens: `(t1 t2 ... tn)`
    * If `t1` is a special form, the semantics of 
    the sequence is special.
    * Else a function call

## Delayed evaluation

In ML, Racket, Java and C,
- Function arguments are eager
- Conditional branches are not eager

A zero-arugment function used to delay the evaluation 
is called a **thunk**.

```
(define (my-if x y z)
    (if x (y) (z)))
```
