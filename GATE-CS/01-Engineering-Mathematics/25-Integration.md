# Integration

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# Why Do We Need Integration?

Suppose a car is moving with a varying speed.

You know the **speed at every instant**, but you want to find the **total distance traveled**.

Differentiation tells us

```
Distance

↓

Speed
```

Integration tells us

```
Speed

↓

Distance
```

Integration is the **reverse process of differentiation**.

It is used in

- Finding Areas
- Volumes
- Distance
- Probability
- Machine Learning
- Physics
- Economics

---

# Intuition

Imagine filling a water tank.

Each tiny drop adds a small amount.

Adding all these tiny pieces gives the total amount.

```
Tiny Area

+

Tiny Area

+

Tiny Area

+

...

=

Total Area
```

Integration is simply **adding infinitely many tiny pieces**.

---

# Definition

Integration is the process of finding the **antiderivative** of a function.

Notation

```
∫ f(x) dx
```

where

```
∫

↓

Integral Sign

f(x)

↓

Function

dx

↓

Variable of Integration
```

---

# Relationship with Differentiation

```
Differentiation

↓

Slope
```

```
Integration

↓

Area
```

or

```
Differentiate

↓

Go Forward

Integrate

↓

Come Back
```

Example

```
d/dx(x²)

=

2x
```

Therefore

```
∫2x dx

=

x²+C
```

---

# Constant of Integration

Every indefinite integral contains a constant.

```
+C
```

Reason

```
d/dx(5)=0

d/dx(10)=0

d/dx(-7)=0
```

Hence

```
∫0 dx

=

C
```

Never forget **+C** in indefinite integrals.

---

# Types of Integration

```
Integration
│
├── Indefinite Integral
├── Definite Integral
└── Improper Integral
```

---

# Indefinite Integral

General antiderivative.

Notation

```
∫f(x)dx
```

Example

```
∫x²dx

=

x³/3+C
```

---

# Definite Integral

Area between limits.

Notation

```
 b
⌠
⌡ f(x)dx
a
```

Formula

```
 b
⌠
⌡ f(x)dx

=

F(b)-F(a)
a
```

where

```
F'(x)=f(x)
```

---

# Fundamental Theorem of Calculus

The bridge between differentiation and integration.

If

```
F'(x)=f(x)
```

Then

```
 b
⌠
⌡ f(x)dx

=

F(b)-F(a)
a
```

Very Important for GATE.

---

# Standard Integrals

### Constant

```
∫k dx

=

kx+C
```

---

### Power Rule

```
∫xⁿdx

=

xⁿ⁺¹

-------

n+1

+C

(n≠-1)
```

---

### Reciprocal

```
∫1/x dx

=

ln|x|+C
```

---

### Exponential

```
∫eˣdx

=

eˣ+C
```

---

### General Exponential

```
∫aˣdx

=

aˣ

------

ln(a)

+C
```

---

### Sine

```
∫sinx dx

=

-cosx+C
```

---

### Cosine

```
∫cosx dx

=

sinx+C
```

---

### Sec²x

```
∫sec²x dx

=

tanx+C
```

---

### Cosec²x

```
∫cosec²x dx

=

-cotx+C
```

---

### SecxTanx

```
∫secxtanx dx

=

secx+C
```

---

### CosecxCotx

```
∫cosecxcotx dx

=

-cosecx+C
```

---

# Properties of Integration

## Constant Multiple Rule

```
∫kf(x)dx

=

k∫f(x)dx
```

---

## Sum Rule

```
∫(f+g)dx

=

∫fdx

+

∫gdx
```

---

## Difference Rule

```
∫(f-g)dx

=

∫fdx

-

∫gdx
```

---

# Methods of Integration

```
Integration
│
├── Direct Formula
├── Substitution
├── Integration by Parts
├── Partial Fractions
└── Trigonometric Identities
```

---

# Method 1: Direct Formula

Example

```
∫5x⁴dx

=

x⁵+C
```

---

# Method 2: Substitution

Useful when one function is inside another.

Formula

Let

```
u=g(x)
```

Then

```
du=g'(x)dx
```

Integral becomes

```
∫f(u)du
```

---

### Example

```
∫2x(x²+1)⁵dx
```

Take

```
u=x²+1
```

Then

```
du=2xdx
```

Result

```
∫u⁵du

=

u⁶/6+C
```

Substitute back.

---

# Method 3: Integration by Parts

Formula

```
∫u dv

=

uv

-

∫v du
```

Memory Trick

```
ILATE
```

Choose

```
I → Inverse Trigonometric

L → Logarithmic

A → Algebraic

T → Trigonometric

E → Exponential
```

Choose `u` from the highest priority.

---

### Example

```
∫x eˣdx
```

Take

```
u=x

dv=eˣdx
```

Result

```
xeˣ-eˣ+C
```

---

# Method 4: Partial Fractions

Used for rational functions.

Example

```
1

-------

(x+1)(x+2)
```

Split as

```
A

---

x+1

+

B

---

x+2
```

Then integrate each part.

---

# Definite Integrals

Example

```
 2
⌠
⌡x dx
0
```

Antiderivative

```
x²/2
```

Evaluate

```
2²/2−0²/2

=

2
```

---

# Properties of Definite Integrals

### Same Limits

```
 a
⌠
⌡f(x)dx

=

0
a
```

---

### Reverse Limits

```
 a
⌠

⌡f(x)dx

=

-

 b
⌠

⌡f(x)dx
a
```

---

### Additivity

```
 a→c

+

c→b

=

a→b
```

---

# Area Under a Curve

If

```
f(x)≥0
```

Then

```
Area

=

 b
⌠
⌡f(x)dx
a
```

If the graph lies below the x-axis, use absolute values for geometric area.

---

# Average Value of a Function

Formula

```
           b
          ⌠
          ⌡f(x)dx
           a
Average

=

----------------

b-a
```

---

# Common GATE PYQs

- Standard Integrals
- Substitution
- Integration by Parts
- Definite Integrals
- Properties of Definite Integrals
- Fundamental Theorem of Calculus
- Area Under Curve

---

# Quick Revision

✅ Indefinite Integral

✅ Definite Integral

✅ Constant of Integration

✅ Standard Integrals

✅ Substitution

✅ Integration by Parts

✅ Partial Fractions

✅ Area Under Curve

---

# Common Mistakes

❌ Forgetting **+C** in indefinite integrals.

❌ Using the Power Rule for

```
1/x
```

(Use `ln|x|` instead.)

❌ Forgetting to change limits after substitution (or forgetting to substitute back).

❌ Choosing the wrong `u` in Integration by Parts.

❌ Ignoring negative area when interpreting definite integrals geometrically.

---

# Memory Tricks

### Integration

```
Reverse of

Differentiation
```

---

### Power Rule

```
Increase Power

↓

Divide by New Power
```

---

### By Parts

```
∫u dv

=

uv

-

∫v du
```

---

### Choosing u

```
ILATE

↓

Inverse

Log

Algebra

Trig

Expo
```

---

### Definite Integral

```
Upper

-

Lower
```

---

# Formula Sheet

| Formula | Result |
|----------|--------|
| `∫xⁿdx` | `xⁿ⁺¹/(n+1)+C` (`n≠-1`) |
| `∫1/x dx` | `ln|x|+C` |
| `∫eˣdx` | `eˣ+C` |
| `∫sinx dx` | `-cosx+C` |
| `∫cosx dx` | `sinx+C` |
| `∫u dv` | `uv-∫vdu` |
| `∫ₐᵇf(x)dx` | `F(b)-F(a)` |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- Standard Integrals
- Integration by Parts
- Substitution
- Definite Integral Properties
- Fundamental Theorem of Calculus
- Area Under Curve

---

# Interview Corner

### Q1. What is the difference between definite and indefinite integration?

- **Indefinite Integral:** Finds the family of antiderivatives and includes **+C**.
- **Definite Integral:** Computes a numerical value over an interval and **does not include +C**.

---

### Q2. Why do we add the constant of integration?

Because the derivative of any constant is **0**, infinitely many functions differ only by a constant but have the same derivative.

---

### Q3. Which integration method is used most often in GATE?

The most frequently tested methods are:

- Direct Formula
- **Substitution**
- **Integration by Parts**
- Properties of Definite Integrals

---

# GATE 80/20 Summary

### Must Remember

- ✅ Integration is the reverse of differentiation.
- ✅ Never forget **+C** in indefinite integrals.
- ✅ `∫1/x dx = ln|x| + C`
- ✅ `∫u dv = uv - ∫vdu`
- ✅ `∫ₐᵇ f(x)dx = F(b)-F(a)`
- ✅ Learn all standard integrals by heart—they appear frequently in GATE.

---

# Next File

➡️ `26-Random-Variables.md`