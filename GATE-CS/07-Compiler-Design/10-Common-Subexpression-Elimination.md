# 10 — Common Subexpression Elimination (CSE) — GATE CSE Notes

## 🎯 GATE Priority: ⭐⭐⭐⭐⭐ VERY HIGH

Common Subexpression Elimination is an important compiler optimization and is strongly connected with:

* DAG
* Available Expressions
* Local optimization
* Global optimization
* Data-flow analysis
* Dead-code elimination
* Value numbering

---

# 1. What is Common Subexpression Elimination?

A **common subexpression** is an expression that is evaluated more than once, where the repeated evaluation produces the same value.

Instead of calculating it repeatedly, the compiler calculates it once and reuses the result.

### Example

```text
a = b + c
d = b + c
```

Both contain:

```text
b + c
```

Instead of computing twice:

```text
t = b + c
a = t
d = t
```

The computation is performed only once.

---

# 2. Why CSE is Useful?

CSE reduces:

* number of computations
* execution time
* generated instructions

Example:

### Before

```text
t1 = a * b
x = t1 + c
t2 = a * b
y = t2 + d
```

`a*b` is calculated twice.

### After CSE

```text
t1 = a * b
x = t1 + c
y = t1 + d
```

One multiplication is eliminated.

---

# 3. What is a Common Subexpression?

Suppose:

```text
x = a + b
y = c * (a + b)
```

The expression:

```text
a + b
```

is common.

We can transform:

```text
t = a + b
x = t
y = c * t
```

---

# 4. Local vs Global CSE ⭐⭐⭐⭐⭐

## Local CSE

Works within a **single basic block**.

Example:

```text
B:
    t1 = a + b
    x = t1 * c
    t2 = a + b
    y = t2 + d
```

The second `a+b` can reuse the first result.

---

## Global CSE

Works across **multiple basic blocks**.

Example:

```text
B1:
    t1 = a + b

B2:
    x = a + b
```

If the expression is guaranteed to still have the same value when reaching `B2`, it can potentially be reused.

### 🔥 GATE Trick

```text
DAG → Mainly local CSE
Available Expressions → Global CSE
```

---

# 5. DAG-Based CSE ⭐⭐⭐⭐⭐

A DAG represents expressions inside a basic block.

Consider:

```text
a = b + c
d = b + c
```

DAG:

```text
       +
      / \
     b   c
```

Both assignments refer to the same DAG node.

Therefore, the second calculation is redundant.

---

# 6. DAG Example

Consider:

```text
a = b + c
d = a * e
f = b + c
```

The first computation creates:

```text
t1 = b + c
```

Then:

```text
d = t1 * e
```

For:

```text
f = b + c
```

the same `b+c` node can be reused.

Equivalent optimized form:

```text
t1 = b + c
a = t1
d = t1 * e
f = t1
```

---

# 7. Important Condition for CSE ⭐⭐⭐⭐⭐

A previous expression can be reused only if its operands still have the same values.

Example:

```text
a = b + c
b = 10
d = b + c
```

Can we reuse the first `b+c`?

❌ **No.**

Why?

Because `b` changed.

```text
First:
b + c

Later:
new b + c
```

may have a different value.

---

# 8. Killer Definition ⭐⭐⭐⭐⭐

An expression is available at a program point if:

1. It has already been computed.
2. Its operands have not changed since that computation.
3. There is no intervening operation that invalidates the expression's value.

This leads directly to:

# Available Expressions Analysis

---

# 9. CSE and Available Expressions

For **global CSE**, the compiler can use available-expression data-flow analysis.

Remember:

```text
Available Expressions
        ↓
Forward analysis
        ↓
Intersection
        ↓
Must analysis
```

### 🔥 GATE Memory Trick

```text
CSE asks:
"Has this expression already been safely computed?"
```

This is exactly what available expressions helps determine.

---

# 10. Available Expression Example

Consider:

```text
B1:
    t1 = a + b
    goto B2

B2:
    x = a + b
```

If `a` and `b` have not changed between the blocks:

```text
a+b
```

is available at `B2`.

Therefore:

```text
x = t1
```

may replace:

```text
x = a + b
```

---

# 11. Why Intersection?

Suppose a block has two predecessors:

```text
       B1
      /  \
     B2  B3
      \  /
       B4
```

Suppose:

```text
B2 computes a+b
B3 computes a+b
```

Then `a+b` is available at `B4`.

But if:

```text
B2 computes a+b
B3 does NOT compute a+b
```

then we cannot safely say `a+b` is available at `B4`.

Therefore:

```text
OUT[B2] ∩ OUT[B3]
```

is used.

### 🔥 Golden Rule

```text
Available Expressions → INTERSECTION
```

because it is a **must** property.

---

# 12. Reaching Definitions vs Available Expressions

| Property  | Reaching Definitions         | Available Expressions                       |
| --------- | ---------------------------- | ------------------------------------------- |
| Direction | Forward                      | Forward                                     |
| Meet      | Union                        | Intersection                                |
| Type      | May                          | Must                                        |
| Question  | Which definitions can reach? | Which expressions are definitely available? |
| Main use  | Def-use information          | Global CSE                                  |

### Memory:

```text
RD → Forward + Union + May
AE → Forward + Intersection + Must
```

---

# 13. GEN and KILL for Available Expressions ⭐⭐⭐⭐⭐

For a basic block `B`:

```text
OUT[B] = GEN[B] ∪ (IN[B] − KILL[B])
```

And for a non-entry block:

```text
IN[B] = ⋂ OUT[P]
```

where `P` represents predecessors.

---

# 14. What is GEN?

`GEN[B]` contains expressions that are **computed in B** and remain valid at the end of B.

Example:

```text
B:
    t = a + b
```

Then:

```text
a+b ∈ GEN[B]
```

assuming nothing later in the block invalidates it.

---

# 15. What is KILL?

`KILL[B]` contains expressions that become invalid because one of their operands is modified.

Example:

```text
B:
    t = a + b
    a = 10
```

The assignment:

```text
a = 10
```

kills:

```text
a+b
```

Therefore:

```text
a+b ∈ KILL[B]
```

---

# 16. Very Important Example

Consider:

```text
B:
    x = a + b
    a = 20
```

At the end:

```text
a+b
```

is **not available**.

Why?

Because `a` changed.

So even though `a+b` was computed, it has been killed.

### 🔥 Trick

> **Computed once is not enough.**

It must remain valid.

---

# 17. Example — Expression Repeated Without Modification

```text
a = b + c
x = a + d
y = b + c
```

No modification to `b` or `c`.

Therefore:

```text
b+c
```

is still available when computing `y`.

So:

```text
y = a previous result
```

can reuse it.

---

# 18. Example — Operand Modified

```text
a = b + c
b = 10
d = b + c
```

First:

```text
b+c
```

is computed.

Then:

```text
b
```

changes.

Therefore:

```text
b+c
```

is killed.

Hence the second expression must be recomputed.

---

# 19. CSE with Multiplication

```text
x = a * b
y = c + x
z = a * b
```

If `a` and `b` are unchanged:

```text
t = a * b
x = t
y = c + t
z = t
```

The multiplication is performed once.

---

# 20. Associativity Trap ⚠️

Consider:

```text
a + b
b + a
```

Can they always be treated as the same expression?

For ordinary mathematical addition, they are mathematically equal.

But compiler CSE depends on the **language semantics and floating-point/overflow rules**.

For GATE's usual integer-style algebraic questions, don't casually assume arbitrary transformations unless the problem's semantics permit them.

### Safe rule:

```text
a + b
```

and

```text
a + b
```

are unquestionably the same expression.

---

# 21. Commutativity Trap

Consider:

```text
a + b
b + a
```

Whether they can be treated as the same depends on the operation and language semantics.

For basic GATE questions involving standard arithmetic, commutative operators may allow such equivalence.

But:

```text
a - b
```

and:

```text
b - a
```

are definitely **not** the same.

Likewise:

```text
a / b
```

and:

```text
b / a
```

are not the same.

---

# 22. Side Effects ⭐⭐⭐⭐

CSE becomes more complicated when expressions involve:

* function calls
* memory loads
* pointers
* volatile memory
* aliasing
* global variables

Example:

```text
x = *p
...
y = *p
```

If memory at `p` might have changed, reusing the first value may be unsafe.

Therefore CSE requires knowing that the expression's value remains valid.

---

# 23. Function Calls and CSE

Consider:

```text
x = f(a)
...
y = f(a)
```

Can we replace the second call with:

```text
y = x
```

Not automatically.

`f(a)` may have:

* side effects
* global-state dependence
* nondeterministic behavior

Therefore ordinary CSE cannot blindly eliminate function calls.

---

# 24. CSE and Dead-Code Elimination

Suppose:

```text
t = a + b
x = t
```

If `x` is never used, then:

```text
t = a + b
x = t
```

may eventually be removed.

Therefore optimizations interact.

Typical chain:

```text
CSE
 ↓
fewer computations
 ↓
possibly unused temporaries
 ↓
Dead-Code Elimination
```

---

# 25. Value Numbering ⭐⭐⭐⭐

**Value numbering** is another technique for detecting equivalent computations.

Example:

```text
a = b + c
d = b + c
```

Both expressions can receive the same value number.

Conceptually:

```text
b → VN1
c → VN2
b+c → VN3
```

Both occurrences of:

```text
b+c
```

map to `VN3`.

Therefore the second computation is redundant.

---

# 26. Local Value Numbering

Local value numbering works inside a basic block.

Example:

```text
a = b + c
d = a + e
f = b + c
```

The second `b+c` can be identified as already computed.

---

# 27. CSE vs Constant Propagation

| CSE                             | Constant Propagation              |
| ------------------------------- | --------------------------------- |
| Eliminates repeated expressions | Replaces variables with constants |
| `a+b` repeated → reuse          | `x=5; y=x` → `y=5`                |
| Uses expression availability    | Uses known constant values        |

---

# 28. CSE vs Copy Propagation

### CSE

```text
t1 = a + b
t2 = a + b
```

→ reuse result.

### Copy propagation

```text
x = y
z = x + 1
```

→

```text
z = y + 1
```

### 🔥 Trick

```text
Repeated computation → CSE
Copied value → Copy propagation
```

---

# 29. CSE vs Common Constant Expression

Consider:

```text
x = 5 + 10
y = 5 + 10
```

Constant folding can first produce:

```text
x = 15
y = 15
```

The compiler does not necessarily need CSE here because the expressions can be evaluated at compile time.

---

# 30. GATE Numerical Pattern ⭐⭐⭐⭐⭐

Suppose:

```text
B:
    t1 = a + b
    t2 = c * d
    t3 = a + b
    t4 = c * d
    t5 = t1 + t2
```

Repeated expressions:

```text
a+b
c*d
```

Therefore two computations can be eliminated.

Optimized form:

```text
t1 = a + b
t2 = c * d
t3 = t1
t4 = t2
t5 = t1 + t2
```

Depending on the IR representation and subsequent copy propagation, it may simplify further.

---

# 31. GATE Trap — Reassignment

```text
t1 = a + b
a = c
t2 = a + b
```

❌ Cannot reuse the first `a+b`.

Because:

```text
a
```

changed.

---

# 32. GATE Trap — Unchanged Operands

```text
t1 = a + b
c = 10
t2 = a + b
```

Can reuse:

```text
a+b
```

because neither `a` nor `b` changed.

---

# 33. GATE Trap — One Operand Changes

```text
t1 = a + b
b = b + 1
t2 = a + b
```

Cannot reuse.

Only one operand changing is sufficient to invalidate the previous expression.

---

# 34. GATE Trap — Different Operator

```text
t1 = a + b
t2 = a * b
```

Not common.

```text
+ ≠ *
```

---

# 35. GATE Trap — Different Operand

```text
t1 = a + b
t2 = a + c
```

Not the same expression.

---

# 36. GATE PYQ Patterns ⭐⭐⭐⭐⭐

### Pattern 1 — Identify redundant computation

Given a sequence of TAC statements, find which expressions can be eliminated.

Look for:

```text
same operator
same operands
no operand modification
```

---

### Pattern 2 — DAG node count

Given a basic block, construct its DAG and determine:

* common subexpressions
* number of nodes
* redundant calculations

---

### Pattern 3 — Available expressions

Given a CFG, calculate:

```text
IN[B]
OUT[B]
```

using:

```text
IN[B] = ⋂ OUT[pred]
```

and:

```text
OUT[B] = GEN[B] ∪ (IN[B] − KILL[B])
```

---

### Pattern 4 — Operand modification

Given:

```text
x = a+b
a = ...
y = a+b
```

determine whether CSE is possible.

Answer:

**No**, because `a` changed.

---

### Pattern 5 — Optimization sequence

A question may ask what happens after applying:

1. constant propagation
2. constant folding
3. CSE
4. dead-code elimination

Apply them carefully in the requested order.

---

# 37. 🔥 CSE Decision Procedure

When you see a repeated expression:

### Step 1

Are the expressions actually equivalent?

```text
same operation?
same operands?
```

### Step 2

Have any operands changed?

```text
YES → Cannot reuse
NO  → Continue
```

### Step 3

Are there side effects/aliasing concerns?

```text
YES → Must analyze carefully
NO  → Continue
```

### Step 4

Was the expression already computed?

```text
YES → CSE possible
```

---

# 38. Most Important Formula

For Available Expressions:

```text
IN[B] = ⋂ OUT[P]
```

```text
OUT[B] = GEN[B] ∪ (IN[B] − KILL[B])
```

### 🔥 Memorize:

```text
Available Expressions
= Forward
+ Intersection
+ Must
```

---

# 39. Master Compiler Optimization Table

| Optimization               | Key idea                         |
| -------------------------- | -------------------------------- |
| Constant Propagation       | Variable → known constant        |
| Constant Folding           | Compute constants                |
| Copy Propagation           | Variable → copied source         |
| CSE                        | Reuse repeated computation       |
| Dead-Code Elimination      | Remove unused results            |
| Strength Reduction         | Expensive operation → cheaper    |
| Loop Invariant Code Motion | Move invariant work outside loop |

---

# 40. 🧠 One-Line Memory Tricks

```text
Repeated expression
        ↓
CSE
```

```text
Known constant
        ↓
Constant Propagation
```

```text
Constant arithmetic
        ↓
Constant Folding
```

```text
Same expression definitely computed
        ↓
Available Expressions
```

```text
Operand modified
        ↓
Previous expression may be invalid
```

```text
DAG
        ↓
Local CSE
```

```text
Available Expressions
        ↓
Global CSE
```

---

# 41. ⚡ 30-Second Revision

```text
CSE = Common Subexpression Elimination
```

Purpose:

```text
Compute once → reuse result
```

Example:

```text
t1 = a+b
t2 = a+b
```

becomes:

```text
t1 = a+b
t2 = t1
```

provided `a` and `b` have not changed.

For global CSE:

```text
Available Expressions
        ↓
Forward
        ↓
Intersection
        ↓
Must
```

Main formulas:

```text
IN  = Intersection of predecessor OUTs

OUT = GEN ∪ (IN − KILL)
```

---

# 42. ✅ Final GATE Checklist

* [ ] Definition of CSE
* [ ] Local CSE
* [ ] Global CSE
* [ ] DAG-based CSE
* [ ] Available Expressions
* [ ] GEN and KILL
* [ ] `IN = intersection of predecessor OUT`
* [ ] `OUT = GEN ∪ (IN − KILL)`
* [ ] Operand modification
* [ ] Commutativity considerations
* [ ] Side-effect issues
* [ ] Function-call restrictions
* [ ] Value numbering
* [ ] Local value numbering
* [ ] CSE vs constant propagation
* [ ] CSE vs copy propagation
* [ ] CSE vs constant folding
* [ ] CSE + dead-code elimination

## ⭐ GATE Priority

```text
⭐⭐⭐⭐⭐ Available Expressions
⭐⭐⭐⭐⭐ GEN/KILL questions
⭐⭐⭐⭐⭐ DAG and local CSE
⭐⭐⭐⭐⭐ Operand modification
⭐⭐⭐⭐ CFG-based global CSE
⭐⭐⭐⭐ Value numbering
⭐⭐⭐ Side effects / aliasing
```

### 🔥 Final Memory Map

```text
             COMMON SUBEXPRESSION
                      │
          ┌───────────┴───────────┐
          ↓                       ↓
       LOCAL                    GLOBAL
          ↓                       ↓
         DAG              Available Expressions
                                  ↓
                         Forward + Intersection
                                  ↓
                               CSE
```

**This completes the 10 topics visible in your current Compiler Design folder.**
