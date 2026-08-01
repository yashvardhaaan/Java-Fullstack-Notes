# Suffix Sum in Java

> Precompute sums from **right to left** so that range queries ending at the last element can be answered efficiently.

---

# What is Suffix Sum?

A **Suffix Sum** array stores the cumulative sum from the current index to the end of the array.

Formula

```
suffix[i] = arr[i] + arr[i+1] + ... + arr[n-1]
```

---

# Why Suffix Sum?

Without Suffix Sum

```
Need to calculate

arr[i] + arr[i+1] + ...

every time.

Time

O(n)
```

With Suffix Sum

```
Answer

O(1)
```

after preprocessing.

---

# Visualization

Array

```
Index

0  1  2  3  4

2  4  1  5  3
```

Suffix

```
15 13 9 8 3
```

Explanation

```
suffix[4] = 3

suffix[3] = 5 + 3 = 8

suffix[2] = 1 + 8 = 9

suffix[1] = 4 + 9 = 13

suffix[0] = 2 + 13 = 15
```

---

# Building Suffix Sum

## Java Code

```java
public static int[] buildSuffix(int[] arr){

    int n = arr.length;

    int[] suffix = new int[n];

    suffix[n-1] = arr[n-1];

    for(int i=n-2;i>=0;i--){

        suffix[i] = suffix[i+1] + arr[i];

    }

    return suffix;

}
```

---

# Dry Run

Array

```
2 4 1 5 3
```

```
suffix[4] = 3

suffix[3] = 8

suffix[2] = 9

suffix[1] = 13

suffix[0] = 15
```

Result

```
15 13 9 8 3
```

---

# Complexity

Building

```
Time

O(n)

Space

O(n)
```

---

# Query

Find sum from index

```
i

to

n-1
```

Simply

```java
suffix[i]
```

Example

```
2 4 1 5 3

Find

2 → End

1 + 5 + 3

Answer

9
```

```
suffix[2] = 9
```

---

# Prefix Sum vs Suffix Sum

| Prefix Sum | Suffix Sum |
|------------|------------|
| Left → Right | Right → Left |
| Sum from Start | Sum till End |
| prefix[i] | suffix[i] |

---

# Pattern 1

## Sum From Index to End

Problem

```
2 4 1 5 3

Index = 1
```

Output

```
13
```

Java

```java
int answer = suffix[1];
```

---

# Pattern 2

## Equilibrium Index

Need

```
Left Sum

==

Right Sum
```

Formula

```
Left

=

prefix[i-1]

Right

=

suffix[i+1]
```

---

# Pattern 3

## Partition Array

Observation

Need

```
Left Sum

Right Sum
```

Use

```
Prefix

+

Suffix
```

---

# Pattern 4

## Maximum Difference

Need

```
Current

vs

Remaining Sum
```

Suffix Sum helps answer remaining sum instantly.

---

# Generic Template

```java
int n = arr.length;

int[] suffix = new int[n];

suffix[n-1] = arr[n-1];

for(int i=n-2;i>=0;i--){

    suffix[i] = suffix[i+1] + arr[i];

}
```

---

# Dry Run Template

```
Array

2 4 1 5 3

↓

Build from Right

↓

3

↓

8

↓

9

↓

13

↓

15
```

---

# Common Mistakes

## Mistake 1

Loop starts from

```java
0
```

Correct

```java
n-2
```

---

## Mistake 2

Forgetting

```java
suffix[n-1]
```

must be initialized first.

---

## Mistake 3

Using

```java
suffix[i-1]
```

instead of

```java
suffix[i+1]
```

---

# Complexity

| Operation | Time |
|------------|------|
| Build Suffix | O(n) |
| Query | O(1) |

Space

```
O(n)
```

---

# Interview Tips

Use Suffix Sum when

- Sum from current index to end
- Remaining array sum
- Partition problems
- Prefix alone is not enough

Often, Prefix + Suffix together produce elegant O(n) solutions.

---

# Practice Problems

## Easy

- Find sum from index to end
- Equilibrium Index
- Left and Right Sum Difference

## Medium

- Partition Array
- Maximum Difference
- Product Except Self (idea)

## Hard

- Trapping Rain Water (conceptual use of left/right information)
- Advanced partition problems

---

# Summary

✅ Suffix Sum stores cumulative sums from **right to left**.

✅ Build in **O(n)**.

✅ Range-to-end queries become **O(1)**.

✅ Often used together with Prefix Sum for partition and balance problems.

---

# Quick Revision

```
Formula

suffix[i] = arr[i] + suffix[i+1]

Build

Right → Left

Time

O(n)

Space

O(n)

Use Cases

• Remaining Sum
• Partition Problems
• Prefix + Suffix
• Balance Index
```