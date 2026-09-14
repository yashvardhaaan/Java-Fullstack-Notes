# 08 — Graphs.md

````md
# 08 — Graphs
## GATE CSE/IT Notes + Tricks + PYQ Explanations + Practice

---

# 1. What is a Graph?

A graph is a non-linear data structure consisting of:

```text
Vertices (V)
Edges (E)
````

A graph is represented as:

```text
G = (V, E)
```

Example:

```text
    A ----- B
    |       |
    |       |
    C ----- D
```

Here:

```text
V = {A, B, C, D}

E = {(A,B), (A,C), (B,D), (C,D)}
```

---

# 2. Graph Terminology

## Vertex

A node of the graph.

Example:

```text
A, B, C, D
```

are vertices.

## Edge

Connection between two vertices.

Example:

```text
A ----- B
```

`AB` is an edge.

---

# 3. Directed Graph

In a directed graph, edges have direction.

```text
A → B
```

means:

```text
A → B
```

but not necessarily:

```text
B → A
```

Example:

```text
A → B → C
```

---

# 4. Undirected Graph

Edges have no direction.

```text
A — B
```

means:

```text
A connected to B
```

and:

```text
B connected to A
```

---

# 5. Weighted Graph

Each edge has a weight/cost.

```text
A --5-- B
```

The cost of travelling from A to B is 5.

Weights may represent:

```text
distance
time
cost
network delay
```

---

# 6. Degree of Vertex

For an undirected graph:

```text
degree(v) = number of edges incident on v
```

Example:

```text
A ----- B
|
|
C
```

Degree of A:

```text
2
```

Degree of B:

```text
1
```

Degree of C:

```text
1
```

---

# 7. Handshaking Lemma

For an undirected graph:

```text
Σ degree(v) = 2E
```

where:

```text
E = number of edges
```

Why?

Every edge contributes:

```text
1 degree to each endpoint
```

Therefore:

```text
2 contributions per edge
```

---

# 8. GATE Trick — Sum of Degrees

If:

```text
E = 20
```

then:

```text
Σ degree = 2 × 20
          = 40
```

This is one of the easiest graph questions in GATE.

---

# 9. Directed Graph Degree

Every vertex has:

```text
in-degree
out-degree
```

### In-degree

Number of edges entering the vertex.

### Out-degree

Number of edges leaving the vertex.

Example:

```text
A → B
```

For A:

```text
out-degree = 1
in-degree = 0
```

For B:

```text
in-degree = 1
out-degree = 0
```

---

# 10. Directed Graph Degree Formula

For a directed graph:

```text
Σ in-degree = E
```

and:

```text
Σ out-degree = E
```

Therefore:

```text
Σ(in-degree + out-degree) = 2E
```

---

# 11. Simple Graph

A simple graph generally has:

```text
No self-loops
No parallel/multiple edges
```

Example:

```text
A — B
```

is valid.

But:

```text
A ↺
```

is a self-loop.

---

# 12. Self Loop

An edge from a vertex to itself.

```text
A ↺
```

For an undirected graph, a self-loop contributes **2** to the degree of that vertex.

### GATE Trap

Do not count a self-loop as degree 1 in an undirected graph.

---

# 13. Parallel Edges

Two or more edges connecting the same pair of vertices.

```text
A ===== B
```

If multiple edges are allowed, the graph is a:

```text
Multigraph
```

---

# 14. Complete Graph

A complete graph has an edge between every pair of distinct vertices.

Notation:

```text
Kₙ
```

For `n` vertices:

```text
Edges = n(n-1)/2
```

---

# 15. Complete Graph Example

For:

```text
K4
```

vertices:

```text
A B C D
```

Every pair is connected.

Number of edges:

```text
4(4-1)/2
= 6
```

---

# 16. Maximum Edges in Simple Undirected Graph

For `n` vertices:

```text
Maximum edges = n(n-1)/2
```

because every pair can have at most one edge.

---

# 17. Maximum Edges in Simple Directed Graph

If self-loops are not allowed:

```text
Maximum edges = n(n-1)
```

because:

```text
A → B
```

and:

```text
B → A
```

can both exist.

---

# 18. Path

A path is a sequence of vertices connected by edges.

Example:

```text
A → B → C → D
```

Path length:

```text
3 edges
```

### GATE Trick

Path length is generally measured in:

```text
number of edges
```

unless the question explicitly defines otherwise.

---

# 19. Simple Path

A path with no repeated vertices.

Example:

```text
A → B → C → D
```

is simple.

But:

```text
A → B → C → B
```

is not simple.

---

# 20. Cycle

A path that starts and ends at the same vertex.

Example:

```text
A → B → C → A
```

is a cycle.

---

# 21. Connected Graph

An undirected graph is connected if there is a path between every pair of vertices.

Example:

```text
A — B — C
```

is connected.

---

# 22. Disconnected Graph

Example:

```text
A — B       C — D
```

There is no path from A to C.

Therefore the graph is disconnected.

---

# 23. Connected Components

A disconnected graph can be divided into connected components.

Example:

```text
A — B       C — D       E
```

Components:

```text
{A,B}
{C,D}
{E}
```

Number of components:

```text
3
```

---

# 24. Tree as a Graph

A tree is:

```text
Connected
+
Acyclic
```

For `n` vertices:

```text
Edges = n - 1
```

Important equivalences:

```text
Tree
⇔ connected + n-1 edges

Tree
⇔ connected + acyclic

Tree
⇔ exactly one simple path between every pair of vertices
```

---

# 25. GATE Tree Trick

If a graph has:

```text
n vertices
n-1 edges
```

it is NOT automatically enough to say it is a tree.

You also need connectivity.

Example:

```text
A — B

C
```

Here:

```text
n = 3
edges = 1
```

which is not a tree.

---

# 26. Forest

A forest is an acyclic undirected graph.

It can contain multiple components.

Example:

```text
A — B      C — D
```

is a forest.

If a forest has:

```text
n vertices
c components
```

then:

```text
E = n - c
```

---

# 27. Adjacency Matrix

For `n` vertices, adjacency matrix is:

```text
n × n
```

Example:

```text
A — B
|
C
```

Matrix:

```text
      A B C
A     0 1 1
B     1 0 0
C     1 0 0
```

For an undirected graph:

```text
Matrix is symmetric
```

---

# 28. Adjacency Matrix Space

For `V` vertices:

```text
Space = O(V²)
```

This is independent of the number of edges.

---

# 29. Adjacency List

Each vertex stores its neighboring vertices.

Example:

```text
A → B, C
B → A
C → A
```

For an undirected graph:

```text
Each edge appears twice
```

once in each endpoint's list.

---

# 30. Adjacency List Space

For:

```text
V vertices
E edges
```

space:

```text
O(V + E)
```

This is better for sparse graphs.

---

# 31. Matrix vs List

| Feature           |      Matrix |         List |
| ----------------- | ----------: | -----------: |
| Space             |       O(V²) |       O(V+E) |
| Check edge        |        O(1) |    O(degree) |
| Iterate neighbors |        O(V) |    O(degree) |
| Best for          | Dense graph | Sparse graph |

---

# 32. GATE Trick — Dense vs Sparse

If:

```text
E ≈ V²
```

graph is dense.

Adjacency matrix is often suitable.

If:

```text
E ≈ V
```

graph is sparse.

Adjacency list is generally preferred.

---

# 33. BFS

BFS = Breadth First Search.

It explores:

```text
Level by level
```

Uses:

```text
Queue
```

Example:

```text
        A
       / \
      B   C
     / \
    D   E
```

BFS:

```text
A B C D E
```

---

# 34. BFS Algorithm

```text
BFS(G, start):

1. Mark start visited.
2. Insert start into queue.
3. While queue is not empty:
      u = dequeue()
      process(u)
      for each neighbor v of u:
          if v is unvisited:
              mark v visited
              enqueue(v)
```

---

# 35. BFS Complexity

Using adjacency list:

```text
O(V + E)
```

Why?

Every vertex is visited once.

Every edge is examined a constant number of times.

For undirected graph:

```text
Each edge appears twice
```

but:

```text
2E = O(E)
```

---

# 36. BFS with Adjacency Matrix

For each vertex, we may scan all `V` possible neighbors.

Therefore:

```text
Time = O(V²)
```

### GATE Trick

Complexity depends on representation.

```text
Adjacency List → O(V+E)
Adjacency Matrix → O(V²)
```

---

# 37. DFS

DFS = Depth First Search.

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

But exact DFS order can depend on neighbor ordering.

---

# 38. DFS Recursive

```c
DFS(u) {
    visited[u] = 1;

    for each v adjacent to u {
        if (!visited[v])
            DFS(v);
    }
}
```

Complexity with adjacency list:

```text
O(V + E)
```

---

# 39. DFS Space

Recursive DFS uses:

```text
O(V)
```

in the worst case for the recursion/visited structures.

More precisely, recursion stack is related to graph traversal depth, which can be O(V).

---

# 40. BFS vs DFS

| Feature                           | BFS        | DFS          |
| --------------------------------- | ---------- | ------------ |
| Main structure                    | Queue      | Stack        |
| Traversal                         | Level-wise | Depth-wise   |
| Shortest path in unweighted graph | Yes        | No guarantee |
| Cycle detection                   | Yes        | Yes          |
| Complexity                        | O(V+E)     | O(V+E)       |

---

# 41. GATE Trick — Shortest Path

For an **unweighted graph**:

```text
BFS → shortest path in number of edges
```

DFS does not guarantee shortest path.

---

# 42. BFS Distance

Suppose:

```text
A — B — C — D
```

Starting at A:

```text
distance(A) = 0
distance(B) = 1
distance(C) = 2
distance(D) = 3
```

BFS discovers vertices in nondecreasing distance.

---

# 43. BFS and Bipartite Graph

A graph is bipartite if its vertices can be divided into two sets such that no edge exists within the same set.

BFS/DFS can check this using:

```text
2-coloring
```

Assign:

```text
color 0
color 1
```

to alternate levels.

If an edge connects two vertices having the same color:

```text
Not bipartite
```

---

# 44. Bipartite Graph

Example:

```text
A —— X
|    |
|    |
Y —— B
```

Can divide into:

```text
Set 1 = {A, B}
Set 2 = {X, Y}
```

No edge occurs within the same set.

---

# 45. Important Bipartite Fact

A graph is bipartite:

```text
⇔ it contains no odd cycle
```

Therefore:

```text
Odd cycle → NOT bipartite
```

Example:

```text
A
/ \
B—C
```

contains a 3-cycle.

Therefore it is not bipartite.

---

# 46. Complete Bipartite Graph

Notation:

```text
K(m,n)
```

There are:

```text
m vertices in first set
n vertices in second set
```

Every vertex in the first set connects to every vertex in the second set.

Number of edges:

```text
mn
```

---

# 47. Example — K(2,3)

Number of edges:

```text
2 × 3 = 6
```

---

# 48. Topological Sort

Topological sorting is defined for:

```text
Directed Acyclic Graph
```

also called:

```text
DAG
```

It produces an ordering such that for every edge:

```text
u → v
```

`u` appears before `v`.

---

# 49. Example Topological Order

Graph:

```text
A → C
B → C
C → D
```

Possible order:

```text
A B C D
```

Another valid order:

```text
B A C D
```

Both satisfy dependencies.

---

# 50. Topological Sort Does Not Need to Be Unique

If multiple vertices have no incoming edges, different choices can produce different valid topological orders.

Therefore:

```text
Topological order may not be unique.
```

---

# 51. Kahn's Algorithm

Kahn's algorithm uses:

```text
Indegree
+
Queue
```

Steps:

```text
1. Find all vertices with indegree 0.
2. Put them into queue.
3. Remove one vertex.
4. Add it to answer.
5. Reduce indegree of its neighbors.
6. If a neighbor becomes indegree 0,
   enqueue it.
```

---

# 52. Detect Cycle Using Kahn

If after processing:

```text
processed vertices < V
```

then:

```text
Cycle exists
```

because not all vertices could be removed.

---

# 53. DFS Topological Sort

DFS-based topological sorting:

```text
DFS each vertex
push vertex after processing all outgoing edges
reverse resulting order
```

Equivalent idea:

```text
Topological order = reverse postorder
```

for DAGs.

---

# 54. DAG

DAG:

```text
Directed Acyclic Graph
```

Properties:

* Directed.
* No directed cycle.
* Has at least one topological ordering.

---

# 55. GATE DAG Trick

If a directed graph contains:

```text
A → B → C → A
```

then:

```text
Cycle exists
```

Therefore:

```text
Not a DAG
```

and:

```text
No topological ordering
```

---

# 56. Minimum Spanning Tree

MST = Minimum Spanning Tree.

For a connected, weighted, undirected graph:

```text
Spanning tree
+
Minimum total edge weight
```

---

# 57. Properties of MST

For `V` vertices:

```text
MST has V - 1 edges
```

It:

```text
connects all vertices
contains no cycle
has minimum total weight
```

---

# 58. MST Is Not Always Unique

If edge weights are repeated, multiple MSTs can exist.

If all edge weights are distinct:

```text
MST is unique
```

This is an important GATE fact.

---

# 59. Kruskal's Algorithm

Kruskal:

```text
1. Sort edges by weight.
2. Take smallest edge.
3. Add it if it does not form a cycle.
4. Repeat until V-1 edges.
```

Cycle detection commonly uses:

```text
Disjoint Set Union (DSU)
```

---

# 60. Kruskal Complexity

Sorting edges:

```text
O(E log E)
```

DSU operations are almost constant amortized with path compression + union by rank/size.

Therefore overall:

```text
O(E log E)
```

---

# 61. Prim's Algorithm

Prim grows one tree.

Steps:

```text
1. Start from any vertex.
2. Select minimum-weight edge
   connecting tree to an unvisited vertex.
3. Add that vertex.
4. Repeat.
```

With a binary heap and adjacency list:

```text
O(E log V)
```

commonly.

---

# 62. Kruskal vs Prim

| Feature            | Kruskal       | Prim                                            |
| ------------------ | ------------- | ----------------------------------------------- |
| Approach           | Edge-based    | Vertex/tree-based                               |
| Sort edges         | Yes           | Not necessarily                                 |
| Common DS          | DSU           | Priority Queue                                  |
| Good for           | Sparse graphs | Often dense graphs with suitable implementation |
| Typical complexity | O(E log E)    | O(E log V)                                      |

---

# 63. MST Cut Property

For any cut of a weighted graph:

```text
The lightest edge crossing the cut
is safe for some MST.
```

This is called the:

```text
Cut Property
```

---

# 64. MST Cycle Property

For a cycle:

```text
The heaviest edge in the cycle
can be excluded from some MST
```

when it is uniquely heaviest, it cannot belong to an MST.

---

# 65. Shortest Path

Shortest path asks for minimum total path weight.

Important algorithms:

```text
BFS
Dijkstra
Bellman-Ford
Floyd-Warshall
```

Choice depends on graph properties.

---

# 66. BFS for Shortest Path

Use BFS when:

```text
All edges have equal weight
```

especially:

```text
unweighted graph
```

Complexity:

```text
O(V+E)
```

with adjacency list.

---

# 67. Dijkstra's Algorithm

Dijkstra finds single-source shortest paths when edge weights are:

```text
NON-NEGATIVE
```

It does not correctly handle arbitrary negative-weight edges.

---

# 68. Dijkstra Idea

Maintain:

```text
distance[v]
```

Initially:

```text
distance[source] = 0
```

others:

```text
∞
```

Repeatedly choose the unprocessed vertex with smallest tentative distance.

Then relax its outgoing edges.

---

# 69. Relaxation

For edge:

```text
u → v
```

with weight `w`:

```text
if dist[u] + w < dist[v]

    dist[v] = dist[u] + w
```

This operation is called:

```text
Relaxation
```

---

# 70. Dijkstra Complexity

Using binary heap + adjacency list:

```text
O((V+E) log V)
```

Often written for connected sparse graphs as:

```text
O(E log V)
```

---

# 71. Dijkstra GATE Trap

Dijkstra:

```text
Works → non-negative edge weights
```

Does NOT generally work with:

```text
negative edge weights
```

---

# 72. Bellman-Ford

Bellman-Ford solves:

```text
Single-source shortest paths
```

and can handle:

```text
negative edge weights
```

It can also detect:

```text
negative-weight cycles
```

reachable from the source.

---

# 73. Bellman-Ford Complexity

Standard implementation:

```text
O(VE)
```

because edges are relaxed up to:

```text
V - 1
```

times.

---

# 74. Negative Cycle

If after `V-1` relaxation rounds an additional relaxation can still improve a distance:

```text
Negative-weight cycle exists
```

reachable from source.

---

# 75. Dijkstra vs Bellman-Ford

| Feature                  | Dijkstra   | Bellman-Ford |
| ------------------------ | ---------- | ------------ |
| Negative edges           | No         | Yes          |
| Negative cycle detection | No         | Yes          |
| Single source            | Yes        | Yes          |
| Typical complexity       | O(E log V) | O(VE)        |

---

# 76. Floyd-Warshall

Floyd-Warshall solves:

```text
All-pairs shortest paths
```

It considers every vertex as an intermediate vertex.

Dynamic programming recurrence:

```text
D[i][j] =
min(D[i][j],
    D[i][k] + D[k][j])
```

---

# 77. Floyd-Warshall Complexity

Time:

```text
O(V³)
```

Space:

```text
O(V²)
```

---

# 78. Negative Cycle in Floyd-Warshall

After the algorithm, if:

```text
D[i][i] < 0
```

for some vertex `i`, then a negative cycle exists.

---

# 79. Shortest Path Algorithm Selection

```text
Unweighted graph
    ↓
BFS

Non-negative weighted graph
    ↓
Dijkstra

Negative edges allowed
    ↓
Bellman-Ford

All-pairs shortest path
    ↓
Floyd-Warshall
```

---

# 80. GATE PYQ Pattern — Degree

Question:

> An undirected graph has 15 edges. What is the sum of degrees?

Use:

```text
Σ degree = 2E
```

Therefore:

```text
= 2 × 15
= 30
```

---

# 81. GATE PYQ Pattern — Complete Graph

Question:

> How many edges can a simple undirected graph with 10 vertices have at most?

Formula:

```text
n(n-1)/2
```

Therefore:

```text
10 × 9 / 2
= 45
```

---

# 82. GATE PYQ Pattern — Tree

A tree has:

```text
25 vertices
```

Number of edges:

```text
25 - 1
= 24
```

---

# 83. GATE PYQ Pattern — Forest

A forest has:

```text
V = 20
components = 4
```

Edges:

```text
E = V - C
  = 20 - 4
  = 16
```

---

# 84. GATE PYQ Pattern — BFS

Given an unweighted graph and asked:

> Find shortest distance from source.

Use:

```text
BFS
```

Do not use DFS merely because it can visit every vertex.

---

# 85. GATE PYQ Pattern — DFS Complexity

For adjacency-list representation:

```text
DFS = O(V+E)
```

Reason:

```text
Each vertex processed once.
Each edge examined a constant number of times.
```

---

# 86. GATE PYQ Pattern — Adjacency Matrix

If graph has:

```text
V vertices
```

adjacency matrix contains:

```text
V² entries
```

Therefore:

```text
Space = O(V²)
```

---

# 87. GATE PYQ Pattern — Topological Sort

If graph contains:

```text
A → B
B → C
A → C
```

valid topological orders include:

```text
A B C
```

The important condition is:

```text
source appears before destination
```

---

# 88. GATE PYQ Pattern — Cycle and Topological Sort

If a directed graph contains:

```text
A → B
B → C
C → A
```

then:

```text
Cycle exists
```

Therefore:

```text
Topological sorting impossible
```

---

# 89. GATE PYQ Pattern — MST

Suppose a connected graph has:

```text
V = 8
```

Any spanning tree contains:

```text
V - 1 = 7
```

edges.

Therefore every MST also has:

```text
7 edges
```

regardless of the original graph having many more edges.

---

# 90. GATE PYQ Pattern — Unique MST

If all edge weights are distinct:

```text
MST is unique
```

If weights repeat:

```text
MST may or may not be unique
```

Repeated weights do NOT automatically mean multiple MSTs.

---

# 91. GATE PYQ Pattern — Dijkstra

Suppose graph contains a negative edge:

```text
A → B = -5
```

Do not blindly apply Dijkstra.

Use:

```text
Bellman-Ford
```

if negative edges must be handled.

---

# 92. GATE PYQ Pattern — Floyd Warshall

If question asks:

> Shortest paths between every pair of vertices.

Think:

```text
Floyd-Warshall
```

Complexity:

```text
O(V³)
```

---

# 93. Important Graph Formulas

```text
Undirected graph:
Σ degree = 2E

Directed graph:
Σ indegree = E
Σ outdegree = E

Complete undirected graph:
E = n(n-1)/2

Complete directed graph without self-loops:
E = n(n-1)

Tree:
E = V-1

Forest:
E = V-C

Complete bipartite:
E = mn
```

---

# 94. Graph Representation Cheat Sheet

```text
Adjacency Matrix:
Space = O(V²)

Adjacency List:
Space = O(V+E)

Matrix edge lookup:
O(1)

List neighbor traversal:
O(degree)
```

---

# 95. Traversal Cheat Sheet

```text
BFS:
Queue

DFS:
Stack / Recursion

BFS shortest path:
Unweighted graph

DFS:
Connectivity
Cycle detection
Topological sort
```

---

# 96. MST Cheat Sheet

```text
Kruskal:
Sort edges
Use DSU
O(E log E)

Prim:
Grow one tree
Use priority queue
O(E log V) commonly

MST:
V-1 edges

Distinct weights:
Unique MST
```

---

# 97. Shortest Path Cheat Sheet

```text
BFS:
Unweighted

Dijkstra:
Non-negative weights

Bellman-Ford:
Negative edges

Floyd-Warshall:
All pairs

Negative cycle:
Bellman-Ford can detect
Floyd-Warshall: D[i][i] < 0
```

---

# 98. High-Yield GATE Traps

## Trap 1

```text
Tree with n nodes has n edges
```

❌ Wrong.

```text
n - 1
```

---

## Trap 2

```text
DFS always finds shortest path
```

❌ Wrong.

BFS gives shortest path in an unweighted graph.

---

## Trap 3

```text
Dijkstra handles negative edges
```

❌ Wrong.

---

## Trap 4

```text
Every graph with n-1 edges is a tree
```

❌ Wrong.

Connectivity must also hold.

---

## Trap 5

```text
Adjacency list always uses O(V²)
```

❌ Wrong.

```text
O(V+E)
```

---

## Trap 6

```text
Topological sort works on any graph
```

❌ Wrong.

It requires a DAG.

---

## Trap 7

```text
MST can contain a cycle
```

❌ Wrong.

A spanning tree is acyclic.

---

## Trap 8

```text
MST has minimum number of edges
```

❌ Wrong.

Every spanning tree already has:

```text
V-1 edges
```

MST minimizes:

```text
total weight
```

---

# 99. GATE Graph Problem Workflow

When a graph question appears:

### Step 1

Identify:

```text
Directed or Undirected?
Weighted or Unweighted?
```

### Step 2

Check:

```text
Cycle?
Connected?
```

### Step 3

If shortest path:

```text
Unweighted → BFS
Non-negative weighted → Dijkstra
Negative edges → Bellman-Ford
All pairs → Floyd-Warshall
```

### Step 4

If minimum spanning tree:

```text
Kruskal / Prim
```

### Step 5

If dependency ordering:

```text
Topological sort
```

### Step 6

If representation question:

```text
Matrix → O(V²)
List → O(V+E)
```

---

# 100. One-Minute Revision

```text
GRAPH:
G = (V,E)

UNDIRECTED:
Σ degree = 2E

DIRECTED:
Σ indegree = E
Σ outdegree = E

COMPLETE:
n(n-1)/2 edges

TREE:
connected + acyclic
E = V-1

FOREST:
E = V-C

BFS:
Queue
Shortest path in unweighted graph

DFS:
Stack/recursion

DAG:
Directed + acyclic

TOPOLOGICAL SORT:
Only DAG

MST:
V-1 edges
Minimum total weight

KRUSKAL:
Sort edges + DSU

PRIM:
Grow tree + priority queue

DIJKSTRA:
No negative edges

BELLMAN-FORD:
Negative edges allowed

FLOYD-WARSHALL:
All pairs
O(V³)
```

---

# 101. Final GATE Checklist

* [ ] Directed vs undirected graph
* [ ] Weighted vs unweighted graph
* [ ] Degree/in-degree/out-degree
* [ ] Handshaking lemma
* [ ] Complete graph
* [ ] Complete bipartite graph
* [ ] Path and cycle
* [ ] Connected components
* [ ] Tree and forest
* [ ] Adjacency matrix
* [ ] Adjacency list
* [ ] BFS
* [ ] DFS
* [ ] BFS shortest path
* [ ] Bipartite graph
* [ ] Topological sorting
* [ ] DAG
* [ ] MST
* [ ] Kruskal
* [ ] Prim
* [ ] Cut property
* [ ] Cycle property
* [ ] Dijkstra
* [ ] Bellman-Ford
* [ ] Floyd-Warshall
* [ ] Negative cycle
* [ ] Graph complexity analysis

---

# 102. Final GATE Rules

```text
RULE 1:
Undirected graph:
sum of degrees = 2E.

RULE 2:
Directed graph:
sum of indegrees = E.

RULE 3:
A tree with V vertices has V-1 edges.

RULE 4:
A forest with C components has V-C edges.

RULE 5:
Complete undirected graph:
V(V-1)/2 edges.

RULE 6:
BFS uses a queue.

RULE 7:
DFS uses a stack or recursion.

RULE 8:
BFS gives shortest path in an unweighted graph.

RULE 9:
Topological sorting requires a DAG.

RULE 10:
MST contains V-1 edges.

RULE 11:
Kruskal is edge-oriented and uses DSU.

RULE 12:
Prim grows one tree.

RULE 13:
Dijkstra requires non-negative edge weights.

RULE 14:
Bellman-Ford handles negative edges.

RULE 15:
Floyd-Warshall solves all-pairs shortest paths.

RULE 16:
Adjacency matrix uses O(V²) space.

RULE 17:
Adjacency list uses O(V+E) space.

RULE 18:
A graph with V-1 edges is not necessarily a tree
unless it is connected.

RULE 19:
An odd cycle means the graph is not bipartite.

RULE 20:
Always identify graph type before choosing the algorithm.
```

---

# END — 08 Graphs

```
```
