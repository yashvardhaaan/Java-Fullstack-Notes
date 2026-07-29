# Logarithms

## Definition

A **Logarithm** is the inverse operation of exponentiation.

If

```
a^x = b
```

then

```
logₐ(b) = x
```

where:

- **a** = Base (a > 0, a ≠ 1)
- **b** = Argument (b > 0)
- **x** = Logarithm

Example

```
2³ = 8
```

Therefore,

```
log₂(8) = 3
```

---

# Why Learn This?

Logarithms are used whenever exponential growth or decay needs to be analyzed.

Applications include:

- **Software Engineering** – Time complexity (O(log n)), binary search, balanced trees, and indexing.
- **Data Science** – Log transformations, probability, and machine learning.
- **Finance** – Compound growth and investment analysis.
- **Physics** – Earthquake magnitude (Richter scale), sound intensity (decibels).
- **Computer Networks** – Algorithm analysis and routing.
- **Statistics** – Probability distributions and data normalization.

---

# Prerequisites

Before learning Logarithms, you should know:

- Powers and Exponents
- Algebra
- Fractions
- Basic Arithmetic

---

# Relationship Between Exponents and Logarithms

```
aˣ = b

⇅

logₐ(b) = x
```

Example

```
5² = 25

↓

log₅(25) = 2
```

---

# Parts of a Logarithm

Example

```
log₂(16)
```

```
Base = 2

Argument = 16

Value = 4
```

Because

```
2⁴ = 16
```

---

# Common Logarithm

Base

```
10
```

Notation

```
log(x)

means

log₁₀(x)
```

Example

```
log(100)

=2
```

---

# Natural Logarithm

Base

```
e

≈2.718
```

Notation

```
ln(x)
```

Example

```
ln(e³)

=3
```

---

# Laws of Logarithms

## 1. Product Rule

```
logₐ(MN)

=

logₐ(M)+logₐ(N)
```

Example

```
log₂(8×4)

=

3+2

=5
```

---

## 2. Quotient Rule

```
logₐ(M/N)

=

logₐ(M)-logₐ(N)
```

Example

```
log₁₀(1000/10)

=

3−1

=2
```

---

## 3. Power Rule

```
logₐ(Mⁿ)

=

n logₐ(M)
```

Example

```
log₂(8²)

=

2×3

=6
```

---

## 4. Change of Base Formula

```
logₐ(b)

=

log(b)

──────

log(a)
```

or

```
logₐ(b)

=

ln(b)

─────

ln(a)
```

Example

```
log₂(8)

=

log8/log2

=3
```

---

# Important Logarithmic Values

| Expression | Value |
|------------|------:|
| log₁₀(1) | 0 |
| log₁₀(10) | 1 |
| log₁₀(100) | 2 |
| log₁₀(1000) | 3 |
| log₂(8) | 3 |
| log₂(16) | 4 |
| ln(e) | 1 |
| ln(1) | 0 |

---

# Properties

## Property 1

```
logₐ(a)

=1
```

---

## Property 2

```
logₐ(1)

=0
```

---

## Property 3

```
a^(logₐx)

=x
```

---

## Property 4

```
logₐ(aⁿ)

=n
```

---

# Domain of Logarithms

For

```
logₐ(x)
```

Conditions:

```
a > 0

a ≠ 1

x > 0
```

Logarithms of zero or negative numbers are **undefined**.

---

# Important Formulae

## Definition

```
aˣ=b

⇔

logₐ(b)=x
```

---

## Product Rule

```
log(MN)

=

logM+logN
```

---

## Quotient Rule

```
log(M/N)

=

logM−logN
```

---

## Power Rule

```
log(Mⁿ)

=

nlogM
```

---

## Change of Base

```
logₐb

=

logb/loga
```

---

# Relationship Diagram

```
Exponent
     │
     ▼
Logarithm
     │
     ▼
Apply Law
     │
     ▼
Simplify
     │
     ▼
Answer
```

---

# Solving Strategy

```
Read Expression
      │
      ▼
Identify Base
      │
      ▼
Apply Log Law
      │
      ▼
Simplify
      │
      ▼
Calculate Value
```

---

# Shortcuts & Tricks

### 1. Convert to Exponential Form

Whenever possible,

```
logₐ(b)

↓

aˣ=b
```

---

### 2. Memorize

```
log(1)=0

log(10)=1

ln(e)=1
```

---

### 3. Product

```
Multiply

↓

Add Logs
```

---

### 4. Division

```
Divide

↓

Subtract Logs
```

---

### 5. Power

Move the exponent in front.

```
log(a⁵)

↓

5log(a)
```

---

# Solved Examples

## Example 1

Find

```
log₂(32)
```

Solution

```
2⁵=32
```

Answer

```
5
```

---

## Example 2

Simplify

```
log₁₀(1000)
```

Solution

```
10³=1000
```

Answer

```
3
```

---

## Example 3

Simplify

```
log₂(8×4)
```

Solution

```
log₂8+log₂4

=3+2

=5
```

Answer

```
5
```

---

## Example 4

Simplify

```
log₃(81)
```

Solution

```
3⁴=81
```

Answer

```
4
```

---

# Common Mistakes

### Mistake 1

Using logarithms for negative numbers.

```
log(-5)

❌ Undefined
```

---

### Mistake 2

Forgetting the logarithm laws.

---

### Mistake 3

Confusing the base with the argument.

---

### Mistake 4

Writing

```
log(a+b)

=

loga+logb

❌ Wrong
```

Only multiplication can be split.

---

### Mistake 5

Ignoring the domain conditions.

---

# Previous Year Question Pattern

Frequently tested concepts:

- Basic Logarithms
- Logarithmic Laws
- Simplification
- Change of Base
- Exponent–Log Conversion
- Domain of Logarithms

---

# Practice Questions

## Q1

Find

```
log₂(64)
```

**Answer**

```
6
```

---

## Q2

Find

```
log₁₀(100000)
```

**Answer**

```
5
```

---

## Q3

Simplify

```
log₂(16×8)
```

**Answer**

```
4+3

=7
```

---

## Q4

Find

```
log₅(125)
```

**Answer**

```
3
```

---

## Q5

Evaluate

```
ln(e⁷)
```

**Answer**

```
7
```

---

# Quick Revision Sheet

| Concept | Formula |
|----------|---------|
| Definition | aˣ = b ⇔ logₐ(b) = x |
| Product Rule | log(MN) = logM + logN |
| Quotient Rule | log(M/N) = logM − logN |
| Power Rule | log(Mⁿ) = n logM |
| Change of Base | logₐ(b) = log(b) ÷ log(a) |
| logₐ(a) | 1 |
| logₐ(1) | 0 |
| a^(logₐx) | x |

---

# GATE 80/20 Summary

✅ Convert logarithms into exponential form whenever possible.

✅ Memorize the four core logarithm laws:
- Product
- Quotient
- Power
- Change of Base

✅ Remember:
- **logₐ(a) = 1**
- **logₐ(1) = 0**
- **Argument must always be positive.**

✅ Never split:

```
log(a+b)

❌
```

Only multiplication and division follow logarithm laws.

✅ Most aptitude questions involve **basic logarithms, simplification, exponent conversion, and logarithmic identities**.

---

# Next File

➡️ `14-Permutation.md`