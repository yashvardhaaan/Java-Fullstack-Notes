# Path & Files (Java NIO)

## What are Path and Files?

`Path` and `Files` are classes introduced in **Java NIO (Java 7)** to provide a **modern and powerful way** of working with files and directories.

- **Path** → Represents the location of a file or directory.
- **Files** → Provides utility methods to create, read, write, copy, move, and delete files.

> **Definition:** `Path` represents a file path, while `Files` performs operations on that path.

---

# Why Do We Need Path and Files?

The older `File` class has some limitations:

- Less powerful
- Limited utility methods
- Less flexible
- Poor error handling

Java introduced **NIO (New I/O)** to solve these problems.

---

# Real-World Example

Imagine Google Maps.

```
Home

↓

Road

↓

Office
```

The **road** is the **Path**.

The actions you perform on that road:

- Travel
- Copy
- Move
- Delete

are performed by the **Files** class.

Similarly,

```
notes.txt

↓

Path

↓

Files.readString()

↓

Read File
```

---

# Import

```java
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.Files;
```

---

# Creating a Path

Using `Path.of()` (Java 11+)

```java
Path path = Path.of("notes.txt");
```

Older way

```java
Path path = Paths.get("notes.txt");
```

Both represent the file path.

---

# Path Example

```java
Path path = Path.of("notes.txt");

System.out.println(path);
```

Output

```text
notes.txt
```

---

# Creating a File

```java
Path path = Path.of("notes.txt");

Files.createFile(path);
```

A physical file is created.

---

# Creating a Directory

```java
Path path = Path.of("Documents");

Files.createDirectory(path);
```

---

# Creating Nested Directories

```java
Path path =
Path.of("Projects/Java/NIO");

Files.createDirectories(path);
```

Creates all missing folders.

---

# Checking if a File Exists

```java
Path path = Path.of("notes.txt");

System.out.println(
Files.exists(path)
);
```

Output

```text
true
```

---

# Deleting a File

```java
Path path = Path.of("notes.txt");

Files.delete(path);
```

---

# Copying a File

```java
Path source =
Path.of("notes.txt");

Path target =
Path.of("backup.txt");

Files.copy(source, target);
```

---

# Moving or Renaming a File

```java
Files.move(

    Path.of("notes.txt"),

    Path.of("newnotes.txt")

);
```

---

# Reading an Entire File

```java
String data =

Files.readString(

    Path.of("notes.txt")

);

System.out.println(data);
```

Suppose

```text
Hello Java
```

Output

```text
Hello Java
```

---

# Writing to a File

```java
Files.writeString(

    Path.of("notes.txt"),

    "Hello Java"

);
```

---

# Reading All Lines

```java
List<String> lines =

Files.readAllLines(

    Path.of("notes.txt")

);

for(String line : lines){

    System.out.println(line);

}
```

---

# Useful Methods

| Method | Purpose |
|---------|----------|
| exists() | Checks file existence |
| createFile() | Creates file |
| createDirectory() | Creates directory |
| createDirectories() | Creates nested folders |
| delete() | Deletes file |
| copy() | Copies file |
| move() | Moves/Renames file |
| readString() | Reads file |
| writeString() | Writes file |
| readAllLines() | Reads all lines |
| size() | File size |
| isDirectory() | Checks directory |
| isRegularFile() | Checks normal file |

---

# Path vs File

| Path | File |
|------|------|
| Modern API | Older API |
| Java NIO | Java IO |
| More flexible | Limited features |
| Better error handling | Older design |
| Preferred in modern Java | Legacy support |

---

# Internal Working

Suppose

```java
Files.readString(
    Path.of("notes.txt")
);
```

Internally

```text
Java Program

↓

Path Object

↓

Files API

↓

Operating System

↓

Read File

↓

Return String
```

---

# Production Usage

`Path` and `Files` are widely used in:

- Spring Boot
- File uploads
- Configuration files
- Log processing
- Report generation
- CSV import/export
- Backup systems
- Cloud storage integrations

Example

```
User Uploads Resume

↓

Path.of()

↓

Files.createDirectories()

↓

Files.copy()

↓

Resume Stored
```

---

# Advantages

- Modern API
- Easy to use
- Better exception handling
- Rich utility methods
- Cross-platform
- Preferred over `File`

---

# Limitations

- Requires understanding of NIO
- Some methods throw checked exceptions
- Large files may require Streams instead of `readString()`

---

# Best Practices

✅ Prefer `Path.of()` over `new File()` in modern Java.

✅ Use `Files` utility methods.

✅ Handle `IOException`.

✅ Use `Files.createDirectories()` for nested folders.

✅ Use Streams or NIO Channels for very large files.

---

# Common Mistakes

❌ Using `Files.readString()` for huge files.

---

❌ Forgetting to handle `IOException`.

---

❌ Using the old `File` API when modern NIO methods are more suitable.

---

❌ Assuming `delete()` works if the file doesn't exist.

---

# Interview Questions

### 1. What is `Path`?

`Path` represents the location of a file or directory.

---

### 2. What is the `Files` class?

`Files` is a utility class that performs operations on files and directories.

---

### 3. What replaced the `File` class?

`Path` and `Files` from Java NIO are the modern alternative.

---

### 4. What is the difference between `Path` and `File`?

`Path` is part of Java NIO and provides a more flexible and feature-rich API than the older `File` class.

---

### 5. Which method creates nested directories?

```java
Files.createDirectories()
```

---

### 6. Which method reads an entire file as a String?

```java
Files.readString()
```

---

### 7. How do you copy a file?

```java
Files.copy(source, target);
```

---

### 8. How do you rename a file?

```java
Files.move(source, target);
```

---

### 9. Why is `Path.of()` preferred?

It is cleaner, modern, platform-independent, and part of the NIO API.

---

### 10. Where are `Path` and `Files` used in Spring Boot?

They are commonly used for file uploads, report generation, configuration management, log processing, backups, and document storage.

---

# Quick Revision

- `Path` represents a file or directory path.
- `Files` performs file operations.
- `Path.of()` is the preferred way to create paths.
- Use `Files.readString()` to read text.
- Use `Files.writeString()` to write text.
- Use `Files.copy()` to copy files.
- Use `Files.move()` to move or rename files.
- Use `Files.createDirectories()` for nested folders.
- `Path` + `Files` are the modern replacement for many `File` operations.

---

# Keywords

- Path
- Files
- Java NIO
- Path.of()
- Paths.get()
- Files.readString()
- Files.writeString()
- Files.copy()
- Files.move()
- Files.delete()
- Files.exists()
- createDirectories()
- File I/O
- Java 7