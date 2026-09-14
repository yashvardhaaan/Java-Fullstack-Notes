# Error Correction

## 1. What is Error Correction?

**Error correction** means detecting an error **and determining the original/correct data**.

```text
Sender → Noisy Channel → Receiver
                         ↓
                    Error detected
                         ↓
                    Correct the data
```

### Detection vs Correction

|                   | Detection           | Correction                    |
| ----------------- | ------------------- | ----------------------------- |
| Purpose           | Know error occurred | Find/correct erroneous bit(s) |
| Example           | CRC, Parity         | Hamming Code                  |
| Extra information | Less                | More redundancy               |

---

# 2. Hamming Distance ⭐⭐⭐⭐⭐

**Hamming distance** = number of bit positions in which two codewords differ.

Example:

```text
101101
100001
```

Differences:

```text
   ↑ ↑
```

Therefore:

```text
d = 2
```

### Minimum Hamming Distance

For a set of valid codewords:

> `dmin` = smallest Hamming distance between any two valid codewords.

This determines the error-detection and correction capability.

---

# 3. Most Important GATE Formulas 🔥

If minimum Hamming distance is `dmin`:

### Error Detection

```text
Maximum detectable errors = dmin − 1
```

### Error Correction

```text
Maximum correctable errors = ⌊(dmin − 1)/2⌋
```

### Example

If:

```text
dmin = 7
```

Then:

```text
Detection = 7 − 1 = 6 errors
```

```text
Correction = ⌊6/2⌋ = 3 errors
```

---

# 4. Why More Distance Helps

Imagine valid codewords:

```text
000000
111111
```

Distance = 6.

If only one bit changes:

```text
000000 → 010000
```

The receiver can see that it is closer to `000000`.

More distance between valid codewords gives more ability to distinguish corrupted data.

---

# 5. Hamming Code ⭐⭐⭐⭐⭐

**Hamming Code** is an error-correcting code that can:

> **Correct single-bit errors** under the standard Hamming-code setup.

It adds **parity bits** to the original data bits.

---

# 6. Number of Parity Bits

Suppose:

* `m` = number of data bits
* `r` = number of parity bits

For single-bit error correction:

```text
2^r ≥ m + r + 1
```

🔥 **This is one of the most important Hamming Code formulas for GATE.**

### Example

For:

```text
m = 4
```

Try `r = 3`:

```text
2³ ≥ 4 + 3 + 1
8 ≥ 8 ✓
```

Therefore:

```text
Data bits = 4
Parity bits = 3
Total bits = 7
```

This gives the famous **Hamming(7,4)** code.

---

# 7. Position of Parity Bits

Parity bits are placed at positions that are powers of 2:

```text
1, 2, 4, 8, 16, ...
```

For Hamming(7,4):

```text
Position:  1  2  3  4  5  6  7
            P  P  D  P  D  D  D
```

So:

```text
P₁ → position 1
P₂ → position 2
P₄ → position 4
```

The remaining positions contain data.

---

# 8. Which Bits Does Each Parity Bit Check?

This is a **very important numerical pattern**.

### P₁ → position 1

Checks:

```text
1, 3, 5, 7, ...
```

### P₂ → position 2

Checks:

```text
2, 3, 6, 7, ...
```

### P₄ → position 4

Checks:

```text
4, 5, 6, 7, ...
```

Pattern:

> Parity bit `2^k` checks positions whose binary representation has that corresponding bit set.

---

# 9. Finding an Error

At the receiver, parity checks are performed again.

Suppose the parity-check results are:

```text
P₄ P₂ P₁ = 101
```

Convert to decimal:

```text
101₂ = 5
```

Therefore:

> **Error is at position 5.**

🔥 This value is called the **syndrome**.

---

# 10. Hamming Code Example

For Hamming(7,4):

```text
Position:  1 2 3 4 5 6 7
           P P D P D D D
```

Suppose receiver calculates:

```text
S₁ = 1
S₂ = 0
S₄ = 1
```

Write syndrome using parity positions:

```text
S₄ S₂ S₁
1  0  1
```

```text
101₂ = 5
```

Therefore:

```text
Error → position 5
```

Flip bit 5 to correct it.

---

# 11. Special Case: No Error

If all parity checks pass:

```text
S₄ S₂ S₁ = 000
```

Then:

```text
Error position = 0
```

So:

> **No single-bit error is detected.**

---

# 12. SEC and SEC-DED

### SEC

**Single Error Correction**

Can:

* Correct 1-bit error.

### SEC-DED

**Single Error Correction + Double Error Detection**

An additional overall parity bit is used.

Can:

* Correct a single-bit error.
* Detect a double-bit error.

🔥 Remember:

```text
SEC      → 1-bit correction
SEC-DED  → 1-bit correction + 2-bit detection
```

---

# 🔥 GATE Traps

### Trap 1

Parity bits are placed at:

```text
1, 2, 4, 8, ...
```

❌ Not `1, 3, 5, 7...`

---

### Trap 2

For `m` data bits:

```text
2^r ≥ m+r+1
```

Don't use:

```text
2^r ≥ m+1
```

---

### Trap 3

If syndrome is:

```text
101
```

Don't read it as decimal 101.

It is:

```text
101₂ = 5
```

Therefore error is at **position 5**.

---

### Trap 4

If:

```text
dmin = 4
```

Correction capability is:

```text
⌊(4−1)/2⌋ = 1
```

Not 2.

---

# ⚡ 30-Second Revision

```text
Error Correction
│
├── Hamming Distance
│   ├── Detection = dmin − 1
│   └── Correction = floor((dmin−1)/2)
│
└── Hamming Code
    ├── 2^r ≥ m+r+1
    ├── Parity positions = 1,2,4,8,...
    ├── Syndrome = error position
    ├── 000 = no error
    └── SEC → 1-bit correction
```

### ⭐ GATE Priority

**Hamming Distance → VERY HIGH**
**Hamming Code → VERY HIGH**
**Parity-bit calculation → HIGH**
**Syndrome/error-position questions → HIGH**
