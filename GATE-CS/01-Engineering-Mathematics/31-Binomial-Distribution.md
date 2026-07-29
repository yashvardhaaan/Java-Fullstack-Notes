# Binomial Distribution

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# Why Do We Need Binomial Distribution?

Suppose you want to know

- Number of Heads in 10 coin tosses
- Number of students who pass an exam
- Number of defective products in a batch
- Number of successful API requests
- Number of correct answers in an MCQ test

Each trial has only **two possible outcomes**.

```
Success

or

Failure
```

The **Binomial Distribution** models the number of successes in a fixed number of independent trials.

---

# Intuition

Imagine tossing a fair coin

```
5 Times
```

Possible outcomes

```
H H T H T
```

Number of Heads

```
3
```

The Binomial Distribution tells us the probability of getting exactly

```
0

1

2

3

4

5
```

heads.

---

# Definition

A **Binomial Distribution** is a **discrete probability distribution** that models the number of successes in

```
n
```

independent trials where each trial has probability

```
p
```

of success.

Notation

```
X ~ Bin(n,p)
```

---

# Characteristics

```
Binomial Distribution
│
├── Discrete
├── Fixed Number of Trials
├── Two Outcomes
├── Independent Trials
└── Constant Probability
```

---

# Conditions for Binomial Distribution

All the following must be true.

### 1. Fixed Number of Trials

```
n

is fixed.
```

---

### 2. Only Two Outcomes

```
Success

Failure
```

---

### 3. Independent Trials

Each trial does not affect another.

---

### 4. Constant Probability

Probability of success

```
p
```

remains constant.

---

# Parameters

```
n

↓

Number of Trials
```

---

```
p

↓

Probability of Success
```

---

```
q

=

1-p

↓

Probability of Failure
```

---

# Probability Mass Function (PMF)

Formula

```
                 nCx p^x q^(n-x)

P(X=x)

=

----------------------------

```

where

```
q=1-p
```

and

```
x

=

0,1,2,...,n
```

---

# Combination Formula

```
nCx

=

n!

------------

x!(n-x)!
```

---

# Example

A fair coin is tossed

```
3

times.
```

Find the probability of getting exactly

```
2 Heads
```

Given

```
n=3

p=1/2

q=1/2

x=2
```

Using the formula

```
P(X=2)

=

3C2

×

(1/2)^2

×

(1/2)^1

=

3/8
```

---

# Mean

Formula

```
Mean

=

np
```

---

### Example

```
n=20

p=0.4
```

Mean

```
20×0.4

=

8
```

---

# Variance

Formula

```
Variance

=

npq
```

---

### Example

```
20×0.4×0.6

=

4.8
```

---

# Standard Deviation

Formula

```
σ

=

√(npq)
```

---

# Shape of Binomial Distribution

Depends on

```
p
```

---

If

```
p=0.5
```

Distribution is

```
Symmetric
```

---

If

```
p<0.5
```

Distribution is

```
Right Skewed
```

---

If

```
p>0.5
```

Distribution is

```
Left Skewed
```

---

# Expected Value

```
E(X)

=

np
```

---

# Properties

### Property 1

Possible values

```
0

to

n
```

---

### Property 2

Uses

```
PMF
```

because it is discrete.

---

### Property 3

```
Mean

=

np
```

---

### Property 4

```
Variance

=

npq
```

---

### Property 5

```
q

=

1-p
```

---

# Relationship with Poisson Distribution

When

```
n

is very large
```

and

```
p

is very small
```

Binomial Distribution approaches

```
Poisson Distribution
```

where

```
λ=np
```

Very Important for GATE.

---

# Relationship with Normal Distribution

When

```
n
```

is large,

Binomial Distribution can be approximated using the

```
Normal Distribution
```

provided

```
np≥5

and

nq≥5
```

---

# Applications

Binomial Distribution is used in

- Coin Tosses
- Quality Control
- Medical Testing
- Survey Analysis
- Machine Learning
- A/B Testing
- Software Reliability

---

# Comparison with Poisson Distribution

| Binomial | Poisson |
|-----------|----------|
| Fixed trials | No fixed trials |
| Parameters `n,p` | Parameter `λ` |
| Finite outcomes | Infinite outcomes |
| Successes | Event counts |

---

# Comparison with Normal Distribution

| Binomial | Normal |
|-----------|---------|
| Discrete | Continuous |
| PMF | PDF |
| Counts successes | Measures continuous values |
| Parameters `n,p` | Parameters `μ,σ` |

---

# Common GATE PYQs

- PMF Formula
- Mean
- Variance
- Standard Deviation
- Conditions of Binomial Distribution
- Binomial Approximation
- Poisson Approximation

---

# Quick Revision

✅ Fixed Number of Trials

✅ Two Outcomes

✅ Independent Trials

✅ Constant Probability

✅ PMF

✅ Mean

✅ Variance

---

# Common Mistakes

❌ Forgetting

```
q=1-p
```

---

❌ Confusing

```
nCx
```

with

```
nPx
```

---

❌ Using Binomial Distribution when the number of trials is **not fixed**.

---

❌ Forgetting that trials must be

```
Independent
```

---

❌ Mixing Binomial and Poisson formulas.

---

# Memory Tricks

### Binomial

```
Binary

↓

Two Outcomes
```

---

### Parameters

```
n

↓

Trials
```

```
p

↓

Success
```

```
q

↓

Failure
```

---

### Mean

```
Trials

×

Success Probability
```

---

### Variance

```
Mean

×

Failure Probability
```

or

```
npq
```

---

# Formula Sheet

| Formula | Meaning |
|----------|----------|
| `P(X=x)=nCx·p^x·q^(n-x)` | PMF |
| `q=1-p` | Failure Probability |
| `Mean=np` | Expected Value |
| `Variance=npq` | Spread |
| `SD=√(npq)` | Standard Deviation |
| `nCx=n!/[x!(n-x)!]` | Combination |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- PMF
- Mean = `np`
- Variance = `npq`
- Conditions of Binomial Distribution
- Binomial vs Poisson
- Binomial vs Normal

---

# Interview Corner

### Q1. When should you use the Binomial Distribution?

Use it when there is:

- A **fixed number of trials**
- **Two possible outcomes**
- **Independent trials**
- **Constant probability of success**

---

### Q2. What is the difference between Binomial and Poisson Distribution?

- **Binomial Distribution** counts successes in a **fixed number of trials**.
- **Poisson Distribution** counts events occurring in a **fixed interval** without a fixed number of trials.

---

### Q3. Why is `q = 1 - p`?

Since there are only two outcomes:

```
Success

or

Failure
```

their probabilities must add up to **1**.

---

# GATE 80/20 Summary

### Must Remember

- ✅ `X ~ Bin(n,p)`
- ✅ Two outcomes: **Success** and **Failure**
- ✅ PMF:

```
P(X=x)

=

nCx·p^x·(1-p)^(n-x)
```

- ✅ Mean = `np`
- ✅ Variance = `np(1-p)`
- ✅ SD = `√(np(1-p))`
- ✅ Poisson Approximation: Large `n`, Small `p`, `λ=np`
- ✅ Normal Approximation: `np≥5` and `n(1-p)≥5`

---

# Next File

➡️ `32-Mean-Median-Mode.md`