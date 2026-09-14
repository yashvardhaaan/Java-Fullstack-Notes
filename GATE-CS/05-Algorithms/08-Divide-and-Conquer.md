# 07 — Divide and Conquer

# 1. THEORY

## 1.1 What is Divide and Conquer?

**Divide and Conquer** is an algorithmic paradigm where a problem is solved in three stages:

```text
Problem
   ↓
DIVIDE
   ↓
Solve smaller subproblems
   ↓
CONQUER
   ↓
COMBINE their solutions
```

### Three steps

### 1. Divide

Break the problem into smaller subproblems.

### 2. Conquer

Solve the subproblems recursively.

### 3. Combine

Combine the solutions to obtain the final answer.

---

# 2. GENERAL STRUCTURE ⭐⭐⭐⭐⭐

```text
DivideAndConquer(problem):

    if problem is small:
        solve directly

    divide problem into subproblems

    solve each subproblem recursively

    combine their solutions
```

The base case prevents infinite recursion.

---

# 3. COMMON DIVIDE-AND-CONQUER ALGORITHMS ⭐⭐⭐⭐⭐

| Algorithm                      | Divide                 | Typical Complexity |
| ------------------------------ | ---------------------- | -----------------: |
| Binary Search                  | Array into 2 halves    |           O(log n) |
| Merge Sort                     | Array into 2 halves    |         O(n log n) |
| Quick Sort                     | Partition around pivot | Average O(n log n) |
| Strassen Matrix Multiplication | Matrices               |          O(n^2.81) |
| Closest Pair of Points         | Points into halves     |         O(n log n) |

---

# 4. BINARY SEARCH ⭐⭐⭐⭐⭐

Binary Search is a classic divide-and-conquer algorithm.

Given:

```text
[10,20,30,40,50,60,70]
```

Search for `60`.

Divide:

```text
[10,20,30] [40] [50,60,70]
```

Since:

$$
60>40
$$

discard the left half.

Continue with:

```text
[50,60,70]
```

---

## Recurrence

$$
T(n)=T(n/2)+O(1)
$$

Therefore:

$$
\boxed{T(n)=O(\log n)}
$$

---

# 5. MERGE SORT ⭐⭐⭐⭐⭐

Merge Sort divides the array into two equal halves.

Example:

```text
[8,3,2,9,7,1,5,4]
```

Divide:

```text
[8,3,2,9] [7,1,5,4]
```

Again:

```text
[8,3] [2,9] [7,1] [5,4]
```

Continue until individual elements remain.

Then merge sorted subarrays.

---

# 6. MERGE SORT RECURRENCE

There are:

```text
2 subproblems
```

Each of size:

$$
n/2
$$

Merging requires:

$$
O(n)
$$

Therefore:

$$
\boxed{T(n)=2T(n/2)+O(n)}
$$

By Master Theorem:

$$
\boxed{T(n)=O(n\log n)}
$$

---

# 7. MERGE SORT COMPLEXITY

| Case    |       Time |
| ------- | ---------: |
| Best    | O(n log n) |
| Average | O(n log n) |
| Worst   | O(n log n) |

Standard implementation:

$$
\boxed{\text{Auxiliary Space}=O(n)}
$$

### Properties

```text
Stable       → Yes
Worst time   → O(n log n)
Predictable  → Yes
```

---

# 8. QUICK SORT ⭐⭐⭐⭐⭐

Quick Sort follows:

```text
Choose Pivot
     ↓
Partition
     ↓
Recursively sort left
     ↓
Recursively sort right
```

Example:

```text
[8,3,2,9,7,1,5,4]
```

Choose:

```text
pivot = 4
```

Partition:

```text
[3,2,1] 4 [8,9,7,5]
```

Then recursively sort both sides.

---

# 9. QUICK SORT — IMPORTANT DIFFERENCE

Merge Sort:

```text
Divide first
↓
Then combine
```

Quick Sort:

```text
Partition first
↓
Subarrays are recursively sorted
↓
Little/no explicit combine required
```

### GATE Trick 🔥

> **Merge Sort does the major work during COMBINE.**

> **Quick Sort does the major work during DIVIDE/PARTITION.**

---

# 10. QUICK SORT RECURRENCE

If pivot divides approximately equally:

$$
T(n)=2T(n/2)+O(n)
$$

Therefore:

$$
\boxed{O(n\log n)}
$$

---

# 11. QUICK SORT WORST CASE

If pivot is always the smallest or largest element:

```text
n
↓
n-1
↓
n-2
↓
...
```

Recurrence:

$$
T(n)=T(n-1)+O(n)
$$

Therefore:

$$
\boxed{O(n^2)}
$$

---

# 12. QUICK SORT SPACE ⭐⭐⭐⭐

Average/balanced recursion:

$$
\boxed{O(\log n)}
$$

Worst case:

$$
\boxed{O(n)}
$$

due to recursion stack.

---

# 13. DIVIDE-AND-CONQUER RECURRENCE ⭐⭐⭐⭐⭐

The general recurrence is:

$$
\boxed{T(n)=aT(n/b)+f(n)}
$$

where:

* `a` = number of subproblems
* `n/b` = size of each subproblem
* `f(n)` = divide + combine work

Example:

$$
T(n)=2T(n/2)+n
$$

means:

```text
2 subproblems
↓
each size n/2
↓
n additional work
```

---

# 14. RECURSION TREE ⭐⭐⭐⭐⭐

Consider:

$$
T(n)=2T(n/2)+n
$$

### Level 0

One problem:

$$
n
$$

### Level 1

Two problems:

$$
n/2+n/2=n
$$

### Level 2

Four problems:

$$
4(n/4)=n
$$

Every level costs:

$$
n
$$

Number of levels:

$$
\log_2 n
$$

Therefore:

$$
n\log n
$$

Hence:

$$
\boxed{T(n)=O(n\log n)}
$$

---

# 15. RECURSION TREE — GATE SHORTCUT 🧠

If each level costs:

$$
n
$$

and there are:

$$
\log n
$$

levels:

$$
\boxed{O(n\log n)}
$$

---

# 16. MASTER THEOREM ⭐⭐⭐⭐⭐

For:

$$
T(n)=aT(n/b)+f(n)
$$

calculate:

$$
\boxed{n^{\log_ba}}
$$

Then compare it with:

$$
f(n)
$$

---

# 17. MASTER THEOREM CASE 1

If:

$$
f(n)<n^{\log_ba}
$$

by a polynomial factor:

$$
\boxed{T(n)=\Theta(n^{\log_ba})}
$$

### Example

$$
T(n)=4T(n/2)+n
$$

Here:

$$
\log_24=2
$$

Therefore:

$$
n^{\log_24}=n^2
$$

Since:

$$
n<n^2
$$

Answer:

$$
\boxed{\Theta(n^2)}
$$

---

# 18. MASTER THEOREM CASE 2

If:

$$
f(n)=\Theta(n^{\log_ba})
$$

then:

$$
\boxed{T(n)=\Theta(n^{\log_ba}\log n)}
$$

Example:

$$
T(n)=2T(n/2)+n
$$

Since:

$$
n^{\log_22}=n
$$

and:

$$
f(n)=n
$$

therefore:

$$
\boxed{T(n)=\Theta(n\log n)}
$$

---

# 19. MASTER THEOREM CASE 3

If:

$$
f(n)>n^{\log_ba}
$$

by a polynomial factor and regularity conditions hold:

$$
\boxed{T(n)=\Theta(f(n))}
$$

Example:

$$
T(n)=2T(n/2)+n^2
$$

Here:

$$
n^{\log_22}=n
$$

and:

$$
n^2>n
$$

Therefore:

$$
\boxed{T(n)=\Theta(n^2)}
$$

---

# 20. MASTER THEOREM QUICK TABLE ⭐⭐⭐⭐⭐

| Recurrence        |      Answer |
| ----------------- | ----------: |
| `T(n)=T(n/2)+1`   |    Θ(log n) |
| `T(n)=2T(n/2)+1`  |        Θ(n) |
| `T(n)=2T(n/2)+n`  |  Θ(n log n) |
| `T(n)=2T(n/2)+n²` |       Θ(n²) |
| `T(n)=4T(n/2)+n`  |       Θ(n²) |
| `T(n)=4T(n/2)+n²` | Θ(n² log n) |
| `T(n)=3T(n/2)+n`  |  Θ(n^log₂3) |

---

# 21. STRASSEN'S MATRIX MULTIPLICATION ⭐⭐⭐

Traditional matrix multiplication requires:

$$
\boxed{O(n^3)}
$$

for two `n × n` matrices.

Strassen reduces the number of recursive multiplications.

Its recurrence is approximately:

$$
T(n)=7T(n/2)+O(n^2)
$$

Therefore:

$$
T(n)=O(n^{\log_27})
$$

Since:

$$
\log_27\approx2.807
$$

we get:

$$
\boxed{O(n^{2.807})}
$$

### GATE Point

Traditional:

$$
O(n^3)
$$

Strassen:

$$
O(n^{2.807})
$$

---

# 22. DIVIDE AND CONQUER vs GREEDY ⭐⭐⭐⭐⭐

| Divide & Conquer    | Greedy                      |
| ------------------- | --------------------------- |
| Divides problem     | Makes local choices         |
| Usually recursive   | Often iterative             |
| Solves subproblems  | Builds solution stepwise    |
| Combines solutions  | Usually no major combine    |
| Example: Merge Sort | Example: Activity Selection |

---

# 23. DIVIDE AND CONQUER vs DP ⭐⭐⭐⭐⭐

| Divide & Conquer              | Dynamic Programming       |
| ----------------------------- | ------------------------- |
| Subproblems often independent | Subproblems often overlap |
| May recompute subproblems     | Stores results            |
| Recursion common              | Memoization/tabulation    |
| Merge Sort                    | Fibonacci DP              |

### Important

If subproblems **overlap heavily**, plain divide-and-conquer may repeat work.

Dynamic Programming can avoid this repetition.

---

# 24. OVERLAPPING SUBPROBLEMS

Naive Fibonacci:

$$
F(n)=F(n-1)+F(n-2)
$$

creates repeated calculations:

```text
F(5)
├── F(4)
│   ├── F(3)
│   └── F(2)
└── F(3)
    ├── F(2)
    └── F(1)
```

`F(3)` and `F(2)` are calculated repeatedly.

Naive recursive Fibonacci:

$$
\boxed{O(2^n)}
$$

DP/memoization:

$$
\boxed{O(n)}
$$

### GATE Trick 🔥

```text
Overlapping subproblems
        ↓
Think DP
```

---

# 25. DIVIDE-AND-CONQUER TRICKS 🧠

## Trick 1

```text
Binary Search
→ 1 subproblem of n/2
→ O(log n)
```

---

## Trick 2

```text
Merge Sort
→ 2 subproblems of n/2
→ O(n) merge
→ O(n log n)
```

---

## Trick 3

```text
Quick Sort
→ Partition O(n)
→ Balanced → O(n log n)
→ Worst → O(n²)
```

---

## Trick 4 ⭐

For:

$$
T(n)=aT(n/b)+f(n)
$$

immediately calculate:

$$
\boxed{p=\log_ba}
$$

Then compare:

$$
f(n)\quad\text{vs}\quad n^p
$$

---

# 26. PYQ-STYLE QUESTION 1

Solve:

$$
T(n)=T(n/2)+1
$$

### Solution

Here:

$$
a=1,\quad b=2
$$

$$
n^{\log_21}=1
$$

And:

$$
f(n)=1
$$

Same order.

Therefore:

$$
\boxed{T(n)=\Theta(\log n)}
$$

---

# 27. PYQ-STYLE QUESTION 2 ⭐

Solve:

$$
T(n)=2T(n/2)+n
$$

### Solution

$$
a=2,\quad b=2
$$

$$
n^{\log_22}=n
$$

And:

$$
f(n)=n
$$

Same order.

Therefore:

$$
\boxed{\Theta(n\log n)}
$$

---

# 28. PYQ-STYLE QUESTION 3

Solve:

$$
T(n)=4T(n/2)+n
$$

### Solution

$$
\log_24=2
$$

Therefore:

$$
n^{\log_24}=n^2
$$

Compare:

```text
f(n) = n
critical term = n²
```

`n` is polynomially smaller.

Therefore:

$$
\boxed{\Theta(n^2)}
$$

---

# 29. PYQ-STYLE QUESTION 4

Solve:

$$
T(n)=2T(n/2)+n^2
$$

### Solution

Critical term:

$$
n^{\log_22}=n
$$

But:

$$
f(n)=n^2
$$

is polynomially larger.

Therefore:

$$
\boxed{\Theta(n^2)}
$$

---

# 30. PYQ-STYLE QUESTION 5 ⭐⭐⭐⭐⭐

Consider:

```text
f(n)
{
    if(n <= 1)
        return;

    f(n/2);
    f(n/2);

    for(i=1; i<=n; i++)
        work();
}
```

Find the time complexity.

### Recurrence

$$
T(n)=2T(n/2)+n
$$

Therefore:

$$
\boxed{O(n\log n)}
$$

---

# 31. PYQ-STYLE QUESTION 6

Consider:

```text
f(n)
{
    if(n <= 1)
        return;

    f(n/2);

    for(i=1; i<=n; i++)
        work();
}
```

### Recurrence

$$
T(n)=T(n/2)+n
$$

Expand:

$$
n+\frac n2+\frac n4+\cdots
$$

This is a geometric series:

$$
<2n
$$

Therefore:

$$
\boxed{O(n)}
$$

### 🔥 GATE Trap

One recursive call does **not automatically mean** `O(log n)`.

The additional work at each level matters.

---

# 32. PYQ-STYLE QUESTION 7 — Quick Sort

Quick Sort produces partitions of sizes:

$$
n/2,\ n/2
$$

at every level.

What is its complexity?

### Solution

$$
T(n)=2T(n/2)+n
$$

Therefore:

$$
\boxed{O(n\log n)}
$$

---

# 33. PYQ-STYLE QUESTION 8 — Quick Sort Worst Case

Partitions are:

$$
0,\ n-1
$$

at every step.

### Recurrence

$$
T(n)=T(n-1)+n
$$

Therefore:

$$
\boxed{O(n^2)}
$$

---

# 34. PYQ-STYLE QUESTION 9 — Strassen

Strassen's algorithm satisfies:

$$
T(n)=7T(n/2)+O(n^2)
$$

What is the complexity?

### Solution

$$
a=7,\quad b=2
$$

Therefore:

$$
T(n)=O(n^{\log_27})
$$

$$
\boxed{O(n^{2.807})}
$$

---

# 35. PYQ-STYLE QUESTION 10 — Fibonacci

Naive recursive Fibonacci:

$$
F(n)=F(n-1)+F(n-2)
$$

has exponential time.

Why?

### Explanation

The same subproblems are solved repeatedly.

Example:

```text
F(5)
├── F(4)
│   ├── F(3)
│   └── F(2)
└── F(3)
```

`F(3)` is repeated.

Therefore naive recursion is exponential:

$$
\boxed{O(2^n)}
$$

Memoization reduces it to:

$$
\boxed{O(n)}
$$

---

# 36. 🔥 GATE FINAL CHEAT SHEET

### Divide and Conquer

$$
\boxed{\text{Divide → Conquer → Combine}}
$$

### Binary Search

$$
\boxed{T(n)=T(n/2)+1=O(\log n)}
$$

### Merge Sort

$$
\boxed{T(n)=2T(n/2)+n=O(n\log n)}
$$

### Quick Sort

Balanced:

$$
\boxed{O(n\log n)}
$$

Worst:

$$
\boxed{O(n^2)}
$$

### Strassen

$$
\boxed{O(n^{\log_27})\approx O(n^{2.807})}
$$

### Master Theorem

$$
\boxed{T(n)=aT(n/b)+f(n)}
$$

Calculate:

$$
\boxed{n^{\log_ba}}
$$

then compare with `f(n)`.

---

# 37. 🧠 ONE-MINUTE REVISION

```text
1 subproblem, n/2
→ Binary Search
→ O(log n)
```

```text
2 subproblems, n/2 + O(n)
→ Merge Sort
→ O(n log n)
```

```text
Balanced Quick Sort
→ O(n log n)
```

```text
Worst Quick Sort
→ O(n²)
```

```text
Overlapping subproblems
→ DP
```

```text
7 subproblems of n/2
→ Strassen
→ O(n^2.807)
```

```text
Same work n at every log n level
→ O(n log n)
```

```text
n + n/2 + n/4 + ...
→ O(n)
```

### 🎯 GATE Priority

**Must master:**

1. Recurrence formation
2. Recursion tree
3. Master Theorem
4. Binary Search
5. Merge Sort
6. Quick Sort
7. Best/worst partition
8. Strassen
9. Divide & Conquer vs DP
10. Identifying overlapping subproblems

**Next: `08-Dynamic-Programming.md` — optimal substructure, overlapping subproblems, memoization vs tabulation, 0/1 Knapsack, LCS, Matrix Chain Multiplication, LIS, Fibonacci, DP tricks + GATE PYQs.**
