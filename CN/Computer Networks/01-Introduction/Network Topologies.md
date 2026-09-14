# 04 — Network Topologies

## 1. Network Topology

**Topology = arrangement of devices (nodes) and links in a network.**

Two types:

* **Physical topology** → actual physical arrangement
* **Logical topology** → how data logically flows

---

## 2. Bus Topology

All devices share **one common backbone cable**.

```text
A ── B ── C ── D
───────────────
   Backbone
```

### Advantages

* Simple
* Low cost
* Less cable

### Disadvantages

* Backbone failure → entire network affected
* Difficult troubleshooting
* Collisions possible
* Performance decreases as devices increase

**GATE:** Terminators are required at the ends of the bus to prevent signal reflection.

---

## 3. Star Topology ⭐

Every device connects to a **central device**.

```text
       A
       |
B ── Switch ── C
       |
       D
```

Central device may be a **switch/hub**.

### Advantages

* Easy to install/manage
* Easy fault detection
* Failure of one link affects only one device
* Easy to expand

### Disadvantage

* Central device failure → network communication is disrupted

**Most common LAN topology today:** Star.

---

## 4. Ring Topology

Each device connects to **two neighboring devices**, forming a ring.

```text
A ── B
|    |
D ── C
```

### Advantages

* Predictable access
* Can avoid collisions with token-based protocols

### Disadvantages

* Link/node failure can affect communication
* Adding/removing devices can be difficult

---

## 5. Mesh Topology

Devices have multiple direct connections.

### Full Mesh

Every device connects to **every other device**.

For **n devices**:

$$
\boxed{\text{Links}=\frac{n(n-1)}{2}}
$$

### Example: 4 devices

$$
\frac{4(4-1)}{2}=6
$$

### Advantages

* Very reliable
* Multiple alternate paths
* No single link failure necessarily disconnects nodes

### Disadvantages

* Expensive
* Requires many links
* Complex installation

### 🔥 GATE Formula

$$
\boxed{L=\frac{n(n-1)}{2}}
$$

---

## 6. Tree Topology

Hierarchical combination of star networks.

```text
          Core
        /      \
      SW1      SW2
     /  \      /  \
    A    B    C    D
```

### Advantages

* Scalable
* Easy hierarchical management

### Disadvantage

* Failure of an upper-level device/link can affect an entire branch.

---

## 7. Hybrid Topology

Combination of **two or more topologies**.

Example:

```text
Star + Bus
Star + Ring
```

Used in large real-world networks.

---

# 🔥 Quick Comparison

| Topology   | Main Idea                | Major Problem          |
| ---------- | ------------------------ | ---------------------- |
| **Bus**    | Common backbone          | Backbone failure       |
| **Star**   | Central device           | Central device failure |
| **Ring**   | Closed loop              | Break can disrupt ring |
| **Mesh**   | Multiple/all connections | Expensive              |
| **Tree**   | Hierarchical             | Upper-level failure    |
| **Hybrid** | Combination              | Complexity             |

---

# 🧠 GATE Must Remember

### Full Mesh

$$
\boxed{\frac{n(n-1)}{2}}
$$

### Star

**Central device is the key point of failure.**

### Bus

**One shared medium → collisions can occur.**

### Mesh

**Highest redundancy + highest cost.**

### Physical vs Logical

> **Physical topology = how devices/links are physically arranged.**

> **Logical topology = how communication/data flows.**

---

### ⭐ Priority

**GATE: ⭐⭐⭐⭐**
**Placement: ⭐⭐⭐⭐**

Focus mainly on **star, bus, ring, mesh + full-mesh formula + physical vs logical topology**.
