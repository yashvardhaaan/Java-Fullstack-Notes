# NIO (New I/O) - Java

## What is NIO?

**NIO (New Input/Output)** is a modern File I/O API introduced in **Java 1.4** to provide **faster, scalable, and more efficient** file and network operations than the traditional Java I/O API.

NIO is based on three main components:

- **Channels**
- **Buffers**
- **Selectors** (for non-blocking network I/O)

> **Definition:** NIO is a high-performance I/O API that uses Channels and Buffers instead of Streams.

---

# Why Do We Need NIO?

Traditional Java I/O works well for small applications.

However, for:

- Large files
- High-speed file transfer
- Thousands of network connections
- Large-scale servers

Traditional I/O becomes less efficient.

NIO was introduced to solve these problems.

---

# Real-World Example

Imagine a courier company.

### Traditional I/O

```
Warehouse

↓

One Package

↓

Truck

↓

Repeat
```

One package is transported at a time.

---

### NIO

```
Warehouse

↓

Large Container

↓

Truck

↓

Many Packages Together
```

Fewer trips and better performance.

---

# Traditional I/O vs NIO

| Traditional I/O | NIO |
|-----------------|-----|
| Stream-based | Channel-based |
| Sequential | Buffer-based |
| Blocking | Supports Non-Blocking |
| Simpler | More scalable |
| Good for small applications | Good for high-performance systems |

---

# Core Components of NIO

```text
            NIO

             │

 ┌───────────┼───────────┐

 │           │           │

Channel    Buffer     Selector
```

---

# 1. Channel

A **Channel** is similar to a stream but is **two-way**.

It can:

- Read data
- Write data

Examples:

- FileChannel
- SocketChannel
- ServerSocketChannel

---

## Channel Flow

```text
File

↓

Channel

↓

Buffer

↓

Java Program
```

Unlike Streams, Channels work with Buffers.

---

# 2. Buffer

A **Buffer** is a temporary memory area that stores data while it is being transferred.

Common Buffers:

- ByteBuffer
- CharBuffer
- IntBuffer
- LongBuffer

---

## Buffer Flow

```text
Disk

↓

Buffer

↓

Program
```

The program reads data from the buffer instead of directly accessing the disk every time.

---

# Buffer Lifecycle

```text
Allocate Buffer

↓

Write Data

↓

flip()

↓

Read Data

↓

clear()

↓

Write Again
```

---

# ByteBuffer Example

```java
import java.nio.ByteBuffer;

public class Main {

    public static void main(String[] args) {

        ByteBuffer buffer =
                ByteBuffer.allocate(10);

        buffer.put((byte)65);

        buffer.flip();

        System.out.println((char)buffer.get());

    }

}
```

Output

```text
A
```

---

# Important Buffer Methods

| Method | Purpose |
|----------|----------|
| allocate() | Creates buffer |
| put() | Writes data |
| get() | Reads data |
| flip() | Switches write mode to read mode |
| clear() | Clears buffer |
| remaining() | Remaining unread data |

---

# 3. FileChannel

`FileChannel` reads and writes files efficiently.

Example

```java
import java.io.*;
import java.nio.channels.FileChannel;

FileInputStream input =
new FileInputStream("notes.txt");

FileChannel channel =
input.getChannel();
```

---

# Copying a File using FileChannel

```java
FileChannel source =
new FileInputStream("a.txt")
.getChannel();

FileChannel target =
new FileOutputStream("b.txt")
.getChannel();

target.transferFrom(
    source,
    0,
    source.size()
);

source.close();
target.close();
```

`transferFrom()` is usually faster than manually copying byte by byte.

---

# What is Non-Blocking I/O?

In blocking I/O:

```text
Read Request

↓

Wait

↓

Receive Data
```

The thread waits until data is available.

---

In non-blocking I/O:

```text
Read Request

↓

No Data?

↓

Continue Other Work

↓

Read Later
```

The thread can perform other tasks instead of waiting.

---

# Selector

A **Selector** allows one thread to monitor **multiple Channels**.

Used mainly in:

- High-performance servers
- Chat applications
- Web servers

---

# Internal Working

Traditional I/O

```text
Program

↓

InputStream

↓

Operating System

↓

Disk
```

---

NIO

```text
Program

↓

Buffer

↓

Channel

↓

Operating System

↓

Disk
```

---

# NIO vs Streams

| Streams | NIO |
|----------|-----|
| InputStream / OutputStream | Channel |
| Reader / Writer | Buffer |
| Blocking | Blocking & Non-Blocking |
| Simpler | More powerful |
| Small applications | Large-scale applications |

---

# Production Usage

NIO is commonly used in:

- Spring Boot file processing
- Large file uploads/downloads
- Web servers
- Chat applications
- Banking systems
- Cloud storage
- High-performance APIs

Examples of frameworks using NIO internally:

- Netty
- Apache Kafka
- Elasticsearch

---

# Advantages

- High performance
- Better scalability
- Supports non-blocking I/O
- Efficient large file transfer
- Better memory usage with buffers

---

# Limitations

- More complex than traditional I/O
- Harder to learn
- Non-blocking programming requires careful design

---

# Best Practices

✅ Use traditional Streams for simple applications.

✅ Use NIO for large files or high-performance systems.

✅ Always close Channels.

✅ Use `Path` and `Files` for common file operations.

✅ Use `FileChannel` for efficient file copying.

---

# Common Mistakes

❌ Forgetting to call `flip()` before reading from a Buffer.

---

❌ Forgetting to close Channels.

---

❌ Using NIO unnecessarily for very simple file operations.

---

❌ Confusing Channels with Streams.

---

# Interview Questions

### 1. What is NIO?

NIO (New Input/Output) is Java's modern API for efficient file and network operations.

---

### 2. What are the three core components of NIO?

- Channel
- Buffer
- Selector

---

### 3. What is the difference between a Stream and a Channel?

A Stream is generally one-way (input or output), while a Channel supports both reading and writing.

---

### 4. Why is NIO faster than traditional I/O?

Because it uses Buffers and supports efficient data transfer and non-blocking operations.

---

### 5. What is a Buffer?

A temporary memory area used to store data during I/O operations.

---

### 6. What does `flip()` do?

It switches a Buffer from writing mode to reading mode.

---

### 7. What is `FileChannel`?

A Channel implementation used for efficient file reading and writing.

---

### 8. What is Non-Blocking I/O?

An I/O model where a thread does not wait for data and can perform other tasks while the operation completes.

---

### 9. Where are Selectors used?

In high-performance network applications where one thread manages many Channels.

---

### 10. Is NIO always better than traditional I/O?

No. Traditional I/O is simpler and often sufficient for small applications. NIO is preferred when performance and scalability are important.

---

# Quick Revision

- NIO = New Input/Output.
- Core components:
  - Channel
  - Buffer
  - Selector
- Channel transfers data.
- Buffer temporarily stores data.
- `flip()` switches Buffer to read mode.
- `FileChannel` is used for efficient file operations.
- NIO supports blocking and non-blocking I/O.
- Used in high-performance servers and large-scale applications.

---

# Keywords

- NIO
- Channel
- FileChannel
- Buffer
- ByteBuffer
- Selector
- Non-Blocking I/O
- Blocking I/O
- flip()
- clear()
- transferFrom()
- Java NIO
- High Performance I/O