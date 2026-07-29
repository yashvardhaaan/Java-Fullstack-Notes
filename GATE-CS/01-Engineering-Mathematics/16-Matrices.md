# Matrices

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# What is a Matrix?

A **Matrix** is a rectangular arrangement of numbers, symbols, or expressions in **rows** and **columns**.

It is represented by capital letters like

```
A, B, C
```

Example

```
      Columns
        ↓

    1   2   3

1  [1   2   3]

2  [4   5   6]

3  [7   8   9]

↑
Rows
```

Notation

```
A(m×n)
```

where

```
m = Rows

n = Columns
```

---

# Why Matrices?

Matrices are used to represent

- Systems of Linear Equations
- Graphs
- Images
- Machine Learning
- Computer Graphics
- Artificial Intelligence
- Cryptography

Almost every branch of Computer Science uses matrices.

---

# Order of Matrix

If a matrix has

```
m rows

n columns
```

Then its order is

```
m × n
```

Example

```
[1 2 3

 4 5 6]
```

Order

```
2×3
```

---

# Types of Matrices

```
Matrices
│
├── Row Matrix
├── Column Matrix
├── Rectangular Matrix
├── Square Matrix
├── Zero Matrix
├── Diagonal Matrix
├── Scalar Matrix
├── Identity Matrix
├── Upper Triangular
├── Lower Triangular
├── Symmetric Matrix
├── Skew Symmetric Matrix
└── Orthogonal Matrix
```

---

# Row Matrix

Contains only one row.

Example

```
[1 2 3 4]
```

Order

```
1×4
```

---

# Column Matrix

Contains only one column.

Example

```
[2

4

6]
```

Order

```
3×1
```

---

# Rectangular Matrix

Rows ≠ Columns.

Example

```
2×3

3×5
```

---

# Square Matrix

Rows = Columns.

Example

```
3×3
```

```
[1 2 3

4 5 6

7 8 9]
```

---

# Zero Matrix

Every element is

```
0
```

Example

```
[0 0

0 0]
```

---

# Diagonal Matrix

All non-diagonal elements are zero.

Example

```
[5 0 0

0 3 0

0 0 8]
```

---

# Scalar Matrix

A diagonal matrix where all diagonal elements are equal.

Example

```
[4 0 0

0 4 0

0 0 4]
```

---

# Identity Matrix

Diagonal elements are

```
1
```

Remaining elements are

```
0
```

Notation

```
I
```

Example

```
[1 0 0

0 1 0

0 0 1]
```

Property

```
AI=IA=A
```

---

# Upper Triangular Matrix

Elements below the main diagonal are zero.

Example

```
[2 3 4

0 5 6

0 0 8]
```

---

# Lower Triangular Matrix

Elements above the main diagonal are zero.

Example

```
[2 0 0

5 3 0

7 6 4]
```

---

# Symmetric Matrix

Definition

```
Aᵀ=A
```

Example

```
[1 2

2 3]
```

---

# Skew Symmetric Matrix

Definition

```
Aᵀ=-A
```

Diagonal elements are always

```
0
```

Example

```
[0 2

-2 0]
```

---

# Orthogonal Matrix

Definition

```
AᵀA=I
```

Property

```
A⁻¹=Aᵀ
```

Very Important in GATE.

---

# Matrix Equality

Two matrices are equal if

- Same order
- Corresponding elements are equal

---

# Matrix Addition

Possible only when both matrices have the same order.

Formula

```
A+B

=

[aij+bij]
```

Example

```
[1 2]

+

[3 4]

=

[4 6]
```

---

# Matrix Subtraction

Same condition as addition.

---

# Scalar Multiplication

Multiply every element by the scalar.

Example

```
3

×

[1 2

3 4]

=

[3 6

9 12]
```

---

# Matrix Multiplication

## Condition

If

```
A(m×n)

B(n×p)
```

Then

```
AB

exists

↓

Result

m×p
```

Memory Trick

```
Inside

Must Match

Outside

Becomes Answer
```

Example

```
2×3

×

3×4

=

2×4
```

---

# Matrix Multiplication Formula

```
Cij

=

Σ

AikBkj
```

Multiply **row × column**.

---

# Important Properties

## Commutative

```
AB≠BA
```

Generally False.

---

## Associative

```
(AB)C

=

A(BC)
```

True.

---

## Distributive

```
A(B+C)

=

AB+AC
```

---

## Identity

```
AI=IA=A
```

---

## Zero Matrix

```
A×0=0
```

---

# Transpose

Interchange rows and columns.

Notation

```
Aᵀ
```

Example

```
A

=

[1 2 3

4 5 6]
```

Transpose

```
[1 4

2 5

3 6]
```

---

# Properties of Transpose

```
(Aᵀ)ᵀ=A
```

---

```
(A+B)ᵀ

=

Aᵀ+Bᵀ
```

---

```
(AB)ᵀ

=

BᵀAᵀ
```

Very Important.

---

# Rank of Matrix

## Intuition

Rank tells us

> **How much independent information is present in the matrix.**

A row that can be obtained from another row does **not** increase the rank.

---

## Definition

Rank = Maximum number of linearly independent rows (or columns).

Notation

```
Rank(A)
```

---

## Properties

```
Rank(A)

≤

min(m,n)
```

---

Identity Matrix

```
Rank=n
```

---

Zero Matrix

```
Rank=0
```

---

# Elementary Row Operations

Used to simplify matrices.

Three operations

1.

```
Swap Rows
```

2.

```
Multiply Row by Non-zero Constant
```

3.

```
Add Multiple of One Row to Another
```

---

# Row Echelon Form (REF)

Characteristics

- Zero rows at bottom
- Leading entries move to the right
- Entries below pivots are zero

---

# Reduced Row Echelon Form (RREF)

Extra condition

Pivot is

```
1
```

and every element above and below pivot is

```
0
```

---

# Inverse of Matrix

Only square matrices may have inverses.

Definition

```
AA⁻¹=I
```

Exists only if

```
det(A)≠0
```

---

# Singular Matrix

```
det(A)=0
```

Inverse does not exist.

---

# Non-Singular Matrix

```
det(A)≠0
```

Inverse exists.

---

# Matrix Inverse (2×2)

For

```
[a b

c d]
```

Inverse

```
1/(ad−bc)

×

[d -b

-c a]
```

Very Important.

---

# Applications

Matrices are used in

- Machine Learning
- Computer Graphics
- Image Processing
- Cryptography
- Artificial Intelligence
- Graph Theory
- Networks

---

# Common GATE PYQs

- Matrix Multiplication
- Matrix Properties
- Rank
- REF & RREF
- Orthogonal Matrix
- Symmetric Matrix
- Inverse Matrix
- Matrix Transpose

---

# Quick Revision

✅ Matrix

✅ Order

✅ Types of Matrices

✅ Matrix Addition

✅ Matrix Multiplication

✅ Transpose

✅ Rank

✅ Elementary Row Operations

✅ REF

✅ RREF

✅ Inverse

✅ Orthogonal Matrix

---

# Common Mistakes

❌ Thinking

```
AB=BA
```

Always False.

---

❌ Forgetting multiplication condition.

---

❌ Confusing Identity Matrix with Diagonal Matrix.

---

❌ Assuming every square matrix has an inverse.

---

❌ Computing rank without row reduction.

---

# Memory Tricks

### Matrix Multiplication

```
Inside Match

Outside Answer
```

```
2×3

×

3×5

=

2×5
```

---

### Identity Matrix

```
AI=IA=A
```

---

### Orthogonal Matrix

```
Inverse

=

Transpose
```

---

### Rank

```
Independent Rows

or

Independent Columns
```

---

# Formula Sheet

| Formula | Result |
|----------|--------|
| Order | m×n |
| Multiplication | (m×n)(n×p)=m×p |
| Identity | AI=IA=A |
| Transpose | (AB)ᵀ=BᵀAᵀ |
| Rank | ≤ min(m,n) |
| Inverse Exists | det(A)≠0 |
| Orthogonal | A⁻¹=Aᵀ |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- Matrix Multiplication
- Rank
- REF & RREF
- Inverse
- Orthogonal Matrix
- Matrix Properties
- Transpose

---

# Next File

➡️ `17-Determinants.md`