# Partial Orders and Lattices

> GATE Weightage: ⭐⭐⭐⭐

---

# Partial Order

A **Partial Order** is a relation that satisfies three properties:

- Reflexive
- Antisymmetric
- Transitive

Memory Trick

```
RAT

R → Reflexive

A → Antisymmetric

T → Transitive
```

---

# Definition

A relation

```
R ⊆ A × A
```

is a Partial Order if

```
Reflexive

AND

Antisymmetric

AND

Transitive
```

are all satisfied.

---

# Reflexive

Every element is related to itself.

```
(a,a) ∈ R
```

Example

```
1 ≤ 1

2 ≤ 2

3 ≤ 3
```

---

# Antisymmetric

If

```
(a,b) ∈ R

and

(b,a) ∈ R
```

Then

```
a = b
```

Example

```
≤

⊆

Divides (|)
```

---

# Transitive

If

```
(a,b)

∈ R

and

(b,c)

∈ R
```

Then

```
(a,c)

∈ R
```

Example

```
2≤3

3≤5

⇒

2≤5
```

---

# Examples of Partial Orders

✅ Less than or equal to

```
≤
```

---

✅ Subset

```
⊆
```

---

✅ Divisibility

```
|
```

---

❌ Friendship

Not antisymmetric.

---

# Non-Examples

```
<
```

Not reflexive.

---

```
=
```

Not a Partial Order in GATE context (it is an equivalence relation instead).

---

# Poset

A set together with a partial order is called a

```
Poset

(Partially Ordered Set)
```

Notation

```
(A,R)
```

Example

```
({1,2,3},≤)
```

---

# Comparable Elements

Two elements

```
a,b
```

are comparable if

```
aRb

OR

bRa
```

---

Example

```
2≤5
```

Comparable.

---

Example

```
{1}

{2}
```

under subset relation

Not comparable.

---

# Total Order (Linear Order)

A Partial Order where

**every pair of elements is comparable.**

Definition

```
For every

a,b

Either

aRb

OR

bRa
```

---

Example

```
Natural Numbers

with

≤
```

---

# Difference

| Partial Order | Total Order |
|--------------|-------------|
| Some elements incomparable | Every pair comparable |
| General case | Special case |

---

# Maximal Element

An element above which **no larger element exists**.

There may be multiple maximal elements.

---

# Minimal Element

An element below which **no smaller element exists**.

There may be multiple minimal elements.

---

# Greatest Element

Element greater than or equal to **every** element.

Only one can exist.

Notation

```
Greatest

or

Maximum
```

---

# Least Element

Element smaller than or equal to **every** element.

Only one can exist.

Notation

```
Least

or

Minimum
```

---

# Difference

| Greatest | Maximal |
|----------|----------|
| Unique | May be many |
| Greater than every element | Only no greater element exists |

---

| Least | Minimal |
|--------|----------|
| Unique | May be many |

---

# Hasse Diagram

A graphical representation of a Poset.

It removes

- Reflexive edges
- Transitive edges
- Arrow directions

Edges go upward.

---

# Steps to Draw Hasse Diagram

1. Remove reflexive edges.

2. Remove transitive edges.

3. Draw smaller elements below.

4. Connect immediate relations.

---

Example

```
     12
    /  \
   4    6
    \  /
     2
     |
     1
```

---

# Upper Bound

For subset

```
S
```

An element

```
u
```

such that

```
x≤u

for every x∈S
```

---

# Lower Bound

An element below every member of the subset.

---

# Least Upper Bound (LUB)

Also called

```
Supremum

Sup
```

Smallest among all upper bounds.

---

# Greatest Lower Bound (GLB)

Also called

```
Infimum

Inf
```

Largest among all lower bounds.

---

# Lattice

A Poset in which **every pair of elements has**

- Least Upper Bound (Join)
- Greatest Lower Bound (Meet)

---

# Join

Notation

```
a∨b
```

Meaning

```
Least Upper Bound
```

---

# Meet

Notation

```
a∧b
```

Meaning

```
Greatest Lower Bound
```

---

# Lattice Example

Consider

```
{1,2,4,8}
```

under divisibility.

```
Join

=

LCM
```

```
Meet

=

GCD
```

Very Important for GATE.

---

# Types of Lattices

```
Lattice
│
├── Bounded
├── Complemented
├── Distributive
└── Modular
```

---

# Bounded Lattice

Contains

- Least Element (0)

- Greatest Element (1)

---

# Complemented Lattice

Every element has a complement.

Example

```
Boolean Algebra
```

---

# Distributive Lattice

Satisfies

```
a∨(b∧c)

=

(a∨b)

∧

(a∨c)
```

and

```
a∧(b∨c)

=

(a∧b)

∨

(a∧c)
```

---

# Modular Lattice

Weaker than distributive.

Formula

```
a≤c

⇒

a∨(b∧c)

=

(a∨b)

∧c
```

---

# Boolean Lattice

A lattice that is

- Distributive
- Complemented
- Bounded

Example

```
Power Set
```

under

```
∩

and

∪
```

---

# Important Theorems

Every Total Order is a Partial Order.

✔️ True

---

Every Partial Order is a Total Order.

❌ False

---

Every Lattice is a Poset.

✔️ True

---

Every Poset is a Lattice.

❌ False

---

Every Boolean Algebra is a Lattice.

✔️ True

---

# Common GATE PYQs

- Partial Order
- Total Order
- Poset
- Comparable Elements
- Hasse Diagram
- LUB
- GLB
- Join
- Meet
- Lattice
- Boolean Lattice

---

# Quick Revision

✅ Partial Order

✅ RAT Property

✅ Poset

✅ Comparable

✅ Total Order

✅ Maximal

✅ Minimal

✅ Greatest

✅ Least

✅ Hasse Diagram

✅ Upper Bound

✅ Lower Bound

✅ LUB

✅ GLB

✅ Join

✅ Meet

✅ Lattice

✅ Boolean Lattice

---

# Common Mistakes

❌ Confusing **Greatest** with **Maximal**.

❌ Confusing **Least** with **Minimal**.

❌ Forgetting that a Total Order requires every pair to be comparable.

❌ Assuming every Poset is a Lattice.

❌ Mixing up Join (LUB) and Meet (GLB).

---

# Memory Tricks

### Partial Order

```
RAT

Reflexive

Antisymmetric

Transitive
```

---

### Lattice

```
Join

=

Least Upper Bound

∨
```

```
Meet

=

Greatest Lower Bound

∧
```

---

### Divisibility Lattice

```
Meet

=

GCD
```

```
Join

=

LCM
```

---

### Boolean Lattice

```
Power Set

+

Union

+

Intersection
```

---

# Formula Sheet

| Concept | Formula |
|----------|---------|
| Partial Order | Reflexive + Antisymmetric + Transitive |
| Join | Least Upper Bound (∨) |
| Meet | Greatest Lower Bound (∧) |
| Boolean Lattice | Bounded + Complemented + Distributive |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- Hasse Diagrams
- Join & Meet
- LUB & GLB
- Partial vs Total Order
- Lattice Identification
- Boolean Lattice

---

# Next File

➡️ `07-Monoids-and-Groups.md`