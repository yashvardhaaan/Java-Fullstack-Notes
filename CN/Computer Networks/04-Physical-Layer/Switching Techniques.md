# Switching Techniques

## 1. What is Switching?

**Switching = technique used to move data from source to destination through a network of interconnected nodes.**

```text id="w2x3c9"
A → Node → Node → Node → B
```

### First principle

> **Multiplexing shares a link; switching determines how data travels through the network.**

---

# 2. Three Main Switching Techniques ⭐⭐⭐⭐⭐

```text id="x5j4qk"
Switching
├── Circuit Switching
├── Packet Switching
└── Message Switching
```

---

# 3. Circuit Switching ⭐⭐⭐⭐

A **dedicated path** is established before communication.

```text id="q0t2py"
A ── R1 ── R2 ── R3 ── B
     ← Dedicated Circuit →
```

### Phases

```text id="m4x9fs"
1. Setup
2. Data Transfer
3. Teardown
```

### Characteristics

* Dedicated path
* Resources reserved
* Predictable performance after setup
* Setup delay
* Inefficient when the connection is idle

### Example

Traditional telephone networks.

### Key

> **Circuit switching = dedicated path**

---

# 4. Packet Switching ⭐⭐⭐⭐⭐

Data is divided into **packets**.

```text id="e6xkz4"
Message
 ↓
P1  P2  P3
```

Packets are forwarded through the network.

### Two types

#### Datagram

Each packet is treated independently.

```text id="w3b5nq"
P1 → Path A
P2 → Path B
P3 → Path A
```

Packets may arrive:

* out of order
* at different times

**IP uses a datagram-style packet-switched network.**

---

#### Virtual Circuit

A logical path is established before packet transfer.

Packets generally follow the established logical path.

### Important

> **Virtual circuit ≠ physical dedicated circuit.**

---

# 5. Message Switching ⭐⭐

The **entire message** is treated as one unit.

Each intermediate node:

```text id="v8u3jw"
Receive entire message
        ↓
Store
        ↓
Forward
```

This is called:

**Store-and-forward**

### Disadvantage

Large messages require significant buffer/storage.

---

# 6. Store-and-Forward ⭐⭐⭐⭐

A switching node receives data before forwarding it.

```text id="l5v7m1"
Sender
  ↓
Node 1
  ↓ Store
  ↓ Forward
Node 2
  ↓ Store
  ↓ Forward
Receiver
```

Packet switching and message switching can use **store-and-forward**.

---

# 🔥 Comparison

| Feature                      | Circuit                      | Packet                    | Message                 |
| ---------------------------- | ---------------------------- | ------------------------- | ----------------------- |
| Dedicated physical resources | Yes                          | No                        | No                      |
| Data unit                    | Continuous stream            | Packet                    | Entire message          |
| Setup                        | Required                     | Not required for datagram | Not required            |
| Store-and-forward            | Typically no                 | Yes                       | Yes                     |
| Resource efficiency          | Lower when idle              | High                      | High                    |
| Delay                        | Setup + predictable transfer | Variable                  | High for large messages |

---

# 7. Circuit vs Packet ⭐⭐⭐⭐⭐

### Circuit

```text id="j0ccqf"
Dedicated path
     ↓
Reserved resources
     ↓
Predictable after setup
```

### Packet

```text id="6d7y3m"
Shared network
     ↓
Packets compete for resources
     ↓
Variable delay
```

---

# 8. Datagram vs Virtual Circuit

| Datagram                         | Virtual Circuit                              |
| -------------------------------- | -------------------------------------------- |
| Connectionless                   | Connection-oriented                          |
| No prior path setup              | Logical path setup                           |
| Packets can take different paths | Packets generally follow same logical path   |
| May arrive out of order          | Usually ordered through the established path |
| Example: IP                      | Examples: Frame Relay, ATM                   |

---

# 🔥 GATE Traps

### Trap 1

**Packet switching does NOT necessarily mean packets take different paths.**

Only **datagram packet switching** has independently routed packets.

---

### Trap 2

**Virtual circuit is not the same as circuit switching.**

```text
Circuit switching → dedicated resources/path
Virtual circuit   → logical connection
```

---

### Trap 3

**IP is connectionless/datagram-based.**

No path reservation is required before sending each packet.

---

### Trap 4

**Message switching = entire message stored and forwarded.**

Packet switching = **smaller packets** are stored and forwarded.

---

# ⚡ 30-Second Revision

```text id="h9m6lz"
SWITCHING
│
├── Circuit
│   └── Dedicated path
│
├── Packet
│   ├── Datagram → independent packets
│   └── Virtual Circuit → logical path
│
└── Message
    └── Entire message → store & forward
```

### Must remember

> **Circuit → Dedicated**

> **Packet → Shared + Packets**

> **Message → Whole message**

> **Datagram → Connectionless**

> **Virtual Circuit → Logical connection**

### GATE Priority: ⭐⭐⭐⭐

### Placement Priority: ⭐⭐⭐⭐

The most important part for GATE is **circuit vs packet switching + datagram vs virtual circuit + store-and-forward**.
