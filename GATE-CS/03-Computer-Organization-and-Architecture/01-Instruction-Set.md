# Instruction Set

> Difficulty: ⭐⭐⭐⭐☆
> GATE Weightage: ⭐⭐⭐⭐⭐
> Interview Importance: ⭐⭐⭐⭐⭐
> Prerequisites:
> - Digital Logic
> - Number Representation
>
> Time Required: 5–6 Hours

---

# Why Should You Study Instruction Set?

A CPU performs only one task:

> **Execute Instructions**

Whether you write

```java
a = b + c;
```

or

```cpp
cout << "Hello";
```

or

```python
x = y * z
```

everything is eventually converted into **machine instructions**.

Understanding the instruction set helps you understand **how software communicates with hardware**.

Without an instruction set,

- CPU cannot execute programs.
- Operating System cannot run.
- Compilers cannot generate machine code.

This chapter is the foundation of COA.

---

# Real World Applications

Instruction Sets are used in

- Intel x86 Processors
- AMD Ryzen CPUs
- ARM Processors
- Apple Silicon
- Mobile Phones
- Embedded Systems
- GPUs
- Operating Systems
- Compilers
- Assemblers

Every processor follows an Instruction Set Architecture (ISA).

---

# Why GATE Asks This Topic

Questions are commonly asked on

- Instruction formats
- Instruction execution cycle
- Instruction types
- RISC vs CISC
- Address fields
- Number of address operands
- Instruction length
- Opcode calculation

This chapter also forms the base for

- Addressing Modes
- Control Unit
- Pipeline
- Interrupts

---

# Learning Outcomes

After completing this chapter you should be able to

- Understand machine instructions
- Decode instruction formats
- Understand instruction execution
- Calculate opcode bits
- Differentiate RISC and CISC
- Solve GATE numerical questions

---

# Big Picture

Every program follows this flow

```
High Level Language

↓

Compiler

↓

Assembly Language

↓

Machine Language

↓

CPU

↓

Execution
```

The CPU understands only **Machine Language**.

---

# What is an Instruction?

An instruction is a binary command that tells the processor **what operation to perform**.

Example

```
ADD R1,R2
```

Meaning

```
R1 = R1 + R2
```

Machine Code Example

```
1001011000010110
```

The processor understands only this binary form.

---

# Components of an Instruction

Every instruction generally contains

```
Opcode

+

Operand(s)
```

Example

```
ADD R1,R2
```

Opcode

```
ADD
```

Operands

```
R1

R2
```

---

# Opcode

Opcode specifies

> **What operation should be performed**

Examples

```
ADD

SUB

MUL

DIV

LOAD

STORE

AND

OR

XOR

JUMP
```

---

# Operand

Operand specifies

- Register
- Memory Location
- Immediate Data

Example

```
ADD R1,R2
```

Operands

```
R1

R2
```

---

# Types of Operands

## Register Operand

```
ADD R1,R2
```

Fastest.

---

## Memory Operand

```
LOAD R1,[1000]
```

Requires memory access.

Slower than registers.

---

## Immediate Operand

```
ADD R1,#10
```

Constant value stored inside instruction.

Fast because no extra memory access.

---

# Instruction Cycle

Every instruction executes in several stages.

```
Fetch

↓

Decode

↓

Operand Fetch

↓

Execute

↓

Memory Access (if required)

↓

Write Back
```

This is called the

```
Instruction Cycle
```

---

# Step 1 — Fetch

CPU fetches instruction from memory.

Registers used

```
PC

MAR

MDR

IR
```

Sequence

```
PC

↓

MAR

↓

Memory Read

↓

MDR

↓

IR

↓

PC = PC + Instruction Length
```

---

# Step 2 — Decode

Control Unit examines

```
Opcode
```

and decides

- Which ALU operation
- Which registers
- Which control signals

---

# Step 3 — Operand Fetch

Operands are fetched

from

- Register
- Memory
- Immediate field

depending upon instruction.

---

# Step 4 — Execute

ALU performs operation.

Example

```
ADD

↓

ALU Addition
```

---

# Step 5 — Memory Access

Needed only for

```
LOAD

STORE
```

Arithmetic instructions usually skip this stage.

---

# Step 6 — Write Back

Result stored into

- Register
- Memory

Instruction completes.

---

# Instruction Format

General Format

```
+--------+----------+----------+
| Opcode | Operand1 | Operand2 |
+--------+----------+----------+
```

Instruction format depends on

- ISA
- Address Size
- Number of Registers

---

# Instruction Length

Instruction may be

- Fixed Length
- Variable Length

Example

```
32-bit Instruction

Opcode

Register

Register

Immediate
```

---

# Fixed-Length Instructions

Example

ARM

Every instruction

```
32 Bits
```

Advantages

- Easy decoding
- Fast pipeline
- Simple hardware

Disadvantages

- May waste bits

---

# Variable-Length Instructions

Example

x86

Instruction length varies.

Advantages

- Better code density

Disadvantages

- Complex decoding

---

# Number of Address Fields

Instruction formats can have

- Three Address
- Two Address
- One Address
- Zero Address

---

# Three Address Instructions

Format

```
ADD R1,R2,R3
```

Meaning

```
R1 = R2 + R3
```

Advantages

- Fewer instructions
- Faster execution

Disadvantages

- Longer instruction length

---

# Two Address Instructions

```
ADD R1,R2
```

Meaning

```
R1 = R1 + R2
```

Most common.

---

# One Address Instructions

Uses

```
Accumulator (AC)
```

Example

```
ADD X
```

Meaning

```
AC = AC + X
```

---

# Zero Address Instructions

Used in

```
Stack Architecture
```

Example

```
PUSH A

PUSH B

ADD
```

Processor pops two operands,

adds them,

pushes result.

---

# Types of Instructions

## Data Transfer

Examples

```
LOAD

STORE

MOVE
```

---

## Arithmetic

```
ADD

SUB

INC

DEC

MUL

DIV
```

---

## Logical

```
AND

OR

NOT

XOR
```

---

## Shift

```
LSL

LSR

ASL

ASR
```

---

## Rotate

```
ROL

ROR
```

---

## Compare

```
CMP
```

Sets status flags.

---

## Branch

```
JMP

BEQ

BNE

CALL

RET
```

Changes program flow.

---

## Stack Instructions

```
PUSH

POP
```

---

## I/O Instructions

```
IN

OUT
```

---

# Instruction Set Architecture (ISA)

ISA is the interface between

```
Software

↓

Hardware
```

ISA defines

- Instructions
- Registers
- Addressing Modes
- Data Types
- Memory Model
- Interrupts

Programs compiled for one ISA cannot directly run on another ISA.

Example

An x86 program cannot run natively on an ARM processor without translation or emulation.

---

# RISC

Reduced Instruction Set Computer

Characteristics

- Simple instructions
- Fixed length
- Load/Store architecture
- Many registers
- Few addressing modes
- Easy pipelining

Examples

- ARM
- RISC-V
- MIPS

---

# CISC

Complex Instruction Set Computer

Characteristics

- Complex instructions
- Variable length
- Memory-to-memory operations
- Many addressing modes
- High code density

Example

- Intel x86
- AMD x86-64

---

# RISC vs CISC

| Feature | RISC | CISC |
|---------|------|------|
|Instruction Length|Fixed|Variable|
|Execution|Usually 1 Cycle|Multiple Cycles|
|Registers|Many|Fewer|
|Pipeline|Easy|Complex|
|Hardware|Simple|Complex|
|Code Size|Larger|Smaller|

⭐ One of the favorite GATE comparison tables.

---

# Internal CPU Execution

Example

```
ADD R1,R2
```

Execution

```
PC

↓

Fetch Instruction

↓

IR

↓

Decode

↓

Read R1

↓

Read R2

↓

ALU Addition

↓

Store Result

↓

Update Flags

↓

Next Instruction
```

---

# Status Flags

ALU updates

```
Carry Flag

Zero Flag

Sign Flag

Overflow Flag
```

These flags are later used by branch instructions.

Example

```
BEQ

Branch if Zero Flag = 1
```

---

# Hardware View

Important Registers

```
PC

Program Counter
```

```
IR

Instruction Register
```

```
MAR

Memory Address Register
```

```
MDR

Memory Data Register
```

```
AC

Accumulator
```

```
General Purpose Registers
```

---

# GATE PYQ Patterns

Frequently Asked

✔ Instruction Cycle

✔ RISC vs CISC

✔ Number of Address Fields

✔ Fixed vs Variable Length Instructions

✔ ISA Concepts

✔ Opcode Calculation

✔ Register Transfer

---

# Shortcut Tricks

### Trick 1

Opcode tells **what** to do.

Operand tells **where** to do it.

---

### Trick 2

More address fields

↓

Longer instruction

↓

Fewer instructions in the program

---

### Trick 3

RISC

```
Simple Hardware

Simple Instructions

Fast Pipeline
```

---

### Trick 4

CISC

```
Complex Hardware

Complex Instructions

Better Code Density
```

---

### Trick 5

Instruction Cycle

```
Fetch

↓

Decode

↓

Execute

↓

Write Back
```

Memorize this sequence.

---

# Common Mistakes

❌ Confusing ISA with Microarchitecture.

❌ Thinking opcode stores operands.

❌ Mixing instruction format with instruction cycle.

❌ Assuming every instruction accesses memory.

❌ Forgetting that arithmetic instructions often execute entirely within the CPU.

---

# Interview Questions

### What is an Instruction?

### What is an Opcode?

### Difference between ISA and Microarchitecture?

### Why are registers faster than memory?

### Difference between RISC and CISC?

### Why are fixed-length instructions easier to pipeline?

### Explain the Instruction Cycle.

---

# Formula Sheet

### Number of Opcodes

If opcode has **n bits**:

```
Maximum Opcodes = 2ⁿ
```

### Instruction Length

```
Instruction Length

=

Opcode Bits

+

Address Bits

+

Other Control Bits
```

---

# One Minute Revision

- Instruction = Opcode + Operand(s).
- CPU executes instructions using the Fetch–Decode–Execute cycle.
- ISA defines the programmer-visible architecture.
- RISC uses simple, fixed-length instructions.
- CISC uses complex, variable-length instructions.
- Registers are faster than memory.
- Status flags are updated after ALU operations.

---

# Five Minute Revision

✅ Instruction Components

✅ Opcode

✅ Operand Types

✅ Instruction Cycle

✅ Instruction Formats

✅ Address Fields

✅ Instruction Types

✅ ISA

✅ RISC vs CISC

✅ CPU Registers

---

# GATE Tips

- **Memorize the complete instruction cycle** and the role of **PC, IR, MAR, and MDR**.
- Practice questions on **instruction length** and **maximum opcode calculation**.
- Understand the trade-offs between **RISC and CISC**—comparison questions are common.
- Don't just memorize instruction formats; understand **how an instruction moves through the CPU**.

---

# Summary

By completing this chapter, you should be able to:

- ✔ Understand how the CPU interprets and executes instructions.
- ✔ Explain every stage of the instruction cycle.
- ✔ Differentiate various instruction formats and addressing styles.
- ✔ Compare RISC and CISC architectures.
- ✔ Solve GATE conceptual and numerical questions related to instruction sets.

---

# Next Topic

➡ **02-Addressing-Modes.md**

In the next chapter, you'll learn **how the CPU locates operands** using different addressing modes and how to calculate the **Effective Address (EA)**—one of the most frequently tested numerical topics in GATE.