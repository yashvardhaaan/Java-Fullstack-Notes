# JVM Architecture

## What is JVM Architecture?

**JVM Architecture** is the internal structure of the **Java Virtual Machine (JVM)** that describes how a Java program is loaded, executed, and managed in memory.

It explains:

- How Java classes are loaded
- Where objects are stored
- How methods execute
- How memory is managed
- How machine code is generated

> **Definition:** JVM Architecture is the collection of components inside the JVM that work together to execute Java programs.

---

# Why Do We Need JVM Architecture?

Suppose you run a Java program.

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello");
    }
}
```

The JVM must:

- Load the class
- Verify the bytecode
- Allocate memory
- Execute instructions
- Free unused memory

JVM Architecture defines how all of this happens.

---

# Real-World Example

Imagine a factory.

```
Raw Material

↓

Quality Check

↓

Warehouse

↓

Workers

↓

Machines

↓

Finished Product
```

Similarly,

```
.class File

↓

Class Loader

↓

Bytecode Verification

↓

Memory Areas

↓

Execution Engine

↓

Machine Code

↓

Output
```

---

# JVM Architecture Diagram

```text
                    +-----------------------+
                    |     Java Program      |
                    |     (.class file)     |
                    +-----------+-----------+
                                |
                                v
                    +-----------------------+
                    |     Class Loader      |
                    +-----------+-----------+
                                |
                                v
                    +-----------------------+
                    | Bytecode Verifier     |
                    +-----------+-----------+
                                |
                                v
+-----------------------------------------------------------+
|                  Runtime Data Areas                        |
|-----------------------------------------------------------|
| Method Area / Metaspace                                   |
| Heap                                                      |
| Java Stack                                                |
| PC Register                                               |
| Native Method Stack                                       |
+--------------------------+--------------------------------+
                           |
                           v
                  +---------------------+
                  | Execution Engine    |
                  |---------------------|
                  | Interpreter         |
                  | JIT Compiler        |
                  | Garbage Collector   |
                  +----------+----------+
                             |
                             v
                  +---------------------+
                  | Native Interface    |
                  | (JNI)               |
                  +----------+----------+
                             |
                             v
                  +---------------------+
                  | Native Libraries    |
                  +---------------------+
```

---

# Main Components

The JVM consists of:

```
JVM

├── Class Loader
├── Runtime Data Areas
├── Execution Engine
├── JNI
└── Native Libraries
```

---

# 1. Class Loader

The **Class Loader** loads `.class` files into memory.

Example

```
Hello.class

↓

Class Loader

↓

Memory
```

Responsibilities

- Load classes
- Verify bytecode
- Prepare memory
- Resolve references
- Initialize classes

We'll study this in detail in **Class Loader.md**.

---

# 2. Runtime Data Areas

The JVM allocates different memory areas.

```
Runtime Data Areas

├── Heap
├── Stack
├── Metaspace
├── Program Counter Register
└── Native Method Stack
```

Each has a different responsibility.

---

## Heap

Stores

- Objects
- Arrays

Example

```java
Student s = new Student();
```

The object is stored in the Heap.

---

## Stack

Each thread gets its own stack.

Stores

- Local variables
- Method calls
- Method parameters

Example

```java
int x = 10;
```

Stored inside the current method's stack frame.

---

## Metaspace

Stores

- Class metadata
- Method metadata
- Runtime constant pool

Introduced in Java 8 to replace PermGen.

---

## Program Counter (PC) Register

Every thread has its own PC Register.

It stores the address of the current JVM instruction being executed.

```
Instruction 1

↓

Instruction 2

↓

Instruction 3
```

The PC Register tracks which instruction comes next.

---

## Native Method Stack

Stores information related to native (non-Java) methods.

Example

```java
System.loadLibrary("xyz");
```

Native methods execute using the Native Method Stack.

---

# 3. Execution Engine

The Execution Engine executes bytecode.

Components

```
Execution Engine

├── Interpreter
├── JIT Compiler
└── Garbage Collector
```

---

## Interpreter

Reads bytecode one instruction at a time.

```
Bytecode

↓

Read

↓

Execute

↓

Next Instruction
```

Advantages

- Starts quickly

Disadvantages

- Slower for repeated execution

---

## JIT Compiler

JIT = **Just-In-Time Compiler**

Instead of interpreting frequently used code repeatedly,

JIT converts it into machine code.

```
Frequently Used Code

↓

JIT Compiler

↓

Machine Code

↓

CPU
```

Result

- Faster execution
- Better performance

---

## Garbage Collector

Automatically removes unused objects.

```
Unused Object

↓

Garbage Collector

↓

Memory Released
```

No manual memory management is required.

---

# 4. JNI (Java Native Interface)

JNI allows Java code to communicate with native languages like C and C++.

Example

```
Java

↓

JNI

↓

C Library

↓

Operating System
```

Used when Java needs platform-specific functionality.

---

# 5. Native Libraries

These are platform-specific libraries.

Examples

- Windows DLL
- Linux `.so`
- macOS `.dylib`

Java accesses them through JNI.

---

# Complete Execution Flow

Suppose we execute

```text
java Hello
```

Flow

```
Hello.java

↓

javac

↓

Hello.class

↓

Class Loader

↓

Bytecode Verification

↓

Memory Allocation

↓

Execution Engine

↓

Interpreter / JIT

↓

Machine Code

↓

CPU

↓

Output
```

---

# Internal Working

Suppose the program is

```java
Student s = new Student();
```

Internally

```
Student.class

↓

Class Loader

↓

Metaspace

↓

Object Created

↓

Heap

↓

Reference Stored

↓

Stack

↓

Execution Engine

↓

Program Continues
```

---

# Production Usage

Every Java application uses JVM Architecture.

Examples

- Spring Boot
- Hibernate
- Kafka
- Apache Spark
- Tomcat
- IntelliJ IDEA
- Jenkins

When a Spring Boot application starts:

```
Spring Boot

↓

JVM

↓

Class Loader

↓

Bean Classes Loaded

↓

Objects Created

↓

Heap

↓

Execution Engine

↓

Application Starts
```

---

# Advantages

- Platform independent
- Automatic memory management
- Secure execution
- Optimized performance using JIT
- Supports multithreading

---

# Limitations

- Higher memory usage
- JVM startup time
- Performance tuning may require JVM configuration

---

# Best Practices

✅ Understand memory areas before learning Garbage Collection.

✅ Avoid unnecessary object creation.

✅ Learn Heap and Stack thoroughly.

✅ Use JVM monitoring tools for production applications.

---

# Common Mistakes

❌ Thinking JVM and JDK are the same.

---

❌ Assuming all memory is stored in the Heap.

---

❌ Believing the Interpreter alone executes all code.

The JIT compiler optimizes frequently executed code.

---

❌ Ignoring how the Class Loader works.

---

# Interview Questions

### 1. What is JVM Architecture?

It is the internal structure of the JVM that loads, manages, and executes Java programs.

---

### 2. What are the main components of JVM Architecture?

- Class Loader
- Runtime Data Areas
- Execution Engine
- JNI
- Native Libraries

---

### 3. What are Runtime Data Areas?

- Heap
- Stack
- Metaspace
- Program Counter Register
- Native Method Stack

---

### 4. What is the Execution Engine?

It executes bytecode using the Interpreter and JIT Compiler, while the Garbage Collector manages memory.

---

### 5. What is JNI?

JNI (Java Native Interface) allows Java code to call native code written in languages such as C or C++.

---

### 6. What is the role of the Class Loader?

It loads `.class` files into the JVM memory.

---

### 7. Why is the JIT Compiler used?

It converts frequently executed bytecode into native machine code to improve performance.

---

### 8. What does the Garbage Collector do?

It automatically removes unused objects to free Heap memory.

---

### 9. Where are objects stored?

Objects are stored in the Heap.

---

### 10. Where are local variables stored?

Local variables and method calls are stored in the Stack.

---

# Quick Revision

- JVM Architecture = Internal working of JVM.
- Components:
  - Class Loader
  - Runtime Data Areas
  - Execution Engine
  - JNI
  - Native Libraries
- Runtime Data Areas:
  - Heap
  - Stack
  - Metaspace
  - PC Register
  - Native Method Stack
- Execution Engine:
  - Interpreter
  - JIT Compiler
  - Garbage Collector
- JVM loads classes, allocates memory, executes bytecode, and manages memory automatically.

---

# Keywords

- JVM Architecture
- Class Loader
- Heap
- Stack
- Metaspace
- Program Counter Register
- Native Method Stack
- Execution Engine
- Interpreter
- JIT Compiler
- Garbage Collector
- JNI
- Native Libraries
- Bytecode
- Machine Code
- Runtime Data Areas
```