# JIT Compiler (Just-In-Time Compiler)

## What is JIT Compiler?

**JIT (Just-In-Time) Compiler** is a component of the JVM's **Execution Engine** that converts frequently executed **bytecode** into **native machine code** at runtime.

Instead of interpreting the same bytecode repeatedly, the JIT Compiler compiles it once into machine code, making future executions much faster.

> **Definition:** JIT Compiler is a runtime compiler inside the JVM that improves Java application performance by converting frequently executed bytecode into native machine code.

---

# Why Do We Need JIT Compiler?

Without JIT,

every Java instruction would be interpreted every time.

```text
Bytecode

↓

Interpreter

↓

Execute

↓

Interpreter

↓

Execute

↓

Interpreter

↓

Execute
```

This becomes slow for code that runs repeatedly.

With JIT,

```text
Bytecode

↓

JIT Compiler

↓

Machine Code

↓

Execute Directly
```

Execution becomes much faster.

---

# Real-World Example

Imagine translating a book.

Without JIT

```text
Read English

↓

Translate

↓

Speak

↓

Repeat Again
```

Every time, translation happens again.

With JIT

```text
Translate Once

↓

Save Translation

↓

Reuse Translation
```

Much faster.

---

# Position in JVM

```text
Java Program

↓

Class Loader

↓

Bytecode

↓

Execution Engine

├── Interpreter
├── JIT Compiler
└── Garbage Collector

↓

Machine Code

↓

CPU
```

The JIT Compiler is part of the **Execution Engine**.

---

# How JIT Works

Suppose we have

```java
for(int i = 0; i < 1000000; i++) {
    add(i);
}
```

Initially,

```text
Bytecode

↓

Interpreter

↓

Execute
```

The JVM notices that `add()` is being executed many times.

Then,

```text
Hot Method

↓

JIT Compiler

↓

Machine Code

↓

CPU
```

Future executions use machine code instead of interpreting bytecode again.

---

# Interpreter vs JIT

### Interpreter

Reads one instruction at a time.

```text
Bytecode

↓

Instruction 1

↓

Instruction 2

↓

Instruction 3
```

Advantages

- Fast startup
- Low compilation overhead

Disadvantages

- Slower execution for frequently used code

---

### JIT Compiler

Compiles an entire method into native code.

```text
Bytecode

↓

Machine Code

↓

Store

↓

Execute Again
```

Advantages

- High performance
- Optimized execution

Disadvantages

- Compilation takes some time

---

# HotSpot JVM

The most common JVM implementation is **HotSpot JVM**.

Why "HotSpot"?

Because it identifies **hot spots** in the code.

A **Hot Spot** is code that executes many times.

Example

```java
while(true){

    process();

}
```

The `process()` method becomes a hot method and is compiled by JIT.

---

# Hot Methods

Methods that execute frequently are called **Hot Methods**.

```text
Method

↓

Executed Again

↓

Executed Again

↓

Executed Again

↓

Hot Method

↓

JIT Compile
```

---

# Compilation Levels

Modern JVMs use **Tiered Compilation**.

```text
Level 0

↓

Interpreter

↓

Level 1

↓

Simple Compilation (C1)

↓

Level 4

↓

Optimized Compilation (C2)
```

The JVM gradually optimizes methods based on how often they are executed.

---

# C1 Compiler (Client Compiler)

Designed for:

- Fast compilation
- Quick startup

Characteristics

- Less optimization
- Lower compilation time

Useful for desktop and short-running applications.

---

# C2 Compiler (Server Compiler)

Designed for:

- High performance
- Long-running applications

Characteristics

- Advanced optimizations
- Higher compilation cost
- Faster execution after compilation

Used in production servers like Spring Boot applications.

---

# Tiered Compilation

Modern JVMs combine both C1 and C2.

```text
Interpreter

↓

C1 Compiler

↓

Profile Execution

↓

C2 Compiler

↓

Highly Optimized Machine Code
```

This gives both fast startup and high performance.

---

# Method Inlining

Suppose

```java
int square(int x){
    return x * x;
}
```

Normally

```text
main()

↓

square()

↓

Return
```

JIT may replace it with

```java
int result = x * x;
```

No method call is needed.

This optimization is called **Method Inlining**.

---

# Escape Analysis

JIT checks whether an object "escapes" a method.

Example

```java
void test(){

    Student s = new Student();

}
```

If `s` is used only inside `test()`, the JVM may optimize the allocation.

Benefits

- Fewer allocations
- Reduced Garbage Collection pressure
- Better performance

---

# Other JVM Optimizations

JIT performs many optimizations, such as:

- Method Inlining
- Escape Analysis
- Dead Code Elimination
- Loop Optimization
- Constant Folding

These optimizations improve execution speed automatically.

---

# Internal Working

Suppose

```java
for(int i=0;i<1000000;i++){

    calculate();

}
```

Internally

```text
Bytecode

↓

Interpreter

↓

Method Becomes Hot

↓

JIT Compiler

↓

Machine Code

↓

CPU

↓

Fast Execution
```

---

# Production Usage

Every modern Java backend uses JIT.

Examples

- Spring Boot
- Hibernate
- Kafka
- Elasticsearch
- Tomcat
- IntelliJ IDEA

Example

```text
Spring Boot Starts

↓

Interpreter Executes

↓

Frequently Used Methods

↓

JIT Compiles

↓

Application Becomes Faster
```

This is one reason long-running Java applications often perform better after they have been running for a while ("warming up").

---

# Advantages

- Faster execution
- Automatic optimization
- Better CPU utilization
- Improves long-running applications
- No changes required in source code

---

# Limitations

- Slower startup due to compilation
- Uses additional memory for compiled code
- Benefits are smaller for very short-lived programs

---

# Best Practices

✅ Keep methods small and focused.

✅ Avoid premature micro-optimizations.

✅ Let the JVM optimize frequently executed code.

✅ Benchmark applications after JVM warm-up.

---

# Common Mistakes

❌ Thinking JIT compiles Java source code.

JIT compiles **bytecode**, not `.java` files.

---

❌ Assuming every method is immediately compiled.

Only frequently executed ("hot") methods are compiled.

---

❌ Believing Java is always interpreted.

Modern JVMs use both the Interpreter and the JIT Compiler.

---

❌ Ignoring JVM warm-up when measuring performance.

---

# Interview Questions

### 1. What is JIT Compiler?

A runtime compiler inside the JVM that converts frequently executed bytecode into native machine code.

---

### 2. Why is JIT needed?

To improve performance by avoiding repeated interpretation of the same bytecode.

---

### 3. Where is JIT located?

Inside the JVM's **Execution Engine**.

---

### 4. What is a Hot Method?

A method that is executed frequently enough for the JVM to compile into machine code.

---

### 5. What is HotSpot JVM?

The standard JVM implementation that detects frequently executed code (hot spots) and optimizes it using JIT.

---

### 6. What is the difference between the Interpreter and JIT?

- Interpreter executes bytecode instruction by instruction.
- JIT compiles frequently executed bytecode into machine code.

---

### 7. What is Method Inlining?

Replacing a method call with the method's body to reduce call overhead.

---

### 8. What is Escape Analysis?

An optimization where the JVM determines whether an object is confined to a method and can optimize its allocation.

---

### 9. What are C1 and C2 Compilers?

- **C1 (Client Compiler):** Faster compilation with fewer optimizations.
- **C2 (Server Compiler):** Slower compilation but highly optimized machine code.

---

### 10. Why do Spring Boot applications become faster after running for some time?

Because the JVM identifies hot methods and compiles them using the JIT Compiler, improving execution speed after the application warms up.

---

# Quick Revision

- JIT = Just-In-Time Compiler.
- Part of the JVM Execution Engine.
- Compiles **bytecode** into **machine code**.
- Optimizes **hot methods**.
- Works with the Interpreter.
- HotSpot JVM uses:
  - C1 Compiler
  - C2 Compiler
  - Tiered Compilation
- Common optimizations:
  - Method Inlining
  - Escape Analysis
  - Dead Code Elimination
  - Loop Optimization
  - Constant Folding

---

# Keywords

- JIT Compiler
- Just-In-Time Compiler
- Execution Engine
- Interpreter
- HotSpot JVM
- Hot Method
- Machine Code
- Bytecode
- C1 Compiler
- C2 Compiler
- Tiered Compilation
- Method Inlining
- Escape Analysis
- JVM Optimization
- Warm-up
```