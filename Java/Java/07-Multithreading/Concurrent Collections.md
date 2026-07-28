# Concurrent Collections (Java)

## What are Concurrent Collections?

**Concurrent Collections** are thread-safe collection classes provided by Java that allow **multiple threads to read and modify data safely without causing data corruption**.

They are part of the package:

```java
java.util.concurrent
```

> **Definition:** Concurrent Collections are specialized data structures designed for high-performance multithreaded applications.

---

# Why Do We Need Concurrent Collections?

Imagine two threads updating a `HashMap`.

```java
HashMap<Integer, String> map = new HashMap<>();
```

Thread A:

```java
map.put(1, "Java");
```

Thread B:

```java
map.put(2, "Spring");
```

Both execute simultaneously.

Possible problems:

- Data corruption
- Missing entries
- Infinite loops (older JVM implementations)
- Unexpected exceptions

Normal collections are **not thread-safe**.

Concurrent collections solve these issues.

---

# Real-World Example

Imagine a supermarket.

Without security:

```
100 Customers

↓

Everyone Enters Billing Counter

↓

Chaos
```

With multiple billing counters:

```
Customer

↓

Available Counter

↓

Payment

↓

Next Customer
```

Multiple customers can be served safely and efficiently.

Concurrent Collections work similarly by allowing safe concurrent access.

---

# Why Not Use Collections.synchronizedXXX()?

Example:

```java
Map<Integer, String> map =
Collections.synchronizedMap(new HashMap<>());
```

Although thread-safe,

it uses **one lock for the entire collection**.

Problems:

- Lower performance
- Only one thread can access the collection at a time

Concurrent Collections use **finer-grained synchronization** or **lock-free algorithms**, allowing much better scalability.

---

# Concurrent Collection Classes

| Class | Purpose |
|--------|----------|
| ConcurrentHashMap | Thread-safe HashMap |
| CopyOnWriteArrayList | Thread-safe ArrayList |
| CopyOnWriteArraySet | Thread-safe Set |
| ConcurrentLinkedQueue | Non-blocking Queue |
| ConcurrentLinkedDeque | Non-blocking Double Ended Queue |
| BlockingQueue | Producer-Consumer communication |
| LinkedBlockingQueue | Queue with optional capacity |
| ArrayBlockingQueue | Fixed-size Blocking Queue |
| PriorityBlockingQueue | Priority-based Queue |
| DelayQueue | Delayed task execution |
| ConcurrentSkipListMap | Sorted thread-safe Map |
| ConcurrentSkipListSet | Sorted thread-safe Set |

---

# 1. ConcurrentHashMap

The most commonly used concurrent collection.

```java
ConcurrentHashMap<Integer, String> map =
new ConcurrentHashMap<>();
```

Example

```java
map.put(1, "Java");

map.put(2, "Spring");

System.out.println(map.get(1));
```

Output

```text
Java
```

### Features

- Thread-safe
- High performance
- Multiple threads can read simultaneously
- Fine-grained locking for updates
- Does not allow `null` keys or values

---

# Internal Working of ConcurrentHashMap

Older Java versions (Java 7):

- Used **Segment Locking** (multiple segments with separate locks).

Modern Java (Java 8+):

- Uses **bucket-level synchronization**, **CAS (Compare-And-Swap)**, and other optimizations instead of segment locking.

This allows higher concurrency.

---

# 2. CopyOnWriteArrayList

Thread-safe version of `ArrayList`.

```java
CopyOnWriteArrayList<String> list =
new CopyOnWriteArrayList<>();
```

When modified,

it creates a **new copy of the internal array**.

Example

```java
list.add("Java");

list.add("Spring");
```

### Best For

- Many reads
- Very few writes

Examples:

- Configuration lists
- Event listeners
- User permissions

---

# Internal Working

```
Old Array

↓

Copy Entire Array

↓

Add New Element

↓

Replace Old Array
```

Reading never blocks.

Writing is expensive.

---

# 3. CopyOnWriteArraySet

Thread-safe version of `Set`.

```java
CopyOnWriteArraySet<Integer> set =
new CopyOnWriteArraySet<>();
```

Features:

- No duplicates
- Thread-safe
- Copy-on-write mechanism

---

# 4. ConcurrentLinkedQueue

A thread-safe, **non-blocking FIFO queue**.

```java
ConcurrentLinkedQueue<String> queue =
new ConcurrentLinkedQueue<>();
```

Example

```java
queue.offer("Java");

queue.offer("Spring");

System.out.println(queue.poll());
```

Output

```text
Java
```

Uses **CAS** instead of locks.

---

# 5. ConcurrentLinkedDeque

Double-ended version of `ConcurrentLinkedQueue`.

Can insert/remove from:

- Front
- Back

---

# 6. BlockingQueue

A queue where producers and consumers automatically wait when necessary.

Example

```java
BlockingQueue<Integer> queue =
new LinkedBlockingQueue<>();
```

---

# Producer Example

```java
queue.put(100);
```

If full,

Producer waits.

---

# Consumer Example

```java
int value = queue.take();
```

If empty,

Consumer waits.

---

# Producer-Consumer Diagram

```text
Producer

↓

BlockingQueue

↓

Consumer
```

Very common in multithreaded systems.

---

# 7. LinkedBlockingQueue

```java
BlockingQueue<String> queue =
new LinkedBlockingQueue<>();
```

Features:

- Optional capacity
- Producer-Consumer pattern
- Thread-safe

---

# 8. ArrayBlockingQueue

```java
BlockingQueue<String> queue =
new ArrayBlockingQueue<>(10);
```

Features:

- Fixed capacity
- Uses an array internally
- Thread-safe

---

# 9. PriorityBlockingQueue

Tasks are ordered by priority.

Example

```java
PriorityBlockingQueue<Integer> queue =
new PriorityBlockingQueue<>();
```

Output order

```text
1

2

3

5

10
```

---

# 10. DelayQueue

Stores elements until their delay expires.

Used for:

- Scheduled tasks
- Cache expiration
- Retry mechanisms

---

# 11. ConcurrentSkipListMap

Thread-safe sorted map.

```java
ConcurrentSkipListMap<Integer,String> map =
new ConcurrentSkipListMap<>();
```

Keys remain sorted automatically.

---

# 12. ConcurrentSkipListSet

Thread-safe sorted set.

```java
ConcurrentSkipListSet<Integer> set =
new ConcurrentSkipListSet<>();
```

---

# ConcurrentHashMap vs HashMap

| HashMap | ConcurrentHashMap |
|----------|-------------------|
| Not thread-safe | Thread-safe |
| Allows null key/value | Does not allow null key/value |
| Faster in single-threaded code | Better for concurrent access |
| Can become corrupted under concurrent modification | Safe for concurrent access |

---

# ConcurrentHashMap vs synchronizedMap

| synchronizedMap | ConcurrentHashMap |
|-----------------|-------------------|
| One global lock | Fine-grained synchronization/CAS |
| Lower concurrency | Higher concurrency |
| Slower under heavy load | Better scalability |

---

# CopyOnWriteArrayList vs ArrayList

| ArrayList | CopyOnWriteArrayList |
|------------|----------------------|
| Not thread-safe | Thread-safe |
| Fast writes | Expensive writes |
| Best for normal use | Best for many reads, few writes |

---

# Production Usage

Concurrent Collections are used in:

- Spring Boot applications
- Banking systems
- Payment gateways
- Web servers
- Caching
- Thread pools
- Logging
- Producer-Consumer systems
- Task schedulers
- Message processing

Example:

A banking server stores active user sessions in a `ConcurrentHashMap`.

Thousands of request threads can safely access and update session information simultaneously.

---

# Advantages

- Thread-safe
- High performance
- Better scalability
- Reduced locking
- Suitable for enterprise applications

---

# Disadvantages

- Slightly more complex than normal collections
- Some implementations (like `CopyOnWriteArrayList`) are inefficient for frequent writes
- Higher memory usage in some cases

---

# Best Practices

✅ Use `ConcurrentHashMap` instead of `Hashtable`.

✅ Use `CopyOnWriteArrayList` only when reads greatly outnumber writes.

✅ Use `BlockingQueue` for Producer-Consumer problems.

✅ Choose the collection based on the workload.

---

# Common Mistakes

❌ Using `HashMap` in multithreaded code.

❌ Using `CopyOnWriteArrayList` when writes are frequent.

❌ Assuming every concurrent collection uses locks (many use CAS or other lock-free techniques).

❌ Using `ConcurrentHashMap` when a simple `HashMap` is sufficient in single-threaded code.

---

# Interview Questions

### 1. What are Concurrent Collections?

Thread-safe collection classes designed for high-performance multithreaded applications.

---

### 2. Why use Concurrent Collections instead of normal collections?

Because normal collections are generally not thread-safe and can become inconsistent when accessed by multiple threads.

---

### 3. What is `ConcurrentHashMap`?

A high-performance, thread-safe implementation of `Map`.

---

### 4. Does `ConcurrentHashMap` allow null keys?

No.

It does not allow `null` keys or `null` values.

---

### 5. What is `CopyOnWriteArrayList`?

A thread-safe list that creates a new copy of its internal array whenever it is modified.

---

### 6. When should you use `CopyOnWriteArrayList`?

When reads are frequent and writes are rare.

---

### 7. What is `BlockingQueue`?

A thread-safe queue where producers wait if the queue is full and consumers wait if the queue is empty.

---

### 8. Difference between `HashMap` and `ConcurrentHashMap`?

`HashMap` is not thread-safe.

`ConcurrentHashMap` is thread-safe and optimized for concurrent access.

---

### 9. Does `ConcurrentHashMap` lock the entire map?

No.

Modern implementations use finer-grained synchronization and CAS, allowing better concurrency than a single global lock.

---

### 10. Are Concurrent Collections used in Spring Boot?

Yes.

They are widely used for:

- Shared caches
- Session management
- Background task processing
- Request handling
- Thread-safe shared data structures

---

# Quick Revision

- Concurrent Collections are in `java.util.concurrent`.
- Designed for multithreaded applications.
- `ConcurrentHashMap` = thread-safe map.
- `CopyOnWriteArrayList` = best for many reads and few writes.
- `BlockingQueue` = Producer-Consumer communication.
- `ConcurrentLinkedQueue` = non-blocking FIFO queue.
- `ConcurrentSkipListMap` = sorted concurrent map.
- Prefer concurrent collections over `Collections.synchronizedXXX()` for high concurrency.
- Many concurrent collections use CAS and fine-grained synchronization.

---

# Keywords

- Concurrent Collections
- ConcurrentHashMap
- CopyOnWriteArrayList
- CopyOnWriteArraySet
- ConcurrentLinkedQueue
- ConcurrentLinkedDeque
- BlockingQueue
- LinkedBlockingQueue
- ArrayBlockingQueue
- PriorityBlockingQueue
- DelayQueue
- ConcurrentSkipListMap
- ConcurrentSkipListSet
- CAS (Compare-And-Swap)
- Thread Safety
- Producer-Consumer
- java.util.concurrent