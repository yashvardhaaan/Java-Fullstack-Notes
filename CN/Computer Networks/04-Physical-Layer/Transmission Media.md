# Transmission Media

## 1. What is Transmission Media?

**Transmission medium = physical path through which signals travel from sender to receiver.**

```text
Sender → Medium → Receiver
```

Two main types:

```text
Transmission Media
├── Guided
└── Unguided
```

---

# 2. Guided vs Unguided ⭐⭐⭐⭐⭐

| Guided                | Unguided                            |
| --------------------- | ----------------------------------- |
| Physical path exists  | No physical cable                   |
| Signal follows medium | Signal propagates through air/space |
| Twisted pair          | Radio                               |
| Coaxial cable         | Microwave                           |
| Optical fiber         | Infrared                            |

### Trick

> **Guided = cable**

> **Unguided = wireless**

---

# 3. Important Characteristics

When comparing media, consider:

* **Bandwidth**
* **Data rate**
* **Distance**
* **Attenuation**
* **Interference/noise**
* **Cost**
* **Security**
* **Installation difficulty**

---

# 4. Attenuation ⭐⭐⭐⭐

**Attenuation = weakening of signal as it travels through the medium.**

```text
Strong signal ─────────→ Weak signal
```

Greater distance generally causes greater attenuation.

### GATE idea

If signal becomes too weak:

> **Repeater/regeneration may be required.**

---

# 5. Noise / Interference

Unwanted signals can corrupt the transmitted signal.

```text
Original signal + Noise
          ↓
      Distorted signal
```

Common sources:

* Electromagnetic interference
* Crosstalk
* Thermal noise

---

# 6. Twisted Pair ⭐⭐⭐⭐

Two insulated copper wires are twisted together.

```text
~\ /~\ /~\ /~
```

Two common types:

* **UTP** → Unshielded Twisted Pair
* **STP** → Shielded Twisted Pair

### Advantages

* Cheap
* Easy to install
* Common in LANs

### Disadvantages

* More susceptible to interference than fiber
* Limited distance/bandwidth compared with fiber

---

# 7. Coaxial Cable ⭐⭐⭐

Structure roughly:

```text
Core
 ↓
Insulation
 ↓
Metallic shield
 ↓
Outer jacket
```

Better shielding than ordinary twisted pair.

### Used in

* Cable TV
* Broadband systems
* Some legacy networking systems

---

# 8. Optical Fiber ⭐⭐⭐⭐⭐

Uses **light** to transmit information.

```text
Electrical data
      ↓
Light signal
      ↓
Fiber
      ↓
Light → Data
```

### Advantages

* Very high bandwidth
* Long distance
* Low attenuation
* Immune to electromagnetic interference
* Difficult to tap physically compared with copper

### Disadvantages

* Higher installation cost
* More delicate
* Requires specialized equipment

---

# 9. Fiber Types

### Single-mode fiber

* Very small core
* Light travels primarily in one mode
* Very long distance
* High bandwidth

### Multimode fiber

* Larger core
* Multiple propagation modes
* Shorter distance
* Generally cheaper equipment

### GATE

```text
Single-mode → Long distance
Multimode   → Shorter distance
```

---

# 10. Wireless Media

Signals travel through **free space**.

Major examples:

### Radio

* Can propagate over relatively long distances
* Used in wireless communication

### Microwave

* Often directional
* Used in point-to-point links and satellite communication

### Infrared

* Short range
* Generally requires line-of-sight or controlled propagation
* Does not normally pass through walls effectively

---

# 🔥 Quick Comparison

| Medium       | Signal               | Distance | Interference               |
| ------------ | -------------------- | -------- | -------------------------- |
| Twisted Pair | Electrical           | Short    | Higher                     |
| Coaxial      | Electrical           | Medium   | Lower than twisted pair    |
| Fiber        | **Light**            | **Long** | **Very low/immune to EMI** |
| Wireless     | Radio/microwave/etc. | Variable | More susceptible           |

---

# 🧠 GATE Traps

### Trap 1

**Fiber does NOT carry electrical signals.**

> Fiber → **Light**

### Trap 2

**Fiber is not affected by electromagnetic interference** in the way copper cables are.

### Trap 3

```text
UTP → Unshielded
STP → Shielded
```

### Trap 4

**Single-mode ≠ multiple light paths**

```text
Single-mode → one propagation mode
Multimode   → multiple modes
```

---

# ⚡ 30-Second Revision

```text
Transmission Media
│
├── Guided
│   ├── Twisted Pair → Copper
│   ├── Coaxial      → Copper + Shield
│   └── Fiber        → Light
│
└── Unguided
    ├── Radio
    ├── Microwave
    └── Infrared
```

### Must remember

$$
\boxed{\text{Guided = Physical path}}
$$

$$
\boxed{\text{Unguided = Free space}}
$$

$$
\boxed{\text{Fiber = Light + High bandwidth + Long distance + EMI immunity}}
$$

### GATE Priority: ⭐⭐⭐⭐

### Placement Priority: ⭐⭐⭐⭐

**Focus most on fiber vs copper, guided vs unguided, attenuation, interference, and single-mode vs multimode.**
