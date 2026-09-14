````md id="snmp-gate"
# SNMP — Simple Network Management Protocol

## 1. Definition

**SNMP** is an Application Layer protocol used to **monitor and manage network devices**.

> SNMP = **Network monitoring + management**

It can monitor:

- Routers
- Switches
- Servers
- Printers
- Network interfaces
- Traffic statistics

---

# 2. SNMP Architecture ⭐⭐⭐⭐

SNMP mainly uses:

```text
Manager
   ↕
 Agent
   ↓
Managed Device
````

### SNMP Manager

Central monitoring system that:

* Requests information
* Receives alerts
* Can modify managed parameters

### SNMP Agent

Software running on the managed device.

It:

* Collects device information
* Responds to manager requests
* Sends notifications

---

# 3. SNMP Components

```text
SNMP Manager
     ↓
Network Management
     ↓
SNMP Agent
     ↓
Managed Device
     ↓
Management Information Base (MIB)
```

### MIB

**Management Information Base**

Contains the structured definitions/objects representing information that can be monitored or managed.

Examples:

```text
Interface status
CPU information
Traffic counters
Device information
```

---

# 4. SNMP Operations ⭐⭐⭐⭐⭐

Important operations:

| Operation | Meaning                                |
| --------- | -------------------------------------- |
| GET       | Manager requests value                 |
| GET-NEXT  | Retrieve next object                   |
| GET-BULK  | Retrieve large set efficiently         |
| SET       | Manager changes a value                |
| RESPONSE  | Agent replies                          |
| TRAP      | Agent sends notification               |
| INFORM    | Notification requiring acknowledgement |

---

# 5. GET vs SET

### GET

```text
Manager ── GET ──→ Agent
Manager ← Value ── Agent
```

> "Tell me the interface status."

### SET

```text
Manager ── SET ──→ Agent
```

> "Change this configurable parameter."

---

# 6. TRAP ⭐⭐⭐⭐⭐

A **TRAP** is an unsolicited notification from the agent to the manager.

```text
Something happens
      ↓
Agent
      ↓
TRAP
      ↓
Manager
```

Example:

```text
Interface goes down
       ↓
SNMP Agent
       ↓
SNMP TRAP
       ↓
Network Manager
```

🔥 Important:

> **GET = Manager asks**
> **TRAP = Agent informs**

---

# 7. SNMP Ports ⭐⭐⭐⭐⭐

Traditional SNMP uses UDP:

```text
UDP 161 → Queries/Responses
UDP 162 → TRAP/INFORM notifications
```

🔥 Must remember:

```text
161 → Manager ↔ Agent operations
162 → Notifications
```

---

# 8. Why UDP?

SNMP traditionally uses UDP because network management benefits from:

* Low overhead
* Simple request/response communication
* No connection establishment

```text
SNMP
 ↓
UDP
 ↓
IP
```

---

# 9. SNMP Versions ⭐⭐⭐⭐

Main versions:

```text
SNMPv1
SNMPv2c
SNMPv3
```

### SNMPv1

Basic SNMP.

### SNMPv2c

Improved operations and performance, but community-string-based security remains weak.

### SNMPv3 ⭐

Adds stronger security features such as:

* Authentication
* Integrity
* Encryption/privacy

> **SNMPv3 is the security-focused version.**

---

# 10. SNMP vs HTTP

| SNMP                  | HTTP                             |
| --------------------- | -------------------------------- |
| Network management    | Web/application communication    |
| Usually UDP           | Usually TCP for HTTP/1.1, HTTP/2 |
| Ports 161/162         | 80/443                           |
| Manager/Agent model   | Client/Server                    |
| Monitoring/management | Web resources/APIs               |

---

# 🔥 GATE Traps

### Trap 1

SNMP uses TCP.

❌

> Traditional SNMP → **UDP**

---

### Trap 2

SNMP port is 80.

❌

```text
SNMP → 161/162
HTTP → 80
```

---

### Trap 3

TRAP is a request from manager to agent.

❌

> **TRAP = agent → manager notification**

---

### Trap 4

GET changes a device parameter.

❌

> **GET → read**

> **SET → modify**

---

### Trap 5

SNMP is only for monitoring.

⚠️

SNMP can also support **management/configuration operations**, such as SET.

---

### Trap 6

SNMPv3 is identical to SNMPv1 security.

❌

> SNMPv3 provides significantly stronger security mechanisms.

---

# ⚡ 30-Second Revision

```text
SNMP
 ↓
Application Layer
 ↓
Network Management

Manager ↔ Agent ↔ Device

GET      → Read
SET      → Modify
TRAP     → Agent notification
INFORM   → Notification + acknowledgement

UDP:
161 → Requests/Responses
162 → TRAP/INFORM

SNMPv3 → Stronger security
```

### 🔥 Must Remember

> **SNMP = Network Management**
> **161 = Operations**
> **162 = Notifications**
> **GET = Read**
> **SET = Write**
> **TRAP = Agent → Manager**

### GATE Priority

**🔥🔥 — Medium**

For GATE, prioritize **SNMP purpose, Manager/Agent, GET/SET/TRAP, and ports 161/162**.

```
```
