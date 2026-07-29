# Relations

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# What is a Relation?

A **Relation** defines how elements of one set are associated with elements of another set.

Mathematically,

```
If A and B are two sets,

A Relation R from A to B is

R ⊆ A × B
```

where

```
A × B
```

is the Cartesian Product.

---

# Example

Let

```
A = {1,2,3}

B = {a,b}
```

Cartesian Product

```
A × B

=

{

(1,a),
(1,b),
(2,a),
(2,b),
(3,a),
(3,b)

}
```

Suppose

```
R =

{

(1,a),

(2,b)

}
```

Then

```
R ⊆ A×B
```

Hence R is a relation.

---

# Number of Relations

If

```
|A| = m

|B| = n
```

Then

```
|A×B|

=

m × n
```

Total possible relations

```
2^(m×n)
```

### Formula

```
Number of Relations

=

2^(mn)
```

---

# Relation on a Set

If relation is from

```
A → A
```

then it is called a relation **on A**.

---

# Domain

The set of first elements.

Example

```
R

=

{

(1,a),

(2,b)

}
```

Domain

```
{1,2}
```

---

# Range

The set of second elements that actually appear.

```
{a,b}
```

---

# Codomain

Entire destination set.

If

```
B={a,b,c}
```

Then

```
Codomain={a,b,c}
```

---

# Matrix Representation

A relation can be represented using a matrix.

If

```
(ai,bj)
```

belongs to relation

Put

```
1
```

Otherwise

```
0
```

Frequently asked in GATE.

---

# Digraph Representation

Represent every element as a vertex.

Each ordered pair becomes a directed edge.

Useful for visualizing relations.

---

# Properties of Relations

---

# Reflexive Relation

Every element is related to itself.

Definition

```
(a,a)

∈ R

for every a
```

Example

```
{

(1,1),

(2,2),

(3,3)

}
```

---

# Irreflexive Relation

No element is related to itself.

Definition

```
(a,a)

∉ R
```

---

# Symmetric Relation

Definition

If

```
(a,b)

∈R
```

then

```
(b,a)

∈R
```

Example

```
Friendship
```

If A is friend of B,

B is friend of A.

---

# Asymmetric Relation

If

```
(a,b)

∈R
```

Then

```
(b,a)

∉R
```

Example

```
Parent
```

---

# Antisymmetric Relation

Definition

If

```
(a,b)

∈R

and

(b,a)

∈R

then

a=b
```

Example

```
≤
```

Very Important.

---

# Transitive Relation

Definition

If

```
(a,b)

∈R

and

(b,c)

∈R
```

then

```
(a,c)

∈R
```

Example

```
≤
```

---

# Summary Table

| Property | Condition |
|-----------|-----------|
| Reflexive | (a,a) always exists |
| Irreflexive | (a,a) never exists |
| Symmetric | (a,b) ⇒ (b,a) |
| Antisymmetric | (a,b) and (b,a) ⇒ a=b |
| Asymmetric | (a,b) ⇒ (b,a) never |
| Transitive | (a,b),(b,c) ⇒ (a,c) |

---

# Equivalence Relation

A relation is an equivalence relation if it is

- Reflexive
- Symmetric
- Transitive

Memory Trick

```
RST

Reflexive

Symmetric

Transitive
```

---

# Example

Equality

```
=
```

is an equivalence relation.

---

# Equivalence Class

For an element

```
a
```

The equivalence class is

```
[a]

=

{x | xRa}
```

All equivalent elements belong to one class.

---

# Partition of a Set

An Equivalence Relation divides a set into

**disjoint subsets**

called

```
Partitions
```

Important theorem

```
Equivalence Relation

⇔

Partition
```

---

# Partial Order Relation

A relation is a Partial Order if it is

- Reflexive
- Antisymmetric
- Transitive

Memory Trick

```
RAT

Reflexive

Antisymmetric

Transitive
```

---

# Example

```
≤
```

```
⊆
```

Both are Partial Orders.

---

# Total Order

A Partial Order in which every pair is comparable.

Example

```
1≤2

or

2≤1
```

always true.

---

# Closures

Sometimes a relation lacks certain properties.

We add minimum pairs to satisfy them.

Types

- Reflexive Closure
- Symmetric Closure
- Transitive Closure

---

# Reflexive Closure

Add

```
(a,a)
```

for every missing element.

---

# Symmetric Closure

If

```
(a,b)
```

exists,

add

```
(b,a)
```

---

# Transitive Closure

Add missing transitive pairs.

Usually computed using

```
Warshall's Algorithm
```

---

# Composition of Relations

Suppose

```
R

⊆

A×B
```

and

```
S

⊆

B×C
```

Then

```
S∘R
```

connects

```
A → C
```

---

# Inverse Relation

Swap every ordered pair.

Example

```
R

=

{

(1,a),

(2,b)

}
```

Inverse

```
R⁻¹

=

{

(a,1),

(b,2)

}
```

---

# Important Formulas

Total Relations

```
2^(mn)
```

Reflexive Relations

```
2^(n²−n)
```

Symmetric Relations

```
2^(n(n+1)/2)
```

---

# Common GATE PYQs

- Check Reflexive
- Check Symmetric
- Check Antisymmetric
- Check Transitive
- Equivalence Relation
- Partial Order
- Number of Relations
- Closures
- Matrix Representation
- Warshall Algorithm
- Equivalence Classes

---

# Quick Revision

✅ Relation

✅ Cartesian Product

✅ Domain

✅ Range

✅ Codomain

✅ Reflexive

✅ Symmetric

✅ Antisymmetric

✅ Transitive

✅ Equivalence Relation

✅ Partial Order

✅ Closures

✅ Composition

✅ Inverse Relation

---

# Common Mistakes

❌ Confusing Symmetric with Antisymmetric.

❌ Forgetting that **Antisymmetric allows (a,a)**.

❌ Assuming every Partial Order is a Total Order.

❌ Mixing Domain and Range.

❌ Forgetting the formulas for counting relations.

---

# Memory Tricks

- **RST = Equivalence Relation**
  - Reflexive
  - Symmetric
  - Transitive

- **RAT = Partial Order**
  - Reflexive
  - Antisymmetric
  - Transitive

- **Total Relations = 2^(mn)**

- **Relation = Subset of Cartesian Product**

---

# Next File

➡️ `05-Functions.md`