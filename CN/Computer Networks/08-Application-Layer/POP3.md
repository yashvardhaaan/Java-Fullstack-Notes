````md id="pop3-gate"
# POP3 — Post Office Protocol Version 3

## 1. Definition

**POP3** is an Application Layer protocol used to **retrieve email from a mail server**.

> POP3 = **Download mail from server to client**

```text
Mail Server
    ↓
   POP3
    ↓
Mail Client
````

---

# 2. POP3 Ports ⭐⭐⭐⭐⭐

|    Port | Purpose               |
| ------: | --------------------- |
| **110** | POP3                  |
| **995** | POP3 over TLS (POP3S) |

POP3 uses:

```text
POP3
 ↓
TCP
 ↓
IP
```

🔥 Remember:

> **POP3 = TCP 110**
> **POP3S = TCP 995**

---

# 3. How POP3 Works ⭐⭐⭐⭐⭐

Typical flow:

```text
Mail Server
     ↓
   POP3
     ↓
Client downloads emails
```

The user can then read the downloaded messages locally.

---

# 4. POP3 Connection States ⭐⭐⭐⭐

POP3 has three main states:

```text
Authorization
      ↓
Transaction
      ↓
Update
```

### 1. Authorization

Client authenticates:

```text
USER
PASS
```

### 2. Transaction

Client accesses messages:

```text
STAT
LIST
RETR
DELE
```

### 3. Update

When the session ends, deletion changes are committed.

```text
QUIT
```

---

# 5. Important POP3 Commands ⭐⭐⭐⭐

| Command | Purpose                   |
| ------- | ------------------------- |
| USER    | Username                  |
| PASS    | Password                  |
| STAT    | Mailbox status            |
| LIST    | List messages             |
| RETR    | Retrieve message          |
| DELE    | Mark message for deletion |
| QUIT    | End session               |

🔥 `RETR` → retrieve mail.

---

# 6. POP3 vs IMAP ⭐⭐⭐⭐⭐

| POP3                           | IMAP                          |
| ------------------------------ | ----------------------------- |
| Mainly downloads mail          | Synchronizes mail             |
| Simple                         | More feature-rich             |
| Traditionally client-oriented  | Server/mailbox-oriented       |
| Limited server-side management | Strong server-side management |
| Good for local/offline storage | Good for multiple devices     |
| TCP 110                        | TCP 143                       |
| TLS: 995                       | TLS: 993                      |

---

# 7. POP3 vs SMTP ⭐⭐⭐⭐⭐

```text
SMTP
 ↓
Send email
```

```text
POP3
 ↓
Retrieve email
```

Example:

```text
Sender
  ↓
SMTP
  ↓
Mail Server
  ↓
POP3
  ↓
Receiver
```

---

# 8. POP3 and Multiple Devices

POP3 traditionally downloads messages to the client and may remove them from the server depending on client configuration.

Therefore, it is less suitable than IMAP when the same mailbox needs to remain synchronized across:

```text
Phone
Laptop
Tablet
```

---

# 🔥 GATE Traps

### Trap 1

POP3 sends email.

❌

> POP3 → **retrieves email**

---

### Trap 2

POP3 uses UDP.

❌

> POP3 → **TCP**

---

### Trap 3

POP3 port is 25.

❌

```text
SMTP → 25
POP3 → 110
```

---

### Trap 4

POP3 and IMAP are the same.

❌

> POP3 mainly downloads; IMAP provides richer mailbox synchronization/management.

---

### Trap 5

POP3S means a completely different mail protocol.

❌

> POP3S = POP3 protected with TLS.

---

# ⚡ 30-Second Revision

```text
POP3
 ↓
Application Layer
 ↓
Retrieve Email
 ↓
TCP

Port:
110 → POP3
995 → POP3 over TLS

States:
Authorization
     ↓
Transaction
     ↓
Update

Commands:
USER
PASS
LIST
RETR
DELE
QUIT
```

### 🔥 Must Remember

> **SMTP → Send**
> **POP3 → Download/Retrieve**
> **IMAP → Synchronize/Manage mailbox**

### GATE Priority

**🔥🔥🔥 — High**

Focus on:

1. POP3 vs SMTP vs IMAP
2. Port 110/995
3. TCP usage
4. POP3 states
5. Basic commands
