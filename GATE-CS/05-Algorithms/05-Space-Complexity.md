# 05 — Space Complexity

# 1. THEORY

## 1.1 What is Space Complexity?

**Space complexity** measures how much memory an algorithm requires as a function of input size `n`.

It is important to distinguish:

* **Total space**
* **Auxiliary space**

### Total Space

Memory required by:

$$
\boxed{\text{Input Space}+\text{Auxiliary Space}}
$$

### Auxiliary Space

Extra memory required by the algorithm **excluding the input itself**.

$$
\boxed{\text{Auxiliary Space}=\text{Extra Space Used}}
$$

### GATE Trick ⭐⭐⭐⭐⭐

If an algorithm uses an input array of size `n` and an additional array of size `n`:

```text id="8p7s1h"
Input array      → O(n)
Extra array      → O(n)
```

Total space:

$$
O(n)
$$

Auxiliary space:

$$
\boxed{O(n)}
$$

The input array is not counted as auxiliary space.

---

# 2. CONSTANT SPACE — O(1)

Example:

```text id="h3j7k5"
int sum = 0;
int i = 0;
int temp;
```

Only a fixed number of variables are used.

Therefore:

$$
\boxed{O(1)}
$$

Even if `n` becomes very large, the number of variables remains constant.

---

# 3. LINEAR SPACE — O(n)

Example:

```text id="9j3f4k"
int B[n];
```

An additional array of size `n` is created.

Therefore:

$$
\boxed{O(n)}
$$

---

# 4. TWO-DIMENSIONAL SPACE — O(n²)

Example:

```text id="m7y4e1"
int A[n][n];
```

Number of elements:

$$
n\times n=n^2
$$

Therefore:

$$
\boxed{O(n^2)}
$$

---

# 5. RECURSION STACK ⭐⭐⭐⭐⭐

Every recursive function uses **stack memory**.

Example:

```text id="2v8q1a"
f(n):
    if n == 0:
        return
    f(n-1)
```

Call stack:

```text id="y9k2s7"
f(n)
f(n-1)
f(n-2)
f(n-3)
...
f(0)
```

Maximum depth:

$$
n
$$

Therefore auxiliary space:

$$
\boxed{O(n)}
$$

---

# 6. BINARY RECURSION

Consider:

```text id="8k1m6p"
f(n):
    if n <= 1:
        return
    f(n/2)
    f(n/2)
```

The recursion depth is:

$$
n\rightarrow n/2\rightarrow n/4\rightarrow\cdots
$$

Therefore:

$$
\boxed{O(\log n)}
$$

space due to recursion depth.

### Important GATE Point

Even though there are **two recursive calls**, they don't necessarily require `O(n)` simultaneous stack space.

The calls execute sequentially, so maximum stack depth is:

$$
\boxed{O(\log n)}
$$

---

# 7. TIME vs SPACE ⭐⭐⭐⭐⭐

Consider:

```text id="1h2g7m"
f(n):
    if n <= 1:
        return
    f(n/2)
    f(n/2)
```

### Time

There are two subproblems:

$$
T(n)=2T(n/2)+O(1)
$$

Therefore:

$$
\boxed{O(n)}
$$

### Space

Maximum recursion depth:

$$
\boxed{O(\log n)}
$$

So:

```text id="a0q7x3"
Time  → O(n)
Space → O(log n)
```

### GATE Trap 🔥

Do not assume:

> Number of recursive calls = space complexity.

Space depends on the **maximum number of simultaneously active calls**.

---

# 8. ITERATIVE vs RECURSIVE

Example: Binary Search.

### Iterative

```text id="4p2j1k"
while(low <= high)
    ...
```

Auxiliary space:

$$
\boxed{O(1)}
$$

### Recursive

```text id="g8z5n4"
binarySearch(...)
```

Maximum recursion depth:

$$
\boxed{O(\log n)}
$$

Therefore:

| Version                 |    Space |
| ----------------------- | -------: |
| Iterative Binary Search |     O(1) |
| Recursive Binary Search | O(log n) |

---

# 9. IN-PLACE ALGORITHM ⭐⭐⭐⭐⭐

An algorithm is generally considered **in-place** if it uses only constant extra memory, usually:

$$
\boxed{O(1)}
$$

Examples:

* Selection Sort
* Insertion Sort
* Heap Sort
* Bubble Sort

### Common non-in-place example

Standard Merge Sort:

$$
\boxed{O(n)}
$$

auxiliary array.

---

# 10. QUICK SORT SPACE ⭐⭐⭐⭐⭐

Quick Sort is particularly important.

### Balanced partitions

Recursion depth:

$$
O(\log n)
$$

Therefore:

$$
\boxed{O(\log n)}
$$

stack space.

### Worst-case partition

If pivot always produces:

```text id="q6s9a1"
0 elements | pivot | n-1 elements
```

then recursion depth becomes:

$$
O(n)
$$

Therefore:

$$
\boxed{O(n)}
$$

stack space in the worst case.

### GATE Trick

Quick Sort is often described as:

$$
\boxed{O(\log n)\text{ average auxiliary stack space}}
$$

but:

$$
\boxed{O(n)\text{ worst-case stack space}}
$$

---

# 11. MERGE SORT SPACE ⭐⭐⭐⭐

Standard Merge Sort:

```text id="j5n8r2"
Input array → n
Temporary array → n
```

Auxiliary space:

$$
\boxed{O(n)}
$$

The recursion stack is `O(log n)`, but:

$$
O(n)+O(\log n)=O(n)
$$

Therefore total auxiliary space remains:

$$
\boxed{O(n)}
$$

---

# 12. HEAP SORT SPACE

Heap Sort performs operations directly in the input array.

Auxiliary space:

$$
\boxed{O(1)}
$$

assuming an iterative/in-place implementation.

Therefore:

```text id="g2k7s9"
Heap Sort
Time  → O(n log n)
Space → O(1)
```

---

# 13. STACK SPACE ⭐⭐⭐⭐⭐

Suppose:

```text id="p6v1s4"
f(n):
    if n == 0:
        return
    f(n-1)
```

There are `n+1` active calls at maximum.

Therefore:

$$
\boxed{O(n)}
$$

---

# 14. TAIL RECURSION

Example:

```text id="r5m8q2"
f(n):
    if n == 0:
        return
    f(n-1)
```

The recursive call is the final operation.

This is **tail recursion**.

In some languages/compilers, tail-call optimization can reduce stack usage.

### GATE Caution

Do not automatically assume tail recursion uses `O(1)` space.

Unless the question explicitly assumes **tail-call optimization**, recursion stack is generally counted.

---

# 15. SPACE USED BY VARIABLES

Suppose:

```text id="q2w8k4"
int a,b,c;
```

Number of variables is constant.

Therefore:

$$
\boxed{O(1)}
$$

If:

```text id="s8m1v5"
int A[n];
```

then:

$$
\boxed{O(n)}
$$

If:

```text id="h4j7p3"
int A[n][n];
```

then:

$$
\boxed{O(n^2)}
$$

---

# 16. SPACE COMPLEXITY OF COMMON DATA STRUCTURES

| Data Structure           | Typical Space |
| ------------------------ | ------------: |
| Array of n elements      |          O(n) |
| Linked List              |          O(n) |
| Stack of n elements      |          O(n) |
| Queue of n elements      |          O(n) |
| Binary Tree with n nodes |          O(n) |
| Hash Table               |          O(n) |
| Graph adjacency matrix   |         O(V²) |
| Graph adjacency list     |        O(V+E) |

---

# 17. GRAPH SPACE ⭐⭐⭐⭐⭐

## Adjacency Matrix

For `V` vertices:

```text id="4h7k2p"
V × V
```

Therefore:

$$
\boxed{O(V^2)}
$$

---

## Adjacency List

For:

* `V` vertices
* `E` edges

Space:

$$
\boxed{O(V+E)}
$$

For an undirected graph, each edge is stored twice, but asymptotically:

$$
O(V+E)
$$

---

# 18. BFS SPACE ⭐⭐⭐⭐⭐

BFS requires:

* Queue
* Visited array

For a graph with `V` vertices:

$$
\boxed{O(V)}
$$

additional space.

The adjacency-list representation itself requires:

$$
O(V+E)
$$

but when discussing **BFS auxiliary space**, the queue and visited information are typically:

$$
\boxed{O(V)}
$$

---

# 19. DFS SPACE ⭐⭐⭐⭐⭐

DFS uses:

* Visited array
* Recursion stack or explicit stack

Maximum recursion depth can be:

$$
O(V)
$$

Therefore auxiliary space:

$$
\boxed{O(V)}
$$

for the traversal bookkeeping/stack.

---

# 20. DYNAMIC PROGRAMMING SPACE ⭐⭐⭐⭐⭐

Consider:

```text id="3n8x5m"
dp[n]
```

Space:

$$
\boxed{O(n)}
$$

If:

```text id="j7k2w6"
dp[n][n]
```

then:

$$
\boxed{O(n^2)}
$$

### GATE Trick

Sometimes DP space can be optimized.

Example:

```text id="f4x9c2"
dp[i] depends only on dp[i-1]
```

Instead of storing all `n` states:

```text id="d8q1v7"
previous
current
```

Space can become:

$$
\boxed{O(1)}
$$

---

# 21. SPACE OPTIMIZATION

Suppose:

$$
dp[i]=dp[i-1]+a[i]
$$

Naive:

```text id="c3m7k1"
dp[n]
```

Space:

$$
O(n)
$$

But only the previous value is required:

```text id="a9r4t8"
previous
current
```

Space:

$$
\boxed{O(1)}
$$

### GATE Concept

Ask:

> Does the algorithm need all previous states, or only a small window of previous states?

---

# 22. RECURSION TREE vs STACK ⭐⭐⭐⭐⭐

Consider:

```text id="x5k8r3"
f(n):
    f(n-1)
    f(n-1)
```

The **number of calls** can be exponential.

Time:

$$
O(2^n)
$$

But the maximum active stack depth is only:

$$
O(n)
$$

because after one recursive branch returns, the other branch is executed.

Therefore:

$$
\boxed{\text{Time can be exponential while space is linear}}
$$

This is a very important GATE concept.

---

# 23. GATE TRICKS 🧠🔥

## Trick 1

```text id="g6h2q9"
Time complexity ≠ Space complexity
```

An algorithm can have:

```text id="6x7k1m"
Time  → O(n²)
Space → O(1)
```

Example: Selection Sort.

---

## Trick 2

Recursive algorithm:

> Count **maximum simultaneous active calls**, not total calls.

---

## Trick 3

```text id="v4m9s2"
n recursive depth → O(n) space
log n recursive depth → O(log n) space
```

---

## Trick 4

Standard Merge Sort:

```text id="j1p6k8"
Time  → O(n log n)
Space → O(n)
```

---

## Trick 5

Heap Sort:

```text id="w8r3f5"
Time  → O(n log n)
Space → O(1)
```

---

## Trick 6

Quick Sort:

```text id="r2x7m4"
Average space → O(log n)
Worst space   → O(n)
```

---

# 24. PYQ-STYLE QUESTION 1

An algorithm uses an array of size `n` and three integer variables.

What is its **auxiliary space**?

### Solution

Input array:

```text id="7j3k9q"
O(n)
```

Three variables:

```text id="z4p8m2"
O(1)
```

Auxiliary space excludes the input.

Therefore:

$$
\boxed{O(1)}
$$

---

# 25. PYQ-STYLE QUESTION 2

Consider:

```text id="s5n1k7"
f(n)
{
    if(n <= 1)
        return;

    f(n-1);
}
```

What is the auxiliary space?

### Solution

Call stack:

```text id="a8r2c6"
f(n)
f(n-1)
f(n-2)
...
f(1)
```

Depth:

$$
n
$$

Therefore:

$$
\boxed{O(n)}
$$

---

# 26. PYQ-STYLE QUESTION 3 ⭐

Consider:

```text id="m7q3x9"
f(n)
{
    if(n <= 1)
        return;

    f(n/2);
    f(n/2);
}
```

What is the auxiliary space?

### Solution

Depth:

$$
n\rightarrow n/2\rightarrow n/4\rightarrow\cdots\rightarrow1
$$

Therefore:

$$
\log_2 n
$$

stack frames.

Hence:

$$
\boxed{O(\log n)}
$$

### Important

Time is:

$$
O(n)
$$

but space is:

$$
O(\log n)
$$

---

# 27. PYQ-STYLE QUESTION 4

What is the auxiliary space of standard Merge Sort?

### Answer

$$
\boxed{O(n)}
$$

### Explanation

The temporary merge array requires `O(n)` memory.

Although recursion requires `O(log n)` stack space:

$$
O(n)+O(\log n)=O(n)
$$

---

# 28. PYQ-STYLE QUESTION 5

What is the worst-case auxiliary space of recursive Quick Sort?

### Answer

$$
\boxed{O(n)}
$$

### Explanation

Worst partition:

```text id="e3q8v1"
0 + (n-1)
0 + (n-2)
...
```

Recursion depth:

$$
n
$$

Therefore:

$$
\boxed{O(n)}
$$

---

# 29. PYQ-STYLE QUESTION 6

An algorithm has:

```text id="w4j9s2"
Time complexity = O(2ⁿ)
```

Can its space complexity be `O(n)`?

### Answer

$$
\boxed{\text{Yes}}
$$

Example:

```text id="c7m1p5"
T(n)=2T(n-1)+O(1)
```

has exponential time but recursion depth:

$$
O(n)
$$

Therefore:

$$
\boxed{\text{Time}=O(2^n),\quad \text{Space}=O(n)}
$$

---

# 30. PYQ-STYLE QUESTION 7 — Graph

A graph has `V` vertices and `E` edges.

What is the space complexity of an adjacency list?

### Answer

$$
\boxed{O(V+E)}
$$

For an adjacency matrix:

$$
\boxed{O(V^2)}
$$

---

# 31. PYQ-STYLE QUESTION 8 — DP

A dynamic programming algorithm uses:

```text id="p3r7x2"
dp[n][n]
```

What is its space complexity?

### Answer

There are:

$$
n\times n=n^2
$$

states.

Therefore:

$$
\boxed{O(n^2)}
$$

---

# 32. PYQ-STYLE QUESTION 9 — Space Optimization

A DP recurrence is:

$$
dp[i]=dp[i-1]+x_i
$$

What is the minimum extra space required if only the final answer is needed?

### Answer

Only the previous state is needed:

```text id="x9m4k6"
previous
current
```

Therefore:

$$
\boxed{O(1)}
$$

instead of `O(n)`.

---

# 33. TIME vs SPACE MASTER TABLE ⭐⭐⭐⭐⭐

| Algorithm               |        Time | Auxiliary Space |
| ----------------------- | ----------: | --------------: |
| Linear Search           |        O(n) |            O(1) |
| Binary Search iterative |    O(log n) |            O(1) |
| Binary Search recursive |    O(log n) |        O(log n) |
| Bubble Sort             | O(n²) worst |            O(1) |
| Selection Sort          |       O(n²) |            O(1) |
| Insertion Sort          | O(n²) worst |            O(1) |
| Merge Sort              |  O(n log n) |            O(n) |
| Quick Sort              | O(n²) worst |      O(n) worst |
| Heap Sort               |  O(n log n) |            O(1) |
| BFS                     |      O(V+E) | O(V) auxiliary* |
| DFS                     |      O(V+E) | O(V) auxiliary* |

`*` excluding the graph representation itself.

---

# 34. 🔥 GATE FINAL CHEAT SHEET

### Definitions

$$
\boxed{\text{Total Space}=\text{Input Space}+\text{Auxiliary Space}}
$$

$$
\boxed{\text{Auxiliary Space}=\text{Extra Space}}
$$

### Recursion

$$
\boxed{\text{Depth }n\Rightarrow O(n)}
$$

$$
\boxed{\text{Depth }\log n\Rightarrow O(\log n)}
$$

### Sorting

$$
\boxed{\text{Merge Sort}\Rightarrow O(n)\text{ auxiliary}}
$$

$$
\boxed{\text{Heap Sort}\Rightarrow O(1)\text{ auxiliary}}
$$

$$
\boxed{\text{Quick Sort}\Rightarrow O(n)\text{ worst stack}}
$$

### Graphs

$$
\boxed{\text{Adjacency Matrix}=O(V^2)}
$$

$$
\boxed{\text{Adjacency List}=O(V+E)}
$$

### DP

```text id="t5x8q2"
1D DP → O(n)
2D DP → O(n²)
Rolling states → potentially O(1)
```

### Most Important GATE Idea

$$
\boxed{\text{Total recursive calls}\neq\text{Maximum stack depth}}
$$

For example:

$$
\boxed{
T(n)=2T(n-1)+1
\Rightarrow
\text{Time}=O(2^n),\;
\text{Space}=O(n)
}
$$

**Next: `06-Greedy.md` — greedy-choice property, optimal substructure, activity selection, fractional knapsack, Huffman coding, MST connection, proof techniques, GATE tricks + PYQs.**
