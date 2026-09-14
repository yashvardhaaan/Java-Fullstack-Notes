# Encapsulation & Decapsulation

## 1. Encapsulation ⭐⭐⭐⭐⭐

**Encapsulation = adding layer-specific control information as data moves DOWN the sender's protocol stack.**

```text id="m0jz5m"
Application
   ↓
   Data
   ↓
Transport
   ↓
[Header + Data]          → Segment
   ↓
Network
   ↓
[IP Header + Segment]    → Packet
   ↓
Data Link
   ↓
[Frame Header + Packet + Trailer] → Frame
   ↓
Physical
   ↓
Bits
```

### First principle

> **Each layer adds the information it needs to perform its own job.**

---

# 2. Decapsulation ⭐⭐⭐⭐⭐

At the receiver, the process is reversed.

```text id="x4h9kj"
Bits
 ↓
Frame
 ↓
Packet
 ↓
Segment
 ↓
Data
```

Each layer removes/processes its corresponding header.

> **Encapsulation → Sender**

> **Decapsulation → Receiver**

---

# 3. PDU Transformation 🔥

Remember:

```text id="7j1q9a"
Application → Data
Transport   → Segment
Network     → Packet
Data Link   → Frame
Physical    → Bits
```

### Easy trick

**S → P → F → B**

**Segment → Packet → Frame → Bits**

---

# 4. Example

Suppose an application wants to send:

```text
"HELLO"
```

### Step 1 — Application

```text
HELLO
```

### Step 2 — Transport

TCP adds its header:

```text
[TCP Header][HELLO]
```

→ **Segment**

### Step 3 — Network

IP adds its header:

```text
[IP Header][TCP Header][HELLO]
```

→ **Packet**

### Step 4 — Data Link

Ethernet adds header + trailer:

```text
[Ethernet Header][IP Header][TCP Header][HELLO][Trailer]
```

→ **Frame**

### Step 5 — Physical

Frame is transmitted as:

```text
101010101010...
```

→ **Bits**

---

# 5. Header vs Trailer

Most layers add a **header**.

Data Link commonly adds:

```text
Header + Data + Trailer
```

Example:

```text
[Header][Packet][FCS]
```

**FCS** is used for error detection.

---

# 6. Why Encapsulation?

Each layer needs its own control information.

For example:

```text
Transport → Port / sequence information
Network   → IP addresses
Data Link → MAC addresses / frame control
```

So:

> **Encapsulation allows each layer to perform its specific function independently.**

---

# 🔥 GATE Important

### Question

If an application sends **1000 bytes of data**, does every layer necessarily see 1000 bytes?

❌ No.

Headers/trailers are added during encapsulation.

```text
Application data
      ↓
+ Transport header
      ↓
+ Network header
      ↓
+ Data-link header/trailer
```

Therefore, transmitted size can be **greater than the original application data size**.

---

# 7. Encapsulation vs Segmentation

Don't confuse them.

### Segmentation

Transport divides large application data into smaller units.

```text
Large Data
 ↓
Segment 1
Segment 2
Segment 3
```

### Encapsulation

A layer adds its control information.

```text
Segment
 ↓
IP Header + Segment
```

---

# 8. Encapsulation vs Multiplexing

At the Transport Layer, multiple applications can use the same network connection/interface.

```text id="1fhx2q"
Browser ─┐
SSH     ─┼→ Transport → Network
DNS     ─┘
```

**Port numbers** help identify the appropriate process.

---

# 🧠 GATE Traps

### Trap 1

❌ Packet = entire message.

✅ Packet is an **L3 PDU** carrying transport-layer information as payload.

---

### Trap 2

❌ Frame exists at Network Layer.

✅ **Frame → Data Link Layer**

---

### Trap 3

❌ TCP header is added by Network Layer.

✅ **TCP header → Transport Layer**

---

### Trap 4

At every layer, the entire lower-layer packet is **not necessarily called the same thing**.

Each layer gives the resulting PDU its own name.

---

# ⚡ 30-Second Revision

```text id="s8pj7p"
SENDER
Data
 ↓
Segment
 ↓
Packet
 ↓
Frame
 ↓
Bits
```

```text id="h5q8bl"
RECEIVER
Bits
 ↓
Frame
 ↓
Packet
 ↓
Segment
 ↓
Data
```

### Core concept

$$
\boxed{\text{Encapsulation = Add control information}}
$$

$$
\boxed{\text{Decapsulation = Process/remove control information}}
$$

### GATE Priority: ⭐⭐⭐⭐⭐

This is **very important** because it connects **all OSI layers** and appears frequently in conceptual and numerical questions.
