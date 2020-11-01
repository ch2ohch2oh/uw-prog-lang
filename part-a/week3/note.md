## Week 3

### Building compound types

- Each of 
- One of
- Self reference

### Records

Records are like dictionaries in python.
```
val person = {name = "tom", age = 23}
#name person = "tom"
```

### Tuples as syntactic sugar

```
val a_tuple = {1 = "tom", 2 = "second field", 3 = "third"}
```

Why use syntactic sugar?
- Simplify the understanding of the language.
- Simplify the implementation of the language.

### Datatype bindings

One-of type:
```
datatype mytype = 
      TwoInts of int * int 
    | Str of string
    | Pizza
```

`TwoInts, Str, Pizza` are the constructors.

### Case expressions

Pattern matching!
```
fun f x = 
    case x of
        Pizza => 3
        | TwoInts(i1, i2) => i1 + i2
        | Str s => String.size s
```

### Useful datatypes

```
datatype cuit = Club | Diamond | Heart | Spade
datatype rank = Jack | Queen | King | Ace | Num of int
```

A more complex example
```
datatype exp = Constant of int
    | Negate of exp
    | Add of exp * exp
    | Multiply of exp * exp

fun eval e  =
    case e of
        Constant i         => i
        | Negate e2        => ~ (eval e2)
        | Add(e1, e2)      => (eval e1) + (eval e2)
        | Multiply(e1, e2) => (eval e1) * (eval e2)
```

### Type synonyms

Like `using` in C++.

```
type card = suit * rank
```

### List and options are datatypes

Options are datatypes.
```
fun inc_or_zero intoption = 
    case intoption of
        NONE => 0
        SOME i => i + 1
```
So as you see, `SOME` and `NONE` are constructors for options.

Lists are datatypes as well.
```
fun sum_list xs = 
    caes xs of
        [] => 0
        | x::xs' => x + sum_list(xs')
```

### Polymorphic datatypes

Defining polymorphic datatypes
```
datatype 'a option = NONE | SOME 'a
```

### Each of pattern matching

Bad example
```
fun sum_triple triple = 
    case triple of
        (x, y, z) => x + y + z

fun full_name r = 
    case r of
        {first=x, middle=y, last=z} =>
            x ^ " " ^ y " " ^ z
```

Better example
```
fun sum_triple t 
    let val (x, y, z) = t
    in
        x + y + z
    end
```
Even better
```
fun sum_triple (x, y, z) =
    x + y + z
```

Note all functions in ML takes only **one** argument, 
which can be a tuple.

### Type inference

### Polymorphic and equality types

Equality types
```
''a list * ''a ->  bool
```

### Nested patterns

Avoid nested `case of`.

### Function patterns

Define a function using patterns.
```
fun eval (Constant i) = i
  | eval (Negate e2) = ~ (eval e2)
  | eval (Add(e1,e2)) = (eval e1) + (eval e2)
  | eval (Multiply(e1,e2)) = (eval e1) * (eval e2)
```

### Tail recursion

Recusion just can be as efficient as a loop.

How to optimize tail recursion: **reuse the same 
call stack frame**.

Tail-recursive: recursive calls are tail-calls.
In other words, there is no more work to do
after the tail call.

One can use a accumulator the turn a recusive call
into a tail call.
