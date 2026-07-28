# Streams (Java)

## What are Streams?

A **Stream** is a sequence of data used to **read data from a source** or **write data to a destination**.

The source or destination can be:

- File
- Keyboard
- Network
- Memory
- Socket

> **Definition:** A Stream is a flow of data between a Java program and an external source or destination.

---

# Why Do We Need Streams?

The `File` class can only manage files.

It **cannot read or write** the contents of a file.

Streams are used to:

- Read data
- Write data
- Copy files
- Transfer data
- Communicate over networks

---

# Real-World Example

Imagine a water pipe.

```
Water Tank

↓

Pipe

↓

Bucket
```

The pipe carries water.

Similarly,

```
File

↓

Stream

↓

Java Program
```

A Stream carries data between the source and the program.

---

# Stream Flow

## Reading

```text
File

↓

Input Stream

↓

Java Program
```

---

## Writing

```text
Java Program

↓

Output Stream

↓

File
```

---

# Types of Streams

Java has two main categories.

## 1. Byte Streams

Works with **8-bit bytes**.

Used for:

- Images
- Videos
- PDF files
- Audio
- Binary files

Classes

- InputStream
- OutputStream

---

## 2. Character Streams

Works with **16-bit Unicode characters**.

Used for:

- Text files
- CSV
- JSON
- XML
- Source code

Classes

- Reader
- Writer

---

# Stream Hierarchy

```text
                 Object
                    │
         ┌──────────┴──────────┐
         │                     │
    InputStream          OutputStream
         │                     │
  FileInputStream      FileOutputStream
 BufferedInputStream BufferedOutputStream


                 Object
                    │
          ┌─────────┴─────────┐
          │                   │
        Reader             Writer
          │                   │
     FileReader          FileWriter
 BufferedReader      BufferedWriter
```

---

# InputStream

Used to **read bytes**.

Example

```java
FileInputStream input =
new FileInputStream("image.png");
```

Reads data from a file into the program.

---

# OutputStream

Used to **write bytes**.

Example

```java
FileOutputStream output =
new FileOutputStream("image.png");
```

Writes data from the program to a file.

---

# Reader

Used to read **characters**.

Example

```java
FileReader reader =
new FileReader("notes.txt");
```

---

# Writer

Used to write **characters**.

Example

```java
FileWriter writer =
new FileWriter("notes.txt");
```

---

# Byte Stream Example

```java
import java.io.*;

public class Main {

    public static void main(String[] args)
            throws IOException {

        FileInputStream input =
            new FileInputStream("image.jpg");

        int data = input.read();

        System.out.println(data);

        input.close();

    }

}
```

---

# Character Stream Example

```java
import java.io.*;

public class Main {

    public static void main(String[] args)
            throws IOException {

        FileReader reader =
            new FileReader("notes.txt");

        int data = reader.read();

        System.out.println((char) data);

        reader.close();

    }

}
```

---

# Byte Stream vs Character Stream

| Byte Stream | Character Stream |
|--------------|------------------|
| Reads bytes | Reads characters |
| 8-bit data | 16-bit Unicode |
| Binary files | Text files |
| InputStream / OutputStream | Reader / Writer |
| Images, PDFs, Audio | Text, JSON, XML |

---

# Common Stream Classes

## Byte Streams

- FileInputStream
- FileOutputStream
- BufferedInputStream
- BufferedOutputStream
- ByteArrayInputStream
- ByteArrayOutputStream

---

## Character Streams

- FileReader
- FileWriter
- BufferedReader
- BufferedWriter
- StringReader
- StringWriter

---

# Closing Streams

Always close streams after use.

```java
reader.close();
```

Better approach:

```java
try (FileReader reader =
        new FileReader("notes.txt")) {

    // Read Data

}
```

The stream is closed automatically.

---

# Internal Working

Suppose

```java
FileReader reader =
new FileReader("notes.txt");
```

Internally

```text
Java Program

↓

Creates Reader Object

↓

Operating System

↓

Reads File

↓

Returns Characters
```

For writing

```text
Java Program

↓

Writer

↓

Operating System

↓

Stores Data

↓

File Updated
```

---

# Stream vs File

| File | Stream |
|------|---------|
| Represents a file or folder | Transfers data |
| Stores path information | Reads/Writes data |
| No content access | Accesses file contents |
| java.io.File | InputStream, OutputStream, Reader, Writer |

---

# Production Usage

Streams are used in almost every Java application.

Examples:

- File upload/download
- Reading configuration files
- Saving reports
- Image processing
- REST API file transfers
- Reading CSV files
- PDF generation
- Logging

Example

```
User Uploads Image

↓

Input Stream

↓

Spring Boot

↓

Output Stream

↓

Server Storage
```

---

# Advantages

- Easy data transfer
- Supports files and networks
- Platform independent
- Works with binary and text data
- Foundation of Java File I/O

---

# Disadvantages

- Streams must be closed properly
- Reading byte by byte can be slow
- Older I/O API is less efficient than NIO for some use cases

---

# Best Practices

✅ Use Byte Streams for binary data.

✅ Use Character Streams for text.

✅ Always close streams.

✅ Prefer **try-with-resources**.

✅ Use Buffered Streams for better performance.

---

# Common Mistakes

❌ Using `FileReader` for images.

---

❌ Using `FileInputStream` for text when character encoding matters.

---

❌ Forgetting to close streams.

---

❌ Reading one byte/character at a time for large files without buffering.

---

# Interview Questions

### 1. What is a Stream?

A Stream is a flow of data between a Java program and a source or destination.

---

### 2. Why do we need Streams?

To read and write data from files, networks, memory, and other sources.

---

### 3. What are the two main types of Streams?

- Byte Streams
- Character Streams

---

### 4. What is the difference between Byte Streams and Character Streams?

Byte Streams handle binary data, while Character Streams handle text data.

---

### 5. Which classes are the parent classes of Byte Streams?

`InputStream` and `OutputStream`.

---

### 6. Which classes are the parent classes of Character Streams?

`Reader` and `Writer`.

---

### 7. When should you use Byte Streams?

For images, PDFs, videos, audio, and other binary files.

---

### 8. When should you use Character Streams?

For text files, JSON, XML, CSV, and source code.

---

### 9. Why should streams be closed?

To release system resources and prevent resource leaks.

---

### 10. Why is `try-with-resources` preferred?

Because it automatically closes streams, even if an exception occurs.

---

# Quick Revision

- Stream = Flow of data.
- Streams read or write data.
- Two types:
  - Byte Streams
  - Character Streams
- `InputStream` / `OutputStream` → Binary data.
- `Reader` / `Writer` → Text data.
- Always close streams.
- Prefer `try-with-resources`.
- Use Buffered Streams for better performance.

---

# Keywords

- Stream
- InputStream
- OutputStream
- Reader
- Writer
- FileInputStream
- FileOutputStream
- FileReader
- FileWriter
- Byte Stream
- Character Stream
- try-with-resources
- Java File I/O