# Limits

> GATE Weightage: ⭐⭐⭐⭐☆

---

# Why Do We Need Limits?

Suppose a function is **not defined** at a particular point.

Example

```
      x²−1
f(x)=-------
      x−1
```

At

```
x=1
```

the denominator becomes

```
0
```

So the function is undefined.

But what value does the function **approach** as

```
x→1
```

Limits answer this question.

They form the foundation of

- Differentiation
- Integration
- Continuity
- Calculus

---

# Intuition

Think of walking toward a door.

You may never touch it, but you keep getting closer.

Similarly,

```
Limit
```

is the value a function approaches as

```
x
```

gets closer to a point.

---

# Definition

The limit of a function

```
f(x)
```

as

```
x→a
```

is

```
L
```

if

```
f(x)
```

gets arbitrarily close to

```
L
```

Notation

```
lim f(x)

x→a
```

---

# Example

Find

```
      x²−1
lim -------
x→1  x−1
```

Factor numerator

```
(x−1)(x+1)
```

Cancel

```
x−1
```

Now

```
lim (x+1)

x→1
```

Substitute

```
1+1=2
```

Answer

```
2
```

---

# Left-Hand Limit (LHL)

Approaching from the left.

Notation

```
lim f(x)

x→a⁻
```

Example

```
x→2⁻
```

means

```
1.9

1.99

1.999

...
```

---

# Right-Hand Limit (RHL)

Approaching from the right.

Notation

```
lim f(x)

x→a⁺
```

Example

```
2.1

2.01

2.001

...
```

---

# Existence of Limit

A limit exists only when

```
LHL

=

RHL
```

If

```
LHL

≠

RHL
```

then

```
Limit Does Not Exist
```

Very Important.

---

# Types of Limits

```
Limits
│
├── Finite Limits
├── Infinite Limits
├── One-sided Limits
├── Limits at Infinity
└── Indeterminate Forms
```

---

# Finite Limits

Example

```
lim (3x+1)

x→2
```

Substitute

```
7
```

---

# Infinite Limits

Example

```
     1
lim ----

x→0 x²
```

Answer

```
∞
```

The function grows without bound.

---

# Limits at Infinity

Example

```
      5x²+1
lim ----------
x→∞ 2x²+4
```

Divide by

```
x²
```

```
5+1/x²
--------

2+4/x²
```

As

```
x→∞
```

```
1/x²→0
```

Answer

```
5/2
```

---

# Direct Substitution

Always try direct substitution first.

If no undefined form appears,

you are done.

Example

```
lim (4x+3)

x→2
```

Answer

```
11
```

---

# Indeterminate Forms

Sometimes direct substitution gives

```
0/0
```

or

```
∞/∞
```

These are called

```
Indeterminate Forms
```

Common forms

```
0/0

∞/∞

0×∞

∞−∞

0⁰

1^∞

∞⁰
```

---

# Methods to Evaluate Limits

```
0/0

↓

Factorization
```

---

```
↓

Rationalization
```

---

```
↓

Common Denominator
```

---

```
↓

L'Hospital's Rule
```

(Usually beyond GATE CSE syllabus, but good to know.)

---

# Factorization Method

Example

```
      x²−9
lim -------
x→3  x−3
```

Factor

```
(x−3)(x+3)
```

Cancel

```
x−3
```

Answer

```
6
```

---

# Rationalization

Useful when square roots are involved.

Example

```
      √x−2
lim --------

x→4  x−4
```

Multiply by the conjugate

```
√x+2
```

Simplify.

---

# Polynomial Limits

Simply substitute.

Example

```
lim (x³+2x)

x→2
```

Answer

```
12
```

---

# Rational Function Limits

If denominator ≠ 0,

substitute directly.

Otherwise,

simplify first.

---

# Limits Involving Absolute Value

Example

```
lim |x|

x→0
```

Left

```
0
```

Right

```
0
```

Limit exists.

---

Example

```
      x
lim ----

x→0 |x|
```

Left

```
-1
```

Right

```
1
```

Limit does **not** exist.

Very common concept.

---

# Squeeze Theorem

If

```
g(x)

≤

f(x)

≤

h(x)
```

and

```
lim g(x)

=

lim h(x)

=

L
```

then

```
lim f(x)

=

L
```

Useful in trigonometric limits.

---

# Important Standard Limits

### 1

```
      sinx
lim -------
x→0    x

=

1
```

---

### 2

```
      tanx
lim -------
x→0    x

=

1
```

---

### 3

```
      1−cosx
lim --------

x→0     x²

=

1/2
```

---

### 4

```
      ex−1
lim -------
x→0   x

=

1
```

---

### 5

```
      lnx
lim -----

x→1 x−1

=

1
```

These are frequently used in Calculus.

---

# Algebra of Limits

If

```
lim f(x)=L

lim g(x)=M
```

Then

### Sum

```
L+M
```

---

### Difference

```
L−M
```

---

### Product

```
LM
```

---

### Quotient

```
L/M

(M≠0)
```

---

### Constant

```
lim c

=

c
```

---

# Infinite Limits vs Does Not Exist

```
∞
```

means

The function grows without bound.

It is **not** the same as

```
Limit Does Not Exist
```

Example

```
1/x²
```

has limit

```
∞
```

at

```
x→0
```

---

```
x/|x|
```

has **no limit**

because

```
LHL≠RHL
```

---

# Common GATE PYQs

- One-sided limits
- Indeterminate forms
- Standard trigonometric limits
- Rationalization
- Factorization
- Limits at infinity
- Absolute value limits

---

# Quick Revision

✅ Limit

✅ Left-Hand Limit

✅ Right-Hand Limit

✅ Existence of Limit

✅ Indeterminate Forms

✅ Factorization

✅ Rationalization

✅ Standard Limits

✅ Squeeze Theorem

---

# Common Mistakes

❌ Forgetting to compare **LHL** and **RHL**.

❌ Directly substituting when the result is

```
0/0
```

❌ Confusing

```
∞
```

with

```
Does Not Exist
```

❌ Forgetting standard trigonometric limits.

❌ Cancelling terms before factorization.

---

# Memory Tricks

### Limit Exists

```
LHL

=

RHL
```

---

### First Step

```
Always

Substitute

First
```

---

### 0/0

```
↓

Factor

↓

Cancel

↓

Substitute
```

---

### Infinity

```
Highest Power

Wins
```

(Divide numerator and denominator by the highest power of x.)

---

# Formula Sheet

| Formula | Result |
|----------|--------|
| Limit Exists | `LHL = RHL` |
| `lim(x→0) sinx/x` | `1` |
| `lim(x→0) tanx/x` | `1` |
| `lim(x→0) (1-cosx)/x²` | `1/2` |
| `lim(x→0) (eˣ-1)/x` | `1` |
| `lim(x→1) ln(x)/(x-1)` | `1` |

---

# PYQ Focus

⭐⭐⭐⭐☆

- One-Sided Limits
- Standard Limits
- Factorization
- Rationalization
- Limits at Infinity
- Indeterminate Forms

---

# Interview Corner

### Q1. What is the difference between a function value and a limit?

The **function value** is the value at a specific point, whereas the **limit** is the value the function approaches as the input gets arbitrarily close to that point. A limit may exist even if the function is undefined there.

---

### Q2. When does a limit exist?

A limit exists if and only if the **Left-Hand Limit (LHL)** equals the **Right-Hand Limit (RHL)**.

---

### Q3. What should you do first while solving a limit?

Always try **direct substitution**. If it results in an indeterminate form like `0/0` or `∞/∞`, then simplify using factorization, rationalization, or other appropriate techniques.

---

# Next File

➡️ `22-Continuity-and-Differentiability.md`