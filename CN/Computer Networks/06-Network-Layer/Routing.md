# Routing

## 1. What is Routing?

**Routing** is the process of determining the **path a packet should take** from source network to destination network.

> **Routing = Path determination**

```text id="e6k4qf"
Source
  ↓
Router 1
  ↓
Router 2
  ↓
Router 3
  ↓
Destination
```

---

# 2. Routing vs Forwarding ⭐⭐⭐⭐⭐

This distinction is extremely important.

### Routing

Determines:

> **Which path should the packet take?**

### Forwarding

Actually moves the packet:

> **Which outgoing interface/next hop should be used?**

```text id="z6v1k8"
Routing
   ↓
Build routing information
   ↓
Forwarding table
   ↓
Forwarding
   ↓
Send packet to next hop
```

### Easy Trick

> **Routing = decide**
> **Forwarding = deliver**

---

# 3. Routing Table

A router maintains a **routing table**.

Example:

| Destination     | Next Hop | Interface |
| --------------- | -------- | --------- |
| `10.0.0.0/8`    | R1       | eth0      |
| `172.16.0.0/16` | R2       | eth1      |
| `0.0.0.0/0`     | R3       | eth2      |

When a packet arrives:

```text id="h2b6p9"
Destination IP
      ↓
Routing table lookup
      ↓
Best matching route
      ↓
Next hop / interface
```

---

# 4. Longest Prefix Matching 🔥🔥🔥🔥🔥

If multiple routes match the destination:

> Router chooses the **most specific / longest prefix match**.

Example:

```text id="e3m7cy"
10.0.0.0/8
10.1.0.0/16
10.1.2.0/24
```

Destination:

```text id="3y4s1e"
10.1.2.50
```

All three match.

Router chooses:

```text id="8w9b5s"
10.1.2.0/24
```

because `/24` is the longest prefix.

---

# 5. Default Route

If no more specific route matches:

```text id="d8a0r9"
0.0.0.0/0
```

can be used as the **IPv4 default route**.

```text id="h7x5m3"
Specific route exists?
       ↓
      Yes → use it
       ↓ No
Default route
```

🔥 `/0` matches every IPv4 destination, but it is the **least specific** route.

---

# 6. Static vs Dynamic Routing

### Static Routing

Routes are manually configured.

```text id="7j1y0k"
Administrator
     ↓
Routing table
```

Advantages:

* Simple for small networks
* Predictable
* No routing-protocol overhead

Disadvantages:

* Doesn't automatically adapt to failures
* Difficult to maintain at scale

---

### Dynamic Routing

Routers exchange routing information using routing protocols.

```text id="f4y3n7"
Router A ↔ Router B ↔ Router C
```

Advantages:

* Adapts to topology changes
* Suitable for larger networks

---

# 7. Main Routing Approaches ⭐⭐⭐⭐⭐

For GATE, know:

```text id="b5j8o0"
Routing
│
├── Distance Vector
│
└── Link State
```

### Distance Vector

Router learns:

> **Distance + direction/next hop**

Example protocol:

```text id="o7u5r3"
RIP
```

### Link State

Router learns the network topology/link states and computes shortest paths.

Example:

```text id="p9a3q1"
OSPF
```

🔥 These deserve separate detailed study.

---

# 8. Routing Metrics

A routing protocol may use metrics such as:

* Hop count
* Cost
* Delay
* Bandwidth
* Reliability

The exact metric depends on the routing protocol.

### Example

```text id="n4f6s8"
Path A → 3 hops
Path B → 5 hops
```

If the protocol uses **hop count**, Path A is preferred.

⚠️ The path with fewer hops is **not universally the fastest path**.

---

# 9. Routing Algorithm

A routing algorithm determines the preferred path using available network information and metrics.

Important algorithms:

### Bellman-Ford

Associated with:

> **Distance Vector**

### Dijkstra

Associated with:

> **Link State**

🔥 Memorize:

```text id="h8c4x2"
Distance Vector → Bellman-Ford
Link State      → Dijkstra
```

---

# 10. Autonomous Systems

The Internet is divided into **Autonomous Systems (ASes)**.

```text id="6a7f3k"
        Internet
           │
    ┌──────┴──────┐
    AS 1          AS 2
```

### IGP

**Interior Gateway Protocol**

Used **within** an AS.

Examples:

* RIP
* OSPF
* IS-IS

### EGP

Routing **between** autonomous systems.

The major modern inter-domain routing protocol is:

> **BGP**

---

# 🔥 GATE Traps

### Trap 1

**Routing and forwarding are the same.**

❌

```text id="q1x5w9"
Routing   → path decision
Forwarding → packet movement
```

---

### Trap 2

**Router always chooses the route with minimum hop count.**

❌ Depends on the routing protocol/metric.

---

### Trap 3

**Longest prefix means shortest numerical prefix.**

❌

```text id="1s8d4k"
/24 is more specific than /16
```

---

### Trap 4

**Default route is the most specific route.**

❌

```text id="q5g2b7"
0.0.0.0/0 → least specific
```

---

### Trap 5

**Dijkstra → Distance Vector**

❌

```text id="c0v6y2"
Bellman-Ford → Distance Vector
Dijkstra     → Link State
```

---

# ⚡ 30-Second Revision

```text id="u7k3m5"
ROUTING
   ↓
Determine path

Routing:
Path decision

Forwarding:
Actually send packet

Routing table:
Destination → Next hop → Interface

Multiple matches:
Longest Prefix Match

Default:
0.0.0.0/0

Static → manually configured
Dynamic → routing protocols

Distance Vector → Bellman-Ford
Link State      → Dijkstra

Within AS  → IGP
Between AS → BGP
```

### GATE Priority

**Routing vs Forwarding → 🔥🔥🔥🔥🔥**
**Longest Prefix Matching → 🔥🔥🔥🔥🔥**
**Routing tables → 🔥🔥🔥🔥🔥**
**Distance Vector / Link State → 🔥🔥🔥🔥🔥**
**Dijkstra / Bellman-Ford → 🔥🔥🔥🔥🔥**
