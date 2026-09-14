# 09 — GRAPH TRAVERSAL

## THEORY

Graph traversal means systematically visiting **all reachable vertices** of a graph.

The two fundamental traversal techniques are:

1. **BFS — Breadth First Search**
2. **DFS — Depth First Search**

---

# 1. BFS — Breadth First Search

BFS visits vertices **level by level**.

### Data Structure

**Queue (FIFO)**

```text
Start
  ↓
Visit all immediate neighbors
  ↓
Visit neighbors of those vertices
  ↓
Continue level by level
```

### Algorithm

```text
BFS(G, s):

1. Mark s as visited
2. Insert s into Queue
3. While Queue is not empty:
      u = Dequeue()
      for every neighbor v of u:
          if v is not visited:
              mark v visited
              enqueue v
```

### Complexity

For **adjacency list**:

$$
O(V+E)
$$

For **adjacency matrix**:

$$
O(V^2)
$$

Space:

$$
O(V)
$$

for the visited array + queue.

---

# 2. BFS and Shortest Path

One of the **most important GATE concepts**:

> BFS gives the shortest path in terms of **number of edges** in an **unweighted graph**.

Example:

```text
A ─ B ─ D
│
C ─ E ─ F
```

Starting from A:

```text
Level 0: A
Level 1: B, C
Level 2: D, E
Level 3: F
```

Therefore:

```text
distance(A,F) = 3
```

### Important

BFS does **NOT** guarantee shortest path when edges have arbitrary weights.

For non-negative weighted graphs, use **Dijkstra**.

---

# 3. DFS — Depth First Search

DFS goes **as deep as possible** before backtracking.

### Data Structure

DFS can be implemented using:

* **Stack**
* **Recursion**

```text
Start
 ↓
Go deeper
 ↓
Go deeper
 ↓
No unvisited neighbor
 ↓
Backtrack
```

### Recursive Algorithm

```text
DFS(u):

    mark u visited

    for every neighbor v of u:
        if v is not visited:
            DFS(v)
```

### Complexity

Adjacency list:

$$
O(V+E)
$$

Adjacency matrix:

$$
O(V^2)
$$

Auxiliary space:

$$
O(V)
$$

because of visited array + recursion/stack.

---

# 4. BFS vs DFS

| Feature                           | BFS                      | DFS                               |
| --------------------------------- | ------------------------ | --------------------------------- |
| Main DS                           | Queue                    | Stack / Recursion                 |
| Strategy                          | Level-wise               | Depth-wise                        |
| Shortest path in unweighted graph | ✅                        | ❌                                 |
| Complexity                        | O(V+E)                   | O(V+E)                            |
| Space                             | O(V)                     | O(V)                              |
| Useful for                        | Shortest path, levels    | Cycle detection, topological sort |
| Backtracking                      | No explicit backtracking | Yes                               |

---

# 5. Graph Representation

## Adjacency Matrix

For `V` vertices:

$$
V\times V
$$

Space:

$$
O(V^2)
$$

Checking whether edge `(u,v)` exists:

$$
O(1)
$$

---

## Adjacency List

Stores only existing edges.

Space:

$$
O(V+E)
$$

For sparse graphs, adjacency lists are usually better.

---

# 6. BFS Traversal Order

Suppose:

```text
      A
     / \
    B   C
   / \   \
  D   E   F
```

Starting from A:

```text
BFS = A B C D E F
```

because:

```text
Level 0 → A
Level 1 → B C
Level 2 → D E F
```

### GATE Trap ⚠️

Traversal order is **not always unique**.

If A has neighbors B and C, processing B first gives one order, while processing C first may give another.

So:

> **Adjacency ordering can change BFS/DFS traversal order.**

---

# 7. BFS Tree

When BFS discovers an unvisited vertex, the edge used to discover it becomes part of the **BFS tree**.

For a connected graph:

$$
\text{BFS tree has } V-1 \text{ edges}
$$

The BFS tree represents shortest-path distances from the source in terms of edges.

---

# 8. DFS Tree

DFS also produces a spanning tree for a connected graph.

For a connected graph:

$$
V-1 \text{ tree edges}
$$

DFS is particularly important for:

* Cycle detection
* Topological sorting
* Connected components
* Strongly connected components
* Articulation points
* Bridges

---

# 9. BFS for Connected Components

If the graph is disconnected, one BFS from a single source does **not** visit the entire graph.

Use:

```text
for every vertex v:
    if v is unvisited:
        BFS(v)
```

Number of BFS/DFS starts = number of connected components.

### Example

```text
A — B — C       D — E       F
```

There are:

$$
3
$$

connected components.

---

# 10. DFS and Cycle Detection

### Undirected Graph

During DFS, if we find an already visited vertex that is **not the parent**, a cycle exists.

```text
if visited[v] and v != parent:
       cycle exists
```

### Directed Graph

Use the concept of **recursion stack / colors**.

If DFS encounters a vertex currently in the recursion stack:

```text
back edge → cycle
```

---

# 11. DFS and Topological Sort

Topological sorting is applicable to a:

> **Directed Acyclic Graph (DAG)**

Using DFS:

1. Perform DFS.
2. After completely processing a vertex, push it onto a stack.
3. Reverse stack gives topological ordering.

### Important

A graph has a topological ordering **iff it is a DAG**.

A directed cycle means:

$$
\boxed{\text{No topological ordering}}
$$

---

# GATE TRICKS 🧠🔥

### Trick 1

```text
BFS → Queue
DFS → Stack
```

Memorize:

> **BFS = Breadth = Queue**

> **DFS = Depth = Stack**

---

### Trick 2

Shortest path in **unweighted graph**:

$$
\boxed{BFS}
$$

---

### Trick 3

Weighted graph:

```text
Unweighted → BFS
Non-negative weights → Dijkstra
Negative weights → Bellman-Ford
```

---

### Trick 4

Adjacency list traversal:

$$
\boxed{O(V+E)}
$$

Adjacency matrix traversal:

$$
\boxed{O(V^2)}
$$

---

### Trick 5

A connected graph with V vertices has:

$$
\boxed{V-1}
$$

edges in its BFS/DFS spanning tree.

---

### Trick 6

Disconnected graph?

Run BFS/DFS from every unvisited vertex.

---

### Trick 7

Topological sorting:

$$
\boxed{\text{DAG only}}
$$

---

### Trick 8 🔥

BFS distance:

$$
dist[v]=dist[u]+1
$$

when `v` is first discovered from `u`.

Therefore BFS naturally computes shortest distance in an unweighted graph.

---

# PYQ-STYLE QUESTIONS

## Q1. Which data structure is primarily used by BFS?

A. Stack
B. Queue
C. Heap
D. Priority Queue

### Answer

$$
\boxed{B}
$$

BFS uses a **FIFO queue**.

---

## Q2. BFS is used to find shortest path in:

A. Any weighted graph
B. Unweighted graph
C. Graph with negative edges
D. Any graph

### Answer

$$
\boxed{B}
$$

BFS minimizes the **number of edges**, not total weighted cost.

---

## Q3. A graph has V vertices and E edges. What is BFS complexity using adjacency list?

### Answer

$$
\boxed{O(V+E)}
$$

Every vertex is visited at most once and every adjacency-list edge is examined a constant number of times.

---

## Q4. What is the space required by an adjacency matrix?

### Answer

$$
\boxed{O(V^2)}
$$

because it stores:

$$
V\times V
$$

entries.

---

## Q5. A connected graph has 10 vertices. How many edges will its BFS tree contain?

A. 9
B. 10
C. 45
D. Depends on graph

### Answer

$$
\boxed{9}
$$

Every spanning tree of a connected graph has:

$$
V-1
$$

edges.

---

## Q6. Consider:

```text
A — B
|   |
C — D
```

Starting BFS from A, is the traversal necessarily unique?

### Answer

**No.**

If neighbors are processed in different orders, different valid BFS orders can occur.

The **BFS levels/distances** remain the same.

---

## Q7. Which algorithm is suitable for shortest path in an unweighted graph?

### Answer

$$
\boxed{BFS}
$$

Because every edge has equal cost.

---

## Q8. Can DFS be used to find connected components?

### Answer

**Yes.**

Run DFS from every unvisited vertex.

Each DFS traversal identifies one connected component.

---

## Q9. A directed graph contains a cycle. Can it have a topological ordering?

### Answer

$$
\boxed{\text{No}}
$$

Topological ordering exists only for a DAG.

---

## Q10. If DFS recursion reaches an already visited vertex in a directed graph that is currently in the recursion stack, what does it indicate?

### Answer

$$
\boxed{\text{Cycle}}
$$

It indicates a **back edge**.

---

# EXAM QUICK REVISION ⚡

```text
BFS
 ↓
Queue
 ↓
Level order
 ↓
Shortest path in unweighted graph
```

```text
DFS
 ↓
Stack / Recursion
 ↓
Depth first
 ↓
Backtracking
 ↓
Cycle / Topological / SCC etc.
```

### Complexity

| Representation   |    BFS |    DFS |
| ---------------- | -----: | -----: |
| Adjacency List   | O(V+E) | O(V+E) |
| Adjacency Matrix |  O(V²) |  O(V²) |

### Space

| Structure        |  Space |
| ---------------- | -----: |
| Adjacency Matrix |  O(V²) |
| Adjacency List   | O(V+E) |
| BFS queue        |   O(V) |
| DFS stack        |   O(V) |

---

# GATE MUST-MEMORIZE TABLE 🔥

| Concept                             | Answer               |
| ----------------------------------- | -------------------- |
| BFS DS                              | Queue                |
| DFS DS                              | Stack/Recursion      |
| BFS shortest path                   | Unweighted graph     |
| BFS list complexity                 | O(V+E)               |
| DFS list complexity                 | O(V+E)               |
| Matrix complexity                   | O(V²)                |
| BFS space                           | O(V)                 |
| DFS space                           | O(V)                 |
| Connected spanning tree edges       | V−1                  |
| Topological sorting                 | DAG                  |
| Directed cycle                      | No topological order |
| Negative weights                    | Bellman-Ford         |
| Non-negative weighted shortest path | Dijkstra             |
| Unweighted shortest path            | BFS                  |

# 🎯 GATE PRIORITY

⭐⭐⭐⭐⭐ **BFS shortest path**

⭐⭐⭐⭐⭐ **BFS/DFS complexity**

⭐⭐⭐⭐⭐ **Queue vs Stack**

⭐⭐⭐⭐⭐ **Adjacency matrix vs list**

⭐⭐⭐⭐ **Connected components**

⭐⭐⭐⭐ **DFS cycle detection**

⭐⭐⭐⭐ **Topological sorting**

⭐⭐⭐ **BFS/DFS traversal order**

**Most important GATE trap:**

> **BFS gives shortest path only when edge costs are equal (typically unweighted graph). DFS does not generally give shortest paths.**
