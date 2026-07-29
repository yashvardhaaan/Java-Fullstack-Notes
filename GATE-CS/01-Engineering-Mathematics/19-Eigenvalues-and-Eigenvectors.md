# Eigenvalues and Eigenvectors

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# Why Do We Need Eigenvalues?

Suppose you stretch a rubber sheet.

Most vectors

- Change direction
- Change length

But some special vectors only **change their length**, not their direction.

These special vectors are called

```
Eigenvectors
```

The amount by which they stretch or shrink is called the

```
Eigenvalue
```

This is why Eigenvalues are extremely useful in

- Machine Learning (PCA)
- Google PageRank
- Computer Vision
- Data Compression
- Quantum Computing
- Network Analysis

---

# Intuition

Imagine multiplying a matrix by a vector.

Normally

```
A × x
```

changes both

- Direction
- Magnitude

But for some vectors

```
A×x

=

λx
```

Only the magnitude changes.

Those vectors are Eigenvectors.

---

# Definition

For a square matrix

```
A
```

If there exists a non-zero vector

```
X
```

such that

```
AX

=

λX
```

Then

```
λ

=

Eigenvalue

X

=

Eigenvector
```

---

# Standard Equation

Move everything to one side.

```
AX−λX=0
```

Take common factor

```
(A−λI)X=0
```

Since

```
X≠0
```

We require

```
det(A−λI)=0
```

This is called the

```
Characteristic Equation
```

**This is the most important formula in this chapter.**

---

# Steps to Find Eigenvalues

Suppose

```
A

=

[4 1

2 3]
```

---

## Step 1

Write

```
A−λI
```

```
[4−λ   1

2     3−λ]
```

---

## Step 2

Take determinant

```
|(A−λI)|=0
```

---

## Step 3

Solve polynomial

Example

```
λ²−7λ+10=0
```

Roots

```
λ=5

λ=2
```

These are the Eigenvalues.

---

# Finding Eigenvectors

For every Eigenvalue

Solve

```
(A−λI)X=0
```

Example

For

```
λ=5
```

Substitute into

```
(A−5I)X=0
```

Solve the resulting equations.

The solution vector is the Eigenvector.

---

# Characteristic Polynomial

Equation

```
det(A−λI)=0
```

Produces a polynomial of degree

```
n
```

for an

```
n×n
```

matrix.

Example

```
2×2

↓

Quadratic
```

```
3×3

↓

Cubic
```

---

# Properties of Eigenvalues

## Sum of Eigenvalues

```
λ₁+λ₂+...+λₙ

=

Trace(A)
```

where

```
Trace(A)

=

Sum of diagonal elements
```

---

## Product of Eigenvalues

```
λ₁λ₂...

=

det(A)
```

Very Important.

---

# Trace of Matrix

Definition

```
Trace(A)

=

Σ aii
```

Example

```
[2 5

3 7]
```

Trace

```
2+7=9
```

---

# Determinant Relation

```
det(A)

=

Product

of

Eigenvalues
```

---

# Zero Eigenvalue

If

```
det(A)=0
```

then

```
0
```

is an Eigenvalue.

Hence

Matrix is Singular.

---

# Eigenvalues of Special Matrices

---

## Diagonal Matrix

Eigenvalues are simply the diagonal elements.

Example

```
[3 0 0

0 7 0

0 0 5]
```

Eigenvalues

```
3

7

5
```

---

## Identity Matrix

```
I
```

Every Eigenvalue

```
1
```

---

## Zero Matrix

Every Eigenvalue

```
0
```

---

## Triangular Matrix

Eigenvalues are diagonal elements.

Very Frequently Asked.

---

# Eigenvectors are NOT Unique

If

```
X
```

is an Eigenvector

Then

```
5X

100X

−3X
```

are also Eigenvectors.

Only direction matters.

---

# Algebraic Multiplicity

Number of times an Eigenvalue appears in the characteristic equation.

Example

```
(λ−2)²(λ−5)=0
```

Eigenvalue

```
2
```

has multiplicity

```
2
```

---

# Geometric Multiplicity

Number of linearly independent Eigenvectors corresponding to an Eigenvalue.

Property

```
Geometric

≤

Algebraic
```

---

# Diagonalization

A matrix is diagonalizable if

It has

```
n

linearly independent

Eigenvectors.
```

Formula

```
A

=

PDP⁻¹
```

where

```
D

=

Diagonal Matrix

of Eigenvalues
```

---

# Why Diagonalization?

Makes computation easier.

Instead of

```
A¹⁰
```

we compute

```
PD¹⁰P⁻¹
```

Much easier because

```
D
```

is diagonal.

---

# Similar Matrices

Two matrices

```
A

and

B
```

are similar if

```
B=P⁻¹AP
```

Property

They have

- Same Eigenvalues
- Same Characteristic Polynomial
- Same Trace
- Same Determinant

---

# Orthogonal Diagonalization

If

```
A
```

is

```
Symmetric
```

then

```
A

=

QDQᵀ
```

where

```
Q
```

is orthogonal.

Very Important.

---

# Positive Definite Matrix

A symmetric matrix

```
A
```

is positive definite if

```
All Eigenvalues

>

0
```

---

# Negative Definite Matrix

All Eigenvalues

```
<0
```

---

# Positive Semi-Definite

All Eigenvalues

```
≥0
```

---

# Negative Semi-Definite

All Eigenvalues

```
≤0
```

---

# Important Theorems

Eigenvalues of

```
A

and

Aᵀ
```

are identical.

---

Eigenvalues of Similar Matrices are equal.

---

Eigenvectors corresponding to distinct Eigenvalues of a symmetric matrix are orthogonal.

---

Determinant

=

Product of Eigenvalues.

---

Trace

=

Sum of Eigenvalues.

---

# Common GATE PYQs

- Find Eigenvalues
- Find Eigenvectors
- Characteristic Equation
- Trace Property
- Determinant Property
- Diagonalization
- Similar Matrices
- Positive Definite Matrix
- Orthogonal Diagonalization

---

# Quick Revision

✅ Eigenvalue

✅ Eigenvector

✅ Characteristic Equation

✅ Trace

✅ Determinant

✅ Diagonal Matrix

✅ Diagonalization

✅ Similar Matrix

✅ Positive Definite Matrix

---

# Common Mistakes

❌ Forgetting to subtract

```
λI
```

instead of just

```
λ
```

---

❌ Using

```
det(A)=0
```

instead of

```
det(A−λI)=0
```

---

❌ Forgetting

```
X≠0
```

---

❌ Mixing Eigenvalues with Eigenvectors.

---

❌ Forgetting that Eigenvectors are not unique.

---

# Memory Tricks

### Fundamental Equation

```
AX

=

λX
```

---

### Characteristic Equation

```
det(A−λI)=0
```

---

### Sum of Eigenvalues

```
Trace
```

---

### Product of Eigenvalues

```
Determinant
```

---

### Diagonal Matrix

```
Eigenvalues

=

Diagonal Elements
```

---

### Singular Matrix

```
det(A)=0

↓

One Eigenvalue

=

0
```

---

# Formula Sheet

| Formula | Result |
|----------|--------|
| Eigenvalue Equation | `AX = λX` |
| Characteristic Equation | `det(A−λI)=0` |
| Trace | `Σ λᵢ` |
| Determinant | `Π λᵢ` |
| Diagonalization | `A=PDP⁻¹` |
| Similar Matrix | `B=P⁻¹AP` |
| Positive Definite | All Eigenvalues > 0 |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- Characteristic Equation
- Finding Eigenvalues
- Finding Eigenvectors
- Trace & Determinant Relations
- Diagonalization
- Similar Matrices
- Positive Definite Matrices

---

# Interview Corner

### Q1. What is an Eigenvalue?

A scalar that only scales an Eigenvector without changing its direction.

---

### Q2. Can a non-square matrix have Eigenvalues?

❌ No. Eigenvalues are defined only for square matrices.

---

### Q3. Can Eigenvalues be zero?

✅ Yes. If `det(A)=0`, then 0 is an Eigenvalue.

---

### Q4. Are Eigenvectors unique?

❌ No. Any non-zero scalar multiple of an Eigenvector is also an Eigenvector.

---

# Next File

➡️ `20-LU-Decomposition.md`