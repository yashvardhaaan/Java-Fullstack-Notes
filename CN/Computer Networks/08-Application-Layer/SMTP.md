````md id="smtp-gate"
# SMTP — Simple Mail Transfer Protocol

## 1. Definition

**SMTP** is an Application Layer protocol used primarily for **sending and relaying email**.

> SMTP = **Send/Transfer mail**

```text
Sender Mail Client
       ↓
     SMTP
       ↓
Mail Server
       ↓
     SMTP
       ↓
Receiver Mail Server
````

---

# 2. SMTP Ports ⭐⭐⭐⭐⭐

Common SMTP ports:

|    Port | Use                                        |
| ------: | ------------------------------------------ |
|  **25** | SMTP relay/server-to-server                |
| **587** | Message submission, commonly with STARTTLS |
| **465** | SMTP submission over implicit TLS          |

🔥 For traditional GATE questions:

> **SMTP → TCP 25**

---

# 3. SMTP Uses TCP ⭐⭐⭐⭐⭐

SMTP uses:

```text
SMTP
 ↓
TCP
 ↓
IP
```

Why TCP?

Email delivery requires reliable, ordered transfer of the message data.

---

# 4. SMTP is for Sending, Not Retrieving ⭐⭐⭐⭐⭐

This is one of the most important distinctions.

```text
SMTP → Send / relay email
POP3 → Retrieve email
IMAP → Retrieve/manage email
```

### Easy trick

> **SMTP = Send**
> **POP3/IMAP = Receive**

---

# 5. SMTP Flow ⭐⭐⭐⭐⭐

Example:

```text
Alice
  ↓
Alice's Mail Server
  ↓
SMTP
  ↓
Bob's Mail Server
  ↓
Mailbox
  ↓
Bob retrieves mail
```

The receiving user may then use:

```text
POP3 / IMAP
```

to access the mailbox.

---

# 6. SMTP Basic Commands ⭐⭐⭐

Common commands include:

| Command   | Purpose                            |
| --------- | ---------------------------------- |
| HELO/EHLO | Identify client/start SMTP session |
| MAIL FROM | Specify sender                     |
| RCPT TO   | Specify recipient                  |
| DATA      | Send message contents              |
| QUIT      | End session                        |

Typical flow:

```text
HELO/EHLO
   ↓
MAIL FROM
   ↓
RCPT TO
   ↓
DATA
   ↓
Message
   ↓
QUIT
```

---

# 7. SMTP vs POP3 vs IMAP ⭐⭐⭐⭐⭐

| Feature                     | SMTP            | POP3     | IMAP            |
| --------------------------- | --------------- | -------- | --------------- |
| Main purpose                | Send/relay      | Retrieve | Retrieve/manage |
| Typical ports               | 25/587/465      | 110/995  | 143/993         |
| TCP                         | ✅               | ✅        | ✅               |
| Mailbox synchronization     | ❌               | Limited  | ✅               |
| Server-side mail management | Not its purpose | Limited  | Strong          |

---

# 8. SMTP Relay

SMTP can transfer mail between mail servers.

```text
Sender Server
      ↓
    SMTP
      ↓
Receiver Server
```

This is called **mail relaying**.

---

# 9. SMTP and DNS ⭐⭐⭐⭐⭐

SMTP commonly relies on DNS to discover the destination mail server.

For a domain such as:

```text
example.com
```

DNS provides:

```text
MX Record
   ↓
Mail server for example.com
```

Then SMTP can communicate with that mail server.

```text
DNS MX
 ↓
Find mail server
 ↓
SMTP
 ↓
Deliver mail
```

🔥 Very useful GATE connection:

> **MX record → mail server**

---

# 🔥 GATE Traps

### Trap 1

SMTP is used to receive email.

❌

> SMTP → **sending/relaying**

---

### Trap 2

POP3 is used to send email.

❌

> POP3 → **retrieval**

---

### Trap 3

SMTP uses UDP.

❌

> SMTP → **TCP**

---

### Trap 4

SMTP always uses port 25.

⚠️

Port **25** is the traditional SMTP relay port; **587** is commonly used for message submission and **465** for implicit TLS.

---

### Trap 5

SMTP directly finds the recipient's IP without DNS.

❌

DNS, particularly **MX records**, is commonly used to locate the receiving mail server.

---

# ⚡ 30-Second Revision

```text id="smtp-revision"
SMTP
 ↓
Application Layer
 ↓
Send / Relay Email
 ↓
TCP

Ports:
25  → Traditional SMTP relay
587 → Message submission
465 → SMTP over implicit TLS

Flow:
HELO/EHLO
 ↓
MAIL FROM
 ↓
RCPT TO
 ↓
DATA
 ↓
QUIT

SMTP → Send
POP3 → Retrieve
IMAP → Retrieve + Synchronize/manage
```

### 🔥 Must Remember

> **SMTP sends mail. POP3/IMAP retrieve mail. MX records identify mail servers.**

### GATE Priority

**🔥🔥🔥🔥 — Very High**

Focus on:

1. SMTP vs POP3 vs IMAP
2. SMTP ports
3. TCP usage
4. MX record relationship
5. Basic SMTP communication flow

```
```
