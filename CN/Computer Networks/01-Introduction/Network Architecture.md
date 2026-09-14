# CN 01 — Network Architecture

### First-Principles Notes for GATE + Placements

> **Goal:** Don't memorize definitions. Understand **why network architecture exists, what problem it solves, and how the pieces fit together.**

---

## 1. First Principle: Why do we need Network Architecture?

Imagine two computers:

```text
Computer A  ──────────────────  Computer B
```

A wants to send data to B.

At first this sounds simple:

> "Just send the bits."

But in a real network, many problems appear:

* How are bits represented?
* How does A know B's address?
* How does data travel through multiple networks?
* How do we detect errors?
* What if data is lost?
* What if packets arrive out of order?
* How do applications communicate?
* How do different manufacturers' devices communicate?

If one giant protocol handled everything, it would become extremely complicated.

So networking uses **layers**.

---

# 2. What is Network Architecture?

### Definition

**Network architecture is the overall design of a computer network that defines how different networking functions, protocols, devices, and layers work together.**

The central idea is:

```text
Complex communication
        ↓
Break into smaller responsibilities
        ↓
Layers
        ↓
Protocols
        ↓
Communication
```

### Example

When you send a message:

```text
Application
    ↓
Transport
    ↓
Network
    ↓
Data Link
    ↓
Physical
    ↓
Network
    ↓
Data Link
    ↓
Physical
```

Each layer has a **specific responsibility**.

---

# 3. The Fundamental Idea: Separation of Concerns

This is one of the most important ideas in networking.

Suppose you are sending a WhatsApp message.

The application should **not** need to know:

* which cable is being used,
* how Ethernet frames work,
* how routers calculate paths,
* how electrical signals are transmitted.

Instead:

```text
Application
"What data should I send?"

        ↓

Transport
"How should the data be delivered?"

        ↓

Network
"Which destination/network should it reach?"

        ↓

Data Link
"How should it move across this local link?"

        ↓

Physical
"How do I transmit the bits?"
```

This is called **separation of concerns**.

### Placement connection

This same principle appears everywhere in software engineering:

```text
Frontend
   ↓
API
   ↓
Business Logic
   ↓
Database
```

Networking uses the same fundamental philosophy.

---

# 4. Why Layers?

There are **5 major reasons**.

### 1. Complexity reduction

Instead of solving one huge problem:

```text
Communication = HUGE problem
```

we divide it:

```text
Communication
├── Application
├── Transport
├── Network
├── Data Link
└── Physical
```

---

### 2. Modularity

A layer can change without completely redesigning everything.

Example:

```text
Application
    ↑
Transport
    ↑
Network
    ↑
Data Link
    ↑
Physical
```

You can change:

```text
Ethernet → Wi-Fi
```

without rewriting the application.

---

### 3. Standardization

Different companies can build compatible systems.

For example:

```text
Dell computer
      ↕
Cisco router
      ↕
HP server
      ↕
Apple computer
```

They can communicate because they follow standardized protocols.

---

### 4. Easier troubleshooting

If communication fails, we can ask:

```text
Is application working?
       ↓
Transport?
       ↓
Network?
       ↓
Data Link?
       ↓
Physical?
```

Instead of examining the entire network simultaneously.

---

### 5. Independent development

Different technologies can evolve independently.

For example:

```text
Physical:
Copper → Fiber → Wireless

while

Application:
HTTP → HTTP/2 → HTTP/3
```

The entire architecture doesn't need to be rebuilt.

---

# 5. What is a Protocol?

This is **extremely important for GATE**.

A **protocol** is a set of rules that governs communication between entities.

Think about human communication.

If I say:

> "Hello"

you need to know:

* what language?
* what does the word mean?
* who speaks first?
* who responds?
* how do we end the conversation?

Computers also need rules.

A protocol defines things such as:

```text
Syntax
Semantics
Timing
```

### Syntax

**What does the message look like?**

Example:

```text
[Header][Data][Trailer]
```

### Semantics

**What does each field mean?**

Example:

```text
Source Address = sender
Destination Address = receiver
```

### Timing

**When/how fast should data be sent?**

Example:

```text
Send
   ↓
Wait for ACK
   ↓
Send next data
```

---

# 6. Protocol vs Architecture

This distinction is commonly tested.

### Architecture

Describes the **overall structure/design**.

```text
Application
Transport
Network
Data Link
Physical
```

### Protocol

Defines the **rules used within communication**.

Examples:

```text
HTTP
TCP
IP
Ethernet
DNS
```

So:

> **Architecture = structure**

> **Protocol = rules**

---

# 7. Network Architecture Components

At a high level:

```text
Network Architecture
        │
        ├── Layers
        │
        ├── Protocols
        │
        ├── Interfaces
        │
        └── Services
```

Let's understand the last two.

---

# 8. Interface

An **interface** defines how one layer communicates with another layer on the same machine.

Example:

```text
Application
     ↕
 Transport
     ↕
 Network
```

The interface tells the upper layer:

> "Here is how you can request services from me."

### Simple analogy

Restaurant:

```text
Customer
   ↓
Waiter
   ↓
Kitchen
```

The customer doesn't enter the kitchen.

The waiter acts as an **interface**.

---

# 9. Service

A **service** is what one layer provides to the layer above it.

For example:

```text
Transport Layer
       ↓
provides communication service
       ↓
Application Layer
```

So remember:

```text
Interface → HOW layers interact

Service → WHAT a layer provides
```

This distinction is useful in GATE questions.

---

# 10. Protocol vs Service vs Interface

| Concept          | Meaning                      |
| ---------------- | ---------------------------- |
| **Architecture** | Overall organization         |
| **Layer**        | Functional division          |
| **Protocol**     | Rules between peer entities  |
| **Service**      | What a layer provides upward |
| **Interface**    | How adjacent layers interact |

### Very important

A protocol is generally used between **peer entities**.

```text
Host A                         Host B

Transport ←── TCP protocol ──→ Transport
Network   ←── IP protocol ───→ Network
```

But a service is provided **vertically**:

```text
Transport
    ↑
 Service
    ↑
Application
```

---

# 11. Peer-to-Peer Communication

This is a foundational concept.

Suppose:

```text
Host A                         Host B

Application  ←────────────→  Application
Transport    ←────────────→  Transport
Network      ←────────────→  Network
```

The Application layer on A logically communicates with the Application layer on B.

These are called **peer entities**.

### Important:

The data doesn't physically jump directly from:

```text
Application A → Application B
```

Instead, it travels down the stack, across the network, and back up.

---

# 12. Encapsulation — The Big Picture

Suppose application produces:

```text
DATA
```

Transport adds its header:

```text
[TCP HEADER][DATA]
```

Network adds its header:

```text
[IP HEADER][TCP HEADER][DATA]
```

Data Link adds its header/trailer:

```text
[ETH HEADER][IP HEADER][TCP HEADER][DATA][ETH TRAILER]
```

Then Physical transmits:

```text
101010101010101...
```

This process is called **encapsulation**.

At receiver:

```text
Bits
 ↓
Frame
 ↓
Packet
 ↓
Segment
 ↓
Data
```

This is **decapsulation**.

---

# 13. PDU Names — GATE Favorite

Know this table:

| Layer       | Common PDU                    |
| ----------- | ----------------------------- |
| Application | Data/Message                  |
| Transport   | Segment (TCP), Datagram (UDP) |
| Network     | Packet/Datagram               |
| Data Link   | Frame                         |
| Physical    | Bits                          |

### Memory trick

**S P F B**

```text
Transport → Segment
Network   → Packet
Data Link → Frame
Physical  → Bits
```

---

# 14. Why Can't We Have Just One Layer?

Suppose a single protocol does everything:

```text
HTTP
+ TCP
+ IP
+ Ethernet
+ Wi-Fi
+ Error detection
+ Routing
+ Signals
```

Now change Ethernet to Wi-Fi.

You would potentially have to redesign the entire protocol.

With layers:

```text
Application
    ↓
Transport
    ↓
Network
    ↓
Data Link
    ↓
Wi-Fi
```

Only the lower technology changes.

That's the **power of layering**.

---

# 15. Advantages of Layered Architecture

### GATE-oriented list

Remember:

**M-S-I-T-E**

* **M**odularity
* **S**implicity
* **I**nteroperability
* **T**roubleshooting
* **E**xtensibility

### Advantages

1. Reduces complexity
2. Encourages modularity
3. Standardizes communication
4. Allows interoperability
5. Easier maintenance
6. Easier troubleshooting
7. Independent evolution of technologies

---

# 16. Disadvantages of Layering

GATE can also ask this.

Layering isn't perfect.

### 1. Overhead

Each layer may add headers.

```text
Original data = 100 bytes

After encapsulation:
Header + Header + Header + Data + Trailer
```

So transmitted data becomes larger.

---

### 2. Duplication

Different layers may perform somewhat similar functions.

For example, reliability can appear at different levels.

---

### 3. Inefficiency

Strict separation can sometimes prevent layers from optimizing together.

---

### 4. Cross-layer dependency

Real-world networks don't always follow perfectly isolated layers.

---

# 17. Architecture vs Implementation

Don't confuse:

```text
Architecture
```

with

```text
Implementation
```

Architecture tells us:

> **What responsibilities exist and how they are organized.**

Implementation tells us:

> **How those responsibilities are actually implemented.**

Example:

```text
Architecture:
Transport layer provides reliable delivery.

Implementation:
TCP implements that reliability using ACKs,
sequence numbers, retransmission, etc.
```

---

# 18. GATE Trap — "Layer = Protocol"

❌ Wrong:

> Every layer is a protocol.

✅ Correct:

A layer is a **functional abstraction**.

A layer may contain multiple protocols.

Example:

```text
Application Layer
 ├── HTTP
 ├── DNS
 ├── SMTP
 └── FTP
```

Similarly:

```text
Transport Layer
 ├── TCP
 └── UDP
```

---

# 19. GATE Trap — Protocol Communication

Consider:

```text
Host A                    Host B

TCP  ←────────────────→  TCP
IP   ←────────────────→  IP
```

TCP entities are **peers**.

IP entities are **peers**.

But:

```text
TCP
 ↓
IP
```

is not peer communication.

It is **service/interface interaction between adjacent layers**.

---

# 20. First-Principles Mental Model

Whenever you see a networking question, ask:

### Question 1

**What problem is being solved?**

Example:

> Packet needs to reach another network.

Answer → Network layer.

### Question 2

**Who is responsible?**

```text
Data transmission → Physical
Local delivery → Data Link
End-to-end delivery → Transport
Application communication → Application
```

### Question 3

**What information is required?**

```text
MAC address → Data Link
IP address → Network
Port number → Transport
Application protocol → Application
```

This way you can derive many answers instead of memorizing them.

---

# 21. Placement Questions You Should Be Able to Answer

### Q1. Why are networks layered?

**Answer:** To reduce complexity, provide modularity, standardization and interoperability, and allow independent evolution of components.

---

### Q2. What is a protocol?

A set of rules governing communication between peer entities.

---

### Q3. What is the difference between protocol and service?

**Protocol:** rules governing communication between peer entities.

**Service:** functionality provided by one layer to the layer above it.

---

### Q4. What is encapsulation?

Adding layer-specific control information as data moves down the protocol stack.

---

### Q5. Why can Ethernet be replaced by Wi-Fi without changing HTTP?

Because layering provides abstraction and modularity.

---

### Q6. What is peer-to-peer communication?

Communication between corresponding entities at the same layer on different systems.

---

# 22. GATE Quick Revision Sheet

```text
NETWORK ARCHITECTURE
        │
        ├── Layers
        │     └── Divide complex communication
        │
        ├── Protocols
        │     └── Rules between peer entities
        │
        ├── Services
        │     └── Provided upward
        │
        └── Interfaces
              └── Interaction between adjacent layers
```

### Remember:

```text
Architecture → Structure
Layer        → Responsibility
Protocol     → Rules
Service      → What is provided
Interface    → How adjacent layers interact
```

### Encapsulation

```text
Application
   ↓ Data
Transport
   ↓ Segment
Network
   ↓ Packet
Data Link
   ↓ Frame
Physical
   ↓ Bits
```

### Core GATE principle

> **Same layer → peer communication → protocol**

> **Adjacent layers → service/interface**

---

## ⭐ GATE Priority for this topic

**Importance: Medium**

You should understand this thoroughly, but **don't spend disproportionate time here**.

The real scoring power in CN comes later from:

**Data Link → IP/Subnetting → Routing → TCP/UDP → Flow/Congestion Control → Application protocols.**

For your folder, the natural next note should be **`Network Criteria.md`**, and I'll keep the same **first-principles → GATE concepts → tricks → placement questions** format.
