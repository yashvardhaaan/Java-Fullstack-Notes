````md id="5g-basics"
# 5G Basics

## 1. What is 5G?

**5G = Fifth Generation of Mobile Networks.**

It is designed to provide:

- Higher data rates
- Lower latency
- Higher network capacity
- Massive number of connected devices
- Better support for diverse applications

> **5G is not simply "faster 4G"; it introduces new radio and network capabilities.**

---

# 2. Main 5G Use Cases ⭐⭐⭐⭐⭐

### 1️⃣ eMBB — Enhanced Mobile Broadband

High-speed data services.

Examples:
- 4K/8K streaming
- High-speed mobile Internet
- AR/VR

```text
eMBB
 ↓
High bandwidth
 ↓
High-speed applications
````

---

### 2️⃣ URLLC — Ultra-Reliable Low-Latency Communication

Designed for applications requiring very low latency and high reliability.

Examples:

* Industrial automation
* Remote control
* Critical communications

```text
URLLC
 ↓
Low latency + High reliability
```

---

### 3️⃣ mMTC — Massive Machine-Type Communications

Supports a huge number of connected devices.

Examples:

* IoT sensors
* Smart meters
* Smart-city devices

```text
mMTC
 ↓
Many devices
 ↓
IoT
```

🔥 Remember:

```text
eMBB  → Speed
URLLC → Low latency + reliability
mMTC  → Massive devices
```

---

# 3. 5G Architecture ⭐⭐⭐⭐⭐

Simplified:

```text
User Equipment (UE)
        ↓
    5G RAN
        ↓
   5G Core
        ↓
Internet / Services
```

### UE

Mobile phone, IoT device, etc.

### 5G RAN

Provides wireless radio access.

### 5G Core

Provides network functions such as:

* Authentication
* Mobility management
* Session management
* Policy control
* Connection to external networks

---

# 4. gNodeB ⭐⭐⭐⭐⭐

The main 5G NR base station is called:

**gNodeB (gNB)**

```text
UE
 ↓
gNodeB
 ↓
5G Core
 ↓
Internet
```

Comparison:

```text
4G → eNodeB
5G → gNodeB
```

---

# 5. 5G NR

**NR = New Radio**

5G NR is the radio access technology used by 5G.

```text
5G
 ↓
5G NR
 ↓
Radio communication
```

🔥 Don't confuse:

**5G = overall mobile-network generation**

**5G NR = 5G radio technology**

---

# 6. Frequency Bands ⭐⭐⭐⭐⭐

5G can operate across different frequency ranges.

### Low Band

* Large coverage
* Better propagation
* Lower capacity than higher bands

### Mid Band

* Good balance of coverage and capacity
* Important for many practical 5G deployments

### High Band / mmWave

* Very high capacity
* Very high frequencies
* Shorter range
* More sensitive to blockage/propagation loss

```text
Frequency ↑
   ↓
Potential bandwidth ↑

But generally:
Coverage ↓
Propagation challenges ↑
```

🔥 Don't say higher frequency **always** means higher speed. Actual speed depends on bandwidth, signal conditions, network configuration, etc.

---

# 7. Beamforming ⭐⭐⭐⭐⭐

Beamforming directs radio energy toward a particular user/device instead of transmitting equally in all directions.

```text
Without beamforming:

       ↑
    ↗  |  ↖
  ←────📡────→
    ↘  |  ↙


With beamforming:

📡 ═══════════→ 📱
```

### Benefits

* Better signal quality
* Better spatial reuse
* Improved coverage/capacity

---

# 8. Massive MIMO ⭐⭐⭐⭐⭐

**MIMO = Multiple Input Multiple Output**

Uses multiple antennas for transmission/reception.

**Massive MIMO** uses a large number of antenna elements.

```text
Many antennas
      ↓
Spatial processing
      ↓
Multiple users / better capacity
```

### Key idea

**MIMO → spatial dimension**

It can improve capacity, reliability, and efficiency.

---

# 9. Network Slicing ⭐⭐⭐⭐⭐

Network slicing creates multiple logical networks over shared physical infrastructure.

```text
                5G Infrastructure
                       │
        ┌──────────────┼──────────────┐
        ↓              ↓              ↓
     Slice A        Slice B        Slice C
      eMBB           URLLC           IoT
```

Each slice can have different:

* Performance requirements
* Security policies
* Resource characteristics

> **One physical infrastructure → multiple logical networks.**

---

# 10. Edge Computing ⭐⭐⭐⭐

Processing data closer to the user/device.

```text
Traditional:

Device → Core/Cloud → Response


Edge:

Device → Edge Server → Response
```

### Benefit

Shorter physical/network path can reduce latency.

Useful for:

* AR/VR
* Industrial applications
* Real-time processing

🔥 5G itself does not magically guarantee low latency; network architecture and deployment matter.

---

# 11. 5G NSA vs SA ⭐⭐⭐⭐⭐

### NSA — Non-Standalone

5G radio works with an existing 4G LTE core/network architecture.

```text
5G NR
  ↓
4G Core
```

### SA — Standalone

5G NR works with a **5G Core**.

```text
5G NR
  ↓
5G Core
```

| NSA                                  | SA                          |
| ------------------------------------ | --------------------------- |
| Uses 4G infrastructure/core elements | Uses 5G Core                |
| Faster migration                     | Full 5G architecture        |
| Depends on LTE components            | More native 5G capabilities |

🔥 **SA ≠ simply "better speed"; it enables the full 5G architecture/features.**

---

# 12. 5G Security

5G includes mechanisms for:

* Subscriber authentication
* Encryption
* Integrity protection
* Secure signaling
* Key management

Security is distributed across the radio and core network.

---

# 🔥 GATE Traps

1. **5G → Fifth-generation mobile network.**
2. **5G NR → New Radio.**
3. **gNodeB → 5G base station.**
4. **4G → eNodeB; 5G → gNodeB.**
5. eMBB → high-speed broadband.
6. URLLC → ultra-reliable low-latency communication.
7. mMTC → massive machine/device connectivity.
8. Higher frequency generally has more propagation challenges and shorter coverage.
9. **Beamforming → directional/spatial signal focusing.**
10. **Massive MIMO → many antennas + spatial processing.**
11. **Network slicing → multiple logical networks over shared infrastructure.**
12. NSA → uses 4G infrastructure/core elements.
13. SA → 5G NR + 5G Core.
14. Edge computing can reduce latency by moving processing closer to users.
15. 5G does **not** automatically guarantee a fixed data rate or latency.

---

# ⚡ 30-Second Revision

```text
5G
 ↓
5G NR
 ↓
gNodeB
 ↓
5G Core
 ↓
Internet

Use Cases:
eMBB  → Speed
URLLC → Low latency + reliability
mMTC  → Massive IoT

Technologies:
Beamforming → Directional transmission
Massive MIMO → Many antennas
Network Slicing → Logical networks
Edge Computing → Processing near user

Deployment:
NSA → 5G NR + 4G infrastructure/core
SA  → 5G NR + 5G Core
```

### 🎯 Priority

**GATE:** ⭐⭐⭐
**Placement:** ⭐⭐⭐⭐⭐

```

**10 – Wireless Networks completed.**
```
