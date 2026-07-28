# Garbage Collection (GC)

## What is Garbage Collection?

**Garbage Collection (GC)** is the automatic process of finding and removing objects that are no longer used by the program.

It helps free Heap memory so that new objects can be created.

> **Definition:** Garbage Collection is a JVM feature that automatically removes unreachable objects from the Heap to prevent memory leaks.

---

# Why Do We Need Garbage Collection?

Imagine creating thousands of objects.

```java
Student s = new Student();

s = null;
```

The object still occupies memory.

If unused objects were never removed,

```text
Heap

↓

Object 1

↓

Object 2

↓

Object 3

↓

Unused Objects

↓

Heap Full
```

Eventually,

```text
java.lang.OutOfMemoryError
```

Garbage Collection solves this problem.

---

# Real-World Example

Imagine a classroom.

```text
Students

↓

Use Paper

↓

Throw in Dustbin

↓

Cleaner Removes Waste
```

Similarly,

```text
Objects

↓

Used

↓

No Longer Needed

↓

Garbage Collector Removes Them
```

---

# Where Does GC Work?

Garbage Collection works only in the **Heap**.

```text
JVM Memory

├── Heap ← Garbage Collector
├── Stack
├── Metaspace
├── PC Register
└── Native Method Stack
```

It does **not** clean Stack memory because Stack Frames are removed automatically when methods return.

---

# What is Garbage?

Garbage means an object that is **no longer reachable**.

Example

```java
Student s = new Student();

s = null;
```

Memory

```text
Stack

↓

s = null

----------------

Heap

↓

Student Object

↓

No Reference
```

Since nothing can access the object,

it becomes **Garbage**.

---

# Reachable vs Unreachable Objects

```java
Student s1 = new Student();

Student s2 = new Student();

s2 = null;
```

Memory

```text
Stack

↓

s1 ───────────────┐
                  │
Heap              │

Student Object 1 ◄┘

Student Object 2

(No Reference)
```

- Student Object 1 → Reachable
- Student Object 2 → Unreachable (Garbage)

---

# How Garbage Collection Works

```text
Create Objects

↓

Use Objects

↓

Some Objects Become Unreachable

↓

Garbage Collector Finds Them

↓

Memory Released
```

---

# Root References

The JVM starts checking from **GC Roots**.

GC Roots include:

- Local variables in Stack
- Active Threads
- Static Variables
- JNI References

Example

```text
GC Roots

↓

Stack

↓

Reference

↓

Heap Object
```

If an object cannot be reached from any GC Root,

it is eligible for Garbage Collection.

---

# Example

```java
Student s = new Student();

s = null;
```

Internally

```text
Student Object

↓

No GC Root

↓

Eligible for GC
```

---

# Multiple References

```java
Student s1 = new Student();

Student s2 = s1;

s1 = null;
```

Memory

```text
Stack

↓

s1 → null

↓

s2 ───────────┐
              │
Heap          │

Student Object◄┘
```

The object is **not** garbage because `s2` still points to it.

---

# Cyclic References

```java
class A{

    B b;

}

class B{

    A a;

}
```

Even if two objects point to each other,

they are removed if no GC Root can reach them.

```text
Object A ↔ Object B

(No GC Root)

↓

Garbage
```

Unlike simple reference counting, modern JVMs correctly collect cyclic garbage.

---

# Types of Garbage Collection

### Minor GC

Works on the **Young Generation**.

```text
Young Generation

↓

Minor GC
```

Fast and frequent.

---

### Major GC

Works mainly on the **Old Generation**.

```text
Old Generation

↓

Major GC
```

Slower than Minor GC.

---

### Full GC

Cleans the entire Heap and may also reclaim class metadata if possible.

```text
Young Generation

↓

Old Generation

↓

Cleanup
```

Usually the slowest type of collection.

---

# When Does GC Run?

The JVM decides when to run GC.

Common situations:

- Heap becomes nearly full
- Eden Space is full
- Memory pressure increases

The programmer **cannot force** GC to run immediately.

---

# System.gc()

Example

```java
System.gc();
```

This is only a **request**.

The JVM may:

- Run GC
- Delay GC
- Ignore the request

---

# Finalize Method

Earlier,

Java supported

```java
protected void finalize()
```

before an object was collected.

Today,

`finalize()` is **deprecated** and should not be used because it is unreliable and hurts performance.

Use:

- Try-with-resources
- `AutoCloseable`

instead.

---

# Internal Working

Suppose

```java
Student s = new Student();

s = null;
```

Internally

```text
Create Object

↓

Heap

↓

Reference Removed

↓

Object Becomes Unreachable

↓

Garbage Collector

↓

Memory Freed
```

---

# Production Usage

Every Java application relies on Garbage Collection.

Examples

- Spring Boot
- Hibernate
- Kafka
- Elasticsearch
- Tomcat

Example

```text
REST Request

↓

Objects Created

↓

Response Sent

↓

Objects Become Unreachable

↓

Garbage Collector Frees Memory
```

In a Spring Boot application, request objects, DTOs, and temporary collections are typically reclaimed after the request completes.

---

# Advantages

- Automatic memory management
- Reduces memory leaks
- No manual memory deallocation
- Simplifies development
- Improves application stability

---

# Limitations

- GC pauses can affect performance
- Consumes CPU resources
- Timing is unpredictable
- Cannot instantly free memory on demand

---

# Best Practices

✅ Remove unnecessary object references.

✅ Close files and database connections using try-with-resources.

✅ Avoid creating excessive temporary objects.

✅ Monitor Heap and GC activity in production.

---

# Common Mistakes

❌ Believing `System.gc()` always runs Garbage Collection.

It is only a request.

---

❌ Thinking GC removes all unused memory immediately.

The JVM decides when to perform collection.

---

❌ Assuming objects with cyclic references always leak memory.

Modern JVMs can collect cyclic garbage.

---

❌ Using `finalize()` for resource cleanup.

It is deprecated.

---

# Interview Questions

### 1. What is Garbage Collection?

Garbage Collection is the automatic process of removing unreachable objects from the Heap.

---

### 2. Where does Garbage Collection work?

Only in the Heap.

---

### 3. What is Garbage?

An object that is no longer reachable from any GC Root.

---

### 4. What are GC Roots?

References from which the JVM starts determining object reachability, such as stack variables, static fields, active threads, and JNI references.

---

### 5. What is Minor GC?

Garbage Collection that primarily cleans the Young Generation.

---

### 6. What is Major GC?

Garbage Collection that primarily cleans the Old Generation.

---

### 7. What is Full GC?

A collection that processes the entire Heap and is generally the most expensive.

---

### 8. Can we force Garbage Collection?

No.

`System.gc()` only requests that the JVM perform GC.

---

### 9. Does Garbage Collection prevent all memory leaks?

No.

Objects that are still reachable (for example, because they remain in a cache or static collection) cannot be collected.

---

### 10. Is `finalize()` recommended?

No.

It is deprecated. Use try-with-resources and `AutoCloseable` instead.

---

# Quick Revision

- GC works only on the Heap.
- Removes unreachable objects.
- Starts from GC Roots.
- Types:
  - Minor GC
  - Major GC
  - Full GC
- `System.gc()` is only a request.
- `finalize()` is deprecated.
- GC automatically manages object memory.

---

# Keywords

- Garbage Collection
- GC
- Heap
- Reachable Object
- Unreachable Object
- GC Roots
- Minor GC
- Major GC
- Full GC
- System.gc()
- finalize()
- JVM
- Memory Management
- Heap Cleanup