# Poisson Distribution

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# Why Do We Need Poisson Distribution?

Suppose we want to count

- Number of emails received in 1 hour
- Number of customers entering a shop
- Number of packets arriving at a router
- Number of typing mistakes in a page
- Number of road accidents per day

The question is

```
How many events occur
in a fixed interval?
```

The **Poisson Distribution** answers this question.

---

# Intuition

Imagine a call center.

Calls arrive randomly.

Sometimes

```
0 calls
```

Sometimes

```
2 calls
```

Sometimes

```
5 calls
```

The exact number is uncertain, but we know the **average rate**.

Poisson Distribution models this situation.

---

# Definition

The **Poisson Distribution** is a **discrete probability distribution** that gives the probability of observing exactly

```
k events
```

in a fixed interval of time, area, or space.

Notation

```
X ~ Poisson(λ)
```

where

```
λ

↓

Average Number of Events
```

---

# Characteristics

```
Poisson Distribution
│
├── Discrete
├── Counts Events
├── One Parameter (λ)
├── Infinite Possible Values
└── Independent Events
```

---

# Conditions for Poisson Distribution

Poisson Distribution is applicable when

✅ Events occur randomly.

✅ Events occur independently.

✅ Average rate remains constant.

✅ Two events cannot occur at exactly the same instant (ideal assumption).

---

# Probability Mass Function (PMF)

Formula

```
             λᵏe⁻ˡ
P(X=k)

=

----------------

      k!
```

where

```
k

=

0,1,2,3,...
```

---

# Meaning of Symbols

```
λ

↓

Average Events
```

---

```
k

↓

Observed Events
```

---

```
e

↓

Euler's Constant

≈2.718
```

---

```
k!

↓

Factorial
```

---

# Example

Suppose

```
Average customers/hour

=

4
```

Then

```
λ=4
```

Probability of exactly

```
3 customers
```

```
          4³e⁻⁴

------------------

3!
```

---

# Mean

Formula

```
Mean

=

λ
```

---

# Variance

Formula

```
Variance

=

λ
```

---

# Standard Deviation

Formula

```
σ

=

√λ
```

---

# Important Property

For Poisson Distribution

```
Mean

=

Variance
```

This is one of its most important properties.

---

# Shape of Poisson Distribution

For small

```
λ
```

Distribution is

```
Right Skewed
```

---

As

```
λ
```

increases,

the distribution becomes more symmetric and starts resembling the

```
Normal Distribution
```

---

# Graph (Example)

```
Probability

^

|

|        █

|      ███

|    █████

|  ███████

|______________________> k

 0 1 2 3 4 5 6
```

---

# Expected Value

```
E(X)

=

λ
```

---

# Moment Generating Function (Optional)

Rarely asked in GATE.

```
M(t)

=

exp(λ(eᵗ−1))
```

Know only for advanced study.

---

# Relationship with Exponential Distribution

Very Important.

```
Poisson

↓

Counts Events
```

```
Exponential

↓

Measures Waiting Time
```

If events occur according to a Poisson process,

then

```
Waiting Time

↓

Exponential Distribution
```

---

# Relationship with Binomial Distribution

Poisson is an approximation of Binomial when

```
n

Very Large
```

and

```
p

Very Small
```

with

```
λ=np
```

Very Important for GATE.

---

# Example

Suppose

```
1000 bulbs
```

are manufactured.

Probability of defect

```
0.002
```

Then

```
λ

=

1000×0.002

=

2
```

Instead of Binomial,

Poisson approximation can be used.

---

# Applications

Poisson Distribution is used in

- Queueing Theory
- Computer Networks
- Traffic Analysis
- Reliability Engineering
- Manufacturing
- Insurance
- Telecommunications
- Web Server Requests

---

# Comparison with Binomial Distribution

| Binomial | Poisson |
|----------|----------|
| Fixed number of trials | Unlimited events |
| Two outcomes | Counts events |
| Parameters `n,p` | Parameter `λ` |
| Finite values | Infinite values |

---

# Comparison with Exponential Distribution

| Poisson | Exponential |
|----------|-------------|
| Discrete | Continuous |
| Counts events | Waiting time |
| PMF | PDF |
| Mean = λ | Mean = 1/λ |

---

# Properties

### Property 1

```
Discrete Distribution
```

---

### Property 2

```
Mean

=

Variance

=

λ
```

---

### Property 3

Possible values

```
0

1

2

3

...
```

---

### Property 4

Uses PMF instead of PDF.

---

### Property 5

Probability sum

```
=

1
```

---

# Common GATE PYQs

- PMF Formula
- Mean
- Variance
- Standard Deviation
- Binomial Approximation
- Poisson vs Exponential
- Poisson vs Binomial

---

# Quick Revision

✅ Counts Events

✅ PMF

✅ Mean

✅ Variance

✅ Standard Deviation

✅ Binomial Approximation

✅ Applications

---

# Common Mistakes

❌ Confusing Poisson with Exponential.

Remember

```
Poisson

↓

Counts
```

---

❌ Forgetting that

```
Mean

=

Variance
```

---

❌ Using PDF instead of PMF.

Poisson is

```
Discrete
```

---

❌ Forgetting the factorial

```
k!
```

in the denominator.

---

# Memory Tricks

### Poisson

```
Count

Events
```

---

### Formula

```
λᵏ

↓

Events

e⁻ˡ

↓

Decay

k!

↓

Normalization
```

---

### Mean

```
Mean

=

Variance

=

λ
```

---

### Relationship

```
Poisson

↓

Count

Exponential

↓

Wait
```

---

# Formula Sheet

| Formula | Meaning |
|----------|----------|
| `P(X=k)=λᵏe⁻ˡ/k!` | PMF |
| `Mean=λ` | Expected Value |
| `Variance=λ` | Spread |
| `SD=√λ` | Standard Deviation |
| `λ=np` | Binomial Approximation |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- PMF
- Mean = Variance
- Binomial Approximation
- Poisson vs Exponential
- Applications

---

# Interview Corner

### Q1. What does the Poisson Distribution model?

It models the **number of events occurring in a fixed interval** when events occur independently at a constant average rate.

---

### Q2. Why are the mean and variance equal in a Poisson Distribution?

This is a mathematical property of the Poisson Distribution:

```
Mean

=

Variance

=

λ
```

It is often used to identify Poisson-distributed data.

---

### Q3. When is Poisson used instead of Binomial?

When

- Number of trials (`n`) is very large,
- Probability of success (`p`) is very small,
- and `λ = np` remains moderate,

the Poisson Distribution provides an excellent approximation.

---

# GATE 80/20 Summary

### Must Remember

- ✅ Poisson Distribution counts **events**.
- ✅ `X ~ Poisson(λ)`
- ✅ PMF:

```
P(X=k)

=

(λᵏe⁻ˡ)/k!
```

- ✅ Mean = `λ`
- ✅ Variance = `λ`
- ✅ Standard Deviation = `√λ`
- ✅ Poisson approximates Binomial when `n` is large and `p` is small.
- ✅ Exponential Distribution models the waiting time between Poisson events.

---

# Next File

➡️ `31-Binomial-Distribution.md`