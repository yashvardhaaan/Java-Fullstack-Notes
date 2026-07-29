# System of Linear Equations

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# What is a System of Linear Equations?

A **System of Linear Equations (SLE)** is a collection of two or more linear equations involving the same variables.

Example

```
2x + y = 5

x - y = 1
```

The goal is to find the values of

```
x

and

y
```

that satisfy **all equations simultaneously**.

---

# Why is it Important?

Systems of linear equations are used in

- Machine Learning
- Artificial Intelligence
- Computer Graphics
- Data Science
- Network Analysis
- Electrical Circuits
- Economics

Almost every engineering field solves systems of equations.

---

# Matrix Representation

A system of equations can be written compactly as

```
AX = B
```

where

```
A = Coefficient Matrix

X = Unknown Variables

B = Constant Matrix
```

Example

```
2x+y=5

x-y=1
```

becomes

```
[2 1]     [x]     [5]

[1 -1] ×  [y]  =  [1]
```

---

# Types of Systems

```
System of Linear Equations
│
├── Consistent
│      ├── Unique Solution
│      └── Infinite Solutions
│
└── Inconsistent
       └── No Solution
```

---

# Consistent System

A solution exists.

There are two possibilities

### Unique Solution

Exactly one solution.

Example

```
x+y=4

x-y=2
```

Solution

```
x=3

y=1
```

---

### Infinite Solutions

Occurs when one equation is a multiple of another.

Example

```
x+y=2

2x+2y=4
```

Both equations represent the same line.

---

# Inconsistent System

No solution exists.

Example

```
x+y=2

x+y=5
```

Parallel lines.

---

# Geometric Interpretation

For two variables

```
One equation

↓

One Line
```

### Unique Solution

```
Two lines intersect once.
```

---

### Infinite Solutions

```
Both lines overlap.
```

---

### No Solution

```
Parallel lines.
```

---

# Rank of a Matrix

## Intuition

Rank tells us how many **independent equations** are present.

Dependent equations do not provide new information.

Notation

```
Rank(A)
```

---

# Rank Criterion (Rouché–Capelli Theorem)

Let

```
A = Coefficient Matrix

[A|B] = Augmented Matrix
```

Then

### Case 1

```
Rank(A)

=

Rank(A|B)

=

Number of Variables
```

✅ Unique Solution

---

### Case 2

```
Rank(A)

=

Rank(A|B)

<

Number of Variables
```

✅ Infinite Solutions

---

### Case 3

```
Rank(A)

≠

Rank(A|B)
```

❌ No Solution

**This is one of the most frequently asked concepts in GATE.**

---

# Augmented Matrix

Combine

```
A

and

B
```

into one matrix.

Example

```
2x+y=5

x-y=1
```

Augmented Matrix

```
[2 1 | 5]

[1 -1| 1]
```

---

# Gaussian Elimination

A systematic method to solve equations by converting the augmented matrix into **Row Echelon Form (REF)**.

### Steps

1. Form the augmented matrix.
2. Apply elementary row operations.
3. Convert to REF.
4. Use back substitution.

---

# Example

```
x+y=3

2x+y=4
```

Augmented Matrix

```
[1 1 |3]

[2 1 |4]
```

Apply

```
R₂

=

R₂−2R₁
```

Result

```
[1 1 |3]

[0 -1|-2]
```

Back substitute

```
y=2

x=1
```

---

# Gauss-Jordan Elimination

An extension of Gaussian Elimination.

Convert the matrix into

```
Reduced Row Echelon Form (RREF)
```

Advantages

- No back substitution required.
- Solution is obtained directly.

---

# Elementary Row Operations

Allowed operations

### Swap Rows

```
Ri ↔ Rj
```

---

### Multiply a Row

```
Ri → kRi

(k≠0)
```

---

### Add Multiple of Another Row

```
Ri → Ri+kRj
```

These operations **do not change the solution**.

---

# Cramer's Rule

Applicable only when

```
det(A)≠0
```

Formula

```
xi

=

det(Ai)

────────

det(A)
```

where

```
Ai
```

is obtained by replacing the

```
i-th
```

column with the constants.

Useful for

- 2×2
- 3×3

Not suitable for large systems.

---

# Inverse Matrix Method

If

```
AX=B
```

and

```
A⁻¹
```

exists,

then

```
X=A⁻¹B
```

Condition

```
det(A)≠0
```

---

# Homogeneous System

All constants are

```
0
```

Example

```
2x+y=0

x-y=0
```

Matrix Form

```
AX=0
```

---

# Solutions of Homogeneous System

### Trivial Solution

```
x=0

y=0

z=0
```

Always exists.

---

### Non-Trivial Solution

Exists only if

```
det(A)=0
```

or

```
Rank(A)

<

Number of Variables
```

---

# Important Relationships

Unique Solution

```
det(A)

≠

0
```

---

Infinite Solutions

```
Rank(A)

=

Rank(A|B)

<

Number of Variables
```

---

No Solution

```
Rank(A)

≠

Rank(A|B)
```

---

# Comparison of Methods

| Method | Best For |
|---------|----------|
| Gaussian Elimination | General systems |
| Gauss-Jordan | Direct solution |
| Cramer's Rule | Small systems (2×2, 3×3) |
| Inverse Method | When inverse already exists |
| Rank Method | Determining number of solutions |

---

# Common GATE PYQs

- Rank of coefficient matrix
- Rank of augmented matrix
- Number of solutions
- Gaussian elimination
- Gauss-Jordan elimination
- Homogeneous systems
- Cramer's Rule
- Matrix inverse method
- Rouché–Capelli theorem

---

# Quick Revision

✅ Matrix Form (AX=B)

✅ Coefficient Matrix

✅ Augmented Matrix

✅ Rank

✅ Gaussian Elimination

✅ Gauss-Jordan

✅ Rouché–Capelli Theorem

✅ Cramer's Rule

✅ Inverse Method

✅ Homogeneous System

---

# Common Mistakes

❌ Confusing **Coefficient Matrix** with **Augmented Matrix**.

❌ Forgetting that **det(A)=0** does **not** always imply no solution (it may imply infinitely many).

❌ Using Cramer's Rule when

```
det(A)=0
```

❌ Stopping Gaussian Elimination before reaching REF.

❌ Ignoring the rank conditions.

---

# Memory Tricks

### Matrix Form

```
AX=B
```

---

### Unique Solution

```
Rank(A)

=

Rank(A|B)

=

Variables
```

---

### Infinite Solutions

```
Equal Ranks

↓

Less than Variables
```

---

### No Solution

```
Ranks Different
```

---

### Homogeneous System

```
AX=0
```

Always has

```
Trivial Solution
```

---

# Formula Sheet

| Formula | Result |
|----------|--------|
| Matrix Form | `AX=B` |
| Unique Solution | `Rank(A)=Rank(A|B)=n` |
| Infinite Solutions | `Rank(A)=Rank(A|B)<n` |
| No Solution | `Rank(A)≠Rank(A|B)` |
| Inverse Method | `X=A⁻¹B` |
| Cramer's Rule | `xᵢ=det(Aᵢ)/det(A)` |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- Rank Method
- Gaussian Elimination
- Gauss-Jordan Elimination
- Rouché–Capelli Theorem
- Homogeneous Systems
- Cramer's Rule
- Matrix Inverse Method

---

# Next File

➡️ `19-Eigenvalues-and-Eigenvectors.md`