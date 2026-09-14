````md id="bluetooth"
# Bluetooth

## 1. What is Bluetooth?

**Bluetooth** is a short-range wireless communication technology used to connect nearby devices.

> **Bluetooth → PAN (Personal Area Network)**

Examples:
- Phone ↔ Earbuds
- Phone ↔ Smartwatch
- Laptop ↔ Keyboard

---

# 2. Bluetooth Characteristics ⭐⭐⭐⭐

| Feature | Bluetooth |
|---|---|
| Network type | WPAN |
| Range | Short |
| Medium | Radio |
| Power | Generally low |
| Use | Personal/device connectivity |
| Common band | 2.4 GHz ISM |

---

# 3. Bluetooth vs WiFi ⭐⭐⭐⭐⭐

| Feature | Bluetooth | WiFi |
|---|---|---|
| Network | WPAN | WLAN |
| Range | Shorter | Generally longer |
| Power | Lower | Generally higher |
| Main use | Device-to-device | LAN/Internet access |
| Example | Earbuds | Laptop → AP |

🔥 **Bluetooth is not a replacement for WiFi.**

---

# 4. Bluetooth Network Structure

### Piconet ⭐⭐⭐⭐

A small Bluetooth network.

```text
        Master
       /  |  \
      S1  S2  S3
````

Traditionally, Bluetooth terminology uses:

* **Master** → central device
* **Slave** → peripheral devices

Modern Bluetooth terminology commonly uses:

* **Central**
* **Peripheral**

### Scatternet

Multiple piconets can be interconnected through devices participating in more than one piconet.

```text
Piconet A        Piconet B
   ↓                ↓
 Central          Central
  / \              / \
 S1  Bridge ───── S3  S4
```

---

# 5. Bluetooth Pairing ⭐⭐⭐⭐⭐

Pairing establishes a relationship between devices and allows them to authenticate and establish keys.

Example:

```text
Phone
  ↓
Search nearby device
  ↓
Pair
  ↓
Authenticate
  ↓
Establish keys
  ↓
Secure communication
```

🔥 Pairing is **not simply "connecting to WiFi."**

---

# 6. Bluetooth Classic vs BLE ⭐⭐⭐⭐⭐

## Bluetooth Classic

Designed for continuous data/streaming use cases.

Examples:

* Wireless headphones
* Speakers
* Older peripherals

## Bluetooth Low Energy (BLE)

Designed for **low-power communication**.

Examples:

* Fitness trackers
* Sensors
* Smart devices
* Beacons

| Classic                        | BLE                              |
| ------------------------------ | -------------------------------- |
| Continuous/streaming use cases | Low-power periodic communication |
| Higher power generally         | Very low power                   |
| Audio traditionally common     | Sensors/IoT common               |

---

# 7. Frequency Hopping ⭐⭐⭐⭐⭐

Bluetooth operates in the **2.4 GHz ISM band** and uses frequency-hopping techniques.

Basic idea:

```text
Channel 1
   ↓
Channel 7
   ↓
Channel 20
   ↓
Channel 4
   ↓
...
```

The communicating devices follow an agreed hopping sequence.

### Benefit

Helps reduce the effect of interference on a particular frequency.

---

# 8. Bluetooth Security

Bluetooth security can involve:

* Device authentication
* Encryption
* Pairing
* Key establishment

Older Bluetooth security mechanisms had vulnerabilities; modern Bluetooth versions provide stronger security when properly configured.

🔥 Security depends on the Bluetooth version, pairing method, and configuration.

---

# 9. Bluetooth Applications

```text
Bluetooth
 ├── Earbuds
 ├── Speakers
 ├── Keyboard / Mouse
 ├── Smartwatch
 ├── Fitness tracker
 ├── Sensors
 └── IoT devices
```

---

# 🔥 GATE Traps

1. **Bluetooth → WPAN**
2. Bluetooth commonly operates in the **2.4 GHz ISM band**.
3. Bluetooth is designed for **short-range** communication.
4. **WiFi → WLAN**, Bluetooth → **WPAN**.
5. Bluetooth uses frequency-hopping techniques.
6. **BLE → low-power applications.**
7. Piconet = small Bluetooth network.
8. Scatternet = interconnected piconets.
9. Pairing is used to establish trust/keys between devices.
10. Bluetooth and WiFi can interfere because both commonly use the 2.4 GHz band.
11. Modern terminology prefers **Central/Peripheral** over Master/Slave.

---

# ⚡ 30-Second Revision

```text
Bluetooth
    ↓
WPAN
    ↓
Short range
    ↓
2.4 GHz ISM
    ↓
Frequency hopping

Piconet
    ↓
Small Bluetooth network

BLE
    ↓
Low power
    ↓
Sensors / IoT / wearables

WiFi
    ↓
WLAN

Bluetooth
    ↓
WPAN
```

### 🎯 Priority

**GATE:** ⭐⭐⭐
**Placement:** ⭐⭐⭐⭐

```
```
