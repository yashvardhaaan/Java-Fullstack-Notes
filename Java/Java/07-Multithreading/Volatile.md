# volatile Keyword (Java)

## What is `volatile`?

`volatile` is a **Java keyword** that ensures **changes made to a variable by one thread are immediately visible to all other threads.**

It solves the **visibility problem** in multithreaded programming.

> **Definition:** A `volatile` variable is always read from and written to **main memory**, not from a thread's local CPU cache.

---

# Why Do We Need `volatile`?

In a multithreaded application, each thread may keep a **local copy (cache)** of variables for faster access.

This can lead to a situation where:

- Thread A updates a variable.
- Thread B still sees the old value because it is reading from its cache.

This is called the **Visibility Problem**.

`volatile` ensures every thread always sees the latest value.

---

# Real-World Example

Imagine a classroom.

Teacher writes on the **whiteboard**.

Every student has a **notebook**.

Without `volatile`:

- Teacher updates the whiteboard.
- Some students keep reading old notes from their notebook.

With `volatile`:

- Every student must check the whiteboard before reading.

```
Main Memory (Whiteboard)
          ▲
          │
Thread A  │  Thread B
   │      │      │
Reads/Writes Latest Value
```

---

# How `volatile` Works

Without `volatile`

```text
Main Memory
      │
      ▼
Thread A Cache     Thread B Cache

count = 10         count = 5
```

Thread A updates:

```java
count = 10;
```

Thread B still sees:

```java
count = 5;
```

Old value!

---

With `volatile`

```java
volatile int count;
```

Every read:

```
Thread
   │
   ▼
Main Memory
```

Every write:

```
Thread
   │
   ▼
Main Memory
```

All threads always see the latest value.

---

# Syntax

```java
volatile boolean running = true;
```

---

# Example Without `volatile`

```java
class MyTask extends Thread {

    boolean running = true;

    public void run() {
        while (running) {
            // keep working
        }
        System.out.println("Stopped");
    }

    public static void main(String[] args)
            throws Exception {

        MyTask task = new MyTask();

        task.start();

        Thread.sleep(3000);

        task.running = false;
    }
}
```

Problem:

The worker thread **may never stop**, because it might continue reading the cached value `true`.

---

# Example With `volatile`

```java
class MyTask extends Thread {

    volatile boolean running = true;

    public void run() {
        while (running) {
            // keep working
        }
        System.out.println("Stopped");
    }

    public static void main(String[] args)
            throws Exception {

        MyTask task = new MyTask();

        task.start();

        Thread.sleep(3000);

        task.running = false;
    }
}
```

Now,

The worker thread immediately sees:

```
running = false
```

and exits the loop.

---

# Internal Working

Normally,

```
Thread

↓

CPU Cache

↓

Main Memory
```

A thread may keep variables in its CPU cache.

With `volatile`

```
Thread

↓

Main Memory
```

The JVM inserts **memory barriers** around volatile reads and writes so that:

- A write is flushed to main memory before it becomes visible.
- A read fetches the latest value from main memory.

---

# What Problems Does `volatile` Solve?

## 1. Visibility Problem ✅

All threads see the latest value.

Example:

```java
volatile boolean running;
```

---

## 2. Instruction Reordering ✅

The JVM and CPU sometimes reorder instructions for performance.

`volatile` prevents certain reorderings around volatile reads and writes, helping preserve the expected execution order.

---

# What `volatile` Does NOT Solve

It **does not make compound operations atomic**.

Example:

```java
volatile int count = 0;

count++;
```

Internally:

```text
Read count

↓

Add 1

↓

Write count
```

Three separate steps.

If two threads execute them simultaneously,

the result may be incorrect.

---

# Example

Initial value:

```text
count = 5
```

Thread A:

```
Read 5
```

Thread B:

```
Read 5
```

Thread A:

```
Write 6
```

Thread B:

```
Write 6
```

Expected:

```
7
```

Actual:

```
6
```

This is called a **Race Condition**.

`volatile` **cannot prevent** this.

---

# When to Use `volatile`

Use it when:

- A variable is shared between threads.
- Only one thread writes to it, while others read it.
- Reads and writes are simple (not compound operations).

Examples:

- Stop flags
- Shutdown signals
- Configuration flags
- Status indicators
- Feature toggles

---

# When NOT to Use `volatile`

Avoid it when:

- Multiple threads modify the same variable.
- You need atomic operations.
- Multiple variables must be updated together.
- Complex synchronization is required.

Use:

- `synchronized`
- `Lock`
- `AtomicInteger`
- Other atomic classes

---

# volatile vs synchronized

| volatile | synchronized |
|-----------|--------------|
| Ensures visibility | Ensures visibility + mutual exclusion |
| No locking | Uses locking |
| No atomicity | Provides atomic execution of synchronized blocks |
| Faster | Slightly slower due to locking |
| Used for simple shared flags | Used for critical sections |

---

# volatile vs AtomicInteger

| volatile | AtomicInteger |
|-----------|---------------|
| Visibility only | Visibility + atomic operations |
| `count++` is unsafe | `incrementAndGet()` is safe |
| No CAS | Uses Compare-And-Swap (CAS) |

---

# Production Usage

`volatile` is commonly used for:

- Stop flags
- Service shutdown signals
- Cache refresh indicators
- Feature flags
- Singleton initialization (with double-checked locking)
- Background worker control

Example:

```java
volatile boolean shutdownRequested;
```

---

# Advantages

- Very fast
- Lightweight
- Ensures visibility
- Prevents certain instruction reorderings
- No explicit locking

---

# Disadvantages

- No atomicity
- Cannot prevent race conditions
- Not suitable for complex shared state

---

# Common Mistakes

❌ Assuming `volatile` makes `count++` thread-safe.

❌ Using `volatile` instead of `synchronized` for critical sections.

❌ Using `volatile` when multiple related variables must be updated together.

❌ Forgetting that `volatile` only guarantees visibility, not mutual exclusion.

---

# Interview Questions

### 1. What is `volatile`?

A Java keyword that ensures updates to a variable are immediately visible to all threads.

---

### 2. What problem does `volatile` solve?

The **visibility problem** in multithreaded programming.

---

### 3. Does `volatile` provide thread safety?

Only for **simple reads and writes**.

It does **not** make compound operations like `count++` thread-safe.

---

### 4. Does `volatile` use locks?

No.

It works through memory visibility guarantees and memory barriers, not locks.

---

### 5. Can `volatile` prevent race conditions?

No.

Race conditions involving compound operations still require synchronization or atomic classes.

---

### 6. What is the difference between `volatile` and `synchronized`?

`volatile` guarantees visibility.

`synchronized` guarantees both visibility and mutual exclusion.

---

### 7. Why is `count++` unsafe with `volatile`?

Because it consists of:

1. Read
2. Increment
3. Write

These three steps are **not atomic**.

---

### 8. When should you use `AtomicInteger` instead of `volatile`?

When multiple threads update a numeric value using operations like increment, decrement, or compare-and-set.

---

# Quick Revision

- `volatile` ensures **visibility** between threads.
- Reads and writes go through **main memory**.
- Solves the visibility problem.
- Prevents certain instruction reorderings.
- Does **not** provide atomicity.
- `count++` is **not** thread-safe with `volatile`.
- No locking is involved.
- Good for stop flags and status variables.
- Use `AtomicInteger` or `synchronized` for shared counters.

---

# Keywords

- volatile
- Visibility
- Main Memory
- CPU Cache
- Memory Barrier
- Happens-Before
- Instruction Reordering
- Race Condition
- Atomicity
- synchronized
- AtomicInteger
- CAS (Compare-And-Swap)
- Thread Safety
- Multithreading
- Concurrency