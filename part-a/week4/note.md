## Week 4

### What is functional programming

Functional programming can mean:
1. Avoid mutation in all/most cases
2. Using functions as values

First-class functions mean we can use functions 
as values.

Function closure: Functions can use 
bindings from outside the function definition.

### Functions as arguments

### Type of the function

Given this function
```
fun n_times (f,n,x) = 
    if n=0
    then x
    else f (n_times(f,n-1,x))
```

Its type is 
```
('a -> 'a) * int * 'a -> 'a
```

### Anonymous functions

Nothing surprising. Must use the `fn` keyword.

### Map and filter

This is classic.
```
fun map (f,xs) =
    case xs of
	[] => []
      | x::xs' => (f x)::(map(f,xs'))
```

### Lexical scope

Lexical scope: The function bodies can use any bindings
in the scope **where the function is defined**.

A function value has two parts:
1. The code
2. The environment that **was** current when the function was defined.
This pair is called the **function closure**.


### Lexical score vs dynamic scope

Lexical scope: use environment where the function is defined

Dynamic scope: use environment where the function is called

There are technical reasons where lexical scope is better.
1. Function meaning does not depend on variable names used.
2. Functions can be type-checked and reasoned about where defined.
3. Closures can easily store the data they need.

### Closure

A function body is not evaluated until the function is called.

### Fold

Another classic higher order function.
```
fun fold (f,acc,xs) =
    case xs of 
	[] => acc
      | x::xs' => fold (f,f(acc,x),xs')
```

### Combining functions

Note the function composition operator in ML is the lower letter `o`.
```
fun sqrt_of_abs i = Math.sqrt(Real.fromInt (abs i))

fun sqrt_of_abs i = (Math.sqrt o Real.fromInt o abs) i
```

### Currying

"Currying" is named after the famous logician Haskell Curry.

Every ML function takes exactly one argument. 
Mutiple arguments can be encoded as one n-tuple. 
One can also take one argument and return a function that 
takes another argument and ...

An example: 
```
val sorted3 = fn x => fn y => fn z => z >= y andalso y >= x

(* syntactic sugar for defining curried functions: space between arguments *)
fun sorted3_nicer x y z = z >= y andalso y >= x
```
The type of `sorted3` is 
```
val sorted3 = fn : int -> int -> int -> bool
```

### Partial application

### Mutable references

New expressions
- `refe e` to create a reference with content `e`
- `e1 := e2` to update content
- `!e` to retrieve contents

### Callbacks

Callbacks are executed for side-effect.

### ML standard library

www.standardml.org/Basics/manPages.html

