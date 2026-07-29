# Random Variables

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# Why Do We Need Random Variables?

Many real-life events are **uncertain**.

Examples

- Tossing a coin
- Rolling a dice
- Number of customers visiting a website
- Time taken by a server to respond
- Packet loss in a network

Instead of predicting the exact outcome, we assign **numerical values** to outcomes.

These numerical values are called **Random Variables**.

---

# Intuition

Consider tossing a coin.

Possible outcomes

```
Head

Tail
```

Instead of writing

```
Head

Tail
```

assign numbers

```
Head → 1

Tail → 0
```

Now we can perform mathematical analysis.

This mapping is called a **Random Variable**.

---

# Definition

A **Random Variable (RV)** is a function that assigns a **real number** to every outcome of a random experiment.

Notation

```
X

Y

Z
```

Example

```
Experiment

↓

Roll a Dice
```

```
Outcome

↓

1 2 3 4 5 6
```

Random Variable

```
X

=

Face Value
```

---

# Probability Experiment

A random experiment consists of

```
Experiment

↓

Sample Space

↓

Random Variable

↓

Probability
```

Example

```
Coin Toss

↓

{H,T}

↓

X={1,0}
```

---

# Sample Space

The set of all possible outcomes.

Notation

```
S
```

Example

Dice

```
S

=

{1,2,3,4,5,6}
```

---

# Event

A subset of the sample space.

Example

Even number

```
{2,4,6}
```

---

# Random Variable vs Random Experiment

| Random Experiment | Random Variable |
|-------------------|-----------------|
| Toss coin | Head = 1, Tail = 0 |
| Roll dice | Face value |
| Draw card | Card number |

Remember

```
Experiment

↓

Produces Outcome

↓

RV Assigns Number
```

---

# Types of Random Variables

```
Random Variables
│
├── Discrete
└── Continuous
```

---

# Discrete Random Variable

Has **countable** values.

Examples

- Number of heads
- Number of packets lost
- Number of customers

Possible values

```
0

1

2

3

...
```

---

# Continuous Random Variable

Can take **any value in an interval**.

Examples

- Height
- Weight
- Temperature
- Time
- Voltage

Possible values

```
2.01

2.011

2.0115

...
```

Infinitely many values.

---

# Comparison

| Discrete | Continuous |
|-----------|------------|
| Countable | Uncountable |
| PMF | PDF |
| Sum = 1 | Area = 1 |

Very Important.

---

# Probability Mass Function (PMF)

Used for **Discrete Random Variables**.

Definition

```
P(X=x)
```

Properties

```
0≤P(X=x)≤1
```

and

```
ΣP(X=x)

=

1
```

---

# Example

Roll a fair die.

```
P(X=1)

=

1/6
```

```
P(X=5)

=

1/6
```

---

# Probability Distribution Table

| X | P(X) |
|---|------|
| 1 | 1/6 |
| 2 | 1/6 |
| 3 | 1/6 |
| 4 | 1/6 |
| 5 | 1/6 |
| 6 | 1/6 |

Check

```
6×1/6

=

1
```

---

# Probability Density Function (PDF)

Used for **Continuous Random Variables**.

Notation

```
f(x)
```

Important Point

```
P(X=x)

=

0
```

for any single value.

Probability exists only over an interval.

---

# Interval Probability

```
P(a<X<b)

=

 b
⌠
⌡f(x)dx
a
```

---

# Properties of PDF

### Property 1

```
f(x)

≥

0
```

---

### Property 2

Total area

```
∞
⌠
⌡f(x)dx

=

1
-∞
```

---

# Cumulative Distribution Function (CDF)

Definition

Probability that

```
X≤x
```

Notation

```
F(x)
```

Formula

```
F(x)

=

P(X≤x)
```

---

# Relationship Between PDF and CDF

For continuous variables

```
F(x)

=

x
⌠
⌡f(t)dt
-∞
```

Also,

```
f(x)

=

dF(x)

------

dx
```

Very Important.

---

# Expected Value (Mean)

The average value of a random variable.

Notation

```
E(X)
```

---

## Discrete Case

Formula

```
E(X)

=

ΣxP(x)
```

---

### Example

Fair Die

```
(1+2+3+4+5+6)

--------------

6

=

3.5
```

Notice

```
3.5
```

is **not** a possible outcome.

It is only the average.

---

## Continuous Case

```
∞
⌠
⌡xf(x)dx
-∞
```

---

# Variance

Measures the spread of data around the mean.

Notation

```
Var(X)
```

Formula

```
Var(X)

=

E[(X−μ)²]
```

Alternative formula

```
Var(X)

=

E(X²)

−

(E(X))²
```

Frequently asked in GATE.

---

# Standard Deviation

Definition

```
σ

=

√Var(X)
```

---

# Properties of Expectation

If

```
a,b
```

are constants

```
E(aX+b)

=

aE(X)+b
```

---

# Properties of Variance

```
Var(c)

=

0
```

---

```
Var(aX+b)

=

a²Var(X)
```

---

# Independence

Two random variables

```
X

and

Y
```

are independent if

```
P(X,Y)

=

P(X)P(Y)
```

---

# Joint Probability

Probability involving two random variables.

Notation

```
P(X,Y)
```

---

# Marginal Probability

Obtained by summing over the other variable.

Example

```
P(X)

=

ΣP(X,Y)
```

---

# Conditional Probability

Formula

```
P(A|B)

=

P(A∩B)

---------

P(B)
```

This is covered in detail later.

---

# Common GATE PYQs

- Discrete vs Continuous RV
- PMF
- PDF
- CDF
- Expected Value
- Variance
- Standard Deviation
- Properties of Expectation
- Independence

---

# Quick Revision

✅ Random Variable

✅ Discrete RV

✅ Continuous RV

✅ PMF

✅ PDF

✅ CDF

✅ Mean

✅ Variance

✅ Standard Deviation

---

# Common Mistakes

❌ Confusing **PMF** with **PDF**.

❌ Forgetting that

```
P(X=x)=0
```

for continuous variables.

❌ Forgetting

```
ΣP(X)=1
```

for discrete distributions.

❌ Mixing Expected Value and Probability.

❌ Forgetting the shortcut

```
Var(X)=E(X²)−(E(X))²
```

---

# Memory Tricks

### Random Variable

```
Outcome

↓

Number
```

---

### PMF

```
Discrete

↓

Probability
```

---

### PDF

```
Continuous

↓

Area
```

---

### Mean

```
Average

=

ΣxP(x)
```

---

### Variance

```
Spread

=

E(X²)

−

Mean²
```

---

# Formula Sheet

| Formula | Meaning |
|----------|----------|
| `E(X)=ΣxP(x)` | Mean (Discrete) |
| `E(X)=∫xf(x)dx` | Mean (Continuous) |
| `Var(X)=E(X²)−(E(X))²` | Variance |
| `σ=√Var(X)` | Standard Deviation |
| `F(x)=P(X≤x)` | CDF |
| `f(x)=dF(x)/dx` | PDF from CDF |
| `P(a<X<b)=∫f(x)dx` | Interval Probability |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- PMF
- PDF
- CDF
- Mean
- Variance
- Standard Deviation
- Discrete vs Continuous
- Expectation Properties

---

# Interview Corner

### Q1. What is the difference between a random experiment and a random variable?

A **random experiment** produces outcomes, while a **random variable** assigns numerical values to those outcomes.

---

### Q2. Why is `P(X=x)=0` for continuous random variables?

Because a continuous random variable has infinitely many possible values. Probability is assigned over **intervals**, not individual points.

---

### Q3. Can the expected value be a value that never actually occurs?

✅ Yes. For example, the expected value of a fair die is **3.5**, even though 3.5 can never appear on the die.

---

# GATE 80/20 Summary

### Must Remember

- ✅ Random Variable = Numerical mapping of outcomes.
- ✅ Discrete → PMF → `ΣP(x)=1`
- ✅ Continuous → PDF → Total Area = `1`
- ✅ `F(x)=P(X≤x)`
- ✅ `E(X)=ΣxP(x)`
- ✅ `Var(X)=E(X²)−(E(X))²`
- ✅ `σ=√Var(X)`

---

# Next File

➡️ `27-Uniform-Distribution.md`