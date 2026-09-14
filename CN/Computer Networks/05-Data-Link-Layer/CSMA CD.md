# CSMA/CD

## 1. What is CSMA/CD?

**CSMA/CD = Carrier Sense Multiple Access with Collision Detection**

It is a **MAC protocol** used to control access to a **shared communication medium**.

> Mainly associated with **traditional shared, half-duplex Ethernet**.

---

# 2. First Principle

Multiple devices share the same medium:

```text
A ──┐
B ──┼──── Shared Medium
C ──┘
```

If A and B transmit simultaneously:

```text
A ──→
B ──→
    💥 Collision
```

CSMA/CD provides a mechanism to **detect the collision and retry later**.

---

# 3. CSMA Meaning

### Carrier Sense

Before transmitting:

> **Listen to the channel.**

```text
Channel busy? → Wait
Channel idle? → Transmit
```

### Multiple Access

Multiple devices have access to the same shared medium.

### Collision Detection

While transmitting, the station checks whether a collision occurred.

---

# 4. Working of CSMA/CD ⭐⭐⭐⭐⭐

```text
        Start
          ↓
   Sense the channel
          ↓
   ┌──────┴──────┐
 Busy           Idle
  ↓               ↓
 Wait          Transmit
                  ↓
          Collision detected?
             /          \
           Yes           No
            ↓             ↓
     Send jam signal    Success
            ↓
      Backoff algorithm
            ↓
          Retry
```

---

# 5. What Happens During Collision?

When a collision is detected:

### Step 1

Stop transmission.

### Step 2

Send a **jam signal** so other stations know a collision occurred.

### Step 3

Wait for a random backoff period.

### Step 4

Try transmitting again.

---

# 6. Binary Exponential Backoff ⭐⭐⭐⭐⭐

After each collision, the possible waiting period increases.

For the `k`th collision, a random number is chosen from:

```text id="q8t0ba"
0 to 2^k − 1
```

and the station waits:

```text id="5epvjj"
Random number × slot time
```

Example:

### First collision

```text
k = 1

Random choice:
0 or 1
```

### Second collision

```text
k = 2

Random choice:
0, 1, 2, 3
```

### Third collision

```text
k = 3

Random choice:
0 ... 7
```

Thus:

> **More collisions → larger possible backoff.**

---

# 7. Important Ethernet Slot-Time Concept 🔥

For traditional Ethernet:

```text
Slot time = 512 bit-times
```

For **10 Mbps Ethernet**:

```text
512 / 10,000,000
≈ 51.2 μs
```

This is closely related to the minimum Ethernet frame size and the collision-detection timing requirement.

---

# 8. Why Minimum Frame Size?

A sender must still be transmitting when a worst-case collision can propagate back to it.

Therefore Ethernet has a **minimum frame size of 64 bytes** (including the Ethernet header and FCS, excluding the preamble/SFD).

🔥 GATE may connect:

```text
Propagation delay
        ↓
Collision detection
        ↓
Minimum frame size
```

---

# 9. CSMA/CD vs CSMA/CA

| CSMA/CD                                    | CSMA/CA                                        |
| ------------------------------------------ | ---------------------------------------------- |
| Collision **Detection**                    | Collision **Avoidance**                        |
| Traditional shared Ethernet                | Wi-Fi                                          |
| Detect collision after transmission begins | Tries to reduce collision probability          |
| Uses collision detection + backoff         | Uses mechanisms such as backoff, ACKs, RTS/CTS |

### Easy Trick

> **CD → Ethernet**
> **CA → Wi-Fi**

⚠️ Modern switched **full-duplex Ethernet does not normally use CSMA/CD**, because each link is effectively point-to-point and collisions don't occur.

---

# 🔥 GATE Traps

### Trap 1

**CSMA/CD is used by modern Wi-Fi.**

❌ No.

Wi-Fi uses **CSMA/CA**.

---

### Trap 2

**CSMA/CD completely prevents collisions.**

❌ No.

It **detects collisions and handles them**.

---

### Trap 3

**CSMA/CD is required for full-duplex switched Ethernet.**

❌ No.

Full-duplex switched Ethernet eliminates the shared collision environment.

---

### Trap 4

After every collision:

> Backoff range can increase exponentially.

```text
0 → 1 → 3 → 7 → ...
```

for the corresponding collision counts.

---

# ⚡ 30-Second Revision

```text
CSMA/CD
   ↓
Shared Ethernet
   ↓
Sense → Transmit → Detect collision
                       ↓
                  Jam signal
                       ↓
                 Random backoff
                       ↓
                     Retry

Binary Exponential Backoff:
k-th collision → random [0, 2^k − 1]

Traditional Ethernet:
Slot time = 512 bit-times
Minimum frame = 64 bytes

CSMA/CD → Ethernet
CSMA/CA → Wi-Fi
```

### GATE Priority

**Binary Exponential Backoff → 🔥🔥🔥🔥🔥**
**Collision/propagation/slot-time numericals → 🔥🔥🔥🔥🔥**
**CSMA/CD vs CSMA/CA → 🔥🔥🔥🔥**
