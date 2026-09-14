# 07 — COMPILER DESIGN

## 06 — Local Optimization — GATE CSE Notes

> **GATE Priority: ⭐⭐⭐⭐⭐ VERY HIGH**
>
> Focus on **basic-block optimization, algebraic simplification, constant folding/propagation, common subexpression elimination, copy propagation, dead-code elimination, strength reduction, DAG, and peephole optimization**.

---

# 1. What is Code Optimization?

Optimization transforms code into an **equivalent** form that is better according to some objective, usually:

* Faster execution
* Less memory
* Smaller code
* Lower energy

The most important condition is:

$$
\boxed{\text{Program meaning must be preserved}}
$$

---

# 2. Local vs Global Optimization

### Local Optimization

Performed within a **single basic block**.

$$
\boxed{\text{Local → one basic block}}
$$

### Global Optimization

Can operate across multiple basic blocks.

$$
\boxed{\text{Global → multiple basic blocks}}
$$

### GATE Trick

```text
One basic block → Local
Multiple blocks    → Global
```

---

# 3. Basic Block

A basic block is a sequence of instructions having:

$$
\boxed{\text{One entry point}}
$$

and:

$$
\boxed{\text{One exit point}}
$$

Local optimization is generally performed independently on each basic block.

---

# 4. Common Local Optimizations

Important techniques:

1. Constant folding
2. Constant propagation
3. Copy propagation
4. Algebraic simplification
5. Common subexpression elimination
6. Dead-code elimination
7. Strength reduction
8. Peephole optimization

---

# 5. Constant Folding

Evaluate constant expressions at **compile time**.

Example:

```text
x = 10 * 20
```

becomes:

```text
x = 200
```

Instead of calculating during execution.

$$
\boxed{10\times20\rightarrow200}
$$

---

# 6. More Constant Folding Examples

```text
x = 5 + 3
```

→

```text
x = 8
```

```text
x = 20 / 4
```

→

```text
x = 5
```

```text
x = 2 * 3 + 4
```

→

```text
x = 10
```

---

# 7. 🔥 Constant Folding vs Constant Propagation

Do not confuse them.

### Constant Folding

Compute a constant expression.

```text
x = 5 + 3
```

→

```text
x = 8
```

### Constant Propagation

Replace a variable known to contain a constant.

```text
x = 10
y = x + 5
```

→

```text
x = 10
y = 15
```

So:

$$
\boxed{\text{Folding = calculate}}
$$

$$
\boxed{\text{Propagation = substitute}}
$$

---

# 8. Constant Propagation Example

Before:

```text
a = 10
b = a + 5
c = b * 2
```

After propagation:

```text
a = 10
b = 10 + 5
c = b * 2
```

After folding:

```text
a = 10
b = 15
c = 30
```

---

# 9. Copy Propagation

Suppose:

```text
x = y
z = x + 5
```

Replace `x` with `y`:

```text
x = y
z = y + 5
```

The assignment:

```text
x = y
```

may then become unnecessary if `x` is not used elsewhere.

---

# 10. Constant vs Copy Propagation

| Optimization         | Example                |
| -------------------- | ---------------------- |
| Constant propagation | `x=10; y=x+1 → y=10+1` |
| Copy propagation     | `x=y; z=x+1 → z=y+1`   |

### Memory

$$
\boxed{\text{Constant → value}}
$$

$$
\boxed{\text{Copy → variable}}
$$

---

# 11. Algebraic Simplification

Use mathematical identities to simplify expressions.

### Examples

$$
x+0=x
$$

$$
x-0=x
$$

$$
x\times1=x
$$

$$
x/1=x
$$

$$
x\times0=0
$$

Therefore:

```text
x = y + 0
```

→

```text
x = y
```

---

# 12. More Algebraic Identities

$$
x-x=0
$$

$$
x/ x=1
$$

provided division by zero is not possible.

$$
x\times2
$$

may sometimes be transformed into:

$$
x+x
$$

depending on machine/optimization considerations.

---

# 13. ⚠️ GATE Trap — Algebraic Transformations

Do not blindly apply mathematical identities when language semantics matter.

For example:

$$
x/x=1
$$

is not universally safe if:

$$
x=0
$$

is possible.

Similarly, floating-point arithmetic can make seemingly equivalent transformations behave differently.

For GATE, follow the assumptions given in the question.

---

# 14. Common Subexpression Elimination

Suppose:

```text
t1 = a + b
x = t1 * c
t2 = a + b
```

If `a` and `b` have not changed:

```text
t2 = t1
```

instead of recomputing:

```text
t2 = a + b
```

---

# 15. 🔥 Key Condition for Common Subexpression

An expression can be reused only if its operands have **not changed** since the previous computation.

Example:

```text
t1 = a + b
a = 10
t2 = a + b
```

Cannot reuse `t1`.

Why?

Because `a` changed.

Therefore:

$$
\boxed{\text{Operand modification destroys the previous common subexpression}}
$$

---

# 16. DAG and Common Subexpressions

A DAG can detect common subexpressions within a basic block.

Example:

```text
x = a + b
y = a + b
```

DAG:

```text
       +
      / \
     a   b
```

Both `x` and `y` can refer to the same computation.

---

# 17. Dead Code

A statement is **dead** if its result is never used and it has no required side effect.

Example:

```text
x = 10
x = 20
print(x)
```

The first:

```text
x = 10
```

is dead because its value is overwritten before use.

Remove it:

```text
x = 20
print(x)
```

---

# 18. Another Dead-Code Example

```text
x = a + b
y = c + d
print(x)
```

If `y` is never used and its computation has no side effects:

```text
y = c + d
```

can be removed.

---

# 19. 🔥 Dead Code vs Unreachable Code

These are related but different.

### Dead code

Code may execute, but its result has no useful effect.

### Unreachable code

Code can never be executed.

Example:

```c
return;
x = 10;
```

The assignment is unreachable.

---

# 20. Strength Reduction

Replace an expensive operation with a cheaper equivalent operation.

Classic example:

$$
\boxed{x\times2\rightarrow x+x}
$$

or, where appropriate:

$$
\boxed{x\times2^k\rightarrow x\ll k}
$$

---

# 21. Loop Strength Reduction

Consider:

```text
i = i + 1
x = i * 4
```

Instead of repeatedly multiplying:

```text
x = i * 4
```

we can maintain an incrementing value:

```text
x = x + 4
```

This is especially useful inside loops.

---

# 22. Strength Reduction Example

Before:

```text
i = 0

L1:
t1 = i * 4
A[t1] = ...
i = i + 1
goto L1
```

Possible transformation:

```text
offset = 0

L1:
A[offset] = ...
offset = offset + 4
goto L1
```

The multiplication is replaced by addition.

---

# 23. Induction Variables

A variable whose value changes by a fixed amount on every loop iteration is an **induction variable**.

Example:

```c
for(i=0; i<n; i++)
```

`i` is an induction variable.

If:

```text
j = 4*i
```

then `j` can potentially be maintained as:

```text
j = j + 4
```

---

# 24. Peephole Optimization

Peephole optimization examines a **small window** of consecutive instructions and replaces inefficient patterns.

Concept:

```text
Instructions
   ↓
Small window
   ↓
Recognize pattern
   ↓
Better instructions
```

---

# 25. Peephole Example

Suppose target code contains:

```text
MOV R1, R2
MOV R2, R1
```

Depending on semantics, redundant instructions may be eliminated or simplified.

Another common pattern:

```text
JMP L1
L1:
```

can become unnecessary depending on control-flow context.

---

# 26. Peephole Optimizations

Common examples:

### Redundant instructions

Remove unnecessary operations.

### Algebraic simplification

```text
ADD R1, 0
```

→ remove.

### Strength reduction

```text
MUL R1, 2
```

→ cheaper operation where appropriate.

### Jump optimization

Remove unnecessary jumps.

---

# 27. Local Common Subexpression

Consider:

```text
t1 = a + b
t2 = c * d
t3 = a + b
```

If `a` and `b` are unchanged:

```text
t3 = t1
```

Therefore one addition can be eliminated.

---

# 28. GATE Question — Find Redundant Computation

Given:

```text
1: t1 = a + b
2: t2 = c + d
3: t3 = a + b
4: a = 10
5: t4 = a + b
```

### Statement 3

Can reuse statement 1:

```text
t3 = t1
```

because `a` and `b` have not changed between 1 and 3.

### Statement 5

Cannot reuse `t1` because:

```text
a = 10
```

changed an operand.

---

# 29. Copy Propagation Example

Before:

```text
x = y
z = x + 1
w = z * 2
```

After:

```text
x = y
z = y + 1
w = z * 2
```

Potentially:

```text
x = y
```

can then be removed if `x` is never otherwise needed.

---

# 30. Constant Propagation + Folding

Before:

```text
a = 5
b = 10
c = a + b
d = c * 2
```

Propagation:

```text
c = 5 + 10
d = c * 2
```

Folding:

```text
c = 15
d = 30
```

---

# 31. Optimization Order

Multiple optimizations can enable one another.

Example:

```text
a = 10
b = a + 5
c = b * 2
```

Constant propagation exposes:

```text
b = 10 + 5
```

Constant folding gives:

```text
b = 15
```

Then:

```text
c = 15 * 2
```

can be folded to:

```text
c = 30
```

So optimization passes may be repeated.

---

# 32. Local Value Numbering

A technique for identifying equivalent computations within a basic block.

Example:

```text
a = b + c
d = b + c
```

Both expressions have the same value number if `b` and `c` have not changed.

This helps detect common subexpressions.

---

# 33. Basic Block Optimization

Given:

```text
B:
t1 = a + b
t2 = t1 * 2
t3 = a + b
x = t3 + 5
```

Optimized:

```text
t1 = a + b
t2 = t1 * 2
x = t1 + 5
```

The repeated `a+b` is eliminated.

---

# 34. Local Optimization vs Machine Optimization

### Machine-independent

Examples:

* Constant folding
* Constant propagation
* Common subexpression elimination
* Dead-code elimination
* Algebraic simplification

### Machine-dependent

Examples:

* Register allocation
* Instruction selection
* Machine-specific peephole rules

GATE may ask whether an optimization depends on target architecture.

---

# 35. 🔥 Important Distinction

### Optimization

Changes representation while preserving behavior.

### Code generation

Maps IR to target-machine instructions.

```text
IR
 ↓
Optimization
 ↓
Optimized IR
 ↓
Code Generation
 ↓
Machine Code
```

---

# 36. PYQ Pattern — Constant Folding

Given:

```text
x = 4 * 5 + 2
```

Compile-time result:

$$
4\times5+2=22
$$

Therefore:

```text
x = 22
```

---

# 37. PYQ Pattern — Constant Propagation

Given:

```text
a = 10
b = a + 2
```

After constant propagation:

```text
b = 10 + 2
```

and after folding:

```text
b = 12
```

---

# 38. PYQ Pattern — Copy Propagation

Given:

```text
x = y
z = x + 5
```

Answer:

```text
z = y + 5
```

---

# 39. PYQ Pattern — Dead Code

Given:

```text
x = 10
x = 20
```

If nothing observes `x` between the assignments:

```text
x = 10
```

is dead.

---

# 40. PYQ Pattern — Common Subexpression

Given:

```text
t1 = a * b
t2 = c + d
t3 = a * b
```

If neither `a` nor `b` changes:

$$
\boxed{t3=t1}
$$

---

# 41. PYQ Pattern — Strength Reduction

Given:

```text
x = i * 4
```

inside a loop where `i` increments by 1:

```text
x = x + 4
```

can potentially replace repeated multiplication.

---

# 42. PYQ Pattern — Basic Block

Optimization such as local common-subexpression elimination generally considers:

$$
\boxed{\text{one basic block}}
$$

unless the question explicitly asks for a global analysis.

---

# 43. Common GATE Traps

### ❌ Trap 1

> Constant folding and constant propagation are the same.

False.

$$
\boxed{Folding=\text{evaluate constants}}
$$

$$
\boxed{Propagation=\text{replace known values}}
$$

---

### ❌ Trap 2

> A repeated expression is always a common subexpression.

False.

Its operands must remain unchanged.

---

### ❌ Trap 3

> Every assignment whose result isn't printed is dead.

False.

It may:

* affect another variable
* affect memory
* call a function
* cause a side effect

---

### ❌ Trap 4

> Strength reduction always means replacing multiplication with addition.

Not necessarily.

It means replacing a relatively expensive operation with a cheaper equivalent operation where valid.

---

### ❌ Trap 5

> Local optimization can freely use information from every basic block.

False.

Local optimization is restricted to a basic block.

---

# 44. Optimization Comparison

| Technique                | Main idea                             |
| ------------------------ | ------------------------------------- |
| Constant folding         | Evaluate constant expression          |
| Constant propagation     | Replace variable with known constant  |
| Copy propagation         | Replace variable with copied variable |
| Algebraic simplification | Apply identities                      |
| CSE                      | Reuse previous computation            |
| Dead-code elimination    | Remove useless computation            |
| Strength reduction       | Replace expensive operation           |
| Peephole                 | Optimize small instruction sequence   |
| DAG                      | Detect/reuse expressions in block     |
| Value numbering          | Identify equivalent values            |

---

# 45. 🧠 30-Second GATE Revision

```text
LOCAL OPTIMIZATION
       ↓
  Basic Block
       ↓
 ┌─────┼────────┬─────────┐
 ↓     ↓        ↓         ↓
CF     CP       CSE      DCE
 ↓     ↓        ↓         ↓
fold  replace   reuse    remove
```

Where:

$$
CF=\text{Constant Folding}
$$

$$
CP=\text{Constant Propagation}
$$

$$
CSE=\text{Common Subexpression Elimination}
$$

$$
DCE=\text{Dead Code Elimination}
$$

---

# 🎯 Highest-Yield GATE Facts

$$
\boxed{\text{Local optimization → Basic Block}}
$$

$$
\boxed{\text{Constant folding → Compile time evaluation}}
$$

$$
\boxed{\text{Constant propagation → Substitute known constants}}
$$

$$
\boxed{\text{Copy propagation → Substitute copied variables}}
$$

$$
\boxed{\text{CSE → Reuse unchanged expression}}
$$

$$
\boxed{\text{DCE → Remove unused/no-side-effect computation}}
$$

$$
\boxed{\text{Strength reduction → Cheaper equivalent operation}}
$$

$$
\boxed{\text{DAG → Common expressions within a basic block}}
$$

---

# 🔥 Final GATE Checklist

* [ ] Local vs global optimization
* [ ] Basic block
* [ ] Constant folding
* [ ] Constant propagation
* [ ] Copy propagation
* [ ] Algebraic simplification
* [ ] Common subexpression elimination
* [ ] Dead code
* [ ] Unreachable code
* [ ] Strength reduction
* [ ] Induction variables
* [ ] Peephole optimization
* [ ] DAG
* [ ] Value numbering
* [ ] Optimization dependencies
* [ ] Side effects
* [ ] Machine-independent vs machine-dependent optimization

**Next: `07-Global-Optimization.md`**.
# 07 — COMPILER DESIGN

## 07 — Global Optimization — GATE CSE Notes

> **GATE Priority: ⭐⭐⭐⭐ HIGH**
>
> Main focus: **global data-flow analysis, reaching definitions, available expressions, live variables, basic-block CFG, dominators, loop optimization, code motion, and global common-subexpression elimination.**

---

# 1. What is Global Optimization?

Global optimization performs optimization across **multiple basic blocks**.

```text
Basic Block B1
      ↓
Basic Block B2
      ↓
Basic Block B3
```

Unlike local optimization, information can flow across block boundaries.

$$
\boxed{\text{Local → one basic block}}
$$

$$
\boxed{\text{Global → multiple basic blocks}}
$$

---

# 2. Why Do We Need Global Optimization?

Consider:

```text id="2e1p9c"
B1:
x = 10

B2:
y = x + 5
```

A local optimizer working only on `B2` doesn't know that:

$$
x=10
$$

was established in `B1`.

Global analysis allows information to move through the control-flow graph.

---

# 3. Control Flow Graph

Global optimization works heavily with the **Control Flow Graph (CFG)**.

Each node:

$$
\boxed{\text{Basic Block}}
$$

Each edge:

$$
\boxed{\text{Possible control flow}}
$$

Example:

```text id="m8m2v4"
        B1
       /  \
      ↓    ↓
     B2    B3
      \    /
       ↓  ↓
        B4
```

---

# 4. Data-Flow Analysis

Global optimization frequently uses **data-flow analysis**.

Information is propagated through the CFG.

General idea:

$$
\boxed{\text{IN}[B]\rightarrow\text{Transfer Function}\rightarrow\text{OUT}[B]}
$$

For each basic block:

* `IN[B]` = information entering the block
* `OUT[B]` = information leaving the block

---

# 5. Three Most Important Data-Flow Problems

For GATE, memorize:

$$
\boxed{\text{Reaching Definitions}}
$$

$$
\boxed{\text{Available Expressions}}
$$

$$
\boxed{\text{Live Variables}}
$$

These are among the highest-yield concepts.

---

# 6. Reaching Definitions

A definition of variable `x` **reaches** a program point if there exists a path from the definition to that point along which `x` has not been redefined.

Example:

```text id="z7j3yq"
B1:
x = 10

B2:
y = x + 5
```

The definition:

```text id="0zqf3b"
x = 10
```

reaches the use of `x` in `B2`.

---

# 7. GEN and KILL for Reaching Definitions

For a basic block `B`:

### GEN[B]

Definitions generated by the block that reach the block's exit.

### KILL[B]

Definitions elsewhere that are killed by definitions in `B`.

The standard forward equation:

$$
\boxed{OUT[B]=GEN[B]\cup(IN[B]-KILL[B])}
$$

Equivalent:

$$
\boxed{OUT[B]=GEN[B]\cup(IN[B]\setminus KILL[B])}
$$

---

# 8. IN Equation for Reaching Definitions

For a block with predecessors:

$$
Pred(B)
$$

$$
\boxed{IN[B]=\bigcup_{P\in Pred(B)}OUT[P]}
$$

This is a:

$$
\boxed{\text{Forward, may analysis}}
$$

---

# 9. 🔥 GATE Trick — Reaching Definitions

Remember:

```text id="1isr89"
Reaching Definition
        ↓
      UNION
        ↓
      MAY analysis
```

So:

$$
\boxed{Forward + Union}
$$

---

# 10. Example — Reaching Definitions

```text id="0b2jz7"
B1:
x = 1
goto B3

B2:
x = 2
goto B3

B3:
y = x + 1
```

At entry of `B3`, either definition may reach:

$$
x=1
$$

or:

$$
x=2
$$

Therefore:

$$
IN[B3]=\{d_1,d_2\}
$$

---

# 11. Available Expressions

An expression is **available** at a point if it has already been computed on **every path** to that point and its operands have not been modified since the computation.

Example:

```text id="yq4zrh"
t1 = a + b
...
t2 = a + b
```

If `a` and `b` haven't changed and the first computation occurs on every path reaching the second point, then:

$$
a+b
$$

is available.

---

# 12. GEN and KILL for Available Expressions

### GEN[B]

Expressions definitely computed by `B` and still available at its exit.

### KILL[B]

Expressions invalidated because one of their operands is modified.

For a standard formulation:

$$
\boxed{OUT[B]=GEN[B]\cup(IN[B]-KILL[B])}
$$

and:

$$
\boxed{IN[B]=\bigcap_{P\in Pred(B)}OUT[P]}
$$

---

# 13. 🔥 GATE Trick — Available Expressions

Remember:

```text id="t3wzv6"
Available Expression
       ↓
      INTERSECTION
       ↓
     MUST analysis
```

Therefore:

$$
\boxed{Forward + Intersection}
$$

---

# 14. Reaching Definitions vs Available Expressions

| Property      | Reaching Definitions         | Available Expressions                         |
| ------------- | ---------------------------- | --------------------------------------------- |
| Direction     | Forward                      | Forward                                       |
| Merge         | Union                        | Intersection                                  |
| Type          | May                          | Must                                          |
| Main question | Could this definition reach? | Has this expression definitely been computed? |

### Golden memory

$$
\boxed{Reaching = MAY = UNION}
$$

$$
\boxed{Available = MUST = INTERSECTION}
$$

---

# 15. Live Variables

A variable is **live** at a point if its current value may be used in the future before being overwritten.

Example:

```text id="4m1u3s"
x = 10
y = x + 5
```

Immediately after:

```text id="5m4f1s"
x = 10
```

`x` is live because it will be used later.

---

# 16. Live Variable Analysis

Live variable analysis is:

$$
\boxed{\text{Backward}}
$$

because we ask about **future uses**.

For a block:

$$
\boxed{IN[B]=USE[B]\cup(OUT[B]-DEF[B])}
$$

and:

$$
\boxed{OUT[B]=\bigcup_{S\in Succ(B)}IN[S]}
$$

---

# 17. 🔥 GATE Trick

Live variables:

```text id="f3sh1v"
Future use
   ↓
Backward analysis
   ↓
Union
```

Therefore:

$$
\boxed{\text{Live = Backward + Union + May}}
$$

---

# 18. The Big Three — Memorize

| Analysis              | Direction | Merge        |
| --------------------- | --------- | ------------ |
| Reaching Definitions  | Forward   | Union        |
| Available Expressions | Forward   | Intersection |
| Live Variables        | Backward  | Union        |

### 🧠 One-line trick

$$
\boxed{R=F+U}
$$

$$
\boxed{A=F+I}
$$

$$
\boxed{L=B+U}
$$

where:

* `R` = Reaching
* `A` = Available
* `L` = Live
* `F` = Forward
* `B` = Backward
* `U` = Union
* `I` = Intersection

---

# 19. Use of Live Variable Analysis

It is particularly useful for:

$$
\boxed{\text{Dead-code elimination}}
$$

Suppose:

```text id="1v7fpy"
x = a + b
y = c + d
print(y)
```

If `x` is never used and has no side effect:

```text id="r4u2pv"
x = a + b
```

can be eliminated.

---

# 20. Use of Reaching Definitions

Useful for:

* Constant propagation
* Copy propagation
* Detecting definition-use relationships
* Some forms of code optimization

Example:

```text id="1v9r6m"
x = 10
...
y = x + 1
```

Reaching-definition analysis can determine which assignment to `x` can reach the use.

---

# 21. Use of Available Expressions

Useful for:

$$
\boxed{\text{Global Common Subexpression Elimination}}
$$

If an expression is available at a point, its previous result can potentially be reused.

---

# 22. Dominators

A block `D` **dominates** block `B` if every path from the entry block to `B` passes through `D`.

Notation:

$$
\boxed{D\ dom\ B}
$$

---

# 23. Example of Dominator

```text id="4b8kpu"
        B1
       /  \
      B2   B3
       \   /
        B4
```

`B1` dominates:

$$
B2,B3,B4
$$

because every path from entry to those blocks passes through `B1`.

---

# 24. Entry Block

The entry block dominates **every reachable block**.

Therefore:

$$
\boxed{Entry\ dom\ B\quad\forall B}
$$

---

# 25. Dominator Tree

Dominator relationships can be represented using a dominator tree.

Example:

```text id="f0l3wd"
       B1
      /  \
     B2   B3
      \   /
       B4
```

if `B1` is the immediate dominator of `B2`, `B3`, and `B4`, the tree represents those relationships.

---

# 26. Natural Loops

A common way to identify a natural loop is through a **back edge**:

$$
\boxed{n\rightarrow d}
$$

where `d` dominates `n`.

Then `d` is the loop header.

---

# 27. Loop Optimization

Loops are especially important because a small optimization inside a loop can greatly reduce execution time.

Common techniques:

* Loop-invariant code motion
* Strength reduction
* Induction-variable elimination
* Loop unrolling

---

# 28. Loop-Invariant Code

An expression is loop invariant if its value does not change across loop iterations.

Example:

```text id="r3k2b6"
while (...) {
    x = a * b;
    y = x + i;
    i++;
}
```

If `a` and `b` never change inside the loop:

```text id="j9f0b1"
x = a * b
```

is loop invariant.

It can potentially be moved outside the loop.

---

# 29. Loop-Invariant Code Motion

Before:

```text id="2x7yqn"
preheader:

loop:
    x = a * b
    y = x + i
    i = i + 1
```

After:

```text id="9x9kq3"
preheader:
    x = a * b

loop:
    y = x + i
    i = i + 1
```

The multiplication occurs once instead of once per iteration.

---

# 30. ⚠️ GATE Trap — Loop Invariant

An expression being constant is not enough.

Moving code outside the loop must preserve:

* Program semantics
* Exceptions
* Side effects
* Execution behavior

For example, moving a potentially trapping operation may not always be safe.

For standard GATE questions, use the assumptions explicitly stated.

---

# 31. Loop Unrolling

Reduce loop-control overhead by performing multiple iterations per loop iteration.

Original:

```c id="72a5p3"
for(i=0;i<4;i++)
    a[i] = 0;
```

Unrolled conceptually:

```c id="st3q3e"
a[0] = 0;
a[1] = 0;
a[2] = 0;
a[3] = 0;
```

Advantages:

* Fewer loop-control operations
* More instruction-level parallelism opportunities

Disadvantage:

$$
\boxed{\text{Larger code size}}
$$

---

# 32. Strength Reduction

Replace expensive operations inside loops.

Example:

```text id="s4p0jz"
x = i * 4
```

with an incrementally maintained value:

```text id="h2i1n8"
x = x + 4
```

This is especially useful when `i` changes predictably.

---

# 33. Induction Variable Elimination

Suppose:

```text id="q4j2pw"
i = i + 1
j = 4 * i
```

Instead of computing:

$$
j=4i
$$

every iteration, maintain:

```text id="j3n2o5"
j = j + 4
```

This removes repeated multiplication.

---

# 34. Global Common Subexpression

Consider:

```text id="n4h7lq"
B1:
t1 = a + b

B2:
x = a + b
```

If `a` and `b` haven't changed and `a+b` is available at the start of `B2`, reuse the previous result.

This is a **global** common-subexpression opportunity.

---

# 35. Partial Redundancy

An expression is **partially redundant** when it is redundant along some paths but not all paths.

Example concept:

```text id="r7s2lq"
       B1
      /  \
     ↓    ↓
    B2    B3
      \  /
       B4
```

An expression might already have been computed on one incoming path but not the other.

This is more advanced but can appear in GATE conceptual questions.

---

# 36. Code Motion

Moving a computation to another location without changing program behavior.

Examples:

* Loop-invariant code motion
* Moving computations to reduce repeated execution

Goal:

$$
\boxed{\text{Perform expensive computation fewer times}}
$$

---

# 37. Global Constant Propagation

Example:

```text id="4m1lq0"
B1:
x = 10

B2:
y = x + 5
```

If no definition of `x` intervenes:

$$
y=15
$$

can potentially be obtained through global constant propagation.

---

# 38. Data-Flow Framework

General structure:

```text id="v9y0h5"
          CFG
           ↓
    Data-flow equations
           ↓
      Fixed point
           ↓
      Optimization
```

The equations are repeatedly applied until the information stops changing.

This is called reaching a:

$$
\boxed{\text{Fixed Point}}
$$

---

# 39. Fixed Point

Suppose successive iterations produce:

```text id="q4n1p9"
Iteration 1 → information A
Iteration 2 → information B
Iteration 3 → information C
Iteration 4 → information C
```

Since the result no longer changes:

$$
\boxed{\text{Fixed point reached}}
$$

---

# 40. Why Iteration?

CFGs may contain loops.

Information can circulate:

```text id="8g2m7q"
B1 → B2 → B3
     ↑       |
     └───────┘
```

Therefore one pass may not be enough.

Data-flow equations are repeatedly evaluated until convergence.

---

# 41. 🔥 GATE Data-Flow Table

| Analysis              | Direction | Merge        | Type | Main use              |
| --------------------- | --------- | ------------ | ---- | --------------------- |
| Reaching Definitions  | Forward   | Union        | May  | Def-use               |
| Available Expressions | Forward   | Intersection | Must | CSE                   |
| Live Variables        | Backward  | Union        | May  | Dead-code elimination |

Memorize this table.

---

# 42. PYQ Pattern — Reaching Definitions

Given:

```text id="r4h2b7"
B1:
x = 1

B2:
x = 2

B3:
y = x
```

If both `B1` and `B2` can reach `B3`, then:

$$
IN[B3]=\{x=1,\ x=2\}
$$

unless some path-specific condition excludes one.

---

# 43. PYQ Pattern — Available Expressions

Suppose:

```text id="h5m2x7"
B1:
t1 = a + b

B2:
t2 = a + b

B3:
...
```

If `B2` is reached from multiple predecessors, `a+b` is available only if it has been computed along **every** path to that point and remains valid.

Therefore:

$$
\boxed{\text{Intersection}}
$$

at merges.

---

# 44. PYQ Pattern — Live Variables

Given:

```text id="2p6x4r"
x = 10
y = x + 1
```

At the point after `x=10`, `x` is:

$$
\boxed{\text{Live}}
$$

because it will be used later.

After:

```text id="f1g5s0"
y = x + 1
```

if `x` is never used again:

$$
\boxed{x\text{ is dead}}
$$

---

# 45. PYQ Pattern — Dominator

Given:

```text id="b5t8j2"
B1 → B2 → B4
  \       ↑
   → B3 ──
```

If every path from `B1` to `B4` passes through `B2`, then:

$$
\boxed{B2\ dominates\ B4}
$$

---

# 46. PYQ Pattern — Loop-Invariant Code

Given:

```text id="9y2r8s"
while(i < n) {
    x = a * b;
    y = x + i;
    i++;
}
```

If `a` and `b` are not modified inside the loop:

$$
a*b
$$

is loop invariant.

It can potentially be moved outside.

---

# 47. PYQ Pattern — Loop Unrolling

Original:

```text id="4m5h7k"
for(i=0;i<100;i++)
```

If unrolled by factor 4:

```text id="t9p2j1"
i += 4
```

and four iterations are performed per loop iteration.

Approximate loop-control iterations:

$$
100/4=25
$$

instead of:

$$
100
$$

ignoring remainder handling and other details.

---

# 48. Common GATE Traps

### ❌ Trap 1

> Reaching definitions uses intersection.

False.

$$
\boxed{\text{Union}}
$$

---

### ❌ Trap 2

> Available expressions use union.

False.

$$
\boxed{\text{Intersection}}
$$

---

### ❌ Trap 3

> Live variable analysis is forward.

False.

$$
\boxed{\text{Backward}}
$$

---

### ❌ Trap 4

> If an expression is available on one path, it is available at a merge.

False.

For a **must** property, it must be available on **every** incoming path.

---

### ❌ Trap 5

> Dominator means direct predecessor.

False.

A block may dominate another block even if there are many blocks between them.

---

# 49. More Important GATE Facts

### Reaching Definitions

$$
\boxed{Forward,\ Union,\ May}
$$

### Available Expressions

$$
\boxed{Forward,\ Intersection,\ Must}
$$

### Live Variables

$$
\boxed{Backward,\ Union,\ May}
$$

### Dominator

$$
\boxed{\text{Every path from entry passes through D}}
$$

### Loop-invariant code

$$
\boxed{\text{Move unchanged computation outside loop}}
$$

---

# 50. 🧠 30-Second Revision

```text id="v0l9gc"
             GLOBAL OPTIMIZATION
                     |
              Control Flow Graph
                     |
             Data-flow Analysis
                     |
        ┌────────────┼────────────┐
        ↓            ↓            ↓
    Reaching      Available      Live
   Definitions   Expressions    Variables
        ↓            ↓            ↓
    Forward       Forward      Backward
     Union       Intersection    Union
      MAY            MUST         MAY
```

### Most important formulas

#### Reaching Definitions

$$
\boxed{OUT=GEN\cup(IN-KILL)}
$$

$$
\boxed{IN=\bigcup OUT(pred)}
$$

#### Available Expressions

$$
\boxed{OUT=GEN\cup(IN-KILL)}
$$

$$
\boxed{IN=\bigcap OUT(pred)}
$$

#### Live Variables

$$
\boxed{IN=USE\cup(OUT-DEF)}
$$

$$
\boxed{OUT=\bigcup IN(successors)}
$$

---

# 🎯 Final GATE Checklist

* [ ] Local vs global optimization
* [ ] Control-flow graph
* [ ] Data-flow analysis
* [ ] IN / OUT sets
* [ ] GEN / KILL
* [ ] Reaching definitions
* [ ] Available expressions
* [ ] Live variables
* [ ] Forward analysis
* [ ] Backward analysis
* [ ] May vs Must analysis
* [ ] Union vs intersection
* [ ] Fixed-point iteration
* [ ] Dominators
* [ ] Dominator tree
* [ ] Back edges
* [ ] Natural loops
* [ ] Loop-invariant code motion
* [ ] Loop unrolling
* [ ] Strength reduction
* [ ] Induction variables
* [ ] Global common-subexpression elimination
* [ ] Partial redundancy
* [ ] Dead-code elimination

## ⭐ GATE Golden Table

$$
\boxed{
\begin{array}{c|c|c|c}
Analysis & Direction & Merge & Type\\
\hline
Reaching\ Definitions & Forward & Union & May\\
Available\ Expressions & Forward & Intersection & Must\\
Live\ Variables & Backward & Union & May
\end{array}}
$$

**Next: `08-Code-Generation.md`**.
