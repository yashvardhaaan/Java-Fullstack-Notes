# Propositional and First Order Logic

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# What is Logic?

Logic is the mathematical study of reasoning.

It helps determine whether a statement is **True** or **False**.

Logic is widely used in

- Programming
- Artificial Intelligence
- Databases
- Digital Electronics
- Algorithms
- Compiler Design

---

# Types of Logic

```
Logic
│
├── Propositional Logic
│
└── First Order (Predicate) Logic
```

---

# Propositional Logic

## Definition

A proposition is a declarative statement that is either

- True (T)
- False (F)

There is no third possibility.

---

## Examples

| Statement | Proposition? |
|------------|--------------|
| 2 + 3 = 5 | ✅ |
| Pune is in India | ✅ |
| x > 5 | ❌ (depends on x) |
| Close the door | ❌ |
| What is your name? | ❌ |

---

# Basic Logical Connectives

| Symbol | Name | Meaning |
|---------|------|----------|
| ¬P | NOT | Negation |
| P ∧ Q | AND | Both true |
| P ∨ Q | OR | At least one true |
| P → Q | Implication | If P then Q |
| P ↔ Q | Biconditional | Both have same truth value |

---

# Truth Tables

## NOT

| P | ¬P |
|---|----|
| T | F |
| F | T |

---

## AND

| P | Q | P∧Q |
|---|---|------|
| T | T | T |
| T | F | F |
| F | T | F |
| F | F | F |

---

## OR

| P | Q | P∨Q |
|---|---|------|
| T | T | T |
| T | F | T |
| F | T | T |
| F | F | F |

---

## XOR (Exclusive OR)

True only when exactly one statement is true.

| P | Q | P⊕Q |
|---|---|------|
| T | T | F |
| T | F | T |
| F | T | T |
| F | F | F |

---

## Implication

P → Q

Equivalent to

```
¬P ∨ Q
```

Truth Table

| P | Q | P→Q |
|---|---|------|
| T | T | T |
| T | F | F |
| F | T | T |
| F | F | T |

### Important

Only False when

```
P = True
Q = False
```

---

## Biconditional

P ↔ Q

Equivalent to

```
(P→Q) ∧ (Q→P)
```

| P | Q | P↔Q |
|---|---|------|
| T | T | T |
| T | F | F |
| F | T | F |
| F | F | T |

---

# Operator Precedence

Highest

```
¬
```

↓

```
∧
```

↓

```
∨
```

↓

```
→
```

↓

```
↔
```

Lowest

---

# Tautology

Always True.

Example

```
P ∨ ¬P
```

Truth Table

| P | Result |
|---|--------|
| T | T |
| F | T |

---

# Contradiction

Always False.

Example

```
P ∧ ¬P
```

---

# Contingency

Sometimes True.

Sometimes False.

Example

```
P ∧ Q
```

---

# Logical Equivalences

## Double Negation

```
¬(¬P)=P
```

---

## De Morgan's Laws

```
¬(P∧Q)=¬P∨¬Q
```

```
¬(P∨Q)=¬P∧¬Q
```

---

## Idempotent Laws

```
P∨P=P
```

```
P∧P=P
```

---

## Identity Laws

```
P∨False=P
```

```
P∧True=P
```

---

## Domination Laws

```
P∨True=True
```

```
P∧False=False
```

---

## Complement Laws

```
P∨¬P=True
```

```
P∧¬P=False
```

---

## Commutative Laws

```
P∨Q=Q∨P
```

```
P∧Q=Q∧P
```

---

## Associative Laws

```
(P∨Q)∨R=P∨(Q∨R)
```

```
(P∧Q)∧R=P∧(Q∧R)
```

---

## Distributive Laws

```
P∧(Q∨R)
=(P∧Q)∨(P∧R)
```

```
P∨(Q∧R)
=(P∨Q)∧(P∨R)
```

---

# Converse

Original

```
P→Q
```

Converse

```
Q→P
```

---

# Inverse

```
¬P→¬Q
```

---

# Contrapositive

```
¬Q→¬P
```

### Important

```
P→Q
≡
¬Q→¬P
```

Only the **Contrapositive** is logically equivalent to the original implication.

---

# Predicate (First Order) Logic

Propositional logic cannot represent variables.

Predicate logic introduces

- Variables
- Predicates
- Quantifiers

---

## Predicate

Example

```
P(x)

"x is even."
```

If

```
x=4
```

Then

```
P(4)=True
```

---

# Quantifiers

## Universal Quantifier

```
∀
```

Means

```
For every
```

Example

```
∀x P(x)
```

---

## Existential Quantifier

```
∃
```

Means

```
There exists
```

Example

```
∃x P(x)
```

---

# Negation of Quantifiers

```
¬∀xP(x)
=
∃x¬P(x)
```

```
¬∃xP(x)
=
∀x¬P(x)
```

**Very Important for GATE**

---

# Free vs Bound Variables

## Bound Variable

Appears inside a quantifier.

Example

```
∀x P(x)
```

---

## Free Variable

Not associated with any quantifier.

Example

```
P(x)
```

---

# Common GATE Tricks

- Implication is False only in one case.
- Contrapositive is equivalent to implication.
- Converse is NOT equivalent.
- Inverse is NOT equivalent.
- Apply De Morgan's laws carefully.
- Negating quantifiers is a favorite PYQ topic.

---

# PYQs Asked

- Truth tables
- Logical equivalence
- Tautology
- Contradiction
- De Morgan's laws
- Implication
- Converse/Inverse/Contrapositive
- Predicate logic
- Quantifier negation
- Free vs Bound variables

---

# Quick Revision

✅ Proposition

✅ Connectives

✅ Truth Tables

✅ Tautology

✅ Contradiction

✅ Contingency

✅ Logical Equivalence

✅ De Morgan's Laws

✅ Implication

✅ Converse

✅ Inverse

✅ Contrapositive

✅ Predicate Logic

✅ Universal Quantifier

✅ Existential Quantifier

✅ Quantifier Negation

---

# Common Mistakes

❌ Confusing OR with XOR.

❌ Assuming converse is equivalent.

❌ Forgetting implication truth table.

❌ Incorrect negation of quantifiers.

❌ Ignoring operator precedence.

---

# Memory Tricks

- **Implication (P→Q):** False only when **True → False**.
- **Contrapositive:** The only implication form equivalent to the original.
- **De Morgan:** "Flip the operator and negate each operand."
- **Quantifier Negation:** Change **∀ ↔ ∃** and negate the predicate.

---

# Next File

➡️ `03-Sets.md`