````md id="ssh-gate"
# SSH — Secure Shell

## 1. Definition

**SSH (Secure Shell)** is an Application Layer protocol used for **secure remote login and secure communication** over an insecure network.

> SSH = **Secure remote access**

```text
Client
   │
   │ Encrypted SSH connection
   ↓
Server
````

---

# 2. SSH Port ⭐⭐⭐⭐⭐

SSH uses:

```text
TCP → Port 22
```

🔥 Remember:

> **SSH = TCP 22**

---

# 3. What Can SSH Do?

SSH can provide:

* Secure remote login
* Remote command execution
* Secure file transfer
* Port forwarding/tunneling
* Secure administration

Example:

```text
Your PC
   ↓
SSH
   ↓
Remote Linux Server
   ↓
Execute commands
```

---

# 4. Why SSH is Secure? ⭐⭐⭐⭐⭐

SSH provides:

```text
Confidentiality
      +
Integrity
      +
Server authentication
      +
User authentication
```

Communication is encrypted after the SSH connection establishes its secure session.

---

# 5. SSH Authentication ⭐⭐⭐⭐

Common authentication methods:

### Password Authentication

```text
Username + Password
```

### Public-Key Authentication ⭐

Client has:

```text
Private Key → kept secret
Public Key  → associated with server/account
```

The private key should **never be shared**.

Public-key authentication is commonly preferred for secure server administration.

---

# 6. SSH vs Telnet ⭐⭐⭐⭐⭐

| SSH                       | Telnet                                    |
| ------------------------- | ----------------------------------------- |
| Secure                    | Insecure/plaintext by default             |
| Encrypted communication   | No encryption                             |
| TCP 22                    | TCP 23                                    |
| Remote login              | Remote login                              |
| Authentication mechanisms | Basic login                               |
| Used today                | Mostly obsolete for secure administration |

🔥 Most important:

```text
SSH   → 22 → Secure
Telnet → 23 → Insecure
```

---

# 7. SSH vs FTP/SFTP ⭐⭐⭐⭐

Do not confuse these:

```text
SSH
 ↓
Secure remote shell
```

```text
SFTP
 ↓
File transfer over SSH
```

SFTP is **not FTP secured with TLS**.

---

# 8. SSH Port Forwarding ⭐⭐⭐

SSH can create encrypted tunnels.

Example:

```text
Client
  ↓
Encrypted SSH tunnel
  ↓
Internal service
```

Useful for securely accessing services that aren't directly exposed.

---

# 9. SSH Basic Connection

Example:

```bash
ssh user@server
```

Conceptually:

```text
ssh
 ↓
TCP connection
 ↓
Port 22
 ↓
Authentication
 ↓
Encrypted session
```

---

# 🔥 GATE Traps

### Trap 1

SSH uses UDP.

❌

> SSH → **TCP 22**

---

### Trap 2

SSH and Telnet are equally secure.

❌

> SSH encrypts communication; Telnet does not provide encryption by default.

---

### Trap 3

SFTP = FTP + TLS.

❌

> **SFTP = SSH-based file transfer**

> **FTPS = FTP + TLS**

---

### Trap 4

SSH's private key should be sent to the server.

❌

> **Private key remains secret.**

---

### Trap 5

SSH is only used for remote login.

❌

SSH also supports command execution, tunneling/port forwarding and related secure file-transfer mechanisms.

---

# ⚡ 30-Second Revision

```text id="ssh-revision"
SSH
 ↓
Secure Shell
 ↓
Application Layer
 ↓
TCP
 ↓
Port 22

Provides:
✓ Encryption
✓ Integrity
✓ Authentication
✓ Remote login
✓ Command execution
✓ Tunneling

SSH  → 22 → Secure
Telnet → 23 → Insecure
```

### 🔥 Must Remember

> **SSH = TCP 22 = Secure remote access**

### GATE Priority

**🔥🔥🔥 — High**

Focus on:

1. SSH port 22
2. SSH vs Telnet
3. Encryption/authentication
4. Public vs private keys
5. SFTP vs FTPS

```
```
