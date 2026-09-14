````md id="wifi"
# WiFi

## 1. What is WiFi?

**WiFi = Wireless LAN (WLAN) technology based on IEEE 802.11.**

It allows devices to communicate using **radio waves** instead of physical Ethernet cables.

> **WiFi = IEEE 802.11 wireless LAN**

---

# 2. Basic WiFi Architecture ⭐⭐⭐⭐⭐

```text
                Internet
                   │
                Router
                   │
            Access Point (AP)
             ↙    ↓     ↘
          Laptop Phone  PC
````

### Access Point (AP)

AP provides wireless connectivity between WiFi devices and the network.

**Station (STA)** = WiFi-enabled device.

---

# 3. WiFi Standards

| Standard | Common name | Band        |
| -------- | ----------- | ----------- |
| 802.11b  | WiFi        | 2.4 GHz     |
| 802.11a  | WiFi        | 5 GHz       |
| 802.11g  | WiFi        | 2.4 GHz     |
| 802.11n  | WiFi 4      | 2.4/5 GHz   |
| 802.11ac | WiFi 5      | 5 GHz       |
| 802.11ax | WiFi 6/6E   | 2.4/5/6 GHz |

🔥 For GATE, remember **802.11 = WLAN**.

---

# 4. CSMA/CA ⭐⭐⭐⭐⭐

WiFi uses **CSMA/CA — Carrier Sense Multiple Access with Collision Avoidance**.

Basic idea:

```text
Sense channel
     ↓
Busy? → Wait
     ↓
Free
     ↓
Random Backoff
     ↓
Transmit
     ↓
ACK?
 ┌───┴───┐
Yes     No
 ↓       ↓
Done   Retransmit
```

### Why CA instead of CD?

Wireless stations generally cannot reliably detect collisions while transmitting because their own transmitted signal overwhelms received signals.

Therefore:

> **Ethernet (traditional shared medium) → CSMA/CD**
> **WiFi → CSMA/CA**

---

# 5. ACK in WiFi ⭐⭐⭐⭐⭐

WiFi commonly uses acknowledgments at the MAC layer.

```text
Sender ───── DATA ─────→ Receiver
Sender ←──── ACK ─────── Receiver
```

If ACK is not received:

```text
No ACK
  ↓
Assume transmission failure
  ↓
Backoff + Retransmission
```

🔥 This is an important difference from basic shared Ethernet behavior.

---

# 6. Hidden Terminal Problem ⭐⭐⭐⭐⭐

Consider:

```text
A  ─────→  B  ←─────  C

A cannot hear C
C cannot hear A
```

A and C may transmit simultaneously to B.

➡️ **Collision occurs at B.**

### Solution

**RTS/CTS**

```text
A → RTS → B
A ← CTS ← B
A → DATA → B
A ← ACK ← B
```

RTS/CTS can help reduce hidden-terminal collisions.

---

# 7. Exposed Terminal Problem ⭐⭐⭐⭐

Example:

```text
A → B        C → D
```

C can hear A transmitting.

C may unnecessarily wait even though its transmission to D would not interfere with B.

➡️ **Unnecessary deferral = exposed terminal problem.**

---

# 8. WiFi vs Ethernet ⭐⭐⭐⭐⭐

| Feature             | WiFi                 | Traditional shared Ethernet |
| ------------------- | -------------------- | --------------------------- |
| Standard            | 802.11               | 802.3                       |
| Medium              | Wireless             | Wired                       |
| Access method       | CSMA/CA              | CSMA/CD                     |
| Collision detection | Difficult            | Possible in half-duplex     |
| ACK                 | Common MAC mechanism | Not like WiFi MAC ACK       |
| Address             | MAC address          | MAC address                 |

🔥 Modern switched full-duplex Ethernet normally has **no collisions**, so CSMA/CD is not used there.

---

# 9. BSS and ESS ⭐⭐⭐⭐

### BSS — Basic Service Set

A basic WiFi coverage area associated with an AP.

```text
       AP
    ↙  ↓  ↘
   STA STA STA
```

### ESS — Extended Service Set

Multiple APs connected through a distribution system.

```text
 AP1          AP2
 / \          / \
STA STA      STA STA
```

Allows wider coverage and mobility between APs.

---

# 10. SSID

**SSID = Service Set Identifier**

It is the network name users commonly see.

Example:

```text
Available WiFi:
 ├── Home_WiFi
 ├── Office_WiFi
 └── Campus_WiFi
```

🔥 **SSID is a network identifier/name, not a MAC address.**

---

# 11. WiFi Frequency Bands

Common WiFi bands:

* **2.4 GHz**
* **5 GHz**
* **6 GHz** (supported by newer WiFi generations)

### 2.4 GHz

* Longer range
* Better wall penetration generally
* More congestion/interference

### 5 GHz

* More channels/capacity
* Usually shorter range than 2.4 GHz
* Less crowded in many environments

### 6 GHz

* Additional spectrum
* Supports newer WiFi deployments
* Range generally shorter than lower frequencies

---

# 12. WiFi Security ⭐⭐⭐⭐⭐

Common generations:

```text
WEP  → Old / insecure
WPA  → Improvement
WPA2 → Stronger, widely deployed
WPA3 → Newer security
```

### Important

**WEP is considered insecure and should not be used for modern secure networks.**

---

# 13. Infrastructure vs Ad Hoc

### Infrastructure Mode

Devices communicate through an **AP**.

```text
STA → AP → STA
```

### Ad Hoc

Devices communicate directly without a traditional AP.

```text
STA ↔ STA ↔ STA
```

---

# 🔥 GATE Traps

1. **WiFi → IEEE 802.11**
2. WiFi is a **WLAN** technology.
3. WiFi uses **CSMA/CA**, not CSMA/CD.
4. WiFi commonly uses MAC-layer **ACKs**.
5. Hidden terminal → **RTS/CTS can help**.
6. Exposed terminal → unnecessary deferral.
7. **SSID = network identifier/name.**
8. **MAC address ≠ SSID.**
9. AP provides wireless network connectivity in infrastructure mode.
10. Modern switched full-duplex Ethernet does not normally use CSMA/CD.
11. WEP is insecure.
12. 802.11n = WiFi 4, 802.11ac = WiFi 5, 802.11ax = WiFi 6/6E.

---

# ⚡ 30-Second Revision

```text
WiFi
 ↓
IEEE 802.11
 ↓
WLAN
 ↓
AP + Stations
 ↓
CSMA/CA
 ↓
Random Backoff
 ↓
DATA → ACK

Problems:
Hidden Terminal → RTS/CTS
Exposed Terminal → Unnecessary waiting

Identity:
SSID → Network name
MAC  → Device/link address

Security:
WEP ❌
WPA2 ✅
WPA3 ✅
```

### 🎯 Priority

**GATE:** ⭐⭐⭐⭐⭐
**Placement:** ⭐⭐⭐⭐⭐

```
```
