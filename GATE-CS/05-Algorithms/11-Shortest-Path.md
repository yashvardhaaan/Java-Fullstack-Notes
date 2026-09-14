# 11 — SHORTEST PATH ALGORITHMS

## THEORY

The **shortest path problem** asks for a path between vertices whose total edge weight is minimum.

For a path:

$$
u\rightarrow v\rightarrow w
$$

total cost:

$$
w(u,v)+w(v,w)
$$

There are four major cases you should know for GATE:

| Graph / Condition            | Algorithm                           |
| ---------------------------- | ----------------------------------- |
| Unweighted graph             | **BFS**                             |
| Weighted, non-negative edges | **Dijkstra**                        |
| Negative edges allowed       | **Bellman-Ford**                    |
| All-pairs shortest path      | **Floyd-Warshall**                  |
| DAG                          | **Topological-order shortest path** |

---

# 1. BFS FOR SHORTEST PATH

For an **unweighted graph**, every edge effectively has equal cost.

Therefore:

$$
\boxed{\text{BFS gives shortest path}}
$$

Example:

```text
A — B — D
|       |
C — E — F
```

Starting from A, BFS explores:

```text
Distance 0 → A
Distance 1 → B,C
Distance 2 → D,E
Distance 3 → F
```

So:

$$
dist(A,F)=3
$$

### Complexity

Adjacency list:

$$
\boxed{O(V+E)}
$$

---

# 2. DIJKSTRA'S ALGORITHM 🔥🔥🔥

Dijkstra finds **single-source shortest paths** when:

$$
\boxed{\text{All edge weights are non-negative}}
$$

Example:

```text
A --4-- B
|       |
1       2
|       |
C --5-- D
```

Starting from A, Dijkstra repeatedly chooses the currently closest unprocessed vertex.

---

## Dijkstra's Main Idea

Maintain:

$$
dist[v]
$$

= current best known distance from source to `v`.

Initially:

```text
source = 0
others = ∞
```

Then repeatedly:

1. Choose unvisited vertex with minimum `dist`.
2. Mark it finalized.
3. Relax all outgoing edges.

---

# 3. RELAXATION 🔥

This is extremely important.

For edge:

$$
u\rightarrow v
$$

with weight `w`:

$$
\boxed{dist[v]=\min(dist[v],dist[u]+w)}
$$

This operation is called **relaxation**.

Example:

```text
dist[A] = 5

A --3--> B
```

Then:

$$
dist[B]=\min(dist[B],5+3)
$$

So:

$$
dist[B]=8
$$

if 8 is better than its previous value.

---

# 4. Why Dijkstra Fails with Negative Edges

Dijkstra permanently finalizes the currently minimum-distance vertex.

That assumption fails when negative edges exist.

Example:

```text
A ----2---- B
 \          |
  5         -10
   \        |
    ------ C
```

A vertex that looked finalized can later receive a smaller distance through a negative edge.

Therefore:

$$
\boxed{\text{Dijkstra requires non-negative edge weights}}
$$

---

# 5. DIJKSTRA COMPLEXITY

### Adjacency Matrix

$$
\boxed{O(V^2)}
$$

### Binary Heap + Adjacency List

$$
\boxed{O((V+E)\log V)}
$$

For a connected graph where \(E\ge V-1\), commonly written:

$$
\boxed{O(E\log V)}
$$

---

# 6. BELLMAN-FORD ALGORITHM 🔥🔥🔥

Bellman-Ford solves:

> **Single-source shortest paths with negative edge weights.**

It can also detect a **negative-weight cycle reachable from the source**.

---

## Main Idea

Relax **every edge** repeatedly.

For a graph with `V` vertices:

$$
\boxed{V-1\text{ passes}}
$$

are sufficient if there is no reachable negative cycle.

Why?

A simple shortest path can contain at most:

$$
V-1
$$

edges.

---

# 7. Bellman-Ford Algorithm

```text
Initialize:
dist[source] = 0
dist[others] = ∞

Repeat V-1 times:
    for every edge (u,v,w):
        relax(u,v,w)
```

Then perform **one additional pass**.

If any distance can still be reduced:

$$
\boxed{\text{Negative cycle exists}}
$$

reachable from the source.

---

# 8. Bellman-Ford Complexity

There are:

$$
V-1
$$

passes.

Each pass examines:

$$
E
$$

edges.

Therefore:

$$
\boxed{O(VE)}
$$

This is slower than Dijkstra, but handles negative edges.

---

# 9. FLOYD-WARSHALL 🔥🔥

Floyd-Warshall finds:

$$
\boxed{\text{All-pairs shortest paths}}
$$

That means shortest paths between **every pair** of vertices.

It is a **dynamic programming** algorithm.

---

## Recurrence

Let:

$$
D^{(k)}[i][j]
$$

represent the shortest distance from `i` to `j` using only the first `k` vertices as intermediate vertices.

Then:

$$
\boxed{
D[i][j]
=
\min(D[i][j],D[i][k]+D[k][j])
}
$$

---

## Complexity

Three nested loops:

$$
\boxed{O(V^3)}
$$

Space:

$$
\boxed{O(V^2)}
$$

---

# 10. Negative Edges in Floyd-Warshall

Floyd-Warshall can handle negative edge weights.

But a negative cycle causes shortest paths to be undefined.

### Detect negative cycle

After Floyd-Warshall:

$$
\boxed{D[i][i]<0}
$$

for some vertex `i` indicates a negative cycle.

---

# 11. DAG SHORTEST PATH

For a **DAG**, shortest paths can be found efficiently using topological ordering.

### Steps

1. Find topological ordering.
2. Process vertices in topological order.
3. Relax outgoing edges.

Complexity:

$$
\boxed{O(V+E)}
$$

This can handle **negative edge weights**, because a DAG cannot contain a cycle.

---

# 12. SINGLE SOURCE vs ALL PAIRS

### Single Source Shortest Path — SSSP

One source → all vertices.

Algorithms:

```text
BFS
Dijkstra
Bellman-Ford
DAG shortest path
```

### All Pairs Shortest Path — APSP

Every vertex → every other vertex.

Common algorithm:

```text
Floyd-Warshall
```

---

# GATE TRICKS 🧠🔥

## Trick 1 — Algorithm Selection

Memorize this:

```text
Unweighted
   ↓
BFS

Non-negative weighted
   ↓
Dijkstra

Negative weights
   ↓
Bellman-Ford

All pairs
   ↓
Floyd-Warshall
```

---

## Trick 2 — Negative Cycle

Bellman-Ford:

$$
\boxed{\text{Extra relaxation after V−1 passes}}
$$

If improvement occurs:

$$
\boxed{\text{Negative cycle}}
$$

---

## Trick 3 — Floyd-Warshall

After execution:

$$
D[i][i]<0
$$

means:

$$
\boxed{\text{Negative cycle}}
$$

---

## Trick 4 — Don't confuse MST

MST:

$$
\text{minimum total weight}
$$

Shortest path:

$$
\text{minimum path weight}
$$

They are **not the same problem**.

---

## Trick 5 🔥

Dijkstra's greedy choice works because edge weights are non-negative.

If negative edges appear:

$$
\boxed{\text{Dijkstra is unsafe}}
$$

---

## Trick 6

BFS is essentially shortest path when:

$$
\boxed{\text{all edges have equal weight}}
$$

---

## Trick 7

A shortest path without a negative cycle can be assumed to be **simple**, so it contains at most:

$$
\boxed{V-1\text{ edges}}
$$

---

# PYQ-STYLE QUESTIONS

## Q1. Which algorithm should be used for an unweighted graph?

A. Dijkstra
B. Bellman-Ford
C. BFS
D. Floyd-Warshall

### Answer

$$
\boxed{C}
$$

BFS minimizes the number of edges.

---

# Q2. Which algorithm can handle negative edge weights?

A. BFS
B. Dijkstra
C. Bellman-Ford
D. Prim

### Answer

$$
\boxed{C}
$$

Bellman-Ford handles negative edges.

---

# Q3. Which algorithm is suitable for all-pairs shortest paths?

### Answer

$$
\boxed{\text{Floyd-Warshall}}
$$

Complexity:

$$
O(V^3)
$$

---

# Q4. Bellman-Ford runs for V−1 iterations. Why?

A simple shortest path can contain at most:

$$
\boxed{V-1}
$$

edges.

Each iteration can propagate shortest-path information one more edge along a path.

---

# Q5. After V−1 Bellman-Ford iterations, an edge can still be relaxed. What does that imply?

### Answer

$$
\boxed{\text{A reachable negative-weight cycle exists}}
$$

---

# Q6. Suppose a graph has 100 vertices and is unweighted. Which algorithm is preferable for single-source shortest path?

### Answer

$$
\boxed{BFS}
$$

With adjacency lists:

$$
O(V+E)
$$

---

# Q7. Can Dijkstra work if the graph contains an edge with weight −2?

### Answer

In general:

$$
\boxed{\text{No}}
$$

Dijkstra requires non-negative edge weights.

---

# Q8. In Floyd-Warshall, after completion, `D[5][5] = -3`. What does this indicate?

### Answer

$$
\boxed{\text{A negative cycle exists}}
$$

because a negative diagonal value indicates a negative cycle.

---

# Q9. What is the complexity of Floyd-Warshall?

Three nested loops over `V`:

$$
\boxed{O(V^3)}
$$

Space:

$$
\boxed{O(V^2)}
$$

---

# Q10. A DAG has V vertices and E edges. What is the shortest-path complexity using topological ordering?

### Answer

$$
\boxed{O(V+E)}
$$

---

# SHORTEST PATH vs MST 🔥

This is a **very common GATE confusion**.

Suppose:

```text
       1
A -------- B
|          |
4          2
|          |
C -------- D
       1
```

### MST asks:

> What connected tree has minimum **total edge weight**?

### Shortest path asks:

> What path from source A to destination D has minimum **path weight**?

These can produce completely different structures.

---

# EXAM QUICK REVISION ⚡

```text
BFS
→ Unweighted
→ O(V+E)
```

```text
Dijkstra
→ Non-negative weights
→ Greedy
→ O(E log V) with heap
```

```text
Bellman-Ford
→ Negative edges
→ Negative-cycle detection
→ O(VE)
```

```text
Floyd-Warshall
→ All pairs
→ DP
→ O(V³)
→ O(V²) space
```

```text
DAG
→ Topological order
→ O(V+E)
→ Negative edges allowed
```

---

# GATE MUST-MEMORIZE TABLE 🔥

| Algorithm         | Problem          | Negative Edge | Negative Cycle Detection | Complexity  |
| ----------------- | ---------------- | ------------- | ------------------------ | ----------- |
| BFS               | SSSP, unweighted | ❌             | ❌                        | O(V+E)      |
| Dijkstra          | SSSP             | ❌             | ❌                        | O(E log V)* |
| Bellman-Ford      | SSSP             | ✅             | ✅                        | O(VE)       |
| Floyd-Warshall    | APSP             | ✅             | ✅                        | O(V³)       |
| DAG shortest path | SSSP             | ✅             | Not needed               | O(V+E)      |

*Using adjacency list + binary heap.

# 🎯 GATE PRIORITY

⭐⭐⭐⭐⭐ **Dijkstra**

⭐⭐⭐⭐⭐ **Bellman-Ford**

⭐⭐⭐⭐⭐ **Floyd-Warshall**

⭐⭐⭐⭐⭐ **Negative cycle**

⭐⭐⭐⭐⭐ **Relaxation**

⭐⭐⭐⭐ **BFS shortest path**

⭐⭐⭐⭐ **MST vs shortest path**

### One-line memory

> **BFS → unweighted, Dijkstra → non-negative, Bellman-Ford → negative edges, Floyd-Warshall → all pairs.**
