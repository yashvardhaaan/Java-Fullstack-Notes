# Buffered Streams (Java)

## What are Buffered Streams?

Buffered Streams are stream classes that use an **internal memory buffer** to improve the performance of reading and writing data.

Instead of accessing the file for every byte or character, they read or write **a large block of data at once**.

> **Definition:** Buffered Streams wrap existing streams and use a buffer to reduce the number of I/O operations.

---

# Why Do We Need Buffered Streams?

Normal streams access the file system frequently.

Example:

Without buffering

```text
Read 1 Byte

↓

Go to Disk

↓

Read 1 Byte

↓

Go to Disk

↓

Read 1 Byte

↓

Go to Disk
```

This is slow because disk access is expensive.

Buffered Streams reduce these disk accesses.

---

# Real-World Example

Imagine filling a bucket.

Without Buffer

```
River

↓

1 Cup

↓

Walk Home

↓

Repeat 100 Times
```

With Buffer

```
River

↓

Large Bucket

↓

Walk Home Once
```

Much faster because fewer trips are required.

---

# How Buffered Streams Work

Without Buffer

```text
File

↓

Read One Character

↓

Java Program

↓

Read Again

↓

File
```

---

With Buffer

```text
File

↓

Buffer (Memory)

↓

Java Program

↓

Buffer Empty?

↓

Yes

↓

Load Again
```

---

# Types of Buffered Streams

## Byte Buffered Streams

- BufferedInputStream
- BufferedOutputStream

Used for binary files like:

- Images
- PDFs
- Videos
- Audio

---

## Character Buffered Streams

- BufferedReader
- BufferedWriter

Used for:

- Text files
- CSV
- JSON
- XML
- Log files

---

# Buffered Stream Hierarchy

```text
               InputStream
                     │
             FileInputStream
                     │
          BufferedInputStream


              OutputStream
                     │
            FileOutputStream
                     │
         BufferedOutputStream


                  Reader
                     │
               FileReader
                     │
             BufferedReader


                  Writer
                     │
               FileWriter
                     │
             BufferedWriter
```

---

# BufferedInputStream

Reads binary data using a buffer.

Example

```java
import java.io.*;

public class Main {

    public static void main(String[] args)
            throws IOException {

        BufferedInputStream input =
            new BufferedInputStream(
                new FileInputStream("image.jpg")
            );

        int data = input.read();

        System.out.println(data);

        input.close();

    }

}
```

---

# BufferedOutputStream

Writes binary data efficiently.

```java
BufferedOutputStream output =
new BufferedOutputStream(
    new FileOutputStream("image.jpg")
);

output.write(100);

output.close();
```

---

# BufferedReader

Reads text efficiently.

```java
BufferedReader reader =
new BufferedReader(
    new FileReader("notes.txt")
);

String line = reader.readLine();

System.out.println(line);

reader.close();
```

Suppose the file contains

```text
Hello Java
```

Output

```text
Hello Java
```

---

# readLine()

`BufferedReader` provides:

```java
readLine()
```

It reads an entire line at once.

Example

```java
String line;

while((line = reader.readLine()) != null){

    System.out.println(line);

}
```

---

# BufferedWriter

Writes text efficiently.

```java
BufferedWriter writer =
new BufferedWriter(
    new FileWriter("notes.txt")
);

writer.write("Hello Java");

writer.newLine();

writer.write("Buffered Writer");

writer.close();
```

Output

```text
Hello Java
Buffered Writer
```

---

# newLine()

Instead of writing

```java
writer.write("\n");
```

use

```java
writer.newLine();
```

It writes the correct line separator for the operating system.

---

# BufferedReader vs FileReader

| FileReader | BufferedReader |
|-------------|----------------|
| Reads character by character | Reads using a buffer |
| Slower | Faster |
| No `readLine()` | Supports `readLine()` |
| Direct disk access | Fewer disk accesses |

---

# BufferedWriter vs FileWriter

| FileWriter | BufferedWriter |
|-------------|----------------|
| Direct writing | Buffered writing |
| Slower | Faster |
| No internal buffer | Internal memory buffer |

---

# flush()

Buffered streams may keep data in memory before writing it to disk.

```java
writer.write("Hello");

writer.flush();
```

`flush()` forces the buffered data to be written immediately.

---

# Internal Working

Without Buffer

```text
Program

↓

Read Character

↓

Operating System

↓

Disk

↓

Repeat
```

---

With Buffer

```text
Program

↓

Memory Buffer

↓

Operating System

↓

Disk

↓

Read Large Block Once

↓

Serve Multiple Reads
```

---

# try-with-resources

Preferred way

```java
try(
    BufferedReader reader =
        new BufferedReader(
            new FileReader("notes.txt")
        )
){

    System.out.println(reader.readLine());

}
catch(IOException e){

    e.printStackTrace();

}
```

Resources are closed automatically.

---

# Production Usage

Buffered Streams are used in:

- Reading log files
- Importing CSV files
- Processing large text files
- File uploads
- Report generation
- Configuration files
- Spring Boot applications

Example

```
Application Starts

↓

Read application.properties

↓

BufferedReader

↓

Load Configuration

↓

Start Server
```

---

# Advantages

- Faster file operations
- Fewer disk accesses
- Reduced I/O overhead
- Efficient for large files
- Easy to use

---

# Limitations

- Uses extra memory for the buffer
- Not useful for very small files
- Must still be closed properly

---

# Best Practices

✅ Wrap FileReader with BufferedReader.

✅ Wrap FileWriter with BufferedWriter.

✅ Use `readLine()` for text files.

✅ Use `flush()` when data must be written immediately.

✅ Prefer `try-with-resources`.

---

# Common Mistakes

❌ Forgetting to close the stream.

---

❌ Forgetting to call `flush()` before program termination when needed.

---

❌ Using BufferedReader for binary files.

---

❌ Reading huge files character by character instead of line by line.

---

# Interview Questions

### 1. What is a Buffered Stream?

A stream that uses an internal memory buffer to improve I/O performance.

---

### 2. Why are Buffered Streams faster?

Because they reduce the number of expensive disk read and write operations.

---

### 3. What is the difference between FileReader and BufferedReader?

`BufferedReader` uses a buffer and provides the `readLine()` method, making it faster and more convenient.

---

### 4. What is the difference between FileWriter and BufferedWriter?

`BufferedWriter` stores data in memory before writing it to the file, improving performance.

---

### 5. What does `readLine()` do?

It reads one complete line of text and returns `null` when the end of the file is reached.

---

### 6. What does `newLine()` do?

It writes the platform-specific line separator.

---

### 7. Why is `flush()` important?

It forces buffered data to be written immediately without closing the stream.

---

### 8. Should Buffered Streams replace normal streams?

They are usually preferred for larger files or frequent I/O because of better performance.

---

### 9. Can BufferedReader read binary files?

No.

It is designed only for character (text) data.

---

### 10. Where are Buffered Streams used in Spring Boot?

They are used for reading configuration files, processing logs, handling CSV imports, generating reports, and other text-based file operations.

---

# Quick Revision

- Buffered Streams improve I/O performance.
- Use an internal memory buffer.
- Byte Streams:
  - BufferedInputStream
  - BufferedOutputStream
- Character Streams:
  - BufferedReader
  - BufferedWriter
- `readLine()` reads one line.
- `newLine()` writes a platform-independent line break.
- `flush()` forces buffered data to be written.
- Prefer `try-with-resources`.
- Buffered Streams are faster than normal streams for most file operations.

---

# Keywords

- BufferedInputStream
- BufferedOutputStream
- BufferedReader
- BufferedWriter
- Buffer
- readLine()
- newLine()
- flush()
- FileReader
- FileWriter
- Performance
- Character Stream
- Byte Stream
- Java File I/O