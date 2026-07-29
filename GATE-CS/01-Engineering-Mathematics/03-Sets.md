# Sets

> GATE Weightage: ⭐⭐⭐⭐

---

# What is a Set?

A **Set** is a well-defined collection of distinct objects.

The objects inside a set are called **elements (members)**.

A set is usually represented using **capital letters**.

Example:

```
A = {1,2,3,4}
```

Here,

```
1 ∈ A
```

```
5 ∉ A
```

---

# Representation of Sets

## 1. Roster (Tabular) Form

List all elements.

Example

```
A = {2,4,6,8}
```

---

## 2. Set Builder Form

Describe a property.

Example

```
A = {x | x is an even number less than 10}
```

---

# Basic Symbols

| Symbol | Meaning |
|----------|---------|
| ∈ | Belongs to |
| ∉ | Does not belong |
| ⊆ | Subset |
| ⊂ | Proper Subset |
| ⊇ | Superset |
| Ø | Empty Set |
| U | Universal Set |
| A' or Ac | Complement |
| ∪ | Union |
| ∩ | Intersection |
| A − B | Difference |
| A △ B | Symmetric Difference |

---

# Types of Sets

## Empty (Null) Set

Contains no elements.

```
Ø
```

Example

```
{x | x < 0 and x > 5}
```

---

## Singleton Set

Contains exactly one element.

Example

```
{5}
```

---

## Finite Set

Number of elements is finite.

Example

```
{1,2,3,4}
```

---

## Infinite Set

Number of elements is infinite.

Example

```
Natural Numbers
```

---

## Equal Sets

Two sets having exactly the same elements.

Example

```
{1,2,3}

{3,2,1}
```

Equal because order doesn't matter.

---

## Equivalent Sets

Same number of elements.

Example

```
A={1,2,3}

B={a,b,c}
```

---

# Cardinality

Number of elements in a set.

Notation

```
|A|
```

Example

```
A={1,2,3}

|A|=3
```

---

# Subset

Every element of A belongs to B.

Notation

```
A ⊆ B
```

Example

```
A={1,2}

B={1,2,3}
```

---

# Proper Subset

```
A ⊂ B
```

A is a subset but not equal to B.

---

# Power Set

Set containing all subsets.

Notation

```
P(A)
```

Example

```
A={1,2}

P(A)=

{

Ø,

{1},

{2},

{1,2}

}
```

---

## Formula

If

```
|A|=n
```

Then

```
|P(A)|=2ⁿ
```

---

# Universal Set

Contains all elements under discussion.

Notation

```
U
```

---

# Complement

Elements in U but not in A.

Notation

```
A'
```

or

```
Ac
```

Formula

```
Ac = U − A
```

---

# Union

All elements from both sets.

Notation

```
A ∪ B
```

Example

```
A={1,2,3}

B={3,4,5}

A∪B

=

{1,2,3,4,5}
```

---

# Intersection

Common elements.

Notation

```
A ∩ B
```

Example

```
{3}
```

---

# Difference

Elements in A but not in B.

Notation

```
A−B
```

---

# Symmetric Difference

Elements in either A or B but not both.

Formula

```
A△B

=

(A−B)

∪

(B−A)
```

---

# Disjoint Sets

No common elements.

```
A∩B=Ø
```

---

# Set Identities

## Identity Laws

```
A∪Ø=A
```

```
A∩U=A
```

---

## Domination Laws

```
A∪U=U
```

```
A∩Ø=Ø
```

---

## Idempotent Laws

```
A∪A=A
```

```
A∩A=A
```

---

## Complement Laws

```
A∪Ac=U
```

```
A∩Ac=Ø
```

---

## Double Complement

```
(Ac)c=A
```

---

## Commutative Laws

```
A∪B=B∪A
```

```
A∩B=B∩A
```

---

## Associative Laws

```
(A∪B)∪C

=

A∪(B∪C)
```

```
(A∩B)∩C

=

A∩(B∩C)
```

---

## Distributive Laws

```
A∪(B∩C)

=

(A∪B)

∩

(A∪C)
```

```
A∩(B∪C)

=

(A∩B)

∪

(A∩C)
```

---

## De Morgan's Laws

```
(A∪B)c

=

Ac∩Bc
```

```
(A∩B)c

=

Ac∪Bc
```

**Very Important for GATE**

---

# Cartesian Product

Definition

```
A×B

=

{(a,b)}

where

a∈A

b∈B
```

Example

```
A={1,2}

B={a,b}

A×B

=

{

(1,a),

(1,b),

(2,a),

(2,b)

}
```

---

## Formula

```
|A×B|

=

|A|

×

|B|
```

---

# Important Formulas

Union

```
|A∪B|

=

|A|

+

|B|

−

|A∩B|
```

Three Sets

```
|A∪B∪C|

=

|A|

+

|B|

+

|C|

−

|A∩B|

−

|A∩C|

−

|B∩C|

+

|A∩B∩C|
```

---

# Venn Diagrams

Used to represent

- Union
- Intersection
- Complement
- Difference

Most GATE questions become easier after drawing a Venn diagram.

---

# Common GATE PYQs

- Number of subsets
- Power set
- Set identities
- De Morgan's laws
- Cartesian product
- Cardinality
- Venn diagram problems
- Inclusion-Exclusion Principle

---

# Quick Revision

✅ Set

✅ Element

✅ Subset

✅ Proper Subset

✅ Power Set

✅ Universal Set

✅ Complement

✅ Union

✅ Intersection

✅ Difference

✅ Symmetric Difference

✅ Cartesian Product

✅ Inclusion-Exclusion Formula

---

# Common Mistakes

❌ Confusing subset (⊆) with element (∈).

❌ Forgetting the empty set is a subset of every set.

❌ Using `2n` instead of `2ⁿ` for power set size.

❌ Ignoring repeated elements (sets contain unique elements only).

❌ Forgetting De Morgan's laws.

---

# Memory Tricks

- **Power Set:** Number of subsets = **2ⁿ**.
- **Cartesian Product:** Multiply the sizes of the two sets.
- **Union Formula:** Add individual sizes, then subtract the common part once.
- **Empty Set:** Subset of every set.

---

# Next File

➡️ `04-Relations.md`