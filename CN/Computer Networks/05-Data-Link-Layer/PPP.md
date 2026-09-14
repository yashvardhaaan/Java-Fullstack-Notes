# PPP

## 1. What is PPP?

**PPP = Point-to-Point Protocol**

It is a **Data Link Layer (L2)** protocol used to establish communication between **two directly connected nodes**.

> **PPP → Point-to-Point → L2**

Example:

```text
Computer ───────── Router
          PPP Link
```

---

# 2. Main Functions

PPP provides:

* **Framing**
* **Link establishment**
* **Authentication**
* **Error detection**
* **Network-layer protocol configuration**

⚠️ PPP does **not** provide error correction/retransmission like HDLC-style reliable protocols.

---

# 3. PPP Frame Format ⭐⭐⭐⭐

```text id="2d8u3k"
┌──────┬─────────┬────────┬─────────┬────────┬──────┐
│ Flag │ Address │Control │Protocol │  Data  │ FCS  │
└──────┴─────────┴────────┴─────────┴────────┴──────┘
```

### Important fields

| Field    | Purpose                          |
| -------- | -------------------------------- |
| Flag     | Frame boundary                   |
| Address  | Address field                    |
| Control  | Control information              |
| Protocol | Identifies encapsulated protocol |
| Data     | Payload                          |
| FCS      | Error detection                  |

PPP commonly uses:

```text id="8z3jtf"
Flag = 01111110
```

---

# 4. PPP Components ⭐⭐⭐⭐⭐

PPP commonly uses two important protocols:

### LCP

**Link Control Protocol**

Used to:

* Establish the link
* Configure link parameters
* Test/maintain the link
* Terminate the link

```text id="j9yqv5"
LCP → Controls the PPP link
```

### NCP

**Network Control Protocol**

Used to configure **network-layer protocols**.

For IPv4, an example is:

```text id="6s9xkn"
IPCP
```

**IPCP = IP Control Protocol**

---

# 5. PPP Authentication

PPP can support authentication.

Common methods:

### PAP

**Password Authentication Protocol**

Simple username/password authentication.

```text id="k6u5pw"
Username + Password
```

### CHAP ⭐⭐⭐⭐

**Challenge Handshake Authentication Protocol**

Uses a challenge-response mechanism.

```text id="9c9y8h"
Server → Challenge
Client → Response
Server → Verify
```

### GATE Trick

> **PAP → simpler**
> **CHAP → challenge-response**

---

# 6. PPP Link Establishment

Simplified sequence:

```text id="v4y7u1"
LCP
 ↓
Authentication (if configured)
 ↓
NCP
 ↓
Network-layer data transfer
 ↓
Terminate
```

Remember:

```text id="3u8q6j"
LCP → Link
NCP → Network protocol
```

---

# 7. PPP vs HDLC

| PPP                                         | HDLC                                  |
| ------------------------------------------- | ------------------------------------- |
| Point-to-point                              | Point-to-point/multipoint variants    |
| L2                                          | L2                                    |
| Supports authentication                     | Authentication not a core PPP feature |
| LCP/NCP                                     | No equivalent PPP LCP/NCP structure   |
| FCS                                         | FCS                                   |
| Flag = `01111110`                           | Flag = `01111110`                     |
| Byte-oriented framing aspects commonly used | Bit-oriented                          |

---

# 🔥 GATE Traps

### Trap 1

**PPP is a Transport Layer protocol.**

❌

> PPP → **Data Link Layer**

---

### Trap 2

**LCP configures IP.**

❌

> **LCP → PPP link**

> **NCP/IPCP → network-layer protocol configuration**

---

### Trap 3

**PAP is challenge-response.**

❌

> **CHAP → challenge-response**

---

### Trap 4

**PPP provides error correction.**

❌

PPP's FCS is for **error detection**.

---

# ⚡ 30-Second Revision

```text id="g6i9m2"
PPP
 ↓
Point-to-Point Protocol
 ↓
Data Link Layer

Functions:
Framing
Authentication
Link management
Error detection
Network protocol configuration

LCP → Link configuration
NCP → Network protocol configuration
IPCP → IPv4 configuration

PAP → Simple authentication
CHAP → Challenge-response

FCS → Error detection
Flag → 01111110
```

### GATE Priority

**LCP vs NCP → 🔥🔥🔥🔥🔥**
**PAP vs CHAP → 🔥🔥🔥🔥**
**PPP frame → 🔥🔥🔥🔥**
**PPP vs HDLC → 🔥🔥🔥**
