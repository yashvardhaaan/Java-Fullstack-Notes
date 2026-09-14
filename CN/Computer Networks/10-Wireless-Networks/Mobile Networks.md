````md id="mobile-networks"
# Mobile Networks

## 1. What is a Mobile Network?

A **mobile/cellular network** allows wireless devices to communicate while moving between geographic coverage areas called **cells**.

> **Cellular network = area divided into cells + base stations + core network**

```text
        Cell 1          Cell 2
      ┌────────┐      ┌────────┐
      │   📱   │      │   📱   │
      │   📡   │──────│   📡   │
      └────────┘      └────────┘
          ↓               ↓
             Core Network
                  ↓
              Internet
````

---

# 2. Cell ⭐⭐⭐⭐⭐

A **cell** is a geographic coverage area served by a base station.

Instead of one huge transmitter:

```text
❌ One huge coverage area
```

the network uses many smaller cells:

```text
✅ Small cells
   ↓
Better frequency reuse
Better capacity
```

---

# 3. Base Station

The base station provides the **radio connection** between mobile devices and the network.

Terminology varies by generation:

| Generation | Base-station terminology |
| ---------- | ------------------------ |
| 2G         | BTS                      |
| 3G         | NodeB                    |
| 4G         | eNodeB                   |
| 5G         | gNodeB                   |

🔥 Don't confuse **base station** with the entire mobile network.

---

# 4. Cellular Architecture ⭐⭐⭐⭐⭐

Simplified:

```text
Mobile Device
     ↓
Radio Access Network (RAN)
     ↓
Core Network
     ↓
Internet / Other Networks
```

### RAN

Handles the **radio/wireless access**.

### Core Network

Handles functions such as:

* Mobility management
* Authentication
* Session management
* Routing
* Connection to external networks

---

# 5. Frequency Reuse ⭐⭐⭐⭐⭐

The same frequency resources can be reused in sufficiently separated cells.

```text
   A       B       A
      B       B
   A       B       A
```

Cells using the same frequency are separated enough to limit interference.

### Main benefit

**More capacity using limited spectrum.**

---

# 6. Handoff / Handover ⭐⭐⭐⭐⭐

When a user moves from one cell to another, the connection may be transferred from one base station/cell to another.

```text
Cell A                  Cell B
  📡                      📡
   \                      /
    \     📱 →           /
     ────────────────────
          Moving
```

```text
Old Cell
   ↓
Handover
   ↓
New Cell
```

> **Handover maintains connectivity while the user moves between cells.**

---

# 7. Roaming vs Handover ⭐⭐⭐⭐⭐

### Handover

Movement between cells/base stations while maintaining service.

### Roaming

A subscriber uses service through a network outside their **home network**, subject to agreements and authentication.

| Handover                       | Roaming                                  |
| ------------------------------ | ---------------------------------------- |
| Mobility between cells         | Use of another operator/network          |
| Usually occurs during movement | Can occur when outside home network      |
| Maintains session/service      | Involves subscriber/network relationship |

🔥 They are **not the same thing**.

---

# 8. Generations of Mobile Networks

| Generation | Main characteristics                                                  |
| ---------- | --------------------------------------------------------------------- |
| 1G         | Analog voice                                                          |
| 2G         | Digital voice + SMS                                                   |
| 3G         | Mobile data + improved multimedia                                     |
| 4G         | High-speed all-IP mobile broadband                                    |
| 5G         | Higher capacity, lower latency potential, massive device connectivity |

---

# 9. 2G / 3G / 4G / 5G

### 2G

* Digital cellular
* Voice
* SMS
* Data through technologies such as GPRS/EDGE

### 3G

* Higher-speed mobile data
* Better multimedia support
* Technologies such as UMTS/WCDMA

### 4G

* High-speed IP-based mobile broadband
* LTE is the major 4G technology family
* LTE uses packet-based architecture

### 5G

Designed for:

* Enhanced mobile broadband
* Massive IoT connectivity
* Low-latency/high-reliability use cases

---

# 10. SIM / Subscriber Identity ⭐⭐⭐⭐

A SIM/eSIM securely stores subscriber-related information and credentials used by the mobile network.

```text
Subscriber
    ↓
SIM / eSIM
    ↓
Authentication
    ↓
Mobile Network
```

🔥 **SIM identifies/authenticates the subscriber; it is not the same as the phone's IMEI.**

---

# 11. IMEI vs IMSI ⭐⭐⭐⭐⭐

### IMEI

Identifies the **mobile equipment/device**.

### IMSI

Identifies the **mobile subscriber** in cellular systems.

| IMEI                              | IMSI                                    |
| --------------------------------- | --------------------------------------- |
| Device/equipment identity         | Subscriber identity                     |
| Associated with handset equipment | Associated with subscriber/SIM identity |

🔥 Very common interview question.

---

# 12. Mobile Network Security

Mobile networks use mechanisms for:

* Subscriber authentication
* Encryption over radio links
* Integrity protection
* Key management

The exact mechanisms differ between generations.

---

# 13. Small Cells ⭐⭐⭐⭐

Smaller cells can increase capacity in high-density areas.

Examples:

* Macrocell → large coverage
* Microcell
* Picocell
* Femtocell

```text
Macrocell
   ↓
Large coverage

Small cell
   ↓
Smaller coverage + higher local capacity
```

---

# 🔥 GATE Traps

1. **Cell = geographic coverage area served by a base station.**
2. Cellular networks use **frequency reuse**.
3. Handover transfers service between cells/base stations.
4. **Handover ≠ roaming.**
5. RAN handles radio access; core network handles broader network functions.
6. **IMEI → device/equipment.**
7. **IMSI → subscriber identity.**
8. SIM/eSIM is associated with subscriber authentication.
9. 1G → analog voice.
10. 2G → digital voice/SMS.
11. 3G → improved mobile data.
12. 4G/LTE → high-speed IP-based mobile broadband.
13. 5G supports eMBB, massive IoT, and low-latency/high-reliability use cases.
14. Frequency reuse improves capacity but can introduce co-channel interference.

---

# ⚡ 30-Second Revision

```text
Mobile Network
      ↓
Cells
      ↓
Base Stations
      ↓
RAN
      ↓
Core Network
      ↓
Internet

Moving user
      ↓
Handover
      ↓
New Cell

Frequency Reuse
      ↓
More capacity

IMEI → Device
IMSI → Subscriber

Generations:
1G → Analog voice
2G → Digital + SMS
3G → Mobile data
4G → High-speed IP
5G → eMBB + IoT + low latency
```

### 🎯 Priority

**GATE:** ⭐⭐⭐⭐
**Placement:** ⭐⭐⭐⭐⭐

```
```
