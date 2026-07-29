# Pipeline Hazards

## Definition

A **Pipeline Hazard** is a condition that prevents the next instruction in the pipeline from executing during its designated clock cycle.

In simple words,

> A pipeline hazard is any situation that forces the CPU to **delay, stall, or change the normal flow of instructions**.

Pipeline hazards reduce the performance gained from pipelining because the processor cannot complete one instruction every clock cycle.

---

# Real-World Example

Imagine a five-stage car wash.

```
Wash

↓

Soap

↓

Rinse

↓

Dry

↓

Inspection
```

Normally, every stage works simultaneously.

Now suppose the drying machine stops working.

Cars begin waiting before entering the drying stage.

Eventually, every stage becomes blocked.

This waiting is similar to a **Pipeline Stall**.

---

# Why Do Pipeline Hazards Occur?

Pipelining assumes that multiple instructions can execute simultaneously.

However, this assumption is not always true.

Problems arise when

- Two instructions require the same hardware.
- One instruction depends on another.
- The CPU does not know which instruction should execute next.

These situations create hazards.

---

# Types of Pipeline Hazards

Pipeline hazards are classified into three major categories.

```
Pipeline Hazards
│
├── Structural Hazard
├── Data Hazard
└── Control Hazard
```

---

# 1. Structural Hazard

## Definition

A **Structural Hazard** occurs when two or more instructions require the same hardware resource at the same time, but only one resource is available.

---

## Real-World Example

Imagine there is only **one printer** in an office.

Two employees send documents to print at exactly the same time.

Only one document can be printed first.

The other employee must wait.

Similarly, if two instructions require the same hardware unit simultaneously, one instruction must stall.

---

## Example

Suppose a processor has only **one memory** for both instructions and data.

```
Instruction 1

↓

MEM Stage

↓

Needs Memory
```

At the same time,

```
Instruction 2

↓

IF Stage

↓

Needs Instruction Memory
```

Both need memory simultaneously.

Only one can proceed.

This causes a Structural Hazard.

---

## Solution

- Separate Instruction and Data Cache (Harvard Architecture)
- Duplicate hardware resources
- Better hardware scheduling

---

# 2. Data Hazard

## Definition

A **Data Hazard** occurs when an instruction depends on the result of a previous instruction that has not yet completed.

---

## Real-World Example

Suppose a chef is baking a cake.

The decorator cannot decorate the cake until it is baked.

If the decorator starts too early, work cannot continue.

Similarly, one instruction may need data that another instruction has not yet produced.

---

# Types of Data Hazards

```
Data Hazard
│
├── RAW
├── WAR
└── WAW
```

---

# A. RAW (Read After Write)

## Definition

Occurs when an instruction tries to **read** a value before the previous instruction has **written** it.

This is the **most common** data hazard.

---

### Example

```assembly
ADD R1, R2, R3
SUB R4, R1, R5
```

The first instruction updates **R1**.

The second instruction immediately tries to read **R1**.

If the ADD instruction has not completed, SUB reads the old value.

This creates a RAW hazard.

---

### Solution

- Data Forwarding
- Pipeline Stall

---

# B. WAR (Write After Read)

## Definition

Occurs when a later instruction writes to a register before an earlier instruction has finished reading it.

---

### Example

```assembly
READ R1
WRITE R1
```

The write happens too early.

The read instruction receives incorrect data.

---

### Note

WAR hazards usually occur in **out-of-order execution**.

They do **not** occur in a simple 5-stage in-order pipeline.

---

# C. WAW (Write After Write)

## Definition

Occurs when two instructions write to the same register.

If the second write finishes first, the final value becomes incorrect.

---

### Example

```assembly
ADD R1, R2, R3
MUL R1, R4, R5
```

Both write into **R1**.

Correct execution order must be preserved.

---

### Note

Like WAR, WAW hazards generally occur in **out-of-order processors**, not in a basic in-order pipeline.

---

# Data Hazard Comparison

| Hazard | Meaning | Occurs In |
|----------|---------|-----------|
| RAW | Read After Write | Basic Pipeline |
| WAR | Write After Read | Out-of-order CPUs |
| WAW | Write After Write | Out-of-order CPUs |

---

# 3. Control Hazard

## Definition

A **Control Hazard** occurs when the processor does not know which instruction should be fetched next because of a branch or jump instruction.

---

## Real-World Example

Suppose you reach a road intersection.

```
Go Left?

or

Go Right?
```

Until you decide,

you cannot continue driving.

Similarly,

the processor must wait until the branch condition is evaluated.

---

## Example

```assembly
BEQ R1, R2, LABEL
```

If the branch is taken,

the next instruction changes.

If it is not taken,

execution continues normally.

The CPU cannot know the correct instruction immediately.

---

# Pipeline Stall

## Definition

A **Pipeline Stall** occurs when one or more pipeline stages are temporarily stopped.

During a stall,

no useful work is performed.

---

## Example

```
Cycle

1

IF

2

ID

IF

3

EX

STALL

IF

4

MEM

ID

IF
```

The empty cycle is called a **Bubble**.

---

# Bubble

A **Bubble** is an empty slot inserted into the pipeline to delay instruction execution.

It behaves like a "No Operation (NOP)" instruction.

---

# Hazard Detection Unit

Modern processors include a **Hazard Detection Unit (HDU)**.

Its job is to

- Detect hazards
- Stall the pipeline when required
- Generate control signals

---

# Data Forwarding (Bypassing)

## Definition

Data Forwarding is a technique that sends the ALU result directly to the next instruction without waiting for Write Back.

---

## Example

Instead of waiting

```
ADD

↓

WB

↓

SUB
```

The ALU output is forwarded immediately.

```
ADD

↓

Forward Result

↓

SUB
```

This eliminates many RAW hazards.

---

# Branch Prediction

Instead of waiting for branch results,

modern CPUs guess the branch outcome.

If the guess is correct,

execution continues normally.

If incorrect,

the wrong instructions are discarded.

---

# Static Branch Prediction

The prediction never changes.

Examples

- Always Taken
- Always Not Taken

Simple but less accurate.

---

# Dynamic Branch Prediction

The processor learns from previous branch behavior.

Uses hardware such as

- Branch History Table (BHT)
- Pattern History Table (PHT)

More accurate than static prediction.

---

# Branch Target Buffer (BTB)

A **BTB** stores the target addresses of previously executed branch instructions.

When the same branch occurs again,

the CPU immediately knows where to jump.

This reduces branch delay.

---

# Speculative Execution

The processor executes instructions **before knowing** whether they are actually required.

If prediction is correct,

time is saved.

If wrong,

the speculative instructions are discarded.

---

# Flush

A **Pipeline Flush** removes incorrectly fetched instructions from the pipeline.

Flushes occur after incorrect branch prediction.

---

# Scoreboarding (Introduction)

Scoreboarding is a hardware technique used to detect hazards and schedule instructions safely.

It tracks

- Resource usage
- Register status
- Instruction dependencies

---

# Tomasulo Algorithm (Introduction)

The Tomasulo Algorithm is an advanced dynamic scheduling technique.

It reduces WAR and WAW hazards using

- Register Renaming
- Reservation Stations

Widely used in modern superscalar processors.

---

# Hazard Removal Techniques

| Hazard | Solution |
|----------|----------|
| Structural | Duplicate Hardware |
| RAW | Forwarding, Stall |
| WAR | Register Renaming |
| WAW | Register Renaming |
| Control | Branch Prediction |

---

# Pipeline Performance with Hazards

Ideal

```
CPI = 1
```

Actual

```
CPI = Ideal CPI + Stall Cycles
```

Hazards increase stall cycles,

thereby increasing CPI and reducing performance.

---

# Advantages of Forwarding

- Reduces stalls
- Improves throughput
- Increases pipeline utilization
- Reduces RAW hazards

---

# Limitations

- Additional hardware
- Increased complexity
- Cannot eliminate every hazard
- Branch hazards still require prediction

---

# Memory Hacks 🧠

### RAW

**Read After Write**

> Read too early.

---

### WAR

**Write After Read**

> Write too early.

---

### WAW

**Write After Write**

> Second write finishes first.

---

Remember

```
RAW

↓

Real Hazard
```

Basic pipelines mostly experience **RAW** hazards.

---

# GATE Tricks

### Trick 1

In a basic 5-stage RISC pipeline,

**RAW** is the primary data hazard.

---

### Trick 2

WAR and WAW mainly occur in **out-of-order execution**, not in simple in-order pipelines.

---

### Trick 3

Forwarding reduces RAW hazards but cannot resolve every dependency.

---

### Trick 4

Branch instructions mainly cause **Control Hazards**.

---

# Common Examiner Traps

❌ Thinking forwarding eliminates all hazards.

It reduces many RAW hazards but not all.

---

❌ Assuming WAR and WAW occur in every pipeline.

They usually appear only in processors with out-of-order execution.

---

❌ Confusing a Bubble with a Flush.

- **Bubble:** Inserts idle cycles due to stalls.
- **Flush:** Removes incorrectly fetched instructions after branch misprediction.

---

# Practice Questions

### Easy

1. What is a pipeline hazard?
2. Name the three types of hazards.
3. What is a structural hazard?
4. What is a data hazard?
5. What is a control hazard?

### Medium

6. Explain RAW hazard with an example.
7. Differentiate RAW, WAR, and WAW.
8. What is data forwarding?
9. What is branch prediction?
10. What is speculative execution?

### GATE Level

11. Calculate CPI when stall cycles are given.
12. Identify hazards in a sequence of instructions.
13. Explain pipeline flush.
14. Compare static and dynamic branch prediction.
15. Explain Tomasulo Algorithm (basic idea).

---

# Interview Questions

## Q1. Which pipeline hazard occurs most frequently in a simple RISC processor?

**Answer:** RAW (Read After Write) hazard.

---

## Q2. How does forwarding improve pipeline performance?

**Answer:** It bypasses the normal write-back stage and directly forwards computed results to dependent instructions, reducing stalls caused by RAW hazards.

---

## Q3. Why are branch instructions problematic in pipelined processors?

**Answer:** The CPU may not know the next instruction to fetch until the branch decision is made, creating control hazards that can lead to stalls or pipeline flushes.

---

# PYQ Pattern Analysis

| Topic | Frequency | Question Type |
|--------|-----------|---------------|
| RAW Hazard | ★★★★★ | Concept + Numerical |
| Forwarding | ★★★★★ | Numerical |
| Pipeline Stall | ★★★★★ | Timing Diagram |
| Control Hazard | ★★★★☆ | Concept |
| Branch Prediction | ★★★★☆ | Concept |
| CPI with Stalls | ★★★★★ | Numerical |

---

# Quick Revision

### Types of Hazards

- Structural → Hardware conflict
- Data → Data dependency
- Control → Branch/jump uncertainty

### Data Hazards

- RAW → Read After Write
- WAR → Write After Read
- WAW → Write After Write

### Important Concepts

- Forwarding reduces RAW hazards.
- Stalls insert bubbles into the pipeline.
- Flushes remove wrongly fetched instructions.
- Branch prediction improves performance.
- Ideal CPI = 1; hazards increase CPI.

```