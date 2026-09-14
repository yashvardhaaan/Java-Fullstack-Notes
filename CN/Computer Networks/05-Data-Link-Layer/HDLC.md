# HDLC

## 1. What is HDLC?

**HDLC = High-Level Data Link Control**

It is a **bit-oriented Data Link Layer protocol** used for reliable communication over point-to-point or multipoint links.

> **Layer → Data Link (L2)**

---

# 2. First Principle

HDLC mainly provides:

* **Framing**
* **Error detection**
* **Flow control**
* **Error control**

It is **bit-oriented**, unlike character-oriented protocols.

---

# 3. HDLC Frame Format ⭐⭐⭐⭐⭐

```text id="x0f8mc"
┌──────┬────────┬────────┬────────┬────────┬──────┐
│ Flag │ Address│Control │  Data  │  FCS   │ Flag │
└──────┴────────┴────────┴────────┴────────┴──────┘
```

### Fields

| Field       | Purpose                          |
| ----------- | -------------------------------- |
| Flag        | Marks beginning/end of frame     |
| Address     | Identifies station               |
| Control     | Frame type + control information |
| Information | Actual data                      |
| FCS         | Error detection                  |

---

# 4. Flag Field 🔥

HDLC uses:

```text id="q5ezqx"
01111110
```

as the **flag**.

This is:

```text id="d3w5t4"
0 111111 0
```

The same flag pattern is used to delimit frames.

---

# 5. Bit Stuffing ⭐⭐⭐⭐⭐

Problem:

What if the data itself contains:

```text id="c7k0sf"
01111110
```

The receiver could mistake it for a flag.

### Solution → Bit Stuffing

After **five consecutive 1s**, the sender inserts a `0`.

Example:

```text id="7z5pzk"
Data:
01111110
```

Stuffed:

```text id="1jzvmt"
011111010
       ↑
   inserted 0
```

Receiver removes the stuffed `0`.

### 🔥 GATE Rule

```text
5 consecutive 1s
        ↓
Insert 0
```

---

# 6. HDLC Frame Types ⭐⭐⭐⭐⭐

HDLC has **three major frame types**:

```text id="7m6xqh"
I-Frame
S-Frame
U-Frame
```

---

## I-Frame — Information

Used for:

* Carrying user data
* Sequence numbers
* Acknowledgment information

```text id="r5e0w2"
I = Information
```

---

## S-Frame — Supervisory

Used mainly for:

* Flow control
* Error control
* Acknowledgments

```text id="3v3l1a"
S = Supervisory
```

Examples include:

* Receive Ready (RR)
* Receive Not Ready (RNR)
* Reject (REJ)
* Selective Reject (SREJ)

---

## U-Frame — Unnumbered

Used for:

* Link management
* Control functions

```text id="v7c0z7"
U = Unnumbered
```

---

# 7. Sequence Numbers

HDLC uses sequence numbers to support reliable transmission.

Conceptually:

```text id="t0x8nm"
Sender
 I(0) ─────→
 I(1) ─────→
 I(2) ─────→
```

Receiver can acknowledge received frames.

---

# 8. FCS

HDLC uses **FCS (Frame Check Sequence)** for error detection.

Typically based on **CRC**.

```text id="x1wqk5"
Data
 ↓
CRC calculation
 ↓
FCS
```

So:

> **HDLC FCS → Error Detection**

Not error correction itself.

---

# 9. HDLC Modes

Important modes include:

### NRM

**Normal Response Mode**

* Secondary station transmits only when permitted by primary.

### ARM

**Asynchronous Response Mode**

* Secondary can initiate transmission without explicit permission.

### ABM ⭐

**Asynchronous Balanced Mode**

* Both stations can act as primary/secondary.
* Commonly associated with balanced point-to-point operation.

🔥 For GATE, know the names and basic distinction.

---

# 🔥 GATE Traps

### Trap 1

**HDLC is byte-oriented.**

❌

> HDLC is **bit-oriented**.

---

### Trap 2

HDLC flag:

```text id="6uhm1b"
01111110
```

---

### Trap 3

After how many consecutive `1`s is a `0` inserted?

```text id="x3l7az"
5
```

---

### Trap 4

**Bit stuffing is the same as byte stuffing.**

❌

HDLC uses **bit stuffing**.

---

### Trap 5

**FCS corrects errors.**

❌

FCS/CRC primarily **detects errors**.

---

# ⚡ 30-Second Revision

```text id="q4v6a1"
HDLC
 ↓
Data Link Layer
 ↓
Bit-oriented protocol

Frame:
Flag | Address | Control | Info | FCS | Flag

Flag = 01111110

Bit Stuffing:
5 consecutive 1s → insert 0

Frame Types:
I → Information
S → Supervisory
U → Unnumbered

FCS → CRC-based error detection
```

### GATE Priority

**Bit stuffing → 🔥🔥🔥🔥🔥**
**HDLC frame format → 🔥🔥🔥🔥**
**I/S/U frames → 🔥🔥🔥🔥**
**Flag pattern → 🔥🔥🔥🔥🔥**
