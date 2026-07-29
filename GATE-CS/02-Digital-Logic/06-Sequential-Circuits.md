# Sequential Circuits

> Difficulty: ⭐⭐⭐⭐⭐
> GATE Weightage: ⭐⭐⭐⭐⭐
> Interview Importance: ⭐⭐⭐⭐⭐
> Prerequisites:
> - Combinational Circuits
> - Boolean Algebra
> - Logic Gates
>
> Time Required: 7–9 Hours

---

# Why Should You Study Sequential Circuits?

Combinational circuits only depend on the **current inputs**.

But most real-world systems need to **remember previous information**.

Examples:

- CPU Registers
- RAM
- Counters
- Digital Watches
- Traffic Lights
- Washing Machines
- Elevators
- ATM Machines

All of these require **memory**, which is provided by **Sequential Circuits**.

---

# Real World Applications

Sequential circuits are used in:

- Computer Processors
- CPU Registers
- Cache Memory
- Finite State Machines
- Traffic Signal Controllers
- Digital Clocks
- Elevators
- Embedded Systems
- Communication Systems
- Robotics

---

# Why GATE Asks This Topic

This is one of the **highest-weightage chapters**.

Questions commonly include:

- Latches
- Flip-Flops
- Race Around Condition
- Characteristic Equation
- Excitation Table
- Registers
- Counters
- State Reduction
- FSM Design

---

# Learning Outcomes

After completing this chapter you should be able to

- Understand memory elements
- Design sequential circuits
- Analyze flip-flops
- Design counters
- Design registers
- Solve state machine problems
- Solve GATE questions confidently

---

# What is a Sequential Circuit?

A Sequential Circuit is a digital circuit whose output depends upon:

- Present Inputs
- Previous State (Memory)

Mathematically,

```
Output = f(Current Inputs, Previous State)
```

---

# Characteristics

- Has Memory
- Feedback Present
- Usually Clock Controlled
- Depends on Previous State
- Uses Flip-Flops

---

# Difference Between Combinational & Sequential Circuits

| Combinational | Sequential |
|---------------|------------|
|No Memory|Has Memory|
|No Feedback|Feedback Exists|
|No Clock|Usually Clocked|
|Current Input Only|Current + Previous State|
|Faster|Slightly Slower|

---

# Memory Element

The basic storage element is

```
Latch

↓

Flip-Flop

↓

Registers

↓

Counters

↓

Memory
```

---

# Clock Signal

A Clock synchronizes operations.

```
HIGH

LOW

HIGH

LOW

HIGH
```

Clock Frequency

```
f = 1 / T
```

Where

```
T = Time Period
```

---

# Level Triggering vs Edge Triggering

## Level Triggered

Output changes while clock is HIGH or LOW.

---

## Edge Triggered

Output changes only at

- Rising Edge ↑
- Falling Edge ↓

Modern processors mainly use edge-triggered flip-flops.

---

# Latch

A latch is a **level-sensitive memory device**.

It stores one bit.

Types

- SR Latch
- D Latch

---

# SR Latch

Inputs

```
S

R
```

Outputs

```
Q

Q'
```

Truth Table

|S|R|Next Q|
|--|--|------|
|0|0|No Change|
|0|1|0|
|1|0|1|
|1|1|Invalid|

---

# Problem with SR Latch

Condition

```
S = 1

R = 1
```

Produces an invalid state.

This limitation leads to Flip-Flops.

---

# D Latch

Only one input

```
D
```

Output simply follows the input while enabled.

Equation

```
Q = D
```

Advantage

Removes invalid condition.

---

# Flip-Flop

A Flip-Flop is an **edge-triggered memory element**.

Stores exactly

```
1 bit
```

Main Types

- SR
- JK
- D
- T

---

# SR Flip-Flop

Inputs

```
S

R

Clock
```

Same operation as SR Latch but synchronized using a clock.

---

# JK Flip-Flop

Improves SR Flip-Flop.

Truth Table

|J|K|Next Q|
|--|--|------|
|0|0|No Change|
|0|1|Reset|
|1|0|Set|
|1|1|Toggle|

No invalid state.

---

# Race Around Condition

Occurs in JK Flip-Flop when

```
J = K = 1
```

and

```
Clock Pulse > Propagation Delay
```

Output toggles continuously.

---

# Eliminating Race Around

Methods

- Master-Slave JK Flip-Flop
- Edge Triggering
- Reduce Clock Width

---

# Master-Slave JK Flip-Flop

Consists of

```
Master

↓

Slave
```

Master works during one clock phase.

Slave updates during the opposite phase.

Prevents Race Around.

---

# D Flip-Flop

Most widely used Flip-Flop.

Equation

```
Q(next) = D
```

Applications

- Registers
- Memory
- Pipelines
- CPUs

---

# T Flip-Flop

Toggle Flip-Flop.

Truth Table

|T|Next State|
|--|----------|
|0|No Change|
|1|Toggle|

Applications

- Counters
- Frequency Division

---

# Characteristic Table

Shows

```
Present State

↓

Input

↓

Next State
```

Important for GATE.

---

# Excitation Table

Reverse of Characteristic Table.

Given

```
Present State

↓

Next State
```

Find

```
Required Inputs
```

Frequently asked in GATE.

---

# Characteristic Equations

SR

```
Q(next)=S+R'Q
```

JK

```
Q(next)=JQ'+K'Q
```

D

```
Q(next)=D
```

T

```
Q(next)=T⊕Q
```

---

# Registers

A Register is a collection of Flip-Flops.

Example

```
8 Flip-Flops

↓

8-bit Register
```

Applications

- CPU Registers
- Memory
- Temporary Storage

---

# Types of Registers

- SISO
- SIPO
- PISO
- PIPO

---

## SISO

Serial In

↓

Serial Out

---

## SIPO

Serial In

↓

Parallel Out

---

## PISO

Parallel In

↓

Serial Out

---

## PIPO

Parallel In

↓

Parallel Out

---

# Shift Registers

Shift data one bit per clock pulse.

Types

- Left Shift
- Right Shift
- Bidirectional
- Universal Shift Register

Applications

- Serial Communication
- Multiplication
- Division
- Data Transfer

---

# Counters

A Counter counts clock pulses.

Applications

- Digital Clock
- Frequency Counter
- Timers
- Event Counter

---

# Types of Counters

- Asynchronous (Ripple)
- Synchronous
- Up Counter
- Down Counter
- Up-Down Counter
- Ring Counter
- Johnson Counter

---

# Ripple Counter

Uses asynchronous flip-flops.

Advantages

- Simple

Disadvantages

- Slow
- Ripple Delay

---

# Synchronous Counter

All flip-flops receive the same clock.

Advantages

- Fast
- No Ripple Delay

Preferred in modern digital systems.

---

# Ring Counter

A shift register with feedback.

Example

```
1000

↓

0100

↓

0010

↓

0001

↓

1000
```

---

# Johnson Counter

Twisted Ring Counter.

Stores

```
2N States

for N Flip-Flops
```

Frequently asked in GATE.

---

# State Table

Represents

- Present State
- Inputs
- Next State
- Output

---

# State Diagram

Graphical representation of a State Table.

Nodes

↓

States

Edges

↓

Transitions

---

# State Reduction

Removes equivalent states.

Benefits

- Less Hardware
- Simpler Design
- Lower Cost

---

# Finite State Machine (FSM)

Two types

## Moore Machine

Output depends only on

```
Present State
```

---

## Mealy Machine

Output depends on

```
Present State

+

Input
```

---

# Moore vs Mealy

| Moore | Mealy |
|--------|--------|
|Output depends on State|Output depends on State & Input|
|Stable Output|Faster Response|
|More States|Fewer States|

---

# GATE PYQ Patterns

Frequently Asked

✔ JK Flip-Flop

✔ Race Around

✔ Characteristic Table

✔ Excitation Table

✔ Registers

✔ Ripple Counter

✔ Synchronous Counter

✔ Ring Counter

✔ Johnson Counter

✔ FSM

✔ Moore vs Mealy

---

# Shortcut Tricks

### Trick 1

```
D Flip-Flop

Most Used
```

---

### Trick 2

```
T Flip-Flop

Toggle
```

---

### Trick 3

```
JK

No Invalid State
```

---

### Trick 4

```
Ring Counter

N States

Johnson Counter

2N States
```

---

### Trick 5

```
Moore

Output = State

Mealy

Output = State + Input
```

---

# Common Mistakes

❌ Confusing Latch with Flip-Flop.

❌ Forgetting Race Around Condition.

❌ Mixing Characteristic and Excitation Tables.

❌ Confusing Ripple and Synchronous Counters.

❌ Forgetting Moore vs Mealy differences.

---

# Interview Questions

### What is a Sequential Circuit?

### Difference between Latch and Flip-Flop?

### Why is D Flip-Flop widely used?

### What is Race Around Condition?

### Difference between Ripple and Synchronous Counter?

### Difference between Moore and Mealy Machine?

### Why are Registers used in CPUs?

---

# Formula Sheet

Clock

```
f = 1 / T
```

Characteristic Equations

```
SR

Q(next)=S+R'Q
```

```
JK

Q(next)=JQ'+K'Q
```

```
D

Q(next)=D
```

```
T

Q(next)=T⊕Q
```

Johnson Counter

```
States = 2N
```

Ring Counter

```
States = N
```

---

# One Minute Revision

- Sequential Circuits have memory.
- Flip-Flops store one bit.
- D Flip-Flop is most common.
- JK removes SR's invalid state.
- Race Around occurs in JK.
- Registers store data.
- Counters count clock pulses.
- Moore depends only on state.
- Mealy depends on state and input.

---

# Five Minute Revision

✅ Latch

✅ Flip-Flops

✅ SR

✅ JK

✅ D

✅ T

✅ Race Around

✅ Registers

✅ Shift Registers

✅ Ripple Counter

✅ Synchronous Counter

✅ Ring Counter

✅ Johnson Counter

✅ FSM

✅ Moore vs Mealy

---

# GATE Tips

- **Memorize all four flip-flop truth tables, characteristic tables, excitation tables, and characteristic equations**.
- Practice **counter sequence** questions (especially Ring and Johnson Counters).
- Be comfortable converting **state diagrams ↔ state tables**.
- Moore vs Mealy and Race Around Condition are recurring conceptual questions.

---

# What's Next?

➡ **07-Number-Representation.md**

In the next chapter, you'll study **number systems, binary arithmetic, complements, Gray code, BCD, ASCII, Unicode, overflow, and code conversions**, which form the foundation of Computer Organization and Digital Logic.