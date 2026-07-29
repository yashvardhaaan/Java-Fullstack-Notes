# Continuity and Differentiability

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# Why Do We Need Continuity?

Imagine driving on a road.

### Continuous Road

```
──────────────
```

You can drive smoothly.

---

### Discontinuous Road

```
──────    ──────
```

There is a break.

You cannot continue without jumping.

A **continuous function** behaves like a smooth road.

---

# Why Do We Need Differentiability?

Suppose you want to know

- Speed of a car
- Slope of a hill
- Growth of a population

You need the **rate of change**.

That is exactly what differentiation measures.

---

# Continuity

A function is **continuous** at

```
x=a
```

if

1.

```
f(a)
```

exists.

2.

```
lim f(x)

x→a
```

exists.

3.

```
lim f(x)

=

f(a)
```

---

# Mathematical Condition

A function is continuous iff

```
LHL

=

RHL

=

f(a)
```

This is the most important condition in GATE.

---

# Example

```
f(x)=x²
```

At

```
x=2
```

```
LHL=4

RHL=4

f(2)=4
```

Hence

```
Continuous
```

---

# Discontinuity

A function is **discontinuous** if **any** continuity condition fails.

---

# Types of Discontinuity

```
Discontinuity
│
├── Removable
├── Jump
├── Infinite
└── Oscillatory
```

---

# 1. Removable Discontinuity

Occurs when

```
LHL

=

RHL
```

but

```
f(a)
```

is missing or incorrect.

Example

```
      x²−1
f(x)=-------

      x−1
```

At

```
x=1
```

The function is undefined, but

```
lim f(x)=2
```

We can "remove" the discontinuity by defining

```
f(1)=2
```

---

# 2. Jump Discontinuity

Occurs when

```
LHL

≠

RHL
```

Example

```
      {-1 , x<0

f(x)={

      { 1 , x≥0
```

At

```
x=0
```

```
LHL=-1

RHL=1
```

Hence

```
Jump Discontinuity
```

---

# 3. Infinite Discontinuity

Function tends toward

```
∞

or

−∞
```

Example

```
1/x
```

at

```
x=0
```

---

# 4. Oscillatory Discontinuity

The function keeps oscillating and never settles.

Example

```
sin(1/x)
```

at

```
x=0
```

No limit exists.

---

# Continuous Functions

The following are continuous on their domains.

✔ Polynomial

```
x²

x³

5x+7
```

---

✔ Exponential

```
eˣ
```

---

✔ Logarithmic

```
ln(x)

(x>0)
```

---

✔ Trigonometric

```
sinx

cosx
```

---

✔ Rational Functions

Continuous wherever denominator ≠ 0.

---

# Differentiability

A function is differentiable at

```
x=a
```

if

```
Derivative Exists
```

---

# Definition

```
f'(a)

=

lim

h→0

f(a+h)-f(a)

────────────

h
```

This is called the

```
First Principle Definition
```

---

# Geometric Meaning

Derivative

=

Slope of the tangent.

```
Higher slope

↓

Higher derivative
```

---

# Relationship

```
Differentiable

↓

Continuous
```

Always True.

---

```
Continuous

↓

Differentiable
```

Not Always True.

Very Important.

---

# Counter Example

Function

```
|x|
```

At

```
x=0
```

Continuous?

```
YES
```

Differentiable?

```
NO
```

Reason

Left slope

```
-1
```

Right slope

```
1
```

Different slopes.

---

# Left-Hand Derivative

Notation

```
LHD
```

Formula

```
lim

h→0⁻

f(a+h)-f(a)

────────────

h
```

---

# Right-Hand Derivative

Notation

```
RHD
```

Formula

```
lim

h→0⁺

f(a+h)-f(a)

────────────

h
```

---

# Condition for Differentiability

Derivative exists if

```
LHD

=

RHD
```

---

# Standard Derivatives

### Constant

```
d/dx(c)=0
```

---

### x

```
d/dx(x)=1
```

---

### xⁿ

```
d/dx(xⁿ)

=

nxⁿ⁻¹
```

---

### sinx

```
cosx
```

---

### cosx

```
-sinx
```

---

### tanx

```
sec²x
```

---

### eˣ

```
eˣ
```

---

### ln(x)

```
1/x
```

---

# Differentiation Rules

## Constant Rule

```
d/dx(c)=0
```

---

## Constant Multiple Rule

```
d/dx(cf)

=

c

d/dx(f)
```

---

## Sum Rule

```
(f+g)'

=

f'+g'
```

---

## Difference Rule

```
(f-g)'

=

f'-g'
```

---

## Product Rule

```
(fg)'

=

f'g+fg'
```

Memory Trick

```
First'

Second

+

First

Second'
```

---

# Quotient Rule

```
(f/g)'

=

gf'

−

fg'

────────

g²
```

Memory Trick

```
Low High'

-

High Low'

──────────

Low²
```

---

# Chain Rule

If

```
y=f(g(x))
```

Then

```
dy/dx

=

dy/du

×

du/dx
```

Memory Trick

```
Outside

↓

Inside
```

Very Important.

---

# Higher Order Derivatives

Second derivative

```
f''(x)
```

Third derivative

```
f'''(x)
```

Notation

```
d²y/dx²

d³y/dx³
```

---

# Physical Meaning

First Derivative

↓

Velocity

---

Second Derivative

↓

Acceleration

---

# Common GATE PYQs

- Continuity test
- Differentiability test
- Left & Right derivative
- Absolute value functions
- Product Rule
- Quotient Rule
- Chain Rule
- Standard derivatives

---

# Quick Revision

✅ Continuity

✅ Types of Discontinuity

✅ Differentiability

✅ First Principle

✅ Product Rule

✅ Quotient Rule

✅ Chain Rule

✅ Standard Derivatives

---

# Common Mistakes

❌ Assuming continuous implies differentiable.

❌ Forgetting

```
|x|
```

is not differentiable at

```
0
```

❌ Using Product Rule instead of Chain Rule.

❌ Forgetting denominator squared in Quotient Rule.

❌ Ignoring LHD and RHD.

---

# Memory Tricks

### Continuity

```
LHL

=

RHL

=

f(a)
```

---

### Differentiability

```
LHD

=

RHD
```

---

### Product Rule

```
First'

Second

+

First

Second'
```

---

### Quotient Rule

```
Low High'

-

High Low'

──────────

Low²
```

---

### Chain Rule

```
Outside

↓

Inside
```

---

# Formula Sheet

| Formula | Result |
|----------|--------|
| Continuity | `LHL = RHL = f(a)` |
| Differentiability | `LHD = RHD` |
| First Principle | `lim(h→0) [f(a+h)-f(a)]/h` |
| Product Rule | `(fg)' = f'g + fg'` |
| Quotient Rule | `(f/g)' = (gf' - fg')/g²` |
| Chain Rule | `(f(g(x)))' = f'(g(x))·g'(x)` |
| Power Rule | `(xⁿ)' = nxⁿ⁻¹` |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- Continuity Conditions
- Differentiability
- LHD & RHD
- Product Rule
- Quotient Rule
- Chain Rule
- Standard Derivatives

---

# Interview Corner

### Q1. Is every differentiable function continuous?

✅ **Yes.** If a function is differentiable at a point, it must also be continuous there.

---

### Q2. Is every continuous function differentiable?

❌ **No.** A classic example is `f(x) = |x|`, which is continuous but **not differentiable** at `x = 0`.

---

### Q3. What is the most commonly used differentiation rule?

The **Chain Rule**, because many real-world functions are compositions of simpler functions.

---

# Next File

➡️ `23-Maxima-and-Minima.md`