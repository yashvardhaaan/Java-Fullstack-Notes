# File (Java)

## What is a File?

The `File` class in Java represents a **file or directory path** in the file system.

It allows us to:

- Create files
- Delete files
- Rename files
- Create directories
- Check if a file exists
- Read file information

> **Important:** The `File` class **does not read or write file contents**. It only manages files and directories. Reading and writing are done using Streams, Readers/Writers, or NIO.

---

# Why Do We Need the File Class?

Before reading or writing a file, we often need to:

- Check whether it exists
- Create it if it doesn't exist
- Delete unwanted files
- Rename files
- Create folders
- Get file information

The `File` class provides these operations.

---

# Real-World Example

Imagine your computer's File Explorer.

```
Documents

├── Resume.pdf
├── Notes.txt
├── Photo.jpg
└── Projects
```

The **File** class works like File Explorer.

It can:

- Check whether `Resume.pdf` exists.
- Create `Notes.txt`.
- Delete `Photo.jpg`.
- Rename `Projects`.
- Create new folders.

It **cannot edit** the contents of these files.

---

# Import

```java
import java.io.File;
```

---

# Creating a File Object

```java
File file = new File("test.txt");
```

This only creates a **Java object** representing the file.

It does **not** create the actual file.

---

# Creating a Physical File

```java
import java.io.File;
import java.io.IOException;

public class Main {

    public static void main(String[] args)
            throws IOException {

        File file = new File("test.txt");

        if(file.createNewFile()) {

            System.out.println("File Created");

        } else {

            System.out.println("File Already Exists");

        }

    }

}
```

Output

```text
File Created
```

---

# Checking if a File Exists

```java
File file = new File("test.txt");

System.out.println(file.exists());
```

Output

```text
true
```

---

# Deleting a File

```java
File file = new File("test.txt");

if(file.delete()) {

    System.out.println("Deleted");

}
```

---

# Renaming a File

```java
File oldFile = new File("test.txt");

File newFile = new File("notes.txt");

oldFile.renameTo(newFile);
```

---

# Creating a Directory

## mkdir()

Creates one directory.

```java
File folder = new File("Documents");

folder.mkdir();
```

---

## mkdirs()

Creates multiple directories.

```java
File folder =
new File("Projects/Java/FileIO");

folder.mkdirs();
```

---

# Listing Files

```java
File folder = new File("Documents");

File[] files = folder.listFiles();

for(File file : files){

    System.out.println(file.getName());

}
```

Output

```text
Resume.pdf

Notes.txt

Photo.jpg
```

---

# Useful Methods

| Method | Purpose |
|---------|----------|
| createNewFile() | Creates a file |
| exists() | Checks existence |
| delete() | Deletes file |
| renameTo() | Renames file |
| mkdir() | Creates one folder |
| mkdirs() | Creates nested folders |
| listFiles() | Lists files in a directory |
| getName() | Returns file name |
| getPath() | Returns path |
| getAbsolutePath() | Returns absolute path |
| length() | Returns file size |
| isFile() | Checks if it's a file |
| isDirectory() | Checks if it's a directory |
| canRead() | Checks read permission |
| canWrite() | Checks write permission |

---

# File Information Example

```java
File file = new File("test.txt");

System.out.println(file.getName());

System.out.println(file.getAbsolutePath());

System.out.println(file.length());

System.out.println(file.isFile());

System.out.println(file.canRead());
```

Example Output

```text
test.txt

C:\Users\Yash\test.txt

125

true

true
```

---

# Absolute Path vs Relative Path

## Relative Path

```java
File file = new File("test.txt");
```

Starts from the current working directory.

---

## Absolute Path

```java
File file =
new File("C:\\Users\\Yash\\Documents\\test.txt");
```

Starts from the root of the file system.

---

# Internal Working

Suppose

```java
File file = new File("test.txt");
```

Internally

```text
Java Program

↓

Creates File Object

↓

Stores Path

↓

No Physical File Created
```

When

```java
file.createNewFile();
```

```text
JVM

↓

Operating System

↓

File System

↓

Physical File Created
```

---

# File vs Stream

| File | Stream |
|------|---------|
| Represents a file or directory | Reads or writes data |
| Manages files | Transfers data |
| No file content access | Accesses file contents |
| `java.io.File` | `InputStream`, `OutputStream`, `Reader`, `Writer` |

---

# Production Usage

The `File` class is commonly used for:

- File uploads
- Log file management
- Configuration files
- Creating report folders
- Backup utilities
- Exporting reports
- Checking uploaded files
- Creating temporary files

Example:

A Spring Boot application uploads a profile picture.

```
Receive Image

↓

Check Upload Folder

↓

Create Folder (if needed)

↓

Save File
```

The `File` class helps manage the file and directory before writing data.

---

# Advantages

- Easy to use
- Cross-platform
- Supports file and directory operations
- Provides metadata about files
- Widely used in Java applications

---

# Limitations

- Cannot read file contents
- Cannot write file contents
- Older API compared to NIO (`java.nio.file`)
- `renameTo()` behavior may vary across operating systems

---

# Best Practices

✅ Check `exists()` before performing operations.

✅ Handle `IOException` properly.

✅ Prefer relative paths when possible.

✅ Use `mkdirs()` for nested directories.

✅ Prefer the `Files` API (`java.nio.file`) for modern applications.

---

# Common Mistakes

❌ Assuming `new File()` creates a file.

```java
File file = new File("test.txt");
```

This only creates a Java object.

---

❌ Ignoring the return value of `createNewFile()`.

---

❌ Using invalid file paths.

---

❌ Not handling `IOException`.

---

# Interview Questions

### 1. What is the `File` class?

The `File` class represents a file or directory path and provides methods to manage files and folders.

---

### 2. Does `new File("test.txt")` create a physical file?

No.

It only creates a `File` object representing the path.

---

### 3. Which method creates a physical file?

```java
createNewFile()
```

---

### 4. What is the difference between `mkdir()` and `mkdirs()`?

- `mkdir()` creates a single directory.
- `mkdirs()` creates all missing parent directories.

---

### 5. What does `exists()` do?

Checks whether the file or directory exists.

---

### 6. Can the `File` class read or write file contents?

No.

It only manages files and directories.

---

### 7. What is the difference between a relative path and an absolute path?

- Relative path starts from the current working directory.
- Absolute path starts from the root of the file system.

---

### 8. What is `listFiles()` used for?

It returns all files and directories inside a folder.

---

### 9. Why is the `Files` API (`java.nio.file`) often preferred today?

It provides more powerful, flexible, and efficient file operations than the older `File` class.

---

### 10. Where is the `File` class used in Spring Boot?

It is used for file uploads, creating directories, managing logs, temporary files, and checking file metadata.

---

# Quick Revision

- `File` represents a file or directory path.
- `new File()` does **not** create a physical file.
- `createNewFile()` creates the actual file.
- `mkdir()` creates one folder.
- `mkdirs()` creates nested folders.
- `exists()` checks existence.
- `listFiles()` lists directory contents.
- `File` manages files but does **not** read or write data.
- Modern Java often prefers the `Files` API (`java.nio.file`) for advanced operations.

---

# Keywords

- File
- java.io.File
- createNewFile()
- exists()
- delete()
- renameTo()
- mkdir()
- mkdirs()
- listFiles()
- getAbsolutePath()
- Relative Path
- Absolute Path
- File Metadata
- Java File I/O