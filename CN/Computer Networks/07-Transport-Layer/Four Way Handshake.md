````md id="four-way-handshake"
# TCP Four-Way Handshake — Connection Termination

## 1. Definition

TCP normally uses a **4-segment exchange** to gracefully terminate a connection.

> **FIN → ACK → FIN → ACK**

Why 4 steps?

Because TCP is **full-duplex**: each direction of communication is closed independently.

---

## 2. Four-Way Termination ⭐⭐⭐⭐⭐

```text
Client                         Server

  |                              |
  |--------- FIN --------------->|
  |                              |
  |<-------- ACK ----------------|
  |                              |
  |<-------- FIN ----------------|
  |                              |
  |--------- ACK --------------->|
  |                              |
       Connection closed
````

---

# 3. Step-by-Step

### Step 1 — Client sends FIN

```text
Client ───── FIN ─────→ Server
```

Client says:

> "I have no more data to send."

The client enters:

```text
FIN-WAIT-1
```

🔥 FIN consumes **1 sequence number**.

---

### Step 2 — Server sends ACK

```text
Client ←──── ACK ───── Server
```

Server acknowledges the FIN.

If:

```text
FIN Seq = 1000
```

then:

```text
ACK = 1001
```

The server can **still send data** to the client.

This is called a **half-closed connection**.

---

### Step 3 — Server sends FIN

After the server finishes sending its remaining data:

```text
Client ←──── FIN ───── Server
```

Server says:

> "I have no more data to send either."

🔥 This FIN also consumes **1 sequence number**.

---

### Step 4 — Client sends ACK

```text
Client ───── ACK ─────→ Server
```

If:

```text
Server FIN Seq = 2000
```

then:

```text
ACK = 2001
```

Connection is terminated.

---

# 4. Why Can't It Be 3-Way?

Because the two directions are closed **independently**.

```text
Client → Server
   ↓
Client has finished sending

Server → Client
   ↓
Server may still have data
```

Therefore:

```text
FIN
 ↓
ACK

...server finishes remaining data...

FIN
 ↓
ACK
```

Sometimes an ACK and FIN can be combined:

```text
FIN + ACK
```

So the actual number of packets can sometimes differ, but the conceptual termination process is **four-way**.

---

# 5. TCP States ⭐⭐⭐⭐⭐

Typical active closer:

```text
ESTABLISHED
     ↓
FIN-WAIT-1
     ↓
FIN-WAIT-2
     ↓
TIME-WAIT
     ↓
CLOSED
```

Typical passive closer:

```text
ESTABLISHED
     ↓
CLOSE-WAIT
     ↓
LAST-ACK
     ↓
CLOSED
```

---

# 6. TIME-WAIT ⭐⭐⭐⭐⭐

The side that sends the **final ACK** typically enters:

```text
TIME-WAIT
```

Why?

### Reason 1 — Retransmitted FIN

If the final ACK is lost:

```text
Server ── FIN ──→ Client
```

the server may retransmit FIN.

TIME-WAIT allows the client to send the ACK again.

### Reason 2 — Old delayed segments

TIME-WAIT helps prevent old duplicate segments from interfering with a later connection.

> TIME-WAIT is about **safe TCP connection termination**, not simply "waiting for the server."

---

# 7. FIN vs RST ⭐⭐⭐⭐

### FIN

```text
Graceful termination
```

Means:

> "I have finished sending."

### RST

```text
Abrupt termination
```

Means:

> "Immediately reset/abort this connection."

| FIN                                 | RST                      |
| ----------------------------------- | ------------------------ |
| Graceful                            | Abrupt                   |
| Normal termination                  | Error/forced termination |
| Allows remaining data to be handled | Immediately terminates   |

---

# 🔥 GATE Traps

### Trap 1

TCP connection termination = 3-way handshake.

❌

> Normal graceful termination is conceptually **4-way**.

---

### Trap 2

FIN does not consume a sequence number.

❌

> **FIN consumes 1 sequence number.**

---

### Trap 3

After receiving FIN, the receiver must immediately stop sending.

❌

TCP is full-duplex.

> One direction can close while the other continues.

---

### Trap 4

TIME-WAIT means the connection is still normally usable.

❌

It is a TCP termination state used for safe cleanup.

---

### Trap 5

FIN and RST mean the same thing.

❌

```text
FIN → graceful
RST → abrupt
```

---

# ⚡ 30-Second Revision

```text
TCP Termination

1. FIN  →
2. ← ACK
3. ← FIN
4. ACK  →

FIN consumes 1 sequence number.

FIN = graceful close
RST = abrupt reset

TIME-WAIT:
→ final ACK side
→ handles retransmitted FIN
→ prevents old delayed segments
```

### GATE Priority

**🔥🔥🔥🔥 — Very High**

Focus on:

1. FIN/ACK sequence numbers
2. Half-close
3. TIME-WAIT
4. FIN vs RST
5. TCP state transitions

```
```
