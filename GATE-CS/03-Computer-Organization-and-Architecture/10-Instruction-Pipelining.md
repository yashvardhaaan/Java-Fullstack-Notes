# Instruction Pipelining

## Definition

Instruction Pipelining is a CPU execution technique in which multiple instructions are executed simultaneously by dividing instruction execution into multiple stages.

Instead of completing one instruction before starting the next, the processor overlaps different stages of multiple instructions.

In simple words,

> Pipelining increases CPU performance by allowing different instructions to execute at different stages at the same time.

It improves **throughput** (instructions completed per unit time) but does **not reduce the execution time (latency) of an individual instruction**.

---

# Real-World Example

Imagine a car manufacturing factory.

Without a pipeline,

```
Car 1

Build Chassis
↓

Paint
↓

Install Engine
↓

Quality Check
↓

Finished

Then only Car 2 starts.
```

This wastes a lot of time because only one department works at a time.

With pipelining,

```
Time →

Car1 : Chassis → Paint → Engine → Test

Car2 :          Chassis → Paint → Engine → Test

Car3 :                    Chassis → Paint → Engine → Test
```

Every department works simultaneously.

Cars finish much faster.

Similarly,

a processor divides instruction execution into stages so different hardware units work simultaneously.

---

# Why Was Pipelining Needed?

Early processors executed instructions sequentially.

Example

```
Instruction 1

↓

Complete

↓

Instruction 2

↓

Complete

↓

Instruction 3
```

During execution,

many CPU components remained idle.

Example

While ALU performs calculations,

Memory is idle.

While Memory is accessed,

ALU is idle.

This wastes hardware resources.

Pipelining allows every hardware unit to remain busy.

---

# Sequential Execution vs Pipelining

## Without Pipeline

```
Instruction 1

IF

↓

ID

↓

EX

↓

MEM

↓

WB

Instruction 2 starts only after WB.
```

---

## With Pipeline

```
Clock

1

I1 IF

--------------------

2

I1 ID

I2 IF

--------------------

3

I1 EX

I2 ID

I3 IF

--------------------

4

I1 MEM

I2 EX

I3 ID

I4 IF

--------------------

5

I1 WB

I2 MEM

I3 EX

I4 ID

I5 IF
```

Several instructions execute simultaneously.

---

# What is a Pipeline?

A pipeline is a sequence of processing stages.

Each stage performs one part of instruction execution.

```
Instruction

↓

Fetch

↓

Decode

↓

Execute

↓

Memory

↓

Write Back
```

Each stage is handled by dedicated hardware.

---

# Five Stage Pipeline

Most GATE questions assume the classic 5-stage RISC pipeline.

```
Instruction Fetch (IF)

↓

Instruction Decode (ID)

↓

Execute (EX)

↓

Memory Access (MEM)

↓

Write Back (WB)
```

---

# Stage 1 : Instruction Fetch (IF)

Purpose

Fetch instruction from instruction memory.

Operations

- Read Program Counter
- Access instruction memory
- Fetch instruction
- Increment PC

Hardware Used

- Program Counter
- Instruction Memory
- Adder

---

# Stage 2 : Instruction Decode (ID)

Purpose

Understand the instruction.

Operations

- Decode opcode
- Read source registers
- Generate control signals

Hardware Used

- Register File
- Decoder
- Control Unit

---

# Stage 3 : Execute (EX)

Purpose

Perform computation.

Operations

- Arithmetic
- Logical operations
- Address calculation
- Branch comparison

Hardware Used

- ALU
- Shifter
- Comparator

---

# Stage 4 : Memory Access (MEM)

Purpose

Access data memory.

Needed only for

- Load
- Store

Hardware Used

- Data Cache
- Memory Interface

---

# Stage 5 : Write Back (WB)

Purpose

Write result back into destination register.

Hardware

- Register File

---

# Pipeline Registers

Between every stage,

special registers store intermediate results.

```
IF

↓

IF/ID Register

↓

ID

↓

ID/EX Register

↓

EX

↓

EX/MEM Register

↓

MEM

↓

MEM/WB Register

↓

WB
```

Pipeline registers isolate stages.

Without them,

pipeline execution is impossible.

---

# Pipeline Timing Diagram

Example

Five Instructions

```
Cycle →

1

I1 IF

----------------

2

I1 ID

I2 IF

----------------

3

I1 EX

I2 ID

I3 IF

----------------

4

I1 MEM

I2 EX

I3 ID

I4 IF

----------------

5

I1 WB

I2 MEM

I3 EX

I4 ID

I5 IF
```

Observe

After pipeline fills,

one instruction completes every clock cycle.

---

# Pipeline Performance

Suppose

Instruction Time

```
IF

2 ns

ID

2 ns

EX

2 ns

MEM

2 ns

WB

2 ns
```

Without pipeline

One instruction

```
10 ns
```

Five instructions

```
50 ns
```

---

With pipeline

Pipeline depth

```
5
```

Time

```
(k + n − 1) × Clock Cycle
```

where

k = stages

n = instructions

```
(5 + 5 − 1)

×

2

=

18 ns
```

Huge improvement.

---

# Pipeline Speedup

Formula

```
Speedup

=

Time Without Pipeline

-----------------------

Time With Pipeline
```

Ideal Speedup

```
Pipeline Depth
```

Example

5-stage pipeline

Maximum Speedup

```
5
```

---

# Throughput

Definition

Number of instructions completed per unit time.

Formula

```
Throughput

=

Completed Instructions

-----------------------

Execution Time
```

Pipeline greatly increases throughput.

---

# Latency

Definition

Time taken by one instruction from fetch to completion.

Important

Pipeline

✔ Improves Throughput

✘ Does NOT reduce Latency

This is one of the most common GATE concepts.

---

# CPI (Cycles Per Instruction)

Formula

```
CPI

=

Clock Cycles

-------------

Instructions
```

Ideal Pipeline

```
CPI = 1
```

Real Processors

```
CPI > 1
```

because of hazards.

---

# Pipeline Efficiency

Formula

```
Efficiency

=

Actual Speedup

----------------

Ideal Speedup

×100%
```

---

# Advantages

- High throughput
- Better CPU utilization
- Faster execution of programs
- Efficient hardware usage
- Higher instruction completion rate

---

# Disadvantages

- Pipeline hazards
- Complex control hardware
- Branch penalties
- Pipeline stalls
- Increased hardware cost

---

# Comparison

| Feature | Sequential | Pipeline |
|----------|------------|----------|
|Instructions at once|1|Multiple|
|Throughput|Low|High|
|CPU Utilization|Poor|High|
|Hardware Complexity|Simple|Complex|
|Performance|Lower|Higher|

---

# Memory Hack 🧠

Remember the stages as

```
F D E M W

↓

Fetch

Decode

Execute

Memory

Write Back
```

Mnemonic

> **"Fresh Developers Execute Many Works."**

---

# GATE Tricks

### Trick 1

Pipeline improves

✅ Throughput

NOT

❌ Latency

---

### Trick 2

Ideal Speedup

```
=

Pipeline Stages
```

---

### Trick 3

Ideal Pipeline

```
CPI = 1
```

---

### Trick 4

Pipeline registers exist

Between every stage.

---

# Common Examiner Traps

❌ Thinking pipeline reduces execution time of one instruction.

It reduces total execution time for many instructions, not the latency of a single instruction.

---

❌ Assuming every instruction uses MEM stage.

Only Load and Store instructions access data memory.

---

❌ Forgetting pipeline fill time.

The first instruction still takes all pipeline stages before completion.

---

# Practice Questions

### Easy

1. What is instruction pipelining?
2. Why is pipelining used?
3. List the five pipeline stages.
4. What is throughput?
5. What is latency?

### Medium

6. Explain IF stage.
7. Explain ID stage.
8. Explain EX stage.
9. Explain MEM stage.
10. Explain WB stage.

### GATE Level

11. Derive pipeline speedup.
12. Find execution time for 20 instructions in a 5-stage pipeline.
13. Explain why CPI is ideally 1.
14. Explain pipeline registers.
15. Compare sequential execution and pipelining.

---

# Interview Questions

## Q1. Does pipelining increase clock frequency?

**Answer**

No. Pipelining increases instruction throughput by overlapping execution stages. It does not inherently increase the processor's clock frequency.

---

## Q2. Does pipelining reduce latency?

**Answer**

No. The latency of a single instruction remains approximately the same. Pipelining mainly improves throughput.

---

## Q3. Why are pipeline registers required?

**Answer**

Pipeline registers store intermediate results between stages, allowing multiple instructions to progress independently through the pipeline without interfering with each other.

---

# PYQ Pattern Analysis

| Topic | Frequency | Question Type |
|--------|-----------|---------------|
|Pipeline Stages|★★★★★|Concept|
|Timing Diagram|★★★★★|Numerical|
|Speedup|★★★★★|Numerical|
|CPI|★★★★☆|Formula|
|Throughput|★★★★☆|Concept + Numerical|
|Latency|★★★★☆|Concept|

---

# Quick Revision

### Formulas

```
Execution Time

=

(k+n−1)

×

Clock Cycle
```

```
Speedup

=

Without Pipeline

-----------------

With Pipeline
```

```
Ideal Speedup

=

Pipeline Depth
```

```
Ideal CPI = 1
```

---

### Remember

- IF → Fetch
- ID → Decode
- EX → Execute
- MEM → Memory Access
- WB → Write Back

---

# Next Topic

➡ **Pipeline Hazards**