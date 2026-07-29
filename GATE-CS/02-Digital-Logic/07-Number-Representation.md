# Number Representation

> Difficulty: ⭐⭐⭐☆☆
> GATE Weightage: ⭐⭐⭐⭐⭐
> Interview Importance: ⭐⭐⭐⭐☆
> Prerequisites:
> - Binary Number System
> - Basic Arithmetic
>
> Time Required: 4–5 Hours

---

# Why Should You Study Number Representation?

Computers understand only **binary (0 and 1)**.

Everything inside a computer—including numbers, characters, instructions, memory addresses, images, and videos—is represented using binary.

Without number representation:

- CPUs cannot perform arithmetic.
- Memory cannot store data correctly.
- Operating Systems cannot manage addresses.
- Networks cannot transmit data.
- Compilers cannot generate machine code.

This chapter forms the foundation of:

- Digital Logic
- Computer Organization (COA)
- Operating Systems
- Computer Networks
- Compilers

---

# Real World Applications

Number representation is used in:

- CPU arithmetic operations
- Memory addressing
- Machine language instructions
- Floating-point calculations
- Image and audio processing
- Embedded systems
- Cryptography
- Networking
- Data compression

---

# Why GATE Asks This Topic

This chapter is one of the most frequently asked topics.

Common questions include:

- Base conversion
- Complements
- Signed number representation
- Overflow
- Binary arithmetic
- Gray Code
- BCD
- ASCII
- IEEE Floating Point (covered separately)

---

# Learning Outcomes

After completing this chapter you should be able to

- Convert between number systems
- Perform binary arithmetic
- Represent signed numbers
- Detect overflow
- Understand Gray Code
- Solve GATE numerical questions quickly

---

# What is Number Representation?

Number Representation is the method of storing numbers inside a digital computer.

Since computers understand only binary,

Every number is converted into binary before processing.

Example

Decimal

```
25
```

Binary

```
11001₂
```

---

# Number Systems

Four number systems are commonly used.

| Number System | Base | Digits |
|---------------|------|--------|
| Decimal | 10 | 0–9 |
| Binary | 2 | 0–1 |
| Octal | 8 | 0–7 |
| Hexadecimal | 16 | 0–9, A–F |

---

# Positional Number System

The value of a digit depends on

- Digit
- Position
- Base

Example

```
(345)₁₀

= 3×10² + 4×10¹ + 5×10⁰
```

General Formula

```
Value = Σ(Digit × Base^Position)
```

⭐ Important GATE Formula

---

# Decimal to Binary Conversion

Method

Repeatedly divide by 2.

Example

```
13

↓

13 ÷2 = 6 R1

6 ÷2 =3 R0

3 ÷2 =1 R1

1 ÷2 =0 R1
```

Answer

```
1101₂
```

---

# Binary to Decimal

Multiply each bit by its positional weight.

Example

```
101101₂
```

```
=1×32

+0×16

+1×8

+1×4

+0×2

+1×1

=45
```

---

# Decimal to Octal

Repeated division by

```
8
```

---

# Decimal to Hexadecimal

Repeated division by

```
16
```

---

# Binary ↔ Octal

Group bits in

```
3
```

Example

```
101110001₂

↓

101 110 001

↓

561₈
```

---

# Binary ↔ Hexadecimal

Group bits in

```
4
```

Example

```
10111111₂

↓

1011 1111

↓

BF₁₆
```

---

# Octal ↔ Binary

Each Octal digit

↓

3 Binary Bits

Example

```
7₈

↓

111₂
```

---

# Hexadecimal ↔ Binary

Each Hex digit

↓

4 Binary Bits

Example

```
A₁₆

↓

1010₂
```

---

# Binary Addition

Rules

```
0+0=0

0+1=1

1+0=1

1+1=10

1+1+1=11
```

Example

```
1010

+

0111

=

10001
```

---

# Binary Subtraction

Rules

```
1−0=1

1−1=0

0−0=0

0−1=Borrow
```

---

# Binary Multiplication

Rules

```
0×0=0

0×1=0

1×0=0

1×1=1
```

---

# Binary Division

Same as decimal long division.

---

# Signed and Unsigned Numbers

## Unsigned

All bits represent magnitude.

Example

```
8 bits

0–255
```

Formula

```
0 to 2ⁿ−1
```

---

## Signed Numbers

One bit stores the sign.

```
0 = Positive

1 = Negative
```

---

# Sign Magnitude Representation

MSB

↓

Sign

Remaining Bits

↓

Magnitude

Example

```
10001011

↓

Negative
```

Problems

- Two representations of zero
- Complex arithmetic

Rarely used.

---

# One's Complement

Negative number

↓

Invert all bits

Example

```
01010101

↓

10101010
```

Range

```
-(2ⁿ⁻¹−1)

to

+(2ⁿ⁻¹−1)
```

Problem

Two zeros.

---

# Two's Complement

Most widely used representation.

Steps

1.

Invert bits

2.

Add 1

Example

```
13

00001101

↓

11110010

↓

11110011
```

Advantages

- Single zero
- Easy arithmetic
- Hardware friendly

---

# Range of Two's Complement

For

```
n bits
```

Range

```
−2ⁿ⁻¹

to

2ⁿ⁻¹−1
```

Example

8 bits

```
−128

to

127
```

⭐ Very Important Formula

---

# Overflow

Overflow occurs when

Result cannot be represented using the available bits.

Example

```
01111111

+

00000001

↓

10000000
```

Overflow occurs.

---

# Overflow Detection Rules

Addition

Positive + Positive → Negative

↓

Overflow

Negative + Negative → Positive

↓

Overflow

Otherwise

↓

No Overflow

---

# BCD (Binary Coded Decimal)

Each decimal digit uses

```
4 bits
```

Example

```
59

↓

0101 1001
```

Notice

BCD is **not** ordinary binary.

---

# Gray Code

Gray Code changes only

```
One Bit
```

between consecutive numbers.

Example

Binary

```
000

001

010

011
```

Gray

```
000

001

011

010
```

Applications

- Rotary Encoders
- Position Sensors
- Error Reduction

---

# Binary to Gray Conversion

Rule

```
MSB

↓

Same
```

Remaining Bits

↓

Previous XOR Current

Example

Binary

```
1011
```

Gray

```
1110
```

---

# Gray to Binary Conversion

Rule

MSB

↓

Same

Remaining Bits

↓

Previous Binary XOR Current Gray

---

# ASCII

ASCII stores characters.

Uses

```
7 bits
```

Extended ASCII

```
8 bits
```

Example

```
'A'

↓

65

↓

1000001
```

---

# Unicode

Supports almost every language.

UTF

- UTF-8
- UTF-16
- UTF-32

Modern computers use Unicode.

---

# Common Character Codes

| Character | ASCII |
|------------|-------|
| A | 65 |
| a | 97 |
| 0 | 48 |
| Space | 32 |

---

# GATE PYQ Patterns

Frequently Asked

✔ Base Conversion

✔ Two's Complement

✔ Overflow

✔ Gray Code

✔ BCD

✔ ASCII

✔ Binary Arithmetic

✔ Signed Numbers

---

# Shortcut Tricks

### Trick 1

Binary → Octal

```
3 Bits
```

---

### Trick 2

Binary → Hex

```
4 Bits
```

---

### Trick 3

Two's Complement

```
Invert

+

1
```

---

### Trick 4

Unsigned Range

```
0

to

2ⁿ−1
```

---

### Trick 5

Two's Complement Range

```
−2ⁿ⁻¹

to

2ⁿ⁻¹−1
```

---

# Common Mistakes

❌ Confusing BCD with Binary.

❌ Forgetting the extra +1 in Two's Complement.

❌ Incorrect overflow detection.

❌ Using binary grouping incorrectly.

❌ Forgetting signed number ranges.

---

# Interview Questions

### Why do computers use binary?

### Why is Two's Complement preferred?

### Difference between ASCII and Unicode?

### Difference between BCD and Binary?

### Why is Gray Code used?

### What causes overflow?

---

# Formula Sheet

Positional Value

```
Σ(Digit × Base^Position)
```

Unsigned Range

```
0 → 2ⁿ−1
```

Two's Complement Range

```
−2ⁿ⁻¹ → 2ⁿ⁻¹−1
```

Binary → Octal

```
3 Bits
```

Binary → Hex

```
4 Bits
```

Two's Complement

```
Invert

+

1
```

BCD

```
1 Decimal Digit

=

4 Bits
```

ASCII

```
7 Bits
```

---

# One Minute Revision

- Computers use binary.
- Four common number systems.
- Two's Complement is the standard signed representation.
- BCD stores decimal digits separately.
- Gray Code changes one bit at a time.
- Overflow occurs when the result exceeds the representable range.

---

# Five Minute Revision

✅ Number Systems

✅ Base Conversion

✅ Binary Arithmetic

✅ Signed vs Unsigned

✅ One's Complement

✅ Two's Complement

✅ Overflow

✅ BCD

✅ Gray Code

✅ ASCII

✅ Unicode

---

# GATE Tips

- Memorize the **ranges** for unsigned and Two's Complement numbers.
- Practice **base conversions** until they become mechanical.
- Don't confuse **BCD** with ordinary binary representation.
- Gray Code and overflow questions are common and usually straightforward if you know the rules.
- This chapter directly supports topics in **Computer Organization**, especially arithmetic circuits and floating-point representation.

---

# What's Next?

➡ **08-Fixed-Point-Arithmetic.md**

In the next chapter, you'll learn how computers represent **fractional numbers using fixed-point representation**, perform arithmetic on them, analyze precision, detect overflow, and understand their hardware implementation.