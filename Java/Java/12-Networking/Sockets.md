# Sockets (Java Networking)

## What is a Socket?

A **Socket** is one endpoint of a communication channel between two computers over a network.

Think of it as a **door** through which two applications send and receive data.

> **Definition:** A Socket is an endpoint for bidirectional communication between two devices over a network.

---

# Why Do We Need Sockets?

Suppose two computers want to communicate.

Without sockets

```
Computer A

❌

Computer B
```

There is no direct communication.

Using sockets

```
Computer A

↓

Socket

↓

Internet

↓

Socket

↓

Computer B
```

Now both computers can exchange data.

Sockets are the foundation of:

- HTTP
- HTTPS
- FTP
- Email
- Chat Applications
- Spring Boot REST APIs

---

# Real-World Example

Imagine a telephone call.

```
Person A

↓

Phone

↓

Telephone Network

↓

Phone

↓

Person B
```

Similarly,

```
Client

↓

Socket

↓

Internet

↓

Socket

↓

Server
```

---

# Socket Communication

```
Client

↓

Client Socket

↓

Internet

↓

Server Socket

↓

Server
```

---

# Types of Sockets

There are mainly two types.

```
Sockets

↓

TCP Socket

↓

UDP Socket
```

---

# TCP Socket

Uses TCP protocol.

Features

- Reliable
- Ordered
- Connection-oriented

Java Class

```java
Socket
```

Server Class

```java
ServerSocket
```

---

# UDP Socket

Uses UDP protocol.

Features

- Fast
- Connectionless
- No guaranteed delivery

Java Class

```java
DatagramSocket
```

---

# Socket Lifecycle

```
Create Socket

↓

Connect

↓

Send Data

↓

Receive Data

↓

Close Socket
```

---

# Java Socket Classes

| Class | Purpose |
|--------|----------|
| Socket | TCP Client |
| ServerSocket | TCP Server |
| DatagramSocket | UDP Communication |
| DatagramPacket | UDP Data Packet |

---

# ServerSocket

A `ServerSocket` waits for client connections.

Example

```java
ServerSocket server =

new ServerSocket(8080);
```

Now the server listens on port **8080**.

---

# Accepting a Connection

```java
Socket socket =

server.accept();
```

`accept()` blocks until a client connects.

---

# Socket (Client)

Client connects to a server.

```java
Socket socket =

new Socket(

"localhost",

8080

);
```

Now the connection is established.

---

# InputStream

Receive data from another computer.

```java
InputStream input =

socket.getInputStream();
```

---

# OutputStream

Send data.

```java
OutputStream output =

socket.getOutputStream();
```

---

# Sending Data

```java
OutputStream output =

socket.getOutputStream();

output.write(

"Hello".getBytes()

);
```

---

# Receiving Data

```java
InputStream input =

socket.getInputStream();

byte[] buffer =

new byte[1024];

input.read(buffer);

System.out.println(

new String(buffer)

);
```

---

# Client-Server Example

## Server

```java
ServerSocket server =

new ServerSocket(5000);

Socket socket =

server.accept();

System.out.println(

"Client Connected"

);
```

---

## Client

```java
Socket socket =

new Socket(

"localhost",

5000

);

System.out.println(

"Connected"

);
```

Output

Server

```text
Client Connected
```

Client

```text
Connected
```

---

# TCP Socket Communication

```
Client

↓

Create Socket

↓

Three-Way Handshake

↓

Connected

↓

Exchange Data

↓

Close Connection
```

---

# UDP Socket Communication

```
Sender

↓

DatagramPacket

↓

DatagramSocket

↓

Internet

↓

Receiver
```

No connection establishment occurs.

---

# Port Numbers

A socket uses an **IP Address + Port Number**.

Example

```
192.168.1.10:8080
```

```
IP Address

+

Port

=

Socket Address
```

Common ports

| Port | Service |
|------|----------|
| 80 | HTTP |
| 443 | HTTPS |
| 21 | FTP |
| 22 | SSH |
| 25 | SMTP |
| 3306 | MySQL |
| 5432 | PostgreSQL |

---

# Blocking Socket

Normally

```java
server.accept();
```

waits until a client connects.

```
Server

↓

Waiting...

↓

Client Connects

↓

Continue
```

This is called **blocking I/O**.

---

# Internal Working

Suppose a browser requests a webpage.

```
Browser

↓

Socket Created

↓

TCP Handshake

↓

HTTP Request

↓

Internet

↓

Web Server

↓

HTTP Response

↓

Browser Displays Page
```

---

# Socket vs ServerSocket

| Socket | ServerSocket |
|---------|--------------|
| Client side | Server side |
| Sends and receives data | Waits for client connections |
| Uses IP + Port | Listens on a Port |
| Active connection | Passive listening |

---

# Production Usage

Sockets are used in:

- Spring Boot Web Servers
- Chat Applications
- Banking Systems
- Multiplayer Games
- Video Calls
- File Transfer
- Email Servers
- Database Connections

Example

When you access

```
http://localhost:8080
```

Spring Boot (embedded Tomcat) opens a server socket on port **8080** and listens for incoming TCP connections.

---

# Advantages

- Real-time communication
- Bidirectional communication
- Reliable with TCP
- Supports client-server architecture
- Widely supported

---

# Limitations

- Network failures must be handled
- Blocking I/O can reduce scalability
- Requires proper resource management
- TCP sockets have more overhead than UDP

---

# Best Practices

✅ Always close sockets after use.

✅ Use try-with-resources.

✅ Handle exceptions properly.

✅ Set appropriate socket timeouts.

✅ Use buffered streams for efficient data transfer.

---

# Common Mistakes

❌ Forgetting to close sockets.

---

❌ Ignoring exceptions.

---

❌ Using blocking sockets for thousands of concurrent clients without thread management or non-blocking I/O.

---

❌ Hardcoding port numbers without checking availability.

---

# Interview Questions

### 1. What is a Socket?

A Socket is an endpoint for communication between two devices over a network.

---

### 2. What is a ServerSocket?

A `ServerSocket` listens for incoming client connections.

---

### 3. What is the difference between Socket and ServerSocket?

- `Socket` is used by the client to connect and exchange data.
- `ServerSocket` is used by the server to listen for incoming connections.

---

### 4. Which protocol does `Socket` use?

TCP.

For UDP, Java uses `DatagramSocket`.

---

### 5. What does `accept()` do?

It waits (blocks) until a client connects and then returns a connected `Socket`.

---

### 6. How do you send data through a Socket?

Using the `OutputStream` obtained from the socket.

---

### 7. How do you receive data through a Socket?

Using the `InputStream` obtained from the socket.

---

### 8. What is a Socket Address?

A combination of an **IP Address** and a **Port Number**.

Example

```
192.168.1.10:8080
```

---

### 9. How does Spring Boot use sockets?

The embedded web server (such as Tomcat, Jetty, or Undertow) opens a `ServerSocket`, listens on a configured port (for example, 8080), accepts incoming TCP connections, and processes HTTP requests.

---

### 10. What is the difference between TCP Socket and UDP Socket?

TCP Sockets provide reliable, connection-oriented communication. UDP Sockets provide faster, connectionless communication without guaranteed delivery.

---

# Quick Revision

- Socket = Communication endpoint.
- ServerSocket = Listens for client connections.
- Socket lifecycle:
  - Create
  - Connect
  - Send
  - Receive
  - Close
- Java classes:
  - `Socket`
  - `ServerSocket`
  - `DatagramSocket`
  - `DatagramPacket`
- Uses:
  - `InputStream`
  - `OutputStream`
- Socket Address = IP + Port.
- Used by HTTP, Spring Boot, databases, chat applications, and games.

---

# Keywords

- Socket
- ServerSocket
- DatagramSocket
- DatagramPacket
- InputStream
- OutputStream
- TCP Socket
- UDP Socket
- Port
- IP Address
- Socket Address
- Client
- Server
- Java Networking
- Blocking I/O