````md id="telnet-gate"
# Telnet — Teletype Network

## 1. Definition

**Telnet** is an Application Layer protocol used for **remote login and remote command execution**.

> Telnet provides remote terminal access, but **does not encrypt communication**.

```text
Client
  │
  │ Telnet
  ↓
Remote Server
````

---

# 2. Telnet Port ⭐⭐⭐⭐⭐

Telnet uses:

```text
TCP → Port 23
```

🔥 Remember:

> **Telnet = TCP 23**

---

# 3. How Telnet Works

A client establishes a TCP connection to the remote server:

```text
Client
  ↓
TCP connection
  ↓
Port 23
  ↓
Remote terminal
```

Commands typed by the user are sent to the server over the connection.

---

# 4. Major Problem — No Encryption ⭐⭐⭐⭐⭐

Traditional Telnet sends communication in **plaintext**.

Example:

```text
Username: yash
Password: abc123
```

An attacker able to observe the traffic may potentially capture the credentials.

```text
Client ── plaintext ──→ Server
              ↑
          Attacker
```

Therefore:

> **Telnet should not be used for secure remote administration.**

---

# 5. Telnet vs SSH ⭐⭐⭐⭐⭐

| Telnet                         | SSH                                           |
| ------------------------------ | --------------------------------------------- |
| TCP 23                         | TCP 22                                        |
| No encryption                  | Encrypted                                     |
| Insecure                       | Secure                                        |
| Remote login                   | Remote login                                  |
| Credentials can be exposed     | Protected by secure authentication/encryption |
| Mostly obsolete for secure use | Widely used                                   |

### Easy Trick

```text
SSH    → 22 → Secure
Telnet → 23 → Plain/Insecure
```

---

# 6. Telnet vs HTTP

Both are Application Layer protocols, but their purposes differ.

```text
Telnet → Remote terminal/login
HTTP   → Web communication
```

---

# 7. Telnet and TCP ⭐⭐⭐⭐

Telnet itself does not provide reliable transport.

It relies on:

```text
Telnet
  ↓
TCP
  ↓
IP
```

TCP provides:

* Reliable delivery
* Ordered byte stream
* Connection management

---

# 8. TELNET Commands / Negotiation ⭐⭐⭐

Telnet supports negotiation of terminal options using control commands.

Important concept:

> Telnet can negotiate characteristics of the terminal/session between client and server.

For GATE, knowing **Telnet = remote login + TCP 23 + plaintext/insecure** is usually more important than memorizing individual negotiation commands.

---

# 🔥 GATE Traps

### Trap 1

Telnet uses UDP.

❌

> Telnet → **TCP 23**

---

### Trap 2

Telnet encrypts passwords.

❌

> Traditional Telnet communication is **plaintext**.

---

### Trap 3

Telnet and SSH are equivalent in security.

❌

> SSH provides secure encrypted communication; Telnet does not.

---

### Trap 4

Telnet is a Transport Layer protocol.

❌

> Telnet → **Application Layer**

---

### Trap 5

Telnet = FTP.

❌

```text
Telnet → Remote login
FTP    → File transfer
```

---

# ⚡ 30-Second Revision

```text
TELNET
  ↓
Application Layer
  ↓
Remote login / terminal
  ↓
TCP
  ↓
Port 23

Problem:
❌ No encryption
❌ Insecure for sensitive remote administration

SSH:
TCP 22 → Secure
Telnet:
TCP 23 → Insecure
```

### 🔥 Must Remember

> **Telnet = TCP 23 = Remote login but plaintext/insecure**

### GATE Priority

**🔥🔥 — Medium**

Focus on:

1. Port 23
2. TCP usage
3. Telnet vs SSH
4. Plaintext/insecurity
5. Remote terminal purpose

```
```
