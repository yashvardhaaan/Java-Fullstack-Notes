# Routing Algorithms

## 1. What is a Routing Algorithm?

A **routing algorithm** determines the best path for packets from a source to a destination.

```text
Source
  ↓
Routing Algorithm
  ↓
Best Path
  ↓
Routing Table
  ↓
Forwarding
```

> **Routing algorithm = path selection mechanism**

---

# 2. Main Routing Algorithm Categories ⭐⭐⭐⭐⭐

For GATE, focus mainly on:

```text id="x8h2m5"
Routing Algorithms
│
├── Distance Vector
│     └── Bellman-Ford
│
└── Link State
      └── Dijkstra
```

---

# 3. Bellman-Ford ⭐⭐⭐⭐⭐

Used conceptually by **Distance Vector routing**.

The key equation:

```text id="g7q3n1"
Dₓ(y) = minᵥ [ c(x,v) + Dᵥ(y) ]
```

Meaning:

> Find the minimum-cost route to destination `y` through neighbor `v`.

### Example

```text id="8c5v2k"
A ──2── B ──3── D
```

A reaches D through B:

```text id="9w1p4z"
2 + 3 = 5
```

Therefore:

```text id="2m7k6q"
A → D = 5
```

---

# 4. Dijkstra's Algorithm ⭐⭐⭐⭐⭐

Used in **Link State routing**.

It finds the shortest paths from **one source vertex to all reachable vertices** when edge weights satisfy Dijkstra's requirements (in particular, no negative edge weights).

```text id="v5x9r2"
Source
  ↓
Dijkstra
  ↓
Shortest Path Tree
  ↓
Routing Table
```

---

# 5. Dijkstra Basic Steps

Suppose source = A.

```text id="k2m8q4"
1. Set distance(A) = 0
2. Set all other distances = ∞
3. Select unvisited node with smallest distance
4. Relax its neighbors
5. Mark node visited/finalized
6. Repeat
```

### Relaxation

If:

```text id="f3q7x1"
dist(A→B) = 4
B→C = 3
```

then:

```text id="m8v2k5"
A→C through B = 4 + 3 = 7
```

If 7 is smaller than the currently known distance to C, update it.

---

# 6. Dijkstra vs Bellman-Ford 🔥

| Dijkstra                   | Bellman-Ford                                        |
| -------------------------- | --------------------------------------------------- |
| Link State                 | Distance Vector                                     |
| Shortest Path First        | Distance-vector recurrence                          |
| Non-negative edge weights  | Can handle negative edges in general graph problems |
| Builds shortest-path tree  | Repeated relaxation                                 |
| O(V²) basic implementation | O(VE) typical implementation                        |
| OSPF                       | RIP conceptually                                    |

⚠️ In networking, **RIP is a distance-vector protocol based on Bellman-Ford-style distributed computation**; don't equate the full protocol with the textbook algorithm implementation.

---

# 7. Shortest Path Tree ⭐⭐⭐⭐⭐

Dijkstra produces a **Shortest Path Tree (SPT)** rooted at the source.

Example:

```text id="n3c6v8"
       A
      / \
     B   C
      \ /
       D
```

The selected shortest paths form a tree.

> **SPT is not necessarily the only possible shortest-path tree.**

Equal-cost paths can exist.

---

# 8. Routing Metrics

A routing algorithm needs a **cost/metric**.

Possible metrics:

```text id="z6p4w1"
Hop Count
Cost
Delay
Bandwidth
Reliability
```

The algorithm selects a path according to the metric being used.

### Example

```text id="a9j5r3"
Path A = 3 hops
Path B = 5 hops
```

If metric = hop count:

```text id="5s1k7v"
Path A wins
```

But if metric = another cost, the result may differ.

---

# 9. Relaxation ⭐⭐⭐⭐⭐

A very important concept for numerical questions.

Suppose:

```text id="6f0q3n"
Current dist[C] = 10

dist[A] = 4
A → C = 3
```

New possible distance:

```text id="q7m2v9"
4 + 3 = 7
```

Since:

```text id="1n5k8d"
7 < 10
```

update:

```text id="c8r4x2"
dist[C] = 7
```

This process is called **relaxation**.

---

# 10. Routing Loops

Bad/inconsistent routing information can cause:

```text id="j3k8p2"
A → B → C → A → B → ...
```

Packets circulate instead of reaching the destination.

Distance Vector is particularly associated with the **count-to-infinity** problem.

Techniques such as:

* Split horizon
* Poison reverse

help reduce certain routing loops.

---

# 🔥 GATE Traps

### Trap 1

**Dijkstra is used by Distance Vector.**

❌

```text id="h4m7x9"
Dijkstra      → Link State
Bellman-Ford  → Distance Vector
```

---

### Trap 2

**Dijkstra supports negative edge weights.**

❌ Standard Dijkstra assumes **non-negative edge weights**.

---

### Trap 3

**Shortest path always means minimum number of hops.**

❌ Only when **hop count is the metric**.

---

### Trap 4

**Dijkstra gives only the shortest path to one destination.**

❌ From one source, it computes shortest paths to **all reachable destinations**.

---

# ⚡ 30-Second Revision

```text id="k9w3p5"
ROUTING ALGORITHMS
        ↓
┌───────────────────┐
│ Distance Vector   │
│ → Bellman-Ford    │
│ → RIP             │
└───────────────────┘

┌───────────────────┐
│ Link State        │
│ → Dijkstra / SPF  │
│ → OSPF            │
└───────────────────┘

Relaxation:
new distance
= distance to neighbor
+ neighbor → destination cost

Dijkstra:
Non-negative weights
→ Shortest Path Tree
```

### GATE Priority

**Dijkstra numericals → 🔥🔥🔥🔥🔥**
**Bellman-Ford → 🔥🔥🔥🔥🔥**
**Relaxation → 🔥🔥🔥🔥🔥**
**Shortest Path Tree → 🔥🔥🔥🔥**
**Routing metrics → 🔥🔥🔥🔥**
