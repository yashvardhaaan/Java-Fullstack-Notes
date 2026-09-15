````md id="websocket"
# WebSocket

## 1. What is WebSocket?

**WebSocket** is a protocol that provides **persistent, full-duplex communication** between a client and server over a single connection.

> Unlike normal HTTP request-response, both client and server can send data whenever needed.

```text
HTTP:
Client ── Request ──→ Server
Client ←─ Response ── Server

WebSocket:
Client ←──────→ Server
     continuous communication
````

---

## 2. Why WebSocket?

Normal HTTP is mainly:

```text
Request → Response
```

For real-time applications, continuously polling the server is inefficient.

WebSocket enables:

```text
Client ←→ Server
```

Useful for:

* Chat applications
* Live notifications
* Online gaming
* Stock/live-price updates
* Real-time dashboards
* Collaborative applications

---

## 3. Connection Establishment ⭐⭐⭐⭐⭐

WebSocket initially uses an **HTTP Upgrade request**.

Simplified:

```text
Client → HTTP Upgrade Request → Server
Client ← 101 Switching Protocols ← Server
```

After the handshake:

```text
HTTP connection
      ↓
WebSocket connection
      ↓
Full-duplex communication
```

The connection remains open.

---

## 4. Full Duplex ⭐⭐⭐⭐⭐

Both sides can transmit independently.

```text
Client ─────────→ Server
Client ←───────── Server
Client ─────────→ Server
Client ←───────── Server
```

The server doesn't have to wait for a new client request before sending data.

🔥 **WebSocket = full-duplex.**

---

## 5. WebSocket vs HTTP ⭐⭐⭐⭐⭐

| Feature                        | HTTP                   | WebSocket              |
| ------------------------------ | ---------------------- | ---------------------- |
| Communication                  | Request-response       | Full-duplex            |
| Persistent connection          | Possible               | Yes                    |
| Server can initiate data       | Normally needs request | Yes                    |
| Real-time communication        | Less suitable          | Excellent              |
| Typical use                    | Web pages/APIs         | Chat/live updates      |
| Overhead for repeated messages | Higher                 | Lower after connection |

---

## 6. WebSocket vs Polling

### Polling

Client repeatedly asks:

```text
Client → "Any update?"
Server → "No"
Client → "Any update?"
Server → "Yes"
```

Creates unnecessary requests.

### WebSocket

```text
Client ←────────→ Server
          ↓
     Server pushes
       updates
```

More efficient for continuous real-time communication.

---

## 7. WebSocket and TCP ⭐⭐⭐⭐⭐

WebSocket commonly runs over **TCP**.

```text
Application
   ↓
WebSocket
   ↓
TCP
   ↓
IP
   ↓
Ethernet/Wi-Fi
```

Secure WebSocket:

```text
WebSocket Secure (WSS)
        ↓
       TLS
        ↓
       TCP
        ↓
       IP
```

Common ports:

```text
ws  → 80
wss → 443
```

---

## 8. WebSocket Messages

WebSocket supports:

* Text messages
* Binary messages
* Control frames such as Ping/Pong
* Close frames

The protocol uses **frames** internally to carry messages/control information.

🔥 Don't confuse:

**WebSocket frame ≠ Ethernet frame ≠ TCP segment.**

They belong to different layers/protocols.

---

## 9. WebSocket vs SSE ⭐⭐⭐⭐

**SSE = Server-Sent Events**

| WebSocket                | SSE                                         |
| ------------------------ | ------------------------------------------- |
| Full-duplex              | Server → client                             |
| Client → server possible | Client normally uses separate HTTP requests |
| Text + binary            | Mainly text                                 |
| Chat/games               | Notifications/live feeds                    |
| WebSocket protocol       | HTTP                                        |

Shortcut:

```text
WebSocket → Client ↔ Server
SSE       → Client ← Server
```

---

## 🔥 Placement / GATE Traps

1. **WebSocket provides full-duplex communication.**
2. It starts with an **HTTP Upgrade handshake**.
3. `101 Switching Protocols` is the classic handshake response.
4. After upgrade, communication is WebSocket, not ordinary HTTP request-response.
5. WebSocket commonly runs over **TCP**.
6. `ws` commonly uses port **80**.
7. `wss` commonly uses port **443 + TLS**.
8. WebSocket is suitable for **real-time applications**.
9. Polling repeatedly sends requests; WebSocket keeps a persistent connection.
10. **WebSocket ≠ HTTP**, although it begins with an HTTP-based handshake.
11. WebSocket is **full-duplex**, while SSE is primarily **server → client**.
12. WebSocket does not inherently mean encrypted; use **WSS** for TLS protection.

---

# ⚡ 30-Second Revision

```text
Client
   │
   │ HTTP Upgrade
   ↓
Server
   │
   │ 101 Switching Protocols
   ↓
WebSocket Connection
   ↕
Full-Duplex Communication
```

### Remember

```text
WebSocket
= Persistent
+ Full Duplex
+ Real Time
+ TCP
```

```text
ws  → 80
wss → 443 + TLS
```

### 🎯 Priority

**Placement:** ⭐⭐⭐⭐⭐
**GATE:** ⭐⭐⭐

```

**Next: `DNS Resolution.md`**.
```
