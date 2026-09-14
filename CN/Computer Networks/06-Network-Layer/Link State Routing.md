# Link State Routing

## 1. What is Link State Routing?

In **Link State (LS) routing**, each router learns the **state/cost of network links** and builds a map of the network topology.

> **Link State = “What does the network look like?”**

---

# 2. Basic Idea ⭐⭐⭐⭐⭐

Each router:

```text id="1l6f42"
1. Discover neighbors
        ↓
2. Determine link costs
        ↓
3. Create Link-State information
        ↓
4. Flood it through the network
        ↓
5. Build topology database
        ↓
6. Run Dijkstra
        ↓
7. Build routing table
```

---

# 3. Example

Network:

```text id="k2r7p1"
      2
 A ─────── B
 |         |
 5         3
 |         |
 C ─────── D
      1
```

A learns the topology:

```text id="j5m8s0"
A—B = 2
A—C = 5
B—D = 3
C—D = 1
```

A can then calculate the shortest path to every destination.

---

# 4. Dijkstra's Algorithm ⭐⭐⭐⭐⭐

Link State routing commonly uses **Dijkstra's Shortest Path First (SPF)** algorithm.

> **Dijkstra → Link State**

The router calculates the shortest-path tree with itself as the root.

Example:

```text id="n8q4x6"
        A
       / \
      B   C
       \ /
        D
```

A computes the minimum-cost path to each destination.

---

# 5. Link-State Advertisement

Routers generate information describing their local links.

This information is distributed/flooded through the routing domain.

Conceptually:

```text id="j1d7c9"
Router A
   ↓
Link-State Information
   ↓
Flood
   ↓
All relevant routers
```

Each router eventually builds a **link-state database (LSDB)**.

---

# 6. Link-State Database

The LSDB represents the network topology known to the router.

```text id="8m3x5v"
LSDB
 ↓
Complete topology information
 ↓
Dijkstra
 ↓
Shortest Path Tree
 ↓
Routing Table
```

🔥 This is the key difference from Distance Vector.

---

# 7. Link State vs Distance Vector ⭐⭐⭐⭐⭐

| Link State                    | Distance Vector                              |
| ----------------------------- | -------------------------------------------- |
| Learns topology/link states   | Learns distance + direction                  |
| Floods link-state information | Exchanges routing information with neighbors |
| Builds topology database      | Maintains distance vectors                   |
| Dijkstra                      | Bellman-Ford                                 |
| SPF                           | Bellman-Ford-based updates                   |
| Example: OSPF                 | Example: RIP                                 |
| Faster convergence generally  | Can suffer count-to-infinity                 |

### Easy Trick

```text id="q7f1n3"
DV → "How far?"
LS → "What is the topology?"
```

---

# 8. OSPF

**OSPF = Open Shortest Path First**

It is a major **Link State** routing protocol.

```text id="c6h0x2"
OSPF
 ↓
Link State
 ↓
Dijkstra / SPF
```

OSPF uses a **cost** metric rather than RIP's simple hop-count metric.

---

# 9. Convergence ⭐⭐⭐⭐

**Convergence** means routers have reached a consistent view of the network after a topology change.

Example:

```text id="2h9r6q"
Link fails
   ↓
Routing information updated
   ↓
Routers recalculate paths
   ↓
Network converges
```

Link-state protocols generally converge faster than basic distance-vector protocols, though actual behavior depends on protocol/configuration.

---

# 10. Advantages

### Link State

✅ Better topology knowledge
✅ Generally faster convergence
✅ More suitable for large networks
✅ Less prone to classic count-to-infinity behavior

### Disadvantages

❌ More memory required
❌ More CPU processing
❌ More complex than basic DV

---

# 🔥 GATE Traps

### Trap 1

**Link State uses Bellman-Ford.**

❌

> Link State → **Dijkstra**

---

### Trap 2

**OSPF is Distance Vector.**

❌

> OSPF → **Link State**

---

### Trap 3

**Link State routers only know their direct neighbors.**

❌

They build a topology database from flooded link-state information.

---

### Trap 4

**Dijkstra directly creates the routing table from nothing.**

Not exactly.

```text id="y5v1c8"
Link-State information
        ↓
Topology / LSDB
        ↓
Dijkstra
        ↓
Shortest Path Tree
        ↓
Routing table
```

---

# ⚡ 30-Second Revision

```text id="e3f7w1"
LINK STATE
     ↓
Learn link states
     ↓
Flood information
     ↓
Build LSDB
     ↓
Dijkstra / SPF
     ↓
Shortest Path Tree
     ↓
Routing Table

Example:
OSPF → Link State

Compare:
DV → Bellman-Ford → RIP
LS → Dijkstra     → OSPF
```

### GATE Priority

**Dijkstra numericals → 🔥🔥🔥🔥🔥**
**Link State vs Distance Vector → 🔥🔥🔥🔥🔥**
**OSPF → 🔥🔥🔥🔥**
**LSDB/flooding/convergence → 🔥🔥🔥🔥**
