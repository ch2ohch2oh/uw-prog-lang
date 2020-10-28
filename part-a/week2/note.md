## Week 2

### Syntax vs semantics

Syntax: how you write down something

Semantics: what does it mean
- Type-checking (before the program runs)
- Evaluation (as the program runs)

For variables bindings:
- Type-check expression and extend the **static environment**
- Evalute the expresssion and extend the **dynamic environment**


### Expressions

Each kind of expression has
1. Syntax
2. Type-checking rules
3. Evaluation rules

### Values

All values are expressions.

Not all expressions are values.

### Shadowing

Expressions in variable bindings are evaluated eagerly.

### Functions

The syntax for a function:

    $ fun x0 (x1: t1, ..., xn: tn) = e

A function is a value!

In SML, a function cannot take variable number of arguments.

### Pairs and tuples

### Lists

A list can have any number of elements, but they have to
have the same type.

