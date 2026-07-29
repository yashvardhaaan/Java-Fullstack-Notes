# Combinatorics

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# What is Combinatorics?

Combinatorics is the branch of mathematics concerned with

- Counting
- Arrangements
- Selections

without actually listing every possibility.

It is one of the highest scoring topics in GATE Mathematics.

---

# Counting Principles

```
Combinatorics
│
├── Addition Principle
├── Multiplication Principle
├── Permutations
├── Combinations
├── Pigeonhole Principle
├── Inclusion-Exclusion
└── Binomial Theorem
```

---

# Addition Principle

If one task can be done in

```
m
```

ways

and another task can be done in

```
n
```

ways,

and both cannot occur together,

then

```
Total Ways

=

m+n
```

---

## Example

Choose

- Tea (3 types)

OR

- Coffee (4 types)

Total

```
3+4=7
```

---

# Multiplication Principle

If one task has

```
m
```

choices

and another has

```
n
```

choices,

then

```
Total Ways

=

m×n
```

---

## Example

3 shirts

4 pants

Total outfits

```
3×4=12
```

---

# Factorial

Definition

```
n!

=

n(n−1)(n−2)...

2×1
```

---

## Examples

```
0!=1
```

```
1!=1
```

```
5!=120
```

---

# Permutations

Arrangement of objects.

**Order matters.**

Formula

```
nPr

=

n!

────────

(n−r)!
```

---

## Example

Arrange 2 letters from

```
A B C
```

```
AB

AC

BA

BC

CA

CB
```

Answer

```
3P2

=

6
```

---

# Special Cases

Arrange all objects

```
nPn=n!
```

Arrange one object

```
nP1=n
```

---

# Permutations with Repetition

If repetitions are allowed

```
n^r
```

---

Example

3-digit PIN

10 digits

```
10³

=

1000
```

---

# Permutations of Identical Objects

Formula

```
n!

────────────

p!q!r!
```

where

```
p,q,r
```

are repeated objects.

---

## Example

MISS

Letters

```
M=1

I=1

S=2
```

```
4!

────

2!

=

12
```

---

# Circular Permutations

People around a circle

Formula

```
(n−1)!
```

---

If clockwise and anticlockwise are considered the same

```
(n−1)!

────────

2
```

---

# Combinations

Selection of objects.

**Order does NOT matter.**

Formula

```
nCr

=

n!

────────────

r!(n−r)!
```

---

## Example

Choose 2 students from 5.

```
5C2

=

10
```

---

# Relationship

```
nPr

=

nCr × r!
```

Very Important.

---

# Properties of Combination

```
nC0=1
```

```
nCn=1
```

```
nC1=n
```

```
nCr=nC(n−r)
```

---

# Pascal's Identity

```
nCr

=

(n−1)Cr

+

(n−1)C(r−1)
```

---

# Binomial Theorem

Expansion

```
(a+b)^n
```

Formula

```
(a+b)^n

=

Σ

nCr

a^(n−r)

b^r
```

---

# General Term

```
T(r+1)

=

nCr

a^(n−r)

b^r
```

---

# Middle Term

If

```
n
```

is even

Middle Term

```
(n/2)+1
```

If

```
n
```

is odd

There are

```
2
```

middle terms.

---

# Pigeonhole Principle

If

```
n+1
```

objects are placed into

```
n
```

boxes,

then at least one box contains

```
2
```

objects.

---

## General Formula

At least one box contains

```
⌈N/k⌉
```

objects

where

```
N = Objects

k = Boxes
```

---

## Example

11 socks

10 drawers

At least one drawer has

```
2
```

socks.

---

# Inclusion-Exclusion Principle

For Two Sets

```
|A∪B|

=

|A|

+

|B|

−

|A∩B|
```

---

For Three Sets

```
|A∪B∪C|

=

|A|

+

|B|

+

|C|

−

|A∩B|

−

|A∩C|

−

|B∩C|

+

|A∩B∩C|
```

Very Frequently Asked.

---

# Derangements

Permutation where no object remains in its original position.

Notation

```
!n
```

Formula

```
!n

≈

n!

───

e
```

Exact Formula

```
!n

=

n!

Σ

(-1)^k

──────

k!
```

---

# Catalan Numbers

Formula

```
Cn

=

1

──────

n+1

×

2nCn
```

Applications

- Binary Trees
- Parenthesization
- BST counting

---

# Counting Functions

Domain Size

```
m
```

Codomain Size

```
n
```

Total Functions

```
n^m
```

Injective

```
n!

──────

(n−m)!
```

Bijective

```
n!
```

---

# Important Identities

```
nCr=nC(n−r)
```

---

```
nCr+nC(r−1)

=

(n+1)Cr
```

---

```
Σ nCr

=

2^n
```

---

```
Σ (-1)^r nCr

=

0
```

---

# Common GATE PYQs

- Addition Rule
- Multiplication Rule
- Permutations
- Combinations
- Circular Arrangement
- Repeated Objects
- Pigeonhole Principle
- Inclusion-Exclusion
- Binomial Expansion
- Catalan Numbers
- Derangements

---

# Quick Revision

✅ Addition Principle

✅ Multiplication Principle

✅ Factorial

✅ Permutations

✅ Combinations

✅ Circular Permutation

✅ Repeated Objects

✅ Binomial Theorem

✅ Pascal Identity

✅ Pigeonhole Principle

✅ Inclusion-Exclusion

✅ Catalan Numbers

✅ Derangements

---

# Common Mistakes

❌ Using permutation instead of combination.

❌ Forgetting that order matters in permutations.

❌ Forgetting

```
0!=1
```

❌ Missing repeated elements in arrangements.

❌ Incorrect application of Inclusion-Exclusion.

---

# Memory Tricks

### Permutation

```
Arrange

↓

Order Matters
```

---

### Combination

```
Choose

↓

Order Doesn't Matter
```

---

### Relationship

```
nPr

=

nCr × r!
```

---

### Circular Arrangement

```
(n−1)!
```

---

### Pigeonhole Principle

```
More Objects

Than Boxes

↓

One Box

Gets Extra
```

---

# Formula Sheet

| Formula | Result |
|----------|--------|
| Factorial | n! |
| Permutation | n!/(n−r)! |
| Combination | n!/[r!(n−r)!] |
| Relation | nPr = nCr × r! |
| Circular Permutation | (n−1)! |
| Repetition Allowed | n^r |
| Inclusion-Exclusion | \|A∪B\| = \|A\|+\|B\|−\|A∩B\| |
| Pigeonhole | At least ⌈N/k⌉ |
| Catalan Number | (1/(n+1))·(2nCn) |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- Permutations vs Combinations
- Circular Arrangements
- Repeated Objects
- Pigeonhole Principle
- Inclusion-Exclusion
- Binomial Theorem
- Catalan Numbers
- Counting Problems

---

# Next File

➡️ `11-Recurrence-Relations.md`