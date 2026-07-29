# LU Decomposition

> GATE Weightage: ⭐⭐⭐⭐

---

# Why Do We Need LU Decomposition?

Suppose you have to solve

```
AX = B
```

once.

You can directly use Gaussian Elimination.

But what if you have

```
AX = B₁

AX = B₂

AX = B₃

...

AX = B₁₀₀
```

The matrix **A** remains the same, only **B** changes.

Instead of performing Gaussian Elimination 100 times, we decompose

```
A

↓

L × U
```

Once.

Then every new problem becomes much faster.

This is why LU Decomposition is widely used in

- Numerical Computing
- Machine Learning
- Computer Graphics
- Scientific Computing
- Engineering Simulations

---

# Intuition

Instead of solving

```
AX=B
```

directly,

break

```
A
```

into two simpler matrices.

```
A

=

L × U
```

where

```
L

↓

Lower Triangular Matrix
```

and

```
U

↓

Upper Triangular Matrix
```

---

# What is LU Decomposition?

A square matrix can often be written as

```
A=L×U
```

where

```
L

=

Lower Triangular Matrix
```

```
U

=

Upper Triangular Matrix
```

---

# Lower Triangular Matrix

All elements above the main diagonal are zero.

Example

```
[1 0 0

2 1 0

5 3 1]
```

Notice

Everything above diagonal = 0

---

# Upper Triangular Matrix

All elements below the main diagonal are zero.

Example

```
[2 3 1

0 4 6

0 0 7]
```

---

# Why is LU Useful?

Instead of solving

```
AX=B
```

Solve

```
LUX=B
```

Let

```
UX=Y
```

Now solve

```
LY=B
```

Then solve

```
UX=Y
```

Both are triangular systems.

Triangular systems are much easier to solve.

---

# Flow of LU Decomposition

```
AX=B

↓

A=L×U

↓

LUX=B

↓

Let

UX=Y

↓

Solve

LY=B

↓

Solve

UX=Y

↓

Find X
```

This flow is very important for GATE.

---

# Conditions for LU Decomposition

A matrix can be decomposed into LU if

- It is square.
- Leading principal minors are non-zero (without pivoting).

If not,

use

```
PA=LU
```

called **LU with Partial Pivoting**.

---

# Doolittle Method

Most common method asked in GATE.

### Property

```
Diagonal of L

=

1
```

Example

```
L

=

[1 0 0

l21 1 0

l31 l32 1]
```

```
U

=

[u11 u12 u13

0 u22 u23

0 0 u33]
```

---

# Crout Method

Exactly opposite.

Property

```
Diagonal of U

=

1
```

Example

```
U

=

[1 u12 u13

0 1 u23

0 0 1]
```

---

# Doolittle vs Crout

| Feature | Doolittle | Crout |
|----------|-----------|--------|
| Diagonal of L | 1 | Variable |
| Diagonal of U | Variable | 1 |
| GATE Preference | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |

Remember:

```
Doolittle

↓

Diagonal of L

=

1
```

---

# Simple Example

Given

```
A

=

[2 4

6 8]
```

Suppose

```
L

=

[1 0

l21 1]
```

```
U

=

[u11 u12

0 u22]
```

Multiply

```
LU
```

Match corresponding elements with

```
A
```

Solve unknowns

```
l21

u11

u12

u22
```

This is the standard procedure.

---

# Forward Substitution

Used to solve

```
LY=B
```

Start from the first equation.

Move downward.

Example

```
L

=

[1 0

2 1]
```

```
Y

=

[y1

y2]
```

Solve

```
y1
```

first,

then

```
y2
```

---

# Backward Substitution

Used to solve

```
UX=Y
```

Start from the last equation.

Move upward.

Example

```
U

=

[3 2

0 5]
```

Solve

```
x2
```

first,

then

```
x1
```

---

# Why Forward and Backward?

Because

```
L

↓

Unknowns appear below
```

Solve top to bottom.

```
U

↓

Unknowns appear above
```

Solve bottom to top.

---

# Computational Complexity

LU Decomposition

```
O(n³)
```

Forward Substitution

```
O(n²)
```

Backward Substitution

```
O(n²)
```

Much faster when solving multiple systems.

---

# Partial Pivoting

Sometimes a pivot becomes

```
0
```

or extremely small.

Swap rows.

Notation

```
PA=LU
```

where

```
P

=

Permutation Matrix
```

Improves numerical stability.

---

# Permutation Matrix

Obtained by swapping rows of the identity matrix.

Example

```
I

=

[1 0

0 1]
```

Swap rows

```
P

=

[0 1

1 0]
```

---

# Advantages of LU

✔ Faster for multiple systems.

✔ More stable than repeated elimination.

✔ Widely used in numerical software.

✔ Foundation of many scientific libraries.

---

# Applications

LU Decomposition is used in

- Solving Linear Equations
- Matrix Inversion
- Determinant Computation
- Machine Learning
- Finite Element Analysis
- Scientific Computing

---

# Relationship with Determinant

If

```
A=LU
```

then

```
det(A)

=

det(L)

×

det(U)
```

For Doolittle,

```
det(L)=1
```

Therefore

```
det(A)

=

Product of

Diagonal Elements of U
```

Frequently asked in GATE.

---

# Common GATE PYQs

- LU Decomposition
- Doolittle Method
- Crout Method
- Forward Substitution
- Backward Substitution
- Partial Pivoting
- Permutation Matrix
- Determinant using LU

---

# Quick Revision

✅ LU Decomposition

✅ Lower Triangular Matrix

✅ Upper Triangular Matrix

✅ Doolittle Method

✅ Crout Method

✅ Forward Substitution

✅ Backward Substitution

✅ Partial Pivoting

✅ Permutation Matrix

---

# Common Mistakes

❌ Confusing Lower and Upper triangular matrices.

❌ Forgetting which diagonal is 1 in Doolittle.

❌ Using backward substitution for L.

❌ Ignoring row swapping when pivot is zero.

❌ Multiplying L and U incorrectly.

---

# Memory Tricks

### LU

```
A

=

L×U
```

---

### L

```
Solve

Top

↓

Bottom
```

---

### U

```
Solve

Bottom

↓

Top
```

---

### Doolittle

```
Diagonal of L

=

1
```

---

### Crout

```
Diagonal of U

=

1
```

---

### Determinant

```
det(A)

=

det(L)

×

det(U)
```

For Doolittle

```
det(A)

=

Product of

Diagonal(U)
```

---

# Formula Sheet

| Formula | Result |
|----------|--------|
| LU Decomposition | `A = LU` |
| Solve Step 1 | `LY = B` |
| Solve Step 2 | `UX = Y` |
| Partial Pivoting | `PA = LU` |
| Determinant | `det(A) = det(L)det(U)` |
| Time Complexity | `O(n³)` |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- LU Decomposition
- Doolittle Method
- Crout Method
- Forward & Backward Substitution
- Partial Pivoting
- Determinant using LU

---

# Interview Corner

### Q1. Why is LU decomposition better than Gaussian Elimination?

LU decomposition factors the matrix once. If the same coefficient matrix is used with multiple right-hand sides, solving each new system only requires forward and backward substitution, making it much faster overall.

---

### Q2. What is the difference between Doolittle and Crout?

- **Doolittle:** Diagonal elements of **L** are 1.
- **Crout:** Diagonal elements of **U** are 1.

---

### Q3. When do we use Partial Pivoting?

When a pivot element is **0** or very close to **0**, rows are swapped to avoid division by zero and improve numerical stability.

---

# Next File

➡️ `21-Limits.md`