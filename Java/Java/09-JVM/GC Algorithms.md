# GC Algorithms

## What are GC Algorithms?

A **Garbage Collection (GC) Algorithm** is the strategy used by the JVM to identify and remove unused objects from the Heap.

Different algorithms are designed for different goals such as:

- Low pause time
- High throughput
- Low memory usage
- Large Heap support

> **Definition:** GC Algorithms are techniques used by the JVM to automatically reclaim Heap memory occupied by unreachable objects.

---

# Why Do We Need Different GC Algorithms?

Imagine two applications.

### Banking Application

- Thousands of users
- Low response time required

Needs:

```
Low Pause Time
```

---

### Batch Processing Application

- Runs overnight
- Speed is more important than pauses

Needs:

```
High Throughput
```

Different applications have different requirements.

That's why Java provides multiple Garbage Collectors.

---

# Real-World Example

Imagine cleaning a city.

Method 1

```
Clean one street quickly
```

Method 2

```
Clean the whole city once a week
```

Method 3

```
Many workers clean different areas together
```

All clean the city,

but differently.

Similarly,

GC algorithms clean Heap memory differently.

---

# Types of Garbage Collectors

```
Garbage Collectors

├── Serial GC
├── Parallel GC
├── CMS GC (Deprecated)
├── G1 GC
├── ZGC
└── Shenandoah GC
```

---

# 1. Serial Garbage Collector

The simplest Garbage Collector.

Uses

- One Thread

```
Application

↓

Stop

↓

GC Thread

↓

Resume
```

Characteristics

- Single-threaded
- Simple
- Small Heap
- Long pauses

Suitable for

- Small applications
- Low-memory systems

JVM Option

```bash
-XX:+UseSerialGC
```

---

# 2. Parallel Garbage Collector

Uses multiple threads.

```
GC

↓

Thread 1

Thread 2

Thread 3

Thread 4
```

Characteristics

- Multi-threaded
- High throughput
- Longer pause times than G1

Suitable for

- Batch jobs
- CPU-intensive applications

JVM Option

```bash
-XX:+UseParallelGC
```

---

# 3. CMS (Concurrent Mark Sweep)

CMS was designed to reduce pause times.

Working

```
Mark

↓

Sweep

↓

Application Continues
```

Advantages

- Low pauses
- Better user experience

Limitations

- Memory fragmentation
- Complex
- Higher CPU usage

Status

> **Deprecated in Java 9 and removed in Java 14.**

JVM Option (older JVMs)

```bash
-XX:+UseConcMarkSweepGC
```

---

# 4. G1 Garbage Collector (Garbage First)

**G1 GC** is the default Garbage Collector in modern Java (Java 9+).

Instead of treating the Heap as one large block,

it divides the Heap into many **Regions**.

```
Heap

+----+----+----+----+
| R1 | R2 | R3 | R4 |
+----+----+----+----+
| R5 | R6 | R7 | R8 |
+----+----+----+----+
```

G1 cleans the regions containing the most garbage first.

Hence the name

```
Garbage First
```

Characteristics

- Predictable pause times
- Good for large heaps
- Parallel
- Concurrent

Suitable for

- Spring Boot
- Microservices
- Enterprise applications

JVM Option

```bash
-XX:+UseG1GC
```

---

# 5. Z Garbage Collector (ZGC)

Designed for

- Very large heaps
- Extremely low pause times

Characteristics

- Pause time usually stays below a few milliseconds
- Concurrent collection
- Scales to very large heaps

Suitable for

- Banking
- Trading Systems
- Large cloud applications

JVM Option

```bash
-XX:+UseZGC
```

---

# 6. Shenandoah GC

Developed by Red Hat.

Goal

```
Very Low Pause Time
```

Characteristics

- Concurrent
- Large Heap support
- Low latency

Suitable for

- Large enterprise systems
- Cloud-native applications

JVM Option

```bash
-XX:+UseShenandoahGC
```

---

# Comparison

| GC | Threads | Pause Time | Throughput | Best For |
|-----|----------|------------|------------|----------|
| Serial | One | High | Low | Small Apps |
| Parallel | Multiple | Medium | High | Batch Jobs |
| CMS | Multiple | Low | Medium | Legacy Systems |
| G1 | Multiple | Low | High | Most Applications |
| ZGC | Multiple | Very Low | High | Huge Heaps |
| Shenandoah | Multiple | Very Low | High | Low-Latency Apps |

---

# How G1 Works

```
Heap

↓

Regions

↓

Find Region

↓

Most Garbage

↓

Collect First
```

Instead of cleaning the whole Heap,

it cleans selected regions.

---

# Stop-The-World (STW)

Some GC phases pause the application.

```
Application Running

↓

Stop-The-World

↓

Garbage Collection

↓

Resume
```

Modern collectors like G1, ZGC, and Shenandoah try to minimize these pauses.

---

# Concurrent Collection

Some collectors perform much of their work while the application is still running.

```
Application

↓

Running

↓

GC Running

↓

Application Still Running
```

This reduces pause time.

---

# Internal Working

Suppose

```java
List<Student> students = new ArrayList<>();
```

Objects are created.

```
Objects Created

↓

Heap

↓

Some Objects Become Garbage

↓

GC Algorithm

↓

Memory Reclaimed
```

The exact steps depend on the selected GC algorithm.

---

# Production Usage

Different applications use different collectors.

Examples

- Spring Boot → G1 GC (default in modern Java)
- Banking Systems → ZGC (when extremely low pauses are required)
- Batch Processing → Parallel GC
- Legacy Applications → CMS (older Java versions)

---

# Advantages

- Automatic memory management
- Different collectors for different workloads
- Better performance
- Lower pause times
- Scales to large heaps

---

# Limitations

- No single GC is best for every application
- Some collectors use more CPU
- Large heaps still require proper tuning
- Wrong GC choice can affect performance

---

# Best Practices

✅ Use the default G1 GC unless you have measured reasons to change.

✅ Monitor GC logs in production.

✅ Choose a collector based on your application's workload.

✅ Benchmark before changing GC settings.

---

# Common Mistakes

❌ Thinking one GC algorithm is always the fastest.

Different workloads benefit from different collectors.

---

❌ Choosing a GC without measuring performance.

Always benchmark first.

---

❌ Assuming GC tuning alone fixes memory problems.

Poor application design can still cause memory issues.

---

❌ Using deprecated collectors like CMS in new applications.

---

# Interview Questions

### 1. What are GC Algorithms?

They are strategies used by the JVM to reclaim unused Heap memory.

---

### 2. Which GC is the default in modern Java?

**G1 Garbage Collector**.

---

### 3. Which GC is best for small applications?

Serial GC.

---

### 4. Which GC provides high throughput?

Parallel GC.

---

### 5. Which GC offers very low pause times for large heaps?

ZGC and Shenandoah.

---

### 6. Why is G1 called "Garbage First"?

Because it collects the Heap regions containing the most garbage first.

---

### 7. What is Stop-The-World?

A pause during which application threads are temporarily stopped while certain GC work is performed.

---

### 8. Is CMS recommended for new projects?

No.

It is deprecated and removed in newer Java versions.

---

### 9. Which GC is commonly used for Spring Boot applications?

G1 GC (the default in modern Java).

---

### 10. Can we change the Garbage Collector?

Yes.

By using JVM options such as:

```bash
-XX:+UseG1GC
```

or

```bash
-XX:+UseZGC
```

---

# Quick Revision

- GC Algorithms decide **how** the Heap is cleaned.
- Types:
  - Serial GC
  - Parallel GC
  - CMS (Deprecated)
  - G1 GC
  - ZGC
  - Shenandoah GC
- G1 is the default in modern Java.
- ZGC and Shenandoah focus on very low pause times.
- Parallel GC focuses on throughput.
- Serial GC is suitable for small applications.

---

# Keywords

- Garbage Collection
- GC Algorithms
- Serial GC
- Parallel GC
- CMS
- G1 GC
- ZGC
- Shenandoah
- Stop-The-World
- Concurrent GC
- Throughput
- Low Latency
- Heap
- JVM