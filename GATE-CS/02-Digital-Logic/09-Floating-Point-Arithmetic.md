# Floating Point Arithmetic

> Difficulty: ⭐⭐⭐⭐☆
> GATE Weightage: ⭐⭐⭐⭐⭐
> Interview Importance: ⭐⭐⭐⭐⭐
> Prerequisites:
> - Number Representation
> - Fixed Point Arithmetic
> - Binary Arithmetic
>
> Time Required: 4–5 Hours

---

# Why Should You Study Floating Point Arithmetic?

Many real-world values cannot be represented efficiently using Fixed Point representation.

Examples

- 0.0000000123
- 987654321234
- π
- e
- Scientific calculations

Using Fixed Point either causes

- Huge memory requirement
- Poor precision
- Overflow

Floating Point solves this problem by representing numbers similarly to scientific notation.

Example

```
125000

=

1.25 × 10⁵
```

Computers store numbers as

```
Mantissa × Base^Exponent
```

---

# Real World Applications

Floating Point Arithmetic is used in

- CPUs
- GPUs
- AI & Machine Learning
- Scientific Computing
- Graphics Processing
- Image Processing
- Computer Vision
- Weather Forecasting
- Space Research
- Simulations
- Games

Almost every modern processor contains a Floating Point Unit (FPU).

---

# Why GATE Asks This Topic?

Frequently asked topics

- IEEE 754 Representation
- Exponent Bias
- Normalization
- Mantissa
- Overflow
- Underflow
- NaN
- Infinity
- Floating Point Arithmetic
- Precision

---

# Learning Outcomes

After completing this chapter you should be able to

- Represent numbers using IEEE 754
- Normalize floating point numbers
- Calculate exponent bias
- Perform floating point addition
- Detect overflow and underflow
- Solve GATE numerical problems

---

# What is Floating Point Representation?

Floating Point stores numbers in the form

```
Mantissa × Base^Exponent
```

Example

Decimal

```
6250

=

6.25 × 10³
```

Binary

```
101.101

=

1.01101 × 2²
```

Notice

The binary point "floats".

Hence the name

```
Floating Point
```

---

# Scientific Notation

Decimal Example

```
45000

↓

4.5 × 10⁴
```

Binary Example

```
11010.11₂

↓

1.101011 × 2⁴
```

---

# Components of Floating Point Number

Every floating-point number has

```
Sign Bit

+

Exponent

+

Mantissa (Fraction)
```

---

# IEEE 754 Standard

IEEE 754 is the standard representation used by almost all modern computers.

It defines

- Floating Point Format
- Arithmetic Rules
- Special Values
- Rounding Rules
- Overflow Handling
- Underflow Handling

---

# IEEE 754 Single Precision (32-bit)

Total Bits

```
32
```

Format

| Field | Bits |
|-------|------|
| Sign | 1 |
| Exponent | 8 |
| Fraction (Mantissa) | 23 |

Layout

```
|S|Exponent|Fraction|

1

8

23
```

---

# IEEE 754 Double Precision (64-bit)

Total Bits

```
64
```

| Field | Bits |
|-------|------|
| Sign | 1 |
| Exponent | 11 |
| Fraction | 52 |

Much higher precision than Single Precision.

---

# Sign Bit

```
0

↓

Positive
```

```
1

↓

Negative
```

---

# Exponent

Exponent is stored using

```
Bias Representation
```

Actual exponent is not stored directly.

---

# Bias

Formula

```
Bias

=

2^(k−1)-1
```

where

```
k

=

Number of Exponent Bits
```

---

## Bias for Single Precision

Exponent Bits

```
8
```

Bias

```
127
```

---

## Bias for Double Precision

Exponent Bits

```
11
```

Bias

```
1023
```

⭐ Very Important GATE Formula

---

# Mantissa (Fraction)

Mantissa stores the significant digits.

IEEE assumes a hidden leading

```
1
```

for normalized numbers.

Example

Stored

```
101000...
```

Actual

```
1.101000...
```

This is called the

```
Hidden Bit
```

or

```
Implicit Leading One
```

---

# Normalization

A normalized binary number has exactly one non-zero digit before the binary point.

Correct

```
1.101 × 2³
```

Incorrect

```
101.1 × 2¹
```

Normalization maximizes precision.

---

# Denormalized Numbers

Very small numbers cannot be normalized.

These are called

```
Denormalized Numbers
```

Characteristics

- Exponent = 0
- No hidden 1
- Used to avoid sudden underflow

---

# Representing a Number

Example

Represent

```
13.25
```

Step 1

Convert to binary

```
1101.01₂
```

Step 2

Normalize

```
1.10101 × 2³
```

Step 3

Sign

```
0
```

Step 4

Exponent

```
3 + 127

=

130

=

10000010₂
```

Step 5

Mantissa

```
101010000...
```

Final IEEE Representation

```
Sign

Exponent

Mantissa
```

---

# Floating Point Addition

Steps

1.

Equalize exponents.

↓

2.

Shift smaller mantissa.

↓

3.

Add mantissas.

↓

4.

Normalize.

↓

5.

Round if required.

---

# Floating Point Subtraction

Same as addition except mantissas are subtracted.

---

# Floating Point Multiplication

Rules

Multiply Mantissas

+

Add Exponents

+

Normalize

---

# Floating Point Division

Rules

Divide Mantissas

+

Subtract Exponents

+

Normalize

---

# Rounding

Sometimes a number cannot be represented exactly.

IEEE provides rounding modes.

Most common

```
Round to Nearest Even
```

Other modes

- Round Toward Zero
- Round Toward +∞
- Round Toward −∞

---

# Precision

Single Precision

Approximately

```
7 Decimal Digits
```

Double Precision

Approximately

```
15–16 Decimal Digits
```

---

# Overflow

Occurs when

Exponent becomes too large.

Result

```
±∞
```

---

# Underflow

Occurs when

Exponent becomes too small.

Result becomes

```
Denormalized

↓

Zero
```

---

# Infinity

Positive

```
+∞
```

Negative

```
−∞
```

Representation

Exponent

```
All 1's
```

Fraction

```
All 0's
```

---

# NaN (Not a Number)

Occurs during invalid operations.

Examples

```
0 / 0
```

```
∞ − ∞
```

Representation

Exponent

```
All 1's
```

Fraction

```
Non-Zero
```

---

# Comparison with Fixed Point

| Fixed Point | Floating Point |
|--------------|----------------|
|Fixed Binary Point|Moving Binary Point|
|Simple Hardware|Complex Hardware|
|Fast|Slower|
|Small Range|Huge Range|
|Less Precision|Higher Precision|
|Embedded Systems|Scientific Computing|

---

# Advantages

- Huge range
- High precision
- Standardized (IEEE 754)
- Supports scientific calculations
- Widely supported in hardware

---

# Disadvantages

- More hardware
- Slower than Fixed Point
- Rounding errors
- Precision loss in repeated calculations

---

# GATE PYQ Patterns

Frequently Asked

✔ IEEE 754 Format

✔ Bias Calculation

✔ Hidden Bit

✔ Normalization

✔ Floating Point Representation

✔ Overflow

✔ Underflow

✔ NaN

✔ Infinity

✔ Single vs Double Precision

---

# Shortcut Tricks

### Trick 1

Single Precision

```
1

8

23
```

---

### Trick 2

Double Precision

```
1

11

52
```

---

### Trick 3

Bias

```
2^(k−1)-1
```

---

### Trick 4

Normalized Numbers

Always start with

```
1.
```

---

### Trick 5

Exponent

All 1's

+

Fraction = 0

↓

Infinity

Exponent

All 1's

+

Fraction ≠ 0

↓

NaN

---

# Common Mistakes

❌ Forgetting the hidden leading 1.

❌ Using incorrect bias.

❌ Confusing overflow with underflow.

❌ Forgetting normalization after arithmetic.

❌ Mixing Fixed Point and Floating Point rules.

---

# Interview Questions

### Why do computers use Floating Point?

### What is IEEE 754?

### Why is Bias used?

### What is the Hidden Bit?

### Difference between Single and Double Precision?

### What is NaN?

### What causes Overflow?

### Why are Denormalized Numbers required?

---

# Formula Sheet

Bias

```
Bias

=

2^(k−1)-1
```

Single Precision

```
1

8

23
```

Double Precision

```
1

11

52
```

Exponent

```
Stored

=

Actual + Bias
```

Actual

```
Stored − Bias
```

---

# One Minute Revision

- Floating Point uses scientific notation.
- IEEE 754 is the standard.
- Single Precision = 32 bits.
- Double Precision = 64 bits.
- Bias = 127 (Single), 1023 (Double).
- Hidden leading 1 increases precision.
- Overflow → Infinity.
- Underflow → Denormalized/Zero.
- NaN represents invalid operations.

---

# Five Minute Revision

✅ Scientific Notation

✅ IEEE 754 Layout

✅ Sign Bit

✅ Exponent

✅ Bias

✅ Mantissa

✅ Hidden Bit

✅ Normalization

✅ Denormalization

✅ Floating Point Arithmetic

✅ Overflow

✅ Underflow

✅ NaN

✅ Infinity

---

# GATE Tips

- Memorize the **IEEE 754 layouts**:
  - **Single Precision:** 1 | 8 | 23
  - **Double Precision:** 1 | 11 | 52
- Always calculate the **stored exponent** using:
  ```
  Stored Exponent = Actual Exponent + Bias
  ```
- Be comfortable converting decimal numbers to normalized binary form.
- Understand the difference between **Infinity** and **NaN** based on the exponent and fraction fields.
- Practice at least **15–20 IEEE 754 representation problems**, as these are common in GATE and Computer Organization.

---

# Chapter Summary

By completing this chapter, you should be able to:

- ✔ Represent numbers using IEEE 754 Single and Double Precision
- ✔ Convert decimal values into normalized binary form
- ✔ Calculate exponent bias correctly
- ✔ Perform floating-point arithmetic conceptually
- ✔ Identify overflow, underflow, NaN, and Infinity
- ✔ Solve GATE numerical and conceptual questions on floating-point representation

---

# Digital Logic Complete 🎉

You have now completed the complete Digital Logic syllabus:

1. Boolean Algebra
2. Algebraic Minimization
3. Karnaugh Maps
4. Tabular (Quine–McCluskey) Method
5. Combinational Circuits
6. Sequential Circuits
7. Number Representation
8. Fixed Point Arithmetic
9. Floating Point Arithmetic

These notes provide the conceptual foundation required for **GATE**, **Computer Organization & Architecture (COA)**, and **technical interviews**.