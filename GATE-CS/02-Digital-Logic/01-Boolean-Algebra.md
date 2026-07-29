# Boolean Algebra

> Difficulty: ⭐⭐⭐☆☆
> GATE Weightage: ⭐⭐⭐⭐⭐
> Interview Importance: ⭐⭐⭐⭐⭐
> Prerequisites: Binary Number System, Basic Logic Gates
> Time Required: 3-5 Hours

---

# Why Should You Study Boolean Algebra?

Boolean Algebra is the mathematical language used by every digital system. Every processor, memory chip, calculator, mobile phone, and computer performs logical operations using Boolean Algebra.

### Real World Applications

- CPU instruction execution
- ALU (Arithmetic Logic Unit)
- Digital circuit design
- Microprocessors
- FPGA and ASIC design
- Embedded Systems
- Computer Architecture
- Logic optimization in VLSI
- Error detection circuits
- Switching circuits

### Why GATE Asks This Topic

Boolean Algebra forms the foundation of:

- Karnaugh Maps
- Logic Minimization
- Combinational Circuits
- Sequential Circuits
- Computer Organization
- Digital Electronics

Almost every year, GATE asks at least one question directly or indirectly from Boolean Algebra.

---

# Learning Outcomes

After completing this chapter, you should be able to:

- Understand Boolean variables
- Write Boolean expressions
- Simplify expressions
- Apply Boolean laws quickly
- Solve GATE Boolean Algebra questions
- Design optimized logic circuits

---

# Introduction

Normal Algebra deals with numbers.

Boolean Algebra deals with **logical values**.

There are only two possible values.

| Value | Meaning |
|--------|----------|
| 0 | False / LOW / OFF |
| 1 | True / HIGH / ON |

Unlike normal algebra,

```
2 + 2 = 4
```

In Boolean Algebra,

```
1 + 1 = 1
```

because '+' represents **OR**, not arithmetic addition.

---

# History

Boolean Algebra was developed by

> **George Boole (1854)**

His work became the mathematical foundation of Digital Electronics and Modern Computers.

---

# Binary Logic

Every digital system understands only two voltages.

Example

```
5V  → 1

0V  → 0
```

Everything inside a processor is represented using these two states.

---

# Boolean Variables

A Boolean variable stores only one of two values.

Example

```
A = 0

B = 1
```

Possible values are

```
0

1
```

Nothing else.

---

# Boolean Constants

| Constant | Meaning |
|----------|----------|
| 0 | False |
| 1 | True |

---

# Boolean Operators

There are only three fundamental operators.

## AND

Symbol

```
A · B

AB
```

Meaning

Output becomes 1 only when both inputs are 1.

Truth Table

| A | B | Output |
|---|---|--------|
|0|0|0|
|0|1|0|
|1|0|0|
|1|1|1|

---

## OR

Symbol

```
A + B
```

Output becomes 1 if at least one input is 1.

Truth Table

|A|B|Output|
|--|--|------|
|0|0|0|
|0|1|1|
|1|0|1|
|1|1|1|

---

## NOT

Symbol

```
A'
```

or

```
Ā
```

Truth Table

|A|Output|
|--|------|
|0|1|
|1|0|

---

# Operator Precedence

Always remember this order.

```
1. NOT

2. AND

3. OR
```

Example

```
A + BC'

↓

NOT

↓

AND

↓

OR
```

---

# Boolean Expressions

Example

```
F = AB + A'C
```

Read as

```
(A AND B)

OR

(NOT A AND C)
```

---

# Truth Table Generation

Example

```
F = AB + C
```

Steps

1. List all input combinations.
2. Compute intermediate terms.
3. Find final output.

For **n variables**

Number of rows

```
2ⁿ
```

Examples

| Variables | Rows |
|-----------|------|
|1|2|
|2|4|
|3|8|
|4|16|
|5|32|

⭐ **GATE Favorite Formula**

```
Rows = 2ⁿ
```

---

# Principle of Duality

Every Boolean expression has a **dual**.

To obtain the dual:

- Replace AND (·) with OR (+)
- Replace OR (+) with AND (·)
- Replace 0 with 1
- Replace 1 with 0
- Do **not** change variables or complements

Example:

Original:
```
A + 0 = A
```

Dual:
```
A · 1 = A
```

> If a Boolean identity is true, its dual is also true.

---

# Principle of Complementation

Replacing every variable with its complement and every operator with its dual gives the complemented form.

Example:

```
(A + B)' = A'B'
```

This is one of DeMorgan's Theorems.

---

# Important Symbols

| Symbol | Meaning |
|--------|----------|
| + | OR |
| · or no symbol | AND |
| ' | NOT |
| () | Priority |
| = | Equality |

---

# Important Observations

- Boolean Algebra is **not** ordinary mathematics.
- There are only two values: 0 and 1.
- '+' means OR, not addition.
- Multiplication means AND.
- Complement means inversion.

---

# Quick Check

Can you answer these?

1. How many values can a Boolean variable take?
2. What is the precedence of Boolean operators?
3. What is the formula for the number of rows in a truth table?
4. Who developed Boolean Algebra?
5. Why is Boolean Algebra important in computer architecture?

If you can answer all five without looking back, you're ready to move on to the Boolean Laws section.

---

# Summary

- Boolean Algebra is the mathematical foundation of digital logic.
- It uses only two values: 0 and 1.
- Three basic operators: AND, OR, and NOT.
- Truth tables describe logical behavior.
- Duality and complementation are fundamental concepts.
- Mastering these basics makes simplification and circuit design much easier.

---

# Next Topic

➡️ **Basic Laws of Boolean Algebra**