# Physical Layer — OSI Layer 1

## 1. What is the Physical Layer?

**Physical Layer = responsible for transmitting raw bits (0s and 1s) over a physical medium.**

```text
10110101
   ↓
Electrical / Optical / Radio signal
   ↓
Medium
   ↓
Receiver
```

### First principle

> **L1 answers: "How do I physically transmit a bit?"**

---

## 2. Main Responsibilities

* Bit transmission
* Signal representation
* Transmission medium
* Data rate
* Physical topology
* Synchronization
* Connectors/interfaces

---

## 3. What Does L1 NOT Understand?

Physical layer does **not** understand:

* MAC addresses
* IP addresses
* Port numbers
* Packets
* Frames
* Routing

It only deals with **bits and signals**.

---

# 4. Bit vs Signal ⭐

A computer works with:

```text
0 / 1
```

But the physical medium carries a **signal**.

```text
Bits → Encoding/Modulation → Signal → Medium
```

Example:

```text
Bits:     1 0 1 1 0
Signal:   ──__───__
```

The exact signal representation depends on the technology.

---

# 5. Transmission Media

Two broad categories:

### Guided / Wired

Signal follows a physical path.

* Twisted-pair cable
* Coaxial cable
* Optical fiber

### Unguided / Wireless

Signal propagates through space.

* Radio
* Microwave
* Infrared

### Trick

> **Guided → cable**

> **Unguided → air/space**

---

# 6. Data Rate

**Data rate = number of bits transmitted per second.**

Unit:

$$
\text{bps} = \text{bits/second}
$$

Examples:

```text
1 Mbps = 10⁶ bits/s
1 Gbps = 10⁹ bits/s
```

### Don't confuse:

**bps ≠ Bytes/s**

$$
1\ Byte = 8\ bits
$$

---

# 7. Bandwidth

In networking, bandwidth can refer to the **capacity/rate of a communication channel**.

Example:

```text
100 Mbps link
```

means the nominal capacity is 100 million bits/s.

### Important distinction

```text
Bandwidth → Capacity
Throughput → Actual achieved rate
```

---

# 8. Physical Layer Devices

| Device     | Layer  |
| ---------- | ------ |
| Repeater   | **L1** |
| Hub        | **L1** |
| Cables     | L1     |
| Connectors | L1     |

### GATE Trick

> **If a device only regenerates/forwards signals without understanding addresses → think L1.**

---

# 9. Transmission Modes

### Simplex

One-way communication.

```text
A ─────→ B
```

Example: traditional TV broadcast.

### Half-Duplex

Both directions, but **not simultaneously**.

```text
A ───→ B
A ←─── B
```

Example: walkie-talkie.

### Full-Duplex

Both directions **simultaneously**.

```text
A ⇄ B
```

Example: telephone conversation.

### Trick

**Simplex = one way**

**Half = both, one at a time**

**Full = both simultaneously**

---

# 10. Physical Layer Performance Factors

Important concepts:

### Propagation Delay

Time taken by the signal to travel through the medium.

$$
T_p=\frac{\text{Distance}}{\text{Propagation Speed}}
$$

### Transmission Delay

Time required to push all bits onto the link.

$$
T_t=\frac{\text{Packet Size}}{\text{Data Rate}}
$$

🔥 **GATE distinction:**

```text
Propagation delay
→ movement through medium

Transmission delay
→ putting bits onto link
```

---

# 11. GATE Must Know

### Formula 1

$$
\boxed{T_p=\frac{d}{v}}
$$

### Formula 2

$$
\boxed{T_t=\frac{L}{R}}
$$

where:

* \(d\) = distance
* \(v\) = propagation speed
* \(L\) = packet length in bits
* \(R\) = transmission rate in bps

---

# 🔥 Common GATE Traps

### Trap 1

A **larger packet** increases transmission delay.

But it does **not necessarily increase propagation delay**.

---

### Trap 2

Increasing bandwidth/data rate:

$$
T_t \downarrow
$$

but propagation delay remains approximately unchanged.

---

### Trap 3

Fiber optic communication uses **light**, not electrical signals.

---

# ⚡ Quick Revision

```text
L1 = Bits + Signals + Medium

Guided:
Twisted Pair
Coaxial
Fiber

Unguided:
Radio
Microwave
Infrared

Simplex → One way
Half     → Both, one at a time
Full     → Both simultaneously
```

### Most important formulas

$$
\boxed{T_p=d/v}
$$

$$
\boxed{T_t=L/R}
$$

### GATE Priority: ⭐⭐⭐

**Focus mainly on transmission delay vs propagation delay, transmission media, data rate, bandwidth, and signal/bit concepts.**
