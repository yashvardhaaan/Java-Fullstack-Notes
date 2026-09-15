# 13 — Concurrency Control

> **GATE Priority: ⭐⭐⭐⭐⭐ VERY HIGH**

Concurrency control ensures that **multiple transactions can execute simultaneously without producing an incorrect database state**.

> **First principle:** Allow concurrency for performance, but control the order of conflicting operations so that the schedule remains correct/serializable.

---

# 1. Why Concurrency Control?

Suppose:

```text id="h8q2m1"
A = 100
```

Two transactions:

```text id="v5r7p3"
T1: Read(A)
    A = A + 50
    Write(A)

T2: Read(A)
    A = A + 20
    Write(A)
```

If both read `100` before either writes:

```text id="q4m9x6"
T1 writes 150
T2 writes 120
```

Final value:

```text id="r3n8k2"
120
```

But expected:

```text id="z6p1w4"
170
```

This is a **lost update** problem.

---

# 2. Common Concurrency Problems ⭐⭐⭐⭐⭐

## 2.1 Lost Update

Two transactions update the same item and one update gets overwritten.

```text id="7f2m8x"
T1: R(A)
T2: R(A)
T1: W(A)
T2: W(A)
```

T1's update can be lost.

---

## 2.2 Dirty Read / Temporary Update

T2 reads data written by T1 **before T1 commits**.

```text id="4k8p2m"
T1: W(A)
T2: R(A)
T1: ABORT
```

T2 read a value that never became permanent.

---

## 2.3 Unrepeatable Read

T1 reads the same item twice but gets different values.

```text id="0s5n7q"
T1: R(A)
T2: W(A)
T2: COMMIT
T1: R(A)
```

First and second reads of A differ.

---

## 2.4 Incorrect Summary / Inconsistent Analysis

T1 calculates an aggregate while T2 is modifying some of the rows.

Example:

```text id="p9v3x1"
T1: SUM(A,B,C)
T2: modifies B
```

T1 may observe a mixture of old and new values.

---

# 3. Main Concurrency-Control Techniques

For GATE, focus on:

```text id="x6q2r9"
1. Lock-based protocols
2. Two-Phase Locking (2PL)
3. Timestamp ordering
4. Deadlock handling
```

---

# 4. Locks ⭐⭐⭐⭐⭐

Two fundamental locks:

```text id="k4m8v2"
S-lock → Shared / Read
X-lock → Exclusive / Write
```

---

# 5. Shared Lock

Used for reading.

```text id="q8p1s6"
S(A)
```

Multiple transactions can simultaneously hold shared locks.

```text id="z3m7x5"
T1 → S(A)
T2 → S(A)
```

✅ Allowed.

---

# 6. Exclusive Lock

Used for writing.

```text id="c2v9n4"
X(A)
```

Only one transaction can hold an exclusive lock.

While `X(A)` exists:

```text id="7s4k1m"
No S(A)
No X(A)
```

from another transaction.

---

# 7. Lock Compatibility Matrix ⭐⭐⭐⭐⭐

| Requested / Existing |  S |  X |
| -------------------- | -: | -: |
| **S**                |  ✅ |  ❌ |
| **X**                |  ❌ |  ❌ |

Remember:

```text id="y8m2q4"
S + S → allowed
S + X → not allowed
X + S → not allowed
X + X → not allowed
```

🔥 **Most important lock table for GATE.**

---

# 8. Two-Phase Locking (2PL) ⭐⭐⭐⭐⭐

2PL divides a transaction into two phases:

### Growing phase

Transaction can:

```text id="g7v3m9"
acquire locks
```

but cannot release locks.

### Shrinking phase

Transaction can:

```text id="d2x8p5"
release locks
```

but cannot acquire new locks.

Diagram:

```text id="w9q1s6"
        Growing
           ↓
       lock point
           ↓
        Shrinking

Acquire → Acquire → Acquire
                         ↓
                       Release
                         ↓
                       Release
```

---

# 9. Lock Point

The **lock point** is the point at which a transaction has obtained its **last lock**.

After that:

```text id="x3m7q2"
only unlocking
```

is allowed.

---

# 10. What Does 2PL Guarantee? ⭐⭐⭐⭐⭐

Basic 2PL guarantees:

> **Conflict serializability.**

So:

```text id="r8k2m5"
2PL
 ↓
Conflict Serializable
```

But:

> Basic 2PL does **not necessarily prevent deadlocks**.

🔥 Very important.

---

# 11. Strict 2PL ⭐⭐⭐⭐⭐

Under strict 2PL:

> All **exclusive (X) locks** are held until commit/abort.

Therefore:

```text id="n5q9x1"
X-lock
  ↓
held until
  ↓
COMMIT / ABORT
```

Advantages:

* Conflict serializable
* Recoverable
* Cascadeless
* Easier recovery

---

# 12. Rigorous 2PL

Even stronger:

> **Both S-locks and X-locks** are held until commit/abort.

So:

```text id="s7m3p8"
Strict 2PL
→ X locks held

Rigorous 2PL
→ S + X locks held
```

🔥 **Hierarchy**

```text id="q4v8n2"
Rigorous 2PL
      ↓
Strict 2PL
      ↓
2PL
      ↓
Conflict Serializable
```

---

# 13. Conservative / Static 2PL

A transaction obtains **all required locks before it starts executing**.

Therefore:

```text id="z1m6x3"
All locks acquired first
       ↓
Execution
       ↓
Release
```

Main advantage:

> **Deadlock-free**

because a transaction never waits while holding some locks.

🔥 **GATE Shortcut**

```text id="h5q9w2"
Conservative 2PL → Deadlock-free
```

---

# 14. 2PL Variants Comparison

| Protocol         | Serializability       | Deadlock possible? | Locks held until commit |
| ---------------- | --------------------- | ------------------ | ----------------------- |
| Basic 2PL        | Conflict serializable | ✅ Yes              | No                      |
| Strict 2PL       | Conflict serializable | ✅ Yes              | X locks                 |
| Rigorous 2PL     | Conflict serializable | ✅ Yes              | S + X                   |
| Conservative 2PL | Conflict serializable | ❌ No               | All acquired initially  |

---

# 15. Lock Conversion ⭐⭐⭐⭐

A transaction may convert locks.

### Upgrade

```text id="r4m8q2"
S → X
```

Must occur during the **growing phase**.

### Downgrade

```text id="k7p1x5"
X → S
```

Must occur during the **shrinking phase**.

🔥 **GATE Trap**

```text id="s8m2v6"
S → X = upgrade → growing
X → S = downgrade → shrinking
```

---

# 16. Deadlock ⭐⭐⭐⭐⭐

Deadlock occurs when transactions wait for each other indefinitely.

Example:

```text id="p4x8m1"
T1 holds A
T2 holds B

T1 waits for B
T2 waits for A
```

Diagram:

```text id="n7q3s9"
T1 ─────→ T2
 ↑         │
 └─────────┘
```

This is a cycle in the **wait-for graph**.

---

# 17. Wait-For Graph

Nodes:

```text id="c8m5x2"
transactions
```

Edge:

```text id="q3v7n1"
Ti → Tj
```

means:

> Ti is waiting for Tj.

🔥 **Deadlock rule**

```text id="m9s4k6"
Cycle in wait-for graph
        ↓
Deadlock
```

---

# 18. Deadlock Handling

Three major approaches:

### Prevention

Ensure deadlock cannot occur.

Examples:

```text id="j2x8q4"
Wait-Die
Wound-Wait
```

### Avoidance

Grant a request only if the resulting state remains safe.

### Detection + Recovery

Allow deadlock, detect cycle, then abort one or more transactions.

---

# 19. Wait-Die ⭐⭐⭐⭐⭐

Uses transaction timestamps.

Suppose:

```text id="v7m2p5"
Older transaction → smaller timestamp
Younger transaction → larger timestamp
```

If:

```text id="h4x8n1"
Ti requests a lock held by Tj
```

### If Ti is older

```text id="q5m9s2"
Ti waits
```

### If Ti is younger

```text id="k8r3v6"
Ti dies / aborts
```

So:

> **Old waits, young dies.**

🔥 Memorize exactly.

---

# 20. Wound-Wait ⭐⭐⭐⭐⭐

Opposite style.

If Ti requests a lock held by Tj:

### Ti older

```text id="z6p1m8"
Ti wounds Tj
→ Tj aborts
```

### Ti younger

```text id="s4x9q2"
Ti waits
```

So:

> **Old wounds, young waits.**

🔥 Memory:

```text id="9n3m7v"
Wait-Die:
Old → Wait
Young → Die

Wound-Wait:
Old → Wound
Young → Wait
```

---

# 21. Timestamp Ordering ⭐⭐⭐⭐⭐

Each transaction receives a unique timestamp:

```text id="a5q8m3"
TS(T1) < TS(T2)
```

means T1 is older.

Each data item X maintains:

```text id="f8v2k6"
read_TS(X)
write_TS(X)
```

---

# 22. Timestamp Ordering — Read Rule

Transaction Ti wants:

```text id="x7m1q4"
READ(X)
```

If:

```text id="n5k8p2"
TS(Ti) < write_TS(X)
```

then Ti is trying to read a value that should have been overwritten by a younger transaction.

Therefore:

```text id="j4s9v6"
READ rejected
Ti rolled back
```

Otherwise:

```text id="b2q7m8"
READ allowed
read_TS(X) = max(read_TS(X), TS(Ti))
```

---

# 23. Timestamp Ordering — Write Rule ⭐⭐⭐⭐⭐

Ti wants:

```text id="r8x3p1"
WRITE(X)
```

Reject/abort if either:

```text id="g4m7q2"
TS(Ti) < read_TS(X)
```

or:

```text id="v9s1k5"
TS(Ti) < write_TS(X)
```

Otherwise write is allowed.

🔥 **Easy memory**

For a write:

```text id="k2m8x4"
TS(Ti) must NOT be older than
read_TS(X) or write_TS(X)
```

---

# 24. Thomas Write Rule ⭐⭐⭐⭐

Thomas Write Rule modifies timestamp ordering.

If:

```text id="n6p3r8"
TS(Ti) < write_TS(X)
```

then the write may simply be **ignored** instead of aborting Ti.

But if:

```text id="z5q1m7"
TS(Ti) < read_TS(X)
```

the transaction must still abort.

🔥 **Key distinction**

```text id="w8m4s2"
Older than write_TS
→ Thomas may ignore write

Older than read_TS
→ Abort
```

---

# 25. Locking vs Timestamp Ordering

| Locking               | Timestamp Ordering             |
| --------------------- | ------------------------------ |
| Uses locks            | Uses timestamps                |
| Transactions may wait | Generally no waiting for locks |
| Deadlocks possible    | No lock deadlocks              |
| Can cause blocking    | Can cause rollbacks            |

🔥 **GATE Shortcut**

> Timestamp ordering avoids **lock-based deadlock** because transactions do not wait for locks in the basic protocol.

---

# 26. Two-Phase Locking Example

Consider:

```text id="3j7m1q"
T1:
L-X(A)
R(A)
W(A)
U(A)

T2:
L-X(B)
R(B)
W(B)
U(B)
```

Each transaction:

```text id="q5x8m2"
acquire → use → release
```

No transaction acquires a new lock after releasing one.

Therefore:

```text id="v9k3p6"
2PL satisfied
```

---

# 27. 2PL Violation

```text id="a4m8x1"
L-X(A)
R(A)
U(A)
L-X(B)
```

Here:

```text id="7q2m5v"
unlock A
 ↓
lock B
```

A new lock was acquired after unlocking.

Therefore:

```text id="s8n1k4"
NOT 2PL
```

---

# 28. Lock Compatibility Example

Suppose:

```text id="e6m2q8"
T1 holds S(A)
```

Can T2 acquire:

```text id="9x4p7m"
S(A) → YES
X(A) → NO
```

If T1 holds:

```text id="v3k8n1"
X(A)
```

then:

```text id="j5m2q9"
S(A) → NO
X(A) → NO
```

---

# 29. GATE Problem-Solving: 2PL

When given a sequence of locks/unlocks:

### Step 1

Mark every:

```text id="2p8m4x"
LOCK
UNLOCK
```

### Step 2

Find the **first unlock**.

### Step 3

After that point:

> No new lock can be acquired.

If a new lock appears:

```text id="q7s3n5"
NOT 2PL
```

🔥 This is much faster than analyzing the whole transaction.

---

# 30. GATE Problem-Solving: Deadlock

Given:

```text id="x1m7q4"
T1 waits for T2
T2 waits for T3
T3 waits for T1
```

Draw:

```text id="z8p3n6"
T1 → T2 → T3 → T1
```

Cycle:

```text id="k4m9s2"
DEADLOCK
```

---

# 31. GATE Problem-Solving: Wait-Die

First determine:

```text id="w2q7m5"
Who is older?
```

Then:

```text id="4x8n1p"
Older requests younger's lock
→ WAIT

Younger requests older's lock
→ DIE
```

---

# 32. GATE Problem-Solving: Wound-Wait

```text id="r6m2k8"
Older requests younger's lock
→ WOUND younger → abort

Younger requests older's lock
→ WAIT
```

---

# 🧠 PYQ Patterns

### Pattern 1 — Lock compatibility

Given transactions holding:

```text id="f2q8m5"
S(A), X(A), ...
```

ask whether another lock can be granted.

Use:

```text id="4n7x1p"
S-S → YES
S-X → NO
X-S → NO
X-X → NO
```

---

### Pattern 2 — Is schedule 2PL?

Look for:

```text id="j8m3q5"
unlock
   ↓
later lock
```

If present:

> **Not 2PL.**

---

### Pattern 3 — Conflict serializability after locking

GATE can combine:

```text id="k4x7m1"
locks
+
schedule
+
precedence graph
```

Remember that **2PL guarantees conflict serializability**.

---

### Pattern 4 — Deadlock

Given lock ownership and waiting:

```text id="q9m2s5"
T1 waits T2
T2 waits T3
T3 waits T1
```

→ cycle → deadlock.

---

### Pattern 5 — Wait-Die / Wound-Wait

Given timestamps and lock requests:

```text id="v5k8x2"
Old → small timestamp
Young → large timestamp
```

Apply:

```text id="n7m3q9"
Wait-Die:
Old waits, Young dies

Wound-Wait:
Old wounds, Young waits
```

---

### Pattern 6 — Timestamp ordering

Given:

```text id="1q8m5x"
TS(T)
read_TS(X)
write_TS(X)
```

apply the read/write conditions directly.

This is a common source of GATE numerical questions.

---

# 🔥 GATE Traps

1. **S + S = compatible.**
2. S + X = incompatible.
3. X + X = incompatible.
4. Basic 2PL guarantees conflict serializability.
5. Basic 2PL does **not** guarantee deadlock freedom.
6. Conservative 2PL is deadlock-free.
7. Strict 2PL holds **X locks** until commit/abort.
8. Rigorous 2PL holds **all locks** until commit/abort.
9. `S → X` = upgrade → growing phase.
10. `X → S` = downgrade → shrinking phase.
11. After the first unlock in 2PL, **no new lock** can be obtained.
12. Wait-Die = **old waits, young dies**.
13. Wound-Wait = **old wounds, young waits**.
14. Cycle in wait-for graph = deadlock.
15. Timestamp ordering doesn't require lock waiting.
16. Thomas Write Rule can ignore an obsolete write.
17. Strict 2PL ⇒ cascadeless ⇒ recoverable.
18. Don't confuse **deadlock** with **starvation**.
19. A schedule can be serializable even though transactions are interleaved.
20. Always distinguish `read_TS(X)` from `write_TS(X)`.

---

# ⚡ 30-Second Revision

```text id="5n8q2m"
CONCURRENCY CONTROL
→ correct concurrent execution

LOCKS
S → Read
X → Write

S-S → YES
S-X → NO
X-S → NO
X-X → NO

2PL
Growing:
→ acquire locks
→ no unlock

Shrinking:
→ unlock
→ no new lock

2PL
→ Conflict Serializable

STRICT 2PL
→ X locks until commit/abort

RIGOROUS 2PL
→ S + X locks until commit/abort

CONSERVATIVE 2PL
→ acquire all locks first
→ deadlock-free

DEADLOCK
→ cycle in wait-for graph

WAIT-DIE
→ old waits
→ young dies

WOUND-WAIT
→ old wounds
→ young waits

TIMESTAMP ORDERING
→ read_TS(X)
→ write_TS(X)

THOMAS WRITE RULE
→ obsolete write can be ignored
```

## 🎯 GATE Priority

| Topic                     | Priority |
| ------------------------- | -------: |
| 2PL                       |    ⭐⭐⭐⭐⭐ |
| Lock compatibility        |    ⭐⭐⭐⭐⭐ |
| Conflict serializability  |    ⭐⭐⭐⭐⭐ |
| Deadlock / Wait-for graph |    ⭐⭐⭐⭐⭐ |
| Strict/Rigorous 2PL       |    ⭐⭐⭐⭐⭐ |
| Timestamp Ordering        |    ⭐⭐⭐⭐⭐ |
| Wait-Die / Wound-Wait     |     ⭐⭐⭐⭐ |
| Thomas Write Rule         |     ⭐⭐⭐⭐ |
| Concurrency anomalies     |     ⭐⭐⭐⭐ |

### 🏆 DBMS GATE Master Chain

You have now covered the complete folder:

```text
ER Model
   ↓
Relational Model
   ↓
Relational Algebra
   ↓
Tuple Calculus
   ↓
SQL
   ↓
Integrity Constraints
   ↓
Normalization
   ↓
File Organization
   ↓
Indexing
   ↓
B-Trees
   ↓
B+ Trees
   ↓
Transactions
   ↓
Concurrency Control
```

The **highest-priority DBMS revision chain** is:

```text
FDs
 ↓
Closure
 ↓
Candidate Keys
 ↓
Normalization
 ↓
SQL
 ↓
Relational Algebra
 ↓
B/B+ Trees
 ↓
Transactions
 ↓
Serializability
 ↓
2PL
 ↓
Deadlocks
```

This is the chain to practice heavily for **GATE 2027**.
