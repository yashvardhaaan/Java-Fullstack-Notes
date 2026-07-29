# 3D Plots

## Definition

A **3D Plot (Three-Dimensional Plot)** is a graphical representation of data using **three variables** instead of two.

The variables are represented on:

- **X-axis** (Horizontal)
- **Y-axis** (Horizontal)
- **Z-axis** (Vertical)

A 3D plot helps visualize relationships among three variables simultaneously.

---

# Why Learn This?

3D plots are used when two-dimensional graphs cannot effectively represent complex datasets.

Applications include:

- **Software Engineering** – Visualize CPU usage, memory consumption, and network traffic together.
- **Data Science & Machine Learning** – Analyze multi-variable datasets and visualize model performance.
- **Business Analytics** – Compare sales, profit, and customer growth simultaneously.
- **Finance** – Analyze risk, return, and investment duration.
- **Healthcare** – Study relationships among age, blood pressure, and heart rate.
- **Engineering & Research** – Visualize simulations, terrain models, and scientific experiments.

---

# Prerequisites

Before learning 3D Plots, you should know:

- Cartesian Coordinate System
- 2D Plots
- Line Graphs
- Scatter Plots
- Basic Geometry
- Basic Arithmetic

---

# 3D Coordinate System

A 3D graph contains three perpendicular axes.

```
                 Z
                 ↑
                /
               /
              O────────→ X
             /
            /
           ↓
          Y
```

Each point is represented as

```
(X, Y, Z)
```

Example

```
(4, 6, 2)
```

---

# Components of a 3D Plot

```
3D Plot
│
├── Title
├── X-Axis
├── Y-Axis
├── Z-Axis
├── Scale
├── Data Points
├── Labels
├── Grid
└── Legend
```

---

# Types of 3D Plots

```
3D Plots
│
├── 3D Scatter Plot
├── Surface Plot
├── Wireframe Plot
├── Contour Plot
├── 3D Bar Chart
├── Mesh Plot
└── Volume Plot
```

---

# 1. 3D Scatter Plot

Each observation is represented by a point.

Example

```
      •
   •

        •

 •

```

Useful for:

- Pattern Recognition
- Clustering
- Outlier Detection

---

# 2. Surface Plot

Represents a continuous surface.

Example

```
      /\__
   __/    \__
__/          \__
```

Useful for:

- Terrain Modeling
- Mathematical Functions
- Heat Distribution

---

# 3. Wireframe Plot

Represents surfaces using only connecting lines.

Useful for:

- Engineering Design
- Computer Graphics
- Simulations

---

# 4. Contour Plot

Represents a 3D surface using contour (equal-value) lines on a 2D plane.

Used in:

- Weather Forecasting
- Topographic Maps
- Elevation Analysis

---

# 5. 3D Bar Chart

Each bar has:

- X Position
- Y Position
- Height (Z)

Useful for comparing values across two categories.

---

# Common Question Types

```
3D Plot Questions
│
├── Maximum Value
├── Minimum Value
├── Highest Peak
├── Lowest Point
├── Trend
├── Correlation
├── Comparison
├── Distribution
├── Clustering
└── Outlier Detection
```

---

# Important Formulae

## Average

```
Average = Sum / Number of Values
```

---

## Difference

```
Larger − Smaller
```

---

## Percentage Change

```
((New − Old) / Old) × 100
```

---

## Distance Between Two 3D Points

For points

```
(x₁,y₁,z₁)

(x₂,y₂,z₂)
```

Distance

```
√[(x₂−x₁)² + (y₂−y₁)² + (z₂−z₁)²]
```

---

# Solving Strategy

```
Read Title
      │
      ▼
Read Axes
      │
      ▼
Understand Each Variable
      │
      ▼
Check Scale
      │
      ▼
Observe Pattern
      │
      ▼
Answer Required Question
      │
      ▼
Verify Units
```

---

# Shortcuts & Tricks

### 1. Understand What Each Axis Represents

Never assume the variables without reading the axis labels.

---

### 2. Rotate the Plot Mentally

Visualize the graph from different angles to better understand relationships.

---

### 3. Focus on Relative Heights

Higher points generally indicate larger values of the Z-variable.

---

### 4. Identify Clusters

Groups of nearby points often represent similar observations.

---

### 5. Look for Outliers

Points isolated from the rest of the data may indicate unusual cases.

---

# Solved Example

A company records:

| Product | Sales ($) | Profit ($) |
|---------|----------:|-----------:|
| A | 100 | 20 |
| B | 150 | 40 |
| C | 200 | 60 |
| D | 250 | 70 |

Assume:

- X = Product Number
- Y = Sales
- Z = Profit

---

## Example 1

Which product has the highest profit?

Solution

```
Maximum Profit

=70
```

Answer

```
Product D
```

---

## Example 2

Difference between highest and lowest profit.

Solution

```
70−20

=50
```

Answer

```
50
```

---

## Example 3

Average profit.

Solution

```
20+40+60+70

=190

190/4

=47.5
```

Answer

```
47.5
```

---

# Common Mistakes

### Mistake 1

Ignoring one of the three axes.

---

### Mistake 2

Reading depth incorrectly because of perspective.

---

### Mistake 3

Confusing clusters with trends.

---

### Mistake 4

Ignoring the scale on different axes.

---

### Mistake 5

Comparing only height (Z) without considering X and Y positions.

---

# Previous Year Question Pattern

Frequently tested concepts:

- Highest & Lowest Value
- Comparison
- Trend Analysis
- Cluster Identification
- Outlier Detection
- Multi-variable Interpretation
- Surface Analysis
- 3D Bar Chart Interpretation

---

# Practice Questions

| City | Temperature (°C) | Humidity (%) |
|------|-----------------:|-------------:|
| A | 28 | 60 |
| B | 32 | 50 |
| C | 25 | 70 |
| D | 35 | 45 |

Assume:

- X = City
- Y = Temperature
- Z = Humidity

---

## Q1

Which city has the highest temperature?

**Answer**

```
City D
```

---

## Q2

Which city has the highest humidity?

**Answer**

```
City C
```

---

## Q3

Find the temperature difference between City D and City C.

**Answer**

```
35−25

=10°C
```

---

## Q4

Find the average humidity.

**Answer**

```
60+50+70+45

=225

225/4

=56.25%
```

---

## Q5

Which city has both the lowest temperature and the highest humidity?

**Answer**

```
City C
```

---

# Quick Revision Sheet

| Formula | Expression |
|----------|------------|
| Point | (X, Y, Z) |
| Average | Sum ÷ Count |
| Difference | Larger − Smaller |
| Percentage Change | ((New−Old)/Old) × 100 |
| 3D Distance | √[(x₂−x₁)²+(y₂−y₁)²+(z₂−z₁)²] |

---

# GATE 80/20 Summary

✅ A 3D plot represents **three variables** simultaneously.

✅ Always identify the **X, Y, and Z axes** before interpreting the graph.

✅ Focus on **patterns, peaks, clusters, and outliers**.

✅ Check the scale on all three axes before comparing values.

✅ Most questions involve **maximum/minimum values, comparison, trend analysis, and multi-variable interpretation**.

---

# Next File

➡️ `10-Practice-Problems.md`