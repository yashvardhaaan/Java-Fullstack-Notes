# CSMA/CA

## 1. What is CSMA/CA?

**CSMA/CA = Carrier Sense Multiple Access with Collision Avoidance**

It is primarily used by **IEEE 802.11 Wireless LAN (Wi-Fi)**.

> **CSMA/CD → traditional shared Ethernet**
> **CSMA/CA → Wi-Fi**

---

# 2. Why Wireless Uses Collision Avoidance

In wired Ethernet, a station can monitor the medium while transmitting and detect a collision.

In wireless networks, detecting collisions while transmitting is difficult because:

* A station's own transmitted signal is much stronger than received signals.
* Hidden terminals may exist.
* Wireless propagation is variable.

Therefore Wi-Fi tries to **avoid collisions before transmission** rather than detect them afterward.

---

# 3. Basic Working ⭐⭐⭐⭐⭐

```text id="f9g1i0"
Station wants to send
        ↓
Sense channel
        ↓
Channel busy?
   ┌────┴────┐
  Yes        No
   ↓          ↓
 Wait      Random Backoff
              ↓
       Counter reaches 0
              ↓
          Transmit
              ↓
           ACK?
        ┌─────┴─────┐
       Yes          No
        ↓            ↓
     Success      Backoff
```

---

# 4. Random Backoff

If the channel is idle, the station generally doesn't immediately transmit in every situation.

It chooses a **random backoff counter** from a contention window.

Example:

```text id="1y1s0v"
Contention Window = 0 ... 7

Random number = 5

Wait:
5 × slot time
```

The counter decreases while the channel remains idle.

If another station starts transmitting:

> The countdown **freezes**.

After the channel becomes idle again, the countdown resumes according to the protocol's rules.

---

# 5. ACK is Important 🔥

Wi-Fi uses acknowledgments because a transmitter cannot reliably detect collisions in the same way as CSMA/CD.

```text id="s2l1gu"
Sender ───── DATA ─────→ Receiver
Sender ←──── ACK ─────── Receiver
```

If the sender does not receive the expected ACK:

```text id="s9y7m0"
No ACK
  ↓
Assume transmission failed
  ↓
Increase contention window
  ↓
Backoff
  ↓
Retransmit
```

---

# 6. RTS/CTS

**RTS = Request to Send**

**CTS = Clear to Send**

Used as an optional mechanism to help deal with the **hidden terminal problem**.

```text id="5cg7qm"
Sender → RTS → Receiver
Sender ← CTS ← Receiver
Sender → DATA → Receiver
Sender ← ACK ← Receiver
```

Other nearby stations hearing the CTS defer their transmissions.

---

# 7. Hidden Terminal Problem ⭐⭐⭐⭐⭐

Consider:

```text id="8ngh9c"
A  ─────→  B  ←─────  C
```

A and C can both reach B.

But:

```text id="rj4b7u"
A ↛ C
C ↛ A
```

A cannot hear C, and C cannot hear A.

Therefore:

```text id="j6gkgu"
A transmits ──┐
              ├──→ B
C transmits ──┘
       ↓
   Collision
```

This is the **hidden terminal problem**.

### RTS/CTS can help

```text id="6o9x8a"
A → RTS → B
A ← CTS ← B
```

C hears the CTS and waits.

---

# 8. Exposed Terminal Problem

Opposite situation:

```text id="f9g5hc"
A → B

C → D
```

C can hear A and assumes the medium is busy.

But C's transmission to D may actually be possible without interfering with A → B.

C unnecessarily waits.

This is the **exposed terminal problem**.

---

# 9. CSMA/CD vs CSMA/CA

| Feature                  | CSMA/CD              | CSMA/CA         |
| ------------------------ | -------------------- | --------------- |
| Main use                 | Traditional Ethernet | Wi-Fi           |
| Strategy                 | Detect collision     | Avoid collision |
| ACK                      | Not fundamental      | Important       |
| Random backoff           | Yes                  | Yes             |
| RTS/CTS                  | No                   | Optional        |
| Wireless hidden terminal | Not the main issue   | Important       |

---

# 🔥 GATE Traps

### Trap 1

**Wi-Fi uses CSMA/CD.**

❌ Wrong.

> Wi-Fi → **CSMA/CA**

---

### Trap 2

**CSMA/CA guarantees that collisions never occur.**

❌ No.

It **reduces the probability** of collisions.

---

### Trap 3

**RTS/CTS is mandatory for every Wi-Fi transmission.**

❌ No.

It is an optional mechanism used in appropriate situations.

---

### Trap 4

**RTS/CTS solves every wireless problem.**

❌ No.

It primarily helps with the **hidden terminal problem**.

---

# ⚡ 30-Second Revision

```text id="k1qk0e"
CSMA/CA
   ↓
Wi-Fi
   ↓
Sense channel
   ↓
Random Backoff
   ↓
Transmit
   ↓
ACK received?
 ┌──────┴──────┐
Yes           No
 ↓             ↓
Success     Backoff + Retry

Hidden Terminal
A ↛ C
A → B ← C
     ↓
   Collision

RTS/CTS → helps with hidden terminal
```

### GATE Priority

**CSMA/CA mechanism → 🔥🔥🔥🔥**
**Hidden terminal → 🔥🔥🔥🔥🔥**
**RTS/CTS → 🔥🔥🔥🔥**
**CSMA/CD vs CA → 🔥🔥🔥🔥🔥**
