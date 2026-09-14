````md
# 08 — Graphs.md

# Graphs — GATE CSE Notes, Tricks & PYQ Patterns

---

# 1. What is a Graph?

A **graph** is a data structure consisting of:

\[
G=(V,E)
\]

where:

- `V` = set of vertices/nodes
- `E` = set of edges

Example:

```text
        A
       / \
      B---C
       \ /
        D
````

Vertices:

```text
V = {A,B,C,D}
```

Edges:

```text
E = {(A,B),(A,C),(B,C),(B,D),(C,D)}
```

---

# 2. Types of Graphs

```text
Graph
│
├── Undirected
│
├── Directed
│
├── Weighted
│
├── Unweighted
│
├── Connected
│
├── Disconnected
│
├── Simple
│
├── Multigraph
│
├── Complete
│
├── Bipartite
│
└── DAG
```

---

# 3. Undirected Graph

An edge has no direction.

```text
A ----- B
```

means:

```text
A connected to B
B connected to A
```

The edge:

$$
(A,B)
$$

is equivalent to:

$$
(B,A)
$$

---

# 4. Directed Graph

A directed edge has a direction.

```text
A -----> B
```

means:

```text
A → B
```

but it does NOT necessarily mean:

```text
B → A
```

Example:

```text
A → B → C
```

---

# 5. Weighted Graph

Edges have associated weights/costs.

```text
A --5-- B
 \      /
  2    3
   \  /
     C
```

For example:

```text
A → B = 5
A → C = 2
C → B = 3
```

Weighted graphs appear heavily in:

* Dijkstra
* Bellman-Ford
* Floyd-Warshall
* Prim
* Kruskal

---

# 6. Simple Graph

A simple graph generally has:

* No self-loop
* No multiple/parallel edges between the same pair of vertices

Example:

```text
A ----- B
```

Allowed.

But:

```text
A ---- A
```

is a self-loop.

Not allowed in a simple graph.

---

# 7. Self Loop

An edge from a vertex to itself.

```text
     ┌───┐
     ↓   │
     A───┘
```

For an undirected graph, a self-loop contributes **2 to the degree** of a vertex.

This is an important GATE trap.

---

# 8. Degree of a Vertex

For an undirected graph:

$$
deg(v)=\text{number of edges incident on }v
$$

Example:

```text
A ----- B
| \     |
|  \    |
|   \   |
C ----- D
```

If A is connected to B, C and D:

$$
deg(A)=3
$$

---

# 9. Handshaking Lemma

For every undirected graph:

$$
\boxed{\sum_{v\in V}deg(v)=2|E|}
$$

This is one of the **most important GATE formulas**.

Why?

Every edge contributes 2 to the total degree.

---

# 10. GATE Trick — Sum of Degrees

Suppose:

```text
Number of edges = 20
```

Then:

$$
\sum deg(v)=2(20)=40
$$

Therefore:

```text
Total degree = 40
```

---

# 11. Number of Odd-Degree Vertices

In every undirected graph:

$$
\boxed{\text{Number of odd-degree vertices is even}}
$$

Possible:

```text
0
2
4
6
...
```

Impossible:

```text
1
3
5
...
```

### GATE Shortcut

If an option contains an odd number of odd-degree vertices:

```text
Immediately eliminate it.
```

---

# 12. Maximum Degree in Simple Undirected Graph

For `n` vertices:

$$
\boxed{deg(v)\le n-1}
$$

because a vertex cannot connect to itself and there is at most one edge to every other vertex.

---

# 13. Maximum Number of Edges in Simple Undirected Graph

For `n` vertices:

$$
\boxed{E_{\max}=\frac{n(n-1)}{2}}
$$

Because every pair of vertices can have at most one edge.

Example:

```text
n = 5
```

$$
E_{\max}=\frac{5(4)}{2}=10
$$

---

# 14. Complete Graph

A graph in which every pair of distinct vertices is connected.

Notation:

$$
K_n
$$

Number of edges:

$$
\boxed{|E|=\frac{n(n-1)}{2}}
$$

Degree of every vertex:

$$
\boxed{n-1}
$$

---

# 15. Complete Graph Example

For:

$$
K_4
$$

```text
      A
     /|\
    / | \
   B--|--C
    \ | /
     \|/
      D
```

Number of edges:

$$
\frac{4(3)}{2}=6
$$

Every vertex has degree:

$$
3
$$

---

# 16. Directed Graph Degree

For directed graphs, distinguish:

### In-degree

Number of incoming edges.

### Out-degree

Number of outgoing edges.

Example:

```text
A → B → C
    ↑
    D
```

For B:

```text
in-degree  = 2
out-degree = 1
```

---

# 17. Directed Graph Degree Formula

For a directed graph:

$$
\boxed{\sum indegree(v)=|E|}
$$

and:

$$
\boxed{\sum outdegree(v)=|E|}
$$

Therefore:

$$
\boxed{\sum indegree(v)+\sum outdegree(v)=2|E|}
$$

---

# 18. Adjacency Matrix

For a graph with `n` vertices, adjacency matrix is:

$$
n\times n
$$

Example:

```text
A -- B
|    |
C -- D
```

Matrix:

```text
      A B C D
A     0 1 1 0
B     1 0 0 1
C     1 0 0 1
D     0 1 1 0
```

---

# 19. Adjacency Matrix Properties

For an undirected graph:

$$
\boxed{A=A^T}
$$

Therefore, the adjacency matrix is **symmetric**.

### GATE Trap

Directed graph adjacency matrix need not be symmetric.

---

# 20. Space Complexity of Adjacency Matrix

For `V` vertices:

$$
\boxed{O(V^2)}
$$

Regardless of whether the graph has few edges.

This makes adjacency matrices inefficient for sparse graphs.

---

# 21. Adjacency List

Each vertex stores its neighboring vertices.

Example:

```text
A -- B
|    |
C -- D
```

Adjacency list:

```text
A → B, C
B → A, D
C → A, D
D → B, C
```

---

# 22. Space Complexity of Adjacency List

For a graph with `V` vertices and `E` edges:

$$
\boxed{O(V+E)}
$$

This is usually better for sparse graphs.

---

# 23. Graph Representation Comparison

| Representation   |  Space |   Check edge |
| ---------------- | -----: | -----------: |
| Adjacency Matrix |  O(V²) |         O(1) |
| Adjacency List   | O(V+E) | O(degree(v)) |
| Edge List        |   O(E) |         O(E) |

### GATE Rule

```text
Dense graph → Matrix often useful
Sparse graph → Adjacency list preferred
```

---

# 24. BFS

BFS = **Breadth First Search**

It explores a graph level by level.

Uses:

$$
\boxed{\text{Queue}}
$$

Example:

```text
       A
      / \
     B   C
    / \   \
   D   E   F
```

BFS from A:

```text
A
B C
D E F
```

Traversal:

```text
A B C D E F
```

---

# 25. BFS Algorithm

```text
BFS(G, source):

1. Mark source visited.
2. Insert source into queue.

3. While queue is not empty:
      u = dequeue()

      for every neighbor v of u:
          if v is not visited:
              mark v visited
              enqueue(v)
```

---

# 26. BFS Complexity

Using adjacency list:

$$
\boxed{O(V+E)}
$$

Using adjacency matrix:

$$
\boxed{O(V^2)}
$$

### GATE Trap

Do not automatically answer `O(V+E)` without considering the representation.

---

# 27. BFS Applications

BFS is useful for:

```text
1. Shortest path in unweighted graph
2. Level-order traversal
3. Connected components
4. Bipartite graph testing
5. Finding minimum number of edges
```

---

# 28. BFS Shortest Path

For an **unweighted graph**, BFS gives the shortest path in terms of number of edges.

Example:

```text
A -- B -- C -- D
 \          /
  ---- E ---
```

BFS from A determines minimum edge distance from A to every reachable vertex.

### Important

BFS is NOT generally the correct shortest-path algorithm for arbitrary weighted graphs.

---

# 29. DFS

DFS = **Depth First Search**

It explores as deeply as possible before backtracking.

Uses:

```text
Stack
```

or:

```text
Recursion
```

Example:

```text
       A
      / \
     B   C
    / \
   D   E
```

One possible DFS:

```text
A B D E C
```

The exact order depends on neighbor ordering.

---

# 30. DFS Algorithm

```text
DFS(u):

1. Mark u visited.

2. For every neighbor v of u:
      if v is not visited:
          DFS(v)
```

---

# 31. DFS Complexity

Using adjacency list:

$$
\boxed{O(V+E)}
$$

Using adjacency matrix:

$$
\boxed{O(V^2)}
$$

---

# 32. BFS vs DFS

| Feature                  | BFS          | DFS             |
| ------------------------ | ------------ | --------------- |
| Main data structure      | Queue        | Stack/Recursion |
| Level-wise               | Yes          | No              |
| Unweighted shortest path | Yes          | No              |
| Cycle detection          | Yes          | Yes             |
| Topological sort         | Not standard | Yes             |
| Connected components     | Yes          | Yes             |
| Bipartite testing        | Yes          | Yes             |

---

# 33. Connected Graph

An undirected graph is connected if there is a path between every pair of vertices.

Example:

```text
A --- B --- C
      |
      D
```

All vertices are reachable.

Therefore:

```text
Connected
```

---

# 34. Disconnected Graph

Example:

```text
A --- B       C --- D
```

There is no path from A to C.

Therefore graph is disconnected.

---

# 35. Connected Components

A disconnected graph can be divided into connected components.

Example:

```text
A --- B       C --- D --- E       F
```

Components:

```text
{A,B}
{C,D,E}
{F}
```

Total:

$$
\boxed{3}
$$

---

# 36. Finding Connected Components

Run DFS/BFS from every unvisited vertex.

```text
count = 0

for every vertex v:
    if v not visited:
        DFS(v)
        count++
```

Complexity:

$$
\boxed{O(V+E)}
$$

with adjacency lists.

---

# 37. Path

A path is a sequence of vertices where consecutive vertices are connected by edges.

Example:

```text
A → B → C → D
```

Path:

```text
A-B-C-D
```

Length:

```text
3 edges
```

---

# 38. Simple Path

A simple path does not repeat vertices.

Example:

```text
A → B → C → D
```

is simple.

But:

```text
A → B → C → B → D
```

is not simple because B repeats.

---

# 39. Cycle

A cycle is a closed path.

Example:

```text
A --- B
|     |
|     |
D --- C
```

Cycle:

```text
A → B → C → D → A
```

---

# 40. Tree as a Graph

A tree is an undirected graph that is:

```text
Connected
+
Acyclic
```

For `V` vertices:

$$
\boxed{E=V-1}
$$

This is extremely important.

---

# 41. Tree Properties

For a tree:

```text
Connected
Acyclic
E = V - 1
Exactly one simple path between every pair of vertices
```

Any one of these suitable properties can characterize a tree.

---

# 42. GATE Tree Trick

If an undirected graph has:

```text
V = 20
E = 19
```

and is connected:

```text
It is a tree.
```

If:

```text
V = 20
E = 19
```

but graph is disconnected:

```text
It is NOT a tree.
```

---

# 43. Bipartite Graph

A graph is bipartite if its vertices can be divided into two sets such that no edge connects vertices within the same set.

Example:

```text
Set A          Set B

 A  ----------  X
 | \          / |
 |  \        /  |
 B  ----------  Y
```

All edges go between the two sets.

---

# 44. Bipartite Graph and Coloring

A graph is bipartite if it can be colored using:

$$
\boxed{2\text{ colors}}
$$

such that adjacent vertices have different colors.

BFS/DFS can test this.

---

# 45. Critical GATE Rule — Bipartite Graph

An undirected graph is bipartite **iff it contains no odd-length cycle**.

Therefore:

```text
Odd cycle
   ↓
Not bipartite
```

Examples:

```text
Triangle
A
|\
| \
B--C
```

has cycle length 3.

Therefore:

```text
NOT bipartite
```

---

# 46. Even Cycle

Example:

```text
A --- B
|     |
D --- C
```

Cycle length:

$$
4
$$

An even cycle can be bipartite.

---

# 47. DAG

DAG = **Directed Acyclic Graph**

It is:

```text
Directed
+
No directed cycle
```

Example:

```text
A → B → D
 \       ↑
  → C --- 
```

No directed cycle.

---

# 48. Topological Sorting

Topological ordering is possible only for a:

$$
\boxed{\text{DAG}}
$$

It is a linear ordering of vertices such that for every edge:

$$
u\rightarrow v
$$

`u` appears before `v`.

---

# 49. Example of Topological Sort

Suppose:

```text
A → C
B → C
C → D
```

Possible ordering:

```text
A B C D
```

Also:

```text
B A C D
```

Both are valid.

---

# 50. Important Topological Sort Trick

A DAG may have:

```text
Multiple valid topological orders.
```

Topological ordering is generally **not unique**.

If two vertices are independent, their relative order may change.

---

# 51. Kahn's Algorithm

Kahn's algorithm uses:

$$
\boxed{\text{In-degree}}
$$

Steps:

```text
1. Calculate indegree of every vertex.
2. Put all indegree-0 vertices into queue.
3. Remove one vertex.
4. Add it to topological order.
5. Reduce indegree of its outgoing neighbors.
6. If any becomes 0, insert it into queue.
7. Repeat.
```

If fewer than `V` vertices are processed:

```text
Directed cycle exists.
```

---

# 52. DFS Topological Sort

DFS can also produce topological ordering.

Basic idea:

```text
DFS(v)

visit v
DFS(all unvisited outgoing neighbors)
push v after all neighbors finish
```

Then reverse the finishing order.

---

# 53. Cycle Detection — Undirected Graph

DFS can detect cycles in an undirected graph.

During DFS, if we find a visited neighbor that is **not the parent**, then a cycle exists.

```text
if visited[v] && v != parent:
    cycle exists
```

---

# 54. Cycle Detection — Directed Graph

For directed graphs, DFS can use a recursion stack.

Maintain:

```text
visited
recursionStack
```

If an edge points to a vertex currently in the recursion stack:

```text
Back edge
   ↓
Directed cycle
```

---

# 55. Edge Classification in DFS

For directed graphs, DFS edges can be:

```text
Tree edge
Back edge
Forward edge
Cross edge
```

### Most important

```text
Back edge
   ↓
Cycle
```

in a directed graph.

---

# 56. Bridges

A bridge is an edge whose removal increases the number of connected components.

Example:

```text
A --- B --- C
          /
         D
```

If B-C is the only connection to the right-side component, removing it disconnects the graph.

Therefore:

```text
B-C = bridge
```

---

# 57. Articulation Point

An articulation point is a vertex whose removal increases the number of connected components.

Example:

```text
A --- B --- C
          \
           D
```

If B is the only connection between A and the rest:

```text
B
```

can be an articulation point.

---

# 58. Euler Path

An Euler path visits:

$$
\boxed{\text{every edge exactly once}}
$$

Vertices may repeat.

---

# 59. Euler Circuit

An Euler circuit is an Euler path that starts and ends at the same vertex.

For a connected undirected graph:

### Euler circuit exists iff

$$
\boxed{\text{Every vertex has even degree}}
$$

### Euler path but not circuit exists iff

$$
\boxed{\text{Exactly 2 vertices have odd degree}}
$$

---

# 60. Euler GATE Trick

For a connected undirected graph:

```text
0 odd vertices
→ Euler circuit

2 odd vertices
→ Euler path but no Euler circuit

More than 2 odd vertices
→ Neither
```

---

# 61. Hamiltonian Path

A Hamiltonian path visits:

$$
\boxed{\text{every vertex exactly once}}
$$

This is different from Euler path.

---

# 62. Euler vs Hamiltonian

| Euler                                   | Hamiltonian                           |
| --------------------------------------- | ------------------------------------- |
| Visits every edge exactly once          | Visits every vertex exactly once      |
| Based on edges                          | Based on vertices                     |
| Degree conditions useful                | Generally much harder                 |
| Euler circuit has even-degree condition | No similarly simple general condition |

### Memory Trick

```text
Euler → Edges
Hamiltonian → Houses/Vertices
```

---

# 63. Minimum Spanning Tree

MST = Minimum Spanning Tree.

For a connected weighted undirected graph, MST:

```text
Connects all vertices
Contains no cycle
Has minimum total edge weight
```

For `V` vertices:

$$
\boxed{V-1\text{ edges}}
$$

---

# 64. MST Algorithms

Main algorithms:

```text
Prim
Kruskal
```

---

# 65. Prim's Algorithm

Prim grows one tree.

Basic idea:

```text
Start from any vertex.

Repeatedly choose the minimum-weight edge
that connects the current tree to a new vertex.
```

Common implementation:

```text
Priority Queue / Min Heap
```

---

# 66. Kruskal's Algorithm

Kruskal considers edges globally.

Steps:

```text
1. Sort edges by increasing weight.
2. Pick the smallest edge.
3. Add it if it does not create a cycle.
4. Repeat until V-1 edges are selected.
```

Cycle detection commonly uses:

$$
\boxed{\text{Disjoint Set Union / Union-Find}}
$$

---

# 67. Prim vs Kruskal

| Prim                         | Kruskal                      |
| ---------------------------- | ---------------------------- |
| Vertex/tree based            | Edge based                   |
| Grows one tree               | Builds forest then merges    |
| Priority queue commonly used | Sorting edges + DSU          |
| Good for dense graphs        | Often good for sparse graphs |

---

# 68. Shortest Path Algorithms

Important algorithms:

```text
Shortest Path
│
├── BFS
│   └── Unweighted graph
│
├── Dijkstra
│   └── Non-negative edge weights
│
├── Bellman-Ford
│   └── Negative edges allowed
│
└── Floyd-Warshall
    └── All-pairs shortest paths
```

---

# 69. Dijkstra's Algorithm

Dijkstra finds shortest paths from one source when edge weights are:

$$
\boxed{\ge 0}
$$

It does NOT correctly handle arbitrary negative-weight edges.

---

# 70. Dijkstra Complexity

With adjacency list + binary heap:

$$
\boxed{O((V+E)\log V)}
$$

Often written as:

$$
O(E\log V)
$$

for connected graphs where `E ≥ V-1`.

With adjacency matrix/simple implementation:

$$
\boxed{O(V^2)}
$$

---

# 71. Dijkstra GATE Trap

Suppose graph contains:

```text
A --2--> B
A --5--> C
B --(-10)--> C
```

Dijkstra should NOT be blindly applied because there is a negative edge.

Use Bellman-Ford for graphs where negative edges may exist.

---

# 72. Bellman-Ford

Bellman-Ford finds single-source shortest paths and can handle negative edge weights.

It can also detect:

$$
\boxed{\text{Negative-weight cycles}}
$$

Complexity:

$$
\boxed{O(VE)}
$$

---

# 73. Floyd-Warshall

Floyd-Warshall computes:

$$
\boxed{\text{All-pairs shortest paths}}
$$

Dynamic programming approach.

Complexity:

$$
\boxed{O(V^3)}
$$

Space:

$$
\boxed{O(V^2)}
$$

---

# 74. Negative Cycle Detection

In Floyd-Warshall, after completion:

If:

$$
dist[i][i]<0
$$

for some `i`, then a negative cycle exists.

### GATE Shortcut

```text
Floyd-Warshall:
negative diagonal
→ negative cycle
```

---

# 75. Graph Traversal Complexity

| Algorithm            | Adjacency List | Matrix |
| -------------------- | -------------: | -----: |
| BFS                  |         O(V+E) |  O(V²) |
| DFS                  |         O(V+E) |  O(V²) |
| Connected Components |         O(V+E) |  O(V²) |

---

# 76. Important Graph Formula Sheet

### Undirected graph

$$
\boxed{\sum deg(v)=2E}
$$

### Directed graph

$$
\boxed{\sum indeg(v)=E}
$$

$$
\boxed{\sum outdeg(v)=E}
$$

### Simple undirected graph maximum edges

$$
\boxed{\frac{V(V-1)}2}
$$

### Complete graph

$$
\boxed{E=\frac{V(V-1)}2}
$$

### Tree

$$
\boxed{E=V-1}
$$

### Bipartite

$$
\boxed{\text{No odd cycle}}
$$

### Euler circuit

$$
\boxed{\text{All degrees even}}
$$

### Euler path

$$
\boxed{\text{Exactly 0 or 2 odd-degree vertices}}
$$

### Adjacency matrix

$$
\boxed{O(V^2)}
$$

### Adjacency list

$$
\boxed{O(V+E)}
$$

---

# 77. GATE PYQ Pattern — Handshaking Lemma

Suppose an undirected graph has:

```text
20 edges
```

Find the sum of degrees.

$$
\sum deg(v)=2E
$$

$$
=2(20)
$$

$$
\boxed{40}
$$

---

# 78. GATE PYQ Pattern — Odd Degree

Suppose an undirected graph has:

```text
Exactly 3 odd-degree vertices.
```

Can this happen?

```text
NO
```

The number of odd-degree vertices must always be even.

Therefore:

$$
\boxed{\text{Impossible}}
$$

---

# 79. GATE PYQ Pattern — Maximum Edges

For a simple undirected graph with:

```text
V = 10
```

Maximum edges:

$$
\frac{10(9)}2
$$

$$
\boxed{45}
$$

---

# 80. GATE PYQ Pattern — Tree

A connected graph contains:

```text
V = 50
E = 49
```

Since:

$$
E=V-1
$$

and the graph is connected:

$$
\boxed{\text{It is a tree}}
$$

---

# 81. GATE PYQ Pattern — BFS Shortest Path

If a graph is unweighted and the question asks:

```text
Minimum number of edges from S to T
```

Use:

$$
\boxed{BFS}
$$

Do NOT unnecessarily use Dijkstra.

---

# 82. GATE PYQ Pattern — Bipartite

Given:

```text
A -- B
|    |
D -- C
```

This is a cycle of length 4.

Since 4 is even:

```text
It can be bipartite.
```

But:

```text
A
|\
| \
B--C
```

contains a cycle of length 3.

Therefore:

```text
Not bipartite.
```

---

# 83. GATE PYQ Pattern — Topological Sort

Given:

```text
A → C
B → C
C → D
```

Possible topological orders:

```text
A B C D
B A C D
```

Both are valid.

### Trick

Never assume topological ordering is unique.

---

# 84. GATE PYQ Pattern — Euler Circuit

Suppose a connected graph has degree sequence:

```text
2, 4, 2, 6, 4
```

All degrees are even.

Therefore:

```text
Euler circuit exists.
```

---

# 85. GATE PYQ Pattern — Euler Path

Suppose a connected graph has:

```text
degree:
3, 2, 4, 1, 2
```

Odd-degree vertices:

```text
3 and 1
```

Exactly two.

Therefore:

```text
Euler path exists
Euler circuit does not exist
```

---

# 86. GATE PYQ Pattern — Graph Representation

Suppose:

```text
V = 1000
E = 1200
```

Graph is relatively sparse.

Adjacency list requires approximately:

$$
O(V+E)
$$

while adjacency matrix requires:

$$
O(V^2)
$$

Therefore adjacency list is generally more space efficient.

---

# 87. GATE PYQ Pattern — Dijkstra

Question asks:

```text
Single-source shortest path
Graph has no negative edge.
```

Best standard choice:

$$
\boxed{\text{Dijkstra}}
$$

If graph is unweighted:

$$
\boxed{\text{BFS}}
$$

If negative edges exist:

$$
\boxed{\text{Bellman-Ford}}
$$

If all-pairs:

$$
\boxed{\text{Floyd-Warshall}}
$$

---

# 88. Graph Algorithm Decision Tree

```text
What is the question?
        │
        ├── Traversal
        │    ├── Level-wise → BFS
        │    └── Depth-wise → DFS
        │
        ├── Unweighted shortest path
        │    └── BFS
        │
        ├── Single-source shortest path
        │    ├── Non-negative → Dijkstra
        │    └── Negative edges → Bellman-Ford
        │
        ├── All-pairs shortest path
        │    └── Floyd-Warshall
        │
        ├── Minimum spanning tree
        │    ├── Prim
        │    └── Kruskal
        │
        ├── Topological ordering
        │    └── DAG
        │
        ├── Bipartite test
        │    └── BFS/DFS 2-coloring
        │
        └── Connected components
             └── BFS/DFS
```

---

# 89. Most Important GATE Traps

### Trap 1

```text
BFS uses stack
```

Wrong.

$$
\boxed{BFS\rightarrow Queue}
$$

---

### Trap 2

```text
DFS uses queue
```

Wrong.

$$
\boxed{DFS\rightarrow Stack/Recursion}
$$

---

### Trap 3

```text
Dijkstra handles negative edges
```

Wrong.

Dijkstra requires non-negative edge weights.

---

### Trap 4

```text
Tree with V vertices has V edges
```

Wrong.

$$
\boxed{E=V-1}
$$

---

### Trap 5

```text
Bipartite graph has no cycle
```

Wrong.

A bipartite graph can contain even cycles.

It only cannot contain odd cycles.

---

### Trap 6

```text
Euler path visits every vertex exactly once
```

Wrong.

Euler path visits every **edge** exactly once.

---

### Trap 7

```text
Hamiltonian path visits every edge exactly once
```

Wrong.

Hamiltonian path visits every **vertex** exactly once.

---

### Trap 8

```text
Topological sorting works for every directed graph
```

Wrong.

$$
\boxed{\text{Topological ordering requires a DAG}}
$$

---

### Trap 9

```text
Adjacency matrix uses O(V+E)
```

Wrong.

$$
\boxed{O(V^2)}
$$

---

### Trap 10

```text
Every graph has a unique MST
```

Wrong.

An MST may not be unique.

If all edge weights are distinct, the MST is unique.

---

# 90. One-Minute Revision

```text
Graph
↓
G = (V,E)

Undirected:
(a,b) = (b,a)

Directed:
a → b ≠ b → a

Undirected degree:
Σ degree = 2E

Directed:
Σ indegree = E
Σ outdegree = E

Simple graph max edges:
V(V-1)/2

Tree:
Connected + Acyclic
E = V-1

BFS:
Queue
Unweighted shortest path
O(V+E)

DFS:
Stack/Recursion
O(V+E)

Bipartite:
2-colorable
No odd cycle

DAG:
Directed + Acyclic

Topological sort:
Only DAG

Euler:
Every edge exactly once

Hamiltonian:
Every vertex exactly once

MST:
V-1 edges

Dijkstra:
Non-negative weights

Bellman-Ford:
Negative edges allowed

Floyd-Warshall:
All-pairs shortest path
O(V³)
```

---

# 91. Super Important Comparison Table

| Problem                             | Algorithm                       |
| ----------------------------------- | ------------------------------- |
| Graph traversal                     | BFS / DFS                       |
| Unweighted shortest path            | BFS                             |
| Single source, non-negative weights | Dijkstra                        |
| Single source, negative edges       | Bellman-Ford                    |
| All-pairs shortest path             | Floyd-Warshall                  |
| Minimum spanning tree               | Prim / Kruskal                  |
| Topological sort                    | Kahn / DFS                      |
| Connected components                | BFS / DFS                       |
| Bipartite test                      | BFS / DFS                       |
| Cycle detection                     | BFS / DFS                       |
| Euler path/circuit                  | Degree-based conditions         |
| Hamiltonian path                    | Backtracking / advanced methods |

---

# 92. Final GATE Rules

1. **Graph = `(V,E)`.**
2. **Undirected edge has no direction.**
3. **Directed edge has direction.**
4. **Sum of degrees in an undirected graph = `2E`.**
5. **Number of odd-degree vertices is always even.**
6. **Maximum edges in a simple undirected graph = `V(V−1)/2`.**
7. **Tree with `V` vertices has `V−1` edges.**
8. **BFS uses a queue.**
9. **DFS uses a stack/recursion.**
10. **BFS gives shortest paths in unweighted graphs.**
11. **Dijkstra requires non-negative edge weights.**
12. **Bellman-Ford handles negative edges.**
13. **Floyd-Warshall solves all-pairs shortest paths.**
14. **A DAG is required for topological sorting.**
15. **A bipartite graph has no odd cycle.**
16. **Euler → every edge exactly once.**
17. **Hamiltonian → every vertex exactly once.**
18. **Euler circuit in a connected undirected graph → all degrees even.**
19. **Euler path → exactly 0 or 2 odd-degree vertices.**
20. **MST contains `V−1` edges.**
21. **Adjacency matrix → `O(V²)` space.**
22. **Adjacency list → `O(V+E)` space.**
23. **Prim is vertex/tree growing.**
24. **Kruskal is edge sorting + cycle avoidance.**
25. **Back edge in directed DFS indicates a cycle.**
26. **Negative diagonal in Floyd-Warshall indicates a negative cycle.**
27. **A graph can have multiple valid topological orders.**
28. **An MST need not be unique.**
29. **Distinct edge weights guarantee a unique MST.**
30. **Always check whether the graph is directed/undirected and weighted/unweighted before selecting an algorithm.**

---

# 93. Final Checklist

Before solving a GATE graph question:

```text
□ Directed or undirected?
□ Weighted or unweighted?
□ Number of vertices V?
□ Number of edges E?
□ Simple graph?
□ Connected or disconnected?
□ Need traversal?
□ Need shortest path?
□ Need MST?
□ Need topological ordering?
□ Need cycle detection?
□ Need bipartite testing?
□ Adjacency matrix or adjacency list?
□ Are negative weights present?
□ Is the question about edges or vertices?
□ Is the graph a tree?
□ Are there odd-degree vertices?
```

# ⭐ GATE Golden Memory

```text
BFS          → Queue → Unweighted shortest path

DFS          → Stack → Deep traversal

Dijkstra     → Non-negative weights

Bellman-Ford → Negative edges

Floyd        → All pairs

Prim         → MST → Grow tree

Kruskal      → MST → Sort edges

DAG          → Topological sort

Bipartite    → No odd cycle

Euler        → Edges

Hamiltonian  → Vertices

Tree         → E = V - 1

Undirected   → Σdegree = 2E
```

```
```
