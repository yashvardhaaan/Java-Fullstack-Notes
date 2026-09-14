# 07 — COMPILER DESIGN

## 05 — Intermediate Code Generation — GATE CSE Notes

> **GATE Priority: ⭐⭐⭐⭐⭐ VERY HIGH**
>
> Focus heavily on **three-address code, quadruples, triples, indirect triples, temporary variables, basic blocks, control-flow translation, boolean expressions, backpatching, and DAGs**.

---

# 1. What is Intermediate Code?

After semantic analysis, the compiler generates an **intermediate representation (IR)** before producing target-machine code.

```text
Source Program
      ↓
Lexical Analysis
      ↓
Parsing
      ↓
Semantic Analysis
      ↓
Intermediate Code
      ↓
Optimization
      ↓
Target Code
```

The intermediate representation provides a machine-independent form.

$$
\boxed{\text{Source Code} \rightarrow IR \rightarrow Target Code}
$$

---

# 2. Why Intermediate Code?

Main advantages:

### 1. Machine independence

The same IR can be used for different target machines.

### 2. Optimization

Optimization can be performed on IR.

### 3. Easier code generation

Target-specific code generation is separated from earlier compiler phases.

---

# 3. Three-Address Code

The most important IR for GATE.

A typical three-address instruction has at most:

$$
\boxed{3\text{ addresses}}
$$

General form:

$$
x=y\ op\ z
$$

Example:

```text id="y0a8p7"
t1 = b * c
t2 = a + t1
```

---

# 4. Why Temporary Variables?

Consider:

$$
a+b*c
$$

Three-address code:

```text id="5t4k21"
t1 = b * c
t2 = a + t1
```

`t1` stores the intermediate result.

---

# 5. Three-Address Code Examples

## Assignment

$$
x=y
$$

```text id="f6s9lm"
x = y
```

---

## Binary operation

$$
x=y+z
$$

```text id="5iqz1c"
x = y + z
```

---

## Unary operation

$$
x=-y
$$

```text id="tqf5ax"
x = -y
```

---

## Array access

Conceptually:

```text id="8j7s6x"
t1 = i * width
t2 = base(A) + t1
```

---

# 6. Expression Translation

Consider:

$$
a+b*c
$$

Because multiplication has higher precedence:

$$
a+(b*c)
$$

Three-address code:

```text id="1l5o5s"
t1 = b * c
t2 = a + t1
```

---

# 7. Example: Complex Expression

Consider:

$$
a*b+c*d
$$

Three-address code:

```text id="q2v6xu"
t1 = a * b
t2 = c * d
t3 = t1 + t2
```

Number of temporary variables:

$$
\boxed{3}
$$

---

# 8. Example with Parentheses

$$
(a+b)*(c-d)
$$

TAC:

```text id="1xxpgo"
t1 = a + b
t2 = c - d
t3 = t1 * t2
```

---

# 9. 🔥 GATE Trick — Number of Temporaries

For an expression, evaluate subexpressions according to precedence and introduce temporaries for intermediate results.

Example:

$$
a+b*c-d
$$

TAC:

```text id="l3k9fq"
t1 = b * c
t2 = a + t1
t3 = t2 - d
```

So:

$$
\boxed{3\text{ operations}}
$$

and typically 3 TAC instructions.

---

# 10. Representations of Three-Address Code

Three major representations:

$$
\boxed{\text{Quadruples}}
$$

$$
\boxed{\text{Triples}}
$$

$$
\boxed{\text{Indirect Triples}}
$$

---

# 11. Quadruples

Each instruction has four fields:

$$
\boxed{(op,\ arg1,\ arg2,\ result)}
$$

Example:

```text id="4g7x5a"
t1 = a + b
```

Quadruple:

$$
\boxed{(+,a,b,t1)}
$$

---

# 12. Quadruple Example

TAC:

```text id="q5g8f4"
t1 = a + b
t2 = t1 * c
```

Quadruples:

| # | op  | arg1 | arg2 | result |
| - | --- | ---- | ---- | ------ |
| 0 | `+` | a    | b    | t1     |
| 1 | `*` | t1   | c    | t2     |

---

# 13. Triples

Triples use three fields:

$$
\boxed{(op,\ arg1,\ arg2)}
$$

The result is implicitly represented by the **instruction number**.

Example:

```text id="cxz5e5"
t1 = a + b
t2 = t1 * c
```

Triples:

| # | op | arg1 | arg2 |
| - | -- | ---- | ---- |
| 0 | +  | a    | b    |
| 1 | *  | (0)  | c    |

Here `(0)` refers to the result of triple 0.

---

# 14. 🔥 Quadruple vs Triple

| Quadruple                | Triple                                      |
| ------------------------ | ------------------------------------------- |
| 4 fields                 | 3 fields                                    |
| Explicit result field    | Result identified by position               |
| Uses temporary names     | Uses instruction references                 |
| Easier to rearrange code | Code movement can require reference changes |

---

# 15. Indirect Triples

Indirect triples add a separate list of pointers/references to triples.

Conceptually:

```text id="u6s3zn"
Pointer Table
   ↓
Triples
```

The pointer table can be rearranged without changing the triples themselves.

---

# 16. GATE Trick

Memorize:

$$
\boxed{Quadruple=(op,arg1,arg2,result)}
$$

$$
\boxed{Triple=(op,arg1,arg2)}
$$

$$
\boxed{Indirect\ Triple=Pointer\ Table+Triples}
$$

---

# 17. Boolean Expressions

Boolean expressions are particularly important because they often use **short-circuit evaluation**.

Example:

```c id="b7p0uj"
if (a < b && c < d)
```

For `&&`:

> If the first condition is false, the second condition need not be evaluated.

---

# 18. Short-Circuit Evaluation

### AND

$$
A\land B
$$

If:

$$
A=false
$$

then:

$$
A\land B=false
$$

without evaluating `B`.

---

### OR

$$
A\lor B
$$

If:

$$
A=true
$$

then:

$$
A\lor B=true
$$

without evaluating `B`.

---

# 19. 🔥 GATE Trick

```text id="kztrg0"
A && B
```

If `A = false`:

$$
\boxed{B\text{ is skipped}}
$$

```text id="b8n2x8"
A || B
```

If `A = true`:

$$
\boxed{B\text{ is skipped}}
$$

---

# 20. Conditional Statements

Consider:

```c id="f0h8l1"
if (a < b)
    x = y;
else
    x = z;
```

Possible TAC:

```text id="xw8q7n"
if a < b goto L1
goto L2

L1:
x = y
goto L3

L2:
x = z

L3:
```

---

# 21. Unconditional Jump

```text id="0s9mqp"
goto L1
```

means transfer control directly to label `L1`.

---

# 22. Conditional Jump

```text id="8k3p0q"
if x < y goto L1
```

Control goes to `L1` only if:

$$
x<y
$$

is true.

---

# 23. While Loop

Source:

```c id="5s6hpx"
while (a < b) {
    x = x + 1;
}
```

TAC:

```text id="d7q7yr"
L1:
if a < b goto L2
goto L3

L2:
t1 = x + 1
x = t1
goto L1

L3:
```

Important:

$$
\boxed{\text{Loop requires a backward jump}}
$$

---

# 24. For Loop

Conceptually:

```c id="c5q2qk"
for(initialization; condition; update)
    body;
```

can be represented as:

```text id="w9g8v0"
initialization

L1:
if condition goto L2
goto L4

L2:
body

L3:
update
goto L1

L4:
```

---

# 25. Basic Block

A **basic block** is a maximal sequence of consecutive statements with:

* One entry point
* One exit point

No jump enters the middle of the block.

---

# 26. Leaders

To divide TAC into basic blocks, identify **leaders**.

A statement is a leader if:

### Rule 1

The first statement is a leader.

### Rule 2

The target of a conditional/unconditional jump is a leader.

### Rule 3

The statement immediately following a jump is a leader.

---

# 27. 🔥 GATE Leader Trick

Given:

```text id="k5m8a3"
1: a = b + c
2: if a > 0 goto 5
3: d = e + f
4: goto 6
5: x = y + z
6: ...
```

Leaders:

* `1` → first statement
* `5` → jump target
* `3` → statement after conditional jump
* `6` → jump target

Therefore:

$$
\boxed{\{1,3,5,6\}}
$$

---

# 28. Basic Block Construction

Once leaders are identified:

> Each leader starts a block that continues until just before the next leader.

Example:

```text id="7h3w5c"
B1: 1,2

B2: 3,4

B3: 5

B4: 6,...
```

---

# 29. Control Flow Graph

A **Control Flow Graph (CFG)** represents possible control flow between basic blocks.

```text id="e9v1dd"
       B1
      /  \
     ↓    ↓
    B2    B3
     \    /
       ↓
       B4
```

Each node:

$$
\boxed{\text{Basic Block}}
$$

Each edge:

$$
\boxed{\text{Possible control transfer}}
$$

---

# 30. Back Edge

In a loop, a control-flow edge goes back to an earlier block.

Example:

```text id="w7o3r1"
B1 → B2 → B3
     ↑       |
     └───────┘
```

The edge:

$$
B3\rightarrow B2
$$

is a **back edge**.

### GATE

Back edges are strongly associated with loops.

---

# 31. DAG for Basic Block

A **DAG (Directed Acyclic Graph)** can represent expressions within a basic block.

It helps identify:

* Common subexpressions
* Dead computations
* Redundant calculations

---

# 32. Common Subexpression

Consider:

```text id="q5n1g8"
t1 = a + b
t2 = a + b
```

The second computation is redundant if neither `a` nor `b` changed between them.

DAG can represent:

```text id="5o6q4z"
      +
     / \
    a   b
```

and reuse the same node.

---

# 33. Backpatching

**Backpatching** is used when the target address/label of a jump is not known when the instruction is initially generated.

Example:

```text id="m7n3aq"
if a < b goto ___
```

The target is filled later.

This is particularly important in translating:

* Boolean expressions
* `if`
* `while`
* Short-circuit expressions

---

# 34. Backpatching Lists

Common lists:

$$
\boxed{truelist}
$$

$$
\boxed{falselist}
$$

$$
\boxed{nextlist}
$$

### `truelist`

Contains jumps whose targets should be the **true** branch.

### `falselist`

Contains jumps whose targets should be the **false** branch.

### `nextlist`

Contains jumps to the next statement.

---

# 35. 🔥 Backpatching Trick

Remember:

```text id="9m5qjx"
Boolean expression
     ↓
truelist
falselist
```

Statements/control flow:

```text id="4q7w6p"
Statement
    ↓
nextlist
```

---

# 36. `&&` and Backpatching

For:

$$
B_1\land B_2
$$

If `B₁` is true, we must evaluate `B₂`.

Therefore:

$$
\boxed{backpatch(B_1.truelist,\ beginning\ of\ B_2)}
$$

The false list becomes:

$$
\boxed{B_1.falselist\cup B_2.falselist}
$$

---

# 37. `||` and Backpatching

For:

$$
B_1\lor B_2
$$

If `B₁` is false, evaluate `B₂`.

Therefore:

$$
\boxed{backpatch(B_1.falselist,\ beginning\ of\ B_2)}
$$

True list becomes:

$$
\boxed{B_1.truelist\cup B_2.truelist}
$$

---

# 38. 🔥 Super Important

### AND

$$
\boxed{B_1.true\rightarrow B_2}
$$

### OR

$$
\boxed{B_1.false\rightarrow B_2}
$$

This is a very useful GATE shortcut.

---

# 39. Three-Address Code for Array Access

Suppose:

```c id="4g3e9s"
x = A[i]
```

For a one-dimensional array with element width `w`:

$$
offset=i\times w
$$

Then:

```text id="h5t7w0"
t1 = i * w
t2 = A[t1]
x = t2
```

Exact representation varies depending on IR conventions.

---

# 40. Address Calculation

For:

$$
A[i]
$$

if:

* Base address = `B`
* Element width = `w`

then:

$$
\boxed{Address(A[i])=B+i\times w}
$$

This is frequently useful in code-generation questions.

---

# 41. Two-Dimensional Array

For row-major array:

$$
A[i][j]
$$

with:

* Number of columns = `N`
* Element width = `w`

offset:

$$
\boxed{(iN+j)w}
$$

Therefore:

$$
Address=A_{base}+(iN+j)w
$$

---

# 42. Pointer Operations

TAC may represent:

### Address-of

$$
x=\&y
$$

### Dereference

$$
x=*y
$$

### Assignment through pointer

$$
*x=y
$$

These are commonly used in intermediate representations.

---

# 43. Procedure Calls in TAC

Typical forms:

```text id="7eqp6m"
param x
param y
call f, 2
```

or:

```text id="h9a5vx"
t1 = call f, 2
```

depending on the IR.

---

# 44. Return

Example:

```text id="0kr9qh"
return x
```

or:

```text id="3q8m1r"
return
```

for a procedure without a value.

---

# 45. GATE PYQ Pattern — Quadruples

Given:

```text id="r8h2u0"
t1 = a + b
t2 = t1 * c
```

Quadruples:

$$
(+,a,b,t1)
$$

$$
(*,t1,c,t2)
$$

The most common mistake is putting the result in the wrong field.

---

# 46. PYQ Pattern — Triples

For:

```text id="c8w0xy"
t1 = a + b
t2 = t1 * c
```

Triples:

```text id="f1v6l2"
0: (+, a, b)
1: (*, (0), c)
```

The result of instruction `0` is referred to by `(0)`.

---

# 47. PYQ Pattern — Leaders

Given a TAC sequence:

```text id="9i3c7n"
1: ...
2: goto 5
3: ...
4: if ... goto 7
5: ...
6: ...
7: ...
```

Leaders include:

$$
\boxed{1,3,5,7}
$$

because:

* `1` is first
* `3` follows a jump
* `5` is a jump target
* `7` is a jump target

---

# 48. PYQ Pattern — Number of Basic Blocks

Procedure:

### Step 1

Find all leaders.

### Step 2

Sort them.

### Step 3

Each leader starts one block.

Therefore:

$$
\boxed{\#Basic\ Blocks=\#Leaders}
$$

---

# 49. PYQ Pattern — Short Circuit

For:

```c id="h8v9s0"
if (A && B)
```

If `A` is false:

$$
\boxed{B\text{ is not evaluated}}
$$

For:

```c id="8s1h7a"
if (A || B)
```

If `A` is true:

$$
\boxed{B\text{ is not evaluated}}
$$

---

# 50. PYQ Pattern — Common Subexpression

Given:

```text id="2n7w1v"
t1 = a + b
x = t1 * c
t2 = a + b
```

If `a` and `b` have not changed:

$$
\boxed{t2=t1}
$$

can replace recomputation.

This is a classic optimization opportunity.

---

# 51. Common GATE Traps

### ❌ Trap 1

> Triple has four fields.

False.

$$
\boxed{Triple=3\ fields}
$$

---

### ❌ Trap 2

> Quadruple result is implicit.

False.

Quadruple explicitly stores:

$$
\boxed{result}
$$

---

### ❌ Trap 3

> Every statement after a conditional jump is always a leader.

Yes, under the standard leader algorithm.

---

### ❌ Trap 4

> Only jump targets are leaders.

False.

The statement immediately following a jump is also a leader.

---

### ❌ Trap 5

> `&&` evaluates both operands.

Not necessarily.

Short-circuit semantics can skip the second operand.

---

# 52. Important Comparison

| Representation  |                 Fields | Result               |
| --------------- | ---------------------: | -------------------- |
| Quadruple       |                      4 | Explicit             |
| Triple          |                      3 | Instruction position |
| Indirect Triple | Triple + pointer table | Indirect reference   |

---

# 53. Important Control-Flow Terms

| Term         | Meaning                              |
| ------------ | ------------------------------------ |
| Basic block  | One-entry, one-exit sequence         |
| Leader       | Beginning of basic block             |
| CFG          | Graph of basic blocks                |
| Back edge    | Edge toward earlier block            |
| DAG          | Expression dependencies inside block |
| Backpatching | Fill unknown jump targets later      |
| `truelist`   | True-condition jumps                 |
| `falselist`  | False-condition jumps                |
| `nextlist`   | Jumps to next statement              |

---

# 54. 🧠 30-Second GATE Revision

### TAC

$$
\boxed{x=y\ op\ z}
$$

### Quadruple

$$
\boxed{(op,arg1,arg2,result)}
$$

### Triple

$$
\boxed{(op,arg1,arg2)}
$$

### Leaders

```text
1. First statement
2. Jump target
3. Statement after jump
```

### Basic block

$$
\boxed{\text{One entry + one exit}}
$$

### Short circuit

$$
\boxed{A\&\&B:\ A=false\Rightarrow skip\ B}
$$

$$
\boxed{A||B:\ A=true\Rightarrow skip\ B}
$$

### Backpatching

$$
\boxed{\text{Fill unknown jump targets later}}
$$

### Boolean backpatching

$$
\boxed{AND\rightarrow B_1.true\rightarrow B_2}
$$

$$
\boxed{OR\rightarrow B_1.false\rightarrow B_2}
$$

---

# 🎯 GATE Final Checklist

* [ ] Intermediate representation
* [ ] Three-address code
* [ ] Temporary variables
* [ ] Expression translation
* [ ] Quadruples
* [ ] Triples
* [ ] Indirect triples
* [ ] Boolean expressions
* [ ] Short-circuit evaluation
* [ ] Conditional statements
* [ ] Loops
* [ ] Basic blocks
* [ ] Leaders
* [ ] Control-flow graph
* [ ] Back edges
* [ ] DAG
* [ ] Common subexpressions
* [ ] Backpatching
* [ ] `truelist`
* [ ] `falselist`
* [ ] `nextlist`
* [ ] Array address calculation
* [ ] Procedure calls
* [ ] Return statements

## ⭐ Highest-yield facts

$$
\boxed{TAC:\ x=y\ op\ z}
$$

$$
\boxed{Quadruple=(op,arg1,arg2,result)}
$$

$$
\boxed{Triple=(op,arg1,arg2)}
$$

$$
\boxed{\#Basic\ Blocks=\#Leaders}
$$

$$
\boxed{AND:\ true\ list\rightarrow next\ condition}
$$

$$
\boxed{OR:\ false\ list\rightarrow next\ condition}
$$

$$
\boxed{\text{Backpatching = filling jump targets later}}
$$

**Next: `06-Local-Optimization.md`**.
