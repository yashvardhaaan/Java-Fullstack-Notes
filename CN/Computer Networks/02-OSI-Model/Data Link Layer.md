# Data Link Layer — OSI Layer 2

## 1. What is the Data Link Layer?

**L2 = reliable node-to-node delivery over a single link.**

```text
Host A ───── Switch ───── Host B
        ← Data Link →
```

### First principle

> **L2 answers: "How do I deliver this frame to the next directly connected device?"**

---

## 2. Main Responsibilities

* **Framing**
* **MAC addressing**
* **Error detection**
* **Flow control** *(depending on protocol)*
* **Medium access control**

---

# 3. Framing ⭐⭐⭐⭐⭐

Network layer gives L2 a **packet**.

L2 packages it into a **frame**:

```text
[Header][ Network Packet ][Trailer]
          ↓
        Frame
```

### Why framing?

The receiver needs to know:

> **Where does one frame start and where does it end?**

---

# 4. MAC Address ⭐⭐⭐⭐⭐

A **MAC address** is a link-layer address used for communication on the local network.

Example:

```text
00:1A:2B:3C:4D:5E
```

### Think:

```text
IP  → Which network/host?
MAC → Which device on this local link?
```

---

# 5. Node-to-Node Delivery

Data Link Layer works over a **single link**.

Example:

```text
A ── R1 ── R2 ── B
```

There are multiple links:

```text
A → R1
R1 → R2
R2 → B
```

L2 handles delivery **one link at a time**.

L3 handles the overall packet journey.

### 🔥 GATE

> **L2 = node-to-node**

> **L3 = network-to-network / routing**

---

# 6. Error Detection ⭐⭐⭐⭐⭐

Frames can be corrupted during transmission.

L2 can detect errors using mechanisms such as:

* Parity
* Checksum
* **CRC**

### CRC is especially important for GATE.

Basic idea:

```text
Sender
Data → CRC calculation → Frame

Receiver
Frame → CRC check → Error / No error
```

**Detection ≠ correction**

> Detecting an error does not necessarily mean L2 can correct it.

---

# 7. MAC / Medium Access Control

When multiple devices share a medium:

```text
A ─┐
B ─┼── Shared Medium
C ─┘
```

They need rules for:

> **Who gets to transmit and when?**

This is **Medium Access Control (MAC)**.

Examples:

* CSMA/CD
* CSMA/CA

---

# 8. Ethernet

Ethernet is a major **Data Link Layer technology**.

It uses:

* Frames
* MAC addresses
* Ethernet header/trailer

Modern switched Ethernet is generally **full-duplex**, so collisions are not the normal operating mechanism.

---

# 9. Data Link Sublayers

IEEE 802 networks commonly divide L2 into:

```text
Data Link
├── LLC
└── MAC
```

### LLC

**Logical Link Control**

### MAC

**Media Access Control**

For GATE, remember:

> **MAC sublayer handles medium-access-related functions and MAC addressing.**

---

# 10. L2 Devices

| Device | Layer  |
| ------ | ------ |
| Bridge | **L2** |
| Switch | **L2** |
| Hub    | L1     |
| Router | L3     |

### Trick

**Switch → MAC → Frame → L2**

---

# 🔥 L2 vs L3

| Feature       | Data Link    | Network         |
| ------------- | ------------ | --------------- |
| Layer         | L2           | L3              |
| PDU           | Frame        | Packet          |
| Address       | MAC          | IP              |
| Delivery      | Node-to-node | Across networks |
| Device        | Switch       | Router          |
| Main function | Framing      | Routing         |

---

# 🧠 GATE Traps

### Trap 1

❌ MAC address belongs to Network Layer.

✅ **MAC → Data Link**

---

### Trap 2

❌ Switch uses IP to make normal Layer-2 forwarding decisions.

✅ **Switch primarily uses MAC addresses.**

---

### Trap 3

❌ L2 provides end-to-end delivery across the Internet.

✅ L2 provides **link/node-to-node delivery**.

---

### Trap 4

**Frame ≠ Packet**

```text
Packet → L3
Frame  → L2
```

A frame generally carries a network-layer packet as its payload.

---

# ⚡ 30-Second Revision

```text
L2 DATA LINK
│
├── Frame
├── MAC Address
├── Node-to-node delivery
├── Error detection → CRC
├── Medium access → MAC
└── Switch / Bridge
```

### Must remember

$$
\boxed{L2 = Frame + MAC + Node-to-Node}
$$

### GATE Priority: ⭐⭐⭐⭐⭐

**Very important.** Focus next on **framing → error detection/CRC → MAC protocols → Ethernet**, because these are much more valuable for GATE than memorizing general definitions.
