# `07-Deadlocks.md`

# Deadlocks — GATE CSE 2027

## 1. What is Deadlock?

A **deadlock** is a situation where a set of processes are permanently blocked because each process is waiting for a resource/event that cannot become available due to the other processes in the set.

> **Everyone is waiting, and nobody can proceed.**

Example:

```text
P1 holds R1 → waits for R2
P2 holds R2 → waits for R1
```

```text
P1 ──waits──→ R2
↑             ↓
R1 ←──held────P2
```

Result:

$$
\boxed{\text{DEADLOCK}}
$$

---

# 2. Four Necessary Conditions ⭐⭐⭐⭐⭐

A deadlock can occur **only if all four** conditions hold simultaneously.

## 1. Mutual Exclusion

At least one resource is non-shareable.

```text
R → only one process can use it at a time
```

---

## 2. Hold and Wait

A process is:

> holding at least one resource while waiting for another.

Example:

```text
P1:
holds R1
waits for R2
```

---

## 3. No Preemption

A resource cannot be forcibly taken away from the process holding it.

The process must release it voluntarily.

---

## 4. Circular Wait

There exists a circular chain:

```text
P1 waits for P2
P2 waits for P3
P3 waits for P1
```

or:

```text
P1 → R2 → P2 → R1 → P1
```

### 🔥 GATE Golden Rule

$$
\boxed{
ME + Hold\&Wait + No\ Preemption + Circular\ Wait
}
$$

All four are **necessary**.

If even **one condition is prevented**, deadlock cannot occur.

---

# 3. Deadlock vs Starvation ⭐⭐⭐⭐⭐

| Deadlock                                  | Starvation                           |
| ----------------------------------------- | ------------------------------------ |
| Processes are permanently blocked         | A process waits indefinitely         |
| Circular/resource dependency often exists | Usually unfair allocation/scheduling |
| Involved processes may all stop           | Other processes may continue         |
| No progress for involved processes        | System can still make progress       |

### Example

```text
Deadlock:
P1 waits for P2
P2 waits for P1
```

```text
Starvation:
P1 waits
P2 keeps getting resource
P3 keeps getting resource
...
```

### Memory trick

> **Deadlock = everyone stuck**
> **Starvation = someone ignored**

---

# 4. Deadlock vs Livelock

### Deadlock

Processes do nothing because they are blocked.

```text
P1 → waiting
P2 → waiting
```

### Livelock

Processes are active but continuously change state without making useful progress.

```text
P1 → moves
P2 → moves
P1 → moves
P2 → moves
...
```

but no useful work completes.

### 🔥 GATE Trap

$$
\boxed{\text{Deadlock = no progress + blocked}}
$$

$$
\boxed{\text{Livelock = activity + no useful progress}}
$$

---

# 5. Resource Allocation Graph (RAG) ⭐⭐⭐⭐⭐

Used to represent processes and resources.

### Notation

```text
Circle → Process
Rectangle → Resource
```

Example:

```text
P1 ──request──→ R1
R2 ──allocated──→ P1
```

More commonly:

```text
P1 → R1
R2 → P1
```

### Meaning

```text
P → R
```

means:

> Process P is requesting resource R.

```text
R → P
```

means:

> Resource R is allocated to process P.

---

# 6. Cycle in Resource Allocation Graph

This is a **very important GATE distinction**.

### If every resource has exactly ONE instance:

$$
\boxed{\text{Cycle} \iff \text{Deadlock}}
$$

So:

```text
Cycle → Deadlock
No cycle → No deadlock
```

### If resources can have MULTIPLE instances:

A cycle is:

$$
\boxed{\text{Necessary but NOT sufficient}}
$$

for deadlock.

### 🔥 GATE Trap

> "Cycle always means deadlock."

❌ False when resources have multiple instances.

---

# 7. Example — Single Instance

```text
P1 → R1
R1 → P2
P2 → R2
R2 → P1
```

Cycle:

$$
P1\rightarrow R1\rightarrow P2\rightarrow R2\rightarrow P1
$$

Since each resource has one instance:

$$
\boxed{\text{Deadlock}}
$$

---

# 8. Wait-for Graph ⭐⭐⭐⭐⭐

A **wait-for graph** contains only processes.

If:

```text
P1 waits for resource held by P2
```

we draw:

```text
P1 → P2
```

Example:

```text
P1 → P2
↑     ↓
└─────┘
```

Cycle:

$$
\boxed{\text{Deadlock}}
$$

### Important

Wait-for graphs are particularly useful when considering **single-instance resource allocation**.

---

# 9. Deadlock Handling Strategies ⭐⭐⭐⭐⭐

There are four major approaches:

```text
1. Ignore
2. Prevention
3. Avoidance
4. Detection + Recovery
```

---

# 10. Deadlock Prevention

Prevention ensures that **at least one of the four necessary conditions can never hold**.

---

## Prevent Mutual Exclusion

Make resources sharable where possible.

Example:

```text
Read-only resource
```

But many resources inherently cannot be shared.

---

## Prevent Hold and Wait

Require a process to request **all resources at once**.

```text
P requests R1 + R2 + R3
```

before execution.

### Problem

* poor resource utilization
* possible starvation

---

## Prevent No Preemption

If a process requests a resource that is unavailable, force it to release resources it currently holds, where possible.

Not suitable for every resource.

---

## Prevent Circular Wait ⭐⭐⭐⭐⭐

Impose a total ordering on resource types.

Example:

$$
R_1 < R_2 < R_3
$$

Processes must acquire resources in increasing order:

```text
R1 → R2 → R3
```

Then circular wait cannot form.

### 🔥 GATE Favorite

> **Resource ordering prevents circular wait.**

---

# 11. Deadlock Avoidance ⭐⭐⭐⭐⭐

Avoidance requires the system to know information about **future resource requirements**.

The OS grants a request only if doing so keeps the system in a:

$$
\boxed{\text{Safe State}}
$$

The most famous algorithm:

$$
\boxed{\text{Banker's Algorithm}}
$$

---

# 12. Safe State ⭐⭐⭐⭐⭐

A state is **safe** if there exists some order in which all processes can complete without causing deadlock.

That order is called a:

> **Safe sequence**

Example:

```text
P2 → P1 → P3
```

means:

1. P2 can finish
2. P2 releases resources
3. P1 can finish
4. P1 releases resources
5. P3 can finish

Therefore the system is safe.

---

# 13. Unsafe State ≠ Deadlock

This is one of the **most important GATE traps**.

$$
\boxed{\text{Deadlock} \Rightarrow \text{Unsafe}}
$$

But:

$$
\boxed{\text{Unsafe} \not\Rightarrow \text{Deadlock}}
$$

An unsafe state means:

> Deadlock **may** occur in the future.

It does not necessarily mean deadlock has already occurred.

---

# 14. Safe vs Unsafe vs Deadlock

```text
All States
   |
   ├── Safe
   |
   └── Unsafe
         |
         ├── May lead to deadlock
         |
         └── Deadlock
```

Think:

```text
Safe → guaranteed possible completion
Unsafe → no guarantee
Deadlock → already stuck
```

---

# 15. Banker's Algorithm ⭐⭐⭐⭐⭐

Banker's algorithm checks whether granting a request leaves the system in a safe state.

Important matrices/vectors:

### Available

Resources currently available.

### Max

Maximum resources each process may require.

### Allocation

Resources currently allocated.

### Need

Remaining maximum requirement.

$$
\boxed{Need = Max - Allocation}
$$

---

# 16. Banker's Algorithm — Core Procedure

Suppose:

```text
Available = Work
```

Find a process `Pi` such that:

$$
Need_i \leq Work
$$

Then assume it completes:

$$
Work = Work + Allocation_i
$$

Repeat.

If every process can finish:

$$
\boxed{\text{Safe}}
$$

If no unfinished process satisfies:

$$
Need_i\leq Work
$$

then:

$$
\boxed{\text{Unsafe}}
$$

---

# 17. Banker's Algorithm Numerical Trick ⭐⭐⭐⭐⭐

Always calculate:

$$
\boxed{Need=Max-Allocation}
$$

Then:

```text
Step 1:
Work = Available

Step 2:
Find Need ≤ Work

Step 3:
Pretend process finishes

Step 4:
Work += Allocation

Step 5:
Repeat
```

### 🔥 Don't make this mistake

When a process finishes:

$$
Work \neq Work+Need
$$

Correct:

$$
\boxed{Work=Work+Allocation}
$$

because the process returns the resources it was **holding**.

---

# 18. Example

Suppose:

$$
Available=(3,2)
$$

For P1:

$$
Max=(5,3)
$$

$$
Allocation=(3,1)
$$

Therefore:

$$
Need=(5,3)-(3,1)
$$

$$
\boxed{Need=(2,2)}
$$

Check:

$$
(2,2)\leq(3,2)
$$

Yes.

So P1 can finish.

After completion:

$$
Work=(3,2)+(3,1)
$$

$$
\boxed{Work=(6,3)}
$$

Continue checking other processes.

---

# 19. Deadlock Detection

If the system does **not** prevent or avoid deadlock, it can periodically check whether deadlock exists.

Detection algorithms determine:

> Which processes/resources are involved in deadlock?

For single-instance resources:

> Cycle in wait-for graph indicates deadlock.

For multiple instances:

> More general detection algorithms are required.

---

# 20. Deadlock Recovery ⭐⭐⭐⭐

Once deadlock is detected, possible recovery methods include:

### 1. Process termination

Terminate:

* all deadlocked processes, or
* selected processes one by one

### 2. Resource preemption

Take resources from selected processes and reassign them.

### 3. Rollback

Return a process to a previous safe state and restart it.

---

# 21. Recovery — Process Termination

Two basic strategies:

### Kill all deadlocked processes

Simple but expensive.

### Kill one process at a time

After each termination, check whether deadlock is removed.

Need to consider:

* process priority
* work already completed
* resources held
* resources still needed
* restart cost

---

# 22. Resource Preemption

Take a resource from one process and give it to another.

Problems:

* selecting victim
* rollback
* starvation

### 🔥 GATE Trap

Preemption is not always possible.

Some resources cannot be safely taken away while in use.

---

# 23. Deadlock Prevention vs Avoidance ⭐⭐⭐⭐⭐

| Prevention                                             | Avoidance                                    |
| ------------------------------------------------------ | -------------------------------------------- |
| Breaks one necessary condition                         | Keeps system in safe state                   |
| Does not require future maximum demand in the same way | Requires information about future/max demand |
| More restrictive                                       | More flexible                                |
| Resource ordering is example                           | Banker's algorithm is example                |

### Shortcut

```text
Prevention → break condition
Avoidance  → check safe state
```

---

# 24. Avoidance vs Detection

| Avoidance                                  | Detection                                                        |
| ------------------------------------------ | ---------------------------------------------------------------- |
| Acts before unsafe allocation              | Allows allocation and checks later                               |
| Prevents system from entering unsafe state | Finds existing deadlock                                          |
| Banker's algorithm                         | Detection algorithm                                              |
| Needs future demand information            | Can operate without requiring the same maximum-demand assumption |

---

# 25. Deadlock Ignorance

Some systems simply **ignore deadlocks** when:

* deadlocks are rare
* prevention/avoidance overhead is too high
* recovery is acceptable

This is sometimes called the:

> **Ostrich approach**

---

# 26. GATE PYQ Pattern — Four Conditions

Question:

> Which conditions are necessary for deadlock?

Answer:

$$
\boxed{
Mutual\ Exclusion,\ Hold\&Wait,\ No\ Preemption,\ Circular\ Wait
}
$$

### Fast elimination

If a question says:

> Resource can always be preempted.

Then:

```text
No-preemption condition is false
```

Therefore deadlock cannot occur under those assumptions.

---

# 27. GATE PYQ Pattern — Resource Ordering

Suppose resources are ordered:

$$
R_1<R_2<R_3
$$

and every process must acquire resources only in increasing order.

Can circular wait occur?

$$
\boxed{\text{No}}
$$

Therefore deadlock is prevented.

---

# 28. GATE PYQ Pattern — RAG Cycle

Question gives a resource allocation graph.

### First question to ask:

> **How many instances does each resource have?**

If all are single-instance:

```text
Cycle → Deadlock
```

If some have multiple instances:

```text
Cycle → may or may not be deadlock
```

This is one of the highest-yield GATE tricks.

---

# 29. GATE PYQ Pattern — Safe Sequence

Given:

```text
Available
Max
Allocation
```

Do:

$$
Need=Max-Allocation
$$

Then repeatedly find:

$$
Need_i\leq Work
$$

and update:

$$
Work=Work+Allocation_i
$$

If all processes finish:

$$
\boxed{\text{Safe}}
$$

---

# 30. GATE PYQ Pattern — Unsafe State

Question:

> Does an unsafe state necessarily imply that the system is currently deadlocked?

Answer:

$$
\boxed{\text{No}}
$$

It means there is no guarantee that all processes can complete.

---

# 31. GATE PYQ Pattern — Wait-for Graph

Given:

```text
P1 → P2
P2 → P3
P3 → P1
```

There is a cycle.

For the single-instance resource case:

$$
\boxed{\text{Deadlock}}
$$

---

# 32. 🔥 GATE Traps

### Trap 1

> Circular wait alone causes deadlock.

❌ All four necessary conditions must hold.

---

### Trap 2

> Every cycle in RAG means deadlock.

❌ Only guaranteed for the single-instance case.

---

### Trap 3

> Unsafe state means deadlock.

❌ False.

$$
\boxed{Unsafe \neq Deadlock}
$$

---

### Trap 4

> Banker's Algorithm is deadlock detection.

❌ It is a **deadlock avoidance** algorithm.

---

### Trap 5

> Deadlock prevention and avoidance are the same.

❌

```text
Prevention → break a necessary condition
Avoidance → stay in safe state
```

---

### Trap 6

When a process finishes in Banker's algorithm:

$$
Work += Allocation
$$

not:

$$
Work += Need
$$

---

### Trap 7

Wait-for graph includes resources.

❌ It contains **processes only**.

---

### Trap 8

Starvation and deadlock are identical.

❌ Other processes may continue during starvation.

---

# 🎯 GATE Priority

| Topic                     | Priority |
| ------------------------- | -------: |
| Four necessary conditions |    ⭐⭐⭐⭐⭐ |
| Resource Allocation Graph |    ⭐⭐⭐⭐⭐ |
| Safe/unsafe state         |    ⭐⭐⭐⭐⭐ |
| Banker's Algorithm        |    ⭐⭐⭐⭐⭐ |
| Safe sequence numericals  |    ⭐⭐⭐⭐⭐ |
| Deadlock prevention       |    ⭐⭐⭐⭐⭐ |
| Wait-for graph            |    ⭐⭐⭐⭐⭐ |
| Detection                 |     ⭐⭐⭐⭐ |
| Recovery                  |     ⭐⭐⭐⭐ |
| Starvation vs deadlock    |    ⭐⭐⭐⭐⭐ |
| Livelock                  |      ⭐⭐⭐ |
| Ostrich approach          |       ⭐⭐ |

---

# 🧠 GATE Mental Model

```text
                  DEADLOCK
                      |
       ┌──────────────┼──────────────┐
       ↓              ↓              ↓
   Conditions       Avoidance      Detection
       |              |              |
   4 conditions    Safe State       Find it
       |              |              |
       ↓           Banker's          RAG/
   ME + H&W +        |              WFG
   NP + CW           ↓
                  Safe Sequence
```

### Four conditions:

```text
ME
Hold & Wait
No Preemption
Circular Wait
```

### Prevention:

```text
Break one condition
```

### Avoidance:

```text
Don't enter unsafe state
```

### Detection:

```text
Allow → detect later → recover
```

---

# ⚡ 30-Second Revision

```text
Deadlock:
→ processes permanently blocked

4 necessary conditions:
1. Mutual Exclusion
2. Hold and Wait
3. No Preemption
4. Circular Wait

RAG:
P → R = request
R → P = allocation

Single-instance resource:
Cycle ⇔ Deadlock

Multiple-instance resource:
Cycle ≠ necessarily deadlock

Wait-for graph:
→ processes only
→ cycle indicates deadlock in single-instance setting

Prevention:
→ break one necessary condition

Avoidance:
→ remain in SAFE state
→ Banker's Algorithm

Need:
Need = Max - Allocation

Banker's:
Work = Available
Find Need ≤ Work
Work += Allocation
Repeat

Safe:
→ all processes can potentially finish

Unsafe:
→ may lead to deadlock
→ NOT necessarily deadlocked

Detection:
→ find existing deadlock

Recovery:
→ terminate / preempt / rollback

Deadlock:
→ everyone stuck

Starvation:
→ one waits indefinitely while others may continue

Livelock:
→ active but no useful progress
```

### ⭐ GATE Priority: **5/5**

## 🔥 The 5 formulas/rules you absolutely must remember

$$
\boxed{Need=Max-Allocation}
$$

$$
\boxed{Work_{new}=Work+Allocation}
$$

$$
\boxed{\text{Single-instance RAG: Cycle }\iff\text{ Deadlock}}
$$

$$
\boxed{\text{All 4 conditions are necessary}}
$$

$$
\boxed{\text{Unsafe State}\neq\text{Deadlock}}
$$

➡️ **Next: `08-CPU-Scheduling.md`**
