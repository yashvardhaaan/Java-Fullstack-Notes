# 03 — Network Devices

## 1. Network Device

A **network device** connects, forwards, or controls communication between network nodes.

The key question is:

> **At which layer does the device primarily operate?**

---

## 2. Hub

**Layer:** Physical (L1)

* Receives bits/signals
* Sends them to **all ports**
* No address filtering
* No intelligence
* One collision domain

```text
A ──┐
B ──┼── HUB → all ports
C ──┘
```

**Trick:**

> Hub = **Broadcasts everything**

---

## 3. Switch

**Layer:** Data Link (L2)

* Uses **MAC addresses**
* Forwards Ethernet frames to the appropriate port
* Learns MAC addresses
* Each port is generally a separate collision domain
* Supports full-duplex communication

```text
        Switch
       /   |   \
      A    B    C
```

### Key

**Switch → MAC → L2**

---

## 4. Router

**Layer:** Network (L3)

* Uses **IP addresses**
* Connects different networks
* Selects paths for packets
* Separates broadcast domains

```text
Network A ── Router ── Network B
```

### Key

**Router → IP → L3**

---

## 5. Bridge

**Layer:** Data Link (L2)

* Connects LAN segments
* Uses MAC addresses
* Filters/forwards frames

### Important

A **switch is essentially a multi-port bridge**.

```text
Bridge → few ports
Switch → many ports
```

---

## 6. Repeater

**Layer:** Physical (L1)

* Regenerates/reshapes signals
* Extends transmission distance
* Does not understand MAC/IP addresses

**Key:**

> Repeater = **Regenerate signal**

---

## 7. Gateway

**Can operate at higher layers**, depending on implementation.

Used to connect **different systems/protocols/architectures**.

Example:

```text
Network A → Gateway → Network B
```

### Important distinction

A **default gateway** in an IP network is typically the router that forwards traffic outside the local network.

---

## 8. Modem

**Modulator + Demodulator**

Converts signals between forms suitable for transmission over a communication medium.

```text
Digital → Analog
Analog  → Digital
```

Modern modems may use more sophisticated digital signaling, but the fundamental idea remains signal conversion/modulation.

---

# 🔥 Most Important Comparison

| Device       | Layer            | Main Address/Function      |
| ------------ | ---------------- | -------------------------- |
| **Repeater** | L1               | Regenerate signal          |
| **Hub**      | L1               | Send to all ports          |
| **Bridge**   | L2               | MAC                        |
| **Switch**   | L2               | MAC                        |
| **Router**   | L3               | IP                         |
| **Gateway**  | Higher layers*   | Protocol/system conversion |
| **Modem**    | Physical-related | Modulation/Demodulation    |

*Gateway is not restricted to one OSI layer.

---

# 🧠 GATE Tricks

### MAC vs IP

```text
MAC → Switch/Bridge
IP  → Router
```

### Collision vs Broadcast

**Switch:** separates collision domains.

**Router:** separates broadcast domains.

**Hub:** single collision domain.

---

## Placement Questions

**Q: Hub vs Switch?**

> Hub blindly forwards signals to all ports; switch intelligently forwards frames using MAC addresses.

**Q: Switch vs Router?**

> Switch primarily connects devices within a LAN using MAC addresses; router connects different networks using IP addresses.

**Q: Why is router used between two networks?**

> Because routers operate at Layer 3 and make forwarding decisions using network-layer addresses.

---

### ⭐ Priority

**GATE: ⭐⭐⭐⭐**
**Placement: ⭐⭐⭐⭐⭐**

Focus especially on:

**Hub vs Switch vs Router + OSI layer + MAC/IP + collision/broadcast domains.**
