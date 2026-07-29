# Permutation

## Definition

A **Permutation** is an arrangement of objects in a specific order.

**Order matters** in permutations.

Example

```
A B

and

B A
```

These are considered **different** arrangements.

---

# Why Learn This?

Permutations are used whenever the arrangement or ordering of items is important.

Applications include:

- **Software Engineering** – Password generation, test case generation, and algorithm design.
- **Cybersecurity** – Cryptographic key generation and brute-force analysis.
- **Data Science** – Feature ordering and sequence generation.
- **Operations Research** – Scheduling and optimization.
- **Manufacturing** – Production sequencing.
- **Artificial Intelligence** – Search algorithms and state-space exploration.

---

# Prerequisites

Before learning Permutations, you should know:

- Factorials
- Multiplication Principle
- Basic Algebra

---

# Factorial

Factorial is the foundation of permutations.

Notation

```
n!
```

Formula

```
n!

=

n×(n−1)×(n−2)...×2×1
```

Examples

| n | n! |
|---:|---:|
| 0 | 1 |
| 1 | 1 |
| 2 | 2 |
| 3 | 6 |
| 4 | 24 |
| 5 | 120 |
| 6 | 720 |

---

# Fundamental Counting Principle

If one task can be performed in

```
m
```

ways and another in

```
n
```

ways,

then both together can be performed in

```
m×n
```

ways.

Example

```
3 shirts

×

2 pants

=6 outfits
```

---

# Permutation Formula

The number of ways to arrange

```
r
```

objects from

```
n
```

distinct objects is

```
ⁿPᵣ

=

n!

──────

(n−r)!
```

Conditions

```
n ≥ r
```

---

# Example

Arrange

```
3
```

letters from

```
A B C D
```

Solution

```
⁴P₃

=

4!

───

1!

=

24
```

Answer

```
24
```

---

# Permutation of All Objects

When

```
r=n
```

Formula

```
n!
```

Example

Arrange

```
A B C D
```

Solution

```
4!

=24
```

---

# Circular Permutation

For arranging

```
n
```

distinct objects in a circle,

Formula

```
(n−1)!
```

Example

Arrange

```
5 people
```

around a round table.

Solution

```
(5−1)!

=4!

=24
```

---

# Permutations with Repeated Objects

Formula

```
n!

────────────

p!×q!×r!
```

where

```
p,q,r
```

are frequencies of repeated objects.

---

## Example

Arrange the letters of

```
LEVEL
```

Letters

```
L =2

E =2

V =1
```

Solution

```
5!

──────

2!×2!

=

120/4

=30
```

---

# Permutations with Restrictions

Example

Arrange

```
A B C D
```

such that

```
A
```

is always first.

Fix

```
A
```

Remaining arrangements

```
3!

=6
```

---

# Important Formulae

## Factorial

```
n!
```

---

## Permutation

```
ⁿPᵣ

=

n!

──────

(n−r)!
```

---

## All Objects

```
n!
```

---

## Circular Arrangement

```
(n−1)!
```

---

## Repeated Objects

```
n!

────────────

p!q!r!
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
Arrange Them
   │
   ▼
Permutation
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
Yes
      │
      ▼
Identify n and r
      │
      ▼
Choose Formula
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
Permutation

↓

Order Matters
```

---

### 2. Memorize

```
0!

=1
```

---

### 3. If All Objects Are Used

Use

```
n!
```

---

### 4. Circular Arrangement

Use

```
(n−1)!
```

---

### 5. Repeated Letters

Always divide by the factorial of repeated frequencies.

---

# Solved Examples

## Example 1

Find

```
⁵P₂
```

Solution

```
5!

───

3!

=

5×4

=20
```

Answer

```
20
```

---

## Example 2

Arrange

```
6
```

people in a row.

Solution

```
6!

=720
```

Answer

```
720
```

---

## Example 3

Arrange the letters of

```
BOOK
```

Solution

Letters

```
B=1

O=2

K=1
```

Formula

```
4!

───

2!

=

24/2

=12
```

Answer

```
12
```

---

## Example 4

Arrange

```
7
```

people around a circular table.

Solution

```
(7−1)!

=6!

=720
```

Answer

```
720
```

---

# Common Mistakes

### Mistake 1

Using combinations instead of permutations when order matters.

---

### Mistake 2

Forgetting to divide for repeated objects.

---

### Mistake 3

Using

```
n!
```

instead of

```
(n−1)!
```

for circular arrangements.

---

### Mistake 4

Incorrect factorial calculations.

---

### Mistake 5

Confusing

```
ⁿPᵣ

and

ⁿCᵣ
```

---

# Previous Year Question Pattern

Frequently tested concepts:

- Basic Permutations
- Circular Arrangements
- Repeated Letters
- Restricted Arrangements
- Factorials
- Seating Arrangements

---

# Practice Questions

## Q1

Find

```
⁶P₃
```

**Answer**

```
6!

───

3!

=6×5×4

=120
```

---

## Q2

Arrange

```
5
```

books on a shelf.

**Answer**

```
5!

=120
```

---

## Q3

Arrange the letters of

```
APPLE
```

**Answer**

Letters

```
P=2
```

```
5!

───

2!

=60
```

---

## Q4

Arrange

```
8
```

people around a circular table.

**Answer**

```
7!

=5040
```

---

## Q5

How many 4-digit numbers can be formed using

```
1,2,3,4
```

without repetition?

**Answer**

```
4!

=24
```

---

# Quick Revision Sheet

| Concept | Formula |
|----------|---------|
| Factorial | n! |
| Permutation | n! ÷ (n−r)! |
| All Objects | n! |
| Circular Arrangement | (n−1)! |
| Repeated Objects | n! ÷ (p!q!r!...) |

---

# GATE 80/20 Summary

✅ **Permutation = Arrangement where order matters.**

✅ Memorize:

- **ⁿPᵣ = n! / (n−r)!**
- **n!** for arranging all objects.
- **(n−1)!** for circular arrangements.

✅ For repeated objects, divide by the factorial of repeated frequencies.

✅ Always ask:

```
Does order matter?
```

If **Yes**, use **Permutation**.

✅ Most aptitude questions involve **factorials, seating arrangements, repeated letters, and circular permutations**.

---

# Next File

➡️ `15-Combination.md`