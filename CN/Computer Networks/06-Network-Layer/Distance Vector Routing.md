# Distance Vector Routing

## 1. What is Distance Vector Routing?

In **Distance Vector (DV) routing**, each router maintains information about:

* **Distance** → cost to reach a destination
* **Vector** → direction/next hop to reach it

> **DV = “How far + through whom?”**

---

# 2. Basic Idea ⭐⭐⭐⭐⭐

Each router initially knows only its **directly connected neighbors**.

Routers periodically exchange their routing information with neighbors.

```text id="g0p8m2"
       2
A ───────── B
│           │
1           3
│           │
C ───────── D
       4
```

A learns about destinations through neighboring routers.

---

# 3. Routing Table

A typical DV table contains:

| Destination | Cost | Next Hop |
| ----------- | ---: | -------- |
| A           |    0 | —        |
| B           |    2 | B        |
| C           |    1 | C        |
| D           |    5 | C        |

The router chooses the best known route based on the routing metric.

---

# 4. Bellman-Ford Equation ⭐⭐⭐⭐⭐

The fundamental DV equation is:

```text id="q3gq5m"
Dₓ(y) = minᵥ [ c(x,v) + Dᵥ(y) ]
```

Meaning:

> Cost from router `x` to destination `y` = minimum cost through any neighbor `v`.

### Simple version

```text id="3m8t1d"
Cost via neighbor
=
Cost to neighbor
+
Neighbor's cost to destination
```

Choose the **minimum**.

---

# 5. Example

Suppose:

```text id="g6j7c2"
A → B = 2
B → D = 3
```

A can reach D through B:

```text id="3q3m4q"
A → B → D
```

Cost:

```text id="7h0m5e"
2 + 3 = 5
```

Therefore:

```text id="a1f5t7"
A → D = 5
Next hop = B
```

---

# 6. Distance Vector Updates

Suppose:

```text id="5k4s2w"
A ──2── B ──3── C
```

Initially A knows:

```text id="z2h7q0"
A → B = 2
```

B tells A:

```text id="f8t6p1"
B → C = 3
```

A calculates:

```text id="4v5m1k"
A → C = 2 + 3 = 5
```

So A updates its table:

```text id="e6z0p3"
C → cost 5 → next hop B
```

---

# 7. Count-to-Infinity Problem ⭐⭐⭐⭐⭐

One of the most important DV concepts.

Consider:

```text id="m8d3x2"
A ──1── B ──1── C
```

Suppose C becomes unreachable.

B may incorrectly believe:

```text id="2j9v1b"
C is reachable through A
```

while A believes:

```text id="5n4f0c"
C is reachable through B
```

They keep increasing the metric:

```text id="1s5w8m"
2 → 3 → 4 → 5 → 6 → ...
```

This is called:

> **Count-to-infinity problem**

🔥 Very important for GATE.

---

# 8. Split Horizon ⭐⭐⭐⭐⭐

A technique used to reduce routing loops.

### Rule:

> **Do not advertise a route back through the interface from which that route was learned.**

Example:

```text id="6t4q9k"
A ← route to C ← B
```

B learned the route to C through A.

B should not advertise that route back to A.

```text id="w6v5n1"
Learn from A
    ↓
Don't advertise same route back to A
```

---

# 9. Poison Reverse

A stronger form of split horizon.

Instead of simply not advertising the route:

> Advertise it with an **infinite metric**.

Conceptually:

```text id="v0j4t7"
Route learned through A
        ↓
Advertise back to A
        ↓
Cost = ∞
```

This tells A:

> “Do not use me to reach that destination.”

---

# 10. RIP

**RIP = Routing Information Protocol**

RIP is a classic example of a **Distance Vector** routing protocol.

Metric:

> **Hop count**

Maximum usable hop count:

```text id="0av7t8"
15
```

A metric of:

```text id="5r8m2x"
16 = unreachable
```

🔥 GATE frequently asks this.

---

# 11. DV vs Link State

| Distance Vector                           | Link State                         |
| ----------------------------------------- | ---------------------------------- |
| Shares routing information with neighbors | Distributes link-state information |
| Knows distance + direction                | Builds topology view               |
| Bellman-Ford                              | Dijkstra                           |
| Can suffer count-to-infinity              | Not the same DV problem            |
| Example: RIP                              | Example: OSPF                      |

### Easy Trick

```text id="l5s3c7"
DV → Bellman-Ford → RIP
LS → Dijkstra → OSPF
```

---

# 🔥 GATE Traps

### Trap 1

**Distance Vector uses Dijkstra.**

❌

> DV → **Bellman-Ford**

---

### Trap 2

**RIP uses bandwidth as its primary metric.**

❌

> RIP → **Hop count**

---

### Trap 3

**RIP allows 16 hops.**

Careful:

```text id="d8p2y1"
15 → maximum usable
16 → infinity/unreachable
```

---

### Trap 4

**Split horizon completely eliminates all routing loops.**

❌ It helps prevent certain loops but is not a universal solution.

---

# ⚡ 30-Second Revision

```text id="z5k8w2"
DISTANCE VECTOR
       ↓
Distance + Direction
       ↓
Exchange with neighbors
       ↓
Bellman-Ford

Dₓ(y) = min [c(x,v) + Dᵥ(y)]

Important:
├── Count-to-Infinity
├── Split Horizon
└── Poison Reverse

RIP:
├── Distance Vector
├── Hop-count metric
├── 15 → maximum usable
└── 16 → infinity

DV → Bellman-Ford
LS → Dijkstra
```

### GATE Priority

**Bellman-Ford calculation → 🔥🔥🔥🔥🔥**
**Count-to-Infinity → 🔥🔥🔥🔥🔥**
**Split Horizon / Poison Reverse → 🔥🔥🔥🔥**
**RIP hop count → 🔥🔥🔥🔥🔥**
