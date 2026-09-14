# 02 — Network Criteria

## 1. Network Criteria

The **quality of a network** is mainly evaluated using:

1. **Performance**
2. **Reliability**
3. **Security**

---

## 2. Performance

Measures **how efficiently data is transferred**.

Important measures:

### Bandwidth

Maximum capacity of a communication link.

> Higher bandwidth → potentially more data can be transmitted per second.

### Throughput

**Actual rate** at which data is successfully transferred.

```text
Bandwidth = maximum possible
Throughput = actual achieved
```

### Latency / Delay

Time required for data to travel from source to destination.

> Lower latency → faster response.

---

## 3. Reliability

Measures the network's ability to **operate correctly and continuously**.

Affected by:

* Failure frequency
* Recovery time
* Fault tolerance
* Availability

### Availability

$$
Availability = \frac{Uptime}{Uptime + Downtime}
$$

Higher availability → more reliable network.

---

## 4. Security

Protects network resources and data against unauthorized access and attacks.

Three fundamental goals:

### CIA Triad

**C — Confidentiality**

> Only authorized users can access data.

**I — Integrity**

> Data should not be modified improperly.

**A — Availability**

> Services/data should remain accessible to authorized users.

### Trick

**CIA = Confidentiality + Integrity + Availability**

---

# 🔥 GATE Traps

### Bandwidth vs Throughput

```text
Bandwidth → Capacity
Throughput → Actual rate
```

A 100 Mbps link does **not** necessarily provide 100 Mbps throughput.

---

### Reliability vs Security

```text
Reliability → Does the network work correctly?
Security    → Is the network protected?
```

---

# 📌 Quick Revision

| Criterion        | Meaning                             |
| ---------------- | ----------------------------------- |
| **Performance**  | How fast/efficient                  |
| **Reliability**  | How consistently it works           |
| **Security**     | How well it protects data/resources |
| **Bandwidth**    | Maximum capacity                    |
| **Throughput**   | Actual transfer rate                |
| **Latency**      | Delay                               |
| **Availability** | Uptime proportion                   |

### GATE Priority: ⭐⭐⭐

**Must know:** Bandwidth, throughput, latency, reliability, availability, CIA triad.
