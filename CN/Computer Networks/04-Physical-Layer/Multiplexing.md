# Multiplexing

## 1. What is Multiplexing?

**Multiplexing = combining multiple signals/data streams and transmitting them over a single shared communication link.**

```text
A ──┐
B ──┼──→ MUX ──→ Shared Link ──→ DEMUX ──→ A, B, C
C ──┘
```

### First principle

> **Many sources → one channel → many destinations**

* **MUX** = Multiplexer → combines
* **DEMUX** = Demultiplexer → separates

---

# 2. Why Multiplexing?

Without multiplexing:

```text
A ───────── Link 1
B ───────── Link 2
C ───────── Link 3
```

With multiplexing:

```text
A ──┐
B ──┼── MUX ── One Link ── DEMUX
C ──┘
```

### Benefit

**Better utilization of expensive/shared communication links.**

---

# 3. Main Types ⭐⭐⭐⭐⭐

```text
Multiplexing
├── FDM
├── TDM
├── WDM
└── CDM
```

---

# 4. FDM — Frequency Division Multiplexing ⭐⭐⭐⭐

The available frequency spectrum is divided into **frequency bands**.

```text
Frequency
│
├── A ── Band 1
├── B ── Band 2
├── C ── Band 3
```

Each signal gets a different frequency range.

### Key

> **FDM → Frequency**

Used traditionally in radio/TV and various analog/wireless systems.

### Guard Band

Small unused frequency bands may be placed between channels to reduce interference.

---

# 5. TDM — Time Division Multiplexing ⭐⭐⭐⭐⭐

Users share the same channel by using **different time slots**.

```text
Time →
| A | B | C | A | B | C |
```

Each source gets the channel for its assigned time.

### Key

> **TDM → Time**

---

## Synchronous TDM

Each source gets a **fixed slot**, even if it has no data.

```text
| A | B | C | A | B | C |
```

If B has nothing to send, B's slot may remain unused.

---

## Statistical TDM

Slots are assigned **dynamically** to active sources.

```text
| A | C | A | A | C | B |
```

### Key difference

> **Synchronous TDM → fixed slots**

> **Statistical TDM → dynamic slots**

---

# 6. WDM — Wavelength Division Multiplexing ⭐⭐⭐⭐

Used primarily with **optical fiber**.

Different signals use different **wavelengths of light**.

```text
λ1 → A
λ2 → B
λ3 → C
       ↓
   One Fiber
```

### Key

> **WDM → Wavelength → Fiber**

---

# 7. CDM / CDMA ⭐⭐⭐

Multiple users can share the same frequency and time by using **different codes**.

```text
A → Code A
B → Code B
C → Code C
```

Receiver uses the appropriate code to distinguish signals.

### Key

> **CDM → Code**

---

# 🔥 Most Important Comparison

| Technique | Separation Based On | Key Word    |
| --------- | ------------------- | ----------- |
| **FDM**   | Frequency           | Frequency   |
| **TDM**   | Time                | Time        |
| **WDM**   | Wavelength          | Light/Fiber |
| **CDM**   | Code                | Code        |

### Memory

> **F → Frequency**

> **T → Time**

> **W → Wavelength**

> **C → Code**

---

# 8. Multiplexing vs Switching

Don't confuse them.

### Multiplexing

> Multiple signals **share one physical link/channel**.

### Switching

> Network determines **how data is forwarded through interconnected nodes**.

```text
Multiplexing → Share a link
Switching    → Choose/establish forwarding path
```

---

# 🔥 GATE Traps

### Trap 1

**WDM is essentially optical multiplexing.**

```text
WDM → Different wavelengths of light
```

### Trap 2

**TDM doesn't divide the link into different frequencies.**

It divides access by **time**.

### Trap 3

In **synchronous TDM**, an assigned slot may be unused if the source has no data.

### Trap 4

**Statistical TDM** improves utilization by dynamically allocating slots to active sources.

---

# ⚡ 30-Second Revision

```text
MULTIPLEXING
     │
     ├── FDM → Frequency
     ├── TDM → Time
     ├── WDM → Wavelength → Fiber
     └── CDM → Code
```

```text
MUX:
Many → One

DEMUX:
One → Many
```

### GATE Priority: ⭐⭐⭐⭐⭐

Focus especially on:

**FDM vs TDM → synchronous vs statistical TDM → WDM → basic numerical/conceptual questions.**
