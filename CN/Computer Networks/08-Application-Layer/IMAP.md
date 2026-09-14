````md id="imap-gate"
# IMAP — Internet Message Access Protocol

## 1. Definition

**IMAP** is an Application Layer protocol used to **access, retrieve, and manage email while keeping the mailbox on the mail server**.

> IMAP = **Server-side mailbox synchronization**

```text
Mail Server
     ↕
    IMAP
     ↕
Client
````

---

# 2. IMAP Ports ⭐⭐⭐⭐⭐

|    Port | Purpose       |
| ------: | ------------- |
| **143** | IMAP          |
| **993** | IMAP over TLS |

IMAP uses:

```text
IMAP
 ↓
TCP
 ↓
IP
```

🔥 Remember:

> **IMAP = TCP 143**
> **IMAPS = TCP 993**

---

# 3. Why IMAP? ⭐⭐⭐⭐⭐

Suppose you use the same email account on:

```text
Laptop
Phone
Tablet
```

With IMAP, the mailbox remains primarily on the server and clients synchronize with it.

```text
                 Server
               Mailbox
              ↙   ↓   ↘
          Laptop Phone Tablet
```

Actions such as:

* Read
* Delete
* Move
* Mark as unread

can be synchronized across devices.

---

# 4. IMAP vs POP3 ⭐⭐⭐⭐⭐

| IMAP                       | POP3                              |
| -------------------------- | --------------------------------- |
| Server-side mailbox        | Mainly download-oriented          |
| Synchronizes messages      | Mainly retrieves messages         |
| Multiple-device friendly   | Less suitable for synchronization |
| Supports folders           | More limited                      |
| Server keeps mailbox state | Client-oriented                   |
| TCP 143                    | TCP 110                           |
| TLS 993                    | TLS 995                           |

### Easy Trick

> **POP3 → Pull/download**
> **IMAP → Internet/server mailbox management**

---

# 5. IMAP vs SMTP ⭐⭐⭐⭐⭐

```text
SMTP
 ↓
Send / relay email
```

```text
IMAP
 ↓
Access / retrieve / manage email
```

Typical email flow:

```text
Sender
  ↓
SMTP
  ↓
Recipient Mail Server
  ↓
IMAP
  ↓
Recipient's device
```

---

# 6. IMAP Folders ⭐⭐⭐⭐

IMAP allows messages to be organized into server-side folders/mailboxes.

Examples:

```text
Inbox
Sent
Drafts
Trash
Work
Personal
```

Changes can be synchronized with the server.

---

# 7. IMAP and Multiple Devices ⭐⭐⭐⭐⭐

Example:

```text
Phone:
Read Email A
     ↓
Server state updated
     ↓
Laptop:
Email A appears as read
```

This is a major advantage over traditional download-oriented POP3 usage.

---

# 8. IMAP Commands ⭐⭐⭐

Some common commands include:

| Command | Purpose                                         |
| ------- | ----------------------------------------------- |
| LOGIN   | Authenticate                                    |
| SELECT  | Select mailbox                                  |
| FETCH   | Retrieve message data                           |
| SEARCH  | Search messages                                 |
| STORE   | Change message flags                            |
| COPY    | Copy messages                                   |
| EXPUNGE | Permanently remove messages marked for deletion |
| LOGOUT  | End session                                     |

---

# 🔥 GATE Traps

### Trap 1

IMAP is used to send email.

❌

> **SMTP → Send**

> **IMAP → Retrieve/manage**

---

### Trap 2

IMAP uses UDP.

❌

> IMAP → **TCP**

---

### Trap 3

IMAP port = 110.

❌

```text
POP3 → 110
IMAP → 143
```

---

### Trap 4

IMAP downloads all mail and removes it from the server.

❌

> IMAP is designed around **server-side mailbox access and synchronization**.

---

### Trap 5

IMAPS is a completely unrelated protocol.

❌

> IMAPS = **IMAP protected using TLS**, commonly TCP 993.

---

# ⚡ 30-Second Revision

```text id="imap-revision"
IMAP
 ↓
Application Layer
 ↓
Access + Retrieve + Manage Email
 ↓
TCP

143 → IMAP
993 → IMAP over TLS

Main advantage:
Server-side mailbox
       ↓
Synchronization
       ↓
Multiple devices
```

### 🔥 Must Remember

```text
SMTP → Send
POP3 → Download/Retrieve
IMAP → Synchronize/Manage
```

### GATE Priority

**🔥🔥🔥 — High**

Focus on:

1. IMAP vs POP3
2. IMAP vs SMTP
3. Ports 143/993
4. Server-side synchronization
5. Multiple-device behavior
