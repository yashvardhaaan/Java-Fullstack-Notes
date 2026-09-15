# `06-Synchronization.md`

# Process Synchronization — GATE CSE 2027

## 1. What is Synchronization?

**Process synchronization** coordinates concurrent processes/threads so that shared data remains **consistent and correct**.

> If concurrent processes access shared data, synchronization controls **who can access what, and when**.

---

# 2. Why Synchronization?

Consider:

```c
counter++;
```

It may actually be:

```text
READ counter
ADD 1
WRITE counter
```

Suppose initially:

$$
counter=10
$$

Two threads execute `counter++`:

```text
T1: READ → 10
T2: READ → 10
T1: WRITE → 11
T2: WRITE → 11
```

Expected:

$$
12
$$

Actual:

$$
\boxed{11}
$$

This is a **race condition**.

Synchronization prevents such incorrect interleavings.

---

# 3. Critical Section ⭐⭐⭐⭐⭐

A critical section is the part of a program where shared data/resource is accessed.

```text
Entry Section
      ↓
Critical Section
      ↓
Exit Section
      ↓
Remainder Section
```

The synchronization mechanism controls entry into the critical section.

---

# 4. Three Requirements ⭐⭐⭐⭐⭐

A correct critical-section solution must satisfy:

### 1. Mutual Exclusion

Only one process can execute the critical section at a time.

$$
\boxed{\leq 1\text{ process inside CS}}
$$

### 2. Progress

If the critical section is free and processes want to enter, selection cannot be postponed indefinitely.

### 3. Bounded Waiting

A process requesting entry must have a finite bound on how long it can be postponed.

### 🔥 GATE Shortcut

```text
ME → One at a time
Progress → Someone can enter
Bounded → Nobody waits forever
```

---

# 5. Mutex ⭐⭐⭐⭐⭐

A **mutex** (mutual exclusion lock) allows only one thread/process to own a protected critical section at a time.

```text
lock(mutex)

Critical Section

unlock(mutex)
```

Conceptually:

```text
Unlocked → lock() → Locked
Locked   → unlock() → Unlocked
```

---

# 6. Mutex Example

```c
lock(mutex);

balance = balance + 100;

unlock(mutex);
```

If T1 has the mutex:

```text
T1 → CS
T2 → waits
T3 → waits
```

After T1 unlocks:

```text
T2 → may acquire
```

---

# 7. Semaphore ⭐⭐⭐⭐⭐

Semaphore is a synchronization primitive accessed using atomic:

```text
wait()
signal()
```

or:

```text
P()
V()
```

### `wait(S)`

Decreases the semaphore when the resource is available.

### `signal(S)`

Increases/releases the semaphore.

---

# 8. Binary Semaphore

A binary semaphore has:

$$
\boxed{S\in\{0,1\}}
$$

Commonly used to provide mutual exclusion.

```text
S = 1 → available
S = 0 → unavailable
```

---

# 9. Counting Semaphore

Can represent multiple identical resources.

Example:

```text
4 printers
```

Initialize:

$$
S=4
$$

After three successful waits:

$$
4\rightarrow3\rightarrow2\rightarrow1
$$

One more:

$$
1\rightarrow0
$$

A further `wait()` must wait until a resource is released.

---

# 10. Mutex vs Binary Semaphore ⭐⭐⭐⭐⭐

They can both enforce mutual exclusion, but their semantics differ.

| Mutex                         | Binary Semaphore                                        |
| ----------------------------- | ------------------------------------------------------- |
| Designed for mutual exclusion | General synchronization                                 |
| Usually has ownership         | No inherent ownership requirement                       |
| Owner normally unlocks        | `signal()` need not be performed by same process/thread |
| Usually 0/1                   | 0/1                                                     |
| Protects critical section     | Can also signal events                                  |

### 🔥 GATE Trap

> **Binary semaphore = mutex in every respect**

❌ False.

They may both provide mutual exclusion, but their semantics are different.

---

# 11. Spinlock ⭐⭐⭐⭐

A spinlock uses **busy waiting**.

```c
while(lock == busy)
    ;   // spin
```

The thread continuously checks the lock.

### Good when:

* expected wait is extremely short
* multicore system
* sleeping/waking overhead would be larger than waiting

### Bad when:

* wait is long
* CPU is scarce
* single CPU with no useful progress possible

---

# 12. Blocking Synchronization

Instead of continuously checking:

```text
Process → BLOCKED
```

When resource becomes available:

```text
BLOCKED → READY
```

### Comparison

| Busy waiting           | Blocking                    |
| ---------------------- | --------------------------- |
| CPU repeatedly checks  | Process sleeps/blocks       |
| Wastes CPU during wait | CPU can run another process |
| Spinlock               | Semaphore/mutex may block   |

---

# 13. Atomicity ⭐⭐⭐⭐⭐

Synchronization primitives rely on **atomic operations**.

An atomic operation appears indivisible.

Examples:

```text
Test-and-Set
Compare-and-Swap
Swap
Fetch-and-Add
```

Without atomicity:

```text
T1 checks lock
T2 checks lock
T1 acquires
T2 acquires
```

→ mutual exclusion fails.

---

# 14. Test-and-Set

Conceptually:

```c
while (TestAndSet(&lock))
    ;
```

`TestAndSet` must execute atomically.

It:

1. reads old value
2. sets lock
3. returns old value

If old value was:

```text
0 → acquired
1 → continue spinning
```

---

# 15. Compare-and-Swap (CAS)

CAS conceptually performs:

```text
if (*X == expected)
    *X = new_value;
```

as one atomic operation.

Example:

```text
CAS(X, 0, 1)
```

means:

> If X is 0, change it to 1 atomically.

Useful for implementing locks and lock-free algorithms.

---

# 16. Peterson's Algorithm ⭐⭐⭐⭐⭐

Classical software solution for **two processes**.

Uses:

```text
flag[2]
turn
```

For process `Pi`:

```text
flag[i] = true;
turn = j;

while(flag[j] && turn == j)
    ;
```

It provides:

$$
\boxed{\text{Mutual Exclusion}}
$$

$$
\boxed{\text{Progress}}
$$

$$
\boxed{\text{Bounded Waiting}}
$$

### 🔥 GATE Trap

Peterson's classical algorithm:

$$
\boxed{\text{2 processes only}}
$$

---

# 17. Semaphore and Critical Section

Suppose:

```text
S = 1
```

Process P1:

```text
wait(S)
CS
signal(S)
```

Process P2:

```text
wait(S)
CS
signal(S)
```

Possible execution:

```text
P1: wait(S) → S=0
P1: CS

P2: wait(S) → BLOCK

P1: signal(S)
P2: CS
```

Thus only one enters the CS.

---

# 18. Ordering of Semaphore Operations ⭐⭐⭐⭐⭐

This is a **major GATE numerical/conceptual area**.

For producer-consumer:

```text
empty = N
full = 0
mutex = 1
```

### Producer

```text
wait(empty)
wait(mutex)

insert()

signal(mutex)
signal(full)
```

### Consumer

```text
wait(full)
wait(mutex)

remove()

signal(mutex)
signal(empty)
```

### Why?

`empty`/`full` control buffer availability.

`mutex` protects the buffer itself.

---

# 19. Producer-Consumer Example

Buffer capacity:

$$
N=3
$$

Initially:

```text
empty = 3
full = 0
```

One producer inserts:

```text
empty = 2
full = 1
```

Another:

```text
empty = 1
full = 2
```

Another:

```text
empty = 0
full = 3
```

Now producer must wait.

Consumer removes one:

```text
empty = 1
full = 2
```

Producer can continue.

---

# 20. Semaphore Numerical Trick ⭐⭐⭐⭐⭐

For a semaphore:

$$
\boxed{
S_{final}
=
S_{initial}
+
\#signal
-
\#successful\ wait
}
$$

### Important

A `wait()` that **blocks** does not successfully decrement the semaphore.

---

# 21. Readers-Writers Synchronization ⭐⭐⭐⭐

Multiple readers can usually read simultaneously.

A writer needs exclusive access.

```text
Reader + Reader → allowed
Reader + Writer → not allowed
Writer + Writer → not allowed
```

Conceptually:

```text
       Database
      /    |    \
    R1     R2    R3
       simultaneous

W → exclusive
```

---

# 22. Reader-Writer Variants

### Reader Preference

Readers may get preference.

Potential problem:

$$
\boxed{\text{Writer starvation}}
$$

If readers continuously arrive, a writer may wait indefinitely.

### Writer Preference

Writers get preference.

Potential problem:

$$
\boxed{\text{Reader starvation}}
$$

### Fair solution

Attempts to prevent indefinite starvation for either side.

### 🔥 GATE Trap

> A correct reader-writer solution automatically guarantees no starvation.

❌ Not necessarily.

The specific policy matters.

---

# 23. Dining Philosophers ⭐⭐⭐⭐

Five philosophers share five forks.

Each philosopher needs:

```text
left fork + right fork
```

Bad strategy:

```text
Everyone picks left fork
        ↓
Everyone waits for right fork
        ↓
Deadlock
```

### Core lesson

Resource acquisition order matters.

---

# 24. Synchronization vs Deadlock

Synchronization mechanisms themselves can introduce deadlock if used incorrectly.

Example:

```text
P1:
lock(A)
lock(B)

P2:
lock(B)
lock(A)
```

Possible:

```text
P1 owns A → waits B
P2 owns B → waits A
```

Therefore:

$$
\boxed{\text{Deadlock}}
$$

---

# 25. Lock Ordering

A common strategy to avoid the above deadlock:

Require all processes to acquire locks in the same global order.

For example:

```text
A < B
```

Then everyone does:

```text
lock(A)
lock(B)
```

instead of arbitrary ordering.

This eliminates circular wait in this particular locking pattern.

---

# 26. Starvation

Synchronization can provide mutual exclusion but still allow starvation.

Example:

```text
P1 waits
P2 repeatedly acquires/releases lock
P1 never gets lock
```

So:

$$
\boxed{\text{Mutual exclusion} \not\Rightarrow \text{No starvation}}
$$

---

# 27. Priority Inversion ⭐⭐⭐⭐

Suppose:

```text
High-priority H
Medium-priority M
Low-priority L
```

L holds a lock needed by H:

```text
L → holds lock
H → waits for L
M → keeps running
```

Because M runs while H waits for L:

```text
H is indirectly delayed by M
```

This is **priority inversion**.

### Solution

**Priority inheritance**:

> Temporarily raise L's priority to H's priority so L can finish and release the lock.

---

# 28. GATE PYQ Pattern — Critical Section

Question:

> Which conditions are required for a correct critical-section solution?

Answer:

$$
\boxed{\text{Mutual Exclusion + Progress + Bounded Waiting}}
$$

---

# 29. GATE PYQ Pattern — Semaphore Value

Suppose:

```text
S = 5
```

Operations:

```text
wait
wait
signal
wait
signal
```

Net change:

$$
-1-1+1-1+1=-1
$$

Therefore:

$$
S=5-1=\boxed{4}
$$

assuming every `wait` succeeds.

---

# 30. GATE PYQ Pattern — Producer Consumer

If:

```text
Buffer size = 10
```

then initially:

$$
\boxed{empty=10}
$$

$$
\boxed{full=0}
$$

$$
\boxed{mutex=1}
$$

After 4 insertions:

$$
empty=6
$$

$$
full=4
$$

After 2 removals:

$$
empty=8
$$

$$
full=2
$$

---

# 31. GATE PYQ Pattern — Peterson

Question:

> Peterson's algorithm is designed for how many processes?

$$
\boxed{2}
$$

Question:

> Which properties does Peterson's solution satisfy?

$$
\boxed{\text{Mutual Exclusion + Progress + Bounded Waiting}}
$$

---

# 32. GATE PYQ Pattern — Atomic Instructions

Question:

> Why must Test-and-Set be atomic?

Because otherwise two processes could simultaneously observe the lock as free.

```text
P1 → sees 0
P2 → sees 0
P1 → sets 1
P2 → sets 1
```

Both could enter.

Therefore:

$$
\boxed{\text{Atomicity is essential}}
$$

---

# 33. GATE PYQ Pattern — Starvation

Question:

> A process waits indefinitely while other processes repeatedly enter the critical section. What is this?

$$
\boxed{\text{Starvation}}
$$

---

# 34. GATE PYQ Pattern — Priority Inversion

Question:

> A high-priority process waits for a lock held by a low-priority process, while a medium-priority process keeps executing. What is this?

$$
\boxed{\text{Priority Inversion}}
$$

---

# 🔥 GATE Traps

### Trap 1

```text
Mutex = binary semaphore
```

❌ Not exactly. Similar mutual-exclusion use, different semantics.

### Trap 2

```text
Mutual exclusion → no starvation
```

❌ False.

### Trap 3

```text
Spinlock → blocking
```

❌ False.

Spinlock → busy waiting.

### Trap 4

```text
Peterson → any number of processes
```

❌ Classical Peterson → 2.

### Trap 5

A semaphore `wait()` that blocks should not be counted as a successful decrement.

### Trap 6

`signal()` releases/increments the semaphore.

### Trap 7

Shared memory without synchronization can produce race conditions.

### Trap 8

Correct synchronization does not automatically mean deadlock-free.

### Trap 9

Reader-reader access is normally allowed in the readers-writers problem.

### Trap 10

Priority inversion is **not** the same as starvation, although priority inversion can contribute to prolonged waiting.

---

# 🎯 GATE Priority

| Topic                       | Priority |
| --------------------------- | -------: |
| Semaphore                   |    ⭐⭐⭐⭐⭐ |
| Critical-section conditions |    ⭐⭐⭐⭐⭐ |
| Producer-consumer           |    ⭐⭐⭐⭐⭐ |
| Peterson                    |    ⭐⭐⭐⭐⭐ |
| Race conditions             |    ⭐⭐⭐⭐⭐ |
| Atomic instructions         |    ⭐⭐⭐⭐⭐ |
| Mutex                       |    ⭐⭐⭐⭐⭐ |
| Readers-writers             |     ⭐⭐⭐⭐ |
| Dining philosophers         |     ⭐⭐⭐⭐ |
| Starvation                  |    ⭐⭐⭐⭐⭐ |
| Priority inversion          |     ⭐⭐⭐⭐ |
| Spinlocks                   |     ⭐⭐⭐⭐ |

---

# 🧠 GATE Mental Model

```text
              Synchronization
                     |
          ┌──────────┴──────────┐
          ↓                     ↓
     Mutual Exclusion      Coordination
          |                     |
       Mutex              Semaphore
          |                     |
       Lock/Unlock         Wait/Signal
          |
     Critical Section
          |
   ┌──────┼─────────┐
   ↓      ↓         ↓
  Race  Deadlock  Starvation
```

When you see a question, ask:

```text
1. Shared data?
2. Critical section?
3. Need mutual exclusion?
4. Need ordering/signaling?
5. Semaphore value?
6. Busy waiting or blocking?
7. Deadlock possible?
8. Starvation possible?
```

---

# ⚡ 30-Second Revision

```text
Synchronization:
→ controls concurrent access to shared resources

Critical Section:
→ code accessing shared resource

Correct CS solution:
→ Mutual Exclusion
→ Progress
→ Bounded Waiting

Mutex:
→ lock/unlock
→ mutual exclusion
→ ownership semantics

Semaphore:
→ wait()/signal()
→ synchronization/counting

Binary semaphore:
→ 0/1

Counting semaphore:
→ multiple resources

Atomic:
→ indivisible operation

Test-and-Set / CAS:
→ hardware atomic primitives

Peterson:
→ 2 processes
→ ME + Progress + Bounded Waiting

Spinlock:
→ busy waiting

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

Starvation:
→ indefinite waiting

Priority inversion:
→ high priority waits because lower-priority task holds resource

Deadlock:
→ processes permanently stuck waiting
```

### ⭐ GATE Priority: **5/5**

The **highest-yield numerical area** is semaphore execution:

$$
\boxed{S_f=S_i+\#signal-\#successful\ wait}
$$

and the **highest-yield conceptual area** is:

$$
\boxed{\text{Mutex vs Semaphore vs Spinlock vs Peterson}}
$$

➡️ **Next: `07-Deadlocks.md`**
