# Graphs

> GATE Weightage: ⭐⭐⭐⭐⭐

---

# What is a Graph?

A **Graph** is a mathematical structure used to represent relationships between objects.

A graph consists of:

- Vertices (Nodes)
- Edges (Connections)

Notation

```
G = (V, E)
```

where

```
V = Set of Vertices

E = Set of Edges
```

---

# Example

```
V = {A,B,C,D}

E = {(A,B),(A,C),(C,D)}
```

```
    A
   / \
  B   C
       \
        D
```

---

# Basic Terminology

## Vertex (Node)

A point in a graph.

Example

```
A
```

---

## Edge

Connection between two vertices.

Example

```
(A,B)
```

---

## Adjacent Vertices

Two vertices connected by an edge.

Example

```
A ----- B
```

A and B are adjacent.

---

## Incident Edge

An edge connected to a vertex.

---

## Degree

Number of edges incident on a vertex.

Notation

```
deg(v)
```

Example

```
A ---- B ---- C
```

```
deg(B)=2
```

---

# Handshaking Lemma

The sum of degrees of all vertices equals twice the number of edges.

Formula

```
Σ deg(v)

=

2|E|
```

Very Important for GATE.

---

# Types of Graphs

```
Graphs
│
├── Undirected
├── Directed
├── Weighted
├── Unweighted
├── Simple
├── Multigraph
├── Pseudograph
├── Complete
├── Bipartite
├── Complete Bipartite
├── Cyclic
├── Acyclic
├── Connected
└── Disconnected
```

---

# Undirected Graph

Edges have no direction.

```
A ----- B
```

---

# Directed Graph (Digraph)

Edges have direction.

```
A → B
```

---

# Weighted Graph

Every edge has a weight.

Example

```
A --5-- B
```

---

# Simple Graph

- No self-loops
- No parallel edges

---

# Multigraph

Parallel edges allowed.

---

# Pseudograph

Self-loops allowed.

---

# Complete Graph

Every pair of vertices is connected.

Notation

```
Kn
```

Example

```
K4
```

---

## Number of Edges

```
n(n−1)

────────

2
```

---

# Bipartite Graph

Vertices divided into two disjoint sets.

Edges exist only across sets.

Example

```
{A,B}

{1,2}
```

---

# Complete Bipartite Graph

Notation

```
Km,n
```

Every vertex of one set connects to every vertex of the other.

---

## Number of Edges

```
m × n
```

---

# Regular Graph

Every vertex has the same degree.

Example

```
All vertices have degree 3.
```

---

# Null Graph

No edges.

---

# Connected Graph

Every vertex is reachable from every other vertex.

---

# Disconnected Graph

Some vertices cannot be reached.

---

# Path

A sequence of vertices connected by edges.

Example

```
A → B → C
```

---

# Path Length

Number of edges in the path.

Example

```
A → B → C

Length = 2
```

---

# Simple Path

No repeated vertices.

---

# Cycle

A path that starts and ends at the same vertex.

Example

```
A → B → C → A
```

---

# Simple Cycle

No repeated vertices except the first and last.

---

# Acyclic Graph

Contains no cycles.

---

# Tree

A connected acyclic graph.

Properties

```
n vertices

↓

n−1 edges
```

---

# Forest

A collection of trees.

---

# Subgraph

A graph formed using a subset of vertices and edges.

---

# Complement Graph

Contains exactly those edges not present in the original graph.

Notation

```
G̅
```

---

# Degree in Directed Graph

## In-degree

Number of incoming edges.

Notation

```
indegree(v)
```

---

## Out-degree

Number of outgoing edges.

Notation

```
outdegree(v)
```

---

## Formula

```
Σ indegree

=

Σ outdegree

=

|E|
```

---

# Graph Representation

Two common methods

```
1. Adjacency Matrix

2. Adjacency List
```

---

# Adjacency Matrix

A square matrix of size

```
V × V
```

If edge exists

```
1
```

Otherwise

```
0
```

---

## Space Complexity

```
O(V²)
```

---

## Advantages

- Fast edge lookup
- Easy implementation

---

## Disadvantages

- Wastes memory for sparse graphs

---

# Adjacency List

Store neighbors for every vertex.

Example

```
A → B,C

B → D

C → D

D →
```

---

## Space Complexity

```
O(V+E)
```

Preferred for sparse graphs.

---

# Matrix vs List

| Feature | Matrix | List |
|----------|---------|------|
| Space | O(V²) | O(V+E) |
| Edge Lookup | O(1) | O(degree) |
| Sparse Graph | Poor | Excellent |
| Dense Graph | Good | Good |

---

# Graph Traversal

Two important algorithms

```
1. BFS

2. DFS
```

Covered separately.

---

# Euler Graph

Contains an Euler Circuit.

Conditions

- Connected
- Every vertex has even degree

---

# Euler Path

Conditions

Exactly

```
0

or

2
```

vertices have odd degree.

---

# Hamiltonian Path

Visits every vertex exactly once.

---

# Hamiltonian Cycle

Visits every vertex exactly once and returns to the starting vertex.

No simple necessary and sufficient condition exists.

---

# Graph Isomorphism

Two graphs are isomorphic if they have the same structure despite different vertex labels.

Properties preserved:

- Number of vertices
- Number of edges
- Degree sequence

---

# Common GATE Formulas

## Complete Graph

```
Edges

=

n(n−1)

──────

2
```

---

## Tree

```
Edges

=

Vertices−1
```

---

## Handshaking Lemma

```
Σ Degree

=

2E
```

---

## Complete Bipartite

```
Edges

=

m×n
```

---

## Directed Graph

```
Σ In-degree

=

Σ Out-degree

=

E
```

---

# Common GATE PYQs

- Degree of Vertex
- Handshaking Lemma
- Complete Graph
- Bipartite Graph
- Tree Properties
- Adjacency Matrix
- Adjacency List
- Directed Graph
- Euler Path
- Euler Circuit
- Hamiltonian Path
- Graph Isomorphism

---

# Quick Revision

✅ Graph

✅ Vertex

✅ Edge

✅ Degree

✅ Handshaking Lemma

✅ Complete Graph

✅ Bipartite Graph

✅ Tree

✅ Forest

✅ Path

✅ Cycle

✅ Directed Graph

✅ Adjacency Matrix

✅ Adjacency List

✅ Euler Graph

✅ Hamiltonian Graph

---

# Common Mistakes

❌ Forgetting that **Σ Degree = 2E**.

❌ Confusing Euler and Hamiltonian paths.

❌ Mixing Tree and Forest.

❌ Assuming every connected graph is complete.

❌ Using Adjacency Matrix for sparse graphs without considering memory.

---

# Memory Tricks

### Graph

```
G=(V,E)
```

---

### Tree

```
Connected

+

Acyclic
```

---

### Complete Graph

```
Edges

=

n(n−1)/2
```

---

### Tree Formula

```
Edges

=

Vertices−1
```

---

### Handshaking Lemma

```
Every Edge

Contributes

2 Degrees
```

---

# Formula Sheet

| Formula | Result |
|----------|--------|
| Handshaking Lemma | Σ Degree = 2E |
| Complete Graph | n(n−1)/2 |
| Complete Bipartite | m×n |
| Tree | E = V−1 |
| Directed Graph | Σ In-degree = Σ Out-degree = E |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- Graph Properties
- Degree
- Complete Graph
- Trees
- Bipartite Graph
- Adjacency Matrix/List
- Euler vs Hamiltonian
- Handshaking Lemma

---

# Next File

➡️ `09-Connectivity-Matching-and-Colouring.md`