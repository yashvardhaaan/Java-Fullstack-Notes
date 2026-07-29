# Fixed Point Arithmetic

> Difficulty: ⭐⭐⭐☆☆
> GATE Weightage: ⭐⭐⭐☆☆
> Interview Importance: ⭐⭐⭐⭐☆
> Prerequisites:
> - Number Representation
> - Binary Arithmetic
> - Two's Complement
>
> Time Required: 2–3 Hours

---

# Why Should You Study Fixed Point Arithmetic?

Not every value stored in a computer is an integer.

Examples:

- Temperature
- Voltage
- Currency
- Sensor Data
- GPS Coordinates

These values contain fractional parts.

One way to store them is **Fixed Point Representation**.

Fixed-point arithmetic is widely used where:

- Speed is more important than precision.
- Hardware resources are limited.
- Floating-point hardware is unavailable.

---

# Real World Applications

Fixed-point arithmetic is used in:

- Embedded Systems
- Microcontrollers
- DSP (Digital Signal Processing)
- IoT Devices
- Digital Filters
- Robotics
- Motor Controllers
- Automotive ECUs
- Mobile Devices
- Real-Time Systems

---

# Why GATE Asks This Topic

GATE usually asks conceptual and numerical questions on:

- Fixed Point Representation
- Binary Fraction Conversion
- Arithmetic Operations
- Overflow
- Precision
- Range
- Comparison with Floating Point

---

# Learning Outcomes

After completing this chapter you should be able to

- Represent fractional numbers in binary
- Perform fixed-point arithmetic
- Detect overflow
- Calculate range and precision
- Compare fixed-point and floating-point representations

---

# What is Fixed Point Representation?

In Fixed Point Representation, the position of the binary point is fixed.

Example

```
1101.101
```

The binary point always remains at the same location.

Unlike floating-point numbers,

the binary point **never moves**.

---

# General Representation

```
IIII.FFFF
```

Where

```
I → Integer Bits

F → Fraction Bits
```

Example

```
8-bit Number

1111.0000
```

means

```
4 Integer Bits

4 Fraction Bits
```

---

# Q Format

Fixed-point numbers are usually represented using **Q Format**.

Example

```
Q7.8
```

means

```
7 Integer Bits

8 Fraction Bits
```

Another Example

```
Q1.15
```

Used extensively in DSP processors.

---

# Binary Fraction

Fractional binary digits have negative powers of 2.

Example

```
101.101₂
```

Expansion

```
1×2²

+

0×2¹

+

1×2⁰

+

1×2⁻¹

+

0×2⁻²

+

1×2⁻³
```

Result

```
5.625₁₀
```

---

# Decimal Fraction to Binary

Example

Convert

```
0.625
```

Multiply repeatedly by 2.

```
0.625 ×2 =1.25

↓

1

0.25×2=0.5

↓

0

0.5×2=1.0

↓

1
```

Answer

```
0.101₂
```

---

# Binary to Decimal Fraction

Example

```
0.1101₂
```

```
1×2⁻¹

+

1×2⁻²

+

0×2⁻³

+

1×2⁻⁴
```

```
0.5

+

0.25

+

0

+

0.0625

=

0.8125
```

---

# Fixed Point Addition

Rule

Both operands must have the same binary point position.

Example

```
10.110

+

01.101

--------

100.011
```

Overflow must be checked.

---

# Fixed Point Subtraction

Performed using

```
Two's Complement
```

Same rules as integer subtraction.

---

# Fixed Point Multiplication

Rules

- Ignore binary point initially.
- Perform normal binary multiplication.
- Place binary point after adding fractional bits.

Example

```
Q4.4

×

Q4.4

↓

Result

Q8.8
```

---

# Fixed Point Division

Rules

- Perform binary division.
- Restore binary point according to operand formats.

---

# Signed Fixed Point Numbers

Negative numbers are represented using

```
Two's Complement
```

Exactly like signed integers.

---

# Range

Suppose

```
Q4.4
```

Maximum

```
0111.1111
```

Minimum

```
1000.0000
```

General Formula

For

```
m Integer Bits

n Fraction Bits
```

Resolution

```
2⁻ⁿ
```

---

# Resolution

Resolution is the smallest change that can be represented.

Formula

```
Resolution

=

2⁻Fraction Bits
```

Example

```
Q8.8

↓

Resolution

=

1/256
```

---

# Precision

More fractional bits

↓

Higher precision

Example

```
Q4.4

↓

Precision = 1/16
```

```
Q4.8

↓

Precision = 1/256
```

Hence,

```
Q4.8

>

Q4.4
```

---

# Quantization Error

Not every decimal fraction has an exact binary representation.

Example

```
0.1₁₀
```

Cannot be represented exactly.

The difference is called

```
Quantization Error
```

---

# Overflow

Overflow occurs when the result exceeds the representable range.

Example

```
0111.1111

+

0001.0000
```

Cannot be represented.

Overflow occurs.

---

# Underflow

Occurs when the result is too small to represent.

Mostly important in floating-point arithmetic.

Rare in fixed-point systems.

---

# Saturation Arithmetic

Instead of overflowing,

some processors clamp values.

Example

Maximum

```
127
```

If result becomes

```
140
```

Stored value

```
127
```

Applications

- DSP
- Audio Processing
- Image Processing

---

# Wrap Around Arithmetic

Normal processors

↓

Discard overflow bits.

Example

```
11111111

+

1

↓

00000000
```

---

# Comparison with Floating Point

| Fixed Point | Floating Point |
|--------------|----------------|
|Fixed Binary Point|Moving Binary Point|
|Simple Hardware|Complex Hardware|
|Fast|Slower|
|Lower Precision|Higher Precision|
|Lower Cost|Higher Cost|
|Embedded Systems|Scientific Computing|

---

# Advantages

- Fast arithmetic
- Simple hardware
- Low power consumption
- Low memory usage
- Easy implementation

---

# Disadvantages

- Limited range
- Overflow occurs easily
- Lower precision
- Difficult to represent very small or very large numbers

---

# GATE PYQ Patterns

Frequently Asked

✔ Binary Fraction Conversion

✔ Fixed Point Addition

✔ Fixed Point Multiplication

✔ Resolution

✔ Precision

✔ Overflow

✔ Range

✔ Fixed vs Floating Point

---

# Shortcut Tricks

### Trick 1

More Fraction Bits

↓

Higher Precision

---

### Trick 2

More Integer Bits

↓

Larger Range

---

### Trick 3

Resolution

```
2⁻Fraction Bits
```

---

### Trick 4

Use Two's Complement

↓

Negative Numbers

---

### Trick 5

Fixed Point

↓

Fast

Floating Point

↓

Accurate

---

# Common Mistakes

❌ Forgetting binary point alignment before addition.

❌ Incorrect placement of the binary point after multiplication.

❌ Confusing precision with range.

❌ Ignoring overflow.

❌ Forgetting Two's Complement for signed values.

---

# Interview Questions

### What is Fixed Point Representation?

### Why is Fixed Point faster than Floating Point?

### What is Q Format?

### What is Quantization Error?

### Difference between Fixed Point and Floating Point?

### Where is Fixed Point used?

---

# Formula Sheet

Resolution

```
Resolution = 2⁻ⁿ
```

Where

```
n

=

Fraction Bits
```

Maximum Unsigned

```
2ᴵ−2⁻ᶠ
```

Where

```
I = Integer Bits

F = Fraction Bits
```

Precision

```
Increases

with

Fraction Bits
```

Range

```
Increases

with

Integer Bits
```

---

# One Minute Revision

- Binary point remains fixed.
- Q Format specifies integer and fractional bits.
- More fractional bits → Better precision.
- More integer bits → Larger range.
- Resolution = 2⁻Fraction Bits.
- Two's Complement is used for signed values.
- Fixed Point is faster but less flexible than Floating Point.

---

# Five Minute Revision

✅ Binary Fractions

✅ Q Format

✅ Fixed Point Addition

✅ Fixed Point Multiplication

✅ Range

✅ Resolution

✅ Precision

✅ Quantization Error

✅ Overflow

✅ Fixed vs Floating Point

---

# GATE Tips

- Always **align the binary point** before performing addition or subtraction.
- Remember the relationship:
  - **More integer bits → larger range**
  - **More fractional bits → higher precision**
- Practice binary fraction conversions—they are common in numerical questions.
- Understand the trade-off between **range, precision, and hardware complexity**.
- This chapter is closely connected to **Floating Point Arithmetic**, which is the next topic.

---

# What's Next?

➡ **09-Floating-Point-Arithmetic.md**

In the next chapter, you'll study the **IEEE 754 Floating Point Standard**, including **normalization, exponent bias, mantissa, rounding, NaN, infinity, overflow, underflow, and floating-point arithmetic**, one of the most important topics in Computer Organization and GATE.