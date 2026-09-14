# Presentation Layer — OSI Layer 6

## 1. What is the Presentation Layer?

**L6 = translates data into a format that both communicating systems can understand.**

### First principle

> **L6 answers: "In what form should the data be represented?"**

```text
Application
    ↓
Presentation
    ↓
Transport
```

---

## 2. Main Functions ⭐⭐⭐

### ① Translation

Converts between different data representations.

```text
Format A → Format B
```

Example:

* Character encoding
* Data representation

---

### ② Encryption / Decryption

Provides data confidentiality through encryption/decryption.

```text
Sender                    Receiver

Plaintext
   ↓
Encrypt
   ↓
Ciphertext ─────────────→ Decrypt
                            ↓
                         Plaintext
```

---

### ③ Compression / Decompression

Reduces data size for efficient transmission.

```text
Original Data
     ↓
Compression
     ↓
Smaller Data
     ↓
Transmission
     ↓
Decompression
```

---

# 3. Three Keywords 🔥

Remember:

> **T-E-C**

**T → Translation**

**E → Encryption**

**C → Compression**

---

# 4. Presentation vs Session

| Presentation        | Session                  |
| ------------------- | ------------------------ |
| Data representation | Session management       |
| Translation         | Establish/manage session |
| Encryption          | Synchronization          |
| Compression         | Dialog control           |

### Trick

> **Presentation → How data looks**

> **Session → How conversation is managed**

---

# 5. TCP/IP Mapping

TCP/IP does **not** have separate Presentation and Session layers.

Their functions are generally incorporated into the **Application layer**.

```text
OSI                         TCP/IP

Application ─┐
Presentation ├──────────→ Application
Session ─────┘
```

---

# 🔥 GATE Traps

### Trap 1

**Encryption is associated with Presentation Layer in the OSI model.**

But in real networks, encryption can be implemented at different layers.

---

### Trap 2

```text
Compression → Presentation
Routing     → Network
Framing     → Data Link
```

---

### Trap 3

Presentation Layer does **not** decide the network path.

```text
Path selection → Network Layer
```

---

# ⚡ Quick Revision

```text
L6 PRESENTATION
│
├── Translation
├── Encryption / Decryption
└── Compression / Decompression
```

### One-line memory

> **Presentation Layer = makes data understandable, secure, and efficiently represented.**

### GATE Priority: ⭐⭐

Know **Translation + Encryption + Compression + TCP/IP mapping**. Don't spend much time beyond that.
