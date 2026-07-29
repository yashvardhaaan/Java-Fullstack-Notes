# Standard Deviation

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# Why Do We Need Standard Deviation?

Suppose two classes have the same average marks.

```
Class A

60 60 60 60 60
```

Mean

```
60
```

---

```
Class B

20 40 60 80 100
```

Mean

```
60
```

Both classes have the same **Mean**.

But clearly,

```
Class A

↓

Students scored almost equally.
```

```
Class B

↓

Marks vary a lot.
```

To measure this **spread**, we use

```
Standard Deviation
```

---

# Intuition

Standard Deviation answers the question

```
How far are the observations

from the Mean?
```

Small SD

```
Values are close together.
```

Large SD

```
Values are widely spread.
```

---

# Measures of Dispersion

```
Dispersion
│
├── Range
├── Variance
└── Standard Deviation
```

Standard Deviation is the **most important** measure.

---

# Variance

Variance measures the **average squared distance** from the mean.

Formula (Population)

```
          Σ(x−μ)²

Variance = -----------

              N
```

where

```
μ

↓

Population Mean
```

```
N

↓

Population Size
```

---

# Sample Variance

Formula

```
          Σ(x−x̄)²

s² = ----------------

            n−1
```

where

```
x̄

↓

Sample Mean
```

---

# Why Do We Square?

Suppose

```
Mean = 50
```

Observations

```
45

55
```

Deviations

```
-5

+5
```

Adding them gives

```
0
```

which is misleading.

Squaring makes every deviation positive.

```
(-5)² = 25

(+5)² = 25
```

---

# Standard Deviation

Standard Deviation is the square root of variance.

Formula

```
σ

=

√Variance
```

Population Formula

```
        Σ(x−μ)²
σ = √ ------------

            N
```

Sample Formula

```
        Σ(x−x̄)²
s = √ --------------

           n−1
```

---

# Example

Data

```
2

4

6

8

10
```

Mean

```
6
```

Deviations

```
-4

-2

0

2

4
```

Squares

```
16

4

0

4

16
```

Sum

```
40
```

Variance

```
40/5

=

8
```

Standard Deviation

```
√8

≈2.83
```

---

# Shortcut Formula for Variance

Instead of calculating deviations,

use

```
Variance

=

E(X²)

−

(E(X))²
```

Very Important for GATE.

---

# Properties of Standard Deviation

### Property 1

```
Standard Deviation

≥0
```

Always non-negative.

---

### Property 2

If all observations are equal

```
SD=0
```

---

### Property 3

Larger spread

↓

Larger SD

---

### Property 4

Small spread

↓

Small SD

---

### Property 5

Same units as the original data.

Unlike variance, which has squared units.

---

# Effect of Adding a Constant

Suppose

```
New Data

=

Old Data + c
```

Then

```
Mean Changes
```

But

```
Standard Deviation

Does NOT Change
```

---

# Effect of Multiplying by a Constant

Suppose

```
New Data

=

a×Old Data
```

Then

```
New SD

=

|a| × Old SD
```

---

# Standard Deviation vs Variance

| Variance | Standard Deviation |
|-----------|--------------------|
| Squared units | Original units |
| Harder to interpret | Easier to interpret |
| Square of SD | Square root of Variance |

---

# Standard Deviation vs Range

| Range | Standard Deviation |
|--------|--------------------|
| Uses only min & max | Uses all observations |
| Less reliable | More reliable |
| Simple | More informative |

---

# Empirical Rule

For a Normal Distribution

```
Within

1σ

↓

68%
```

---

```
Within

2σ

↓

95%
```

---

```
Within

3σ

↓

99.7%
```

Very Important.

---

# Applications

Standard Deviation is used in

- Machine Learning
- Data Science
- Statistics
- Finance
- Manufacturing
- Risk Analysis
- Quality Control

---

# Common GATE PYQs

- Standard Deviation
- Variance
- Shortcut Formula
- Properties
- Effect of Scaling
- Normal Distribution Rule

---

# Quick Revision

✅ Variance

✅ Standard Deviation

✅ Population Formula

✅ Sample Formula

✅ Shortcut Formula

✅ Properties

---

# Common Mistakes

❌ Forgetting to take the square root after computing variance.

---

❌ Mixing the population formula

```
N
```

with the sample formula

```
n−1
```

---

❌ Forgetting that adding a constant does **not** change the Standard Deviation.

---

❌ Confusing variance with Standard Deviation.

---

# Memory Tricks

### Standard Deviation

```
Spread

Around

Mean
```

---

### Formula

```
Square

↓

Average

↓

Square Root
```

---

### Shortcut

```
Variance

=

E(X²)

−

Mean²
```

---

### Constant Addition

```
Shift

↓

Same Spread
```

---

### Multiplication

```
Multiply Data

↓

Multiply SD
```

---

# Formula Sheet

| Formula | Meaning |
|----------|----------|
| `Variance = Σ(x−μ)²/N` | Population Variance |
| `s² = Σ(x−x̄)²/(n−1)` | Sample Variance |
| `σ = √Variance` | Standard Deviation |
| `Variance = E(X²)−(E(X))²` | Shortcut Formula |
| `New SD = \|a\| × Old SD` | Scaling Property |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- Variance
- Standard Deviation
- Shortcut Formula
- Population vs Sample
- Effect of Scaling
- Empirical Rule

---

# Interview Corner

### Q1. Why do we square deviations while calculating variance?

Squaring prevents positive and negative deviations from canceling each other and gives greater weight to larger deviations.

---

### Q2. Why is Standard Deviation preferred over Variance?

Because Standard Deviation is expressed in the **same units as the original data**, making it easier to interpret.

---

### Q3. What happens to Standard Deviation if every observation increases by 10?

The **Mean** increases by 10, but the **Standard Deviation remains unchanged**, since the spread of the data does not change.

---

# GATE 80/20 Summary

### Must Remember

- ✅ Standard Deviation measures the **spread** of data around the mean.
- ✅ `SD = √Variance`
- ✅ Population Variance:

```
Σ(x−μ)² / N
```

- ✅ Sample Variance:

```
Σ(x−x̄)² / (n−1)
```

- ✅ Shortcut:

```
Variance

=

E(X²)

−

(E(X))²
```

- ✅ Adding a constant does **not** change SD.
- ✅ Multiplying by a constant multiplies SD by `|a|`.
- ✅ Empirical Rule:

```
68% → 1σ

95% → 2σ

99.7% → 3σ
```

---

# Next File

➡️ `34-Conditional-Probability.md`