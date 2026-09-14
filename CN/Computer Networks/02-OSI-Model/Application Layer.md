# Application Layer — OSI Layer 7

## 1. What is the Application Layer?

**L7 = provides network services directly to applications.**

### First principle

> **L7 answers: "What network service does the application need?"**

```text
User/Application
       ↓
 Application Layer
       ↓
   Transport
```

---

## 2. Important Protocols ⭐⭐⭐⭐⭐

| Protocol       | Purpose                    |
| -------------- | -------------------------- |
| **HTTP/HTTPS** | Web communication          |
| **DNS**        | Domain name → IP address   |
| **FTP**        | File transfer              |
| **SMTP**       | Sending email              |
| **POP3**       | Receiving email            |
| **IMAP**       | Receiving/managing email   |
| **DHCP**       | Automatic IP configuration |
| **SSH**        | Secure remote login        |

### GATE focus

**DNS, HTTP, FTP, SMTP, DHCP** are particularly important.

---

# 3. HTTP / HTTPS

### HTTP

Used for communication between **web clients and web servers**.

```text
Browser ── HTTP Request ──→ Server
Browser ←─ HTTP Response ── Server
```

### HTTPS

**HTTP + secure TLS protection**

```text
HTTP
 +
TLS
 ↓
HTTPS
```

Default ports:

```text
HTTP  → 80
HTTPS → 443
```

---

# 4. DNS ⭐⭐⭐⭐⭐

**DNS = Domain Name System**

Converts a domain name into an IP address.

```text
google.com
     ↓ DNS
IP address
```

### Why?

Humans prefer:

```text
example.com
```

Machines ultimately communicate using network addresses such as:

```text
IP address
```

### Common port

**DNS → 53**

DNS commonly uses **UDP**, but TCP is also used in several situations.

---

# 5. FTP

**FTP = File Transfer Protocol**

Used to transfer files between client and server.

Common ports:

```text
FTP control → 21
FTP data    → 20 (traditional active mode)
```

### GATE

Don't simply memorize "FTP = port 20."
**Port 21 is the control connection**, while data handling depends on FTP mode.

---

# 6. SMTP

**SMTP = Simple Mail Transfer Protocol**

Primarily used for **sending/relaying email**.

Common ports:

```text
25  → SMTP relay
587 → message submission
465 → commonly used for SMTP over TLS
```

### Think:

> **SMTP → Send Mail**

---

# 7. POP3 vs IMAP

Both are used for **retrieving email**.

### POP3

Generally downloads messages to the client.

### IMAP

Keeps mail synchronized with the server and supports server-side mailbox management.

### Trick

> **POP3 → Download**

> **IMAP → Synchronize**

---

# 8. DHCP ⭐⭐⭐⭐

**DHCP = Dynamic Host Configuration Protocol**

Automatically provides configuration such as:

* IP address
* Subnet mask
* Default gateway
* DNS server

### DORA ⭐⭐⭐⭐⭐

```text
D → Discover
O → Offer
R → Request
A → Acknowledgment
```

```text
Client → Discover
Server → Offer
Client → Request
Server → ACK
```

### Port

```text
DHCP Server → UDP 67
DHCP Client → UDP 68
```

---

# 9. SSH

**SSH = Secure Shell**

Used for secure remote login/command execution.

```text
Client ── encrypted connection ──→ Server
```

Default port:

**22**

---

# 🔥 Application Protocol Quick Table

| Protocol | Main Job              |       Port |
| -------- | --------------------- | ---------: |
| HTTP     | Web                   |         80 |
| HTTPS    | Secure web            |        443 |
| DNS      | Name resolution       |         53 |
| FTP      | File transfer         |      20/21 |
| SMTP     | Email sending/relay   | 25/587/465 |
| POP3     | Email retrieval       |    110/995 |
| IMAP     | Email synchronization |    143/993 |
| DHCP     | IP configuration      |      67/68 |
| SSH      | Secure remote access  |         22 |

---

# 🧠 GATE Traps

### Trap 1

```text
DNS → Application
HTTP → Application
DHCP → Application
```

Even though they use UDP/TCP underneath.

---

### Trap 2

**DNS does not assign IP addresses.**

```text
DNS    → Name ↔ IP resolution
DHCP   → Network configuration
```

---

### Trap 3

**SMTP is mainly for sending/relaying mail.**

```text
SMTP → Send
POP3/IMAP → Retrieve
```

---

### Trap 4

Application Layer does **not mean the application itself**.

It means the **network protocols/services used by applications**.

---

# ⚡ 30-Second Revision

```text
L7 APPLICATION
│
├── HTTP/HTTPS → Web
├── DNS        → Name resolution
├── FTP        → File transfer
├── SMTP       → Send email
├── POP3/IMAP  → Receive/manage email
├── DHCP       → IP configuration
└── SSH        → Secure remote access
```

### Must remember

**DNS → 53**

**HTTP → 80**

**HTTPS → 443**

**SSH → 22**

**DHCP → 67/68**

**SMTP → 25/587**

### GATE Priority: ⭐⭐⭐⭐

### Placement Priority: ⭐⭐⭐⭐⭐

For placements, **DNS + HTTP/HTTPS + TCP + DHCP** are especially important because they are frequently used in practical networking questions.
