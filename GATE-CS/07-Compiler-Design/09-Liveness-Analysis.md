# 09 — Liveness Analysis — GATE CSE Notes

## 🎯 GATE Priority: ⭐⭐⭐⭐⭐ VERY HIGH

Liveness Analysis is one of the most important **data-flow analyses** for GATE Compiler Design.

It is directly connected to:

* Register allocation
* Register spilling
* Dead-code elimination
* Interference graphs
* Next-use information
* Data-flow equations

---

# 1. What is Liveness Analysis?

A variable is **live** at a program point if its current value **may be used later** before being overwritten.

In simple words:

> **Will the current value of this variable be needed in the future?**

If yes → **LIVE**

If no → **DEAD**

---

# 2. Simple Example

```text
1. x = 10
2. y = x + 5
3. z = y * 2
```

After statement 1:

```text
x is LIVE
```

because statement 2 uses `x`.

After statement 2:

```text
x is DEAD
```

because there is no future use of `x`.

But:

```text
y is LIVE
```

because statement 3 uses `y`.

---

# 3. Why is Liveness Analysis Needed?

The most important application is:

## Register Allocation

If a variable is dead, its register can be reused.

Example:

```text
x = a + b
y = c + d
z = x + y
```

After `x` has been used in:

```text
z = x + y
```

its register can be reused.

### 🔥 GATE Trick

```text
Dead variable
     ↓
No future use
     ↓
Register can be reused
```

---

# 4. Live vs Dead

Consider:

```text
1. a = 5
2. b = a + 10
3. c = 20
4. d = b + 5
```

At different points:

```text
After 1 → a is LIVE
After 2 → b is LIVE
After 3 → b is LIVE
After 4 → b is DEAD
```

The assignment:

```text
c = 20
```

doesn't affect `b`.

---

# 5. Liveness is a Backward Analysis ⭐⭐⭐⭐⭐

This is extremely important.

Liveness asks:

> What will be needed in the future?

Therefore information flows **backward**.

```text
Future
  ↑
  |
Current
```

### Remember:

```text
Reaching Definitions → FORWARD
Constant Propagation → FORWARD
Available Expressions → FORWARD
Liveness Analysis → BACKWARD
```

---

# 6. USE and DEF ⭐⭐⭐⭐⭐

For a basic block, we define:

### USE[B]

Variables whose values are used **before being defined** in block `B`.

### DEF[B]

Variables defined before being used in block `B`.

---

# 7. Example of USE and DEF

Consider:

```text
B:
    x = a + b
    y = x + c
```

### First statement

```text
x = a + b
```

Uses:

```text
a, b
```

Defines:

```text
x
```

Second statement:

```text
y = x + c
```

`x` is already defined inside the block.

Therefore:

```text
USE[B] = {a, b, c}
DEF[B] = {x, y}
```

### 🔥 Important

`x` is **not** included in USE[B] merely because it is used.

It is used **after being defined within the block**.

---

# 8. Standard Liveness Equations ⭐⭐⭐⭐⭐

For a basic block `B`:

### OUT equation

```text
OUT[B] = ⋃ IN[S]
```

where `S` is every successor of `B`.

### IN equation

```text
IN[B] = USE[B] ∪ (OUT[B] − DEF[B])
```

These are extremely important for GATE.

---

# 9. Memorize This

```text
          SUCCESSORS
              ↓
       OUT[B] = UNION IN[S]
              ↓
       remove DEF[B]
              ↓
       add USE[B]
              ↓
       IN[B]
```

Or:

```text
IN = USE + (OUT - DEF)
```

---

# 10. Why is DEF Removed?

Suppose:

```text
B:
    x = 10
```

Even if `x` is live after the block:

```text
x ∈ OUT[B]
```

the old value of `x` isn't needed before this assignment.

The block overwrites it.

Therefore:

```text
OUT - DEF
```

removes variables whose old values are killed by definitions inside the block.

Then `USE` adds values that are needed before being redefined.

---

# 11. Statement-Level Liveness ⭐⭐⭐⭐⭐

For a statement:

```text
x = y + z
```

the backward rule is:

```text
LIVE_before =
    USE(statement)
    ∪
    (LIVE_after − DEF(statement))
```

Therefore:

```text
LIVE_before =
{y,z} ∪ (LIVE_after − {x})
```

---

# 12. Example

Consider:

```text
1. a = b + c
2. d = a + e
3. f = d + g
```

Assume nothing is live after statement 3.

Start:

```text
LIVE_after(3) = {}
```

### Statement 3

```text
f = d + g
```

Therefore:

```text
LIVE_before(3) = {d,g}
```

---

### Statement 2

```text
d = a + e
```

`d` is needed later.

So:

```text
LIVE_before(2)
= {a,e} ∪ ({d,g} - {d})
= {a,e,g}
```

---

### Statement 1

```text
a = b + c
```

Therefore:

```text
LIVE_before(1)
= {b,c} ∪ ({a,e,g} - {a})
= {b,c,e,g}
```

Final:

```text
Before 1 → {b,c,e,g}
Before 2 → {a,e,g}
Before 3 → {d,g}
After 3  → {}
```

---

# 13. GATE Shortcut for Statement Liveness

For:

```text
x = y op z
```

go backward.

### Step 1

Remove:

```text
x
```

from the live set.

### Step 2

Add:

```text
y,z
```

to the live set.

So:

```text
LIVE_before =
(LIVE_after − {x})
∪ {y,z}
```

---

# 14. Example with Multiple Uses

```text
1. a = b + c
2. d = a + e
3. f = a + d
```

Start from bottom.

After statement 3:

```text
{}
```

Before statement 3:

```text
{a,d}
```

Before statement 2:

```text
{a,e} ∪ ({a,d} - {d})
= {a,e}
```

Before statement 1:

```text
{b,c} ∪ ({a,e} - {a})
= {b,c,e}
```

---

# 15. Liveness and Control Flow ⭐⭐⭐⭐⭐

Consider:

```text
       B1
      /  \
     B2  B3
      \  /
       B4
```

Suppose:

```text
IN[B2] = {x}
IN[B3] = {y}
```

Then:

```text
OUT[B1]
= IN[B2] ∪ IN[B3]
= {x,y}
```

### 🔥 Trick

For liveness:

> A variable is live out of a block if it is live into **ANY successor**.

Therefore use:

```text
UNION
```

not intersection.

---

# 16. Why UNION?

Suppose:

```text
B1 → B2
B1 → B3
```

If:

```text
B2 needs x
B3 does not need x
```

then `x` is still potentially needed after `B1`.

Therefore:

```text
x ∈ OUT[B1]
```

Hence:

```text
OUT[B1] = UNION of successor IN sets
```

---

# 17. Boundary Condition

At the program exit, usually:

```text
OUT[EXIT] = ∅
```

if no variables are required after program termination.

Then liveness information propagates backward.

---

# 18. Fixed-Point Iteration

Because CFGs contain loops, liveness may need multiple iterations.

General process:

```text
Initialize
   ↓
Compute OUT
   ↓
Compute IN
   ↓
Repeat
   ↓
No changes
   ↓
Fixed point
```

### Important

Because liveness is backward:

```text
Successor information
        ↓
Current block
```

---

# 19. Liveness and Loops

Consider:

```text
      B1
      ↓
      B2 ←──┐
      ↓    │
      B3 ──┘
      ↓
     Exit
```

Because `B3` can go back to `B2`, information can circulate through the loop.

Therefore:

> Multiple iterations may be necessary to reach a fixed point.

---

# 20. Dead Code Elimination ⭐⭐⭐⭐⭐

Liveness is heavily used for dead-code elimination.

Consider:

```text
x = a + b
y = 10
z = x + 5
```

If `y` is never used later:

```text
y = 10
```

is dead.

It can potentially be removed.

---

# 21. When is an Assignment Dead?

For:

```text
x = expression
```

the assignment can be considered dead if:

1. `x` is not live after the assignment, and
2. evaluating `expression` has no observable side effects.

### Example

```text
x = a + b
```

If `x` is never used:

```text
x = a + b
```

can be removed.

---

# 22. Side-Effect Trap ⚠️

Consider:

```text
x = f()
```

Even if `x` is dead, removing the statement may be incorrect because:

```text
f()
```

may have side effects.

For example:

```text
print()
write()
update_database()
```

Therefore:

> Dead assignment does not automatically mean removable code.

---

# 23. Liveness and Register Allocation ⭐⭐⭐⭐⭐

Suppose:

```text
1. a = b + c
2. d = a + e
3. f = d + g
```

After statement 2:

```text
a
```

is dead.

Therefore the register holding `a` can be reused for another value.

This reduces register pressure.

---

# 24. Liveness and Interference Graph

Two variables interfere if they are **simultaneously live**.

Example:

```text
1. a = ...
2. b = ...
3. c = a + b
```

At statement 3:

```text
a and b
```

are both live.

Therefore:

```text
a ─── b
```

in the interference graph.

They cannot use the same register at that point.

---

# 25. Key Relationship

```text
Liveness Analysis
       ↓
Live ranges
       ↓
Interference
       ↓
Interference Graph
       ↓
Graph Coloring
       ↓
Register Allocation
```

⭐⭐⭐⭐⭐ **Very important GATE chain**

---

# 26. Live Range

The **live range** of a variable is the region over which its current value may be needed.

Example:

```text
1. x = 10
2. a = x + 1
3. b = x + 2
4. c = 20
```

`x` is live from its definition through its last use at statement 3.

After statement 3:

```text
x = DEAD
```

---

# 27. Next Use vs Liveness

These are related but not identical.

### Liveness

Answers:

> Is this value needed later?

### Next-use

Answers:

> Where is it needed next?

Example:

```text
x = 10
y = x + 5
```

At the definition of `x`:

```text
x = LIVE
next-use(x) = next statement
```

---

# 28. Liveness vs Reaching Definitions

Very important comparison:

| Property      | Liveness               | Reaching Definitions         |
| ------------- | ---------------------- | ---------------------------- |
| Direction     | Backward               | Forward                      |
| Main question | Will value be used?    | Which definitions can reach? |
| Type          | May analysis           | May analysis                 |
| Meet          | Union                  | Union                        |
| Main use      | Register allocation    | Def-use analysis             |
| Equation      | `IN = USE ∪ (OUT−DEF)` | `OUT = GEN ∪ (IN−KILL)`      |

### 🔥 Memorize

```text
Liveness
= BACKWARD + UNION + MAY
```

```text
Reaching Definitions
= FORWARD + UNION + MAY
```

---

# 29. Liveness vs Available Expressions

| Analysis              | Direction | Meet         |
| --------------------- | --------- | ------------ |
| Reaching Definitions  | Forward   | Union        |
| Available Expressions | Forward   | Intersection |
| Liveness              | Backward  | Union        |

### Super Trick

```text
RD  → F + U + MAY
AE  → F + I + MUST
LV  → B + U + MAY
```

Where:

```text
F = Forward
B = Backward
U = Union
I = Intersection
```

---

# 30. Example — Basic Block

Consider:

```text
B:
    a = b + c
    d = a + e
    f = d + g
```

We can derive:

```text
USE[B] = {b,c,e,g}
DEF[B] = {a,d,f}
```

Assume:

```text
OUT[B] = {}
```

Then:

```text
IN[B]
= USE[B] ∪ (OUT[B] − DEF[B])

= {b,c,e,g} ∪ ({} − {a,d,f})

= {b,c,e,g}
```

---

# 31. Example with OUT

Suppose:

```text
USE[B] = {a,b}
DEF[B] = {x,y}
OUT[B] = {x,a,c}
```

Then:

```text
IN[B]
= USE ∪ (OUT − DEF)
```

First:

```text
OUT − DEF
= {x,a,c} − {x,y}
= {a,c}
```

Then:

```text
IN
= {a,b} ∪ {a,c}
= {a,b,c}
```

### Answer:

```text
IN[B] = {a,b,c}
```

---

# 32. PYQ Pattern — Compute IN/OUT ⭐⭐⭐⭐⭐

If GATE gives:

```text
USE[B] = {a,b}
DEF[B] = {c}
```

and:

```text
OUT[B] = {a,c,d}
```

Then immediately apply:

```text
IN = USE ∪ (OUT − DEF)
```

Therefore:

```text
OUT − DEF
= {a,d}

IN
= {a,b,d}
```

---

# 33. PYQ Pattern — Identify Dead Variable

```text
1. x = a + b
2. y = c + d
3. z = x + y
```

At statement 3:

```text
x,y
```

are live.

After statement 3:

```text
x,y
```

become dead if not used later.

---

# 34. PYQ Pattern — Minimum Registers

Given:

```text
a
b
c
d
```

and liveness information, GATE may ask the minimum number of registers.

Don't count all variables.

Count the **maximum number of simultaneously live values**.

### 🔥 Golden Rule

```text
Minimum registers
≈ Maximum simultaneous live values
```

subject to the exact target-machine/register constraints.

---

# 35. PYQ Pattern — Interference

If:

```text
LIVE = {a,b,c}
```

at one point:

```text
a ↔ b
a ↔ c
b ↔ c
```

All three interfere.

Therefore at least:

```text
3 registers
```

are needed for those simultaneously live values.

---

# 36. Common GATE Traps ⚠️

### Trap 1

> Liveness is a forward analysis.

❌ False.

It is **backward**.

---

### Trap 2

> Liveness uses intersection.

❌ False.

Standard liveness uses **union**.

---

### Trap 3

> If a variable is defined, it is immediately dead.

❌ False.

It is dead only when its current value has no future use.

---

### Trap 4

> A variable being used means it is always in USE[B].

❌ False.

`USE[B]` means use **before any definition in B**.

---

### Trap 5

> Dead variable always means the entire statement can be deleted.

❌ Not if the RHS has side effects.

---

### Trap 6

> Number of variables determines number of registers.

❌ False.

Maximum simultaneous liveness is what matters.

---

### Trap 7

> Liveness and next-use are identical.

❌ False.

Liveness says **whether** a future use exists.

Next-use says **where/when** the next use occurs.

---

# 37. 🧠 Super GATE Memory Formula

Memorize this:

```text
          LIVENESS
             ↓
       BACKWARD ANALYSIS
             ↓
      OUT = UNION successors
             ↓
       IN = USE ∪ (OUT−DEF)
```

And:

```text
LIVE → Register useful
DEAD → Register reusable
```

---

# 38. One-Page Revision Table

| Concept          | Remember                     |
| ---------------- | ---------------------------- |
| Liveness         | Future use                   |
| Direction        | Backward                     |
| Meet             | Union                        |
| Type             | May                          |
| USE              | Used before local definition |
| DEF              | Defined in block             |
| IN               | `USE ∪ (OUT−DEF)`            |
| OUT              | Union of successor IN        |
| Exit OUT         | Usually ∅                    |
| Dead value       | No future use                |
| Main application | Register allocation          |
| Another use      | Dead-code elimination        |
| Interference     | Simultaneously live          |
| Graph coloring   | Register allocation          |

---

# 39. 🔥 Most Important GATE Tricks

### Trick 1

```text
"Will this value be needed later?"
        ↓
Liveness
```

### Trick 2

```text
"Which definitions can reach here?"
        ↓
Reaching Definitions
```

### Trick 3

```text
"Is this expression already available?"
        ↓
Available Expressions
```

### Trick 4

```text
Liveness → Backward
```

### Trick 5

```text
Liveness → Union
```

### Trick 6

```text
IN = USE ∪ (OUT − DEF)
```

### Trick 7

```text
Simultaneously live
        ↓
Interfere
        ↓
Need different registers
```

---

# 40. 🚨 GATE Exam Strategy

If a question gives a CFG:

### Step 1

Draw the CFG.

### Step 2

Calculate:

```text
USE[B]
DEF[B]
```

for each block.

### Step 3

Start from the exit.

```text
OUT[EXIT] = ∅
```

### Step 4

Move **backward**.

```text
OUT[B] = UNION(IN[successors])
```

### Step 5

Calculate:

```text
IN[B] = USE[B] ∪ (OUT[B]−DEF[B])
```

### Step 6

For loops, repeat until no set changes.

---

# 41. Final Checklist ✅

Before GATE, you should be able to:

* [ ] Define liveness
* [ ] Identify live/dead variables
* [ ] Calculate USE and DEF
* [ ] Apply `IN = USE ∪ (OUT − DEF)`
* [ ] Calculate OUT from successors
* [ ] Solve CFG liveness
* [ ] Handle loops
* [ ] Perform fixed-point iteration
* [ ] Identify dead code
* [ ] Understand side-effect restrictions
* [ ] Build interference graphs
* [ ] Relate liveness to register allocation
* [ ] Calculate simultaneous live variables
* [ ] Distinguish liveness from next-use
* [ ] Distinguish liveness from reaching definitions

## ⭐ Priority for GATE

```text
⭐⭐⭐⭐⭐ IN/OUT equations
⭐⭐⭐⭐⭐ CFG numerical questions
⭐⭐⭐⭐⭐ USE/DEF
⭐⭐⭐⭐⭐ Register allocation connection
⭐⭐⭐⭐⭐ Interference graph
⭐⭐⭐⭐ Dead-code elimination
⭐⭐⭐⭐ Fixed-point iteration
⭐⭐⭐ Next-use comparison
```

**Next according to your folder: `10-Common-Subexpression-Elimination.md`**
