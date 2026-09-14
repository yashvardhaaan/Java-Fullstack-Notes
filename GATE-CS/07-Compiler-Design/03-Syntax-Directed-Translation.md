# 07 — COMPILER DESIGN

## 03 — Syntax-Directed Translation — GATE CSE Notes

> **GATE Priority: ⭐⭐⭐⭐ HIGH**
>
> Main focus: **SDD, SDT, synthesized/inherited attributes, dependency graphs, evaluation order, annotated parse trees, type checking, postfix generation, and L-/S-attributed definitions.**

---

# 1. What is Syntax-Directed Translation?

**Syntax-Directed Translation (SDT)** associates semantic actions with the grammar so that some translation or semantic information can be produced while parsing.

Basic idea:

$$
\boxed{\text{Grammar + Semantic Information} \rightarrow \text{Translation}}
$$

Example:

$$
E\rightarrow E+T
$$

can have an associated semantic rule such as:

$$
E.val=E_1.val+T.val
$$

---

# 2. Syntax-Directed Definition (SDD)

An **SDD** is a CFG together with:

1. **Attributes** associated with grammar symbols.
2. **Semantic rules** associated with productions.

Example:

$$
E\rightarrow E_1+T
$$

Semantic rule:

$$
E.val=E_1.val+T.val
$$

Here:

```text
E.val
E₁.val
T.val
```

are attributes.

---

# 3. Attributes

There are two major types:

$$
\boxed{\text{Synthesized}}
$$

and

$$
\boxed{\text{Inherited}}
$$

This distinction is **extremely important for GATE**.

---

# 4. Synthesized Attribute

A synthesized attribute is calculated from the attributes of:

$$
\boxed{\text{Children}}
$$

of a node.

Information flows:

```text id="j9j8lm"
      Parent
        ↑
        |
      Child
```

### Example

$$
E\rightarrow E_1+T
$$

$$
E.val=E_1.val+T.val
$$

`E.val` is synthesized because it depends on:

* `E₁.val`
* `T.val`

which belong to its children.

---

# 5. Inherited Attribute

An inherited attribute is obtained from:

* Parent
* Siblings

Information flows:

```text id="2v8xkk"
       Parent
          |
          ↓
       Child
```

or between siblings.

Example:

$$
A\rightarrow BC
$$

Suppose:

$$
C.in=B.val
$$

Then `C.in` is inherited from its sibling `B`.

---

# 6. 🔥 GATE Memory Trick

### Synthesized

$$
\boxed{\text{Child → Parent}}
$$

### Inherited

$$
\boxed{\text{Parent/Sibling → Child}}
$$

Remember:

> **S = Subtree result comes upward**

> **I = Information comes In**

---

# 7. Example of Synthesized Attributes

Grammar:

$$
E\rightarrow E_1+T
$$

$$
E\rightarrow T
$$

$$
T\rightarrow digit
$$

Semantic rules:

$$
E.val=E_1.val+T.val
$$

$$
E.val=T.val
$$

$$
T.val=digit.lexval
$$

For:

$$
3+5
$$

we obtain:

$$
T.val=3
$$

$$
T.val=5
$$

then:

$$
E.val=3+5=8
$$

---

# 8. Annotated Parse Tree

For:

$$
3+5
$$

conceptually:

```text id="p8r1x3"
             E
          val = 8
           / | \
          E  +  T
        val=3  val=5
         |      |
         3      5
```

Values are calculated **bottom-up**.

Therefore:

$$
\boxed{\text{Synthesized attributes naturally support bottom-up evaluation}}
$$

---

# 9. Inherited Attribute Example

Suppose:

$$
D\rightarrow TL
$$

where `D` represents a declaration and `T` represents the type.

We may have:

$$
L.in=T.type
$$

Here the type obtained from `T` is passed into `L`.

Conceptually:

```text id="s7n1dn"
          D
         / \
        T   L
        |   ↑
      type  |
          T.type
```

`L.in` is inherited.

---

# 10. Dependency Graph

A **dependency graph** represents dependencies among attributes.

Suppose:

$$
A\rightarrow BC
$$

and:

$$
B.x=f(C.y)
$$

Then:

$$
C.y\rightarrow B.x
$$

The dependency graph contains an edge:

$$
\boxed{C.y\rightarrow B.x}
$$

---

# 11. Evaluation Order

Attributes must be evaluated according to their dependencies.

If:

$$
A\rightarrow B
$$

and:

$$
B.x\rightarrow A.y
$$

then:

```text id="7g4lj8"
B.x
 ↓
A.y
```

So `B.x` must be computed first.

A valid evaluation order is a:

$$
\boxed{\text{Topological ordering}}
$$

of the dependency graph.

---

# 12. Circular Dependency

Suppose:

$$
A.x=B.y
$$

and:

$$
B.y=A.x
$$

Then:

```text id="y5km6f"
A.x → B.y
 ↑       |
 |       ↓
 └───────
```

This is a cycle.

Therefore:

$$
\boxed{\text{Circular dependency}}
$$

and the attributes cannot be evaluated using a simple dependency-respecting ordering.

### GATE Trick

$$
\boxed{\text{Cycle in dependency graph → circular dependency}}
$$

---

# 13. S-Attributed Definition

An SDD is **S-attributed** if it uses:

$$
\boxed{\text{Only synthesized attributes}}
$$

Example:

$$
E.val=E_1.val+T.val
$$

No inherited attributes are used.

---

# 14. Why S-Attributed Definitions are Important

They are especially convenient for **bottom-up parsing**.

Information naturally moves:

```text id="4a5y2p"
Leaves
 ↓
Subtrees
 ↓
Root
```

Therefore:

$$
\boxed{\text{S-attributed → Bottom-up friendly}}
$$

---

# 15. L-Attributed Definition

An SDD is **L-attributed** if inherited attributes satisfy restrictions that allow evaluation from left to right.

For production:

$$
A\rightarrow X_1X_2...X_n
$$

an inherited attribute of \(X_i\) may depend on:

* inherited attributes of `A`
* attributes of symbols \(X_1,\ldots,X_{i-1}\) to its **left**
* subject to the formal L-attributed restriction.

It must **not depend on a symbol to its right** in a way that violates the left-to-right evaluation condition.

---

# 16. 🔥 GATE Memory Trick for L-Attributed

Think:

$$
\boxed{\text{Information can come from the LEFT}}
$$

For:

```text id="c0n6ec"
A → X₁ X₂ X₃
```

When processing `X₃`, information may come from:

```text id="fz9y4d"
A
X₁
X₂
```

but not from `X₄` or symbols to the right.

---

# 17. Relationship Between S and L

Very important:

$$
\boxed{S\text{-attributed} \subseteq L\text{-attributed}}
$$

Every S-attributed definition is L-attributed.

Why?

Because synthesized attributes do not violate the left-to-right restriction.

---

# 18. SDD vs SDT

Do not confuse these.

### SDD

Specifies:

```text id="9c1w1h"
Grammar
+
Attributes
+
Semantic Rules
```

It describes **what** should be computed.

---

### SDT

Embeds semantic actions directly inside productions.

Example:

$$
E\rightarrow E+T\ \{print("+")\}
$$

It specifies actions to be executed during parsing.

### GATE shortcut

$$
\boxed{SDD=\text{attributes + rules}}
$$

$$
\boxed{SDT=\text{grammar + embedded actions}}
$$

---

# 19. Postfix Translation

A classic syntax-directed translation problem.

Infix:

$$
a+b
$$

Postfix:

$$
ab+
$$

Grammar:

$$
E\rightarrow E+T
$$

$$
E\rightarrow T
$$

Suppose semantic action:

```text id="gkqg6m"
E → E + T { print('+') }
```

Then operands are printed first and operator afterward.

Result:

$$
\boxed{ab+}
$$

---

# 20. Infix → Postfix Trick

### Infix

$$
a+b*c
$$

### Postfix

$$
\boxed{abc*+}
$$

Reason:

1. `b*c` first
2. Then `a + result`

---

# 21. Prefix vs Postfix

For:

$$
a+b
$$

### Infix

$$
a+b
$$

### Prefix

$$
+ab
$$

### Postfix

$$
ab+
$$

### GATE Trick

```text id="v3z5si"
Prefix  → Operator first
Infix   → Operator middle
Postfix → Operator last
```

---

# 22. Syntax-Directed Translation for Postfix

Example grammar:

$$
E\rightarrow E+T
$$

Semantic action:

$$
\{print(+)\}
$$

The parse proceeds and eventually prints:

```text id="3sqj3h"
a b +
```

Therefore:

$$
\boxed{ab+}
$$

---

# 23. Type Checking Using Attributes

Syntax-directed definitions are also used for semantic analysis.

Example:

$$
E\rightarrow E_1+E_2
$$

We can define:

$$
E.type=typecheck(E_1.type,E_2.type)
$$

For:

```text id="1iyr3w"
int + int
```

result:

```text id="wz9x4g"
int
```

For incompatible operands, an error may be generated.

---

# 24. Symbol Table and Attributes

Attributes can carry information such as:

```text id="y1xzh7"
type
width
address
value
scope
```

Example:

$$
T.type=int
$$

and this information can be propagated to identifiers in declarations.

---

# 25. Width Calculation

Syntax-directed translation can calculate memory width.

Example:

```text id="f3m7j0"
int → width = 4
float → width = 8
```

For:

$$
A\rightarrow B
$$

we may have:

$$
A.width=B.width
$$

For arrays:

$$
A\rightarrow array[num]\ of\ T
$$

we can calculate:

$$
\boxed{A.width=num\times T.width}
$$

---

# 26. Dependency Graph — GATE Example

Suppose:

$$
A.x=B.y+C.z
$$

Dependencies:

$$
B.y\rightarrow A.x
$$

$$
C.z\rightarrow A.x
$$

Graph:

```text id="s2k4dq"
B.y ──┐
      ├──→ A.x
C.z ──┘
```

Therefore:

```text id="u4mx8h"
B.y and C.z
      ↓
    A.x
```

Both must be computed before `A.x`.

---

# 27. Evaluation of Synthesized Attributes

Suppose:

$$
A.x=f(B.y,C.z)
$$

Then:

$$
B.y,C.z
$$

must be evaluated first.

This naturally corresponds to:

$$
\boxed{\text{Postorder traversal}}
$$

of the parse tree.

---

# 28. Evaluation of Inherited Attributes

Inherited information generally moves:

```text id="2b7p4z"
Parent → Child
```

or:

```text id="n2yybq"
Left sibling → Right sibling
```

Thus L-attributed definitions can be evaluated in a left-to-right traversal.

---

# 29. 🔥 Very Important Relationship

| Definition   | Attributes                         |
| ------------ | ---------------------------------- |
| S-attributed | Only synthesized                   |
| L-attributed | Restricted inherited + synthesized |
| S-attributed | Always L-attributed                |
| L-attributed | Not necessarily S-attributed       |

Therefore:

$$
\boxed{S\subseteq L}
$$

---

# 30. Common GATE Trap

### Statement:

> Every inherited attribute makes an SDD non-L-attributed.

❌ False.

Inherited attributes are allowed in an L-attributed definition **if they satisfy the left-to-right dependency restriction**.

---

# 31. Another GATE Trap

### Statement:

> Every L-attributed definition contains inherited attributes.

❌ False.

An S-attributed definition is also L-attributed.

So an L-attributed definition may contain:

* only synthesized attributes, or
* synthesized + permitted inherited attributes.

---

# 32. Another Important Trap

### Statement:

> Synthesized attributes can depend only on terminals.

❌ False.

A synthesized attribute can depend on attributes of **children**, including non-terminals.

Example:

$$
E.val=E_1.val+T.val
$$

---

# 33. Semantic Actions

An SDT can place actions at different positions.

Example:

$$
A\rightarrow X\ \{action\}\ Y
$$

The action executes at a specific point during parsing.

This is important when converting SDDs into SDTs.

---

# 34. Postfix Example — GATE Style

Grammar:

$$
E\rightarrow E+T
$$

$$
E\rightarrow T
$$

$$
T\rightarrow id
$$

If semantic action is:

$$
E\rightarrow E+T\ \{print(+)\}
$$

For:

$$
a+b
$$

output:

```text id="tqk8wy"
a b +
```

Therefore:

$$
\boxed{ab+}
$$

---

# 35. Parse Tree vs Syntax Tree

### Parse Tree

Contains all grammar details.

### Syntax Tree / AST

Removes unnecessary grammar details.

For:

$$
a+b*c
$$

AST:

```text id="e7l1ha"
       +
      / \
     a   *
        / \
       b   c
```

The AST is more compact.

---

# 36. Semantic Analysis Connection

Syntax-directed definitions are heavily used for:

* Type checking
* Scope checking
* Declaration processing
* Intermediate code generation
* Storage layout
* Expression translation

---

# 37. PYQ Pattern 1 — Attribute Classification

Question gives:

$$
A\rightarrow BC
$$

and:

$$
A.x=f(B.y,C.z)
$$

Ask: What type is `A.x`?

Since it depends on children:

$$
\boxed{\text{Synthesized}}
$$

---

# 38. PYQ Pattern 2 — Inherited Attribute

Given:

$$
A\rightarrow BC
$$

and:

$$
C.in=B.type
$$

`C.in` depends on sibling `B`.

Therefore:

$$
\boxed{\text{Inherited}}
$$

---

# 39. PYQ Pattern 3 — Dependency Graph

Given:

$$
A.x=B.y+C.z
$$

Edges:

$$
B.y\rightarrow A.x
$$

$$
C.z\rightarrow A.x
$$

Question may ask:

* Number of edges
* Valid evaluation order
* Whether a cycle exists
* Which attribute must be evaluated first

---

# 40. PYQ Pattern 4 — Circular Dependency

Given:

$$
A.x=B.y
$$

$$
B.y=A.x
$$

Answer:

$$
\boxed{\text{Circular dependency}}
$$

No valid topological evaluation order exists.

---

# 41. PYQ Pattern 5 — S vs L Attribution

Question:

> An SDD has only synthesized attributes. What can be concluded?

Answer:

$$
\boxed{\text{It is S-attributed and therefore L-attributed}}
$$

---

# 42. PYQ Pattern 6 — Postfix

Given an expression and semantic actions such as:

```text id="q1i8a8"
{ print(op) }
```

calculate the output.

### Trick

For postfix:

$$
\boxed{\text{Print operator after operands}}
$$

---

# 43. PYQ Pattern 7 — Type Propagation

Given:

$$
D\rightarrow TL
$$

and:

$$
L.in=T.type
$$

ask the type of the identifiers in `L`.

The type flows:

```text id="1zsljr"
T
 ↓
L.in
 ↓
Identifiers
```

This is an inherited-attribute style problem.

---

# 44. High-Yield Comparison

| Concept          | Key Point                             |
| ---------------- | ------------------------------------- |
| SDD              | Attributes + semantic rules           |
| SDT              | Semantic actions embedded in grammar  |
| Synthesized      | Child → Parent                        |
| Inherited        | Parent/Sibling → Child                |
| S-attributed     | Only synthesized                      |
| L-attributed     | Restricted left-to-right dependencies |
| Dependency graph | Attribute dependencies                |
| Cycle            | Circular dependency                   |
| Evaluation order | Topological order                     |
| Postfix          | Operator after operands               |
| Prefix           | Operator before operands              |

---

# 45. 🧠 30-Second GATE Revision

```text id="f4j83s"
SDD
 ↓
Attributes + Semantic Rules
```

### Attributes

$$
\boxed{Synthesized=Children\rightarrow Parent}
$$

$$
\boxed{Inherited=Parent/Sibling\rightarrow Child}
$$

### Special classes

$$
\boxed{S-attributed=Only\ Synthesized}
$$

$$
\boxed{S-attributed\subseteq L-attributed}
$$

### Dependency

```text id="5ay9wq"
Attribute A
    ↓
Attribute B
```

means:

$$
A\text{ must be evaluated before }B
$$

### Cycle

$$
\boxed{\text{No valid topological ordering}}
$$

### Translation

```text id="xqj6p4"
Infix  → a+b
Prefix → +ab
Postfix → ab+
```

---

# 🎯 GATE Final Checklist

* [ ] Syntax-directed definition
* [ ] Syntax-directed translation
* [ ] Attributes
* [ ] Synthesized attributes
* [ ] Inherited attributes
* [ ] S-attributed definitions
* [ ] L-attributed definitions
* [ ] S ⊆ L relationship
* [ ] Dependency graph
* [ ] Topological evaluation
* [ ] Circular dependency
* [ ] Semantic actions
* [ ] Infix → postfix translation
* [ ] Type checking using attributes
* [ ] Width/address calculation
* [ ] Attribute propagation
* [ ] Parse tree vs AST
* [ ] PYQ-style attribute classification

### ⭐ Most important formulas/facts

$$
\boxed{S\text{-attributed}\Rightarrow L\text{-attributed}}
$$

$$
\boxed{Synthesized:\ Child\rightarrow Parent}
$$

$$
\boxed{Inherited:\ Parent/Sibling\rightarrow Child}
$$

$$
\boxed{\text{Cycle in dependency graph}\Rightarrow\text{circular dependency}}
$$

$$
\boxed{\text{Valid evaluation order}=\text{topological order}}
$$

**Next: `04-Runtime-Environments.md`**.
