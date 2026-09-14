# 08 — Dynamic Programming (DP)

# 1. THEORY

## 1.1 What is Dynamic Programming?

**Dynamic Programming (DP)** is an algorithmic technique used to solve problems by:

1. Breaking the problem into smaller subproblems.
2. Solving each subproblem once.
3. Storing its result.
4. Reusing the stored result whenever the same subproblem occurs again.

### Core idea

$$
\boxed{\text{Solve once + Store + Reuse}}
$$

DP is especially useful when a problem has:

$$
\boxed{\text{Overlapping Subproblems + Optimal Substructure}}
$$

---

# 2. TWO PROPERTIES OF DP ⭐⭐⭐⭐⭐

## 2.1 Overlapping Subproblems

The same subproblems occur repeatedly.

Example: Fibonacci.

$$
F(n)=F(n-1)+F(n-2)
$$

For `F(5)`:

```text
             F(5)
           /      \
        F(4)      F(3)
       /   \      /   \
     F(3) F(2)  F(2) F(1)
```

`F(3)` and `F(2)` are repeatedly calculated.

DP stores their results.

---

# 3. OPTIMAL SUBSTRUCTURE ⭐⭐⭐⭐⭐

A problem has optimal substructure if:

> An optimal solution can be constructed from optimal solutions to its subproblems.

Examples:

* Shortest path
* 0/1 Knapsack
* LCS
* Matrix Chain Multiplication

### GATE Trick

```text id="q6m7z4"
Overlapping Subproblems
        +
Optimal Substructure
        ↓
Think Dynamic Programming
```

But **optimal substructure alone does not imply DP is necessary**.

---

# 4. DP vs DIVIDE AND CONQUER ⭐⭐⭐⭐⭐

| DP                      | Divide & Conquer                       |
| ----------------------- | -------------------------------------- |
| Subproblems may overlap | Usually independent subproblems        |
| Stores results          | Usually doesn't store repeated results |
| Avoids recomputation    | May recompute                          |
| Memoization/tabulation  | Recursion commonly                     |
| Fibonacci DP            | Merge Sort                             |

### Example

Merge Sort:

```text id="x8m2p6"
Left half and right half
```

are independent.

Fibonacci:

```text id="j4r7c1"
F(n-1) and F(n-2)
```

have overlapping subproblems.

---

# 5. TWO APPROACHES TO DP ⭐⭐⭐⭐⭐

## 5.1 Top-Down — Memoization

Start with the original problem and recursively solve smaller problems.

Store results.

```text id="0s5x2c"
function fib(n):

    if n <= 1:
        return n

    if dp[n] already exists:
        return dp[n]

    dp[n] = fib(n-1) + fib(n-2)

    return dp[n]
```

### Features

```text id="6k1r8f"
Recursion
+
Storage
=
Memoization
```

---

# 6. BOTTOM-UP — TABULATION

Start from the smallest subproblems and build toward the final answer.

For Fibonacci:

```text id="7h4k9p"
dp[0] = 0
dp[1] = 1

for i = 2 to n:
    dp[i] = dp[i-1] + dp[i-2]
```

### Features

```text id="m9c2v5"
Iteration
+
Table
=
Tabulation
```

---

# 7. MEMOIZATION vs TABULATION ⭐⭐⭐⭐⭐

| Feature                    | Memoization   | Tabulation              |
| -------------------------- | ------------- | ----------------------- |
| Direction                  | Top-down      | Bottom-up               |
| Technique                  | Recursion     | Iteration               |
| Computes                   | Needed states | Usually all states      |
| Stack usage                | Yes           | Usually no              |
| Easy to write              | Often         | Often requires ordering |
| Stack overflow possibility | Yes           | No recursion stack      |

---

# 8. FIBONACCI USING DP ⭐⭐⭐⭐⭐

Naive:

$$
F(n)=F(n-1)+F(n-2)
$$

Time:

$$
\boxed{O(2^n)}
$$

With DP:

```text id="z5m8q3"
dp[0] = 0
dp[1] = 1

dp[i] = dp[i-1] + dp[i-2]
```

Time:

$$
\boxed{O(n)}
$$

Space:

$$
\boxed{O(n)}
$$

But only the previous two values are required.

Therefore space can be optimized to:

$$
\boxed{O(1)}
$$

---

# 9. 0/1 KNAPSACK ⭐⭐⭐⭐⭐

Given:

* `n` items
* Weight `w[i]`
* Value `v[i]`
* Capacity `W`

Each item can either be:

```text id="4y9p1k"
Taken → 1
Not taken → 0
```

Fractions are not allowed.

Goal:

$$
\boxed{\text{Maximize total value}}
$$

---

# 10. KNAPSACK DP STATE

Define:

$$
dp[i][w]
$$

as the maximum value obtainable using the first `i` items with capacity `w`.

---

# 11. KNAPSACK RECURRENCE ⭐⭐⭐⭐⭐

For item `i`:

### If item doesn't fit:

$$
w_i>w
$$

then:

$$
\boxed{dp[i][w]=dp[i-1][w]}
$$

### If it fits:

Either don't take it:

$$
dp[i-1][w]
$$

or take it:

$$
v_i+dp[i-1][w-w_i]
$$

Therefore:

$$
\boxed{
dp[i][w]
=
\max(dp[i-1][w],
v_i+dp[i-1][w-w_i])
}
$$

---

# 12. KNAPSACK COMPLEXITY

Number of states:

$$
n\times W
$$

Therefore:

$$
\boxed{O(nW)}
$$

Space:

$$
\boxed{O(nW)}
$$

Can be optimized to:

$$
\boxed{O(W)}
$$

using a 1D DP array.

---

# 13. KNAPSACK — GATE TRICK 🔥

`O(nW)` is **pseudo-polynomial**, not polynomial in the input length.

Why?

Because `W` can be represented using only:

$$
O(\log W)
$$

bits.

But the algorithm takes:

$$
O(W)
$$

time.

Therefore:

$$
\boxed{O(nW)\text{ is pseudo-polynomial}}
$$

This is an important GATE concept.

---

# 14. FRACTIONAL vs 0/1 KNAPSACK

| Feature            | Fractional    | 0/1                    |
| ------------------ | ------------- | ---------------------- |
| Fractions allowed  | Yes           | No                     |
| Greedy             | Works         | Doesn't generally work |
| DP                 | Not necessary | Common solution        |
| Typical complexity | O(n log n)    | O(nW)                  |

### Memory

```text id="f8k2m1"
Fractional → Greedy
0/1        → DP
```

---

# 15. LONGEST COMMON SUBSEQUENCE — LCS ⭐⭐⭐⭐⭐

Given two strings:

```text id="w7n4q2"
X = ABCD
Y = ACBD
```

Find the longest sequence that appears in both strings **in the same order**, but not necessarily contiguously.

Possible LCS:

```text id="6m8r1p"
ABD
```

or:

```text id="4q2t9x"
ACD
```

Length:

$$
3
$$

---

# 16. SUBSTRING vs SUBSEQUENCE ⭐⭐⭐⭐⭐

### Substring

Must be contiguous.

```text id="1f8k5m"
ABCDEF
BCD → substring
```

### Subsequence

Does not need to be contiguous.

```text id="3q7n2v"
ABCDEF
ACE → subsequence
```

### GATE Trap 🔥

LCS means:

$$
\boxed{\text{Longest Common Subsequence}}
$$

NOT substring.

---

# 17. LCS DP STATE

Define:

$$
dp[i][j]
$$

as the LCS length of:

```text id="r3v8x1"
X[1..i]
Y[1..j]
```

---

# 18. LCS RECURRENCE ⭐⭐⭐⭐⭐

If:

$$
X[i]=Y[j]
$$

then:

$$
\boxed{dp[i][j]=dp[i-1][j-1]+1}
$$

If:

$$
X[i]\ne Y[j]
$$

then:

$$
\boxed{
dp[i][j]=
\max(dp[i-1][j],dp[i][j-1])
}
$$

---

# 19. LCS COMPLEXITY

There are:

$$
m\times n
$$

states.

Therefore:

$$
\boxed{O(mn)}
$$

space:

$$
\boxed{O(mn)}
$$

Can sometimes be optimized to:

$$
\boxed{O(\min(m,n))}
$$

if only the length is required.

---

# 20. MATRIX CHAIN MULTIPLICATION ⭐⭐⭐⭐⭐

Suppose matrices:

$$
A_1,A_2,\ldots,A_n
$$

The order in which matrix multiplications are performed affects the number of scalar multiplications.

Goal:

$$
\boxed{\text{Minimize scalar multiplications}}
$$

---

# 21. MATRIX CHAIN EXAMPLE

Suppose:

```text id="v8m2k6"
A = 10 × 20
B = 20 × 30
C = 30 × 40
```

Two possible orders:

### `(AB)C`

First:

$$
10\times20\times30=6000
$$

Then:

$$
10\times30\times40=12000
$$

Total:

$$
\boxed{18000}
$$

---

### `A(BC)`

First:

$$
20\times30\times40=24000
$$

Then:

$$
10\times20\times40=8000
$$

Total:

$$
\boxed{32000}
$$

Therefore:

$$
\boxed{(AB)C}
$$

is better.

---

# 22. MATRIX CHAIN DP RECURRENCE ⭐⭐⭐⭐⭐

Let:

$$
dp[i][j]
$$

be the minimum number of scalar multiplications needed to multiply:

$$
A_i\ldots A_j
$$

Then:

$$
\boxed{
dp[i][j]
=
\min_{i\le k<j}
\{dp[i][k]+dp[k+1][j]+p_{i-1}p_kp_j\}
}
$$

---

# 23. MATRIX CHAIN COMPLEXITY

There are:

$$
O(n^2)
$$

states.

For each state, try:

$$
O(n)
$$

splits.

Therefore:

$$
\boxed{O(n^3)}
$$

time.

Space:

$$
\boxed{O(n^2)}
$$

---

# 24. LONGEST INCREASING SUBSEQUENCE — LIS ⭐⭐⭐⭐

Given:

```text id="j8p3r5"
[10, 22, 9, 33, 21, 50, 41, 60]
```

One LIS:

```text id="d6m9q2"
10,22,33,50,60
```

Length:

$$
\boxed{5}
$$

---

# 25. LIS DP

Define:

$$
dp[i]
$$

as the length of the longest increasing subsequence **ending at index `i`**.

Then:

$$
\boxed{
dp[i]=1+\max(dp[j])
}
$$

for all:

$$
j<i
$$

such that:

$$
A[j]<A[i]
$$

If no such `j` exists:

$$
dp[i]=1
$$

---

# 26. LIS COMPLEXITY

Basic DP:

$$
\boxed{O(n^2)}
$$

There is also a binary-search-based method:

$$
\boxed{O(n\log n)}
$$

### GATE Point

The `O(n log n)` method maintains an array of minimum possible tail values.

It does **not necessarily store the actual LIS directly**.

---

# 27. COIN CHANGE ⭐⭐⭐⭐⭐

Suppose coins:

```text id="w5n8p2"
{1,3,4}
```

Amount:

```text id="k2r7m4"
6
```

Goal:

> Find minimum number of coins.

DP recurrence:

$$
\boxed{
dp[x]=1+\min_{c\le x}dp[x-c]
}
$$

Base:

$$
dp[0]=0
$$

---

# 28. COIN CHANGE EXAMPLE

```text id="q6t3v1"
dp[0] = 0
dp[1] = 1
dp[2] = 2
dp[3] = 1
dp[4] = 1
dp[5] = 2
dp[6] = 2
```

For `6`:

```text id="9m2x7k"
3 + 3
```

Therefore:

$$
\boxed{2}
$$

coins.

Greedy would produce:

```text id="w8k4p3"
4 + 1 + 1
```

which uses `3`.

---

# 29. DP FOR SHORTEST PATH ⭐⭐⭐⭐

Dynamic Programming can be used in shortest-path problems.

### Bellman-Ford

Bellman-Ford can be viewed through DP-style relaxation.

It handles:

$$
\boxed{\text{Negative edge weights}}
$$

and can detect reachable negative cycles.

Complexity:

$$
\boxed{O(VE)}
$$

---

# 30. DP vs DIJKSTRA ⭐⭐⭐⭐⭐

| Dijkstra               | Bellman-Ford           |
| ---------------------- | ---------------------- |
| Greedy                 | DP-style relaxation    |
| No negative edges      | Negative edges allowed |
| Typically faster       | Slower                 |
| `O(E log V)` with heap | `O(VE)`                |

### GATE Trick

```text id="8k5p1z"
Negative edge?
↓
Dijkstra ❌
Bellman-Ford ✅
```

---

# 31. DP STATE DESIGN ⭐⭐⭐⭐⭐

The most difficult part of DP is often identifying the correct **state**.

Ask:

1. What information uniquely describes a subproblem?
2. What choices are available?
3. What smaller states result from each choice?
4. What is the base case?

### Example — Knapsack

State:

$$
dp[i][w]
$$

means:

> Maximum value using first `i` items with capacity `w`.

---

# 32. DP TRANSITION

A **transition** tells how one state is calculated from smaller states.

Example:

$$
dp[i][w]
=
\max(
dp[i-1][w],
v_i+dp[i-1][w-w_i]
)
$$

This represents two choices:

```text id="k3q8m6"
Don't take item
        OR
Take item
```

---

# 33. BASE CASE ⭐⭐⭐⭐⭐

Every DP needs appropriate base cases.

For Fibonacci:

$$
dp[0]=0
$$

$$
dp[1]=1
$$

For Knapsack:

$$
dp[0][w]=0
$$

because zero items give zero value.

For LCS:

$$
dp[0][j]=0
$$

and:

$$
dp[i][0]=0
$$

because an empty string has LCS length zero.

---

# 34. DP SPACE OPTIMIZATION ⭐⭐⭐⭐⭐

Suppose:

$$
dp[i][w]
$$

only depends on:

$$
dp[i-1][w]
$$

Then instead of:

```text id="7r4n2m"
dp[n][W]
```

we can use:

```text id="8k1p5q"
dp[W]
```

Space becomes:

$$
\boxed{O(W)}
$$

instead of:

$$
O(nW)
$$

---

# 35. 1D KNAPSACK UPDATE DIRECTION ⭐⭐⭐⭐⭐

For **0/1 Knapsack**, if using a 1D DP array, iterate capacity **backward**:

```text id="r9x3m7"
for each item:
    for w = W down to weight[i]:
        dp[w] = max(dp[w],
                     value[i] + dp[w-weight[i]])
```

Why backward?

To prevent using the same item multiple times during the same iteration.

### GATE Trap 🔥

```text id="v6k2p8"
0/1 Knapsack → backward
Unbounded Knapsack → forward
```

---

# 36. 0/1 vs UNBOUNDED KNAPSACK ⭐⭐⭐⭐

### 0/1

Each item can be used:

$$
0\text{ or }1
$$

times.

### Unbounded

An item can be used multiple times.

In a 1D DP implementation:

```text id="k4p7n1"
0/1 → iterate weight downward
Unbounded → iterate weight upward
```

---

# 37. DP TRICKS 🧠🔥

## Trick 1

```text id="y2q7m4"
Overlapping subproblems
+
Optimal substructure
→ DP
```

---

## Trick 2

```text id="p8x3r5"
Top-down → Memoization
Bottom-up → Tabulation
```

---

## Trick 3

```text id="w6n1k9"
0/1 Knapsack → O(nW)
```

---

## Trick 4

```text id="r3m8q2"
LCS → O(mn)
```

---

## Trick 5

```text id="j5v2x8"
Matrix Chain → O(n³)
```

---

## Trick 6

```text id="n9k4p1"
LIS basic DP → O(n²)
LIS optimized → O(n log n)
```

---

## Trick 7

```text id="a7m3r6"
0/1 Knapsack 1D → backward
Unbounded Knapsack → forward
```

---

# 38. PYQ-STYLE QUESTION 1 — Fibonacci

Naive recursive Fibonacci takes approximately:

$$
O(2^n)
$$

What is the time complexity using memoization?

### Answer

Each state `F(i)` is calculated once.

There are:

$$
n+1
$$

states.

Therefore:

$$
\boxed{O(n)}
$$

---

# 39. PYQ-STYLE QUESTION 2

What are the two fundamental properties required for the standard DP approach?

### Answer

$$
\boxed{\text{Overlapping Subproblems + Optimal Substructure}}
$$

---

# 40. PYQ-STYLE QUESTION 3 — LCS ⭐⭐⭐⭐⭐

Find the LCS length:

```text id="y4k8m2"
X = ABC
Y = AC
```

### Solution

Common subsequence:

```text id="f8p2r6"
AC
```

Therefore:

$$
\boxed{2}
$$

---

# 41. PYQ-STYLE QUESTION 4 — LCS Recurrence

If:

$$
X[i]=Y[j]
$$

what is the LCS transition?

### Answer

$$
\boxed{dp[i][j]=dp[i-1][j-1]+1}
$$

If they are different:

$$
\boxed{
dp[i][j]=\max(dp[i-1][j],dp[i][j-1])
}
$$

---

# 42. PYQ-STYLE QUESTION 5 — Knapsack ⭐⭐⭐⭐⭐

There are `100` items and capacity `50`.

What is the basic DP time complexity for 0/1 Knapsack?

### Solution

$$
nW
$$

Therefore:

$$
100\times50
$$

and asymptotically:

$$
\boxed{O(nW)}
$$

---

# 43. PYQ-STYLE QUESTION 6 — Pseudo-Polynomial

Why is:

$$
O(nW)
$$

not considered polynomial in the size of the input?

### Answer

Because `W` may be exponentially larger than the number of bits needed to represent it.

For example:

```text id="m6q1p8"
W = 1,000,000
```

requires only about 20 bits, but the DP performs work proportional to one million.

Therefore:

$$
\boxed{O(nW)\text{ is pseudo-polynomial}}
$$

---

# 44. PYQ-STYLE QUESTION 7 — Matrix Chain

Matrices:

```text id="c8v3m5"
A = 10×20
B = 20×30
C = 30×40
```

Which order requires fewer scalar multiplications?

### `(AB)C`

$$
10(20)(30)+10(30)(40)
$$

$$
=6000+12000
$$

$$
=\boxed{18000}
$$

### `A(BC)`

$$
20(30)(40)+10(20)(40)
$$

$$
=24000+8000
$$

$$
=\boxed{32000}
$$

Therefore:

$$
\boxed{(AB)C}
$$

---

# 45. PYQ-STYLE QUESTION 8 — Coin Change

Coins:

```text id="q9r2m7"
{1,3,4}
```

Amount:

```text id="z6p3x1"
6
```

Minimum coins?

### Greedy

```text id="h8k4v2"
4 + 1 + 1 = 3 coins
```

### DP

```text id="j3m7q9"
3 + 3 = 2 coins
```

Therefore:

$$
\boxed{2}
$$

---

# 46. PYQ-STYLE QUESTION 9 — 1D Knapsack

For 0/1 Knapsack using a one-dimensional DP array, in which direction should capacity normally be traversed?

### Answer

$$
\boxed{\text{Right to Left / Descending}}
$$

Example:

```text id="r5n2k8"
for w = W down to weight[i]
```

### Why?

To ensure the current item is not reused multiple times.

---

# 47. PYQ-STYLE QUESTION 10 — DP Space

A DP algorithm has:

$$
dp[n][n]
$$

but each row depends only on the previous row.

What space optimization is possible?

### Original

$$
O(n^2)
$$

### Optimized

Keep only:

```text id="x7m4q1"
previous row
current row
```

Therefore:

$$
\boxed{O(n)}
$$

---

# 48. PYQ-STYLE QUESTION 11 — LIS

Given:

```text id="v5q8m3"
[3, 10, 2, 1, 20]
```

Find the LIS length.

Possible LIS:

```text id="p2r7k4"
3,10,20
```

or:

```text id="m9x3c6"
3,10,20
```

Length:

$$
\boxed{3}
$$

---

# 49. PYQ-STYLE QUESTION 12 — DP vs Greedy

Which statement is correct?

A. Every DP problem can be solved greedily.

B. Every greedy problem requires DP.

C. 0/1 Knapsack can generally be solved optimally using value/weight greedy.

D. Fractional Knapsack can be solved optimally using value/weight greedy.

### Answer

$$
\boxed{D}
$$

---

# 50. 🔥 GATE MUST-MEMORIZE TABLE

| Problem             | Technique           |  Typical Time |
| ------------------- | ------------------- | ------------: |
| Fibonacci           | DP                  |          O(n) |
| 0/1 Knapsack        | DP                  |         O(nW) |
| Fractional Knapsack | Greedy              |    O(n log n) |
| LCS                 | DP                  |         O(mn) |
| Matrix Chain        | DP                  |         O(n³) |
| LIS basic           | DP                  |         O(n²) |
| LIS optimized       | Binary Search       |    O(n log n) |
| Coin Change         | DP                  | O(n × amount) |
| Bellman-Ford        | DP-style relaxation |         O(VE) |

---

# 51. 🧠 ONE-MINUTE REVISION

```text id="z4m7q1"
DP
↓
Overlapping subproblems
+
Optimal substructure
```

```text id="c8p2r6"
Memoization
↓
Top → Down
↓
Recursion + Cache
```

```text id="n5x9k3"
Tabulation
↓
Bottom → Up
↓
Iteration + Table
```

```text id="w7m3q8"
0/1 Knapsack
↓
Take / Don't Take
↓
O(nW)
```

```text id="p2r6v4"
LCS
↓
Same → diagonal + 1
Different → max(top,left)
```

```text id="k9x3m7"
Matrix Chain
↓
Try every split
↓
O(n³)
```

```text id="h4q8n2"
LIS
↓
Increasing subsequence
↓
O(n²) basic
↓
O(n log n) optimized
```

```text id="m6p1r9"
0/1 Knapsack 1D
↓
Backward
```

```text id="t3x7k5"
Unbounded Knapsack 1D
↓
Forward
```

---

# 🎯 GATE PRIORITY

### ⭐⭐⭐⭐⭐ Must Master

1. DP identification
2. Overlapping subproblems
3. Optimal substructure
4. Memoization vs tabulation
5. 0/1 Knapsack
6. LCS
7. Matrix Chain Multiplication
8. LIS
9. Coin Change
10. DP space optimization
11. Pseudo-polynomial complexity
12. 0/1 vs unbounded Knapsack
13. DP vs Greedy

### 🔥 Ultimate DP Formula Sheet

$$
\boxed{\text{DP}=\text{Overlapping Subproblems}+\text{Optimal Substructure}}
$$

$$
\boxed{\text{Memoization}=\text{Top-Down}}
$$

$$
\boxed{\text{Tabulation}=\text{Bottom-Up}}
$$

$$
\boxed{\text{0/1 Knapsack}=O(nW)}
$$

$$
\boxed{\text{LCS}=O(mn)}
$$

$$
\boxed{\text{Matrix Chain}=O(n^3)}
$$

$$
\boxed{\text{LIS}=O(n^2)\text{ basic}}
$$

$$
\boxed{\text{LIS}=O(n\log n)\text{ optimized}}
$$

$$
\boxed{\text{0/1 1D DP}\rightarrow\text{backward}}
$$

$$
\boxed{\text{Unbounded 1D DP}\rightarrow\text{forward}}
$$

**Next: `09-Backtracking.md` — state-space tree, N-Queens, subset sum, graph coloring, Hamiltonian cycle, pruning, backtracking vs DP/greedy, GATE tricks + PYQs.**
