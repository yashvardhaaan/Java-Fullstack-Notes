# Heap (JVM Memory)

## What is Heap?

The **Heap** is the JVM memory area where **objects and arrays** are stored.

Whenever you create an object using the `new` keyword, memory is allocated from the Heap.

> **Definition:** Heap is a shared JVM memory area used for storing objects and arrays. It is managed automatically by the Garbage Collector.

---

# Why Do We Need Heap?

Imagine creating thousands of objects.

```java
Student s1 = new Student();
Student s2 = new Student();
Student s3 = new Student();
```

The JVM needs a place to store these objects.

That place is the **Heap**.

Without Heap memory, Java objects could not exist during program execution.

---

# Real-World Example

Imagine a warehouse.

```text
Warehouse

↓

Store Boxes

↓

Retrieve Boxes

↓

Remove Unused Boxes
```

Similarly,

```text
Heap

↓

Store Objects

↓

Use Objects

↓

Garbage Collector Removes Unused Objects
```

---

# Characteristics of Heap

- Shared by all threads
- Stores Objects
- Stores Arrays
- Managed by Garbage Collector
- Largest memory area inside JVM

---

# Object Creation

Example

```java
Student s = new Student();
```

Memory

```text
Stack

↓

Reference s

↓

Heap

↓

Student Object
```

Notice

- Object → Heap
- Reference → Stack

---

# Heap Structure

Modern JVMs divide the Heap into different regions.

```text
Heap

├── Young Generation
│     ├── Eden Space
│     ├── Survivor 0 (S0)
│     └── Survivor 1 (S1)
│
└── Old Generation
```

---

# Young Generation

Newly created objects are stored here.

```java
Student s = new Student();
```

Memory

```text
Heap

↓

Young Generation

↓

Eden Space
```

Most objects die quickly.

---

# Eden Space

Every new object is first created inside Eden Space.

```text
new Student()

↓

Eden
```

When Eden becomes full,

Minor Garbage Collection runs.

---

# Survivor Spaces

There are two Survivor Spaces.

```text
Young Generation

↓

Eden

↓

S0

↓

S1
```

Objects that survive Minor GC move between S0 and S1.

---

# Old Generation

Objects that live for a long time are promoted to the Old Generation.

Example

```java
Singleton Object
```

or

```java
Spring Bean
```

Memory

```text
Young Generation

↓

Survives Many GCs

↓

Old Generation
```

---

# Object Lifecycle

```text
new Object()

↓

Eden

↓

Minor GC

↓

Survivor

↓

Minor GC

↓

Old Generation

↓

Major/Full GC

↓

Removed
```

---

# Heap Example

```java
Student s1 = new Student();

Student s2 = new Student();
```

Memory

```text
Stack

↓

s1

↓

Heap

↓

Student Object 1

----------------

Stack

↓

s2

↓

Heap

↓

Student Object 2
```

---

# Arrays in Heap

Example

```java
int[] arr = new int[5];
```

Memory

```text
Stack

↓

arr

↓

Heap

↓

Array Object
```

Arrays are objects in Java, so they are stored in the Heap.

---

# String Objects

Example

```java
String s = new String("Java");
```

```text
Stack

↓

Reference

↓

Heap

↓

String Object
```

> **Note:** String literals (like `"Java"`) are also stored in the **String Pool**, which resides in the Heap.

---

# Heap and Garbage Collector

Suppose

```java
Student s = new Student();

s = null;
```

Memory

```text
Object

↓

No Reference

↓

Garbage Collector

↓

Memory Freed
```

The Garbage Collector removes objects that are no longer reachable.

---

# Heap vs Stack

| Heap | Stack |
|------|------|
| Stores Objects | Stores Method Calls |
| Shared | Thread-Specific |
| Garbage Collected | Automatically Removed on Method Return |
| Larger Memory | Smaller Memory |
| Slower Access | Faster Access |

---

# Heap and Threads

Suppose

```text
Thread 1

↓

Student Object

---------------

Thread 2

↓

Student Object
```

Both threads use the same Heap.

This is why synchronization is sometimes required when multiple threads access the same object.

---

# OutOfMemoryError

Suppose

```java
while(true){

    list.add(new Student());

}
```

Objects keep getting created.

Eventually

```text
Heap Full

↓

java.lang.OutOfMemoryError

↓

Java Heap Space
```

---

# Internal Working

Suppose

```java
Student s = new Student();

s.study();
```

Internally

```text
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

Method Call

↓

Stack Frame
```

---

# Production Usage

Every Java application stores objects in the Heap.

Examples

- Spring Boot Beans
- Hibernate Entities
- REST API Request Objects
- JSON Objects
- Kafka Messages
- Collections

Example

```text
Spring Boot Starts

↓

Beans Created

↓

Heap

↓

Requests Use Beans
```

Singleton Spring Beans remain in the Heap for the lifetime of the application.

---

# Advantages

- Dynamic memory allocation
- Supports object-oriented programming
- Automatic memory management
- Shared across threads
- Managed by Garbage Collector

---

# Limitations

- Slower than Stack
- Shared memory may require synchronization
- Can cause `OutOfMemoryError`
- Garbage Collection introduces some overhead

---

# Best Practices

✅ Remove unnecessary object references.

✅ Reuse objects when appropriate.

✅ Avoid creating excessive temporary objects.

✅ Monitor Heap usage in production.

---

# Common Mistakes

❌ Thinking references and objects are stored together.

References are stored in the Stack, while objects are stored in the Heap.

---

❌ Believing Heap is thread-specific.

The Heap is shared by all threads.

---

❌ Ignoring object lifetime.

Long-lived unused objects can increase memory usage.

---

❌ Assuming `System.gc()` always runs Garbage Collection immediately.

It is only a request to the JVM.

---

# Interview Questions

### 1. What is Heap Memory?

Heap is the JVM memory area where objects and arrays are stored.

---

### 2. Is Heap shared?

Yes.

The Heap is shared by all threads.

---

### 3. Where are objects stored?

Objects are stored in the Heap.

---

### 4. Where are object references stored?

Object references are typically stored in the Stack (if they are local variables) or inside other objects in the Heap (if they are fields).

---

### 5. What is Eden Space?

The part of the Young Generation where new objects are initially created.

---

### 6. What are Survivor Spaces?

Temporary areas where objects that survive Minor Garbage Collection are moved before possible promotion to the Old Generation.

---

### 7. What is the Old Generation?

The region where long-lived objects are stored.

---

### 8. What causes `OutOfMemoryError`?

When the JVM cannot allocate more Heap memory and Garbage Collection cannot free enough space.

---

### 9. Who manages Heap Memory?

The Garbage Collector.

---

### 10. Why is Heap slower than Stack?

Because Heap memory requires dynamic allocation and Garbage Collection, while Stack follows a simple LIFO structure.

---

# Quick Revision

- Heap stores:
  - Objects
  - Arrays
- Shared by all threads.
- Managed by Garbage Collector.
- Structure:
  - Young Generation
    - Eden
    - Survivor 0
    - Survivor 1
  - Old Generation
- Objects start in Eden.
- Long-lived objects move to Old Generation.
- Heap exhaustion causes `OutOfMemoryError`.

---

# Keywords

- Heap
- Heap Memory
- Young Generation
- Eden Space
- Survivor Space
- Old Generation
- Object
- Array
- Garbage Collector
- OutOfMemoryError
- JVM
- Object Lifecycle
- Spring Beans
- Java Memory
```