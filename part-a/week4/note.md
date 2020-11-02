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
