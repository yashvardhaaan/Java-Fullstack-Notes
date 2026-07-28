# UDP (User Datagram Protocol)

## What is UDP?

**UDP (User Datagram Protocol)** is a **connectionless** communication protocol that allows data to be sent between devices **without establishing a connection first**.

It works at the **Transport Layer (Layer 4)** of the OSI Model.

Unlike TCP, UDP focuses on **speed** rather than reliability.

> **Definition:** UDP is a transport-layer protocol that provides fast, connectionless communication without guaranteeing delivery, order, or error recovery.

---

# Why Do We Need UDP?

Not every application needs perfect reliability.

Imagine a live football match.

If one video frame is lost, you would rather continue watching than wait for the missing frame.

UDP is ideal for such situations because speed is more important than perfect delivery.

Applications that commonly use UDP include:

- Video Streaming
- Voice Calls
- Online Gaming
- DNS
- Live Broadcasting

---

# Real-World Example

Imagine sending postcards.

```
Write Postcard

↓

Post Office

↓

Receiver
```

If one postcard is lost, you don't ask the sender to resend it.

Similarly,

```
Data

↓

UDP Packet

↓

Internet

↓

Receiver
```

If a packet is lost, UDP simply moves on.

---

# Connectionless Protocol

UDP does **not** establish a connection.

```
Client

↓

Send Packet

↓

Internet

↓

Server
```

No handshake is required.

---

# UDP Communication

```
Client

↓

UDP

↓

Internet

↓

UDP

↓

Server
```

Packets are sent independently.

---

# UDP Features

- Connectionless
- Fast communication
- Low overhead
- No acknowledgments
- No retransmission
- No ordering guarantee
- Supports broadcasting
- Supports multicasting

---

# UDP Header

UDP has a very small header.

```
-----------------------------
Source Port
Destination Port
Length
Checksum
Data
-----------------------------
```

Important fields:

- Source Port
- Destination Port
- Length
- Checksum

Header size: **8 bytes**

---

# No Handshake

Unlike TCP

```
Client

↓

SYN

↓

ACK
```

UDP simply sends data immediately.

```
Client

↓

Packet

↓

Server
```

This makes UDP much faster.

---

# Datagram

UDP sends data in units called **Datagrams**.

```
Datagram

↓

Header

↓

Data
```

Each datagram is independent.

---

# No Acknowledgment

Suppose

```
Packet

↓

Receiver
```

UDP does **not** send

```
ACK
```

The sender never knows whether the packet reached the destination.

---

# No Retransmission

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

UDP does not resend Packet 2.

The application must decide whether missing data matters.

---

# No Ordering

Packets may arrive in any order.

```
Sent

1

2

3

4
```

Received

```
2

1

4

3
```

UDP does not rearrange them.

---

# Error Detection

UDP uses a checksum to detect corrupted packets.

```
Sender

↓

Checksum

↓

Receiver

↓

Verify

↓

Correct?

↓

Yes → Accept

No → Discard
```

Unlike TCP, UDP does **not** request retransmission.

---

# Broadcasting

UDP supports broadcasting.

```
One Sender

↓

Many Devices
```

Example

A router announcing its presence on a local network.

---

# Multicasting

UDP supports multicasting.

```
Sender

↓

Selected Group

↓

Receivers
```

Useful for:

- Live streaming
- Online classes
- Stock market updates

---

# Internal Working

Suppose a DNS request is sent.

```
Application

↓

UDP Socket

↓

Packet Created

↓

Internet

↓

DNS Server

↓

Response
```

No connection setup occurs.

---

# UDP vs TCP

| UDP | TCP |
|------|-----|
| Connectionless | Connection-oriented |
| Faster | Slower |
| No ACK | Uses ACK |
| No retransmission | Retransmits lost packets |
| No ordering | Ordered delivery |
| Small header (8 bytes) | Larger header (20+ bytes) |
| Low overhead | Higher overhead |

---

# Production Usage

UDP is used in:

- DNS (Domain Name System)
- DHCP
- VoIP (Voice over IP)
- Video Streaming
- Live Broadcasting
- Online Gaming
- IoT Devices
- SNMP (Network Management)

Example

When you type

```
www.google.com
```

your computer usually sends a **DNS query** using UDP.

---

# Advantages

- Very fast
- Low latency
- Small header
- Low bandwidth usage
- Simple protocol
- Good for real-time communication

---

# Limitations

- No guaranteed delivery
- No ordering
- No retransmission
- No congestion control
- No flow control

---

# Best Practices

✅ Use UDP when speed is more important than reliability.

✅ Use UDP for streaming and gaming.

✅ Implement reliability in the application layer if required.

✅ Keep datagrams reasonably small to reduce fragmentation.

---

# Common Mistakes

❌ Assuming UDP guarantees packet delivery.

---

❌ Using UDP for banking or financial transactions.

---

❌ Expecting packets to arrive in order.

---

❌ Assuming faster always means better.

---

# Interview Questions

### 1. What is UDP?

UDP (User Datagram Protocol) is a fast, connectionless transport-layer protocol.

---

### 2. Why is UDP called connectionless?

Because it sends packets without establishing a connection first.

---

### 3. Does UDP guarantee delivery?

No.

Packets may be lost.

---

### 4. Does UDP use acknowledgments?

No.

UDP has no ACK mechanism.

---

### 5. What is a Datagram?

A Datagram is an independent UDP packet containing a header and data.

---

### 6. Why is UDP faster than TCP?

Because it does not establish connections, send acknowledgments, retransmit packets, or maintain ordering.

---

### 7. What are common applications of UDP?

- DNS
- DHCP
- VoIP
- Video Streaming
- Online Gaming
- Live Broadcasting

---

### 8. Can UDP packets arrive out of order?

Yes.

UDP does not guarantee packet ordering.

---

### 9. When should UDP be used instead of TCP?

When low latency is more important than guaranteed delivery, such as live streaming, gaming, or voice/video calls.

---

### 10. Does Spring Boot use UDP?

By default, Spring Boot web applications use **HTTP over TCP**. UDP can still be used in custom Java applications or specialized networking services, but it is not the default communication protocol for Spring Boot web applications.

---

# Quick Revision

- UDP = User Datagram Protocol.
- Transport Layer protocol.
- Connectionless.
- Fast communication.
- No handshake.
- No ACK.
- No retransmission.
- No ordering.
- Uses Datagrams.
- Supports broadcasting and multicasting.
- Used by:
  - DNS
  - DHCP
  - VoIP
  - Video Streaming
  - Online Gaming

---

# Keywords

- UDP
- User Datagram Protocol
- Transport Layer
- Datagram
- Connectionless
- Checksum
- Broadcasting
- Multicasting
- DNS
- DHCP
- VoIP
- Streaming
- Gaming
- Low Latency
- Java Networking