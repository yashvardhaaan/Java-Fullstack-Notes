# Advanced Java Concurrency - Overview

This file gives a quick overview of advanced multithreading topics that are commonly asked in Java Backend and Spring Boot interviews.

---

# 1. ThreadLocal ⭐⭐⭐⭐⭐

## What is it?

Stores a separate copy of a variable for each thread.

Each thread gets its own independent value.

## Why use it?

To avoid sharing data between threads.

## Learn

- What is ThreadLocal?
- Internal Working
- set()
- get()
- remove()
- Memory Leak Issue

## Production Usage

- User Context
- Security Context (Spring Security)
- Transaction Context
- Logging (MDC)

---

# 2. ReentrantLock ⭐⭐⭐⭐⭐

## What is it?

A more flexible locking mechanism than `synchronized`.

Supports manual locking and unlocking.

## Learn

- lock()
- unlock()
- tryLock()
- lockInterruptibly()
- Fair Lock
- Non-Fair Lock
- Reentrant Behavior
- Difference from synchronized

## Production Usage

- Banking Systems
- Inventory Management
- Shared Resources

---

# 3. ReadWriteLock ⭐⭐⭐⭐☆

## What is it?

Allows multiple threads to read simultaneously while only one thread can write.

## Learn

- Read Lock
- Write Lock
- Multiple Readers
- Single Writer
- ReentrantReadWriteLock

## Production Usage

- Cache
- Configuration Files
- File Reading
- Product Catalog

---

# 4. Semaphore ⭐⭐⭐⭐☆

## What is it?

Controls how many threads can access a resource at the same time.

## Learn

- acquire()
- release()
- Permits
- Binary Semaphore
- Counting Semaphore

## Real-World Example

Parking Lot

```
20 Cars

↓

Only 5 Parking Slots

↓

Semaphore = 5
```

## Production Usage

- Database Connection Pool
- API Gateway
- Rate Limiting
- Resource Limiting

---

# 5. CountDownLatch ⭐⭐⭐⭐☆

## What is it?

Allows one or more threads to wait until other threads complete their work.

## Learn

- countDown()
- await()
- Initial Count

## Example

```
Database

API

Cache

↓

All Ready

↓

Application Starts
```

## Production Usage

- Microservices Startup
- Parallel Initialization
- Data Loading

---

# 6. CyclicBarrier ⭐⭐⭐⭐☆

## What is it?

Allows multiple threads to wait for each other before continuing.

Unlike CountDownLatch, it can be reused.

## Learn

- await()
- Barrier Action
- Reusable Barrier

## Production Usage

- Multiplayer Games
- Scientific Simulations
- Parallel Algorithms

---

# 7. Phaser ⭐⭐⭐☆☆

## What is it?

Advanced synchronization utility supporting multiple execution phases.

## Learn

- register()
- arrive()
- arriveAndAwaitAdvance()
- Dynamic Registration

## Production Usage

- Complex Parallel Workflows
- Multi-Phase Processing

---

# 8. Exchanger ⭐⭐☆☆☆

## What is it?

Allows two threads to exchange data safely.

## Learn

- exchange()

## Production Usage

- Producer-Consumer Variants
- Data Synchronization

---

# 9. Concurrent Utilities ⭐⭐⭐⭐☆

## What is it?

A collection of synchronization utilities in `java.util.concurrent`.

Includes

- Semaphore
- CountDownLatch
- CyclicBarrier
- Phaser
- Exchanger

## Goal

Coordinate multiple threads efficiently.

---

# 10. Deadlock, Starvation & Livelock ⭐⭐⭐⭐⭐

## Learn

### Deadlock

Two or more threads wait forever for each other.

### Starvation

A thread never gets CPU time or a required resource.

### Livelock

Threads keep responding to each other but make no progress.

## Learn

- Causes
- Prevention
- Detection
- Real-world Examples

## Production Usage

Important for designing scalable backend applications.

---

# 11. Producer-Consumer Problem ⭐⭐⭐⭐⭐

## What is it?

One thread produces data while another consumes it safely.

## Learn

- wait()
- notify()
- notifyAll()
- BlockingQueue
- ExecutorService

## Production Usage

- Kafka
- RabbitMQ
- Task Queues
- Logging Systems

---

# 12. Immutable Objects ⭐⭐⭐⭐☆

## What are they?

Objects whose state cannot change after creation.

## Learn

- Why Immutable Objects are Thread-Safe
- String
- Records (Java 16+)
- Builder Pattern

## Production Usage

- DTOs
- Configuration Objects
- Cache Keys
- Shared Objects

---

# Interview Priority

| Topic | Priority |
|--------|----------|
| ThreadLocal | ⭐⭐⭐⭐⭐ |
| ReentrantLock | ⭐⭐⭐⭐⭐ |
| Deadlock / Starvation / Livelock | ⭐⭐⭐⭐⭐ |
| Producer Consumer | ⭐⭐⭐⭐⭐ |
| ReadWriteLock | ⭐⭐⭐⭐☆ |
| Semaphore | ⭐⭐⭐⭐☆ |
| CountDownLatch | ⭐⭐⭐⭐☆ |
| CyclicBarrier | ⭐⭐⭐⭐☆ |
| Immutable Objects | ⭐⭐⭐⭐☆ |
| Phaser | ⭐⭐⭐☆☆ |
| Exchanger | ⭐⭐☆☆☆ |

---

# Recommended Learning Order

```
ThreadLocal
      ↓
ReentrantLock
      ↓
ReadWriteLock
      ↓
Semaphore
      ↓
CountDownLatch
      ↓
CyclicBarrier
      ↓
Producer Consumer
      ↓
Deadlock
      ↓
Immutable Objects
      ↓
Phaser
      ↓
Exchanger
```

---

# Goal

After learning these topics, you'll understand almost all advanced concurrency concepts commonly expected in Java Backend and Spring Boot interviews for freshers and junior developers.