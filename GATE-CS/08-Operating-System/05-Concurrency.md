# `05-Concurrency.md`

# Concurrency — GATE CSE 2027

## 1. What is Concurrency?

**Concurrency** means multiple processes/threads make progress during overlapping time periods.

> Concurrency ≠ necessarily simultaneous execution.

Example on a **single CPU**:

```text
Time →
P1 → P2 → P1 → P2 → P1
```

Only one executes at an instant, but both make progress.

On a **multicore CPU**:

```text
CPU 1 → P1 ─────────
CPU 2 → P2 ─────────
```

They can execute **simultaneously**.

---

# 2. Concurrency vs Parallelism ⭐⭐⭐⭐⭐

| Concurrency                       | Parallelism                            |
| --------------------------------- | -------------------------------------- |
| Multiple tasks make progress      | Multiple tasks execute simultaneously  |
| Possible on single CPU            | Requires multiple execution units      |
| About dealing with multiple tasks | About executing multiple tasks at once |

### 🔥 GATE Trick

$$
\boxed{\text{Parallelism} \Rightarrow \text{Concurrency}}
$$

but:

$$
\boxed{\text{Concurrency} \not\Rightarrow \text{Parallelism}}
$$

---

# 3. Why Concurrency?

Suppose two processes access shared data:

```text
P1 ──┐
     ↓
   Shared X
     ↑
P2 ──┘
```

If both modify `X` simultaneously/interleaved, the final result can depend on the execution order.

This creates:

> **Race condition**

Therefore, concurrency requires proper synchronization when shared state is involved.

---

# 4. Race Condition ⭐⭐⭐⭐⭐

A **race condition** occurs when the correctness of a program depends on the relative timing/order of concurrent operations.

Example:

```c id="g2tqwt"
x = x + 1;
```

This looks like one operation but may involve:

```text id="m3u4m7"
READ x
ADD 1
WRITE x
```

Suppose:

```text id="5x8j0p"
Initially x = 5

P1: READ x → 5
P2: READ x → 5
P1: WRITE x → 6
P2: WRITE x → 6
```

Final:

$$
\boxed{x=6}
$$

Expected if both increments were preserved:

$$
\boxed{x=7}
$$

This is a **lost update**.

---

# 5. Critical Section ⭐⭐⭐⭐⭐

A **critical section** is the part of a process/thread that accesses shared resources and must not be executed by multiple competing processes at the same time when mutual exclusion is required.

Example:

```c id="p4d3qn"
lock();

x = x + 1;   // critical section

unlock();
```

Conceptually:

```text id="y0td3k"
Entry Section
      ↓
Critical Section
      ↓
Exit Section
      ↓
Remainder Section
```

---

# 6. Structure of a Process

A process that uses a critical section can be viewed as:

```text id="y2atn3"
while (true) {

    Entry Section
         ↓
    Critical Section
         ↓
    Exit Section
         ↓
    Remainder Section
}
```

### Entry section

Requests permission to enter the critical section.

### Critical section

Accesses shared resource.

### Exit section

Releases permission.

### Remainder section

Everything outside the critical section.

---

# 7. Critical-Section Problem

A correct solution to the critical-section problem should satisfy three requirements:

$$
\boxed{\text{Mutual Exclusion}}
$$

$$
\boxed{\text{Progress}}
$$

$$
\boxed{\text{Bounded Waiting}}
$$

These are **extremely important for GATE**.

---

# 8. Mutual Exclusion ⭐⭐⭐⭐⭐

At most **one** process can execute the critical section at a time.

```text id="8x8k4h"
P1 → CS
P2 → waiting
P3 → waiting
```

### 🔥 Shortcut

> **Mutual exclusion = only one inside CS.**

---

# 9. Progress ⭐⭐⭐⭐⭐

If:

* no process is currently in the critical section, and
* some processes want to enter,

then selection of the next process cannot be postponed indefinitely.

In other words:

> If the CS is free, competing processes should not be unnecessarily prevented from entering.

---

# 10. Bounded Waiting ⭐⭐⭐⭐⭐

There must be a bound on how many times other processes can enter the critical section after a process has requested entry.

This prevents **starvation**.

### Example

```text id="q2x4t7"
P1 requests CS
   ↓
P2 enters
P3 enters
P2 enters
P3 enters
P2 enters
...
```

If P1 can wait forever:

```text id="7u6h7j"
P1 → STARVATION
```

Bounded waiting prevents this indefinite postponement.

---

# 11. Mutual Exclusion vs Bounded Waiting

| Property         | Meaning                                            |
| ---------------- | -------------------------------------------------- |
| Mutual exclusion | At most one process in CS                          |
| Progress         | Someone should be allowed to enter when CS is free |
| Bounded waiting  | A requesting process won't wait forever            |

### 🔥 GATE Trap

> Mutual exclusion alone does **not** guarantee absence of starvation.

---

# 12. Starvation ⭐⭐⭐⭐⭐

**Starvation** occurs when a process waits indefinitely because other processes repeatedly get the required resource/CPU.

Example:

```text id="31i1h3"
P1 waits
P2 enters
P3 enters
P2 enters
P3 enters
...
P1 never enters
```

$$
\boxed{\text{Starvation = indefinite waiting}}
$$

---

# 13. Deadlock vs Starvation

Very important distinction.

### Deadlock

Processes are stuck waiting for each other/resources.

```text id="r2mt3e"
P1 waits for P2
P2 waits for P1
```

Neither progresses.

### Starvation

One process may wait indefinitely while **other processes continue progressing**.

```text id="7xj5pd"
P1 → waits forever
P2 → keeps executing
P3 → keeps executing
```

| Deadlock                                                | Starvation                            |
| ------------------------------------------------------- | ------------------------------------- |
| System/processes stuck due to circular/resource waiting | One process indefinitely denied       |
| Other involved processes may also stop                  | Others can continue                   |
| Circular wait often involved                            | Unfair scheduling/resource allocation |

---

# 14. Busy Waiting ⭐⭐⭐⭐⭐

A process repeatedly checks whether a resource is available instead of blocking.

Example:

```c id="0qf5jh"
while(lock == 1)
    ;   // keep checking
```

CPU continues executing the waiting process.

This is:

$$
\boxed{\text{Busy Waiting}}
$$

---

# 15. Spinlock

A **spinlock** is a lock where a thread/process repeatedly checks the lock until it becomes available.

```text id="s3f6g2"
while(lock is unavailable)
       spin

enter CS
```

### Advantage

Useful when the expected wait is **very short**, especially on multiprocessor systems.

### Disadvantage

Consumes CPU while waiting.

### 🔥 GATE Trick

```text id="k0q6p3"
Spinlock → busy waiting
Mutex/blocking lock → process may sleep
```

---

# 16. Atomic Operation ⭐⭐⭐⭐⭐

An operation is **atomic** if it appears indivisible:

> It either happens completely or does not happen at all, with no observable intermediate state.

Examples of hardware-supported atomic primitives:

```text id="cplb7f"
Test-and-Set
Compare-and-Swap
Swap
```

These are commonly used to implement synchronization mechanisms.

---

# 17. Test-and-Set

Conceptually:

```c id="r6k3g5"
boolean TestAndSet(boolean *lock) {
    boolean old = *lock;
    *lock = true;
    return old;
}
```

The important requirement is:

$$
\boxed{\text{Test + Set must be atomic}}
$$

Otherwise two processes could both observe the lock as free.

---

# 18. Simple Spinlock Using Test-and-Set

Conceptually:

```c id="y8v6z1"
while (TestAndSet(&lock))
    ;       // spin

// Critical Section

lock = false;
```

If:

```text id="kjh4d1"
lock = false
```

one process successfully changes it to true and enters.

Another process finds:

```text id="t3k4xy"
lock = true
```

and spins.

---

# 19. Compare-and-Swap (CAS)

CAS atomically performs:

```text id="w1x3q7"
if memory == expected
    memory = new_value
```

Otherwise it does not modify the memory.

CAS is widely used for implementing:

* locks
* lock-free data structures
* atomic synchronization

### GATE concept

> Hardware atomic instructions are building blocks for synchronization.

---

# 20. Peterson's Solution ⭐⭐⭐⭐⭐

Peterson's algorithm is a classical **software solution to the critical-section problem for two processes**.

It uses:

```text id="1ok2op"
flag[2]
turn
```

Conceptually:

```text id="huj4a6"
flag[i] = true
turn = j

while(flag[j] && turn == j)
    wait
```

### Properties

Peterson's solution satisfies:

* Mutual exclusion
* Progress
* Bounded waiting

### 🔥 GATE Trap

> Peterson's original classical solution is for **two processes**.

---

# 21. Semaphore ⭐⭐⭐⭐⭐

A semaphore is a synchronization primitive accessed through atomic operations such as:

```text id="rj9l4y"
wait()
signal()
```

Also called:

```text id="a4lqv1"
P()
V()
```

---

# 22. Wait and Signal

### wait(S)

Conceptually:

```text id="zv6n9r"
wait(S):
    while S <= 0
        wait
    S--
```

### signal(S)

```text id="ck7b7p"
signal(S):
    S++
```

Actual OS implementations generally avoid inefficient pure busy-waiting for blocking semaphores.

---

# 23. Binary Semaphore

A binary semaphore has values:

$$
\boxed{0 \text{ or } 1}
$$

Often used for mutual exclusion.

```text id="f0x4ys"
1 → available
0 → unavailable
```

---

# 24. Counting Semaphore

A counting semaphore can represent multiple identical resources.

Example:

```text id="4j8m2k"
5 printers
```

Initialize:

$$
S=5
$$

Each allocation:

$$
S=S-1
$$

Each release:

$$
S=S+1
$$

---

# 25. Semaphore Example

Suppose:

```text id="jtr4hp"
Semaphore S = 1
```

Two processes:

```text id="l0h6x1"
P1 → wait(S)
P1 → CS
P2 → wait(S) → BLOCK
P1 → signal(S)
P2 → CS
```

Thus mutual exclusion is achieved.

---

# 26. Semaphore vs Mutex

| Semaphore                                       | Mutex                                          |
| ----------------------------------------------- | ---------------------------------------------- |
| Synchronization primitive                       | Mutual-exclusion lock                          |
| Can be counting                                 | Usually binary/ownership-based                 |
| May represent multiple resources                | Usually protects one critical section/resource |
| Ownership semantics not inherent in a semaphore | Typically owner must unlock                    |

### GATE shortcut

```text id="c5xqv4"
Mutex → ownership + mutual exclusion
Semaphore → signaling/counting + synchronization
```

---

# 27. Race Condition vs Critical Section

These are related but different.

### Critical section

The **code region** accessing shared data.

### Race condition

The **incorrect behavior** resulting from uncontrolled concurrent access.

```text id="8b4d0s"
Shared data
    ↓
Critical section
    ↓
No synchronization
    ↓
Race condition
```

---

# 28. Producer-Consumer Problem ⭐⭐⭐⭐⭐

Classic synchronization problem.

```text id="5k6m9y"
Producer
   ↓
[ Buffer ]
   ↓
Consumer
```

Producer adds items.

Consumer removes items.

Need to ensure:

```text id="7r0rj9"
Producer → doesn't insert into FULL buffer
Consumer → doesn't remove from EMPTY buffer
```

---

# 29. Standard Semaphore Solution

For buffer size `N`:

```text id="3g7v1q"
mutex = 1
empty = N
full = 0
```

### Producer

```text id="b9c5z7"
wait(empty)
wait(mutex)

insert item

signal(mutex)
signal(full)
```

### Consumer

```text id="k4z6yp"
wait(full)
wait(mutex)

remove item

signal(mutex)
signal(empty)
```

### 🔥 GATE Trap

The **order** matters.

For producer:

```text id="2j3x5k"
wait(empty)
wait(mutex)
```

not:

```text id="q0x7v2"
wait(mutex)
wait(empty)
```

in the standard solution, because holding `mutex` while waiting for an empty slot can lead to deadlock.

---

# 30. Readers-Writers Problem ⭐⭐⭐⭐

Shared database:

```text id="4c7y2h"
Readers → can read
Writer  → modifies
```

Typical requirement:

* multiple readers can read simultaneously
* writer needs exclusive access

```text id="z0v5n8"
R1 ─┐
R2 ─┼──→ Database
R3 ─┘

W  → exclusive
```

### Important

```text
Reader + Reader → allowed
Reader + Writer → conflict
Writer + Writer → conflict
```

This resembles the shared/exclusive locking idea from DBMS.

---

# 31. Dining Philosophers ⭐⭐⭐⭐

Five philosophers:

```text id="l8x2f6"
 P   P
  \ /
   P
  / \
 P   P
```

Each needs two forks to eat.

Poor synchronization can produce:

> **Deadlock**

Example:

```text id="u5t7p3"
Everyone picks left fork
        ↓
Everyone waits for right fork
        ↓
DEADLOCK
```

---

# 32. GATE PYQ Pattern — Critical Section

Typical question:

> Which conditions must a correct solution to the critical-section problem satisfy?

Answer:

$$
\boxed{\text{Mutual Exclusion + Progress + Bounded Waiting}}
$$

### Must memorize

```text id="2v8v8y"
ME → one at a time
Progress → don't unnecessarily delay entry
Bounded waiting → no indefinite waiting
```

---

# 33. GATE PYQ Pattern — Race Condition

Typical question:

> Two processes access and update a shared variable, and the result depends on their execution order. What is this?

$$
\boxed{\text{Race Condition}}
$$

---

# 34. GATE PYQ Pattern — Busy Waiting

Question:

> A process repeatedly checks a lock without yielding the CPU. What is this?

$$
\boxed{\text{Busy Waiting}}
$$

If the mechanism is a lock specifically designed for this:

$$
\boxed{\text{Spinlock}}
$$

---

# 35. GATE PYQ Pattern — Semaphore

Suppose:

$$
S=3
$$

Three successful `wait(S)` operations occur.

Then:

$$
3\rightarrow2\rightarrow1\rightarrow0
$$

A fourth `wait(S)` cannot proceed until a `signal(S)` occurs.

### 🔥 Numerical trick

For a counting semaphore:

$$
\boxed{S_{\text{final}}=S_{\text{initial}}+\#signal-\#successful\ wait}
$$

But if a `wait()` blocks, don't blindly count it as a successful decrement.

---

# 36. GATE PYQ Pattern — Producer Consumer

Given:

```text id="3z0o8h"
empty = N
full = 0
mutex = 1
```

Remember:

```text id="4v8g8x"
Producer:
empty ↓
full   ↑

Consumer:
full   ↓
empty  ↑
```

And:

```text id="j5x8m3"
mutex → protects buffer
```

---

# 37. 🔥 GATE Traps

1. **Concurrency does not necessarily mean parallel execution.**
2. Race condition requires uncontrolled concurrent access to shared state.
3. Critical section is a **code region**, not a synchronization primitive.
4. Mutual exclusion alone does not guarantee progress/bounded waiting.
5. Starvation ≠ deadlock.
6. Spinlock causes busy waiting.
7. Peterson's classical solution is for two processes.
8. Semaphore operations must be atomic.
9. Binary semaphore is not identical in all semantics to a mutex.
10. In producer-consumer, `mutex` protects the buffer; `empty/full` track resource availability.
11. Holding a mutex while waiting for another resource can create deadlock.
12. On a single CPU, concurrency can exist without parallelism.

---

# 🎯 GATE Priority

| Topic                         | Priority |
| ----------------------------- | -------: |
| Critical-section requirements |    ⭐⭐⭐⭐⭐ |
| Race conditions               |    ⭐⭐⭐⭐⭐ |
| Semaphore                     |    ⭐⭐⭐⭐⭐ |
| Producer-consumer             |    ⭐⭐⭐⭐⭐ |
| Peterson's solution           |    ⭐⭐⭐⭐⭐ |
| Busy waiting / spinlocks      |     ⭐⭐⭐⭐ |
| Concurrency vs parallelism    |     ⭐⭐⭐⭐ |
| Readers-writers               |     ⭐⭐⭐⭐ |
| Dining philosophers           |     ⭐⭐⭐⭐ |
| Atomic instructions           |     ⭐⭐⭐⭐ |
| Starvation vs deadlock        |    ⭐⭐⭐⭐⭐ |

---

# 🧠 GATE Mental Model

Whenever you see a concurrency problem:

```text id="8y0lq4"
Shared Resource?
      ↓
Yes
      ↓
Critical Section
      ↓
Need synchronization
      ↓
┌───────────────┐
│ Mutex         │ → mutual exclusion
│ Semaphore     │ → synchronization/counting
│ Peterson      │ → 2-process software solution
│ Test-and-Set  │ → atomic hardware primitive
│ CAS           │ → atomic hardware primitive
└───────────────┘
```

Then check:

```text id="2k5y9r"
Mutual exclusion?
Progress?
Bounded waiting?
Deadlock?
Starvation?
Busy waiting?
```

---

# ⚡ 30-Second Revision

```text id="n4y5jk"
Concurrency:
→ multiple tasks make overlapping progress

Parallelism:
→ actually execute simultaneously

Race condition:
→ result depends on execution order

Critical section:
→ code accessing shared resource

Correct CS solution:
→ Mutual Exclusion
→ Progress
→ Bounded Waiting

Starvation:
→ process waits indefinitely while others progress

Deadlock:
→ processes stuck waiting for each other/resources

Busy waiting:
→ repeatedly checking instead of blocking

Spinlock:
→ lock + busy waiting

Semaphore:
→ wait(P) + signal(V)

Binary semaphore:
→ 0/1

Counting semaphore:
→ multiple resources

Peterson:
→ classical 2-process software solution

Producer-Consumer:
mutex = 1
empty = N
full = 0

Producer:
wait(empty)
wait(mutex)
insert
signal(mutex)
signal(full)

Consumer:
wait(full)
wait(mutex)
remove
signal(mutex)
signal(empty)
```

### ⭐ GATE Priority: **5/5**

**The highest-yield chain to master is:**

$$
\boxed{\text{Race Condition → Critical Section → Semaphore → Producer/Consumer → Deadlock}}
$$

➡️ **Next: `06-Synchronization.md`**
