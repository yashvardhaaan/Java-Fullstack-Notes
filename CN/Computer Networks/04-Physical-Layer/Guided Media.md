# Guided Media

## 1. What is Guided Media?

**Guided media = transmission medium where signals travel through a physical path/cable.**

```text
Sender ───── Cable ───── Receiver
```

Main types:

1. **Twisted Pair**
2. **Coaxial Cable**
3. **Optical Fiber**

---

# 2. Twisted Pair ⭐⭐⭐

Two insulated copper wires are twisted together.

```text
Wire 1  ~~~~~~~~~
Wire 2  ~~~~~~~~~
```

### Types

**UTP**

* Unshielded
* Cheap
* Easy to install
* More affected by interference

**STP**

* Shielded
* Better protection against interference
* More expensive

### Key

> **UTP → cheaper**

> **STP → better shielding**

---

# 3. Coaxial Cable ⭐⭐⭐

Structure:

```text
Core
 ↓
Insulation
 ↓
Metal shield
 ↓
Outer jacket
```

### Advantages

* Better shielding than twisted pair
* Higher bandwidth than basic twisted pair in many applications
* More resistant to interference

### Disadvantages

* More expensive/bulkier than twisted pair
* Less convenient to install

---

# 4. Optical Fiber ⭐⭐⭐⭐⭐

Uses **light** for transmission.

```text
Data → Light → Fiber → Light → Data
```

### Structure

```text
Core
 ↓
Cladding
 ↓
Jacket
```

Light is guided through the core by **total internal reflection** in conventional fiber.

---

# 5. Single-Mode vs Multimode 🔥

### Single-Mode

* Very small core
* One propagation mode
* Long-distance communication
* Higher bandwidth-distance capability

### Multimode

* Larger core
* Multiple propagation modes
* Shorter distances
* Common for shorter-range links

```text
Single-mode → Long distance
Multimode   → Shorter distance
```

---

# 6. Fiber Advantages ⭐⭐⭐⭐⭐

* Very high bandwidth
* Low attenuation
* Long-distance transmission
* Immune to electromagnetic interference
* Lightweight
* Better resistance to electrical interference

### Major disadvantage

> Higher installation/termination cost and more specialized equipment.

---

# 7. Comparison

| Feature      | Twisted Pair | Coaxial    | Fiber          |
| ------------ | ------------ | ---------- | -------------- |
| Signal       | Electrical   | Electrical | **Light**      |
| Cost         | Low          | Medium     | Higher         |
| Bandwidth    | Lower        | Higher     | **Very high**  |
| EMI immunity | Low          | Better     | **Excellent**  |
| Distance     | Short        | Medium     | **Long**       |
| Installation | Easy         | Moderate   | More difficult |

---

# 🔥 GATE Traps

### Trap 1

**Fiber does not use electrical signals.**

→ Uses **light**.

### Trap 2

**Single-mode has a smaller core than multimode.**

### Trap 3

**STP is not optical fiber.**

STP is still **copper**.

### Trap 4

Fiber's immunity to electromagnetic interference does **not** mean it is immune to every possible form of signal loss or physical damage.

---

# ⚡ Quick Revision

```text
GUIDED MEDIA
│
├── Twisted Pair
│   ├── UTP
│   └── STP
│
├── Coaxial
│
└── Optical Fiber
    ├── Single-mode → Long distance
    └── Multimode   → Shorter distance
```

### Remember

**Copper → Electrical**

**Fiber → Light**

**Single-mode → Long distance**

**Multimode → Multiple modes**

### GATE Priority: ⭐⭐⭐

Know the **comparison + fiber types + advantages/disadvantages**.
