````md id="transport-congestion-control"
# Transport Layer — Congestion Control

## 1. Definition

**Congestion Control** prevents excessive traffic from overwhelming the network.

> **Flow control protects the receiver; congestion control protects the network.**

```text
Many Senders
     ↓
   Routers
     ↓
Traffic exceeds network capacity
     ↓
  Congestion
````

---

# 2. What Happens During Congestion? ⭐⭐⭐⭐⭐

When too much traffic enters the network:

```text
Queue increases
     ↓
Delay increases
     ↓
Packets may be dropped
     ↓
Retransmissions increase
     ↓
Traffic increases further
```

This can cause **congestion collapse** if uncontrolled.

---

# 3. TCP Congestion Control

TCP mainly controls the sending rate using:

```text
cwnd = Congestion Window
```

The sender limits outstanding data based on the congestion window.

Combined with receiver flow control:

```text id="2b1v9q"
Effective Sending Window
        =
min(cwnd, rwnd)
```

---

# 4. Important TCP Variables ⭐⭐⭐⭐⭐

| Variable   | Meaning                      |
| ---------- | ---------------------------- |
| `cwnd`     | Congestion window            |
| `rwnd`     | Receiver's advertised window |
| `ssthresh` | Slow-start threshold         |
| `MSS`      | Maximum Segment Size         |

Remember:

```text
cwnd → Network
rwnd → Receiver
```

---

# 5. Slow Start ⭐⭐⭐⭐⭐

Despite its name, TCP **increases its sending rate rapidly** during slow start.

Initially:

```text
cwnd = small
```

As ACKs arrive:

```text
cwnd ↑ rapidly
```

Approximately:

```text
1 MSS
2 MSS
4 MSS
8 MSS
16 MSS
...
```

So cwnd grows approximately **exponentially per RTT** during the idealized slow-start phase.

---

# 6. Congestion Avoidance ⭐⭐⭐⭐⭐

When:

```text
cwnd ≥ ssthresh
```

TCP generally enters **Congestion Avoidance**.

Growth becomes approximately linear:

```text
cwnd ↑ slowly
```

Classic simplified behavior:

```text
Slow Start:
Exponential growth

Congestion Avoidance:
Linear growth
```

---

# 7. TCP Congestion Window Graph ⭐⭐⭐⭐⭐

Classic TCP behavior:

```text
cwnd
 ↑
 |                 /\
 |               /   \
 |             /      \
 |           /         \
 |         /            \
 |       /               \
 |     /                  \
 |   /                     \
 +------------------------------→ Time
     Slow       Congestion
     Start      Avoidance
```

When congestion is detected:

```text
cwnd decreases
```

Then TCP increases again according to the congestion-control algorithm.

---

# 8. Congestion Detection

TCP can infer congestion from events such as:

### Timeout

Usually indicates serious congestion.

```text
Timeout
   ↓
Strong reduction in sending rate
```

### Duplicate ACKs

Can indicate packet loss while later data is arriving.

```text
Duplicate ACKs
      ↓
Fast Retransmit
      ↓
Congestion response
```

---

# 9. TCP Tahoe vs Reno ⭐⭐⭐⭐

### Tahoe

On congestion/loss:

```text
cwnd → 1 MSS
ssthresh → roughly half of previous cwnd
```

Then slow start begins again.

### Reno

For **3 duplicate ACKs**, classic Reno performs:

```text
Fast Retransmit
      ↓
Fast Recovery
```

and reduces the congestion window rather than dropping all the way to 1 MSS.

For a **timeout**, Reno also falls back to slow start with a much smaller cwnd.

🔥 For GATE, understand the behavior rather than memorizing implementation details beyond what the question specifies.

---

# 10. AIMD ⭐⭐⭐⭐⭐

**AIMD = Additive Increase, Multiplicative Decrease**

### Additive Increase

During congestion avoidance:

```text
cwnd increases gradually
```

### Multiplicative Decrease

When congestion is detected:

```text
cwnd decreases significantly
```

Classic idea:

```text
Increase → slowly
Decrease → sharply
```

This helps TCP share network capacity fairly.

---

# 11. Slow Start vs Congestion Avoidance

| Feature       | Slow Start                           | Congestion Avoidance      |
| ------------- | ------------------------------------ | ------------------------- |
| Growth        | Exponential-ish                      | Linear                    |
| Purpose       | Quickly discover capacity            | Carefully increase rate   |
| Controlled by | `cwnd`, `ssthresh`                   | `cwnd`                    |
| Trigger       | Connection start / after severe loss | After reaching `ssthresh` |

---

# 12. Flow Control vs Congestion Control ⭐⭐⭐⭐⭐

```text
                 TCP
                  |
        +---------+---------+
        |                   |
   Flow Control       Congestion Control
        |                   |
      rwnd                 cwnd
        |                   |
   Receiver              Network
```

### Easy trick

> **R = Receiver → rwnd**
> **C = Congestion → cwnd**

---

# 🔥 GATE Traps

### Trap 1

Slow Start means cwnd increases slowly.

❌

> Slow Start is actually **rapid/exponential-ish growth**.

---

### Trap 2

`rwnd` handles congestion.

❌

> `rwnd` → flow control
> `cwnd` → congestion control

---

### Trap 3

Congestion control guarantees zero packet loss.

❌

It attempts to **avoid/reduce congestion**; packet loss can still occur.

---

### Trap 4

Timeout and duplicate ACKs always produce exactly the same TCP response.

❌

Their responses can differ depending on the TCP congestion-control algorithm.

---

### Trap 5

Congestion avoidance is exponential.

❌

Classic simplified TCP:

```text
Slow Start       → exponential-ish
Congestion Avoidance → linear
```

---

# ⚡ 30-Second Revision

```text
CONGESTION CONTROL
        ↓
Protect network
        ↓
TCP uses cwnd
        ↓
Slow Start
   ↓
Exponential-ish growth
   ↓
ssthresh
   ↓
Congestion Avoidance
   ↓
Linear growth
   ↓
Loss/congestion
   ↓
Reduce cwnd
```

### Most Important Formula

```text
Effective Window = min(cwnd, rwnd)
```

### Key Concept

```text
rwnd → receiver capacity
cwnd → network capacity
```

### GATE Priority

**🔥🔥🔥🔥🔥 — Extremely High**

Especially important for **GATE numericals** involving:

* `cwnd`
* `ssthresh`
* Slow Start
* Congestion Avoidance
* Timeout
* Duplicate ACKs
* Tahoe vs Reno
* AIMD

```
```
