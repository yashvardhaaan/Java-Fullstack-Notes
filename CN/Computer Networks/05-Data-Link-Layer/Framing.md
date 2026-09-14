# Framing

## 1. What is Framing?

**Framing** is the Data Link Layer process of dividing a continuous stream of bits into **manageable units called frames**.

```text
Network Layer
     ↓
   Packet
     ↓
Data Link Layer
     ↓
   Frame
     ↓
Physical Layer
     ↓
   Bits
```

> **Frame = PDU of Data Link Layer**

---

# 2. Why is Framing Needed?

The receiver must know:

* **Where a frame starts**
* **Where a frame ends**

Without framing:

```text
101101001011010010...
          ↓
Receiver doesn't know
which bits belong to which frame
```

With framing:

```text
[ Frame 1 ][ Frame 2 ][ Frame 3 ]
```

---

# 3. Main Framing Methods ⭐⭐⭐⭐⭐

For GATE, remember these:

1. **Character/Byte Count**
2. **Byte Stuffing**
3. **Bit Stuffing**
4. **Physical Layer Coding Violations**

---

# 4. Character/Byte Count

A field in the frame indicates its **length**.

Example:

```text
┌────────┬──────────────┐
│ Length │     Data     │
└────────┴──────────────┘
```

If:

```text
Length = 5
```

receiver knows the frame contains 5 bytes according to the protocol's length definition.

### Problem ⚠️

If the length field itself is corrupted, the receiver can lose synchronization and misinterpret subsequent bytes.

---

# 5. Byte Stuffing ⭐⭐⭐⭐

Used in **byte/character-oriented framing**.

Suppose a special byte indicates the beginning/end of a frame:

```text
FLAG
```

What if `FLAG` appears inside the actual data?

### Solution → Escape byte

```text
FLAG → Frame boundary
ESC  → Escape character
```

If data contains:

```text
A FLAG B
```

Sender sends:

```text
A ESC FLAG B
```

Receiver removes the `ESC`.

---

# 6. Bit Stuffing ⭐⭐⭐⭐⭐

Used in **bit-oriented protocols such as HDLC**.

HDLC flag:

```text
01111110
```

To prevent this pattern from accidentally appearing in data:

> After **five consecutive 1s**, insert a `0`.

Example:

```text
Original:
01111110

Stuffed:
011111010
       ↑
   inserted 0
```

Receiver removes the inserted `0`.

### 🔥 Memorize

```text
5 consecutive 1s → insert 0
```

---

# 7. Byte Stuffing vs Bit Stuffing

| Byte Stuffing                         | Bit Stuffing                  |
| ------------------------------------- | ----------------------------- |
| Byte-oriented                         | Bit-oriented                  |
| Uses escape byte                      | Inserts `0`                   |
| Protects special bytes                | Protects special bit patterns |
| Example: character-oriented protocols | HDLC                          |

🔥 **Don't confuse them.**

---

# 8. Physical Layer Coding Violations

Some protocols reserve certain signal patterns that **cannot occur during normal data transmission**.

These special patterns can be used to identify:

```text
Start of frame
End of frame
```

This technique depends on the physical encoding scheme.

---

# 9. Framing vs Encapsulation

Very important distinction.

### Encapsulation

Adding headers/trailers around data:

```text
Packet
  ↓
Header + Packet + Trailer
  ↓
Frame
```

### Framing

Defining the **boundaries** of that frame in the transmitted stream.

```text
... [Frame 1] [Frame 2] [Frame 3] ...
          ↑
       boundaries
```

> **Encapsulation adds control information.**
> **Framing identifies frame boundaries.**

---

# 🔥 GATE Traps

### Trap 1

**Frame = Packet**

❌

```text
Packet → Network Layer
Frame  → Data Link Layer
```

A frame typically **encapsulates a packet**.

---

### Trap 2

**Bit stuffing inserts 1 after five 0s.**

❌

For HDLC:

```text
Five consecutive 1s → insert 0
```

---

### Trap 3

**Byte stuffing and bit stuffing are the same.**

❌

Byte stuffing → escape character/byte
Bit stuffing → insert a bit.

---

### Trap 4

**Framing and encapsulation are identical.**

❌ Related, but different concepts.

---

# ⚡ 30-Second Revision

```text
FRAMING
   ↓
Divide bit stream into frames
   ↓
Identify START + END

Methods:
├── Character/Byte Count
├── Byte Stuffing
├── Bit Stuffing
└── Coding Violations

HDLC:
01111110 → Flag
5 consecutive 1s → insert 0

Byte stuffing → ESC
Bit stuffing  → inserted 0

Packet → L3
Frame  → L2
Bits   → L1
```

### GATE Priority

**Bit Stuffing → 🔥🔥🔥🔥🔥**
**Byte Stuffing → 🔥🔥🔥🔥**
**Framing methods → 🔥🔥🔥🔥**
**Framing vs Encapsulation → 🔥🔥🔥**
