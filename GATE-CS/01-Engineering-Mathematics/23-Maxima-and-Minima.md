# Maxima and Minima

> GATE Weightage: ⭐⭐⭐⭐☆

---

# Why Do We Need Maxima and Minima?

In real life, we often want to

- Maximize profit 📈
- Minimize cost 💰
- Maximize speed 🚗
- Minimize time ⏳
- Find the shortest path 📍
- Find the least memory usage 💻

All these are **Optimization Problems**.

Calculus helps us find the **maximum** and **minimum** values of a function.

---

# Intuition

Imagine climbing a mountain.

```
          ▲
         / \
        /   \
       /     \
______/       \______
```

The highest point is the

```
Maximum
```

Now imagine a valley.

```
______       ______
      \     /
       \   /
        \_/
```

The lowest point is the

```
Minimum
```

---

# Definitions

## Maximum

A function has a **maximum** value at

```
x = a
```

if

```
f(a)
```

is greater than all nearby values.

---

## Minimum

A function has a **minimum** value at

```
x = a
```

if

```
f(a)
```

is smaller than all nearby values.

---

# Types of Maxima and Minima

```
Optimization
│
├── Local (Relative) Maximum
├── Local (Relative) Minimum
├── Global (Absolute) Maximum
└── Global (Absolute) Minimum
```

---

# Local Maximum

Largest value only in a nearby region.

Example

```
        ▲
       / \
______/   \_____
```

Not necessarily the highest point overall.

---

# Local Minimum

Smallest value in a nearby region.

```
______
      \
       \_
         \
__________\
```

---

# Global Maximum

Largest value in the **entire domain**.

---

# Global Minimum

Smallest value in the **entire domain**.

---

# Critical (Stationary) Points

A **critical point** is where

```
f'(x)=0
```

or

```
f'(x)
```

does not exist.

These are the candidate points for maxima and minima.

---

# Steps to Find Maxima and Minima

```
Step 1

↓

Find f'(x)
```

↓

```
Step 2

↓

Set

f'(x)=0
```

↓

```
Step 3

↓

Find Critical Points
```

↓

```
Step 4

↓

Use Second Derivative Test
```

↓

```
Step 5

↓

Conclude Maximum/Minimum
```

---

# First Derivative Test

Observe the sign of

```
f'(x)
```

### Positive to Negative

```
+

↓

-

```

Maximum

---

### Negative to Positive

```
-

↓

+
```

Minimum

---

### No Sign Change

Neither maximum nor minimum.

---

# Example

Suppose

```
f'(x)
```

changes as

```
+

+

0

-

-
```

Then

```
Maximum
```

occurs at that critical point.

---

# Second Derivative Test

Find

```
f''(x)
```

at the critical point.

---

## Case 1

```
f''(a)>0
```

Graph opens upward.

```
Minimum
```

---

## Case 2

```
f''(a)<0
```

Graph opens downward.

```
Maximum
```

---

## Case 3

```
f''(a)=0
```

Test is inconclusive.

Use

- First Derivative Test
- Higher derivatives

---

# Example

Find maxima/minima of

```
f(x)=x²
```

Step 1

```
f'(x)=2x
```

---

Step 2

```
2x=0

↓

x=0
```

---

Step 3

Second derivative

```
f''(x)=2
```

Since

```
2>0
```

Answer

```
Minimum at x=0
```

---

# Another Example

```
f(x)=-x²
```

Derivative

```
-2x
```

Critical point

```
x=0
```

Second derivative

```
-2
```

Negative

↓

```
Maximum
```

---

# Increasing and Decreasing Functions

## Increasing

If

```
f'(x)>0
```

Function increases.

```
↗
```

---

## Decreasing

If

```
f'(x)<0
```

Function decreases.

```
↘
```

---

# Concavity

Determined using

```
Second Derivative
```

---

## Concave Up

```
f''(x)>0
```

Shape

```
∪
```

---

## Concave Down

```
f''(x)<0
```

Shape

```
∩
```

---

# Inflection Point

A point where concavity changes.

Condition

```
f''(x)
```

changes sign.

Example

```
∪

↓

∩
```

or

```
∩

↓

∪
```

---

# Absolute Maximum and Minimum

For a closed interval

```
[a,b]
```

Check

- Critical points
- Endpoints

The largest value is the

```
Absolute Maximum
```

The smallest value is the

```
Absolute Minimum
```

---

# Optimization Problems

Common procedure

```
Read Question

↓

Form Equation

↓

Differentiate

↓

Set f'(x)=0

↓

Verify

↓

Answer
```

---

# Important Relationships

```
f'(x)=0

↓

Possible Max/Min
```

---

```
f''(x)>0

↓

Minimum
```

---

```
f''(x)<0

↓

Maximum
```

---

```
f''(x)=0

↓

Cannot Conclude
```

---

# Common GATE PYQs

- Critical Points
- First Derivative Test
- Second Derivative Test
- Increasing & Decreasing Functions
- Concavity
- Inflection Points
- Optimization Problems

---

# Quick Revision

✅ Critical Points

✅ First Derivative Test

✅ Second Derivative Test

✅ Increasing Function

✅ Decreasing Function

✅ Concavity

✅ Inflection Point

✅ Optimization

---

# Common Mistakes

❌ Assuming every point where

```
f'(x)=0
```

is a maximum or minimum.

---

❌ Forgetting to check

```
f''(x)
```

---

❌ Ignoring interval endpoints for absolute extrema.

---

❌ Forgetting that

```
f''(x)=0
```

does **not** imply an inflection point.

---

❌ Mixing local and global maxima.

---

# Memory Tricks

### Critical Point

```
f'(x)=0
```

---

### Minimum

```
f''>0

↓

Smile 😊

↓

Minimum
```

(Graph opens upward like a smile.)

---

### Maximum

```
f''<0

↓

Sad ☹

↓

Maximum
```

(Graph opens downward.)

---

### Increasing

```
f'>0
```

---

### Decreasing

```
f'<0
```

---

# Formula Sheet

| Formula | Meaning |
|----------|----------|
| `f'(x)=0` | Critical Point |
| `f''(x)>0` | Local Minimum |
| `f''(x)<0` | Local Maximum |
| `f''(x)=0` | Test Inconclusive |
| `f'(x)>0` | Increasing Function |
| `f'(x)<0` | Decreasing Function |

---

# PYQ Focus

⭐⭐⭐⭐☆

- Critical Points
- First Derivative Test
- Second Derivative Test
- Optimization Problems
- Increasing/Decreasing Functions
- Concavity
- Inflection Points

---

# Interview Corner

### Q1. Is every critical point a maximum or minimum?

❌ No. A critical point may also be a **point of inflection** or neither.

---

### Q2. What is the difference between local and global maximum?

- **Local Maximum:** Highest value only in a neighborhood.
- **Global Maximum:** Highest value over the entire domain.

---

### Q3. Which derivative tells us about concavity?

The **second derivative**, `f''(x)`, determines whether the graph is concave up or concave down.

---

# Next File

➡️ `24-Mean-Value-Theorem.md`