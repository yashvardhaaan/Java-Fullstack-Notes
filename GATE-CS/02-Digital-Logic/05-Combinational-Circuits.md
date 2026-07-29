# Combinational Circuits

> Difficulty: ⭐⭐⭐⭐☆
> GATE Weightage: ⭐⭐⭐⭐⭐
> Interview Importance: ⭐⭐⭐⭐⭐
> Prerequisites:
> - Boolean Algebra
> - Karnaugh Maps
> - Logic Gates
>
> Time Required: 6–8 Hours

---

# Why Should You Study Combinational Circuits?

Almost every digital device you use contains combinational circuits.

Whenever you:

- Add two numbers
- Compare two values
- Select one input from many
- Convert binary to decimal
- Decode memory addresses
- Generate parity bits

A combinational circuit is working internally.

It is one of the most important chapters in Digital Logic because it connects Boolean Algebra to actual hardware.

---

# Real World Applications

Combinational circuits are used in

- CPU Arithmetic Logic Unit (ALU)
- Memory Address Decoding
- Cache Controllers
- Digital Calculators
- Multiprocessors
- Network Switches
- Embedded Systems
- FPGA Design
- ASIC Design
- Communication Systems

---

# Why GATE Asks This Topic

This chapter is asked almost every year.

Questions usually involve

- Truth Tables
- Circuit Design
- Gate Count
- MUX/DEMUX
- Encoder/Decoder
- Adders/Subtractors
- Comparators
- ROM/PAL/PLA
- Parity Circuits

---

# Learning Outcomes

After completing this chapter, you should be able to

- Design combinational circuits
- Convert truth tables into circuits
- Understand arithmetic circuits
- Solve MUX and Decoder questions
- Design circuits using universal gates
- Solve GATE numerical questions confidently

---

# What is a Combinational Circuit?

A combinational circuit is a digital circuit whose output depends **only on the present inputs**.

There is **no memory**.

```
Inputs

↓

Logic Gates

↓

Output
```

Mathematically,

```
Output = f(Current Inputs)
```

---

# Characteristics

- No memory
- No clock
- No feedback
- Output depends only on current input
- Faster than sequential circuits

---

# Difference Between Combinational and Sequential Circuits

| Combinational | Sequential |
|--------------|------------|
|No Memory|Has Memory|
|No Clock|Clock Required|
|Output depends on present input|Output depends on present + past input|
|Simple Design|Complex Design|

---

# Design Procedure

Every combinational circuit is designed using the following steps.

```
Problem

↓

Inputs

↓

Truth Table

↓

Boolean Expression

↓

Simplification

↓

Logic Diagram
```

---

# Arithmetic Circuits

Arithmetic circuits perform mathematical operations.

Topics covered:

- Half Adder
- Full Adder
- Half Subtractor
- Full Subtractor
- Parallel Adder
- Ripple Carry Adder
- Carry Look Ahead Adder

---

# Half Adder

## Purpose

Adds two 1-bit binary numbers.

Inputs

```
A

B
```

Outputs

```
Sum

Carry
```

Truth Table

|A|B|Sum|Carry|
|--|--|---|-----|
|0|0|0|0|
|0|1|1|0|
|1|0|1|0|
|1|1|0|1|

Equations

```
Sum = A ⊕ B

Carry = AB
```

---

# Full Adder

Adds three bits.

Inputs

```
A

B

Cin
```

Outputs

```
Sum

Carry
```

Equations

```
Sum = A ⊕ B ⊕ Cin

Carry = AB + BCin + ACin
```

GATE Favorite

A Full Adder can be built using

```
2 Half Adders

+

1 OR Gate
```

---

# Half Subtractor

Performs subtraction of two bits.

Outputs

```
Difference

Borrow
```

Formula

```
Difference = A ⊕ B

Borrow = A'B
```

---

# Full Subtractor

Inputs

```
A

B

Borrow In
```

Outputs

```
Difference

Borrow Out
```

Difference

```
A ⊕ B ⊕ Bin
```

Borrow

```
A'B + A'Bin + BBin
```

---

# Ripple Carry Adder (RCA)

Constructed using multiple Full Adders.

```
FA

↓

FA

↓

FA

↓

FA
```

Advantages

- Simple
- Cheap

Disadvantages

- Slow
- Carry propagates through every stage

Propagation Delay

```
Delay ∝ Number of Bits
```

---

# Carry Look Ahead Adder (CLA)

Designed to eliminate ripple carry delay.

Concept

Generate

```
Gi = AiBi
```

Propagate

```
Pi = Ai ⊕ Bi
```

Carry

```
Ci+1 = Gi + PiCi
```

Advantages

- Much Faster

Disadvantages

- More Hardware

GATE loves comparing RCA vs CLA.

---

# Comparator

Compares two binary numbers.

Outputs

```
A>B

A=B

A<B
```

Applications

- CPU
- Sorting Hardware
- ALU
- Memory Systems

---

# Decoder

Converts

```
n Inputs

↓

2ⁿ Outputs
```

Example

```
2-to-4 Decoder
```

Applications

- Memory Selection
- Address Decoding
- Instruction Decoding

Formula

```
Outputs = 2ⁿ
```

---

# Encoder

Reverse of Decoder.

```
2ⁿ Inputs

↓

n Outputs
```

Example

```
8-to-3 Encoder
```

---

# Priority Encoder

If multiple inputs are HIGH,

Highest priority input is encoded.

Applications

- Interrupt Controllers
- CPU Priority Logic

---

# Multiplexer (MUX)

A Multiplexer selects one input from many.

```
Many Inputs

↓

One Output
```

Formula

```
Select Lines = log₂(Number of Inputs)
```

Examples

|MUX|Select Lines|
|---|------------|
|2:1|1|
|4:1|2|
|8:1|3|
|16:1|4|

Applications

- Data Selection
- ALU
- Bus Systems

---

# Demultiplexer (DEMUX)

Reverse of Multiplexer.

```
One Input

↓

Many Outputs
```

Applications

- Data Distribution
- Communication Systems

---

# Code Converter

Converts one code into another.

Examples

- Binary → Gray
- Gray → Binary
- BCD → Excess-3
- Binary → BCD

---

# Parity Generator

Generates

- Even Parity
- Odd Parity

Purpose

Error Detection

Uses XOR Gates.

---

# Parity Checker

Checks whether transmission contains errors.

Cannot correct errors.

Only detects them.

---

# Programmable Logic Devices

---

## ROM

- Fixed AND
- Programmable OR

Applications

- Lookup Tables
- Firmware
- Microprogramming

---

## PLA

Both arrays programmable.

Advantages

- Flexible
- Efficient

---

## PAL

Programmable AND

Fixed OR

Cheaper than PLA.

---

# Universal Gate Implementation

Every combinational circuit can be built using only

- NAND Gates
- NOR Gates

These are called Universal Gates.

---

# Design Using MUX

GATE frequently asks

Design Boolean Function using

- 4×1 MUX
- 8×1 MUX
- 16×1 MUX

Always remember

```
Number of Select Lines

=

log₂(Number of Inputs)
```

---

# Design Using Decoder

Boolean functions can also be implemented using

- Decoder
- OR Gate

Very common GATE question.

---

# GATE PYQ Patterns

Frequently Asked

✔ Half Adder

✔ Full Adder

✔ Ripple Carry Delay

✔ Carry Look Ahead

✔ Decoder Outputs

✔ Multiplexer Design

✔ Priority Encoder

✔ ROM vs PLA vs PAL

✔ Parity Generator

✔ Comparator

---

# Shortcut Tricks

### Trick 1

Decoder

```
Outputs = 2ⁿ
```

---

### Trick 2

MUX

```
Select Lines = log₂(Input Lines)
```

---

### Trick 3

Full Adder

```
2 Half Adders

+

1 OR
```

---

### Trick 4

CLA

Fast

RCA

Slow

---

### Trick 5

Encoder is the reverse of Decoder.

---

# Common Mistakes

❌ Confusing Encoder with Decoder.

❌ Forgetting MUX select line formula.

❌ Confusing Half Adder with Full Adder.

❌ Forgetting Carry equations.

❌ Assuming Parity corrects errors.

(It only detects errors.)

---

# Interview Questions

### What is a Combinational Circuit?

### Difference between Combinational and Sequential Circuits?

### Why is Carry Look Ahead faster?

### Difference between ROM, PLA and PAL?

### Can every circuit be implemented using NAND only?

### Difference between Encoder and Priority Encoder?

### Why is a MUX called a Data Selector?

---

# Formula Sheet

Half Adder

```
S = A ⊕ B

C = AB
```

Full Adder

```
S = A ⊕ B ⊕ Cin

C = AB + BCin + ACin
```

Half Subtractor

```
D = A ⊕ B

Borrow = A'B
```

Decoder

```
Outputs = 2ⁿ
```

MUX

```
Select Lines = log₂(N)
```

CLA

```
Gi = AB

Pi = A ⊕ B

Ci+1 = Gi + PiCi
```

---

# One Minute Revision

- No memory.
- No clock.
- Output depends only on inputs.
- MUX selects.
- DEMUX distributes.
- Decoder expands.
- Encoder compresses.
- CLA is faster than RCA.
- XOR is used for parity.

---

# Five Minute Revision

✅ Half Adder

✅ Full Adder

✅ Subtractors

✅ Ripple Carry Adder

✅ Carry Look Ahead Adder

✅ Comparator

✅ Decoder

✅ Encoder

✅ Priority Encoder

✅ Multiplexer

✅ Demultiplexer

✅ ROM

✅ PLA

✅ PAL

✅ Parity Generator

---

# GATE Tips

- Memorize **Half Adder** and **Full Adder** truth tables.
- Practice designing Boolean functions using **MUX** and **Decoder**—these are common GATE problems.
- Be comfortable comparing **RCA vs CLA**, **ROM vs PLA vs PAL**, and **Encoder vs Priority Encoder**.
- Focus on understanding why each circuit exists, not just its equations.

---

# What's Next?

➡ **06-Sequential-Circuits.md**

In the next chapter, you'll study circuits that **have memory**, including **Latches, Flip-Flops, Registers, Counters, and Finite State Machines (FSMs)**—another high-weightage area in GATE Digital Logic.