# Divisibility Rules

## Definition

**Divisibility Rules** are shortcut techniques used to determine whether a number is divisible by another number **without performing long division**.

They help solve aptitude questions quickly and are extensively used in Number System, HCF, LCM, Factors, Prime Numbers, and Simplification.

---

# Why Learn This?

Divisibility rules improve calculation speed and reduce manual computation.

Applications include:

- **Software Engineering** – Data validation, hashing, modular arithmetic, and algorithm optimization.
- **Cryptography** – Prime number generation and modular operations.
- **Finance** – Quick validation of calculations and accounting checks.
- **Data Science** – Numerical preprocessing and mathematical computations.
- **Competitive Programming** – Efficient solutions for divisibility-based problems.
- **Scientific Computing** – Simplifying numerical calculations.

---

# Prerequisites

Before learning Divisibility Rules, you should know:

- Number System
- Addition
- Subtraction
- Multiplication
- Place Value

---

# Why Divisibility Rules Matter

Instead of performing

```
87654 ÷ 9
```

You simply check

```
8+7+6+5+4

=30

30 is not divisible by 9

Therefore

87654 is not divisible by 9
```

This saves time.

---

# Divisibility Rules

## Divisible by 2

Rule

The **last digit** must be even.

Possible last digits

```
0

2

4

6

8
```

Examples

```
248 ✔

572 ✔

914 ✔

915 ✘
```

---

## Divisible by 3

Rule

Add all digits.

If the sum is divisible by **3**, the number is divisible by **3**.

Example

```
672

6+7+2

=15

15 is divisible by 3

Therefore

672 is divisible by 3
```

---

## Divisible by 4

Rule

Check the **last two digits**.

If they are divisible by **4**, the entire number is divisible by **4**.

Example

```
13516

Last two digits

16

16÷4

=4

Therefore divisible.
```

---

## Divisible by 5

Rule

Last digit must be

```
0

or

5
```

Examples

```
235 ✔

870 ✔

234 ✘
```

---

## Divisible by 6

Rule

The number must be divisible by **2** and **3**.

Example

```
432

Last digit = 2 ✔

Digit Sum

4+3+2=9 ✔

Therefore divisible by 6.
```

---

## Divisible by 7

Rule

Multiply the last digit by **2**.

Subtract it from the remaining number.

Repeat if necessary.

If the result is divisible by **7**, the original number is divisible by **7**.

Example

```
203

20−(3×2)

20−6

=14

14 is divisible by 7

Therefore

203 is divisible by 7.
```

---

## Divisible by 8

Rule

Check the **last three digits**.

If they are divisible by **8**, the number is divisible by **8**.

Example

```
4216

216÷8

=27

Therefore divisible.
```

---

## Divisible by 9

Rule

Add all digits.

If the sum is divisible by **9**, the number is divisible by **9**.

Example

```
729

7+2+9

=18

18 divisible by 9

Therefore divisible.
```

---

## Divisible by 10

Rule

Last digit must be

```
0
```

Examples

```
450 ✔

920 ✔

923 ✘
```

---

## Divisible by 11

Rule

Find the difference between the sum of digits in alternate positions.

If the difference is **0** or divisible by **11**, the number is divisible by **11**.

Example

```
50611

(5+6+1)

=12

(0+1)

=1

Difference

12−1

=11

Therefore divisible.
```

---

## Divisible by 12

Rule

The number must be divisible by

- 3
- 4

Example

```
348

Digit Sum

3+4+8

=15 ✔

Last Two Digits

48 ✔

Therefore divisible by 12.
```

---

## Divisible by 15

Rule

The number must be divisible by

- 3
- 5

Example

```
735

Digit Sum

7+3+5=15 ✔

Last digit =5 ✔

Therefore divisible.
```

---

## Divisible by 18

Rule

The number must be divisible by

- 2
- 9

---

## Divisible by 25

Rule

The last two digits must be

```
00

25

50

75
```

Examples

```
325 ✔

750 ✔

643 ✘
```

---

## Divisible by 100

Rule

Last two digits must be

```
00
```

---

## Divisible by 1000

Rule

Last three digits must be

```
000
```

---

# Summary Table

| Number | Rule |
|---------|------|
| 2 | Last digit even |
| 3 | Sum of digits divisible by 3 |
| 4 | Last two digits divisible by 4 |
| 5 | Last digit 0 or 5 |
| 6 | Divisible by 2 and 3 |
| 7 | Double last digit, subtract, repeat |
| 8 | Last three digits divisible by 8 |
| 9 | Sum of digits divisible by 9 |
| 10 | Last digit 0 |
| 11 | Alternate digit difference divisible by 11 |
| 12 | Divisible by 3 and 4 |
| 15 | Divisible by 3 and 5 |
| 18 | Divisible by 2 and 9 |
| 25 | Last two digits are 00, 25, 50, or 75 |
| 100 | Last two digits are 00 |
| 1000 | Last three digits are 000 |

---

# Solving Strategy

```
Read Number
      │
      ▼
Identify Divisor
      │
      ▼
Recall Rule
      │
      ▼
Apply Shortcut
      │
      ▼
Verify Answer
```

---

# Shortcuts & Tricks

### 1. Memorize Composite Rules

```
6 = 2 × 3

12 = 3 × 4

15 = 3 × 5

18 = 2 × 9
```

---

### 2. Last Digit Rules

```
2

5

10
```

depend only on the last digit.

---

### 3. Last Two Digit Rules

```
4

25

100
```

---

### 4. Last Three Digit Rules

```
8

1000
```

---

### 5. Digit Sum Rules

```
3

9
```

---

# Solved Examples

## Example 1

Is **1356** divisible by 4?

Solution

```
Last two digits

56

56÷4

=14
```

Answer

```
Yes
```

---

## Example 2

Is **945** divisible by 9?

Solution

```
9+4+5

=18

18÷9

=2
```

Answer

```
Yes
```

---

## Example 3

Is **2450** divisible by 25?

Solution

```
Last two digits

50
```

Answer

```
Yes
```

---

## Example 4

Is **50611** divisible by 11?

Solution

```
(5+6+1)

=12

(0+1)

=1

12−1

=11
```

Answer

```
Yes
```

---

# Common Mistakes

### Mistake 1

Checking all digits instead of only the required digits.

---

### Mistake 2

Using the rule for 3 when checking divisibility by 9.

---

### Mistake 3

Forgetting that divisibility by 6 requires both 2 and 3.

---

### Mistake 4

Ignoring the alternate-digit rule for 11.

---

### Mistake 5

Applying multiple rules unnecessarily.

---

# Previous Year Question Pattern

Frequently tested concepts:

- Divisibility by 2, 3, 4, 5, 6, 8, 9, and 11
- Composite divisibility (12, 15, 18)
- Last digit and last two-digit rules
- Digit sum techniques
- Fast elimination using divisibility shortcuts

---

# Practice Questions

## Q1

Is **648** divisible by 8?

**Answer**

```
Last three digits

648

648÷8

=81

Yes
```

---

## Q2

Is **693** divisible by 9?

**Answer**

```
6+9+3

=18

Yes
```

---

## Q3

Is **875** divisible by 25?

**Answer**

```
Last two digits

75

Yes
```

---

## Q4

Is **1242** divisible by 6?

**Answer**

```
Last digit even ✔

1+2+4+2=9 ✔

Yes
```

---

## Q5

Is **1430** divisible by 10?

**Answer**

```
Last digit = 0

Yes
```

---

# Quick Revision Sheet

| Divisor | Shortcut |
|---------:|----------|
| 2 | Last digit even |
| 3 | Sum of digits divisible by 3 |
| 4 | Last 2 digits divisible by 4 |
| 5 | Last digit 0 or 5 |
| 6 | Divisible by 2 and 3 |
| 7 | Double last digit, subtract |
| 8 | Last 3 digits divisible by 8 |
| 9 | Sum of digits divisible by 9 |
| 10 | Last digit 0 |
| 11 | Alternate digit difference divisible by 11 |
| 25 | Last 2 digits: 00, 25, 50, 75 |

---

# GATE 80/20 Summary

✅ Memorize the divisibility rules for **2, 3, 4, 5, 6, 8, 9, 10, and 11**.

✅ Remember composite rules:
- 6 = 2 × 3
- 12 = 3 × 4
- 15 = 3 × 5
- 18 = 2 × 9

✅ Use **digit-sum rules** for 3 and 9, **last-digit rules** for 2, 5, and 10, and **last two/three digit rules** for 4, 8, 25, 100, and 1000.

✅ These shortcuts eliminate the need for long division in most aptitude questions.

---

# Next File

➡️ `03-Factors-and-Multiples.md`