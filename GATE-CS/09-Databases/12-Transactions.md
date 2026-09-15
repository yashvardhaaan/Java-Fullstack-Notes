# 12 — Transactions

> **GATE Priority: ⭐⭐⭐⭐⭐ VERY HIGH**

Transactions are one of the **most important DBMS topics for GATE**. The highest-value areas are **ACID, transaction states, schedules, serializability, conflict serializability, precedence graphs, recoverability, cascading rollback, and strict schedules**.

> **First principle:** A transaction is a logical unit of database work that should take the database from **one consistent state to another consistent state**.

---

# 1. What is a Transaction?

A transaction is a sequence of database operations treated as one logical unit.

Example:

```text id="2s4b8j"
Transfer ₹1000 from A to B

1. Read(A)
2. A = A - 1000
3. Write(A)
4. Read(B)
5. B = B + 1000
6. Write(B)
```

Either the whole transfer happens:

```text id="t8x3m1"
A −1000
B +1000
```

or none of it should happen.

---

# 2. ACID Properties ⭐⭐⭐⭐⭐

| Property        | Meaning                                      |
| --------------- | -------------------------------------------- |
| **Atomicity**   | All or nothing                               |
| **Consistency** | Valid state → valid state                    |
| **Isolation**   | Concurrent transactions behave appropriately |
| **Durability**  | Committed changes survive failures           |

### Memory trick

```text id="8s5k0p"
A → All or Nothing
C → Correct State
I → Independent execution
D → Doesn't disappear
```

---

# 3. Atomicity

Suppose:

```text id="0f4x8z"
A = 5000
B = 3000
```

Transfer 1000:

```text id="5m8w2r"
A → 4000
B → 4000
```

If the system crashes after updating A but before B:

```text id="q8m3y1"
A = 4000
B = 3000
```

Database becomes inconsistent.

Atomicity requires:

```text id="6r2z9a"
Either:
A and B both updated

OR:
neither updated
```

---

# 4. Consistency

A transaction must preserve all database constraints.

Example:

```text id="8d5k2m"
Total money = ₹8000
```

Before:

```text id="m8v3j0"
A = 5000
B = 3000
```

After transfer:

```text id="9x2p6q"
A = 4000
B = 4000
```

Total remains:

```text id="4m8k2s"
₹8000
```

---

# 5. Isolation

Concurrent transactions should not interfere in an incorrect way.

Example:

```text id="9k2x6m"
T1: Read(A)
T2: Read(A)
T1: Write(A)
T2: Write(A)
```

Without proper concurrency control, updates can be lost.

Isolation addresses such concurrency problems.

---

# 6. Durability

After:

```text id="6q8s3v"
COMMIT
```

the changes must survive a system crash.

> **Committed ≠ temporary.**

---

# 7. Transaction States ⭐⭐⭐⭐⭐

A transaction can move through:

```text id="1d5q7m"
          Active
            ↓
       Partially Committed
            ↓
         Committed
```

If something goes wrong:

```text id="9r4k2x"
Active
  ↓
Failed
  ↓
Aborted
```

After abort:

```text id="4s8n1q"
Aborted
   ↓
Restart / terminate
```

---

# 8. State Meanings

### Active

Transaction is executing.

### Partially committed

Last statement has executed, but commit is not yet fully guaranteed.

### Committed

Transaction completed successfully and its effects are permanent.

### Failed

Transaction cannot continue normally.

### Aborted

Transaction has been rolled back.

---

# 9. Schedule ⭐⭐⭐⭐⭐

A **schedule** is an ordering of operations from multiple transactions while preserving the order within each individual transaction.

Suppose:

```text id="q3m7x2"
T1: R1(A) W1(A)
T2: R2(A) W2(A)
```

A possible schedule:

```text id="p7y2w4"
R1(A)
W1(A)
R2(A)
W2(A)
```

Another:

```text id="9j4s6x"
R1(A)
R2(A)
W1(A)
W2(A)
```

---

# 10. Serial Schedule ⭐⭐⭐⭐⭐

Transactions execute **one after another**.

Example:

```text id="w6f1q9"
T1 completely
   ↓
T2 completely
```

or:

```text id="n3s8c5"
T2 completely
   ↓
T1 completely
```

For `n` transactions:

```text id="7g2h4m"
Number of serial schedules = n!
```

Example:

```text id="a1f8k6"
3 transactions
→ 3! = 6 serial schedules
```

🔥 **GATE numerical favorite.**

---

# 11. Non-Serial Schedule

Operations of transactions are interleaved.

Example:

```text id="1c7m3q"
T1: R(A)
T2: R(B)
T1: W(A)
T2: W(B)
```

This may improve performance through concurrency.

But it can produce incorrect results.

---

# 12. Serializable Schedule ⭐⭐⭐⭐⭐

A schedule is serializable if its effect is equivalent to some serial schedule.

> **Key idea:** Interleaving is allowed, but the final effect should be equivalent to a valid serial execution.

---

# 13. Conflict Operations

Two operations conflict if:

1. They belong to **different transactions**
2. They access the **same data item**
3. At least one operation is a **write**

Therefore:

| Operations | Conflict? |
| ---------- | --------- |
| R-R        | ❌         |
| R-W        | ✅         |
| W-R        | ✅         |
| W-W        | ✅         |

🔥 **GATE Shortcut**

```text id="x4k7p2"
Different transactions
+
Same item
+
At least one W
=
CONFLICT
```

---

# 14. Conflict Serializability ⭐⭐⭐⭐⭐

A schedule is conflict serializable if it can be transformed into a serial schedule by swapping **non-conflicting operations**.

The easiest GATE method is:

> **Build a precedence graph.**

---

# 15. Precedence / Serialization Graph

Create:

```text id="p2y7x9"
one node per transaction
```

Add edge:

```text id="s4m8c1"
Ti → Tj
```

if an operation of Ti conflicts with a later operation of Tj.

---

# 16. Example

Schedule:

```text id="v3n8k5"
R1(A)
W1(A)
R2(A)
W2(A)
```

`W1(A)` occurs before `R2(A)`.

Conflict:

```text id="h7q2m4"
T1 → T2
```

Graph:

```text id="q9w5r1"
T1 ─────→ T2
```

No cycle.

Therefore:

```text id="e4s6z8"
Conflict serializable
```

Equivalent serial order:

```text id="k1m7v3"
T1 → T2
```

---

# 17. Cycle Rule ⭐⭐⭐⭐⭐

This is one of the most important GATE rules:

```text id="5v8m2x"
Precedence graph

NO CYCLE
   ↓
Conflict Serializable

CYCLE
   ↓
NOT Conflict Serializable
```

🔥 Memorize this.

---

# 18. Example with Cycle

Suppose:

```text id="7x2p9m"
T1 → T2
T2 → T1
```

Graph:

```text id="q5r8s3"
T1 ───→ T2
 ↑       │
 └───────┘
```

Cycle exists.

Therefore:

```text id="n1c6y4"
NOT conflict serializable
```

---

# 19. Read/Write Conflict Example

Schedule:

```text id="4m9s2q"
R1(A)
W2(A)
W1(B)
R2(B)
```

Conflicts:

```text id="9k3x7v"
R1(A) before W2(A)
→ T1 → T2

W1(B) before R2(B)
→ T1 → T2
```

Graph:

```text id="7v5n1p"
T1 → T2
```

No cycle.

Therefore conflict serializable.

---

# 20. Recoverable Schedule ⭐⭐⭐⭐⭐

A schedule is **recoverable** if:

> If Tj reads a value written by Ti, then Tj must commit **after Ti commits**.

Example:

```text id="w8q3m5"
W1(A)
R2(A)
C1
C2
```

T2 reads from T1.

T1 commits before T2.

✅ Recoverable.

---

# 21. Non-Recoverable Schedule

```text id="k6p1x9"
W1(A)
R2(A)
C2
A1
```

T2 commits before T1.

But T2 read data written by T1.

If T1 later aborts:

```text id="n4s8q2"
T2 committed invalid data
```

Therefore:

```text id="j5v7c3"
NOT recoverable
```

🔥 **GATE Rule**

> Writer must commit before the dependent reader commits.

---

# 22. Cascading Rollback ⭐⭐⭐⭐⭐

Suppose:

```text id="m8q4s1"
T1: W(A)
T2: R(A)
T3: R(A)
```

If T1 aborts:

```text id="j2x7v9"
T1 abort
 ↓
T2 must rollback
 ↓
T3 may also need rollback
```

This is a **cascading rollback**.

---

# 23. Cascadeless Schedule

A schedule is cascadeless if transactions **only read committed data**.

If:

```text id="7c3m9p"
T1 writes A
T1 commits
T2 reads A
```

then T2 reads committed data.

Therefore:

> Cascadeless schedules avoid cascading rollback.

---

# 24. Strict Schedule ⭐⭐⭐⭐⭐

A schedule is strict if:

> After Ti writes X, no other transaction can **read or write X** until Ti commits or aborts.

Therefore:

```text id="n5k2r8"
Ti W(X)
   ↓
No Rj(X)
No Wj(X)
   ↓
until Ti commits/aborts
```

Strictness is stronger than cascadelessness.

---

# 25. Relationship ⭐⭐⭐⭐⭐

Remember:

```text id="p6s3z1"
Strict
  ↓
Cascadeless
  ↓
Recoverable
```

Therefore:

```text id="0w8k4m"
Strict ⇒ Cascadeless ⇒ Recoverable
```

But reverse implication is not guaranteed.

🔥 **Very common GATE question.**

---

# 26. Recoverability Comparison

| Schedule    | Can read uncommitted data? | Cascading rollback? | Recoverable? |
| ----------- | -------------------------: | ------------------: | -----------: |
| Recoverable |                        Yes |            Possible |            ✅ |
| Cascadeless |                         No |                   ❌ |            ✅ |
| Strict      |                         No |                   ❌ |            ✅ |

And:

```text id="8q3m6x"
Strict ⊂ Cascadeless ⊂ Recoverable
```

conceptually.

---

# 27. Conflict vs View Serializability

### Conflict serializability

Based on:

```text id="4y8n1q"
conflicting operations
```

Can be tested efficiently using a precedence graph.

### View serializability

Based on:

* Same initial reads
* Same reads-from relationships
* Same final writes

View serializability is more general.

```text id="f6m2z7"
Conflict Serializable
        ⊂
View Serializable
```

🔥 Therefore:

> Every conflict-serializable schedule is view-serializable, but not every view-serializable schedule is conflict-serializable.

---

# 28. Blind Write

A **blind write** occurs when a transaction writes a data item without previously reading it.

Example:

```text id="r2j8v4"
W1(A)
```

without:

```text id="4x7m9q"
R1(A)
```

This is important when reasoning about **view serializability**.

---

# 29. Conflict Equivalence

Two schedules are conflict equivalent if:

1. They contain the same operations of the same transactions.
2. Every pair of conflicting operations occurs in the same relative order.

Therefore if the ordering of all conflicting pairs is unchanged:

```text id="q1m8s6"
Schedules are conflict equivalent.
```

---

# 30. GATE Precedence Graph Method ⭐⭐⭐⭐⭐

Given a schedule:

### Step 1

Create one node per transaction.

```text id="4v8p2x"
T1 T2 T3
```

### Step 2

Look for pairs accessing the **same item**.

### Step 3

Ignore:

```text id="m5j1k9"
R-R
```

### Step 4

For each conflict:

```text id="x6q8w3"
earlier transaction → later transaction
```

### Step 5

Check cycle.

```text id="z2r7n4"
No cycle → conflict serializable
Cycle → not conflict serializable
```

---

# 31. GATE Example

Schedule:

```text id="0f7m3p"
R1(A)
W1(A)
R2(A)
W2(A)
R2(B)
W2(B)
R3(B)
W3(B)
```

Conflicts:

```text id="6v2q9x"
T1 → T2
T2 → T3
```

Graph:

```text id="4s8k1m"
T1 → T2 → T3
```

No cycle.

Therefore:

```text id="j7m5q2"
Conflict serializable.

Equivalent serial order:
T1 → T2 → T3
```

---

# 32. GATE Pattern — Number of Serial Schedules

If there are `n` distinct transactions:

```text id="0g6m2x"
Number of serial schedules = n!
```

Examples:

```text id="3v8k1p"
2 → 2!
   = 2

3 → 3!
   = 6

4 → 4!
   = 24
```

---

# 33. GATE Pattern — Determine Recoverability

Look for:

```text id="x4n7s2"
Ti writes X
Tj reads X
```

Then:

```text id="9p5m8q"
Ti → Tj dependency
```

Check commit order:

```text id="v1k6r3"
Ci before Cj → okay
Cj before Ci → NOT recoverable
```

---

# 34. GATE Pattern — Strictness

If:

```text id="2q7m5v"
Wi(X)
```

and before `Ti` commits:

```text id="8s3n1k"
Rj(X)
```

or:

```text id="6v4p9x"
Wj(X)
```

then:

```text id="j8m2q5"
NOT strict
```

---

# 🔥 GATE Traps

1. **R-R is not a conflict.**
2. R-W, W-R and W-W are conflicts.
3. Same item + different transactions is necessary.
4. Precedence graph **cycle → not conflict serializable**.
5. No cycle → conflict serializable.
6. Every conflict-serializable schedule is view-serializable.
7. Reverse implication is false.
8. Recoverable ≠ cascadeless.
9. Cascadeless ⇒ recoverable.
10. Strict ⇒ cascadeless ⇒ recoverable.
11. Recoverable schedules may still have cascading rollback.
12. Strict schedules don't allow reads/writes of an item written by an uncommitted transaction.
13. Root concept for recoverability is **commit order**.
14. For serial schedules with n transactions → `n!`.
15. Blind writes matter especially for view serializability.
16. Don't confuse **serial** with **serializable**.
17. A non-serial schedule can still be perfectly serializable.

---

# 🧠 PYQ Patterns

GATE repeatedly asks transaction questions in these forms:

### Pattern 1 — Conflict serializability

Given a schedule:

```text
R1(X), W1(X), R2(X), W2(X), ...
```

Ask whether it is conflict serializable.

**Solution:** precedence graph.

---

### Pattern 2 — Equivalent serial schedules

Given a precedence graph:

```text
T1 → T2
T1 → T3
T2 → T3
```

Determine the serial order.

Here:

```text
T1 → T2 → T3
```

---

### Pattern 3 — Recoverability

Given:

```text
W1(X)
R2(X)
C2
C1
```

T2 reads T1's value but commits first.

Therefore:

```text
NOT RECOVERABLE
```

---

### Pattern 4 — Cascading rollback

Given:

```text
W1(X)
R2(X)
R3(X)
A1
```

T1 aborts.

Therefore T2 and potentially T3 must roll back.

---

### Pattern 5 — Strict/cascadeless/recoverable

Given a schedule and asked for the strongest property.

Remember:

```text
Strict
  ↓
Cascadeless
  ↓
Recoverable
```

Choose the **strongest property actually satisfied**.

---

# ⚡ 30-Second Revision

```text id="j0m8q4"
TRANSACTION
→ logical unit of work

ACID
A → Atomicity
C → Consistency
I → Isolation
D → Durability

SERIAL
→ one transaction after another

SERIALIZABLE
→ equivalent to some serial schedule

CONFLICT
→ same item
→ different transactions
→ at least one WRITE

R-R → no conflict
R-W → conflict
W-R → conflict
W-W → conflict

PRECEDENCE GRAPH
NO CYCLE → Conflict Serializable
CYCLE    → NOT Conflict Serializable

VIEW SERIALIZABLE
→ more general than conflict serializable

RECOVERABLE
→ writer commits before dependent reader

CASCADELESS
→ reads only committed data

STRICT
→ no R/W on item written by uncommitted transaction

STRICT
 ↓
CASCADELESS
 ↓
RECOVERABLE

n transactions
→ n! serial schedules
```

## 🎯 GATE Priority

| Topic                    | Priority |
| ------------------------ | -------: |
| Conflict Serializability |    ⭐⭐⭐⭐⭐ |
| Precedence Graph         |    ⭐⭐⭐⭐⭐ |
| Recoverability           |    ⭐⭐⭐⭐⭐ |
| Cascadeless / Strict     |    ⭐⭐⭐⭐⭐ |
| ACID                     |     ⭐⭐⭐⭐ |
| Transaction States       |      ⭐⭐⭐ |
| View Serializability     |     ⭐⭐⭐⭐ |
| Schedule concepts        |    ⭐⭐⭐⭐⭐ |
| Serial schedule counting |      ⭐⭐⭐ |

**Next: `13-Concurrency-Control.md`** — covering **locks, 2PL, strict 2PL, deadlocks, timestamp ordering, Thomas Write Rule, and concurrency-control numericals**.
