Yes — this image clarifies the **exact Compiler Design folder order**. My previous `08-Code-Generation.md` was based on the wrong sequence.

The correct sequence is:

```text
07-Compiler-Design
├── 01-Lexical-Analysis.md
├── 02-Parsing.md
├── 03-Syntax-Directed-Translation.md
├── 04-Runtime-Environments.md
├── 05-Intermediate-Code-Generation.md
├── 06-Local-Optimization.md
├── 07-Data-Flow-Analysis.md
├── 08-Constant-Propagation.md
├── 09-Liveness-Analysis.md
└── 10-Common-Subexpression-Elimination.md
```

So **08 = Constant Propagation**. I'll follow this order from now on.

# 08 — Constant Propagation — GATE CSE Notes

## 🎯 GATE Priority: ⭐⭐⭐⭐ HIGH

Constant Propagation is a very important **compiler optimization** topic and is closely related to:

* Data-flow analysis
* Reaching definitions
* Constant folding
* Copy propagation
* Dead-code elimination

---

# 1. What is Constant Propagation?

**Constant propagation** replaces a variable with a known constant value wherever possible.

Example:

```text
a = 10
b = a + 5
```

After constant propagation:

```text
a = 10
b = 10 + 5
```

Then constant folding can further produce:

```text
b = 15
```

### Important distinction

```text
Constant Propagation
        ↓
replace variable by known constant

Constant Folding
        ↓
evaluate constant expression
```

---

# 2. Simple Example

Original:

```text
x = 5
y = x + 10
z = y * 2
```

Constant propagation:

```text
x = 5
y = 5 + 10
z = y * 2
```

Constant folding:

```text
x = 5
y = 15
z = 30
```

Therefore, the two optimizations often work together.

---

# 3. Constant Propagation vs Constant Folding ⭐⭐⭐⭐⭐

| Constant Propagation          | Constant Folding              |
| ----------------------------- | ----------------------------- |
| Replaces variable by constant | Evaluates constant expression |
| `x = 5; y = x+2` → `y=5+2`    | `5+2` → `7`                   |
| Uses data-flow information    | Uses known constant operands  |
| Tracks values                 | Computes expressions          |

### 🔥 GATE Trick

```text
x = 10
y = x + 5
```

If `y` becomes:

```text
y = 10 + 5
```

→ **Propagation**

If it becomes:

```text
y = 15
```

→ **Folding**

---

# 4. Why Constant Propagation is Useful?

It can enable:

* constant folding
* dead-code elimination
* branch simplification
* strength reduction
* fewer memory accesses
* fewer instructions

Example:

```text
x = 10

if (x > 5)
    a = 20
else
    a = 30
```

After propagation:

```text
if (10 > 5)
    a = 20
else
    a = 30
```

Then:

```text
if (true)
    a = 20
```

The unreachable branch can potentially be removed.

---

# 5. Constant Lattice ⭐⭐⭐⭐⭐

Constant propagation is commonly explained using a **lattice**.

For a variable `x`, its abstract value can be:

```text
          ⊤
       /     \
   constant  constant
       \     /
          ⊥
```

The exact notation depends on the textbook/framework, so focus on the meanings.

A common three/four-valued interpretation is:

### `UNDEF`

Variable has not yet received a definition.

### Constant

Variable is known to contain a specific constant.

Example:

```text
x = 5
```

### `NAC`

**Not A Constant**

The value cannot be determined to be one constant.

---

# 6. Typical Constant Domain

For example:

```text
{ UNDEF, constants, NAC }
```

where:

```text
UNDEF = undefined/not yet established
NAC   = not a constant
```

Constants may be:

```text
0, 1, 2, 3, 10, ...
```

---

# 7. Meet Operation ⭐⭐⭐⭐⭐

Suppose a variable reaches a program point with:

```text
x = 5
```

along one path and:

```text
x = 5
```

along another path.

Then:

```text
x = 5
```

is still known.

But if:

```text
Path 1: x = 5
Path 2: x = 10
```

then:

```text
x = NAC
```

because `x` does not have one unique constant value.

### 🔥 Golden Rule

```text
Same constant + Same constant
        ↓
Same constant

Different constants
        ↓
NAC
```

---

# 8. Example with Control Flow

Consider:

```text
1. x = 5

2. if (...)
3.     x = 10
4. else
5.     x = 20

6. y = x
```

At statement 6:

```text
x ∈ {10,20}
```

Therefore:

```text
x = NAC
```

So we **cannot** propagate a constant to `y`.

---

# 9. Constant Propagation Through a Basic Block

Consider:

```text
a = 10
b = a + 5
c = b * 2
```

Initially:

```text
a = 10
```

Propagate:

```text
b = 10 + 5
```

Then:

```text
b = 15
```

Propagate again:

```text
c = 15 * 2
```

Finally:

```text
c = 30
```

---

# 10. Transfer Function

For an assignment:

```text
x = constant
```

the result is:

```text
x → constant
```

Example:

```text
x = 10
```

gives:

```text
x = 10
```

---

For:

```text
x = y
```

the value of `x` becomes the current value of `y`.

Example:

```text
y = 10
x = y
```

Therefore:

```text
x = 10
```

---

For:

```text
x = y + z
```

if:

```text
y = 5
z = 10
```

then:

```text
x = 15
```

---

If either operand is `NAC`:

```text
y = NAC
z = 10
```

then generally:

```text
x = NAC
```

assuming ordinary operations without special language-specific semantics.

---

# 11. Example

```text
a = 10
b = 20
c = a + b
d = c * 2
```

Constant information:

```text
a = 10
b = 20
c = 30
d = 60
```

Optimized code:

```text
a = 10
b = 20
c = 30
d = 60
```

Depending on later optimizations, some assignments may become removable if their values are never used.

---

# 12. Constant Propagation + Dead Code

Example:

```text
x = 10

if (x == 0)
    y = 20
else
    y = 30
```

Propagation:

```text
if (10 == 0)
```

Folding:

```text
if (false)
```

Therefore:

```text
y = 30
```

The first branch is unreachable.

This demonstrates how one optimization can enable another.

---

# 13. Constant Propagation Across Basic Blocks

Suppose:

```text
B1:
    x = 10
    goto B3

B2:
    x = 20

B3:
    y = x + 5
```

If `B3` can only be reached from `B1`, then:

```text
x = 10
```

can be propagated.

But if both `B1` and `B2` can reach `B3`:

```text
B1 → B3
B2 → B3
```

then:

```text
x = 10
```

or

```text
x = 20
```

may reach `B3`.

Therefore:

```text
x = NAC
```

at `B3`.

---

# 14. Relationship with Reaching Definitions ⭐⭐⭐⭐⭐

Constant propagation often relies on determining which definitions reach a program point.

Example:

```text
x = 10
...
y = x
```

If the definition:

```text
x = 10
```

is the only possible reaching definition of `x`, then we can conclude:

```text
x = 10
```

and propagate it.

### Important connection

```text
Reaching Definitions
        ↓
Which definitions can reach here?
        ↓
Constant Propagation
        ↓
Can variable have a known constant?
```

---

# 15. Example of Multiple Definitions

```text
x = 10
x = 20
y = x
```

At `y = x`, the first definition:

```text
x = 10
```

has been killed by:

```text
x = 20
```

Therefore:

```text
x = 20
```

can be propagated.

---

# 16. Constant Propagation is a Data-Flow Problem

This is extremely important for GATE.

Constant propagation can be formulated as a:

> **Forward data-flow analysis**

because information flows from definitions toward later uses.

Conceptually:

```text
Earlier statement
       ↓
Later statement
```

---

# 17. Forward Analysis

Example:

```text
x = 5
y = x + 1
z = y + 2
```

Information moves:

```text
x=5
 ↓
y=6
 ↓
z=8
```

Therefore constant propagation is naturally **forward**.

---

# 18. Initialization

At the beginning of analysis, variables may be considered:

```text
UNDEF
```

Then assignments progressively establish their values.

Example:

```text
Initially:
x = UNDEF

After:
x = 5

Therefore:
x = 5
```

The exact initialization/boundary convention can vary with the chosen lattice formulation.

---

# 19. Fixed-Point Computation ⭐⭐⭐⭐

For CFG-based constant propagation:

```text
Initialize data-flow values
        ↓
Apply transfer functions
        ↓
Meet incoming information
        ↓
Update values
        ↓
Repeat
        ↓
No changes
        ↓
Fixed point
```

GATE may ask how many iterations are needed or what values reach a particular block.

---

# 20. Important Example

```text
B1:
    x = 5

B2:
    y = x + 10

B3:
    z = y + 20
```

Data flow:

```text
B1
x = 5
 ↓
B2
y = 15
 ↓
B3
z = 35
```

Therefore:

```text
x = 5
y = 15
z = 35
```

---

# 21. When Constant Propagation Fails

### Case 1 — Multiple possible constants

```text
if (...)
    x = 5
else
    x = 10

y = x
```

Cannot conclude one constant.

```text
x = NAC
```

---

### Case 2 — Input-dependent value

```text
x = input()
```

If `input()` can return arbitrary values:

```text
x = NAC
```

---

### Case 3 — Modification through aliases/pointers

In languages with pointers/references, determining the exact value may require alias analysis.

Example conceptually:

```text
*p = 10
x = *q
```

If `p` and `q` may refer to the same location, analysis becomes more complicated.

---

# 22. Constant Propagation vs Copy Propagation

These are frequently confused.

### Copy Propagation

```text
x = y
z = x + 1
```

becomes:

```text
z = y + 1
```

### Constant Propagation

```text
x = 10
z = x + 1
```

becomes:

```text
z = 10 + 1
```

### 🔥 Trick

```text
x = y
→ Copy Propagation

x = 10
→ Constant Propagation
```

---

# 23. Constant Folding

Example:

```text
x = 5 + 10
```

Constant folding:

```text
x = 15
```

No variable replacement is involved.

---

# 24. Combined Example ⭐⭐⭐⭐⭐

Original:

```text
a = 10
b = a
c = b + 5
d = c * 2
```

### Constant propagation

```text
a = 10
b = 10
c = 10 + 5
d = c * 2
```

### Constant folding

```text
a = 10
b = 10
c = 15
d = 30
```

### Potential dead-code elimination

If only `d` is required:

```text
d = 30
```

could eventually remain.

---

# 25. GATE Numerical Trick

If you see:

```text
x = 5
y = x
z = y
a = z + 2
```

Don't stop at the first propagation.

Follow the chain:

```text
x = 5
 ↓
y = 5
 ↓
z = 5
 ↓
a = 7
```

### 🔥 Trick

**Constant propagation can cascade through multiple assignments.**

---

# 26. Common GATE Traps ⚠️

### Trap 1

> Constant propagation and constant folding are the same.

❌ False.

---

### Trap 2

> If a variable has two definitions, it cannot be constant.

❌ Not necessarily.

Example:

```text
x = 5
x = 5
```

Both definitions produce the same constant.

Therefore:

```text
x = 5
```

can still be known.

---

### Trap 3

> Different definitions always imply NAC.

❌ False.

```text
x = 5
x = 5
```

→ still `5`.

But:

```text
x = 5
x = 10
```

→ `NAC`.

---

### Trap 4

> Constant propagation is backward.

❌ Normally it is a **forward** analysis.

---

### Trap 5

> `x = y` is constant propagation.

Not necessarily.

If `y` is not known to be constant, it is **copy propagation**, not constant propagation.

---

### Trap 6

> Constant propagation alone evaluates arithmetic expressions.

Not necessarily.

```text
x = 5
y = x + 2
```

Propagation gives:

```text
y = 5 + 2
```

Evaluation to `7` is **constant folding**.

---

# 27. PYQ Patterns ⭐⭐⭐⭐⭐

GATE commonly tests this topic through:

### Pattern 1 — Identify optimization

Given:

```text
x = 10
y = x + 5
```

Ask what optimization can transform it.

Answer:

**Constant propagation**, followed by possible constant folding.

---

### Pattern 2 — Multiple control-flow paths

Given:

```text
if (...)
    x = 5
else
    x = 10

y = x
```

Determine whether `x` can be replaced by a constant.

Answer:

**No**, because multiple different constants can reach the use.

---

### Pattern 3 — Same constant on multiple paths

```text
if (...)
    x = 5
else
    x = 5

y = x
```

Here:

```text
x = 5
```

can still be propagated.

---

### Pattern 4 — Cascading propagation

```text
a = 5
b = a
c = b
d = c + 10
```

Final:

```text
d = 15
```

after propagation + folding.

---

### Pattern 5 — Interaction with dead-code elimination

Constant propagation simplifies a condition, which may make one branch unreachable.

---

# 28. 🧠 GATE Master Table

| Optimization          | Example                   | Main idea                    |
| --------------------- | ------------------------- | ---------------------------- |
| Constant propagation  | `x=5; y=x` → `y=5`        | Replace variable by constant |
| Constant folding      | `y=5+2` → `y=7`           | Evaluate constants           |
| Copy propagation      | `x=y; z=x` → `z=y`        | Replace copy                 |
| CSE                   | `a+b` repeated            | Reuse expression             |
| Dead-code elimination | unused assignment         | Remove useless code          |
| Strength reduction    | expensive op → cheaper op | Reduce operation cost        |

---

# 29. 🔥 Most Important Rules

```text
Same constant from all paths
        ↓
Can propagate
```

```text
Different constants from different paths
        ↓
NAC
```

```text
Variable = constant
        ↓
Constant propagation
```

```text
Constant expression
        ↓
Constant folding
```

```text
Variable = another variable
        ↓
Copy propagation
```

```text
Constant propagation
        ↓
May enable
        ↓
Constant folding
        ↓
May enable
        ↓
Dead-code elimination
```

---

# 30. Last-Minute Revision

### Constant Propagation

> Replace a variable with its known constant value.

### Constant Folding

> Evaluate an expression whose operands are constants.

### Copy Propagation

> Replace a copied variable with its source variable.

### Data-flow direction

```text
Constant Propagation → Forward
```

### Multiple paths

```text
5 + 5 → 5
5 + 10 → NAC
```

### Key relationship

```text
Reaching Definitions
        ↓
Determine possible definitions
        ↓
Constant information
        ↓
Constant Propagation
```

---

# ✅ Final GATE Checklist

* [ ] Definition of constant propagation
* [ ] Constant propagation vs folding
* [ ] Constant propagation vs copy propagation
* [ ] `UNDEF`
* [ ] Constant value
* [ ] `NAC`
* [ ] Meet operation
* [ ] Multiple definitions
* [ ] Multiple CFG paths
* [ ] Forward data-flow analysis
* [ ] Fixed-point computation
* [ ] Cascading propagation
* [ ] Interaction with dead-code elimination
* [ ] PYQ-style control-flow problems

## ⭐ Priority

```text
⭐⭐⭐⭐⭐ Multiple-path questions
⭐⭐⭐⭐⭐ Constant vs NAC
⭐⭐⭐⭐⭐ Propagation + Folding
⭐⭐⭐⭐ Data-flow formulation
⭐⭐⭐⭐ Reaching Definitions relationship
⭐⭐⭐ Copy Propagation comparison
```

**Next according to your folder: `09-Liveness-Analysis.md`**
