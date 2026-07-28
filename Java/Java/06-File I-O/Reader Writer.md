# Reader & Writer (Java)

## What are Reader and Writer?

`Reader` and `Writer` are abstract classes in Java used for **Character Streams**.

They are designed to read and write **text (characters)** instead of raw bytes.

> **Definition:** Reader and Writer are character-based stream classes used to read and write text data.

---

# Why Do We Need Reader & Writer?

Byte Streams (`InputStream` and `OutputStream`) work with bytes.

For text files, Java needs to understand **characters** and **Unicode encoding**.

Reader and Writer make text processing easier.

Used for:

- Text files
- CSV files
- JSON
- XML
- Log files
- Source code

---

# Real-World Example

Imagine reading and writing a book.

```
Book

↓

Reader

↓

You
```

Reading.

```
You

↓

Writer

↓

Notebook
```

Writing.

Similarly,

```
Text File

↓

Reader

↓

Java Program
```

and

```
Java Program

↓

Writer

↓

Text File
```

---

# Character Stream Hierarchy

```text
                Object
                   │
              Reader
                 │
        ┌────────┴────────┐
        │                 │
   FileReader      BufferedReader

                Object
                   │
               Writer
                  │
        ┌─────────┴─────────┐
        │                   │
    FileWriter      BufferedWriter
```

---

# Reader

`Reader` is an abstract class used to **read characters**.

Common subclasses:

- FileReader
- BufferedReader
- StringReader

---

# Writer

`Writer` is an abstract class used to **write characters**.

Common subclasses:

- FileWriter
- BufferedWriter
- StringWriter

---

# FileReader

Reads characters from a text file.

Example

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

Suppose `notes.txt` contains:

```text
Hello
```

Output

```text
H
```

---

# Reading an Entire File

```java
FileReader reader =
new FileReader("notes.txt");

int data;

while((data = reader.read()) != -1){

    System.out.print((char)data);

}

reader.close();
```

Output

```text
Hello World
```

---

# FileWriter

Writes characters to a text file.

```java
import java.io.*;

public class Main {

    public static void main(String[] args)
            throws IOException {

        FileWriter writer =
            new FileWriter("notes.txt");

        writer.write("Hello Java");

        writer.close();

    }

}
```

The file now contains:

```text
Hello Java
```

---

# Appending Data

By default, `FileWriter` overwrites the file.

To append data:

```java
FileWriter writer =
new FileWriter("notes.txt", true);

writer.write("\nWelcome");

writer.close();
```

Output

```text
Hello Java

Welcome
```

---

# Common Reader Methods

| Method | Purpose |
|----------|----------|
| read() | Reads one character |
| read(char[]) | Reads multiple characters |
| skip() | Skips characters |
| close() | Closes stream |
| ready() | Checks if data is available |

---

# Common Writer Methods

| Method | Purpose |
|----------|----------|
| write() | Writes characters |
| append() | Appends text |
| flush() | Forces buffered data to be written |
| close() | Closes stream |

---

# flush()

Some writers temporarily store data in memory.

```java
writer.write("Hello");

writer.flush();
```

`flush()` immediately writes the buffered data to the file without closing the stream.

---

# Reader vs Writer

| Reader | Writer |
|----------|---------|
| Reads text | Writes text |
| Input | Output |
| Character Stream | Character Stream |
| FileReader | FileWriter |

---

# Reader vs InputStream

| Reader | InputStream |
|---------|-------------|
| Characters | Bytes |
| Text files | Binary files |
| Unicode aware | Raw bytes |
| FileReader | FileInputStream |

---

# Internal Working

Reading

```text
Text File

↓

Operating System

↓

Reader

↓

Characters

↓

Java Program
```

Writing

```text
Java Program

↓

Writer

↓

Operating System

↓

Text File
```

---

# try-with-resources

Preferred way:

```java
try(FileReader reader =
        new FileReader("notes.txt")){

    int ch;

    while((ch = reader.read()) != -1){

        System.out.print((char)ch);

    }

}
catch(IOException e){

    e.printStackTrace();

}
```

The stream closes automatically.

---

# Production Usage

Reader and Writer are used in:

- Reading configuration files
- Processing CSV files
- Reading JSON/XML
- Log file generation
- Report generation
- Spring Boot configuration
- Import/Export utilities

Example

```
Application Starts

↓

Read application.properties

↓

Load Configuration

↓

Start Server
```

---

# Advantages

- Easy text processing
- Unicode support
- Platform independent
- Simple API
- Better than Byte Streams for text files

---

# Limitations

- Not suitable for binary files
- Reading character by character can be slow
- Buffered classes provide better performance

---

# Best Practices

✅ Use Reader/Writer only for text files.

✅ Use Byte Streams for images, PDFs, videos, and audio.

✅ Always close streams.

✅ Prefer `try-with-resources`.

✅ Use BufferedReader and BufferedWriter for large files.

---

# Common Mistakes

❌ Using FileReader for images.

---

❌ Forgetting to close the stream.

---

❌ Not using append mode when required.

---

❌ Reading large files one character at a time without buffering.

---

# Interview Questions

### 1. What is Reader?

An abstract class used to read characters from a text source.

---

### 2. What is Writer?

An abstract class used to write characters to a text destination.

---

### 3. What is FileReader?

A class used to read text from a file.

---

### 4. What is FileWriter?

A class used to write text to a file.

---

### 5. What is the difference between FileWriter and FileOutputStream?

`FileWriter` writes characters (text).

`FileOutputStream` writes bytes (binary data).

---

### 6. What does `flush()` do?

It forces buffered data to be written immediately without closing the stream.

---

### 7. Does FileWriter overwrite a file?

Yes, by default.

Use:

```java
new FileWriter("file.txt", true);
```

to append.

---

### 8. Why are Reader and Writer preferred for text files?

Because they work with characters and support Unicode encoding.

---

### 9. Why should you use BufferedReader with FileReader?

Because it reduces disk access and improves performance.

---

### 10. Where are Reader and Writer used in Spring Boot?

For reading configuration files, processing text-based files (CSV, JSON, XML), generating reports, and writing logs.

---

# Quick Revision

- Reader → Reads text.
- Writer → Writes text.
- FileReader → Reads from a file.
- FileWriter → Writes to a file.
- Supports Unicode characters.
- Use append mode to add data.
- Use `flush()` to write buffered data immediately.
- Prefer `try-with-resources`.
- Use BufferedReader/BufferedWriter for better performance.

---

# Keywords

- Reader
- Writer
- FileReader
- FileWriter
- Character Stream
- read()
- write()
- append()
- flush()
- close()
- Unicode
- try-with-resources
- Java File I/O