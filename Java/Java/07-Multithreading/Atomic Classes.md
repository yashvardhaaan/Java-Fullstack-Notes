# Atomic Classes (Java)

## What are Atomic Classes?

**Atomic Classes** are thread-safe classes in Java that perform **lock-free, atomic operations** on single variables.

They are part of:

```java
java.util.concurrent.atomic
```

> **Definition:** Atomic Classes provide thread-safe operations on variables without using `synchronized` or explicit locks.

---

# Why Do We Need Atomic Classes?

Suppose multiple threads are incrementing a counter.

```java
count++;
```

This looks like one operation but internally it is **three steps**:

```text
Read count

↓

Add 1

↓

Write count
```

If two threads execute these steps at the same time, updates can be lost.

Example:

```
Count = 5

Thread A reads 5
Thread B reads 5

Thread A writes 6
Thread B writes 6

Final Count = 6 ❌
Expected = 7
```

This is called a **Race Condition**.

Atomic classes solve this problem.

---

# Real-World Example

Imagine a ticket counter.

Without Atomic Classes:

```
Person A → Ticket #101

Person B → Ticket #101 ❌
```

Duplicate ticket numbers.

With Atomic Classes:

```
Person A → Ticket #101

Person B → Ticket #102 ✅
```

Every update happens safely.

---

# How Atomic Classes Work

```text
Thread A

↓

Atomic Operation

↓

Shared Variable

↑

Thread B
```

Only one atomic update succeeds at a time.

Internally, Atomic Classes use **CAS (Compare-And-Swap)** instead of locks.

---

# What is CAS (Compare-And-Swap)?

CAS is a CPU-level instruction.

It works like this:

1. Read the current value.
2. Compare it with the expected value.
3. If they match, update it.
4. Otherwise, retry.

Example:

```
Current Value = 10

Expected = 10

New Value = 11

↓

Update Successful
```

If another thread changes the value first:

```
Current = 12

Expected = 10

↓

Update Failed

↓

Retry
```

This avoids using locks in many situations.

---

# Common Atomic Classes

| Class | Purpose |
|--------|----------|
| AtomicInteger | Atomic integer |
| AtomicLong | Atomic long |
| AtomicBoolean | Atomic boolean |
| AtomicReference<T> | Atomic object reference |
| AtomicIntegerArray | Atomic integer array |
| AtomicLongArray | Atomic long array |
| AtomicReferenceArray | Atomic reference array |

---

# 1. AtomicInteger

Most commonly used atomic class.

```java
AtomicInteger count =
new AtomicInteger(0);
```

Increment:

```java
count.incrementAndGet();
```

Current value:

```java
System.out.println(count.get());
```

---

# Example

```java
import java.util.concurrent.atomic.AtomicInteger;

public class Main {

    public static void main(String[] args) {

        AtomicInteger counter =
                new AtomicInteger(0);

        counter.incrementAndGet();

        System.out.println(counter.get());

    }

}
```

Output

```text
1
```

---

# Common Methods

## get()

Returns the current value.

```java
counter.get();
```

---

## set()

Updates the value.

```java
counter.set(10);
```

---

## incrementAndGet()

Increment first, then return.

```java
counter.incrementAndGet();
```

---

## getAndIncrement()

Return current value, then increment.

```java
counter.getAndIncrement();
```

Example:

```
Current = 5

↓

getAndIncrement()

Returns → 5

Stored Value → 6
```

---

## decrementAndGet()

```java
counter.decrementAndGet();
```

---

## addAndGet()

```java
counter.addAndGet(10);
```

---

## compareAndSet()

Performs CAS.

```java
boolean success =
counter.compareAndSet(5, 6);
```

Meaning:

```
If value == 5

↓

Change to 6
```

Returns:

```
true

or

false
```

---

# AtomicBoolean

Thread-safe boolean.

```java
AtomicBoolean running =
new AtomicBoolean(true);
```

Useful for:

- Stop flags
- Status indicators
- Feature switches

---

# AtomicLong

```java
AtomicLong total =
new AtomicLong(0);
```

Used for:

- Counters
- IDs
- Statistics

---

# AtomicReference

Stores an object atomically.

```java
AtomicReference<String> name =
new AtomicReference<>("Java");
```

Update:

```java
name.set("Spring");
```

Useful when multiple threads update object references safely.

---

# Atomic Classes vs synchronized

| Atomic Classes | synchronized |
|----------------|--------------|
| Lock-free | Uses locks |
| Faster for simple operations | Slower due to locking |
| Good for single-variable updates | Good for complex critical sections |
| Uses CAS | Uses monitor locks |

---

# Atomic Classes vs volatile

| volatile | Atomic Classes |
|-----------|----------------|
| Visibility only | Visibility + Atomicity |
| No atomic increment | Atomic increment supported |
| No CAS | Uses CAS |

Example:

```java
volatile int count;

count++; // ❌ Not atomic
```

```java
AtomicInteger count =
new AtomicInteger();

count.incrementAndGet(); // ✅ Atomic
```

---

# Internal Working

```
AtomicInteger

↓

Read Current Value

↓

Compare Current Value

↓

If Same

↓

Update

↓

Else Retry
```

The retry process is handled automatically.

---

# Production Usage

Atomic Classes are used in:

- Spring Boot
- Web servers
- Thread pools
- Metrics counters
- Rate limiters
- ID generators
- Request counters
- Caching
- Monitoring systems

Example:

A web server receives thousands of requests.

```java
AtomicInteger requestCount =
new AtomicInteger();
```

Every request safely increments the counter.

---

# Advantages

- Thread-safe
- Lock-free
- High performance
- Simple API
- Excellent for counters and flags

---

# Disadvantages

- Suitable mainly for **single-variable operations**
- Cannot replace locks for complex operations involving multiple variables
- CAS retries can increase CPU usage under very high contention

---

# Best Practices

✅ Use `AtomicInteger` for shared counters.

✅ Use `AtomicBoolean` for stop flags.

✅ Use `AtomicReference` for shared object references.

✅ Use `compareAndSet()` when conditional updates are required.

---

# Common Mistakes

❌ Assuming Atomic Classes replace all synchronization.

❌ Using multiple atomic variables when one atomic operation across several variables is required.

❌ Using `volatile` instead of `AtomicInteger` for counters.

---

# Interview Questions

### 1. What are Atomic Classes?

Thread-safe classes that perform atomic operations without using explicit locks.

---

### 2. Which package contains Atomic Classes?

```java
java.util.concurrent.atomic
```

---

### 3. What is `AtomicInteger`?

A thread-safe integer that supports atomic operations like increment, decrement, and compare-and-set.

---

### 4. What is CAS?

**Compare-And-Swap** is a lock-free mechanism that compares a value with an expected value and updates it only if they match.

---

### 5. Difference between `incrementAndGet()` and `getAndIncrement()`?

| incrementAndGet() | getAndIncrement() |
|-------------------|-------------------|
| Increment first, then return | Return first, then increment |

---

### 6. Difference between `AtomicInteger` and `volatile int`?

`AtomicInteger` provides both visibility and atomic operations.

`volatile int` provides visibility only.

---

### 7. When should you use Atomic Classes?

Use them for:

- Counters
- Flags
- Sequence numbers
- Statistics
- Shared references

---

### 8. Are Atomic Classes faster than `synchronized`?

For simple single-variable operations, **yes**. They avoid locking by using CAS.

---

### 9. Can Atomic Classes replace locks completely?

No.

For operations involving multiple variables or complex critical sections, locks may still be required.

---

### 10. Are Atomic Classes used in Spring Boot?

Yes.

They are commonly used for:

- Request counters
- Metrics
- Rate limiting
- Background task coordination
- Monitoring

---

# Quick Revision

- Introduced in Java 5.
- Package: `java.util.concurrent.atomic`.
- Lock-free thread-safe classes.
- Uses **CAS (Compare-And-Swap)**.
- `AtomicInteger` → Integer counter.
- `AtomicLong` → Long counter.
- `AtomicBoolean` → Boolean flag.
- `AtomicReference` → Object reference.
- Better than `volatile` for atomic updates.
- Best for single-variable thread-safe operations.

---

# Keywords

- Atomic Classes
- AtomicInteger
- AtomicLong
- AtomicBoolean
- AtomicReference
- CAS
- Compare-And-Swap
- Lock-Free
- Thread Safety
- incrementAndGet()
- getAndIncrement()
- compareAndSet()
- java.util.concurrent.atomic
- Concurrency
- Multithreading
- Java 5