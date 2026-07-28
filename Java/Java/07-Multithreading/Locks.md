# Locks in Java

## What is a Lock?

A **Lock** is a synchronization mechanism that ensures **only one thread can access a critical section of code at a time**.

Locks prevent multiple threads from modifying shared resources simultaneously, avoiding inconsistent data and race conditions.

> **Definition:** A Lock provides explicit control over thread synchronization, allowing one thread to access shared resources while others wait.

---

# Why Do We Need Locks?

Imagine two threads updating the same bank account.

Initial Balance:

```text
₹10,000
```

Thread A:

```
Withdraw ₹2,000
```

Thread B:

```
Withdraw ₹3,000
```

Without synchronization:

```
Both threads read ₹10,000

↓

Thread A writes ₹8,000

↓

Thread B writes ₹7,000
```

Final Balance:

```
₹7,000 ❌
```

Correct Balance:

```
₹5,000 ✅
```

This problem is called a **Race Condition**.

Locks ensure only one thread updates the balance at a time.

---

# Real World Example

Imagine a washroom with only **one key**.

```
Person A

↓

Takes Key

↓

Uses Washroom

↓

Returns Key

↓

Person B Enters
```

Only the person holding the key can enter.

The **key** acts as the **Lock**.

---

# How Locks Work

```text
Thread A
    │
Acquire Lock
    │
Execute Critical Section
    │
Release Lock
    │
Thread B Acquires Lock
```

Only one thread owns the lock at any moment.

---

# What is a Critical Section?

A **Critical Section** is the part of the code where shared data is accessed or modified.

Example:

```java
balance = balance - amount;
```

If multiple threads execute this simultaneously, incorrect results may occur.

---

# Types of Locks in Java

## 1. Intrinsic Lock (Monitor Lock)

Automatically provided by the JVM using the `synchronized` keyword.

```java
synchronized(this) {
    balance--;
}
```

Features:

- Automatic lock management
- Lock released automatically
- Simple to use

---

## 2. Explicit Lock (`ReentrantLock`)

Provided by the `java.util.concurrent.locks` package.

```java
Lock lock = new ReentrantLock();
```

The programmer manually acquires and releases the lock.

---

# ReentrantLock Example

```java
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class Counter {

    private int count = 0;

    private final Lock lock = new ReentrantLock();

    public void increment() {

        lock.lock();

        try {
            count++;
        } finally {
            lock.unlock();
        }

    }
}
```

Always release the lock in a `finally` block.

---

# Why `finally`?

```java
lock.lock();

try {

    // Critical Section

} finally {

    lock.unlock();

}
```

If an exception occurs,

the lock is still released.

Otherwise,

other threads may wait forever.

---

# Internal Working

```
Thread A

↓

lock()

↓

Owns Lock

↓

Critical Section

↓

unlock()

↓

Thread B Gets Lock
```

If another thread tries to acquire the lock:

```
Thread B

↓

Waits

↓

Lock Released

↓

Continues
```

---

# ReentrantLock Features

## 1. Reentrant

The same thread can acquire the lock multiple times.

```java
lock.lock();

lock.lock();

...

lock.unlock();

lock.unlock();
```

Each `lock()` call must have a matching `unlock()`.

---

## 2. tryLock()

Attempts to acquire the lock immediately.

```java
if (lock.tryLock()) {

    try {
        System.out.println("Lock Acquired");
    } finally {
        lock.unlock();
    }

}
```

If the lock isn't available,

it returns `false` instead of waiting.

---

## 3. lockInterruptibly()

Allows a waiting thread to be interrupted.

```java
lock.lockInterruptibly();
```

Useful when a thread should not wait forever.

---

## 4. Fair Lock

```java
Lock lock = new ReentrantLock(true);
```

Threads acquire the lock in roughly the order they requested it (FIFO), reducing starvation.

---

# synchronized vs ReentrantLock

| synchronized | ReentrantLock |
|--------------|---------------|
| Keyword | Class |
| Lock released automatically | Must call `unlock()` manually |
| Simpler | More flexible |
| No `tryLock()` | Supports `tryLock()` |
| No interruptible locking | Supports `lockInterruptibly()` |
| No fairness option | Can create fair locks |

---

# Lock vs volatile

| Lock | volatile |
|------|----------|
| Mutual exclusion | Visibility only |
| Prevents race conditions | Does not prevent race conditions |
| One thread at a time | Multiple threads can read/write |
| Supports atomic critical sections | Only safe for simple reads/writes |

---

# Common Lock Methods

## lock()

Acquires the lock.

```java
lock.lock();
```

---

## unlock()

Releases the lock.

```java
lock.unlock();
```

---

## tryLock()

Attempts to acquire the lock.

```java
lock.tryLock();
```

Returns:

```text
true

or

false
```

---

## lockInterruptibly()

Allows interruption while waiting.

```java
lock.lockInterruptibly();
```

---

# Production Usage

Locks are commonly used in:

- Banking systems
- Payment gateways
- Inventory management
- Order processing
- File writing
- Shared caches
- Logging systems
- Multi-threaded backend services

Example:

Two users try to purchase the **last movie ticket** simultaneously.

A lock ensures:

```
User A

↓

Books Ticket

↓

Lock Released

↓

User B

↓

"No Tickets Available"
```

This prevents double booking.

---

# Advantages

- Prevents race conditions
- Gives explicit synchronization control
- Supports fairness
- Supports interruptible locking
- Supports timed lock attempts
- Better flexibility than `synchronized`

---

# Disadvantages

- Easy to forget `unlock()`
- Can cause deadlocks if multiple locks are acquired in the wrong order
- Slightly more complex than `synchronized`

---

# Best Practices

✅ Always release the lock in a `finally` block.

✅ Keep the critical section as small as possible.

✅ Avoid holding locks during long-running operations.

✅ Use `tryLock()` when indefinite waiting is undesirable.

✅ Prefer `synchronized` for simple cases and `ReentrantLock` when advanced features are needed.

---

# Common Mistakes

❌ Forgetting to call `unlock()`.

❌ Calling `unlock()` without owning the lock.

❌ Holding locks longer than necessary.

❌ Acquiring multiple locks in different orders, causing deadlocks.

❌ Using a lock when `volatile` is sufficient for a simple status flag.

---

# Interview Questions

### 1. What is a Lock?

A Lock is a synchronization mechanism that allows only one thread to execute a critical section at a time.

---

### 2. Why do we use Locks?

To prevent race conditions and protect shared resources in multithreaded applications.

---

### 3. What is `ReentrantLock`?

`ReentrantLock` is an explicit lock implementation that provides features like `tryLock()`, fairness, and interruptible locking.

---

### 4. Why is it called "Reentrant"?

Because the same thread can acquire the same lock multiple times without blocking itself.

---

### 5. Why should `unlock()` be called in a `finally` block?

To ensure the lock is released even if an exception occurs, preventing threads from waiting forever.

---

### 6. What is the difference between `synchronized` and `ReentrantLock`?

`ReentrantLock` provides advanced features like `tryLock()`, fairness, and interruptible locking, while `synchronized` is simpler and automatically releases the lock.

---

### 7. What is `tryLock()`?

It attempts to acquire a lock immediately and returns `true` if successful or `false` if the lock is already held.

---

### 8. Can Locks prevent race conditions?

Yes.

Locks ensure that only one thread enters the critical section at a time.

---

### 9. What is a deadlock?

A deadlock occurs when two or more threads wait indefinitely for each other to release locks.

---

### 10. When should you use `ReentrantLock` instead of `synchronized`?

Use `ReentrantLock` when you need:

- `tryLock()`
- Fair locking
- Interruptible locking
- More explicit control over lock management

---

# Quick Revision

- Lock = Only one thread enters the critical section.
- Prevents race conditions.
- `synchronized` uses intrinsic (monitor) locks.
- `ReentrantLock` provides advanced locking features.
- Always call `unlock()` in a `finally` block.
- `tryLock()` avoids waiting indefinitely.
- Fair locks reduce starvation.
- Locks provide mutual exclusion; `volatile` provides visibility only.
- Improper lock usage can lead to deadlocks.

---

# Keywords

- Lock
- ReentrantLock
- synchronized
- Monitor Lock
- Critical Section
- Race Condition
- Mutual Exclusion
- tryLock()
- lockInterruptibly()
- Fair Lock
- unlock()
- Deadlock
- Thread Safety
- Concurrency
- Multithreading
- java.util.concurrent.locks