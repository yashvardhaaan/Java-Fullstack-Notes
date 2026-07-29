# Functions

> GATE Weightage: ⭐⭐⭐⭐

---

# What is a Function?

A **Function** is a special type of relation in which **every element of the domain is associated with exactly one element of the codomain.**

Mathematically,

```
f : A → B
```

where

- A = Domain
- B = Codomain

For every

```
a ∈ A
```

there exists **exactly one**

```
b ∈ B
```

such that

```
f(a)=b
```

---

# Relation vs Function

| Relation | Function |
|----------|----------|
| Can map one element to many | Must map one element to exactly one |
| May leave elements unmapped | Every domain element must be mapped |
| General concept | Special type of relation |

---

# Example of Function

```
A={1,2,3}

B={a,b,c}
```

Function

```
1→a

2→b

3→c
```

✅ Valid Function

---

# Not a Function

```
1→a

1→b
```

One input has two outputs.

❌ Not a Function

---

# Domain

The set of all input values.

Example

```
f(x)=x²

Domain

=

All Real Numbers
```

---

# Codomain

The complete set of possible outputs.

Example

```
f : A→B
```

B is the codomain.

---

# Range

The set of actual outputs.

Example

```
f(x)=x²

Range

=

{0,1,4,9,...}
```

---

# Domain vs Codomain vs Range

```
Domain
   │
   ▼

Function

   ▼

Range ⊆ Codomain
```

---

# Types of Functions

```
Functions
│
├── One-One (Injective)
├── Many-One
├── Onto (Surjective)
├── Into
├── Bijective
├── Identity
├── Constant
└── Invertible
```

---

# One-One (Injective)

Different inputs give different outputs.

Definition

```
If

f(a)=f(b)

then

a=b
```

Example

```
f(x)=2x
```

---

# Many-One Function

Different inputs may have the same output.

Example

```
f(x)=x²
```

because

```
2²=4

(-2)²=4
```

---

# Onto (Surjective)

Every element of the codomain has at least one pre-image.

Definition

```
Range

=

Codomain
```

Example

```
f(x)=x
```

---

# Into Function

Some elements of the codomain are never mapped.

```
Range

⊂

Codomain
```

---

# Bijective Function

A function that is

- One-One
- Onto

Memory Trick

```
Bijection

=

Injection

+

Surjection
```

---

# Identity Function

Every element maps to itself.

```
f(x)=x
```

---

# Constant Function

Every input maps to the same output.

Example

```
f(x)=5
```

---

# Invertible Function

Only **Bijective Functions** have an inverse.

Notation

```
f⁻¹
```

Property

```
f⁻¹(f(x))

=

x
```

---

# Composition of Functions

Suppose

```
f:A→B

g:B→C
```

Then

```
g∘f
```

means

```
g(f(x))
```

Example

```
f(x)=2x

g(x)=x+3
```

Then

```
(g∘f)(x)

=

2x+3
```

---

# Equality of Functions

Two functions are equal if they have

- Same domain
- Same codomain
- Same output for every input

---

# Image

For

```
x∈A
```

the output

```
f(x)
```

is called the **Image**.

---

# Preimage (Inverse Image)

For

```
y∈B
```

the set of all inputs mapping to

```
y
```

is called the preimage.

---

# Cardinality of Functions

Suppose

```
|A|=m

|B|=n
```

---

## Total Number of Functions

```
n^m
```

---

## Number of One-One Functions

Applicable only if

```
m≤n
```

Formula

```
n!

──────────

(n−m)!
```

---

## Number of Onto Functions

No simple direct formula for GATE.

Usually solved using the **Inclusion-Exclusion Principle**.

---

## Number of Bijective Functions

Possible only if

```
m=n
```

Formula

```
n!
```

---

# Important Properties

## Composition of Injective Functions

Injective

+

Injective

=

Injective

---

## Composition of Surjective Functions

Surjective

+

Surjective

=

Surjective

---

## Composition of Bijections

Bijective

+

Bijective

=

Bijective

---

# Common GATE PYQs

- Identify function
- One-One
- Onto
- Bijective
- Domain
- Codomain
- Range
- Number of Functions
- Number of Injective Functions
- Inverse Function
- Composition

---

# Quick Revision

✅ Function

✅ Domain

✅ Codomain

✅ Range

✅ One-One

✅ Many-One

✅ Onto

✅ Into

✅ Bijective

✅ Identity Function

✅ Constant Function

✅ Inverse Function

✅ Composition

✅ Counting Functions

---

# Common Mistakes

❌ Confusing **Range** with **Codomain**.

❌ Assuming every One-One function is Onto.

❌ Forgetting that only **Bijective Functions** have inverses.

❌ Using

```
m^n
```

instead of

```
n^m
```

for counting functions.

❌ Confusing Many-One with Into.

---

# Memory Tricks

### Total Functions

```
n^m
```

where

```
m = Domain size

n = Codomain size
```

---

### Injective

```
Different Inputs

↓

Different Outputs
```

---

### Surjective

```
Every Output

is Used
```

---

### Bijective

```
Injective

+

Surjective
```

---

### Inverse Exists

```
Only

Bijective

Functions
```

---

# Formula Sheet

| Formula | Result |
|----------|--------|
| Total Functions | `n^m` |
| Injective Functions | `n!/(n-m)!` |
| Bijective Functions | `n!` (if `m=n`) |
| Inverse Exists | Only for Bijective Functions |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- One-One vs Onto
- Counting Functions
- Inverse Function
- Composition
- Domain / Range / Codomain
- Bijective Functions

---

# Next File

➡️ `06-Partial-Orders-and-Lattices.md`