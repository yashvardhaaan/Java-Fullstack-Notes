````md id="3wayhandshake"
# TCP Three-Way Handshake

## 1. Definition

The **3-way handshake** establishes a TCP connection between client and server and synchronizes their initial sequence numbers.

> **SYN → SYN-ACK → ACK**

---

## 2. Why 3 Steps?

Both sides need to confirm:

1. Client can send → server can receive
2. Server can send → client can receive
3. Both sides agree on initial sequence numbers

---

## 3. Three-Way Handshake ⭐⭐⭐⭐⭐

Assume:

```text
Client ISN = 100
Server ISN = 500
````

### Step 1 — SYN

```text
Client ───── SYN, Seq=100 ─────→ Server
```

Client says:

> "I want to establish a connection. My initial sequence number is 100."

Client enters:

```text
SYN-SENT
```

---

### Step 2 — SYN + ACK

```text
Client ←── SYN=1, ACK=101, Seq=500 ── Server
```

Server says:

> "I received your SYN. My sequence number is 500."

Why:

```text
ACK = 100 + 1 = 101
```

Server enters:

```text
SYN-RECEIVED
```

---

### Step 3 — ACK

```text
Client ───── ACK=501 ─────→ Server
```

Because:

```text
ACK = Server Seq + 1
    = 500 + 1
    = 501
```

Connection becomes:

```text
ESTABLISHED
```

---

# 4. Complete Diagram ⭐⭐⭐⭐⭐

```text
                 CLIENT                 SERVER

                    |                     |
                    |  SYN, Seq=100      |
                    |------------------->|
                    |                     |
                    |  SYN+ACK            |
                    |  Seq=500            |
                    |  ACK=101            |
                    |<-------------------|
                    |                     |
                    |  ACK=501            |
                    |------------------->|
                    |                     |
                    |   ESTABLISHED       |
                    |<===================>|
```

---

# 5. Why Does SYN Consume 1 Sequence Number? ⭐⭐⭐⭐⭐

A **SYN consumes one sequence number**, even though it carries no application data.

If:

```text
SYN Seq = 100
```

then:

```text
Next expected sequence = 101
```

Similarly, **FIN also consumes one sequence number**.

🔥 GATE favorite:

```text
SYN → consumes 1 sequence number
FIN → consumes 1 sequence number
```

---

# 6. Important ACK Rule

TCP ACK number generally means:

> **The next sequence number the receiver expects.**

Example:

```text
Received bytes:
1000–1499
```

Then:

```text
ACK = 1500
```

---

# 7. Why Not Two-Way Handshake?

Suppose:

```text
Client ─── SYN ───→ Server
Server ─── ACK ───→ Client
```

The server knows the client can send.

But a proper handshake also needs the client to know that:

> **The server can receive and send, and its sequence number has been synchronized.**

The third ACK confirms the server's SYN.

---

# 8. TCP States ⭐⭐⭐⭐

During establishment:

```text
Client:
CLOSED
  ↓
SYN-SENT
  ↓
ESTABLISHED
```

Server:

```text
LISTEN
  ↓
SYN-RECEIVED
  ↓
ESTABLISHED
```

---

# 9. SYN Flood Attack 🔥

An attacker can send many SYN requests without completing the handshake.

```text
Attacker ── SYN ──→ Server
Attacker ── SYN ──→ Server
Attacker ── SYN ──→ Server
...
```

Server keeps partially established connections.

This can exhaust resources.

> **SYN flood = DoS/DDoS attack targeting TCP connection establishment.**

---

# 🔥 GATE Traps

### Trap 1

TCP uses a 2-way handshake.

❌

> TCP connection establishment = **3-way handshake**

---

### Trap 2

SYN does not consume a sequence number.

❌

> **SYN consumes 1 sequence number.**

---

### Trap 3

FIN does not consume a sequence number.

❌

> **FIN consumes 1 sequence number.**

---

### Trap 4

ACK number means the last byte received.

❌

> ACK = **next byte expected**

---

### Trap 5

The third ACK establishes both directions independently.

⚠️ More precisely, it acknowledges the server's SYN and completes establishment from the client's side.

---

# ⚡ 30-Second Revision

```text
TCP 3-Way Handshake

1. SYN
   Client → Server
   Seq = x

2. SYN + ACK
   Server → Client
   Seq = y
   ACK = x + 1

3. ACK
   Client → Server
   ACK = y + 1

→ Connection Established
```

### Must Remember

```text
SYN → consumes 1 sequence number
FIN → consumes 1 sequence number
ACK → next byte expected

Client: SYN-SENT → ESTABLISHED
Server: SYN-RECEIVED → ESTABLISHED
```

### GATE Priority

**🔥🔥🔥🔥🔥 — Extremely High**

Expect **sequence-number/ACK-number numericals** from this topic.

```
```
