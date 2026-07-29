# Mean Value Theorem (MVT)

> GATE Weightage: ⭐⭐⭐⭐☆

---

# Why Do We Need the Mean Value Theorem?

Suppose you drive

```
120 km
```

in

```
2 hours
```

Your average speed is

```
120/2

=

60 km/hr
```

The Mean Value Theorem says:

> **At some instant during the journey, your instantaneous speed was exactly 60 km/hr.**

This powerful idea connects the **average rate of change** with the **instantaneous rate of change**.

It is widely used in

- Calculus
- Optimization
- Error Analysis
- Numerical Methods
- Machine Learning

---

# Prerequisites

Before applying MVT, always check

```
Continuous

+

Differentiable
```

Without these conditions,

```
MVT cannot be applied.
```

---

# Flow of Mean Value Theorems

```
Mean Value Theorems
│
├── Rolle's Theorem
│
├── Lagrange Mean Value Theorem (LMVT)
│
└── Cauchy Mean Value Theorem (Rare in GATE CSE)
```

---

# Rolle's Theorem

## Statement

If a function

- is continuous on

```
[a,b]
```

- differentiable on

```
(a,b)
```

- satisfies

```
f(a)=f(b)
```

Then there exists some

```
c ∈ (a,b)
```

such that

```
f'(c)=0
```

---

# Intuition of Rolle's Theorem

Imagine climbing a hill and returning to the same height.

```
Start
 ●
  \      /\
   \    /
    \__/
        ● End
```

Since you start and end at the same height,

there must be at least one point where the slope is

```
0
```

---

# Conditions for Rolle's Theorem

```
1. Continuous on [a,b]

✓
```

---

```
2. Differentiable on (a,b)

✓
```

---

```
3.

f(a)=f(b)

✓
```

If **any one condition fails**, Rolle's theorem cannot be applied.

---

# Example

```
f(x)=x²−4x+3
```

Interval

```
[1,3]
```

Check

```
f(1)=0

f(3)=0
```

Conditions satisfied.

Derivative

```
f'(x)=2x−4
```

Set

```
2x−4=0
```

Answer

```
c=2
```

---

# Lagrange Mean Value Theorem (LMVT)

This is the **most important theorem** for GATE.

---

## Statement

If

```
f(x)
```

is

- continuous on

```
[a,b]
```

- differentiable on

```
(a,b)
```

Then there exists

```
c∈(a,b)
```

such that

```
            f(b)-f(a)
f'(c)

=

-------------------

              b-a
```

---

# Meaning of LMVT

Left side

```
Instantaneous Rate

(Slope of Tangent)
```

Right side

```
Average Rate

(Slope of Chord)
```

MVT says

```
These become equal

at least once.
```

---

# Geometric Interpretation

```
          ●
        / |
      /   | Tangent
    /     |
●----------●

Chord
```

There exists a tangent parallel to the chord.

---

# Formula

```
            f(b)-f(a)
f'(c)

=

-------------------

              b-a
```

**This formula is frequently asked in GATE.**

---

# Example

Given

```
f(x)=x²
```

Interval

```
[1,3]
```

Average slope

```
9−1

----

3−1

=

4
```

Derivative

```
2x
```

Set

```
2c=4
```

Answer

```
c=2
```

---

# Rolle's vs LMVT

| Rolle's Theorem | LMVT |
|-----------------|------|
| Requires `f(a)=f(b)` | No such condition |
| Gives `f'(c)=0` | Gives `f'(c)=Average Slope` |
| Special case of LMVT | More general theorem |

---

# Cauchy Mean Value Theorem

Generalization of LMVT.

For two functions

```
f(x)

and

g(x)
```

There exists

```
c
```

such that

```
f'(c)

      f(b)-f(a)
------

=

g'(c)

      g(b)-g(a)
```

Rarely asked directly in GATE CSE.

---

# Applications of MVT

Used to

- Prove inequalities
- Estimate function values
- Study monotonicity
- Analyze optimization problems
- Numerical approximation
- Error estimation

---

# Increasing and Decreasing Functions

If

```
f'(x)>0
```

Function is

```
Increasing
```

---

If

```
f'(x)<0
```

Function is

```
Decreasing
```

MVT helps prove these properties.

---

# Important Observations

If

```
Derivative

=

0

everywhere
```

Then

```
Function

=

Constant
```

---

If

```
Derivative

>

0
```

Function always increases.

---

If

```
Derivative

<

0
```

Function always decreases.

---

# Common GATE PYQs

- Conditions of Rolle's theorem
- Conditions of LMVT
- Finding the value of `c`
- Geometric interpretation
- Comparing Rolle's and LMVT
- Increasing/Decreasing functions using MVT

---

# Problem Solving Strategy

```
Step 1

↓

Check Continuity
```

↓

```
Step 2

↓

Check Differentiability
```

↓

```
Step 3

↓

Check

f(a)=f(b)

(Only for Rolle's)
```

↓

```
Step 4

↓

Apply Formula
```

↓

```
Step 5

↓

Solve for c
```

---

# Quick Revision

✅ Rolle's Theorem

✅ LMVT

✅ Conditions

✅ Formula

✅ Geometric Meaning

✅ Finding c

✅ Applications

---

# Common Mistakes

❌ Forgetting to verify continuity.

❌ Forgetting to verify differentiability.

❌ Applying Rolle's theorem without checking

```
f(a)=f(b)
```

❌ Confusing average slope with derivative.

❌ Solving outside the interval

```
(a,b)
```

---

# Memory Tricks

### Rolle's Theorem

```
Same Heights

↓

Horizontal Tangent

↓

f'(c)=0
```

---

### LMVT

```
Average Slope

=

Instantaneous Slope
```

---

### Conditions

```
Continuous

+

Differentiable

=

Apply MVT
```

---

### Formula

```
             Change in Output
Derivative = -----------------
             Change in Input
```

---

# Formula Sheet

| Formula | Meaning |
|----------|----------|
| Rolle's | `f'(c)=0` |
| LMVT | `f'(c)=[f(b)-f(a)]/(b-a)` |
| Conditions | Continuous on `[a,b]`, Differentiable on `(a,b)` |
| Rolle's Extra Condition | `f(a)=f(b)` |

---

# PYQ Focus

⭐⭐⭐⭐☆

- Rolle's Theorem
- LMVT Formula
- Conditions for Application
- Finding the value of `c`
- Geometric Interpretation

---

# Interview Corner

### Q1. What is the difference between Rolle's Theorem and LMVT?

**Rolle's Theorem** is a special case of **LMVT** where the function values at the endpoints are equal (`f(a)=f(b)`), resulting in `f'(c)=0`.

---

### Q2. Can MVT be applied if a function is continuous but not differentiable?

❌ No. Both **continuity** on the closed interval and **differentiability** on the open interval are mandatory.

---

### Q3. What is the geometric meaning of LMVT?

There exists at least one point where the **tangent to the curve is parallel to the chord** joining the two endpoints.

---

# GATE 80/20 Summary

### Must Remember

- ✅ Rolle's Conditions:
  - Continuous on `[a,b]`
  - Differentiable on `(a,b)`
  - `f(a)=f(b)`

- ✅ LMVT Conditions:
  - Continuous on `[a,b]`
  - Differentiable on `(a,b)`

- ✅ LMVT Formula:

```
            f(b)-f(a)
f'(c)

=

-------------------

              b-a
```

- ✅ Rolle's is a **special case** of LMVT.

---

# Next File

➡️ `25-Integration.md`