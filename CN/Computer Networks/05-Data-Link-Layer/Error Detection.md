# Error Detection

## 1. What is Error Detection?

**Error detection** is the process of determining whether the received data has been **corrupted during transmission**.

```text
Sender                         Receiver
  ↓                               ↓
Data ──── Noise/Interference ──→ Data'
                                  ↓
                            Error detected?
```

> **Detection ≠ Correction**
> Detection tells us **whether an error occurred**. Correction determines **what the correct data should be**.

---

## 2. Why is Error Detection Needed?

Transmission can introduce errors because of:

* Noise
* Electromagnetic interference
* Signal attenuation
* Hardware problems
* Wireless interference

Example:

```text
Sent:     10110100
Received: 10100100
              ↑
            Error
```

---

# 3. Main Error Detection Techniques

| Technique                  | Main Idea                               | GATE Priority |
| -------------------------- | --------------------------------------- | ------------: |
| **Parity Bit**             | Add 1 bit to make number of 1s even/odd |           ⭐⭐⭐ |
| **Two-Dimensional Parity** | Parity across rows + columns            |           ⭐⭐⭐ |
| **Checksum**               | One's-complement addition               |          ⭐⭐⭐⭐ |
| **CRC**                    | Polynomial division                     |         ⭐⭐⭐⭐⭐ |

🔥 **CRC is the most important for GATE numericals.**

---

# 4. Parity Bit

A **parity bit** is an extra bit added to data.

Two types:

* **Even parity**
* **Odd parity**

### Even Parity

Total number of `1`s must be **even**.

Example:

```text
Data = 1011001
Number of 1s = 4

Parity bit = 0

Code = 10110010
```

### Odd Parity

Total number of `1`s must be **odd**.

```text
Data = 1011001
Number of 1s = 4

Parity bit = 1

Code = 10110011
```

---

## 🔥 GATE Trick

For **single parity**:

> Detects **all odd-number bit errors**.

But:

> Cannot detect **even-number bit errors**.

Example:

```text
Original:  101101
Received:  100001
             ↑ ↑
          2 bits changed
```

Parity may remain valid → **error goes undetected**.

### Remember

```text
Odd errors  → Detectable
Even errors → May NOT be detected
```

---

# 5. Two-Dimensional Parity

Data is arranged in rows and columns.

Parity is calculated for:

* Each row
* Each column

Example:

```text
1 0 1 1 | P
0 1 0 1 | P
1 1 0 0 | P
--------- 
P P P P
```

If a **single bit** changes:

* One row parity fails
* One column parity fails

Their intersection identifies the erroneous bit.

🔥 Thus, 2-D parity can **locate a single-bit error**.

---

# 6. Checksum

Checksum divides data into fixed-size words and performs **one's-complement addition**.

### Basic process

```text
Data
 ↓
Divide into fixed-size words
 ↓
One's-complement addition
 ↓
Complement the result
 ↓
Checksum
```

Receiver:

```text
Received data + checksum
          ↓
One's-complement addition
          ↓
Check result
```

### Important

Checksum is commonly associated with **IP/TCP/UDP error detection**, although the exact checksum usage differs by protocol.

🔥 GATE often tests **one's-complement arithmetic**.

---

# 7. CRC — Cyclic Redundancy Check ⭐⭐⭐⭐⭐

CRC is one of the **most important GATE error-detection topics**.

### First principle

CRC treats the bit sequence as a **binary polynomial** and performs **modulo-2 division**.

There is:

* Data
* Generator polynomial
* Remainder

---

## CRC Sender Process

Suppose:

```text
Data = D
Generator = G
```

If generator has degree **r**:

### Step 1

Append `r` zeros to data.

```text
D → D × 2ʳ
```

### Step 2

Perform modulo-2 division by generator.

### Step 3

Take the remainder `R`.

### Step 4

Transmit:

```text
Codeword = D + R
```

where `R` has exactly `r` bits (including leading zeros as needed).

---

# 8. Modulo-2 Arithmetic

CRC uses **XOR instead of normal subtraction**.

```text
0 ⊕ 0 = 0
0 ⊕ 1 = 1
1 ⊕ 0 = 1
1 ⊕ 1 = 0
```

Therefore:

```text
1011
⊕ 1101
──────
0110
```

🔥 **No carry and no borrow.**

---

# 9. CRC Receiver

Receiver divides the received codeword by the same generator.

```text
Received Codeword
       ↓
Modulo-2 division
       ↓
Remainder
```

### Result

```text
Remainder = 0
      ↓
No error detected
```

```text
Remainder ≠ 0
      ↓
Error detected
```

⚠️ **Zero remainder does NOT prove that no error occurred.**

It only means:

> **The error was not detected by this CRC.**

---

# 10. CRC Important Formula

If generator polynomial has degree **r**:

```text
Number of CRC bits = r
```

Example:

```text
G(x) = x⁴ + x³ + 1
```

Highest power = 4

Therefore:

```text
r = 4
CRC bits = 4
```

---

# 11. Burst Error Detection

A **burst error** means a sequence of bits is affected.

Example:

```text
Original:  101101001101
Received:  101010111101
              ←───→
             burst
```

### GATE Rule ⭐

If generator has degree **r**:

> CRC detects **all burst errors of length ≤ r**.

For longer burst errors, detection depends on the generator polynomial.

---

# 12. Hamming Distance

Another extremely important concept.

**Hamming distance = number of bit positions in which two bit strings differ.**

Example:

```text
101101
100001
```

Different positions = 2

Therefore:

```text
Hamming distance = 2
```

If minimum Hamming distance is `dmin`:

### Error Detection

```text
Maximum detectable errors = dmin − 1
```

### Error Correction

```text
Maximum correctable errors = ⌊(dmin − 1)/2⌋
```

🔥 These formulas are extremely important for GATE.

---

# 🔥 GATE Traps

### Trap 1

**Parity detects every error?**

❌ No.

Single parity can miss **even-number bit errors**.

---

### Trap 2

**CRC uses normal binary division?**

❌ No.

CRC uses **modulo-2 division = XOR operations**.

---

### Trap 3

**CRC remainder is always r bits?**

✅ Yes, where `r = degree of generator`.

---

### Trap 4

**Zero CRC remainder means definitely no error?**

❌ No.

It means **no error was detected**.

---

### Trap 5

If:

```text
dmin = 5
```

Detection:

```text
5 − 1 = 4 errors
```

Correction:

```text
⌊(5−1)/2⌋ = 2 errors
```

---

# ⚡ 30-Second Revision

```text
Error Detection
│
├── Parity
│   ├── Even
│   ├── Odd
│   └── Detects odd # of bit errors
│
├── 2-D Parity
│   └── Row + Column
│
├── Checksum
│   └── One's-complement addition
│
└── CRC ⭐⭐⭐⭐⭐
    ├── Polynomial division
    ├── XOR
    ├── Generator degree = r
    ├── Append r zeros
    ├── Remainder = CRC
    └── Detects all burst errors ≤ r
```

### GATE Must-Know

```text
dmin − 1
     ↓
Maximum errors detected

⌊(dmin−1)/2⌋
     ↓
Maximum errors corrected
```

**Next: Error Correction.md → Hamming Code + Hamming Distance numericals.**
