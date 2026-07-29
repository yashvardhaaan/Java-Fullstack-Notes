# Sequences and Series

## Definition

A **Sequence** is an ordered list of numbers that follows a specific pattern.

A **Series** is the sum of the terms of a sequence.

Example

```
Sequence

2, 4, 6, 8, 10
```

```
Series

2 + 4 + 6 + 8 + 10

=30
```

---

# Why Learn This?

Sequences and Series are used to model patterns, predict future values, and analyze repetitive processes.

Applications include:

- **Software Engineering** – Algorithm analysis, recurrence relations, and dynamic programming.
- **Data Science** – Time series analysis and trend prediction.
- **Finance** – Loan payments, investments, and annuities.
- **Economics** – Population and economic growth models.
- **Physics** – Wave patterns and motion analysis.
- **Artificial Intelligence** – Sequence modeling and forecasting.

---

# Prerequisites

Before learning Sequences and Series, you should know:

- Basic Algebra
- Powers and Exponents
- Arithmetic Operations
- Factorials (Helpful)

---

# Sequence

A sequence is an ordered collection of numbers.

Example

```
3, 6, 9, 12, 15
```

Each number is called a **term**.

Notation

```
a₁, a₂, a₃, ...
```

where

```
aₙ

=

nth term
```

---

# Types of Sequences

```
Sequences
│
├── Arithmetic Progression (AP)
├── Geometric Progression (GP)
├── Harmonic Progression (HP)
└── Fibonacci Sequence
```

---

# Arithmetic Progression (AP)

An AP is a sequence where the difference between consecutive terms is constant.

Example

```
5, 8, 11, 14, 17
```

Common Difference

```
d

=3
```

---

## nth Term of AP

Formula

```
aₙ

=

a+(n−1)d
```

Where

```
a

=

First Term

d

=

Common Difference
```

Example

```
a=4

d=5

Find 8th term
```

Solution

```
a₈

=4+(8−1)×5

=39
```

---

## Sum of First n Terms of AP

Formula

```
Sₙ

=

n/2

[2a+(n−1)d]
```

Alternative Formula

```
Sₙ

=

n(a+l)

──────

2
```

where

```
l

=

Last Term
```

---

# Geometric Progression (GP)

A GP is a sequence where each term is obtained by multiplying the previous term by a constant ratio.

Example

```
2, 6, 18, 54
```

Common Ratio

```
r

=3
```

---

## nth Term of GP

Formula

```
aₙ

=

arⁿ⁻¹
```

Example

```
a=2

r=3

Find 5th term
```

Solution

```
2×3⁴

=162
```

---

## Sum of First n Terms of GP

For

```
r≠1
```

Formula

```
Sₙ

=

a(rⁿ−1)

────────

r−1
```

Equivalent Formula

```
Sₙ

=

a(1−rⁿ)

────────

1−r
```

---

## Infinite GP

If

```
|r|<1
```

Formula

```
S∞

=

a

──

1−r
```

Example

```
1+1/2+1/4+1/8...
```

```
1/(1−1/2)

=2
```

---

# Harmonic Progression (HP)

A sequence whose reciprocals form an Arithmetic Progression.

Example

```
1

1/2

1/3

1/4
```

---

# Fibonacci Sequence

Each term is the sum of the previous two terms.

Example

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

Formula

```
Fₙ

=

Fₙ₋₁+Fₙ₋₂
```

---

# Important Formulae

## AP nth Term

```
a+(n−1)d
```

---

## AP Sum

```
n/2

[2a+(n−1)d]
```

---

## GP nth Term

```
arⁿ⁻¹
```

---

## GP Sum

```
a(rⁿ−1)

────────

r−1
```

---

## Infinite GP

```
a/(1−r)
```

---

## Fibonacci

```
Fₙ

=

Fₙ₋₁+Fₙ₋₂
```

---

# Relationship Diagram

```
Sequence
    │
    ▼
Identify Pattern
    │
    ├── Constant Difference → AP
    ├── Constant Ratio      → GP
    ├── Reciprocal of AP    → HP
    └── Sum of Previous Two → Fibonacci
```

---

# Solving Strategy

```
Read Sequence
      │
      ▼
Find Pattern
      │
      ▼
AP / GP / HP / Fibonacci
      │
      ▼
Apply Formula
      │
      ▼
Calculate Answer
```

---

# Shortcuts & Tricks

### 1. AP

If the difference is constant,

```
↓

AP
```

---

### 2. GP

If the ratio is constant,

```
↓

GP
```

---

### 3. Infinite GP

Applicable only when

```
|r|<1
```

---

### 4. AP Sum Shortcut

If the first and last terms are known,

```
S

=

n(a+l)

──────

2
```

---

### 5. Fibonacci

Every term is

```
Previous

+

Previous Previous
```

---

# Solved Examples

## Example 1

Find the 12th term of the AP

```
5, 9, 13...
```

Solution

```
a=5

d=4

a₁₂

=5+11×4

=49
```

Answer

```
49
```

---

## Example 2

Find the sum of the first

```
20
```

terms of

```
2, 5, 8...
```

Solution

```
a=2

d=3

S₂₀

=20/2

[4+57]

=10×61

=610
```

Answer

```
610
```

---

## Example 3

Find the 6th term of the GP

```
3, 6, 12...
```

Solution

```
a=3

r=2

a₆

=3×2⁵

=96
```

Answer

```
96
```

---

## Example 4

Find the sum of the infinite GP

```
8

+

4

+

2

+

1...
```

Solution

```
a=8

r=1/2

S∞

=8/(1−1/2)

=16
```

Answer

```
16
```

---

# Common Mistakes

### Mistake 1

Confusing common difference with common ratio.

---

### Mistake 2

Using the AP formula for GP questions.

---

### Mistake 3

Applying the infinite GP formula when

```
|r|≥1
```

---

### Mistake 4

Using the wrong value of

```
n
```

in the nth-term formula.

---

### Mistake 5

Incorrectly identifying the sequence pattern.

---

# Previous Year Question Pattern

Frequently tested concepts:

- AP nth Term
- AP Sum
- GP nth Term
- GP Sum
- Infinite GP
- Missing Terms
- Fibonacci Sequence

---

# Practice Questions

## Q1

Find the 15th term of the AP

```
7, 10, 13...
```

**Answer**

```
49
```

---

## Q2

Find the sum of the first

```
15
```

terms of

```
4, 8, 12...
```

**Answer**

```
480
```

---

## Q3

Find the 7th term of the GP

```
2, 4, 8...
```

**Answer**

```
128
```

---

## Q4

Find the sum of the infinite GP

```
12

+

6

+

3...
```

**Answer**

```
24
```

---

## Q5

Write the next term of

```
2, 3, 5, 8, 13, 21
```

**Answer**

```
34
```

---

# Quick Revision Sheet

| Concept | Formula |
|----------|---------|
| AP nth Term | a + (n−1)d |
| AP Sum | n/2 [2a + (n−1)d] |
| AP Sum (Alternative) | n(a+l)/2 |
| GP nth Term | ar^(n−1) |
| GP Sum | a(rⁿ−1)/(r−1) |
| Infinite GP | a/(1−r), \|r\| < 1 |
| Fibonacci | Fₙ = Fₙ₋₁ + Fₙ₋₂ |

---

# GATE 80/20 Summary

✅ Identify the pattern first:
- **Constant Difference → AP**
- **Constant Ratio → GP**
- **Reciprocals form AP → HP**
- **Each term = Sum of previous two → Fibonacci**

✅ Memorize:
- **AP nth Term = a + (n−1)d**
- **AP Sum = n/2 [2a + (n−1)d]**
- **GP nth Term = ar^(n−1)**
- **GP Sum = a(rⁿ−1)/(r−1)**

✅ Use the infinite GP formula only when:

```
|r| < 1
```

✅ Most aptitude questions involve **AP, GP, sums, missing terms, and Fibonacci sequences**.

---

# Next File

➡️ `17-Probability.md`