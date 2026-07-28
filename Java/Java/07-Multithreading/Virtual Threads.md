# Virtual Threads (Java)

## What are Virtual Threads?

A **Virtual Thread** is a **lightweight thread managed by the JVM instead of the Operating System**.

Unlike traditional threads (Platform Threads), virtual threads allow Java applications to create **millions of concurrent threads** with very little memory.

> **Definition:** A Virtual Thread is a JVM-managed lightweight thread introduced in **Java 21 (Project Loom)** that enables high-concurrency applications with minimal resource usage.

---

# Why Do We Need Virtual Threads?

Traditional (Platform) threads are expensive.

For every thread:

- OS creates a native thread
- Memory is allocated
- Context switching occurs
- Thread creation takes time

Imagine a server receiving:

```
1,000,000 HTTP Requests
```

Creating **1 million platform threads** would consume enormous memory and CPU resources.

Virtual Threads solve this problem by allowing Java to create a huge number of lightweight threads efficiently.

---

# Real World Example

Imagine a restaurant.

### Platform Threads

Each customer gets **their own waiter**.

If 10,000 customers arrive,

you need 10,000 waiters.

Very expensive.

---

### Virtual Threads

There are only **20 waiters**.

Whenever one customer waits for food,

the waiter immediately serves another customer.

```
Customer Waiting

↓

Waiter Serves Another Customer

↓

Food Ready

↓

Waiter Returns
```

Few waiters can efficiently handle thousands of customers.

---

# Platform Thread vs Virtual Thread

| Platform Thread | Virtual Thread |
|-----------------|----------------|
| Managed by OS | Managed by JVM |
| Heavyweight | Lightweight |
| Expensive to create | Cheap to create |
| Large memory usage | Very small memory usage |
| Limited in number | Can create millions |
| One OS thread per Java thread | Many virtual threads share a small number of OS threads |

---

# How Virtual Threads Work

```
Virtual Thread 1
Virtual Thread 2
Virtual Thread 3
Virtual Thread 4
Virtual Thread 5
        │
        ▼
 JVM Scheduler
        │
        ▼
Platform Threads
        │
        ▼
Operating System
```

The JVM schedules many virtual threads onto a smaller set of platform threads.

---

# Creating a Virtual Thread

## Method 1 (Recommended)

```java
Thread thread = Thread.startVirtualThread(() -> {
    System.out.println("Hello Virtual Thread");
});
```

The thread starts immediately.

---

## Method 2

```java
Thread thread = Thread.ofVirtual()
                      .start(() -> {
                          System.out.println("Running");
                      });
```

---

## Method 3

```java
Thread.Builder builder = Thread.ofVirtual();

Thread thread = builder.unstarted(() -> {
    System.out.println("Task");
});

thread.start();
```

---

# Example

```java
public class Main {

    public static void main(String[] args)
            throws Exception {

        Thread thread = Thread.startVirtualThread(() -> {

            System.out.println(
                    Thread.currentThread());

        });

        thread.join();
    }

}
```

Output

```text
VirtualThread[#21]/runnable
```

---

# Creating Thousands of Virtual Threads

```java
for (int i = 0; i < 100000; i++) {

    Thread.startVirtualThread(() -> {
        System.out.println("Running");
    });

}
```

This is practical because virtual threads are lightweight.

Doing the same with platform threads would usually exhaust system resources.

---

# Internal Working

Platform Thread

```
Java Thread

↓

Operating System Thread

↓

CPU
```

One Java thread maps to one OS thread.

---

Virtual Thread

```
Virtual Thread

↓

JVM Scheduler

↓

Platform Thread

↓

CPU
```

Many virtual threads share a small number of platform threads.

---

# What Happens During Blocking?

Suppose a virtual thread performs:

```java
Thread.sleep(5000);
```

or waits for database/network I/O.

With a **platform thread**:

```
Platform Thread

↓

Blocked for 5 Seconds
```

The OS thread is tied up.

---

With a **virtual thread**:

```
Virtual Thread

↓

Parks (suspends)

↓

Platform Thread becomes free

↓

Runs another Virtual Thread
```

This makes virtual threads especially efficient for I/O-heavy workloads.

---

# Virtual Threads vs Thread Pool

| Thread Pool | Virtual Thread |
|--------------|----------------|
| Limited number of threads | Can create millions of threads |
| Threads are reused | Threads are cheap enough that reuse is often unnecessary |
| Uses `ExecutorService` | Can be created directly or via virtual-thread executors |
| Better than creating platform threads | Better for large numbers of blocking tasks |

---

# Virtual Thread Executor

Java provides an executor for virtual threads.

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

try (ExecutorService executor =
         Executors.newVirtualThreadPerTaskExecutor()) {

    executor.submit(() ->
        System.out.println("Task"));

}
```

Each submitted task gets its own virtual thread.

---

# When Should We Use Virtual Threads?

Best for:

- REST APIs
- Database calls
- Network communication
- File I/O
- Web servers
- Chat applications
- Email services
- Microservices
- Backend services with many concurrent users

---

# When Should We NOT Use Virtual Threads?

Virtual threads are **not always the best choice**.

Avoid relying on them for:

- CPU-intensive computations
- Long-running mathematical processing
- Parallel scientific calculations

For CPU-bound work, use a limited number of platform threads or thread pools sized to the available CPU cores.

---

# Production Usage

Virtual Threads are becoming popular in:

- Spring Boot 3.2+ (when enabled)
- REST APIs
- Banking applications
- Payment gateways
- Cloud-native applications
- Microservices
- High-concurrency backend systems

Example:

A banking application receives:

```
500,000 Users
```

Each request may wait for:

- Database
- Redis
- External APIs

Instead of creating hundreds of thousands of platform threads,

the application creates hundreds of thousands of **virtual threads**, while the JVM efficiently schedules them onto a much smaller number of platform threads.

---

# Advantages

- Lightweight
- Very low memory usage
- Fast creation
- Supports millions of concurrent tasks
- Excellent for blocking I/O
- Simpler programming model than asynchronous callbacks

---

# Disadvantages

- Not ideal for CPU-bound workloads
- Performance benefits depend on libraries using blocking operations that cooperate well with virtual threads
- Poor synchronization design can still cause contention

---

# Virtual Thread vs Platform Thread

| Feature | Platform Thread | Virtual Thread |
|----------|-----------------|----------------|
| Managed By | OS | JVM |
| Cost | High | Low |
| Memory | Large | Small |
| Creation | Slow | Fast |
| Maximum Count | Limited | Very High |
| Best For | CPU-bound work | I/O-bound work |

---

# Common Mistakes

❌ Assuming virtual threads make CPU-intensive code faster.

❌ Thinking virtual threads replace all thread pools.

❌ Creating unnecessary synchronization that blocks many virtual threads.

❌ Assuming every library automatically benefits without testing.

---

# Interview Questions

### 1. What is a Virtual Thread?

A lightweight thread managed by the JVM that enables high concurrency with much lower resource usage than platform threads.

---

### 2. When were Virtual Threads introduced?

They became a standard feature in **Java 21** after Project Loom.

---

### 3. Who manages Virtual Threads?

The JVM manages and schedules them onto platform threads.

---

### 4. Why are Virtual Threads faster to create?

Because they do not require creating a dedicated OS thread for each Java thread.

---

### 5. Can we create millions of Virtual Threads?

Yes, assuming sufficient memory and an appropriate workload (typically I/O-bound).

---

### 6. Are Virtual Threads good for CPU-intensive work?

No.

They are mainly designed for **I/O-bound** applications.

---

### 7. Do Virtual Threads replace Thread Pools?

Not completely.

For many blocking I/O workloads, they reduce the need for traditional thread pools. However, bounded executors are still useful for limiting concurrency or managing CPU-bound work.

---

### 8. Does Spring Boot support Virtual Threads?

Yes.

Spring Boot 3.2+ can be configured to use virtual threads with Java 21.

---

### 9. What is the biggest advantage of Virtual Threads?

Handling a very large number of concurrent blocking tasks with low memory overhead while keeping code simple.

---

# Quick Revision

- Virtual Threads were introduced as a standard feature in Java 21.
- Managed by the JVM, not directly by the OS.
- Lightweight and inexpensive to create.
- Many virtual threads share a smaller number of platform threads.
- Best suited for I/O-bound applications.
- Not intended to speed up CPU-bound tasks.
- Can be created using `Thread.startVirtualThread()`.
- `Executors.newVirtualThreadPerTaskExecutor()` creates virtual threads for submitted tasks.
- Supported by modern Spring Boot versions.
- Designed to simplify high-concurrency programming.

---

# Keywords

- Virtual Thread
- Platform Thread
- Project Loom
- Java 21
- JVM Scheduler
- Carrier Thread
- I/O-bound
- CPU-bound
- Concurrency
- Thread
- ExecutorService
- newVirtualThreadPerTaskExecutor()
- Thread.startVirtualThread()
- Blocking I/O
- Lightweight Thread
```