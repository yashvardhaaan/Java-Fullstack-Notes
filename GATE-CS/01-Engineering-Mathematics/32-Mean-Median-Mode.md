# Mean, Median, Mode

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# Why Do We Need Mean, Median and Mode?

Suppose a teacher wants to summarize marks of a class.

Instead of looking at every student's marks,

we use a single value that represents the entire dataset.

These measures are called

```
Measures of Central Tendency
```

They tell us where the data is "centered."

---

# Intuition

Consider the marks

```
20

25

30

35

40
```

Instead of remembering all five numbers,

we can summarize them using

```
Mean

Median

Mode
```

---

# Measures of Central Tendency

```
Central Tendency
│
├── Mean
├── Median
└── Mode
```

---

# Mean

The **Mean** is the arithmetic average.

Formula

```
          Σx

Mean = --------

           n
```

where

```
Σx

↓

Sum of Observations
```

```
n

↓

Number of Observations
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
(2+4+6+8+10)

--------------

5

=

6
```

---

# Weighted Mean

Sometimes different observations have different importance.

Formula

```
          Σ(wx)

Weighted Mean = -----------

               Σw
```

where

```
w

↓

Weight
```

---

### Example

Marks

```
80

90

70
```

Weights

```
2

3

1
```

Weighted Mean

```
(80×2)+(90×3)+(70×1)

--------------------

2+3+1

=

500/6

≈83.33
```

---

# Properties of Mean

- Uses all observations.
- Easy to calculate.
- Affected by extreme values.
- Unique value.

---

# Median

The **Median** is the middle value after arranging data in ascending order.

---

### Steps

```
Arrange Data

↓

Find Middle
```

---

# Example (Odd Number of Observations)

Data

```
5

8

10

12

15
```

Median

```
10
```

---

# Example (Even Number of Observations)

Data

```
2

4

6

8
```

Median

```
(4+6)/2

=

5
```

---

# Properties of Median

- Not affected by outliers.
- Divides data into two equal halves.
- Useful for skewed data.

---

# Mode

The **Mode** is the most frequently occurring value.

---

# Example

Data

```
2

4

4

5

7

7

7

9
```

Mode

```
7
```

because it appears most often.

---

# Types of Mode

### Unimodal

One mode.

Example

```
1

2

2

3
```

---

### Bimodal

Two modes.

Example

```
2

2

5

5

7
```

---

### Multimodal

More than two modes.

---

### No Mode

Every value appears exactly once.

---

# Comparison

| Mean | Median | Mode |
|------|--------|------|
| Average | Middle | Most Frequent |
| Uses all values | Middle value | Highest frequency |
| Affected by outliers | Resistant | Resistant |

---

# Outliers

Outliers are unusually large or small observations.

Example

```
10

11

12

13

100
```

Mean

```
29.2
```

Median

```
12
```

Notice

```
Mean

Affected

Median

Not Affected
```

---

# Empirical Relationship

For moderately skewed distributions

```
Mode

≈

3(Median)

-

2(Mean)
```

or

```
Mean

-

Mode

=

3(Mean-Median)
```

Frequently asked in competitive exams.

---

# Symmetric Distribution

```
          ▲

       ▲▲▲▲▲

    ▲▲▲▲▲▲▲▲▲

-------------------->
```

For symmetric distributions

```
Mean

=

Median

=

Mode
```

---

# Right Skewed Distribution

```
▲▲▲▲▲▲▲

      ▲▲

        ▲

          ▲
```

Relationship

```
Mode

<

Median

<

Mean
```

---

# Left Skewed Distribution

```
      ▲

    ▲▲

▲▲▲▲▲▲▲
```

Relationship

```
Mean

<

Median

<

Mode
```

---

# Applications

Used in

- Data Science
- Machine Learning
- Business Analytics
- Statistics
- Economics
- Survey Analysis

---

# Common GATE PYQs

- Mean Calculation
- Median
- Mode
- Weighted Mean
- Mean vs Median
- Empirical Formula

---

# Quick Revision

✅ Mean

✅ Median

✅ Mode

✅ Weighted Mean

✅ Outliers

✅ Empirical Relationship

---

# Common Mistakes

❌ Forgetting to sort data before finding the median.

---

❌ Dividing by the wrong number while calculating the mean.

---

❌ Confusing the most frequent value with the largest value.

---

❌ Using the empirical relationship for every dataset (it is only an approximation for moderately skewed distributions).

---

# Memory Tricks

### Mean

```
Add

↓

Divide
```

---

### Median

```
Arrange

↓

Middle
```

---

### Mode

```
Maximum

Frequency
```

---

### Outliers

```
Mean

Changes

Median

Usually Doesn't
```

---

# Formula Sheet

| Formula | Meaning |
|----------|----------|
| `Mean = Σx/n` | Arithmetic Mean |
| `Weighted Mean = Σ(wx)/Σw` | Weighted Average |
| `Median` | Middle Value |
| `Mode` | Most Frequent Value |
| `Mode ≈ 3(Median)-2(Mean)` | Empirical Relation |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- Mean
- Median
- Mode
- Weighted Mean
- Outlier Effect
- Empirical Relation

---

# Interview Corner

### Q1. When should you use the median instead of the mean?

Use the **median** when the dataset contains **outliers** or is **skewed**, because it is less affected by extreme values.

---

### Q2. Can a dataset have more than one mode?

✅ Yes.

A dataset can be:

- **Unimodal** (one mode)
- **Bimodal** (two modes)
- **Multimodal** (more than two modes)

---

### Q3. In a perfectly symmetric distribution, what is the relationship between mean, median, and mode?

They are all equal.

```
Mean

=

Median

=

Mode
```

---

# GATE 80/20 Summary

### Must Remember

- ✅ Mean = `Σx/n`
- ✅ Weighted Mean = `Σ(wx)/Σw`
- ✅ Median = Middle value after sorting
- ✅ Mode = Most frequent value
- ✅ Mean is affected by outliers.
- ✅ Median is resistant to outliers.
- ✅ In a symmetric distribution:

```
Mean

=

Median

=

Mode
```

- ✅ Empirical Relation:

```
Mode

≈

3(Median)

-

2(Mean)
```

---

# Next File

➡️ `33-Standard-Deviation.md`