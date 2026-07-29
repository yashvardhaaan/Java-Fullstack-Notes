# Connectivity, Matching and Colouring

> GATE Weightage: ⭐⭐⭐⭐

---

# Graph Connectivity

## What is Connectivity?

A graph is **connected** if there exists a path between every pair of vertices.

Example

```
A ----- B ----- C ----- D
```

Every vertex can reach every other vertex.

✅ Connected Graph

---

## Disconnected Graph

If at least one pair of vertices has no path between them.

Example

```
A ----- B

C ----- D
```

❌ Disconnected Graph

---

# Connected Components

A **Connected Component** is a maximal connected subgraph.

Example

```
A --- B

C --- D --- E

F
```

Connected Components:

```
{A,B}

{C,D,E}

{F}
```

Number of Components = 3

---

# Strong Connectivity (Directed Graph)

A directed graph is **Strongly Connected** if every vertex can reach every other vertex.

Example

```
A → B

↑   ↓

D ← C
```

Every vertex is reachable.

---

# Weak Connectivity

Ignore edge directions.

If the graph becomes connected, it is **Weakly Connected**.

---

# Bridge (Cut Edge)

An edge whose removal increases the number of connected components.

Example

```
A ---- B ---- C
```

Removing

```
(B,C)
```

disconnects the graph.

Hence,

```
(B,C)
```

is a Bridge.

---

# Cut Vertex (Articulation Point)

A vertex whose removal disconnects the graph.

Example

```
A ---- B ---- C

      |

      D
```

Removing

```
B
```

disconnects the graph.

---

# Vertex Connectivity

Minimum number of vertices that must be removed to disconnect the graph.

Notation

```
κ(G)
```

---

# Edge Connectivity

Minimum number of edges whose removal disconnects the graph.

Notation

```
λ(G)
```

---

# Connectivity Theorem

```
κ(G)

≤

λ(G)

≤

Minimum Degree
```

Important for GATE.

---

# Matching

## What is Matching?

A **Matching** is a set of edges such that **no two edges share a common vertex**.

Example

```
A ---- B

C ---- D
```

Both edges can belong to a matching.

---

# Maximum Matching

A matching containing the maximum possible number of edges.

Notation

```
M
```

---

# Maximal Matching

A matching that cannot be extended by adding another edge.

Not necessarily maximum.

---

# Perfect Matching

Every vertex is matched exactly once.

Example

```
A ---- B

C ---- D
```

All four vertices are matched.

---

# Near Perfect Matching

Exactly one vertex remains unmatched.

---

# Hall's Marriage Theorem

A bipartite graph has a perfect matching iff

For every subset

```
S
```

of one partition,

```
|N(S)| ≥ |S|
```

where

```
N(S)
```

is the neighborhood of

```
S
```

Very Important for GATE.

---

# Bipartite Graph

Vertices are divided into two disjoint sets.

Edges exist only between the sets.

Example

```
Left

A

B

Right

1

2

3
```

---

# Complete Bipartite Graph

Notation

```
Km,n
```

Every vertex of one set is connected to every vertex of the other.

Number of Edges

```
m × n
```

---

# Coloring

## Graph Coloring

Assign colors to vertices so that

Adjacent vertices have different colors.

---

# Chromatic Number

Minimum number of colors required.

Notation

```
χ(G)
```

---

# Examples

## Complete Graph

```
Kn
```

Chromatic Number

```
χ(Kn)=n
```

---

## Bipartite Graph

Chromatic Number

```
χ=2
```

(if at least one edge exists)

---

## Tree

Chromatic Number

```
χ=2
```

(except single vertex)

---

## Odd Cycle

```
χ=3
```

---

## Even Cycle

```
χ=2
```

---

# Edge Coloring

Assign colors to edges such that

Adjacent edges have different colors.

---

# Chromatic Index

Minimum number of colors needed for edge coloring.

Notation

```
χ'(G)
```

---

# Four Color Theorem

Every planar graph can be colored using at most

```
4
```

colors.

Very Popular GATE Theory Question.

---

# Planar Graph

Can be drawn without edge crossings.

Example

```
Square

□
```

Planar.

---

# Euler Formula (Planar Graph)

```
V − E + F = 2
```

where

```
V = Vertices

E = Edges

F = Faces
```

---

# Properties of Planar Graph

Maximum Edges

```
E ≤ 3V−6
```

For Bipartite Planar Graph

```
E ≤ 2V−4
```

---

# Common Graph Coloring Results

| Graph | Chromatic Number |
|--------|------------------|
| Complete Graph | n |
| Bipartite Graph | 2 |
| Tree | 2 |
| Odd Cycle | 3 |
| Even Cycle | 2 |

---

# Important Formulas

## Complete Graph

```
χ(Kn)=n
```

---

## Bipartite Graph

```
χ=2
```

---

## Euler Formula

```
V−E+F=2
```

---

## Planar Graph

```
E≤3V−6
```

---

## Bipartite Planar

```
E≤2V−4
```

---

# Common GATE PYQs

- Connected Components
- Strongly Connected Graph
- Bridge
- Articulation Point
- Maximum Matching
- Hall's Marriage Theorem
- Perfect Matching
- Graph Coloring
- Chromatic Number
- Four Color Theorem
- Planar Graph
- Euler Formula

---

# Quick Revision

✅ Connected Graph

✅ Connected Components

✅ Strong Connectivity

✅ Bridge

✅ Articulation Point

✅ Vertex Connectivity

✅ Edge Connectivity

✅ Matching

✅ Maximum Matching

✅ Perfect Matching

✅ Hall's Theorem

✅ Graph Coloring

✅ Chromatic Number

✅ Planar Graph

✅ Euler Formula

---

# Common Mistakes

❌ Confusing Maximum Matching with Maximal Matching.

❌ Forgetting that every Tree is Bipartite.

❌ Assuming all connected graphs are planar.

❌ Mixing Bridge and Articulation Point.

❌ Using χ = 2 for odd cycles.

---

# Memory Tricks

### Connectivity

```
Connected

↓

Every vertex

Reachable
```

---

### Matching

```
No Vertex

Repeats
```

---

### Perfect Matching

```
Every Vertex

Matched Exactly Once
```

---

### Coloring

```
Adjacent Vertices

↓

Different Colors
```

---

### Euler Formula

```
V − E + F = 2
```

---

### Planar Graph

```
Maximum Edges

=

3V−6
```

---

# Formula Sheet

| Formula | Result |
|----------|--------|
| Euler Formula | V−E+F=2 |
| Planar Graph | E≤3V−6 |
| Bipartite Planar | E≤2V−4 |
| Complete Graph | χ=n |
| Tree | χ=2 |
| Bipartite | χ=2 |

---

# PYQ Focus

⭐⭐⭐⭐⭐

- Connectivity
- Bridges & Articulation Points
- Hall's Marriage Theorem
- Maximum Matching
- Chromatic Number
- Euler Formula
- Planar Graphs
- Four Color Theorem

---

# Next File

➡️ `10-Combinatorics.md`