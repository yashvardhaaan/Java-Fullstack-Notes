# Recurrence Relations

> GATE Weightage: ⭐⭐⭐⭐

---

# What is a Recurrence Relation?

A **Recurrence Relation** is an equation that defines a sequence using one or more previous terms.

Instead of giving a direct formula, each term is computed from earlier terms.

Example

```
aₙ = aₙ₋₁ + 2
```

If

```
a₁ = 1
```

Then

```
1

3

5

7

9
```

---

# General Form

```
aₙ = f(aₙ₋₁,aₙ₋₂,...)
```

where

```
n ≥ k
```

---

# Initial Conditions

A recurrence relation is incomplete without initial values.

Example

```
aₙ=aₙ₋₁+2
```

Needs

```
a₁
```

Otherwise the sequence cannot be generated.

---

# Examples

## Example 1

```
aₙ=aₙ₋₁+3

a₁=2
```

Sequence

```
2

5

8

11

14
```

---

## Example 2 (Fibonacci)

```
Fₙ

=

Fₙ₋₁

+

Fₙ₋₂
```

Initial Conditions

```
F₀=0

F₁=1
```

Sequence

```
0

1

1

2

3

5

8

13
```

---

# Order of a Recurrence

The order is determined by the largest previous term used.

Example

```
aₙ=aₙ₋₁+5
```

Order

```
1
```

---

Example

```
aₙ

=

aₙ₋₁

+

aₙ₋₂
```

Order

```
2
```

---

# Degree

The degree is the highest power of the highest-order term (after removing radicals and fractions).

Example

```
aₙ=aₙ₋₁²
```

Degree

```
2
```

---

# Types of Recurrence Relations

```
Recurrence Relations
│
├── Linear
├── Non-Linear
├── Homogeneous
├── Non-Homogeneous
├── First Order
└── Higher Order
```

---

# Linear Recurrence

Every term appears only to the first power.

Example

```
aₙ

=

2aₙ₋₁

+

5
```

---

# Non-Linear Recurrence

Contains powers, products, or other nonlinear operations.

Example

```
aₙ

=

(aₙ₋₁)²
```

---

# Homogeneous Recurrence

Contains only previous terms.

Example

```
aₙ

=

2aₙ₋₁

+

3aₙ₋₂
```

---

# Non-Homogeneous Recurrence

Contains an additional function of

```
n
```

Example

```
aₙ

=

2aₙ₋₁

+

5
```

---

# Solving First-Order Recurrence

Example

```
aₙ=aₙ₋₁+2

a₁=1
```

Expand

```
a₂=3

a₃=5

a₄=7
```

General Formula

```
aₙ

=

2n−1
```

---

# Characteristic Equation Method

Used for solving linear homogeneous recurrences.

Example

```
aₙ

=

5aₙ₋₁

−

6aₙ₋₂
```

Assume

```
aₙ=rⁿ
```

Then

```
r²−5r+6=0
```

Roots

```
2

3
```

Solution

```
aₙ

=

A·2ⁿ

+

B·3ⁿ
```

Use initial conditions to find

```
A

B
```

---

# Cases of Characteristic Roots

## Distinct Roots

```
r₁

≠

r₂
```

Solution

```
A(r₁)ⁿ+B(r₂)ⁿ
```

---

## Repeated Roots

```
r₁=r₂=r
```

Solution

```
(A+Bn)rⁿ
```

---

## Complex Roots

```
α±βi
```

Use trigonometric form.

Rare in GATE.

---

# Master Theorem

Used for divide-and-conquer recurrences.

General Form

```
T(n)

=

aT(n/b)

+

f(n)
```

---

## Case 1

If

```
f(n)

=

O(n^(logba−ε))
```

Then

```
T(n)

=

Θ(n^(logba))
```

---

## Case 2

If

```
f(n)

=

Θ(n^(logba)log^k n)
```

Then

```
T(n)

=

Θ(n^(logba)log^(k+1)n)
```

---

## Case 3

If

```
f(n)

=

Ω(n^(logba+ε))
```

and regularity condition holds,

Then

```
T(n)

=

Θ(f(n))
```

Very Important in GATE Algorithms.

---

# Common Recurrence Examples

## Fibonacci

```
Fₙ

=

Fₙ₋₁

+

Fₙ₋₂
```

---

## Tower of Hanoi

```
T(n)

=

2T(n−1)

+

1
```

Solution

```
2ⁿ−1
```

---

## Binary Search

```
T(n)

=

T(n/2)

+

1
```

Solution

```
Θ(log n)
```

---

## Merge Sort

```
T(n)

=

2T(n/2)

+

n
```

Solution

```
Θ(n log n)
```

---

## Quick Sort (Average)

```
Θ(n log n)
```

---

# Applications

- Dynamic Programming
- Divide-and-Conquer Algorithms
- Algorithm Analysis
- Counting Problems
- Graph Algorithms
- Tree Algorithms

---

# Common GATE PYQs

- Solve linear recurrence
- Find order and degree
- Characteristic equation
- Fibonacci sequence
- Master Theorem
- Tower of Hanoi
- Binary Search
- Merge Sort
- Closed-form solution

---

# Quick Revision

✅ Recurrence Relation

✅ Initial Conditions

✅ Order

✅ Degree

✅ Linear

✅ Non-Linear

✅ Homogeneous

✅ Non-Homogeneous

✅ Characteristic Equation

✅ Distinct Roots

✅ Repeated Roots

✅ Master Theorem

---

# Common Mistakes

❌ Forgetting initial conditions.

❌ Mixing homogeneous and non-homogeneous recurrences.

❌ Incorrect characteristic equation.

❌ Using the wrong Master Theorem case.

❌ Confusing order with degree.

---

# Memory Tricks

### Order

```
Largest Previous Term Used
```

---

### Degree

```
Highest Power
```

---

### Characteristic Equation

```
Assume

aₙ=rⁿ
```

---

### Tower of Hanoi

```
2ⁿ−1
```

---

### Merge Sort

```
n log n
```

---

### Binary Search

```
log n
```

---

# Formula Sheet

| Concept | Formula |
|----------|---------|
| First Order | Depends on one previous term |
| Second Order | Depends on two previous terms |
| Characteristic Equation | Assume `aₙ = rⁿ` |
| Distinct Roots | `A(r₁)ⁿ + B(r₂)ⁿ` |
| Repeated Root | `(A + Bn)rⁿ` |
| Tower of Hanoi | `2ⁿ − 1` |
| Binary Search | `Θ(log n)` |
| Merge Sort | `Θ(n log n)` |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- Characteristic Equation
- Solving Linear Recurrences
- Order & Degree
- Master Theorem
- Fibonacci
- Tower of Hanoi
- Divide-and-Conquer Recurrences

---

# Next File

➡️ `12-Generating-Functions.md`