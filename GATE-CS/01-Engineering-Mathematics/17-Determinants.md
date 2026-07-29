# Determinants

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# What is a Determinant?

A **Determinant** is a single numerical value associated with a **square matrix**.

Notation

```
|A|

or

det(A)
```

Unlike a matrix, a determinant is just **one number**.

Example

```
A =

[2 3

1 4]
```

```
|A|

=

5
```

---

# Why Do We Need Determinants?

Determinants help us answer important questions:

- Does a matrix have an inverse?
- Is a system of equations solvable?
- Are vectors linearly independent?
- What is the scaling factor of a transformation?

**Key Idea**

```
det(A)=0

↓

Matrix loses information

↓

Inverse does NOT exist
```

---

# Determinant of 2×2 Matrix

For

```
A=

[a b

 c d]
```

Formula

```
|A|

=

ad−bc
```

Example

```
[3 2

5 4]
```

```
|A|

=

(3×4)-(2×5)

=

12-10

=

2
```

---

# Determinant of 3×3 Matrix

For

```
[a b c

 d e f

 g h i]
```

Formula

```
a(ei−fh)

−

b(di−fg)

+

c(dh−eg)
```

Also called

```
Cofactor Expansion
```

---

# Sarrus Rule (Only for 3×3)

Copy the first two columns.

```
a b c a b

d e f d e

g h i g h
```

Downward diagonals

```
+

```

Upward diagonals

```
−
```

Useful for quick calculations.

---

# Minor

The **Minor** of an element is obtained by deleting its row and column.

Example

```
M23
```

Delete

- Row 2
- Column 3

Find determinant of the remaining matrix.

---

# Cofactor

Formula

```
Cij

=

(-1)^(i+j)

×

Mij
```

Sign Pattern

```
+  -  +

-  +  -

+  -  +
```

Very Important.

---

# Cofactor Expansion

Determinant can be expanded using

- Any row
- Any column

Formula

```
|A|

=

Σ

aijCij
```

Choose the row or column with the **most zeros** to reduce calculations.

---

# Properties of Determinants

## Property 1

Determinant exists only for

```
Square Matrices
```

---

## Property 2

Identity Matrix

```
|I|

=

1
```

---

## Property 3

Transpose

```
|A|

=

|Aᵀ|
```

---

## Property 4

Two Equal Rows

```
↓

Determinant = 0
```

---

## Property 5

Two Equal Columns

```
↓

Determinant = 0
```

---

## Property 6

Interchanging Two Rows

```
↓

Sign Changes
```

```
|A|

↓

-|A|
```

---

## Property 7

Interchanging Two Columns

Same result.

---

## Property 8

Multiplying One Row by

```
k
```

```
↓

Determinant becomes

k|A|
```

---

## Property 9

Multiplying Entire Matrix by

```
k
```

For

```
n×n
```

matrix

```
|kA|

=

kⁿ|A|
```

Very Important.

---

## Property 10

One Entire Row Zero

```
↓

Determinant = 0
```

---

## Property 11

Rows are Linearly Dependent

```
↓

Determinant = 0
```

---

## Property 12

Triangular Matrix

Determinant

=

Product of diagonal elements.

Example

```
[2 3 4

0 5 6

0 0 8]
```

```
|A|

=

2×5×8

=

80
```

---

# Determinant using Row Operations

Allowed operations

### Swap Rows

```
Sign Changes
```

---

### Multiply Row by k

```
Multiply determinant by k
```

---

### Add Multiple of One Row to Another

```
No Change
```

This property is heavily used in GATE.

---

# Singular Matrix

Definition

```
|A|=0
```

Properties

- No inverse
- Rank < n
- Rows are dependent

---

# Non-Singular Matrix

Definition

```
|A|≠0
```

Properties

- Inverse exists
- Full rank
- Independent rows

---

# Adjoint Matrix

The transpose of the cofactor matrix.

Notation

```
adj(A)
```

---

# Inverse using Determinant

Formula

```
A⁻¹

=

adj(A)

────────

|A|
```

Condition

```
|A|≠0
```

---

# Cramer's Rule

Used to solve

```
AX=B
```

Applicable only when

```
|A|≠0
```

Formula

```
xi

=

|Ai|

──────

|A|
```

Rare but occasionally asked.

---

# Geometric Interpretation

### 2×2 Matrix

Absolute determinant = Area scaling factor.

---

### 3×3 Matrix

Absolute determinant = Volume scaling factor.

---

If

```
det(A)=0
```

Area or volume collapses to

```
0
```

which means the transformation is **not invertible**.

---

# Important Identities

```
|AB|

=

|A||B|
```

---

```
|A⁻¹|

=

1

────

|A|
```

---

```
|Aᵀ|

=

|A|
```

---

```
|I|

=

1
```

---

# Common GATE PYQs

- Find determinant of 2×2 or 3×3 matrix
- Properties of determinants
- Row operation shortcuts
- Singular vs Non-singular matrix
- Adjoint and inverse
- Determinant identities
- Triangular matrix determinant
- Cramer's Rule

---

# Quick Revision

✅ Determinant

✅ Minor

✅ Cofactor

✅ Cofactor Expansion

✅ Sarrus Rule

✅ Row Operations

✅ Singular Matrix

✅ Non-Singular Matrix

✅ Adjoint Matrix

✅ Inverse Formula

---

# Common Mistakes

❌ Trying to find a determinant of a non-square matrix.

❌ Forgetting the cofactor sign pattern.

❌ Forgetting that swapping two rows changes the sign.

❌ Multiplying the entire matrix by `k` and using `k` instead of `kⁿ`.

❌ Forgetting that `det(A)=0` means no inverse exists.

---

# Memory Tricks

### 2×2 Determinant

```
ad−bc
```

---

### Cofactor Sign Pattern

```
+  -  +

-  +  -

+  -  +
```

---

### Triangular Matrix

```
Multiply

Diagonal

Elements
```

---

### Inverse Exists

```
det(A)

≠

0
```

---

### Row Operations

| Operation | Effect on Determinant |
|------------|-----------------------|
| Swap Rows | Sign changes |
| Multiply row by k | Multiply determinant by k |
| Add multiple of one row to another | No change |

---

# Formula Sheet

| Formula | Result |
|----------|--------|
| 2×2 Determinant | `ad−bc` |
| Cofactor | `(-1)^(i+j) × Minor` |
| Inverse | `adj(A)/det(A)` |
| Product Rule | `det(AB)=det(A)det(B)` |
| Transpose | `det(Aᵀ)=det(A)` |
| Inverse Determinant | `det(A⁻¹)=1/det(A)` |
| Triangular Matrix | Product of diagonal elements |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- Determinant Properties
- Row Operation Tricks
- Singular vs Non-Singular
- Cofactor Expansion
- Adjoint & Inverse
- Determinant Identities

---

# Next File

➡️ `18-System-of-Linear-Equations.md`