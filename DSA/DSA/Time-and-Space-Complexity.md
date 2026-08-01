# ⏱️ Time and Space Complexity

> "A correct solution is good.
> An efficient solution is better."

---

# What is Time Complexity?

Time Complexity measures **how the running time of an algorithm grows** as the input size increases.

It **does not measure actual time in seconds**.

Instead, it measures the **number of operations**.

Example

```java
for(int i = 0; i < n; i++){
    System.out.println(i);
}
```

Operations

```
n
```

Time Complexity

```
O(n)
```

---

# What is Space Complexity?

Space Complexity measures **how much extra memory** an algorithm uses.

Example

```java
int[] temp = new int[n];
```

Extra memory

```
n integers
```

Space Complexity

```
O(n)
```

---

# Why Complexity Matters?

Suppose

```
n = 10
```

O(n²)

```
100 operations
```

Now

```
n = 100000
```

O(n²)

```
10,000,000,000 operations
```

Impossible within interview time limits.

---

# Big O Notation

Big O represents the **worst-case growth** of an algorithm.

Example

```
O(1)

↓

O(log n)

↓

O(n)

↓

O(n log n)

↓

O(n²)

↓

O(2ⁿ)

↓

O(n!)
```

---

# Complexity Comparison

```
Fastest

O(1)

↓

O(log n)

↓

O(n)

↓

O(n log n)

↓

O(n²)

↓

O(n³)

↓

O(2ⁿ)

↓

O(n!)

Slowest
```

---

# O(1) - Constant Time

Runtime never changes.

Example

```java
int first = arr[0];
```

Operations

```
1
```

Examples

- Array Access
- Stack Push
- Stack Pop
- HashMap Get (Average)

---

# O(log n) - Logarithmic Time

Every step removes half of the data.

Example

Binary Search

```
1024

↓

512

↓

256

↓

128

↓

64

↓

32

↓

16

↓

8

↓

4

↓

2

↓

1
```

Only 10 comparisons.

---

# O(n) - Linear Time

Visit every element once.

Example

```java
for(int num : arr){

    System.out.println(num);

}
```

Examples

- Traversal
- Linear Search
- Finding Maximum

---

# O(n log n)

Common in sorting algorithms.

Examples

- Merge Sort
- Heap Sort
- Quick Sort (Average)

Example

```
Merge Sort

↓

Divide

↓

Merge

↓

Repeat
```

---

# O(n²)

Nested loops.

Example

```java
for(int i=0;i<n;i++){

    for(int j=0;j<n;j++){

    }

}
```

Operations

```
n × n
```

Examples

- Bubble Sort
- Selection Sort
- Brute Force Pair Problems

---

# O(n³)

Three nested loops.

Example

```java
for(...){

    for(...){

        for(...){

        }

    }

}
```

Examples

- Floyd Warshall
- Matrix Multiplication (Basic)

---

# O(2ⁿ)

Every choice creates two more choices.

Example

```
Include

Exclude
```

Common in

- Backtracking
- Subsets
- Recursion

---

# O(n!)

Every permutation.

Example

```
ABC

ACB

BAC

BCA

CAB

CBA
```

Very slow.

---

# Time Complexity Examples

## Example 1

```java
for(int i=0;i<n;i++){

    System.out.println(i);

}
```

Complexity

```
O(n)
```

---

## Example 2

```java
for(int i=0;i<n;i++){

    for(int j=0;j<n;j++){

    }

}
```

Complexity

```
O(n²)
```

---

## Example 3

```java
while(n>1){

    n/=2;

}
```

Complexity

```
O(log n)
```

---

## Example 4

```java
for(int i=0;i<n;i++){

    while(x>1){

        x/=2;

    }

}
```

Complexity

```
O(n log n)
```

---

# Rules for Calculating Complexity

## Rule 1

Ignore Constants

```
O(2n)

↓

O(n)
```

---

## Rule 2

Keep Largest Term

```
O(n²+n)

↓

O(n²)
```

---

## Rule 3

Nested Loops Multiply

```
n

×

n

=

n²
```

---

## Rule 4

Separate Loops Add

```java
for(...){}

for(...){}
```

```
O(n+n)

↓

O(n)
```

---

# Space Complexity Examples

## O(1)

```java
int sum=0;
int max=0;
```

---

## O(n)

```java
int[] temp=new int[n];
```

---

## O(n²)

```java
int[][] matrix=new int[n][n];
```

---

# Recursion Space

Example

```java
factorial(5)
```

Call Stack

```
5

↓

4

↓

3

↓

2

↓

1
```

Space

```
O(n)
```

---

# Common Interview Complexities

| Algorithm | Time | Space |
|-----------|------|-------|
| Linear Search | O(n) | O(1) |
| Binary Search | O(log n) | O(1) |
| Bubble Sort | O(n²) | O(1) |
| Merge Sort | O(n log n) | O(n) |
| Quick Sort | O(n log n)* | O(log n) |
| HashMap Search | O(1)* | O(n) |
| DFS | O(V+E) | O(V) |
| BFS | O(V+E) | O(V) |

`*` = Average case.

---

# Common Mistakes

❌ Counting every statement separately.

❌ Forgetting nested loops multiply.

❌ Ignoring recursion stack space.

❌ Thinking Big-O measures seconds.

---

# Interview Tips

Whenever you finish coding, always answer:

1. What is the Time Complexity?
2. Why?
3. What is the Space Complexity?
4. Can it be optimized?

Interviewers almost always ask these questions.

---

# Complexity Cheat Sheet

| Complexity | Performance |
|------------|-------------|
| O(1) | ⭐⭐⭐⭐⭐ Excellent |
| O(log n) | ⭐⭐⭐⭐⭐ Excellent |
| O(n) | ⭐⭐⭐⭐ Good |
| O(n log n) | ⭐⭐⭐ Good |
| O(n²) | ⭐⭐ Acceptable for small n |
| O(2ⁿ) | ⭐ Poor |
| O(n!) | ❌ Avoid |

---

# Summary

✅ Time Complexity measures how runtime grows.

✅ Space Complexity measures extra memory used.

✅ Ignore constants and smaller terms.

✅ Focus on writing solutions that are:

- Correct
- Efficient
- Easy to explain

---

# Quick Revision

```
Array Access        → O(1)

Binary Search       → O(log n)

Traversal           → O(n)

Merge Sort          → O(n log n)

Nested Loops        → O(n²)

Backtracking        → O(2ⁿ)

Permutations        → O(n!)
```