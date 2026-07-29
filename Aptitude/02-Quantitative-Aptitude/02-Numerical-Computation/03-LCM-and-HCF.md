# HCF and LCM

## Definition

**HCF (Highest Common Factor)** is the largest number that divides two or more numbers exactly.

**LCM (Least Common Multiple)** is the smallest positive number that is exactly divisible by two or more numbers.

HCF is also called:

- GCD (Greatest Common Divisor)
- GCF (Greatest Common Factor)

---

# Why Learn This?

HCF and LCM are fundamental concepts used whenever objects need to be grouped efficiently or synchronized.

Applications include:

- **Software Engineering** – Task scheduling, CPU scheduling, memory allocation, and algorithm optimization.
- **Computer Networks** – Packet transmission intervals and synchronization.
- **Manufacturing** – Packing items into equal-sized groups with minimal waste.
- **Project Management** – Scheduling recurring meetings and maintenance tasks.
- **Music & Signal Processing** – Finding repeating patterns and frequencies.
- **Engineering** – Gear rotations and machine synchronization.

---

# Prerequisites

Before learning HCF and LCM, you should know:

- Number System
- Divisibility Rules
- Factors and Multiples
- Prime Numbers

---

# HCF (Highest Common Factor)

The **largest common factor** of two or more numbers.

Example

```
12 and 18
```

Factors of 12

```
1

2

3

4

6

12
```

Factors of 18

```
1

2

3

6

9

18
```

Largest common factor

```
6
```

Therefore

```
HCF = 6
```

---

# LCM (Least Common Multiple)

The **smallest common multiple** of two or more numbers.

Example

```
6 and 8
```

Multiples of 6

```
6

12

18

24

30

36...
```

Multiples of 8

```
8

16

24

32...
```

Smallest common multiple

```
24
```

Therefore

```
LCM = 24
```

---

# Methods to Find HCF

```
HCF
│
├── Listing Factors
├── Prime Factorization
├── Division Method
└── Euclidean Algorithm
```

---

# 1. Listing Factors

Suitable for small numbers.

Example

```
24

36
```

Common factors

```
1

2

3

4

6

12
```

Answer

```
12
```

---

# 2. Prime Factorization Method

Example

Find HCF of

```
48

60
```

Prime Factorization

```
48

=2⁴×3
```

```
60

=2²×3×5
```

Take smallest powers

```
2²×3

=12
```

Answer

```
HCF = 12
```

---

# 3. Division Method

Example

Find HCF of

```
54

24
```

```
54 ÷ 24

=2 remainder 6
```

```
24 ÷ 6

=4 remainder 0
```

Answer

```
HCF = 6
```

---

# 4. Euclidean Algorithm

The Euclidean Algorithm repeatedly replaces the larger number with the remainder until the remainder becomes zero.

Formula

```
HCF(a,b)

=

HCF(b,a mod b)
```

Example

```
HCF(84,30)
```

```
84 mod 30 =24

30 mod 24 =6

24 mod 6 =0

Answer

6
```

---

# Methods to Find LCM

```
LCM
│
├── Listing Multiples
├── Prime Factorization
└── Division Method
```

---

# Prime Factorization Method

Example

Find LCM of

```
18

30
```

Prime Factors

```
18

=2×3²
```

```
30

=2×3×5
```

Take largest powers

```
2×3²×5

=90
```

Answer

```
LCM = 90
```

---

# Division Method

Example

Find LCM of

```
12

15
```

```
2 | 12 15

2 | 6 15

3 | 3 15

5 | 1 5

    1 1
```

Multiply divisors

```
2×2×3×5

=60
```

Answer

```
60
```

---

# Relationship Between HCF and LCM

For two numbers

```
HCF × LCM

=

Product of Numbers
```

Example

```
8

12
```

```
HCF=4

LCM=24
```

Verification

```
4×24

=96

8×12

=96
```

Verified.

---

# Important Formulae

## HCF

```
Product of Common Prime Factors
(with smallest powers)
```

---

## LCM

```
Product of All Prime Factors
(with largest powers)
```

---

## Product Relation

```
HCF × LCM

=

Number1 × Number2
```

---

# Applications

## Equal Grouping

Use

```
HCF
```

Example

Packing chocolates into the largest equal groups.

---

## Synchronization

Use

```
LCM
```

Example

Three traffic lights blink every

```
20 sec

30 sec

40 sec
```

When will they blink together?

```
LCM

=120 sec
```

---

# Solving Strategy

```
Read Question
      │
      ▼
Identify Whether
HCF or LCM
      │
      ▼
Prime Factorization
or Division Method
      │
      ▼
Apply Formula
      │
      ▼
Verify
```

---

# Shortcuts & Tricks

### 1. HCF Uses Smallest Powers

```
2²×3
```

---

### 2. LCM Uses Largest Powers

```
2⁴×3²×5
```

---

### 3. Memorize

```
HCF

↓

Grouping

LCM

↓

Repeating Events
```

---

### 4. Use Product Relation

When HCF and one number are known.

---

### 5. Division Method is Faster

For two medium-sized numbers.

---

# Solved Examples

## Example 1

Find HCF of

```
36

48
```

Solution

```
36

=2²×3²
```

```
48

=2⁴×3
```

HCF

```
2²×3

=12
```

Answer

```
12
```

---

## Example 2

Find LCM of

```
20

30
```

Solution

```
20

=2²×5
```

```
30

=2×3×5
```

LCM

```
2²×3×5

=60
```

Answer

```
60
```

---

## Example 3

Two bells ring every

```
12 min

18 min
```

When will they ring together again?

Solution

```
LCM

36
```

Answer

```
36 minutes
```

---

## Example 4

Find another number if

```
HCF=8

LCM=240

One number=48
```

Solution

```
(8×240)/48

=40
```

Answer

```
40
```

---

# Common Mistakes

### Mistake 1

Using largest powers while finding HCF.

---

### Mistake 2

Using smallest powers while finding LCM.

---

### Mistake 3

Confusing grouping problems with synchronization problems.

---

### Mistake 4

Forgetting the product relation.

---

### Mistake 5

Ignoring repeated prime factors.

---

# Previous Year Question Pattern

Frequently tested concepts:

- HCF using Prime Factorization
- LCM using Prime Factorization
- Division Method
- Product Relation
- Repeating Events
- Grouping Problems
- Missing Number Problems

---

# Practice Questions

## Q1

Find the HCF of

```
42

56
```

**Answer**

```
14
```

---

## Q2

Find the LCM of

```
24

36
```

**Answer**

```
72
```

---

## Q3

Three machines complete one cycle every

```
8 min

12 min

24 min
```

When will they complete a cycle together?

**Answer**

```
LCM

24 minutes
```

---

## Q4

Find another number if

```
HCF=6

LCM=180

One number=30
```

**Answer**

```
(6×180)/30

=36
```

---

## Q5

Find the HCF of

```
81

108
```

**Answer**

```
27
```

---

# Quick Revision Sheet

| Concept | Formula / Rule |
|----------|----------------|
| HCF | Product of common prime factors (smallest powers) |
| LCM | Product of all prime factors (largest powers) |
| Product Relation | HCF × LCM = Product of Numbers |
| Grouping Problems | Use HCF |
| Repeating Events | Use LCM |

---

# GATE 80/20 Summary

✅ **HCF** is used for **maximum equal grouping**.

✅ **LCM** is used for **repeating events and synchronization**.

✅ Prime factorization is the fastest and most reliable method for most problems.

✅ Remember the identity:

```
HCF × LCM = Product of the Two Numbers
```

✅ Most aptitude questions involve **prime factorization, division method, repeating events, and missing number calculations**.

---

# Next File

➡️ `05-Prime-Numbers.md`