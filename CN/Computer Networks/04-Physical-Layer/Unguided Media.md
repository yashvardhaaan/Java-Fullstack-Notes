# Unguided Media

## 1. What is Unguided Media?

**Unguided media = wireless transmission where signals travel through free space instead of a physical cable.**

```text
Sender )))))))  Free Space  ((((((( Receiver
```

Main types:

* **Radio waves**
* **Microwaves**
* **Infrared**

---

# 2. Radio Waves ⭐⭐⭐

* Generally omnidirectional
* Can travel through/around obstacles better than highly directional microwave links
* Used in radio, TV, Wi-Fi, cellular communication

### Think

> **Radio → broad coverage**

---

# 3. Microwaves ⭐⭐⭐⭐

Usually **directional** and commonly used for point-to-point communication.

```text
Tower A  ─────────────→  Tower B
```

Uses:

* Cellular backhaul
* Satellite communication
* Long-distance wireless links

### Important

Microwave links often require **line of sight**.

---

# 4. Satellite Communication ⭐⭐⭐

Satellite communication uses **microwave frequencies**.

```text
Earth Station
      ↑
      │
   Satellite
      │
      ↓
Earth Station
```

### Advantages

* Very large coverage area
* Useful for remote locations

### Disadvantage

Long propagation distance can produce **significant delay**, especially with high-altitude satellites.

---

# 5. Infrared ⭐⭐

* Short range
* Generally directional
* Cannot effectively penetrate walls
* Used for short-range communication/control applications

### Think

> **Infrared → short range + limited penetration**

---

# 6. Radio vs Microwave vs Infrared

| Feature          | Radio                  | Microwave                 | Infrared            |
| ---------------- | ---------------------- | ------------------------- | ------------------- |
| Direction        | Often broad            | Usually directional       | Usually directional |
| Range            | Variable/large         | Medium–large              | Short               |
| Line of sight    | Not always             | Often required            | Generally important |
| Wall penetration | Better                 | Limited                   | Poor                |
| Examples         | Wi-Fi, cellular, radio | Satellite, point-to-point | Remote controls     |

---

# 🔥 GATE Concepts

### 1. Line of Sight

For many microwave systems:

> Sender and receiver need a sufficiently clear path.

Obstacles can block or weaken the signal.

---

### 2. Propagation Delay

Satellite communication can have noticeable delay because the signal travels a very large distance.

$$
T_p=\frac{d}{v}
$$

---

### 3. Interference

Wireless communication is generally more exposed to:

* Interference
* Noise
* Obstacles
* Weather/environmental effects

than well-shielded guided media.

---

# 🧠 GATE Traps

### Trap 1

**Microwave ≠ always satellite.**

Microwaves are also used for terrestrial point-to-point links.

### Trap 2

**Satellite communication ≠ radio-frequency cable.**

The communication path is through free space.

### Trap 3

**Infrared generally does not pass effectively through walls.**

### Trap 4

Don't assume every wireless technology requires strict line-of-sight. The requirement depends on frequency and propagation characteristics.

---

# ⚡ Quick Revision

```text
UNGUIDED MEDIA
│
├── Radio
│   └── Broad coverage
│
├── Microwave
│   ├── Directional
│   └── Often line-of-sight
│
└── Infrared
    ├── Short range
    └── Poor wall penetration
```

### Remember

**Radio → broad**

**Microwave → directional + LOS**

**Infrared → short range + cannot effectively penetrate walls**

### GATE Priority: ⭐⭐⭐

### Placement Priority: ⭐⭐⭐⭐

Focus on **radio vs microwave vs infrared, line-of-sight, satellite delay, and characteristics of wireless transmission**.
