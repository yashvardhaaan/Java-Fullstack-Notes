# Uniform Distribution

> GATE Weightage: ⭐⭐⭐⭐☆

---

# Why Do We Need Uniform Distribution?

Suppose you roll a **fair die**.

Each outcome

```
1

2

3

4

5

6
```

has exactly the same probability.

Similarly,

Suppose a bus arrives **randomly** between

```
10:00 AM

and

11:00 AM
```

Every instant within that hour is equally likely.

Both situations are examples of a **Uniform Distribution**.

---

# Intuition

The word **Uniform** means

```
Equal

or

Constant
```

Every outcome is **equally likely**.

Unlike other distributions where some outcomes are more likely,

Uniform Distribution treats all outcomes equally.

---

# Types of Uniform Distribution

```
Uniform Distribution
│
├── Discrete Uniform Distribution
└── Continuous Uniform Distribution
```

---

# Discrete Uniform Distribution

Every possible value has the **same probability**.

Examples

- Fair coin
- Fair die
- Lottery number
- Random card selection

---

## Example

Roll a fair die.

Possible values

```
1

2

3

4

5

6
```

Each has probability

```
1/6
```

---

# PMF

For

```
n
```

equally likely outcomes

```
P(X=x)

=

1/n
```

---

# Example

Choose one number from

```
1

2

3

4
```

Each probability

```
1/4
```

---

# Properties

```
All probabilities

Equal
```

---

```
Sum of probabilities

=

1
```

---

# Mean (Discrete Uniform)

Formula

```
E(X)

=

First+Last

------------

2
```

Example

```
1

to

6
```

Mean

```
(1+6)/2

=

3.5
```

---

# Variance (Discrete Uniform)

Formula

```
Var(X)

=

n²−1

--------

12
```

where

```
n

=

Number of Values
```

Example

For a die

```
n=6
```

Variance

```
(36−1)/12

=

35/12
```

---

# Continuous Uniform Distribution

A random variable is uniformly distributed over

```
[a,b]
```

if every value between

```
a

and

b
```

is equally likely.

Notation

```
X ~ U(a,b)
```

---

# Probability Density Function (PDF)

Formula

```
          1
f(x)=-----------

        b−a
```

for

```
a≤x≤b
```

Otherwise

```
f(x)=0
```

---

# Graph of Continuous Uniform Distribution

```
f(x)

 ^
 |
 |──────────────
 |              |
 |              |
 |______________|________> x
      a         b
```

Height

```
1/(b-a)
```

Area under the graph = 1.

---

# Why is Height = 1/(b-a)?

Total probability must be

```
1
```

Area

```
Rectangle

=

Base × Height
```

Base

```
b-a
```

Hence

```
Height

=

1/(b-a)
```

---

# Cumulative Distribution Function (CDF)

Formula

```
          0

x<a
```

---

```
F(x)

=

(x-a)

--------

(b-a)

a≤x≤b
```

---

```
1

x>b
```

---

# Mean (Continuous Uniform)

Formula

```
μ

=

a+b

------

2
```

---

### Example

```
U(2,8)
```

Mean

```
(2+8)/2

=

5
```

---

# Variance (Continuous Uniform)

Formula

```
σ²

=

(b-a)²

---------

12
```

---

### Example

```
U(2,8)
```

Variance

```
(6²)/12

=

3
```

---

# Standard Deviation

Formula

```
σ

=

√[(b-a)²/12]

=

(b-a)

--------

√12
```

---

# Probability Between Two Values

For

```
a≤c≤d≤b
```

Formula

```
P(c<X<d)

=

d-c

-------

b-a
```

Simply

```
Length of Interval

------------------

Total Length
```

Very Important.

---

# Example

Suppose

```
X~U(0,10)
```

Find

```
P(2<X<5)
```

Solution

```
(5−2)

--------

10−0

=

3/10

=

0.3
```

---

# Properties

### Property 1

All intervals of the same length have equal probability.

---

### Property 2

PDF is constant.

---

### Property 3

Area under the PDF

```
=

1
```

---

### Property 4

Mean lies exactly at the center.

---

### Property 5

Symmetric distribution.

---

# Applications

Uniform Distribution is used in

- Random Number Generation
- Computer Simulations
- Cryptography
- Monte Carlo Methods
- Gaming
- Random Sampling

---

# Discrete vs Continuous Uniform

| Feature | Discrete | Continuous |
|----------|-----------|------------|
| Values | Countable | Infinite |
| Formula | `1/n` | `1/(b-a)` |
| Function | PMF | PDF |
| Mean | `(First+Last)/2` | `(a+b)/2` |
| Variance | `(n²−1)/12` | `(b-a)²/12` |

---

# Common GATE PYQs

- Mean of Uniform Distribution
- Variance Formula
- Continuous PDF
- CDF
- Probability over an interval
- Discrete vs Continuous Uniform

---

# Quick Revision

✅ Uniform Distribution

✅ Discrete Uniform

✅ Continuous Uniform

✅ PDF

✅ CDF

✅ Mean

✅ Variance

✅ Interval Probability

---

# Common Mistakes

❌ Using PMF formula for a continuous distribution.

❌ Forgetting that the PDF height is

```
1/(b-a)
```

❌ Calculating probability by multiplying the PDF incorrectly instead of using the interval length.

❌ Confusing the number of values `n` with the interval length `(b-a)`.

---

# Memory Tricks

### Uniform

```
Everything

Equal
```

---

### Continuous PDF

```
Height

=

1

------

Length
```

---

### Mean

```
Middle

Point
```

---

### Probability

```
Required Length

----------------

Total Length
```

---

# Formula Sheet

| Formula | Result |
|----------|--------|
| Discrete PMF | `P(X=x)=1/n` |
| Continuous PDF | `f(x)=1/(b-a)` |
| Mean | `(a+b)/2` |
| Variance | `(b-a)²/12` |
| Standard Deviation | `(b-a)/√12` |
| Interval Probability | `(d-c)/(b-a)` |
| CDF | `(x-a)/(b-a)` for `a≤x≤b` |

---

# PYQ Focus

⭐⭐⭐⭐☆

- Uniform PDF
- Mean
- Variance
- CDF
- Interval Probability
- Discrete vs Continuous Uniform

---

# Interview Corner

### Q1. Why is it called a Uniform Distribution?

Because every outcome (or every value in the interval) is **equally likely**, making the probability distribution constant.

---

### Q2. What is the shape of the PDF of a continuous uniform distribution?

A **rectangle**, since the probability density is constant over the interval `[a,b]`.

---

### Q3. How do you find the probability between two values in a continuous uniform distribution?

Divide the **length of the required interval** by the **total interval length**:

```
P(c<X<d)

=

(d-c)/(b-a)
```

---

# GATE 80/20 Summary

### Must Remember

- ✅ Discrete Uniform: `P(X=x)=1/n`
- ✅ Continuous Uniform: `f(x)=1/(b-a)`
- ✅ Mean = `(a+b)/2`
- ✅ Variance = `(b-a)²/12`
- ✅ Probability = `Required Length / Total Length`
- ✅ Total area under the PDF is **1**

---

# Next File

➡️ `28-Normal-Distribution.md`