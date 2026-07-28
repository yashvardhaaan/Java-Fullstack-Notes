# Memory Areas (JVM Runtime Data Areas)

## What are Memory Areas?

Whenever a Java program runs, the JVM allocates different memory regions to store:

- Objects
- Variables
- Method calls
- Class information
- Native methods

These memory regions are collectively called **JVM Runtime Data Areas**.

> **Definition:** JVM Memory Areas are different sections of memory used by the JVM to execute Java programs efficiently.

---

# Why Do We Need Memory Areas?

Imagine everything in Java is stored in one large memory block.

```
Objects

Variables

Methods

Classes

Threads

↓

One Memory
```

Finding and managing data would become slow and inefficient.

Instead, JVM separates memory into different areas.

```
Heap

↓

Objects

Stack

↓

Method Calls

Metaspace

↓

Class Information
```

This improves performance and memory management.

---

# Real-World Example

Imagine a company.

```
Office

├── Employee Records
├── Work Desk
├── File Cabinet
├── Notice Board
└── Reception
```

Similarly,

```
JVM

├── Heap
├── Stack
├── Metaspace
├── PC Register
└── Native Method Stack
```

Each section has a different responsibility.

---

# JVM Runtime Data Areas

```
JVM Runtime Data Areas

├── Heap
├── Stack
├── Metaspace
├── Program Counter (PC) Register
└── Native Method Stack
```

---

# Complete Memory Diagram

```text
                   JVM Runtime Memory

        +----------------------------------+
        |          Metaspace               |
        |  Class Metadata                  |
        +----------------------------------+

        +----------------------------------+
        |             Heap                 |
        |  Objects | Arrays                |
        +----------------------------------+

Thread 1
+------------------+
| PC Register      |
+------------------+
| Java Stack       |
+------------------+
| Native Stack     |
+------------------+

Thread 2
+------------------+
| PC Register      |
+------------------+
| Java Stack       |
+------------------+
| Native Stack     |
+------------------+
```

Notice:

- Heap is shared.
- Metaspace is shared.
- Stack is per thread.
- PC Register is per thread.
- Native Stack is per thread.

---

# 1. Heap

The Heap stores:

- Objects
- Arrays

Example

```java
Student s = new Student();
```

```
Student Object

↓

Heap
```

Characteristics

- Shared by all threads
- Managed by Garbage Collector
- Largest memory area

---

# 2. Stack

Each thread gets its own Stack.

Stores

- Local variables
- Method parameters
- Method calls
- Return addresses

Example

```java
void add(){

    int x = 10;

}
```

```
Method Call

↓

Stack Frame

↓

Local Variables
```

When the method finishes, its stack frame is removed automatically.

---

# Stack Frame

Every method call creates a **Stack Frame**.

Example

```java
main()

↓

add()

↓

multiply()
```

Memory

```
Top

multiply()

↓

add()

↓

main()

Bottom
```

The stack follows the **LIFO (Last In, First Out)** principle.

---

# 3. Metaspace

Stores

- Class metadata
- Method metadata
- Runtime Constant Pool

Example

```
Student.class

↓

Metaspace
```

Introduced in **Java 8**.

Before Java 8, this area was called **PermGen**.

---

# 4. Program Counter (PC) Register

Every thread has its own PC Register.

Stores

- Address of the current JVM instruction

Example

```
Instruction 1

↓

Instruction 2

↓

Instruction 3
```

The PC Register remembers which instruction should execute next.

---

# 5. Native Method Stack

Used for native methods written in languages like:

- C
- C++

Example

```java
System.loadLibrary("demo");
```

```
Java

↓

JNI

↓

Native Method

↓

Native Stack
```

---

# Shared vs Thread-Specific Memory

| Memory Area | Shared? |
|-------------|----------|
| Heap | ✅ Yes |
| Metaspace | ✅ Yes |
| Stack | ❌ No |
| PC Register | ❌ No |
| Native Method Stack | ❌ No |

---

# Object Creation Example

```java
Student s = new Student();
```

Internally

```
Student.class

↓

Already Loaded

↓

Metaspace

↓

Object Created

↓

Heap

↓

Reference s

↓

Stack
```

Here

- Class information → Metaspace
- Object → Heap
- Reference variable → Stack

---

# Method Call Example

```java
public static void main(String[] args){

    add();

}

static void add(){

    int x = 10;

}
```

Execution

```
main()

↓

add()

↓

Return

↓

main()

↓

End
```

Stack

```
Top

add()

↓

main()

Bottom
```

After `add()` finishes, its stack frame is removed.

---

# Internal Working

Suppose

```java
Student s = new Student();

s.study();
```

Internally

```
Student.class

↓

Metaspace

↓

Object Created

↓

Heap

↓

Reference

↓

Stack

↓

study()

↓

New Stack Frame
```

---

# Production Usage

Every Java application uses these memory areas.

Examples

- Spring Boot
- Hibernate
- Kafka
- Tomcat
- IntelliJ IDEA

Suppose a Spring Boot application starts.

```
Controller Class

↓

Metaspace

↓

Controller Object

↓

Heap

↓

HTTP Request

↓

Thread Stack

↓

Method Executes
```

Each HTTP request usually runs in its own thread, so each request has its own Stack and PC Register while sharing the Heap.

---

# Advantages

- Organized memory management
- Efficient execution
- Supports multithreading
- Automatic object cleanup
- Better performance

---

# Limitations

- Heap can run out of memory
- Deep recursion can cause StackOverflowError
- Excessive class loading can exhaust Metaspace

---

# Best Practices

✅ Avoid unnecessary object creation.

✅ Keep methods small.

✅ Avoid deep recursion unless necessary.

✅ Monitor Heap usage in production.

---

# Common Mistakes

❌ Thinking everything is stored in the Heap.

---

❌ Thinking Stack stores objects.

It stores references and local variables. Objects are usually stored in the Heap.

---

❌ Confusing Metaspace with Heap.

---

❌ Assuming all memory areas are shared by every thread.

---

# Interview Questions

### 1. What are JVM Runtime Data Areas?

The memory regions used by the JVM to execute Java programs.

---

### 2. What are the five JVM Memory Areas?

- Heap
- Stack
- Metaspace
- Program Counter Register
- Native Method Stack

---

### 3. Where are objects stored?

Objects are stored in the Heap.

---

### 4. Where are local variables stored?

Inside Stack Frames in the Java Stack.

---

### 5. What is stored in Metaspace?

Class metadata, method metadata, and the runtime constant pool.

---

### 6. Which memory area is shared by all threads?

Heap and Metaspace.

---

### 7. Which memory areas are thread-specific?

- Stack
- Program Counter Register
- Native Method Stack

---

### 8. What is a Stack Frame?

A Stack Frame is the memory created for each method call. It stores local variables, parameters, and other method-related information.

---

### 9. What does the PC Register store?

It stores the address of the current JVM instruction being executed.

---

### 10. What is the Native Method Stack?

It stores information required for executing native (non-Java) methods.

---

# Quick Revision

- JVM Runtime Memory consists of:
  - Heap
  - Stack
  - Metaspace
  - PC Register
  - Native Method Stack
- Heap → Objects.
- Stack → Method calls and local variables.
- Metaspace → Class metadata.
- PC Register → Current instruction.
- Native Stack → Native methods.
- Heap & Metaspace are shared.
- Stack, PC Register, and Native Stack are thread-specific.

---

# Keywords

- JVM Memory
- Runtime Data Areas
- Heap
- Stack
- Stack Frame
- Metaspace
- Program Counter Register
- Native Method Stack
- Objects
- Local Variables
- Class Metadata
- Thread
- Garbage Collection
- JVM
```