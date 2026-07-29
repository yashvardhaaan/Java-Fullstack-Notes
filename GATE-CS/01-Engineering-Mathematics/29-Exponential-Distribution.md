# Exponential Distribution

> GATE Weightage: ⭐⭐⭐⭐☆

---

# Why Do We Need Exponential Distribution?

Suppose you are waiting for

- A customer to arrive
- A network packet to arrive
- A bus to come
- A machine to fail
- A server request

The question is

```
How long until the next event?
```

The **Exponential Distribution** models the **waiting time** between events that occur randomly at a constant average rate.

---

# Intuition

Imagine customers entering a shop randomly.

```
Customer

↓

Wait

↓

Customer

↓

Wait

↓

Customer
```

The waiting time between consecutive arrivals follows an **Exponential Distribution** (if arrivals follow a Poisson process).

---

# Definition

The Exponential Distribution is a **continuous probability distribution** that models the **time between independent random events**.

Notation

```
X ~ Exp(λ)
```

where

```
λ

↓

Rate Parameter
```

---

# Characteristics

```
Exponential Distribution
│
├── Continuous
├── Waiting Time Distribution
├── One Parameter (λ)
├── Right Skewed
└── Memoryless
```

---

# Probability Density Function (PDF)

For

```
x ≥ 0
```

the PDF is

```
f(x)

=

λe^(-λx)
```

Otherwise

```
f(x)=0
```

---

# Graph

```
Probability

^

|

|\
| \
|  \
|   \
|    \
|     \______________> x
```

The probability is highest at

```
x=0
```

and decreases exponentially.

---

# Cumulative Distribution Function (CDF)

Formula

```
F(x)

=

1-e^(-λx)
```

for

```
x≥0
```

---

# Survival Function

Probability that the waiting time exceeds

```
x
```

Formula

```
P(X>x)

=

e^(-λx)
```

Very Important for GATE.

---

# Mean

Formula

```
Mean

=

1/λ
```

---

### Example

If

```
λ=2
```

events/hour

Then

```
Mean Waiting Time

=

1/2 hour
```

---

# Variance

Formula

```
Var(X)

=

1/λ²
```

---

# Standard Deviation

Formula

```
σ

=

1/λ
```

Notice

```
Mean

=

Standard Deviation
```

A unique property of the Exponential Distribution.

---

# Median

Formula

```
Median

=

ln(2)

------

λ
```

Usually not asked directly in GATE.

---

# Memoryless Property

The most important property.

It states

```
P(X>s+t | X>s)

=

P(X>t)
```

Meaning

If you've already waited

```
10 minutes
```

the expected future waiting behavior is **exactly the same** as if you had just started waiting.

The past does **not** affect the future.

---

# Why is it Called Memoryless?

Imagine waiting for a bus.

After waiting

```
20 minutes
```

your remaining waiting time still follows the same Exponential Distribution.

The process has

```
No Memory
```

---

# Relationship with Poisson Distribution

Very Important.

```
Poisson Distribution

↓

Counts Events
```

```
Exponential Distribution

↓

Measures Waiting Time
```

If events occur according to a **Poisson Process**, then

```
Waiting Time

↓

Exponential Distribution
```

---

# Example

A machine fails on average

```
3

times/hour
```

Then

```
λ=3
```

Mean waiting time

```
1/3

hour
```

Probability that failure occurs after

```
1 hour
```

```
P(X>1)

=

e^(-3)
```

---

# Applications

Exponential Distribution is used in

- Queueing Systems
- Network Packet Arrival
- Reliability Engineering
- Survival Analysis
- Machine Failure
- Server Response Time
- Customer Arrival Models

---

# Comparison with Normal Distribution

| Exponential | Normal |
|-------------|--------|
| Right-skewed | Symmetric |
| Waiting time | Measurements |
| Memoryless | Not memoryless |
| Parameter λ | Parameters μ, σ |

---

# Comparison with Poisson Distribution

| Poisson | Exponential |
|----------|-------------|
| Discrete | Continuous |
| Counts events | Waiting time |
| Parameter λ | Same λ |
| PMF | PDF |

---

# Important Properties

### Property 1

```
Continuous Distribution
```

---

### Property 2

```
Defined only for

x≥0
```

---

### Property 3

```
Area under PDF

=

1
```

---

### Property 4

```
Mean

=

1/λ
```

---

### Property 5

```
Variance

=

1/λ²
```

---

### Property 6

```
Memoryless
```

Most Important.

---

# Common GATE PYQs

- Mean
- Variance
- PDF
- CDF
- Memoryless Property
- Relation with Poisson Distribution
- Waiting Time Problems

---

# Quick Revision

✅ Exponential Distribution

✅ Waiting Time

✅ PDF

✅ CDF

✅ Mean

✅ Variance

✅ Memoryless Property

✅ Relation with Poisson Distribution

---

# Common Mistakes

❌ Confusing the **rate** parameter `λ` with the **mean**.

Remember

```
Mean

=

1/λ
```

---

❌ Applying the distribution to negative time values.

The Exponential Distribution is only defined for

```
x≥0
```

---

❌ Confusing Poisson and Exponential distributions.

- **Poisson** counts events.
- **Exponential** measures waiting time.

---

❌ Forgetting the memoryless property.

---

# Memory Tricks

### Exponential

```
Wait

↓

Next Event
```

---

### Mean

```
1

-

Rate
```

Think

```
Fast Rate

↓

Small Waiting Time
```

---

### Memoryless

```
Past

Does Not

Matter
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
| `f(x)=λe^{-λx}` | PDF |
| `F(x)=1-e^{-λx}` | CDF |
| `P(X>x)=e^{-λx}` | Survival Function |
| `Mean=1/λ` | Average Waiting Time |
| `Variance=1/λ²` | Spread |
| `SD=1/λ` | Standard Deviation |
| `P(X>s+t \| X>s)=P(X>t)` | Memoryless Property |

---

# PYQ Focus

⭐⭐⭐⭐☆

- PDF
- CDF
- Mean
- Variance
- Memoryless Property
- Poisson vs Exponential

---

# Interview Corner

### Q1. What does the Exponential Distribution model?

It models the **waiting time between independent random events** occurring at a constant average rate.

---

### Q2. Why is the Exponential Distribution called memoryless?

Because the probability of waiting longer **does not depend on how long you have already waited**.

---

### Q3. What is the relationship between Poisson and Exponential distributions?

If events occur according to a **Poisson process**, then:

- **Poisson Distribution** models the **number of events** in an interval.
- **Exponential Distribution** models the **time between consecutive events**.

---

# GATE 80/20 Summary

### Must Remember

- ✅ Continuous distribution for **waiting time**.
- ✅ `X ~ Exp(λ)`
- ✅ PDF: `λe^{-λx}`
- ✅ CDF: `1-e^{-λx}`
- ✅ Mean = `1/λ`
- ✅ Variance = `1/λ²`
- ✅ **Memoryless Property** is the most important concept.
- ✅ Poisson counts events; Exponential measures the time between them.

---

# Next File

➡️ `30-Poisson-Distribution.md`