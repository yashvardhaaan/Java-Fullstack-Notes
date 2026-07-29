# Addressing Modes

> Difficulty: ⭐⭐⭐⭐☆
> GATE Weightage: ⭐⭐⭐⭐⭐
> Interview Importance: ⭐⭐⭐⭐⭐
> Prerequisites:
> - Instruction Set
> - Basic CPU Organization
>
> Time Required: 5–6 Hours

---

# Why Should You Study Addressing Modes?

Every instruction operates on **data (operands)**.

The CPU knows **what** operation to perform from the **Opcode**, but it also needs to know **where the data is located**.

The answer to the question

> "Where is my operand?"

is provided by the **Addressing Mode**.

Without addressing modes, every instruction would have to access memory in the same way, making processors slow, inflexible, and inefficient.

Addressing modes improve

- Program efficiency
- Memory utilization
- Execution speed
- Code size
- Flexibility

---

# Real World Example

Suppose you write

```c
int x = 10;
int y = x + 5;
```

Compiler may generate

```
MOV R1,#10

ADD R1,#5
```

Here

```
#10
```

uses **Immediate Addressing**.

Now consider

```
ADD R1,[1000]
```

CPU has to read memory location 1000.

This uses **Direct Addressing**.

Now suppose

```
ADD R1,[R2]
```

CPU first looks inside R2.

Suppose

```
R2 = 5000
```

Then CPU reads memory location

```
5000
```

This is **Register Indirect Addressing**.

Same ADD instruction.

Different Addressing Mode.

Different hardware behavior.

---

# Learning Outcomes

After this chapter you should be able to

✓ Explain why Addressing Modes exist.

✓ Calculate Effective Address.

✓ Solve every GATE numerical.

✓ Differentiate all addressing modes.

✓ Predict CPU execution.

✓ Answer interview questions confidently.

---

# Big Picture

Every instruction contains

```
Opcode

+

Operand Information
```

The opcode tells

```
WHAT
```

The addressing mode tells

```
WHERE
```

```
Instruction

↓

Opcode

↓

ADD

↓

Addressing Mode

↓

Immediate

↓

Operand = 10
```

or

```
Instruction

↓

Opcode

↓

ADD

↓

Addressing Mode

↓

Memory

↓

Operand = M[1000]
```

---

# What is an Operand?

Operand is the data on which the CPU performs an operation.

Example

```
ADD R1,R2
```

Operands are

```
R1

R2
```

Example

```
ADD R1,#20
```

Operand

```
20
```

Example

```
LOAD R1,[300]
```

Operand

```
Memory[300]
```

---

# What is an Address?

An address specifies **where data is stored**.

Example

```
Memory

Address

1000 → 25

1001 → 30

1002 → 45
```

Instruction

```
LOAD R1,[1002]
```

means

```
Load value stored at memory location 1002.
```

Result

```
R1 = 45
```

Notice

The CPU needs the **address**, not just the value.

---

# Effective Address (EA)

This is one of the most important concepts in GATE.

## Definition

The **Effective Address (EA)** is the **actual memory address** from which the operand will be fetched.

Think of it like this.

Instruction may contain

```
200
```

But the CPU might finally access

```
250
```

because of indexing or base registers.

The final address

```
250
```

is called the

```
Effective Address.
```

---

# Why Effective Address Exists

Suppose instruction contains

```
LOAD R1,100
```

Easy.

Address = 100.

Now suppose

```
LOAD R1,100(R2)
```

and

```
R2 = 500
```

Actual address becomes

```
600
```

Instruction stored

```
100
```

Actual address

```
600
```

Therefore

```
EA = 600
```

This calculation happens **inside the CPU**.

---

# CPU Hardware Required

Address calculation uses

```
Program Counter (PC)

Instruction Register (IR)

General Purpose Registers

ALU

MAR

MDR
```

The ALU is not only for arithmetic.

It is also used for

```
Address Calculation
```

This is frequently overlooked by beginners.

---

# General Instruction Format

```
+-----------+--------------+----------------+
|  Opcode   | Address Mode | Operand Field  |
+-----------+--------------+----------------+
```

Example

```
ADD R1,#20
```

```
Opcode

↓

ADD

Mode

↓

Immediate

Operand

↓

20
```

---

# Classification of Addressing Modes

GATE syllabus mainly includes

1. Immediate
2. Register
3. Direct
4. Indirect
5. Register Indirect
6. Indexed
7. Base Register
8. Relative
9. Auto Increment
10. Auto Decrement
11. Stack
12. Implied

Memorize this order.

---

# Immediate Addressing

## Idea

Operand is present inside the instruction itself.

Instruction

```
MOV R1,#25
```

CPU immediately gets

```
25
```

No memory lookup.

Hardware

```
Instruction

↓

IR

↓

Immediate Value

↓

ALU
```

---

## Effective Address

No Effective Address.

Because data already exists inside instruction.

---

## Advantages

Fastest addressing mode.

No memory access.

Simple hardware.

---

## Disadvantages

Operand size limited by instruction length.

Cannot modify value without changing instruction.

---

## GATE Trick

Whenever instruction contains

```
#
```

Think

```
Immediate Addressing
```

No EA calculation.

---

# Register Addressing

Operand stored inside register.

Example

```
ADD R1,R2
```

CPU

```
Reads R2

↓

ALU

↓

Stores Result in R1
```

No memory access.

---

## Effective Address

No Effective Address.

Register already contains operand.

---

## Advantages

Extremely fast.

Used in almost every instruction.

---

## Disadvantages

Limited number of registers.

```
(Continue with Direct Addressing, Indirect Addressing, Register Indirect, Indexed, Base Register, Relative, Auto Increment, Auto Decrement, Stack, Implied, comparison tables, solved GATE numericals, interviewer questions, examiner traps, and revision in the same detailed style.)