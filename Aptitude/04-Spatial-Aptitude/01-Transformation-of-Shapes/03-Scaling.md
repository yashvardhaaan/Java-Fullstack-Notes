# Scaling

## Definition

**Scaling** is a geometric transformation that changes the **size** of a figure while maintaining its **shape**. The figure may become **larger (enlargement)** or **smaller (reduction)** depending on the **scale factor**.

Every point of the figure moves proportionally from or toward a fixed point called the **center of scaling**.

General Structure

```
Original Figure

        ↓
 Apply Scale Factor (k)

        ↓

Scaled Figure
```

Example

```
Original Square

■■
■■

Scale Factor = 2

↓↓

Larger Square
```

---

# Why Learn This?

Scaling is widely used in engineering, design, and computer science.

Applications include:

- Computer Graphics – Zooming images and objects.
- CAD Software – Creating engineering models.
- Architecture – Designing buildings using scale drawings.
- Game Development – Resizing characters and environments.
- GIS (Geographic Information Systems) – Scaling maps.
- Medical Imaging – Enlarging scans for diagnosis.

---

# Prerequisites

Before learning Scaling, you should know:

- Coordinate Geometry
- Cartesian Plane
- Translation
- Rotation

---

# Core Concepts

## Scale Factor

The **scale factor (k)** determines how much the figure changes.

```
k > 1

↓

Enlargement
```

```
0 < k < 1

↓

Reduction
```

```
k = 1

↓

No Change
```

---

## Center of Scaling

Scaling occurs relative to a fixed point.

Usually,

```
Origin

(0,0)
```

unless another center is specified.

---

## Shape Preservation

Scaling preserves

- Shape
- Angles
- Parallel Lines

Scaling changes

- Length
- Area
- Perimeter

---

## Coordinate Scaling

Original Point

```
(x, y)
```

Scaled Point

```
(kx, ky)
```

---

# Important Formulae

## Coordinate Scaling

```
(x, y)

↓

(kx, ky)
```

---

## Length

```
New Length

=

k × Original Length
```

---

## Perimeter

```
New Perimeter

=

k × Original Perimeter
```

---

## Area

```
New Area

=

k² × Original Area
```

---

## Volume (3D)

```
New Volume

=

k³ × Original Volume
```

---

# Rules / Properties

### Property 1

Scaling preserves

- Shape
- Angles
- Parallelism

---

### Property 2

Lengths change by

```
k
```

---

### Property 3

Areas change by

```
k²
```

---

### Property 4

Volumes change by

```
k³
```

---

### Property 5

When

```
k = 1
```

the figure remains unchanged.

---

# Solving Strategy

```
Identify Scale Factor
         │
         ▼
Identify Coordinates
         │
         ▼
Multiply Every Coordinate by k
         │
         ▼
Find New Coordinates
         │
         ▼
Verify Shape
```

---

# Shortcuts & Tricks

### 1. Memorize

```
Coordinates

↓

k
```

```
Lengths

↓

k
```

```
Area

↓

k²
```

```
Volume

↓

k³
```

---

### 2. If

```
k = 2
```

Coordinates double.

---

### 3. If

```
k = 1/2
```

Coordinates become half.

---

### 4. Every Vertex Uses the Same Scale Factor

---

### 5. Shape Never Changes

Only the size changes.

---

# Solved Examples

## Example 1

Point

```
(3,4)
```

Scale Factor

```
2
```

Solution

```
(6,8)
```

---

## Example 2

Point

```
(-2,5)
```

Scale Factor

```
3
```

Solution

```
(-6,15)
```

---

## Example 3

Point

```
(8,-4)
```

Scale Factor

```
1/2
```

Solution

```
(4,-2)
```

---

## Example 4

A square has side

```
5 cm
```

Scale Factor

```
3
```

New Side

```
15 cm
```

---

## Example 5

A rectangle has area

```
20 cm²
```

Scale Factor

```
2
```

New Area

```
2² × 20

=

80 cm²
```

---

# Common Mistakes

### Mistake 1

Multiplying the area by

```
k
```

instead of

```
k²
```

---

### Mistake 2

Changing the shape.

Scaling only changes size.

---

### Mistake 3

Using different scale factors for different vertices.

---

### Mistake 4

Forgetting negative coordinates.

---

### Mistake 5

Confusing enlargement with translation.

---

# Previous Year Question Pattern

Frequently tested concepts:

- Scale Factor
- Coordinate Scaling
- Enlargement
- Reduction
- Area Scaling
- Similar Figures

---

# Practice Questions (with Answers)

## Q1

Scale

```
(2,5)
```

by

```
3
```

**Answer**

```
(6,15)
```

---

## Q2

Scale

```
(-3,4)
```

by

```
2
```

**Answer**

```
(-6,8)
```

---

## Q3

Scale

```
(10,-6)
```

by

```
1/2
```

**Answer**

```
(5,-3)
```

---

## Q4

A line has length

```
12 cm
```

Scale Factor

```
2
```

New Length

**Answer**

```
24 cm
```

---

## Q5

A square has area

```
25 cm²
```

Scale Factor

```
2
```

New Area

**Answer**

```
100 cm²
```

---

## Q6

A cube has volume

```
27 cm³
```

Scale Factor

```
2
```

New Volume

**Answer**

```
216 cm³
```

---

## Q7

Does scaling preserve angles?

**Answer**

```
Yes
```

---

## Q8

Does scaling preserve shape?

**Answer**

```
Yes
```

---

## Q9

What happens when

```
k = 1
```

**Answer**

```
No Change
```

---

## Q10

A figure is reduced using

```
k = 0.5
```

The figure becomes

**Answer**

```
Half the Original Size
```

---

# Quick Revision Sheet

## Coordinate Formula

```
(x,y)

↓

(kx,ky)
```

---

## Scale Factor

| Scale Factor | Result |
|--------------|--------|
| k > 1 | Enlargement |
| 0 < k < 1 | Reduction |
| k = 1 | No Change |

---

## Scaling Effects

| Quantity | Multiplied By |
|-----------|---------------|
| Length | k |
| Perimeter | k |
| Area | k² |
| Volume | k³ |

---

## Scaling Preserves

- Shape
- Angles
- Parallel Lines

---

# GATE 80/20 Summary

✅ Scaling changes **size**, not **shape**.

✅ Coordinate Formula:

```
(x, y)

↓

(kx, ky)
```

✅ Remember:

- Length → `k`
- Perimeter → `k`
- Area → `k²`
- Volume → `k³`

✅ If `k > 1`, the figure enlarges.

✅ If `0 < k < 1`, the figure reduces.

✅ Scaling preserves **shape, angles, and parallel lines**, but changes dimensions according to the scale factor.

---

# Next File

➡️ `04-Reflection-Mirroring.md`