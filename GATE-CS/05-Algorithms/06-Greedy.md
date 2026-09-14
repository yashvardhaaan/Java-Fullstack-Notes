# 06 — Greedy Algorithms

# 1. THEORY

## 1.1 What is a Greedy Algorithm?

A **Greedy Algorithm** constructs a solution step-by-step by choosing the **locally best option** at each stage.

The choice is made with the hope that these local choices lead to a **globally optimal solution**.

### Basic structure

```text
Problem
   ↓
Choose best available option
   ↓
Make the choice permanent
   ↓
Reduce problem
   ↓
Repeat
```

### Key idea

> **Take the best choice now, without reconsidering it later.**

---

# 2. TWO IMPORTANT PROPERTIES ⭐⭐⭐⭐⭐

For a greedy algorithm to correctly solve an optimization problem, we generally need:

### 1. Greedy-Choice Property

A globally optimal solution can be obtained by making a **locally optimal choice** first.

### 2. Optimal Substructure

After making the greedy choice, the remaining problem has an optimal solution that forms part of the overall optimal solution.

---

# 3. GREEDY vs DYNAMIC PROGRAMMING ⭐⭐⭐⭐⭐

This is a very common GATE comparison.

| Greedy                       | Dynamic Programming               |
| ---------------------------- | --------------------------------- |
| Makes local choice           | Considers multiple possibilities  |
| Choice usually irreversible  | States can represent alternatives |
| Doesn't generally reconsider | Stores/reuses subproblem results  |
| Often faster                 | Often more computation            |
| Needs greedy-choice property | Uses optimal substructure         |

### GATE Trick 🔥

> **Optimal substructure alone does NOT guarantee that greedy works.**

You also need a valid greedy-choice argument.

---

# 4. GENERAL GREEDY TEMPLATE

```text
Greedy(problem):

    solution = empty

    while problem not empty:

        x = best available choice

        if x is feasible:
            add x to solution

    return solution
```

The difficult part is proving:

> Why is the locally best choice always safe?

---

# 5. ACTIVITY SELECTION ⭐⭐⭐⭐⭐

Given activities with:

```text
Start time
Finish time
```

Goal:

> Select the **maximum number of mutually compatible activities**.

Example:

| Activity | Start | Finish |
| -------- | ----: | -----: |
| A        |     1 |      3 |
| B        |     2 |      5 |
| C        |     3 |      4 |
| D        |     5 |      7 |
| E        |     5 |      9 |

---

# 6. ACTIVITY SELECTION GREEDY RULE ⭐⭐⭐⭐⭐

Choose the activity with the:

$$
\boxed{\text{Earliest finish time}}
$$

Then choose the next activity whose start time is at least the previous activity's finish time.

### Algorithm

1. Sort activities by finish time.
2. Select the first activity.
3. For each remaining activity:

   * If its start ≥ last selected finish:
   * Select it.

---

# 7. ACTIVITY SELECTION EXAMPLE

Activities:

```text
A = (1,3)
B = (2,5)
C = (3,4)
D = (5,7)
E = (6,9)
```

Sort by finish:

```text
A (1,3)
C (3,4)
B (2,5)
D (5,7)
E (6,9)
```

Choose:

```text
A → finish 3
C → starts 3
D → starts 5
```

Answer:

$$
\boxed{A,C,D}
$$

Number of activities:

$$
\boxed{3}
$$

---

# 8. WHY EARLIEST FINISH? 🧠

Suppose an activity finishes earliest.

It leaves the **maximum remaining time** for all future activities.

Therefore choosing it cannot reduce the maximum number of activities that can be selected.

This is the **greedy-choice argument**.

---

# 9. ACTIVITY SELECTION TRICK ⭐⭐⭐⭐⭐

Remember:

```text
Maximum number of activities
        ↓
Earliest finish time
```

NOT:

```text
Earliest start ❌
Shortest duration ❌
Latest start ❌
```

---

# 10. FRACTIONAL KNAPSACK ⭐⭐⭐⭐⭐

Given:

* Items with values
* Items with weights
* Knapsack capacity

Unlike 0/1 Knapsack, we can take **fractions of items**.

Goal:

$$
\boxed{\text{Maximize total value}}
$$

---

# 11. GREEDY RULE FOR FRACTIONAL KNAPSACK

Calculate:

$$
\boxed{\frac{value}{weight}}
$$

Choose items in **decreasing value/weight ratio**.

Example:

| Item | Value | Weight | Value/Weight |
| ---- | ----: | -----: | -----------: |
| A    |    60 |     10 |            6 |
| B    |   100 |     20 |            5 |
| C    |   120 |     30 |            4 |

Capacity:

```text
50
```

Choose:

```text
A → 10
B → 20
C → remaining 20
```

Take:

$$
\frac{20}{30}
$$

of C.

Total value:

$$
60+100+120\left(\frac{20}{30}\right)
$$

$$
=160+80
$$

$$
\boxed{240}
$$

---

# 12. FRACTIONAL vs 0/1 KNAPSACK ⭐⭐⭐⭐⭐

| Property          | Fractional   | 0/1         |
| ----------------- | ------------ | ----------- |
| Fraction allowed  | ✅            | ❌           |
| Greedy works      | ✅            | ❌ generally |
| Typical method    | Greedy       | DP          |
| Sorting criterion | Value/weight | Not enough  |

### GATE Trap 🔥

> Greedy by value/weight always solves 0/1 Knapsack.

❌ False.

It works for **Fractional Knapsack**, not generally for 0/1 Knapsack.

---

# 13. COUNTEREXAMPLE — 0/1 KNAPSACK

Capacity:

```text
50
```

Items:

| Item | Value | Weight |
| ---- | ----: | -----: |
| A    |    60 |     10 |
| B    |   100 |     20 |
| C    |   120 |     30 |

Ratios:

```text
A → 6
B → 5
C → 4
```

Greedy selects:

```text
A + B
```

Weight:

$$
30
$$

Remaining:

$$
20
$$

Cannot take C.

Value:

$$
160
$$

But:

```text
B + C
```

has weight:

$$
50
$$

and value:

$$
220
$$

Therefore greedy gives:

$$
160
$$

while optimal is:

$$
220
$$

Hence greedy fails for 0/1 Knapsack.

---

# 14. HUFFMAN CODING ⭐⭐⭐⭐⭐

Huffman Coding is a greedy algorithm used to construct an **optimal prefix code**.

Used for:

* Data compression
* Variable-length encoding

---

# 15. PREFIX CODE

A prefix code ensures that:

> No codeword is a prefix of another codeword.

Example:

```text
A → 0
B → 10
C → 11
```

Valid prefix code.

But:

```text
A → 0
B → 01
```

is invalid because `0` is a prefix of `01`.

---

# 16. HUFFMAN GREEDY RULE ⭐⭐⭐⭐⭐

Repeatedly combine the **two nodes with the smallest frequencies**.

Example:

```text
A = 5
B = 9
C = 12
D = 13
E = 16
F = 45
```

First:

```text
5 + 9 = 14
```

Then:

```text
12 + 13 = 25
```

Then:

```text
14 + 16 = 30
```

Then:

```text
25 + 30 = 55
```

Then:

```text
45 + 55 = 100
```

The resulting binary tree gives the Huffman codes.

---

# 17. HUFFMAN TRICK 🔥

Remember:

```text
Huffman
   ↓
Two smallest frequencies
   ↓
Combine
   ↓
Insert back
   ↓
Repeat
```

A **min-heap** is typically used.

Therefore construction complexity is generally:

$$
\boxed{O(n\log n)}
$$

for `n` symbols.

---

# 18. HUFFMAN TREE PROPERTY

For `n` symbols, a full binary Huffman tree has:

$$
\boxed{n-1}
$$

internal nodes.

Total nodes:

$$
\boxed{2n-1}
$$

### GATE Trick ⭐⭐⭐

If there are `10` symbols:

```text
Internal nodes = 9
Total nodes = 19
```

---

# 19. MINIMUM SPANNING TREE ⭐⭐⭐⭐⭐

Two famous greedy algorithms:

### Kruskal's Algorithm

### Prim's Algorithm

Both find a **Minimum Spanning Tree (MST)**.

---

# 20. MINIMUM SPANNING TREE

For a connected, weighted, undirected graph:

An MST is a spanning tree with minimum total edge weight.

Properties:

### Number of edges

For `V` vertices:

$$
\boxed{V-1}
$$

### No cycle

An MST is a tree.

### Minimum total weight

Among all spanning trees, its weight is minimum.

---

# 21. KRUSKAL'S ALGORITHM ⭐⭐⭐⭐⭐

Kruskal is an **edge-based greedy algorithm**.

### Steps

1. Sort all edges by increasing weight.
2. Consider the smallest edge.
3. Add it if it does **not create a cycle**.
4. Continue until `V-1` edges are selected.

---

# 22. KRUSKAL EXAMPLE

Edges:

```text
AB = 1
BC = 2
AC = 3
CD = 4
BD = 5
```

Sort:

```text
AB(1)
BC(2)
AC(3)
CD(4)
BD(5)
```

Select:

```text
AB → select
BC → select
AC → creates cycle A-B-C → reject
CD → select
```

MST:

```text
AB
BC
CD
```

Total:

$$
1+2+4=7
$$

---

# 23. KRUSKAL COMPLEXITY ⭐⭐⭐⭐

Main operation:

```text
Sort edges
```

Sorting:

$$
O(E\log E)
$$

Union-Find operations are nearly linear.

Therefore:

$$
\boxed{O(E\log E)}
$$

---

# 24. PRIM'S ALGORITHM ⭐⭐⭐⭐⭐

Prim's algorithm is a **vertex-based greedy algorithm**.

Start from any vertex.

Repeatedly select the minimum-weight edge connecting:

```text
Current MST
     ↓
Outside vertex
```

---

# 25. PRIM vs KRUSKAL ⭐⭐⭐⭐⭐

| Feature            | Prim                         | Kruskal      |
| ------------------ | ---------------------------- | ------------ |
| Approach           | Vertex-based                 | Edge-based   |
| Starts with        | A vertex                     | Sorted edges |
| Cycle handling     | Implicit through visited set | Union-Find   |
| Main structure     | Priority Queue               | Disjoint Set |
| Typical complexity | O(E log V)                   | O(E log E)   |

### Memory Trick

```text
Prim → Pick nearest vertex
Kruskal → Pick smallest edge
```

---

# 26. DIJKSTRA'S ALGORITHM ⭐⭐⭐⭐⭐

Dijkstra's algorithm is also greedy.

It finds **single-source shortest paths** when edge weights are:

$$
\boxed{\ge0}
$$

### Greedy choice

Select the unvisited vertex with the **smallest tentative distance**.

Then relax its outgoing edges.

---

# 27. DIJKSTRA TRICK 🔥

```text
Dijkstra
↓
Shortest Path
↓
Non-negative weights
```

### GATE Trap

Dijkstra does **not** work correctly with negative-weight edges in general.

---

# 28. GREEDY ALGORITHM SUMMARY ⭐⭐⭐⭐⭐

| Problem             | Greedy Choice                           |
| ------------------- | --------------------------------------- |
| Activity Selection  | Earliest finish time                    |
| Fractional Knapsack | Highest value/weight                    |
| Huffman Coding      | Two smallest frequencies                |
| Kruskal             | Smallest edge without cycle             |
| Prim                | Minimum edge connecting tree to outside |
| Dijkstra            | Smallest tentative distance             |

---

# 29. GATE TRICKS 🧠🔥

## Trick 1

```text
Fractional Knapsack → Greedy
0/1 Knapsack → DP generally
```

---

## Trick 2

```text
Activity Selection
→ Earliest finishing activity
```

---

## Trick 3

```text
Huffman
→ Two minimum frequencies
```

---

## Trick 4

```text
Kruskal
→ Sort edges
→ Union-Find
```

---

## Trick 5

```text
Prim
→ Start vertex
→ Minimum connecting edge
```

---

## Trick 6

```text
Dijkstra
→ Non-negative weights
```

---

## Trick 7 ⭐

An MST always has:

$$
\boxed{V-1}
$$

edges.

---

## Trick 8 ⭐

If all edge weights are **distinct**, the MST is unique.

If equal-weight edges exist, multiple MSTs may exist.

---

# 30. CUT PROPERTY ⭐⭐⭐⭐⭐

The **cut property** is fundamental to MST correctness.

For any cut in a weighted graph:

> A minimum-weight edge crossing that cut is safe to include in some MST.

This is one of the reasons greedy MST algorithms work.

---

# 31. CYCLE PROPERTY ⭐⭐⭐⭐

For a cycle:

> A maximum-weight edge in the cycle can be excluded from some MST.

If the maximum edge is uniquely heaviest, it cannot belong to any MST.

### GATE Trick

```text
Cut → Minimum edge is safe
Cycle → Maximum edge can be removed
```

---

# 32. GREEDY FAILURE ⭐⭐⭐⭐⭐

Greedy does not work for every optimization problem.

Example:

### 0/1 Knapsack

Greedy by:

```text
value/weight
```

can fail.

### Coin Change

Greedy does not always produce the minimum number of coins for arbitrary denominations.

Example:

```text
Coins = {1, 3, 4}
Amount = 6
```

Greedy:

```text
4 + 1 + 1
```

uses:

$$
3
$$

coins.

Optimal:

```text
3 + 3
```

uses:

$$
2
$$

coins.

Therefore:

$$
\boxed{\text{Greedy fails}}
$$

---

# 33. GREEDY PROOF TECHNIQUES ⭐⭐⭐⭐

Two common proof ideas:

### Exchange Argument

Show that a greedy choice can replace another choice in an optimal solution without making it worse.

### Greedy Stays Ahead

Show that after every step, the greedy solution is at least as good as any competing solution according to the relevant measure.

For GATE, understanding the **exchange argument** is especially useful for activity selection and MST reasoning.

---

# 34. PYQ-STYLE QUESTION 1

For Activity Selection, which criterion should be used?

A. Earliest start
B. Shortest duration
C. Earliest finish
D. Highest duration

### Answer

$$
\boxed{C}
$$

### Why?

Earliest finish leaves the largest possible remaining interval for future activities.

---

# 35. PYQ-STYLE QUESTION 2 ⭐

Items are:

| Item | Weight | Value |
| ---- | -----: | ----: |
| A    |     10 |    60 |
| B    |     20 |   100 |
| C    |     30 |   120 |

Capacity = `50`.

What is the optimal value for **fractional knapsack**?

### Solution

Ratios:

$$
A=6
$$

$$
B=5
$$

$$
C=4
$$

Take:

```text
A → 10
B → 20
C → 20
```

Fraction of C:

$$
20/30
$$

Value:

$$
60+100+120(20/30)
$$

$$
=240
$$

### Answer

$$
\boxed{240}
$$

---

# 36. PYQ-STYLE QUESTION 3

For the same items and capacity `50`, what happens if it is **0/1 Knapsack**?

### Solution

Cannot take fractions.

Possible:

```text
A+B → weight 30, value 160

A+C → weight 40, value 180

B+C → weight 50, value 220
```

Therefore:

$$
\boxed{220}
$$

### GATE Concept

Fractional:

$$
240
$$

0/1:

$$
220
$$

Greedy ratio works for the first but not generally for the second.

---

# 37. PYQ-STYLE QUESTION 4 — Huffman

There are `8` symbols.

How many internal nodes does the Huffman tree contain?

### Solution

For `n` symbols:

$$
n-1
$$

Therefore:

$$
8-1=\boxed7
$$

---

# 38. PYQ-STYLE QUESTION 5 — MST

A connected graph has `25` vertices.

How many edges does its MST contain?

### Solution

Any spanning tree with `V` vertices contains:

$$
V-1
$$

edges.

Therefore:

$$
25-1=\boxed{24}
$$

---

# 39. PYQ-STYLE QUESTION 6 — Kruskal

Kruskal's algorithm considers edges in what order?

### Answer

$$
\boxed{\text{Non-decreasing order of edge weight}}
$$

Then an edge is selected only if it does not create a cycle.

---

# 40. PYQ-STYLE QUESTION 7 — Prim

Prim's algorithm currently has a set of vertices in the MST.

What edge should be chosen next?

### Answer

The minimum-weight edge connecting:

```text
MST set
   ↓
A vertex outside MST
```

---

# 41. PYQ-STYLE QUESTION 8 — Dijkstra ⭐⭐⭐⭐⭐

Which condition is required for Dijkstra's algorithm?

A. All weights must be equal
B. All weights must be non-negative
C. Graph must be unweighted
D. Graph must be directed

### Answer

$$
\boxed{B}
$$

Dijkstra works with non-negative edge weights.

---

# 42. PYQ-STYLE QUESTION 9 — Coin Change

Coins:

```text
{1,3,4}
```

Amount:

```text
6
```

What does greedy choose if it repeatedly chooses the largest possible coin?

### Solution

```text
6
↓
4
↓
remaining 2
↓
1
↓
1
```

Solution:

```text
4 + 1 + 1
```

Number of coins:

$$
3
$$

But optimal:

```text
3 + 3
```

Number:

$$
2
$$

Therefore greedy is not optimal.

---

# 43. PYQ-STYLE QUESTION 10 — MST Uniqueness ⭐⭐⭐⭐

A connected weighted graph has all edge weights distinct.

How many MSTs can it have?

### Answer

$$
\boxed{\text{Exactly one}}
$$

Distinct edge weights guarantee a unique MST.

---

# 44. EXAM QUICK REVISION ⚡

```text
GREEDY
↓
Best local choice
↓
Hope for global optimum
```

```text
ACTIVITY SELECTION
↓
Earliest finish
```

```text
FRACTIONAL KNAPSACK
↓
Highest value/weight
```

```text
HUFFMAN
↓
Two smallest frequencies
```

```text
KRUSKAL
↓
Smallest edges
↓
No cycle
↓
Union-Find
```

```text
PRIM
↓
Minimum edge connecting MST to outside
```

```text
DIJKSTRA
↓
Smallest tentative distance
↓
Non-negative edges
```

---

# 45. 🔥 GATE MUST-MEMORIZE TABLE

| Topic                     | Greedy Rule                        |
| ------------------------- | ---------------------------------- |
| Activity Selection        | Earliest finish                    |
| Fractional Knapsack       | Maximum value/weight               |
| Huffman                   | Combine two smallest               |
| Kruskal                   | Smallest edge without cycle        |
| Prim                      | Smallest connecting edge           |
| Dijkstra                  | Smallest tentative distance        |
| MST edges                 | `V − 1`                            |
| MST with distinct weights | Unique                             |
| Cut property              | Minimum crossing edge is safe      |
| Cycle property            | Maximum cycle edge can be excluded |
| 0/1 Knapsack              | Greedy generally fails             |
| Arbitrary Coin Change     | Greedy can fail                    |

---

# 🎯 GATE PRIORITY

### ⭐⭐⭐⭐⭐ Must Master

1. Activity Selection
2. Fractional Knapsack
3. 0/1 Knapsack vs Fractional
4. Huffman Coding
5. Kruskal
6. Prim
7. Dijkstra
8. Cut and Cycle properties
9. Greedy correctness
10. Counterexamples where greedy fails

### 🧠 Ultimate Memory Formula

$$
\boxed{\text{Activity}\rightarrow\text{Earliest Finish}}
$$

$$
\boxed{\text{Knapsack Fractional}\rightarrow\frac{V}{W}}
$$

$$
\boxed{\text{Huffman}\rightarrow\text{Two Minimum}}
$$

$$
\boxed{\text{Kruskal}\rightarrow\text{Smallest Edge + No Cycle}}
$$

$$
\boxed{\text{Prim}\rightarrow\text{Minimum Connecting Edge}}
$$

$$
\boxed{\text{Dijkstra}\rightarrow\text{Minimum Distance}}
$$

**Next: `07-Divide-and-Conquer.md` — divide/conquer/combine, binary search, merge sort, quicksort, recurrence trees, Master Theorem connection, GATE tricks + PYQs.**
