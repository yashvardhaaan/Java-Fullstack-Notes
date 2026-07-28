# TCP (Transmission Control Protocol)

## What is TCP?

**TCP (Transmission Control Protocol)** is a **connection-oriented** communication protocol that allows two devices to exchange data **reliably, accurately, and in order**.

It is one of the core protocols of the Internet and works at the **Transport Layer (Layer 4)** of the OSI Model.

> **Definition:** TCP is a transport-layer protocol that provides reliable, ordered, and error-checked communication between two devices.

---

# Why Do We Need TCP?

Imagine downloading a 5 GB movie.

If some data is lost during transmission, the movie becomes corrupted.

TCP ensures:

- No data loss
- Correct order of data
- Error checking
- Reliable communication

Without TCP, important applications like:

- Banking
- Email
- File Transfer
- Web Browsing

would not work correctly.

---

# Real-World Example

Imagine sending a book through a courier.

```
Book

↓

Split into Pages

↓

Courier Delivers

↓

Receiver Checks

↓

Missing Page?

↓

Yes → Send Again

↓

Arrange Pages

↓

Complete Book
```

Similarly,

```
Large Data

↓

Split into Packets

↓

Internet

↓

ACK

↓

Retransmission (if needed)

↓

Reassemble Data
```

---

# Connection-Oriented Protocol

TCP first establishes a connection before sending data.

```
Client

↓

Connect

↓

Server

↓

Connection Established

↓

Data Transfer

↓

Connection Closed
```

---

# TCP Communication

```
Client

↓

TCP

↓

Internet

↓

TCP

↓

Server
```

Both sender and receiver use TCP.

---

# TCP Features

- Reliable communication
- Connection-oriented
- Ordered delivery
- Error checking
- Flow control
- Congestion control
- Retransmission
- Full-duplex communication

---

# TCP Header

Every TCP packet contains a header.

```
--------------------------------------------
Source Port
Destination Port
Sequence Number
Acknowledgment Number
Flags
Window Size
Checksum
Urgent Pointer
Data
--------------------------------------------
```

Important fields:

- Source Port
- Destination Port
- Sequence Number
- ACK Number
- Window Size
- Checksum

---

# Three-Way Handshake

Before communication begins, TCP establishes a connection.

```
Client                    Server

SYN  --------------------->

      <-------------------- SYN + ACK

ACK  --------------------->
```

Step 1

Client sends

```
SYN
```

meaning

> "Can we communicate?"

---

Step 2

Server replies

```
SYN + ACK
```

meaning

> "Yes, I'm ready."

---

Step 3

Client sends

```
ACK
```

meaning

> "Connection established."

Now data transfer begins.

---

# Data Transfer

Suppose we send

```
HELLO
```

TCP divides it into packets.

```
Packet 1

↓

Packet 2

↓

Packet 3
```

Each packet contains

- Sequence Number
- Checksum
- Data

The receiver sends an ACK after receiving packets.

---

# Sequence Number

Every packet has a unique sequence number.

```
Packet 1

Seq = 100

Packet 2

Seq = 200

Packet 3

Seq = 300
```

Sequence numbers help:

- Maintain order
- Detect missing packets
- Reassemble data correctly

---

# Acknowledgment (ACK)

After receiving data, the receiver sends an ACK.

```
Sender

Packet 1

↓

Receiver

↓

ACK
```

If ACK is not received within a timeout period, TCP retransmits the packet.

---

# Retransmission

Suppose

```
Packet 2
```

is lost.

```
Packet 1 ✓

Packet 2 ❌

Packet 3 ✓
```

Receiver detects the missing sequence number.

It requests Packet 2 again.

TCP retransmits only the missing packet.

---

# Error Detection

TCP uses a **Checksum**.

```
Sender

↓

Calculate Checksum

↓

Send Packet

↓

Receiver

↓

Verify Checksum

↓

Correct?

↓

Yes → Accept

No → Discard & Retransmit
```

---

# Flow Control

A fast sender should not overwhelm a slow receiver.

TCP uses a **Sliding Window** mechanism.

```
Sender

↓

Window Size

↓

Receiver
```

The receiver advertises how much data it can receive.

This prevents buffer overflow.

---

# Sliding Window

Instead of waiting for an ACK after every packet, TCP sends multiple packets.

```
Packet 1

Packet 2

Packet 3

Packet 4

↓

ACK
```

This improves network efficiency.

---

# Congestion Control

Sometimes the network becomes busy.

Too many packets cause congestion.

TCP reduces its sending rate automatically.

Common algorithms include:

- Slow Start
- Congestion Avoidance
- Fast Retransmit
- Fast Recovery

---

# Four-Way Connection Termination

TCP closes the connection gracefully.

```
Client                    Server

FIN ---------------------->

      <------------------- ACK

      <------------------- FIN

ACK ---------------------->
```

After the final ACK, the connection is closed.

---

# Full-Duplex Communication

TCP allows both sides to send and receive data simultaneously.

```
Client

⇄

Server
```

Examples

- Video calls
- Chat applications
- Banking systems

---

# TCP vs UDP

| TCP | UDP |
|------|-----|
| Connection-oriented | Connectionless |
| Reliable | Unreliable |
| Ordered delivery | No order guarantee |
| Error recovery | No recovery |
| Slower | Faster |
| Uses ACK | No ACK |
| Larger header | Smaller header |

---

# Internal Working

Suppose a browser requests a webpage.

```
Browser

↓

TCP Socket

↓

Three-Way Handshake

↓

Packets Created

↓

Internet

↓

Server

↓

ACK

↓

Browser Receives Data

↓

Four-Way Close
```

---

# Production Usage

TCP is used in:

- HTTP / HTTPS
- Spring Boot REST APIs
- Banking Applications
- Email (SMTP, IMAP, POP3)
- FTP
- SSH
- Database Connections
- Cloud Services
- Docker Communication
- Kubernetes Networking

Example

When your browser accesses

```
https://example.com
```

The communication uses:

```
HTTP

↓

TCP

↓

IP

↓

Internet
```

Similarly, when a Spring Boot application connects to MySQL or PostgreSQL, it uses TCP.

---

# Advantages

- Reliable communication
- Ordered delivery
- Error detection
- Retransmission
- Flow control
- Congestion control

---

# Limitations

- Higher overhead than UDP
- Slower due to acknowledgments
- Larger packet headers
- Connection setup takes time

---

# Best Practices

✅ Use TCP when data accuracy is important.

✅ Use TCP for APIs, databases, and financial applications.

✅ Keep connections alive only when necessary.

✅ Handle timeouts and retries appropriately.

---

# Common Mistakes

❌ Assuming TCP is always faster than UDP.

---

❌ Ignoring connection setup overhead.

---

❌ Using TCP for real-time applications where low latency is more important than guaranteed delivery.

---

❌ Assuming TCP guarantees instant delivery—it guarantees reliable delivery, not minimum latency.

---

# Interview Questions

### 1. What is TCP?

TCP (Transmission Control Protocol) is a reliable, connection-oriented transport-layer protocol.

---

### 2. Why is TCP called connection-oriented?

Because it establishes a connection using a **Three-Way Handshake** before sending data.

---

### 3. What is the Three-Way Handshake?

1. SYN
2. SYN + ACK
3. ACK

It establishes a reliable connection between client and server.

---

### 4. What is the purpose of Sequence Numbers?

They help maintain packet order, detect missing packets, and reassemble data correctly.

---

### 5. What is ACK?

ACK (Acknowledgment) confirms that data has been received successfully.

---

### 6. What is Flow Control?

Flow Control ensures that a fast sender does not overwhelm a slow receiver by regulating the rate of data transmission.

---

### 7. What is Congestion Control?

It prevents excessive traffic from overwhelming the network by adjusting the sending rate.

---

### 8. What is the difference between TCP and UDP?

TCP provides reliable, ordered communication with acknowledgments, while UDP is connectionless and prioritizes speed over reliability.

---

### 9. Why is TCP used in Spring Boot?

Spring Boot applications typically communicate over HTTP/HTTPS, which uses TCP. Database connections, REST APIs, and microservice communication also commonly rely on TCP.

---

### 10. Which applications use TCP?

- HTTP/HTTPS
- FTP
- SSH
- SMTP
- IMAP
- POP3
- Database connections
- Banking systems

---

# Quick Revision

- TCP = Transmission Control Protocol.
- Transport Layer protocol.
- Connection-oriented.
- Reliable communication.
- Three-Way Handshake:
  - SYN
  - SYN + ACK
  - ACK
- Four-Way Connection Termination:
  - FIN
  - ACK
  - FIN
  - ACK
- Uses:
  - Sequence Numbers
  - ACKs
  - Checksums
  - Flow Control
  - Sliding Window
  - Congestion Control
- Used by HTTP, HTTPS, databases, and Spring Boot applications.

---

# Keywords

- TCP
- Transmission Control Protocol
- Transport Layer
- Three-Way Handshake
- Four-Way Termination
- SYN
- ACK
- FIN
- Sequence Number
- Checksum
- Flow Control
- Sliding Window
- Congestion Control
- Retransmission
- Reliable Communication
- Full-Duplex
- HTTP
- HTTPS
- Spring Boot
- Java Networking