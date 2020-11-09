## Week 5

### Type inference

Static type checking can reject a program before
it runs to prevent the possibility of some errors.
This is a feature of **statically typed languages**.

### Mutual recursion

Use the `and` keyword.

```
fun f1 p1 = e1
and f2 p2 = e2
and f3 p3 = e3
```

### Modules

ML has structures to define modules

```
structure MyModule = struct bindings end
```

This provides namespace management to avoid 
shadowing.

### Signatures

A signature is a type of a module: it tells 
what binds does it have and what are their types.
This looks like the interfece in Java.

