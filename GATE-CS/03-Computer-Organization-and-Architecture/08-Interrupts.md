# Interrupts

## Definition

An **Interrupt** is a signal sent to the CPU that temporarily stops the execution of the current program so that the processor can execute a higher-priority task called the **Interrupt Service Routine (ISR)**. After servicing the interrupt, the CPU resumes executing the interrupted program from exactly where it stopped.

In simple words,

> **An interrupt is a mechanism that tells the CPU, "Stop what you're doing for a moment and handle this important event first."**

Interrupts allow the processor to respond immediately to external or internal events without continuously checking for them.

---

## Real-World Example

Imagine you are studying for the GATE exam.

Everything is going well until suddenly your phone rings.

You immediately stop studying,

answer the call,

finish the conversation,

and then continue studying from exactly the same page.

```
Studying

↓

Phone Rings

↓

Stop Studying

↓

Answer Call

↓

Call Ends

↓

Continue Studying
```

Notice two important things:

- You did not restart studying from the beginning.
- You resumed exactly where you had stopped.

A CPU behaves in exactly the same way.

Suppose the processor is executing a program.

Suddenly,

- the keyboard receives a key press,
- a network packet arrives,
- a disk finishes reading data,
- or a timer expires.

Instead of waiting until the current program finishes, the processor immediately pauses the current execution, handles the event, and then resumes execution.

This temporary interruption is called an **Interrupt**.

---

## Why Were Interrupts Needed?

Early computers did not use interrupts.

Instead, the CPU continuously checked every input/output device to see whether it required attention.

This method is called **Polling**.

Consider a keyboard.

A person presses a key once every few seconds.

However, the processor executes billions of instructions every second.

Without interrupts, the CPU repeatedly performs

```
Has the keyboard been pressed?

↓

No

↓

Has the keyboard been pressed?

↓

No

↓

Has the keyboard been pressed?

↓

No
```

Most of these checks are unnecessary because nothing has changed.

The processor wastes a huge amount of processing time.

Now consider an interrupt-based system.

```
CPU executes program

↓

Keyboard key pressed

↓

Keyboard sends interrupt signal

↓

CPU immediately responds
```

Instead of continuously asking every device,

the processor waits until a device informs it that attention is required.

This makes the CPU much more efficient.

---

# Polling vs Interrupts

Before understanding interrupts, it is important to understand polling because interrupts were introduced to solve its limitations.

## Polling

### Definition

Polling is a technique in which the CPU repeatedly checks every I/O device to determine whether it requires service.

The CPU itself initiates every check.

```
CPU

↓

Keyboard?

↓

Mouse?

↓

Printer?

↓

Disk?

↓

Repeat
```

Even when no device requires service,

the CPU continues checking.

---

## Interrupts

### Definition

In an interrupt-based system,

the CPU does not repeatedly check devices.

Instead,

devices notify the CPU whenever they require service.

```
Keyboard

↓

Interrupt Signal

↓

CPU

↓

Interrupt Service Routine
```

The CPU remains free to execute useful instructions until an interrupt occurs.

---

## Real-World Comparison

Imagine you order food online.

### Polling

Every two minutes you open the app and check

```
Has the food arrived?
```

Most of the time,

the answer is

```
No
```

You waste time checking repeatedly.

---

### Interrupt

Instead,

the delivery app sends a notification

```
Your order has arrived.
```

Now you only react when something important happens.

This is exactly how interrupts improve CPU efficiency.

---

# Polling vs Interrupts Comparison

| Feature | Polling | Interrupt |
|---------|----------|-----------|
|Who starts communication?|CPU|I/O Device|
|CPU Usage|High|Low|
|Efficiency|Low|High|
|Response Time|Depends on polling interval|Immediate|
|Power Consumption|Higher|Lower|
|Suitable For|Simple systems|Modern computers|

---

# Basic Working of Interrupts

Suppose you press a key on the keyboard.

The following events occur inside the computer.

```
CPU Executing Program

↓

Keyboard Detects Key Press

↓

Keyboard Controller Sends Interrupt Request (IRQ)

↓

CPU Completes Current Instruction

↓

CPU Saves Current Context

↓

CPU Jumps to Interrupt Service Routine (ISR)

↓

ISR Processes Keyboard Input

↓

CPU Restores Previous Context

↓

Program Continues
```

Notice that the CPU **does not restart the program**.

It resumes exactly where it stopped.

This is one of the most important characteristics of interrupts.

---

# Key Terms

Before studying different types of interrupts, you should understand these important terms.

## Interrupt Request (IRQ)

### Definition

An **Interrupt Request (IRQ)** is a signal sent by a hardware device to inform the CPU that it requires immediate attention.

Example

```
Keyboard

↓

IRQ

↓

CPU
```

---

## Interrupt Acknowledge (INTA)

### Definition

After receiving an interrupt request,

the CPU sends an **Interrupt Acknowledge (INTA)** signal.

This tells the device

> "I have received your interrupt request. Please wait while I begin servicing it."

---

## Interrupt Service Routine (ISR)

### Definition

An **Interrupt Service Routine (ISR)** is a special function executed automatically whenever an interrupt occurs.

It contains the code required to handle the interrupt.

Examples

- Read keyboard input
- Receive network packet
- Handle timer expiration
- Complete disk read operation

After the ISR finishes,

control returns to the interrupted program.

---

## Context

When an interrupt occurs,

the CPU must remember the current state of the program.

This saved information is called the **Context**.

Context generally includes

- Program Counter (PC)
- General Purpose Registers
- Stack Pointer (SP)
- Status Register / Flags

Without saving the context,

the processor would not know where to continue after servicing the interrupt.

---

## Why Context Saving is Necessary?

Suppose a program is calculating

```
A + B
```

and the CPU has already loaded

```
A

↓

Register R1
```

Before loading B,

an interrupt occurs.

If the CPU immediately begins executing another program without saving R1,

the value of A would be lost.

When execution resumes,

the original program would produce an incorrect result.

Therefore,

before executing the ISR,

the processor saves all important information.

After the ISR completes,

the saved values are restored,

and execution continues normally.

---

# Interrupt Life Cycle

Every interrupt follows the same sequence.

```
Program Running

↓

Interrupt Occurs

↓

CPU Finishes Current Instruction

↓

Save Context

↓

Identify Interrupt

↓

Execute ISR

↓

Restore Context

↓

Resume Program
```

This complete sequence is known as the **Interrupt Life Cycle**.