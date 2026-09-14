# 10 — MINIMUM SPANNING TREE (MST)

## THEORY

### 1. What is a Spanning Tree?

For a **connected, undirected graph**, a spanning tree is a subgraph that:

* Contains **all vertices**
* Is **connected**
* Contains **no cycle**

For `V` vertices:

$$
\boxed{\text{Spanning tree has exactly }V-1\text{ edges}}
$$

---

## 2. Minimum Spanning Tree

A **Minimum Spanning Tree (MST)** is a spanning tree whose total edge weight is minimum among all spanning trees.

Example:

```text
       2
   A ------- B
   |         |
  5|         |3
   |         |
   C ------- D
       1
```

Possible spanning trees have different total weights.

MST chooses the set of edges with the **minimum total weight** while still connecting every vertex and avoiding cycles.

---

# 3. Important MST Properties

### Property 1 — Number of edges

For `V` vertices:

$$
\boxed{V-1}
$$

---

### Property 2 — No cycle

An MST is always a tree.

Therefore:

$$
\boxed{\text{MST contains no cycle}}
$$

---

### Property 3 — Connected

All vertices must be reachable from every other vertex.

---

### Property 4 — MST is not necessarily unique

If edge weights are repeated, multiple MSTs can exist.

Example:

```text
A --1-- B
|      |
1      1
|      |
C --1-- D
```

Several different spanning trees can have the same minimum cost.

---

# 4. Kruskal's Algorithm 🔥

Kruskal is an **edge-based greedy algorithm**.

### Steps

1. Sort all edges by increasing weight.
2. Pick the smallest edge.
3. Add it if it does **not create a cycle**.
4. Continue until `V-1` edges are selected.

```text
Sort edges
     ↓
Smallest edge
     ↓
Cycle?
 ↙       ↘
Yes       No
Skip      Add
     ↓
Repeat
```

### Data Structure

Kruskal uses:

$$
\boxed{\text{Disjoint Set Union / Union-Find}}
$$

for efficient cycle detection.

---

## Kruskal Example

Edges:

```text
AB = 1
BC = 2
AC = 3
CD = 4
BD = 5
```

Sorted:

```text
1 → 2 → 3 → 4 → 5
```

Select:

```text
AB = 1
BC = 2
```

Now `AC = 3` would create:

```text
A → B → C → A
```

So skip it.

Select:

```text
CD = 4
```

MST:

```text
AB + BC + CD
```

Total:

$$
1+2+4=\boxed{7}
$$

---

# 5. Prim's Algorithm 🔥

Prim is a **vertex-based greedy algorithm**.

It starts from any vertex and repeatedly chooses the minimum-weight edge that connects:

> a vertex already in the MST → a vertex outside the MST.

### Steps

```text
Choose starting vertex
        ↓
Choose minimum edge leaving MST
        ↓
Add new vertex
        ↓
Choose minimum connecting edge
        ↓
Repeat until V-1 edges
```

### Data Structure

Usually:

$$
\boxed{\text{Min-Heap / Priority Queue}}
$$

---

# 6. Kruskal vs Prim

| Feature         | Kruskal                     | Prim                               |
| --------------- | --------------------------- | ---------------------------------- |
| Approach        | Edge-based                  | Vertex-based                       |
| Starts with     | No specific vertex required | A starting vertex                  |
| Main DS         | Union-Find                  | Min-Heap                           |
| Sort edges      | Yes                         | Not necessarily                    |
| Good for        | Sparse graphs               | Often dense graphs                 |
| Cycle detection | DSU                         | Visited set / cut                  |
| Greedy choice   | Smallest safe edge globally | Smallest edge leaving current tree |

### Easy memory trick 🧠

> **Kruskal → Keep smallest edges**

> **Prim → Grow the tree**

---

# 7. MST Complexity

### Kruskal

Sorting edges:

$$
O(E\log E)
$$

Union-Find operations are almost linear.

Therefore:

$$
\boxed{O(E\log E)}
$$

Since:

$$
E\le V^2
$$

often written as:

$$
O(E\log V)
$$

---

### Prim with Binary Heap + Adjacency List

$$
\boxed{O(E\log V)}
$$

---

### Prim with Adjacency Matrix

$$
\boxed{O(V^2)}
$$

This is an important GATE comparison.

---

# 8. Cut Property 🔥🔥🔥

One of the most important MST properties.

> The **minimum-weight edge crossing a cut** is a safe edge for an MST.

Suppose vertices are divided into two sets:

```text
Set A        Set B

 A B          C D
 |            |
 └──── edge ──┘
```

If an edge is the minimum-weight edge crossing that cut, it can be safely selected for an MST.

### GATE wording

**Light edge across a cut → safe for MST**

---

# 9. Cycle Property 🔥

Consider a cycle.

If an edge is the **maximum-weight edge in that cycle**, it can be excluded from an MST.

If it is the **unique maximum-weight edge**, it cannot belong to any MST.

Example:

```text
       2
   A ------- B
   |         |
  5|         |3
   |         |
   C ------- D
       1
```

The edge of weight `5` is the heaviest in the cycle.

Therefore it can be excluded from an MST.

---

# 10. Unique MST

### Very important GATE fact:

If **all edge weights are distinct**:

$$
\boxed{\text{MST is unique}}
$$

But the reverse is NOT necessarily true.

Repeated edge weights do **not** automatically mean multiple MSTs.

---

# 11. Negative Edge Weights

MST algorithms can work with negative edge weights.

For example:

```text
A --(-5)-- B
```

Negative edge weights are **not a problem for MST**.

This is different from Dijkstra.

### Remember:

```text
MST → Negative weights are okay
Dijkstra → Negative weights are NOT okay
```

---

# GATE TRICKS 🧠🔥

### Trick 1

For `V` vertices:

$$
\boxed{MST\ edges=V-1}
$$

---

### Trick 2

If a candidate set has `V` vertices and `V-1` edges:

It is a tree **only if it is connected**.

---

### Trick 3

Kruskal:

$$
\boxed{\text{Sort edges + DSU}}
$$

Prim:

$$
\boxed{\text{Grow tree + minimum connecting edge}}
$$

---

### Trick 4

Distinct edge weights:

$$
\boxed{\text{Unique MST}}
$$

---

### Trick 5

MST does **not** mean:

> shortest path from a source.

MST minimizes:

$$
\boxed{\text{total weight of the tree}}
$$

It does **not** minimize the distance from one particular source to every vertex.

---

### Trick 6 🔥

Do NOT confuse:

**MST**

with

**Shortest Path Tree**

They solve different problems.

---

# 12. MST vs Shortest Path Tree

| Property                      | MST                       | Shortest Path Tree                   |
| ----------------------------- | ------------------------- | ------------------------------------ |
| Goal                          | Minimum total tree weight | Shortest paths from source           |
| Source required               | ❌                         | ✅                                    |
| Algorithm                     | Prim/Kruskal              | Dijkstra/Bellman-Ford                |
| Number edges                  | V−1                       | V−1 for connected reachable vertices |
| Globally minimum total weight | ✅                         | ❌ necessarily                        |
| Negative edges                | Fine                      | Depends on algorithm                 |

---

# PYQ-STYLE QUESTIONS

## Q1. A connected graph has 20 vertices. How many edges does its MST contain?

$$
V-1=20-1
$$

### Answer

$$
\boxed{19}
$$

---

## Q2. Which data structure is primarily associated with Kruskal's algorithm?

A. Stack
B. Queue
C. Union-Find
D. Hash table

### Answer

$$
\boxed{C}
$$

Kruskal needs efficient cycle detection, for which **Disjoint Set Union** is used.

---

## Q3. Which algorithm is edge-based?

A. Prim
B. Kruskal
C. BFS
D. DFS

### Answer

$$
\boxed{B}
$$

Kruskal considers edges globally in increasing order.

---

## Q4. If all edge weights of a connected undirected graph are distinct, what can be concluded?

### Answer

$$
\boxed{\text{MST is unique}}
$$

---

## Q5. Can an MST contain a cycle?

### Answer

$$
\boxed{\text{No}}
$$

A spanning tree is acyclic.

---

## Q6. Does MST necessarily give shortest paths from a chosen source?

### Answer

$$
\boxed{\text{No}}
$$

MST minimizes **total tree weight**, not source-to-vertex distances.

---

## Q7. Consider a cycle containing edges of weights:

```text
2, 4, 7, 3
```

Which edge can safely be excluded from an MST?

### Answer

The maximum edge:

$$
\boxed{7}
$$

If `7` is uniquely the maximum, it cannot belong to any MST.

---

## Q8. A cut has crossing edges with weights:

```text
4, 9, 3, 7
```

Which edge is safe according to the cut property?

### Answer

$$
\boxed{3}
$$

The minimum-weight edge crossing the cut is safe.

---

## Q9. Which complexity is associated with Prim using an adjacency matrix?

A. O(E log V)
B. O(V²)
C. O(V+E)
D. O(log V)

### Answer

$$
\boxed{O(V^2)}
$$

---

## Q10. Can MST algorithms handle negative edge weights?

### Answer

**Yes.**

MST algorithms such as Kruskal and Prim do not require edge weights to be non-negative.

---

# EXAM QUICK REVISION ⚡

```text
MST
 ↓
Connected + Acyclic
 ↓
All V vertices
 ↓
Exactly V-1 edges
 ↓
Minimum total weight
```

### Kruskal

```text
Sort edges
     ↓
Smallest edge
     ↓
Cycle?
     ↓
No → Add
Yes → Skip
     ↓
DSU
```

### Prim

```text
Start vertex
     ↓
Minimum edge leaving tree
     ↓
Add vertex
     ↓
Repeat
```

---

# GATE MUST-MEMORIZE TABLE 🔥

| Concept                  | Must Remember                 |
| ------------------------ | ----------------------------- |
| MST edges                | V−1                           |
| MST cycles               | None                          |
| MST vertices             | All V                         |
| Kruskal                  | Edge-based                    |
| Kruskal DS               | Union-Find                    |
| Kruskal complexity       | O(E log E)                    |
| Prim                     | Vertex-based                  |
| Prim DS                  | Min-Heap                      |
| Prim + heap              | O(E log V)                    |
| Prim + matrix            | O(V²)                         |
| Distinct weights         | Unique MST                    |
| Cut property             | Minimum crossing edge is safe |
| Cycle property           | Maximum edge can be excluded  |
| Negative MST weights     | Allowed                       |
| MST = shortest path tree | ❌                             |

# 🎯 GATE PRIORITY

⭐⭐⭐⭐⭐ **Kruskal**

⭐⭐⭐⭐⭐ **Prim**

⭐⭐⭐⭐⭐ **Cut & Cycle properties**

⭐⭐⭐⭐⭐ **MST vs shortest path**

⭐⭐⭐⭐⭐ **V−1 edges**

⭐⭐⭐⭐ **Unique MST**

⭐⭐⭐⭐ **MST complexity**

### One-line GATE memory

> **Kruskal = globally smallest safe edge + DSU; Prim = grow from a vertex using the smallest connecting edge.**
