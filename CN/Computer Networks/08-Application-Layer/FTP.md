````md id="ftp-gate"
# FTP — File Transfer Protocol

## 1. Definition

**FTP** is an Application Layer protocol used to **transfer files between a client and a server**.

> FTP uses a separate connection for **control** and **file/data transfer**.

---

# 2. FTP Ports ⭐⭐⭐⭐⭐

FTP traditionally uses:

```text
TCP 21 → Control connection
TCP 20 → Data connection (active mode)
````

🔥 Most important:

> **21 = Control**
> **20 = Data in traditional active mode**

---

# 3. FTP Architecture

```text
FTP Client                    FTP Server

    |                              |
    |==== Control Connection =====>|
    |          TCP 21              |
    |                              |
    |<==== Data Connection =======>|
    |          TCP 20*             |
    |                              |
```

The control connection remains available for commands such as:

```text
USER
PASS
LIST
RETR
STOR
QUIT
```

*Port 20 is associated with the server's data connection in **active FTP**. Passive FTP uses a dynamically negotiated server-side port for data.

---

# 4. Active vs Passive FTP ⭐⭐⭐⭐⭐

### Active FTP

```text
Client ── Control ──→ Server:21
Client ←── Data ───── Server:20
```

Server initiates the data connection toward the client.

### Passive FTP

```text
Client ── Control ──→ Server:21
Client ─── Data ────→ Server:Dynamic Port
```

Client initiates both connections.

🔥 Passive FTP is commonly useful when the client is behind a firewall/NAT.

---

# 5. FTP Commands ⭐⭐⭐⭐

| Command | Meaning                 |
| ------- | ----------------------- |
| USER    | Username                |
| PASS    | Password                |
| LIST    | List directory          |
| RETR    | Retrieve/download file  |
| STOR    | Upload/store file       |
| DELE    | Delete file             |
| CWD     | Change directory        |
| PWD     | Print working directory |
| QUIT    | End session             |

---

# 6. FTP vs HTTP ⭐⭐⭐⭐

| FTP                        | HTTP                           |
| -------------------------- | ------------------------------ |
| File transfer protocol     | Web/application protocol       |
| TCP                        | TCP traditionally              |
| Control + data connections | Request/response               |
| Port 21 control            | Port 80                        |
| Can upload/download files  | Mainly resource transfer       |
| Authentication supported   | Authentication mechanisms vary |

---

# 7. Is FTP Secure? 🔥

Traditional FTP sends credentials and data **without encryption**.

```text
FTP
 ↓
Plain communication
```

Therefore, ordinary FTP should not be considered secure for sensitive transfers.

Secure alternatives include:

* **FTPS** → FTP secured using TLS
* **SFTP** → File transfer over SSH

🔥 Important:

> **SFTP ≠ FTP + TLS**

SFTP is a different protocol based on SSH.

---

# 8. FTP vs SFTP vs FTPS ⭐⭐⭐⭐⭐

| Protocol | Security mechanism     |
| -------- | ---------------------- |
| FTP      | No built-in encryption |
| FTPS     | TLS                    |
| SFTP     | SSH                    |

Do not confuse:

```text
FTPS → FTP + TLS
SFTP → SSH-based file transfer
```

---

# 9. Why Two Connections?

FTP separates:

```text
Control
   +
Data
```

This allows commands and file transfers to be handled independently.

Example:

```text
Control:
"Send file X"

Data:
<File contents>
```

---

# 🔥 GATE Traps

### Trap 1

FTP uses UDP.

❌

> FTP uses **TCP**.

---

### Trap 2

FTP uses only one TCP connection.

❌

> FTP traditionally uses separate **control and data connections**.

---

### Trap 3

FTP control = port 20.

❌

> **Control = 21**

---

### Trap 4

FTP data always uses port 20.

⚠️

> Port 20 is associated with **active FTP** data transfer. Passive FTP uses a negotiated server port.

---

### Trap 5

SFTP is secure FTP using TLS.

❌

> **SFTP uses SSH.**

---

# ⚡ 30-Second Revision

```text
FTP
 ↓
Application Layer
 ↓
File Transfer
 ↓
TCP

Control connection → TCP 21

Active FTP:
Server data → TCP 20

Passive FTP:
Client connects to negotiated server data port

Security:
FTP  → No encryption
FTPS → TLS
SFTP → SSH
```

### 🔥 Must Remember

> **FTP = 21 control + separate data connection**

### GATE Priority

**🔥🔥🔥 — High**

Focus on:

1. Control vs data connection
2. Active vs passive FTP
3. Port 20 vs 21
4. FTP vs FTPS vs SFTP
5. TCP usage
