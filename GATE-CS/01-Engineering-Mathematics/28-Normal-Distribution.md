# Normal Distribution

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# Why Do We Need Normal Distribution?

Many real-world measurements naturally follow a **bell-shaped pattern**.

Examples

- Heights of people
- IQ scores
- Measurement errors
- Exam marks
- Machine component dimensions
- Network latency (approximately)

Instead of each value being equally likely, values near the **average** occur much more frequently.

This is modeled using the **Normal Distribution**.

---

# Intuition

Imagine the marks of 10,000 students.

Most students score around

```
60–70
```

Very few score

```
0

or

100
```

The graph looks like

```
                 ▲
               ▲ ▲ ▲
            ▲▲▲▲▲▲▲▲▲
         ▲▲▲▲▲▲▲▲▲▲▲▲▲
      ▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲
---------------------------------->
```

This is called the

```
Bell Curve
```

---

# Definition

A **Normal Distribution** is a continuous probability distribution that is

- Bell-shaped
- Symmetric
- Completely determined by

```
Mean (μ)

and

Standard Deviation (σ)
```

Notation

```
X ~ N(μ,σ²)
```

---

# Characteristics

```
Normal Distribution
│
├── Bell-shaped
├── Symmetric
├── Mean = Median = Mode
├── Total Area = 1
├── Continuous
└── Tails extend infinitely
```

---

# Graph

```
Probability

^

|                    ▲

|                 ▲▲▲▲▲

|              ▲▲▲▲▲▲▲▲▲

|           ▲▲▲▲▲▲▲▲▲▲▲▲▲

|________▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲________> x

          μ
```

---

# Mean, Median and Mode

For a Normal Distribution

```
Mean

=

Median

=

Mode
```

All three occur at the center.

---

# Symmetry

The graph is perfectly symmetric.

```
Left Area

=

Right Area

=

0.5
```

Half the observations lie on each side of the mean.

---

# Probability Density Function (PDF)

Formula

```
                 1
f(x)= -------------------------

          σ√(2π)

          × e^(-(x-μ)² / 2σ²)
```

**You are NOT expected to memorize this formula for GATE CSE**, but you should recognize it.

---

# Mean (μ)

Represents the center of the distribution.

Moving

```
μ
```

shifts the curve left or right.

---

# Standard Deviation (σ)

Measures spread.

Small σ

```
      ▲
     ▲▲▲
    ▲▲▲▲▲
```

Tall and narrow.

---

Large σ

```
   ▲▲▲▲▲▲▲▲▲▲
```

Wide and flat.

---

# Variance

Formula

```
Variance

=

σ²
```

---

# Total Area

Entire area under the curve

```
=

1
```

This represents total probability.

---

# Standard Normal Distribution

A special Normal Distribution with

```
Mean

=

0
```

and

```
Standard Deviation

=

1
```

Notation

```
Z ~ N(0,1)
```

---

# Z-Score

Converts any Normal Distribution into the Standard Normal Distribution.

Formula

```
Z

=

(X-μ)

-------

σ
```

Very Important.

---

# Interpretation of Z-Score

```
Z=0
```

Exactly at the mean.

---

```
Z=1
```

One standard deviation above the mean.

---

```
Z=-2
```

Two standard deviations below the mean.

---

# Why Convert to Z?

Instead of remembering different probability tables,

convert every Normal Distribution into

```
Standard Normal
```

and use one common table.

---

# Empirical Rule (68–95–99.7 Rule)

One of the most important facts.

```
Within

μ±σ

↓

68%
```

---

```
Within

μ±2σ

↓

95%
```

---

```
Within

μ±3σ

↓

99.7%
```

Visualization

```
      |----68%----|

   |------95%------|

|------99.7%------|
```

---

# Area Properties

```
Left of Mean

=

0.5
```

---

```
Right of Mean

=

0.5
```

---

```
Entire Area

=

1
```

---

# Standard Normal Table

The Z-table provides

```
P(Z<z)
```

Example

```
P(Z<1.0)

≈

0.8413
```

Meaning

84.13% of observations lie below

```
Z=1
```

---

# Example

Marks are normally distributed.

```
μ=70

σ=10
```

Find the Z-score for

```
90
```

Solution

```
Z

=

(90-70)

-------

10

=

2
```

Interpretation

The score is

```
2 Standard Deviations

Above the Mean
```

---

# Applications

Normal Distribution is used in

- Machine Learning
- Artificial Intelligence
- Quality Control
- Statistics
- Data Science
- Signal Processing
- Finance
- Manufacturing

---

# Comparison with Uniform Distribution

| Uniform | Normal |
|----------|--------|
| Equal probability | Middle values more likely |
| Rectangle-shaped PDF | Bell-shaped PDF |
| Constant density | Variable density |
| Every interval equally likely | Values near mean are more likely |

---

# Common GATE PYQs

- Properties of Normal Distribution
- Standard Normal Distribution
- Z-score
- Empirical Rule
- Mean = Median = Mode
- Symmetry
- Area under the curve

---

# Quick Revision

✅ Normal Distribution

✅ Bell Curve

✅ Mean

✅ Standard Deviation

✅ Variance

✅ Z-score

✅ Standard Normal Distribution

✅ 68–95–99.7 Rule

---

# Common Mistakes

❌ Confusing variance

```
σ²
```

with standard deviation

```
σ
```

---

❌ Forgetting to subtract the mean before dividing in the Z-score formula.

---

❌ Assuming the graph has finite ends.

The tails extend infinitely.

---

❌ Thinking the highest probability occurs at the extremes.

It occurs near the mean.

---

# Memory Tricks

### Bell Curve

```
Most Data

Near Mean
```

---

### Z-score

```
Actual

-

Mean

--------

Standard Deviation
```

---

### Symmetry

```
Left

=

Right
```

---

### Empirical Rule

```
1σ

↓

68%
```

```
2σ

↓

95%
```

```
3σ

↓

99.7%
```

---

# Formula Sheet

| Formula | Meaning |
|----------|----------|
| `X ~ N(μ,σ²)` | Normal Distribution |
| `Z=(X-μ)/σ` | Z-score |
| Variance | `σ²` |
| Standard Deviation | `σ` |
| Within `μ±σ` | 68% |
| Within `μ±2σ` | 95% |
| Within `μ±3σ` | 99.7% |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- Z-score
- Standard Normal Distribution
- Empirical Rule
- Mean = Median = Mode
- Properties of Bell Curve
- Symmetry

---

# Interview Corner

### Q1. Why is the Normal Distribution called a Bell Curve?

Because its graph is symmetric and resembles the shape of a **bell**, with most observations concentrated around the mean.

---

### Q2. What is the purpose of the Z-score?

The Z-score standardizes observations so that different normal distributions can be compared using the **Standard Normal Distribution**.

---

### Q3. What does the 68–95–99.7 rule represent?

It tells us the approximate percentage of observations that lie within:

- **1 standard deviation:** 68%
- **2 standard deviations:** 95%
- **3 standard deviations:** 99.7%

---

# GATE 80/20 Summary

### Must Remember

- ✅ Bell-shaped and symmetric distribution.
- ✅ Mean = Median = Mode.
- ✅ Total area under the curve = **1**.
- ✅ Standard Normal Distribution: `N(0,1)`.
- ✅ `Z = (X-μ)/σ`.
- ✅ **68–95–99.7 Rule** is one of the most frequently tested concepts.

---

# Next File

➡️ `29-Exponential-Distribution.md`