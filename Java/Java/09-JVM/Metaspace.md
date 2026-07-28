# Metaspace (JVM Memory)

## What is Metaspace?

**Metaspace** is a JVM memory area that stores **class metadata** instead of objects.

Whenever a class is loaded, information about that class is stored in Metaspace.

> **Definition:** Metaspace is a shared JVM memory area that stores class-related metadata such as class structure, methods, fields, constructors, and the runtime constant pool.

---

# Why Do We Need Metaspace?

Suppose we have

```java
class Student {

    int id;

    String name;

    void study() {

    }

}
```

The JVM needs to remember:

- Class name
- Fields
- Methods
- Constructors
- Interfaces
- Annotations

This information is stored in **Metaspace**.

Without Metaspace, the JVM wouldn't know how a class is structured.

---

# Real-World Example

Imagine a blueprint of a building.

```text
Blueprint

↓

Building Details

↓

Engineer Builds House
```

Similarly,

```text
Class File

↓

Metaspace

↓

Object Created in Heap
```

Metaspace stores the **blueprint**, while Heap stores the **actual objects**.

---

# What is Stored in Metaspace?

Metaspace stores:

- Class Metadata
- Method Metadata
- Constructor Information
- Field Information
- Interface Information
- Runtime Constant Pool
- Annotation Metadata

It **does not** store objects.

---

# Example

```java
class Student {

    int id;

    String name;

}
```

Memory

```text
Metaspace

↓

Student Class

↓

Fields

↓

Methods

↓

Constructors
```

---

# Relationship with Heap

Suppose

```java
Student s = new Student();
```

Memory

```text
Metaspace

↓

Student.class

---------------------

Heap

↓

Student Object

---------------------

Stack

↓

Reference s
```

Notice

- Class → Metaspace
- Object → Heap
- Reference → Stack

---

# Class Loading

When the JVM starts

```text
Student.class

↓

Class Loader

↓

Metaspace
```

Now the JVM knows everything about the `Student` class.

---

# Runtime Constant Pool

Each class has a **Runtime Constant Pool**.

It contains:

- String literals
- Numeric constants
- Method references
- Field references
- Symbolic references

Example

```java
String name = "Java";
```

The string literal `"Java"` is stored in the **String Pool** (inside the Heap), while the class's symbolic references and constants are maintained in its Runtime Constant Pool in Metaspace.

---

# Why Was PermGen Removed?

Before Java 8,

JVM used

```text
PermGen
```

Problems:

- Fixed size
- Frequent `OutOfMemoryError`
- Difficult to tune

Java 8 introduced

```text
Metaspace
```

Benefits:

- Uses native memory
- Can grow automatically (unless limited)
- Better performance
- Easier memory management

---

# PermGen vs Metaspace

| PermGen | Metaspace |
|----------|-----------|
| Java 7 and earlier | Java 8+ |
| Fixed Size | Uses Native Memory |
| Easier to exhaust | Can grow dynamically |
| More tuning required | Less tuning required |

---

# Metaspace is Shared

Unlike the Stack,

Metaspace is shared by all threads.

```text
Thread 1

↓

Student Class

---------------

Thread 2

↓

Student Class

---------------

Metaspace (Shared)
```

Only one copy of class metadata is required.

---

# Metaspace and Objects

Example

```java
Student s1 = new Student();

Student s2 = new Student();
```

Memory

```text
Metaspace

↓

Student Class

----------------

Heap

↓

Student Object 1

↓

Student Object 2
```

One class,

many objects.

---

# Dynamic Class Loading

Frameworks like Spring and Hibernate load classes dynamically.

```text
Spring Boot

↓

Class Loader

↓

Metaspace

↓

Beans Created
```

Every dynamically loaded class also occupies Metaspace.

---

# Metaspace OutOfMemoryError

Suppose an application continuously generates new classes.

Eventually

```text
Metaspace Full

↓

java.lang.OutOfMemoryError:

Metaspace
```

This usually happens due to:

- Excessive dynamic class generation
- ClassLoader memory leaks
- Large applications with many loaded classes

---

# JVM Flags

View default settings

```bash
java -XX:+PrintFlagsFinal
```

Limit Metaspace size

```bash
-XX:MaxMetaspaceSize=512m
```

Set initial size

```bash
-XX:MetaspaceSize=128m
```

---

# Internal Working

Suppose

```java
Student s = new Student();
```

Internally

```text
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

Reference

↓

Stack
```

Without Metaspace,

the JVM would not know how to create the object.

---

# Production Usage

Every Java framework uses Metaspace.

Examples

- Spring Boot
- Hibernate
- Kafka
- Tomcat
- JUnit
- IntelliJ IDEA

Example

```text
Spring Boot Starts

↓

Controller Class

↓

Service Class

↓

Repository Class

↓

Loaded into Metaspace

↓

Objects Created in Heap
```

---

# Advantages

- Stores class metadata separately
- Dynamic memory allocation
- Better than PermGen
- Supports dynamic class loading
- Shared across all threads

---

# Limitations

- Can still run out of memory
- Uses native memory
- ClassLoader leaks can consume Metaspace

---

# Best Practices

✅ Avoid unnecessary dynamic class generation.

✅ Release custom ClassLoaders when no longer needed.

✅ Monitor Metaspace usage in production.

✅ Understand the difference between Heap and Metaspace.

---

# Common Mistakes

❌ Thinking objects are stored in Metaspace.

Objects are stored in the Heap.

---

❌ Confusing Metaspace with Heap.

Metaspace stores class metadata, not objects.

---

❌ Believing every object creates new class metadata.

Only one copy of a class's metadata is loaded, regardless of how many objects are created.

---

❌ Ignoring ClassLoader leaks.

Unused ClassLoaders can prevent class metadata from being reclaimed.

---

# Interview Questions

### 1. What is Metaspace?

Metaspace is the JVM memory area that stores class metadata.

---

### 2. What is stored in Metaspace?

- Class metadata
- Method metadata
- Constructor information
- Field information
- Runtime Constant Pool
- Annotation metadata

---

### 3. Are objects stored in Metaspace?

No.

Objects are stored in the Heap.

---

### 4. Which Java version introduced Metaspace?

Java 8.

---

### 5. Why was PermGen removed?

Because it had a fixed size and often caused memory issues. Metaspace uses native memory and can grow dynamically.

---

### 6. Is Metaspace shared?

Yes.

It is shared by all threads.

---

### 7. What is the Runtime Constant Pool?

A per-class runtime structure that stores constants, symbolic references, and other constant data used by the class.

---

### 8. What causes `OutOfMemoryError: Metaspace`?

Excessive class loading, dynamic class generation, or ClassLoader memory leaks.

---

### 9. How can Metaspace size be limited?

Using the JVM option:

```text
-XX:MaxMetaspaceSize
```

---

### 10. How is Metaspace used in Spring Boot?

Spring Boot loads controllers, services, repositories, configuration classes, and other application classes into Metaspace before creating their objects in the Heap.

---

# Quick Revision

- Metaspace stores class metadata.
- Introduced in Java 8.
- Replaced PermGen.
- Shared by all threads.
- Stores:
  - Class metadata
  - Method metadata
  - Runtime Constant Pool
  - Constructors
  - Fields
- Objects are **not** stored here.
- Uses native memory.
- Can throw `OutOfMemoryError: Metaspace`.

---

# Keywords

- Metaspace
- PermGen
- Class Metadata
- Runtime Constant Pool
- Class Loader
- Native Memory
- JVM
- Heap
- Stack
- Java 8
- OutOfMemoryError
- MaxMetaspaceSize
- Dynamic Class Loading
- Spring Boot
```