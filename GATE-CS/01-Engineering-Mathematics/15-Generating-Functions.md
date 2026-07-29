# Generating Functions

> GATE Weightage: ⭐⭐⭐⭐

---

# What is a Generating Function?

A **Generating Function** is a power series used to represent a sequence.

Instead of writing a sequence directly, we encode it into a polynomial (or infinite series).

It is widely used for

- Solving Recurrence Relations
- Counting Problems
- Combinatorics
- Probability
- Dynamic Programming

---

# Definition

For a sequence

```
a₀,a₁,a₂,a₃,...
```

its generating function is

```
G(x)

=

a₀

+

a₁x

+

a₂x²

+

a₃x³

+ ...
```

or

```
∞

Σ

aₙxⁿ

n=0
```

---

# Example 1

Sequence

```
1

1

1

1

1
```

Generating Function

```
1+x+x²+x³+...
```

---

# Example 2

Sequence

```
1

2

3

4

5
```

Generating Function

```
1

+

2x

+

3x²

+

4x³

+...
```

---

# Standard Generating Functions

---

## Constant Sequence

Sequence

```
1

1

1

1
```

Generating Function

```
1

─────

1−x
```

Important Formula

```
1+x+x²+x³+...

=

1/(1−x)
```

---

## Natural Numbers

Sequence

```
1

2

3

4

5
```

Generating Function

```
1

────────

(1−x)²
```

---

## Squares

Sequence

```
1

4

9

16
```

Generating Function

```
x(x+1)

──────────

(1−x)³
```

---

## Powers of Two

Sequence

```
1

2

4

8

16
```

Generating Function

```
1

─────

1−2x
```

---

# Ordinary Generating Function (OGF)

The most common generating function.

Definition

```
G(x)

=

Σ aₙxⁿ
```

Used in almost all GATE questions.

---

# Exponential Generating Function (EGF)

Definition

```
Σ

aₙxⁿ

────

n!
```

Used mainly in advanced combinatorics.

Rare in GATE.

---

# Operations on Generating Functions

---

## Addition

If

```
A(x)

=

Σaₙxⁿ
```

and

```
B(x)

=

Σbₙxⁿ
```

Then

```
A(x)+B(x)

=

Σ(aₙ+bₙ)xⁿ
```

---

## Multiplication

Multiply like ordinary polynomials.

Coefficients follow

```
cₙ

=

Σ

aₖbₙ₋ₖ
```

This is called the **Cauchy Product**.

---

## Differentiation

If

```
G(x)

=

Σaₙxⁿ
```

Then

```
G'(x)

=

Σnaₙxⁿ⁻¹
```

Useful for deriving new generating functions.

---

## Integration

Can also be applied term-by-term.

Less common in GATE.

---

# Solving Recurrence Relations

Generating functions can convert recurrence relations into algebraic equations.

Example

```
aₙ=aₙ₋₁+1
```

Convert into

```
G(x)
```

Solve algebraically.

Extract coefficients.

---

# Fibonacci Generating Function

Recurrence

```
Fₙ

=

Fₙ₋₁

+

Fₙ₋₂
```

Generating Function

```
G(x)

=

x

──────────

1−x−x²
```

Very Important.

---

# Catalan Numbers

Generating Function

```
C(x)

=

1−√(1−4x)

──────────────

2x
```

Usually only the formula is asked.

---

# Binomial Expansion

Generating Function

```
(1+x)^n
```

Expansion

```
Σ

nCr

x^r
```

Important in counting problems.

---

# Geometric Series

Formula

```
1+x+x²+x³+...

=

1

─────

1−x
```

Condition

```
|x|<1
```

---

# Arithmetic Series

Formula

```
1+2x+3x²+...

=

1

────────

(1−x)²
```

---

# Useful Identities

```
1

──────

(1−x)^2

=

Σ

(n+1)xⁿ
```

---

```
1

──────

(1−x)^3

=

Σ

(n+2)(n+1)

──────────

2

xⁿ
```

---

```
e^x

=

Σ

xⁿ

───

n!
```

---

# Applications

Generating Functions are used in

- Counting Problems
- Combinatorics
- Dynamic Programming
- Probability
- Algorithm Analysis
- Solving Recurrence Relations

---

# Common GATE PYQs

- Ordinary Generating Function
- Geometric Series
- Fibonacci Generating Function
- Binomial Expansion
- Solving Recurrence Relations
- Coefficient Extraction
- Standard Generating Functions

---

# Quick Revision

✅ Generating Function

✅ Ordinary Generating Function

✅ Exponential Generating Function

✅ Geometric Series

✅ Arithmetic Series

✅ Fibonacci GF

✅ Cauchy Product

✅ Binomial Expansion

✅ Coefficient Extraction

---

# Common Mistakes

❌ Forgetting the index starts from

```
0
```

❌ Mixing OGF and EGF.

❌ Incorrect power of

```
(1−x)
```

in standard formulas.

❌ Forgetting the geometric series condition

```
|x|<1
```

❌ Confusing sequence terms with coefficients.

---

# Memory Tricks

### Definition

```
Sequence

↓

Power Series
```

---

### Constant Sequence

```
1

─────

1−x
```

---

### Natural Numbers

```
1

────────

(1−x)²
```

---

### Fibonacci

```
x

──────────

1−x−x²
```

---

### Geometric Series

```
1+x+x²+...

=

1/(1−x)
```

---

# Formula Sheet

| Sequence | Generating Function |
|-----------|---------------------|
| 1,1,1,... | `1/(1−x)` |
| 1,2,3,... | `1/(1−x)²` |
| 1,4,9,... | `x(x+1)/(1−x)³` |
| 1,2,4,8,... | `1/(1−2x)` |
| Fibonacci | `x/(1−x−x²)` |
| Binomial Expansion | `(1+x)^n` |

---

# PYQ Focus

⭐⭐⭐⭐

- Standard Generating Functions
- Geometric Series
- Fibonacci Generating Function
- Binomial Expansion
- Coefficient Extraction
- Recurrence Relations

---

# Final Revision Checklist (Discrete Mathematics)

- [ ] Propositional & First-Order Logic
- [ ] Sets
- [ ] Relations
- [ ] Functions
- [ ] Partial Orders
- [ ] Lattices
- [ ] Monoids
- [ ] Groups
- [ ] Graphs
- [ ] Connectivity
- [ ] Matching
- [ ] Colouring
- [ ] Combinatorics
- [ ] Recurrence Relations
- [ ] Generating Functions

---

# 1-Day Revision Strategy

### Morning (2 Hours)
- Logic
- Sets
- Relations
- Functions

### Afternoon (2 Hours)
- Partial Orders
- Lattices
- Monoids
- Groups

### Evening (2 Hours)
- Graphs
- Connectivity
- Matching
- Colouring

### Night (2 Hours)
- Combinatorics
- Recurrence Relations
- Generating Functions
- Solve 20–30 GATE PYQs

---

# GATE High-Priority Topics

⭐⭐⭐⭐⭐ Must Master

- Logic
- Relations
- Functions
- Graphs
- Combinatorics
- Recurrence Relations

⭐⭐⭐⭐

- Lattices
- Groups
- Generating Functions

⭐⭐⭐

- Matching
- Graph Colouring