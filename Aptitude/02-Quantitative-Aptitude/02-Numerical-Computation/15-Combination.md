# Combination

## Definition

A **Combination** is the selection of objects from a group where **the order does NOT matter**.

Example

Selecting two students from

```
A B C
```

```
AB

and

BA
```

are considered the **same** selection.

---

# Why Learn This?

Combinations are used whenever a group needs to be selected without considering the order.

Applications include:

- **Software Engineering** – Test case selection, feature combinations, and configuration testing.
- **Data Science** – Feature selection and sampling techniques.
- **Machine Learning** – Model selection and hyperparameter combinations.
- **Statistics** – Probability calculations and sample selection.
- **Healthcare** – Clinical trial sampling.
- **Business Analytics** – Team formation and survey sampling.

---

# Prerequisites

Before learning Combinations, you should know:

- Factorials
- Permutations
- Multiplication Principle
- Basic Algebra

---

# Difference Between Permutation and Combination

| Permutation | Combination |
|--------------|-------------|
| Order Matters | Order Does Not Matter |
| Arrangement | Selection |
| ABC ≠ BAC | ABC = BAC |
| Formula: nPr | Formula: nCr |

---

# Combination Formula

The number of ways to choose

```
r
```

objects from

```
n
```

distinct objects is

```
ⁿCᵣ

=

n!

────────────

r!(n−r)!
```

Condition

```
n ≥ r
```

---

# Example

Choose

```
2
```

students from

```
5
```

students.

Solution

```
⁵C₂

=

5!

────────

2!3!

=

120

────

12

=10
```

Answer

```
10
```

---

# Relationship Between Permutation and Combination

Formula

```
ⁿPᵣ

=

ⁿCᵣ × r!
```

or

```
ⁿCᵣ

=

ⁿPᵣ

────

r!
```

---

# Special Properties

## Property 1

```
ⁿC₀

=1
```

---

## Property 2

```
ⁿCₙ

=1
```

---

## Property 3

```
ⁿC₁

=n
```

---

## Property 4

```
ⁿCₙ₋₁

=n
```

---

## Property 5 (Symmetry)

```
ⁿCᵣ

=

ⁿCₙ₋ᵣ
```

Example

```
⁸C₂

=

⁸C₆
```

---

# Pascal's Identity

Formula

```
ⁿCᵣ

=

ⁿ⁻¹Cᵣ

+

ⁿ⁻¹Cᵣ₋₁
```

Example

```
⁶C₃

=

⁵C₃

+

⁵C₂

=

10+10

=20
```

---

# Selecting at Least / At Most

## At Least One

Formula

```
Total Ways

−

No Selection
```

Example

Select at least one student from

```
4
```

students.

```
2⁴−1

=16−1

=15
```

---

## At Most

Calculate

```
0

+

1

+

2

...

```

required selections individually.

---

# Important Formulae

## Combination

```
ⁿCᵣ

=

n!

────────────

r!(n−r)!
```

---

## Relation

```
ⁿPᵣ

=

ⁿCᵣ×r!
```

---

## Symmetry

```
ⁿCᵣ

=

ⁿCₙ₋ᵣ
```

---

## Pascal Identity

```
ⁿCᵣ

=

ⁿ⁻¹Cᵣ

+

ⁿ⁻¹Cᵣ₋₁
```

---

# Relationship Diagram

```
Objects
   │
   ▼
Choose r Objects
   │
   ▼
Ignore Order
   │
   ▼
Combination
```

---

# Solving Strategy

```
Read Question
      │
      ▼
Does Order Matter?
      │
      ▼
No
      │
      ▼
Identify n and r
      │
      ▼
Apply nCr Formula
      │
      ▼
Simplify
      │
      ▼
Answer
```

---

# Shortcuts & Tricks

### 1. Remember

```
Combination

↓

Selection
```

---

### 2. Order Does NOT Matter

Always ask

```
Can arrangements be considered the same?
```

If yes,

```
Use Combination.
```

---

### 3. Symmetry Rule

```
ⁿC₂

=

ⁿCₙ₋₂
```

Choose the smaller value for easier calculation.

---

### 4. Memorize

```
ⁿC₀

=1
```

```
ⁿCₙ

=1
```

---

### 5. Use Cancellation

Simplify factorials before multiplying.

Example

```
10!

────────

8!2!

↓

10×9

────

2

=45
```

---

# Solved Examples

## Example 1

Find

```
⁶C₂
```

Solution

```
6!

────────

2!4!

=

6×5

────

2

=15
```

Answer

```
15
```

---

## Example 2

Choose

```
3
```

students from

```
7
```

students.

Solution

```
⁷C₃

=

35
```

Answer

```
35
```

---

## Example 3

Find

```
⁸C₁
```

Solution

```
8
```

Answer

```
8
```

---

## Example 4

Find

```
⁹C₀
```

Solution

```
1
```

Answer

```
1
```

---

# Common Mistakes

### Mistake 1

Using permutation when order does not matter.

---

### Mistake 2

Forgetting the

```
r!
```

term in the denominator.

---

### Mistake 3

Calculating large factorials without cancellation.

---

### Mistake 4

Ignoring the symmetry property.

---

### Mistake 5

Confusing selection with arrangement.

---

# Previous Year Question Pattern

Frequently tested concepts:

- Basic Combinations
- Committee Selection
- Team Formation
- Probability-Based Selection
- Pascal's Identity
- Symmetry Property

---

# Practice Questions

## Q1

Find

```
⁷C₂
```

**Answer**

```
7×6

────

2

=21
```

---

## Q2

Choose

```
4
```

players from

```
9
```

players.

**Answer**

```
⁹C₄

=126
```

---

## Q3

Find

```
¹⁰C₁
```

**Answer**

```
10
```

---

## Q4

Find

```
⁸C₈
```

**Answer**

```
1
```

---

## Q5

Find

```
¹²C₂
```

**Answer**

```
12×11

─────

2

=66
```

---

# Quick Revision Sheet

| Concept | Formula |
|----------|---------|
| Combination | n! / (r!(n−r)!) |
| Relation with Permutation | nPr = nCr × r! |
| Symmetry | nCr = nC(n−r) |
| Pascal Identity | nCr = (n−1)Cr + (n−1)C(r−1) |
| nC₀ | 1 |
| nCₙ | 1 |

---

# GATE 80/20 Summary

✅ **Combination = Selection where order does NOT matter.**

✅ Memorize:

- **ⁿCᵣ = n! / (r!(n−r)!)**
- **ⁿPᵣ = ⁿCᵣ × r!**

✅ Use the **symmetry property** to simplify calculations:

```
ⁿCᵣ = ⁿCₙ₋ᵣ
```

✅ Cancel factorials before multiplying to avoid large calculations.

✅ Most aptitude questions involve **committee selection, team formation, probability, and choosing objects without regard to order**.

---

# Next File

➡️ `16-Sequences-and-Series.md`