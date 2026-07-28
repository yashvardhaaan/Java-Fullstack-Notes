# Serialization (Java)

## What is Serialization?

**Serialization** is the process of converting a Java object into a **sequence of bytes** so that it can be:

- Saved to a file
- Sent over a network
- Stored in a database
- Cached in memory

> **Definition:** Serialization converts an object's state into a byte stream.

---

# Why Do We Need Serialization?

Objects exist only in **JVM memory**.

When the program stops, those objects disappear.

Serialization allows us to **save** the object's state and restore it later.

---

# Real-World Example

Imagine writing your work in a notebook.

```
Memory

↓

Write in Notebook

↓

Close Notebook

↓

Open Later

↓

Continue Work
```

Similarly,

```
Java Object

↓

Serialize

↓

File

↓

Deserialize

↓

Java Object
```

---

# What is Deserialization?

**Deserialization** is the reverse process.

It converts a **byte stream back into a Java object**.

---

# Serialization Flow

```text
Java Object

↓

Serialization

↓

Byte Stream

↓

File / Network / Database
```

---

# Deserialization Flow

```text
File / Network

↓

Byte Stream

↓

Deserialization

↓

Java Object
```

---

# Serializable Interface

To serialize an object, its class must implement the `Serializable` interface.

```java
import java.io.Serializable;

public class Student
        implements Serializable {

    int id;
    String name;

}
```

`Serializable` is a **marker interface**.

It contains **no methods**.

---

# Example Class

```java
import java.io.Serializable;

public class Student
        implements Serializable {

    int id;
    String name;

    Student(int id, String name){

        this.id = id;
        this.name = name;

    }

}
```

---

# Serializing an Object

```java
import java.io.*;

public class Main {

    public static void main(String[] args)
            throws Exception {

        Student student =
            new Student(1, "Yash");

        ObjectOutputStream out =
            new ObjectOutputStream(

                new FileOutputStream("student.ser")

            );

        out.writeObject(student);

        out.close();

    }

}
```

A file named:

```text
student.ser
```

is created.

---

# Deserializing an Object

```java
import java.io.*;

public class Main {

    public static void main(String[] args)
            throws Exception {

        ObjectInputStream in =
            new ObjectInputStream(

                new FileInputStream("student.ser")

            );

        Student student =
            (Student) in.readObject();

        System.out.println(student.name);

        in.close();

    }

}
```

Output

```text
Yash
```

---

# Important Classes

| Class | Purpose |
|---------|----------|
| Serializable | Marks class as serializable |
| ObjectOutputStream | Writes object |
| ObjectInputStream | Reads object |
| FileOutputStream | Writes bytes to file |
| FileInputStream | Reads bytes from file |

---

# Marker Interface

`Serializable` is called a **Marker Interface** because it has:

```java
0 Methods
```

It simply tells the JVM:

> "This object can be serialized."

Other examples:

- Cloneable
- RandomAccess

---

# serialVersionUID

Every serializable class has a version number.

```java
private static final long serialVersionUID = 1L;
```

It helps verify that the class used during deserialization is compatible with the serialized object.

Without it, modifying the class may cause:

```text
InvalidClassException
```

---

# transient Keyword

Sometimes we don't want certain fields to be serialized.

Use:

```java
transient
```

Example

```java
class User
implements Serializable{

    String username;

    transient String password;

}
```

When serialized,

```text
username ✔

password ✘
```

The password is not stored.

---

# static Fields

Static variables belong to the class, **not** to the object.

Therefore, they are **not serialized**.

Example

```java
class Student
implements Serializable{

    static String college =
    "ABC College";

}
```

---

# Internal Working

Serialization

```text
Java Object

↓

ObjectOutputStream

↓

Byte Stream

↓

File
```

---

Deserialization

```text
File

↓

ObjectInputStream

↓

Byte Stream

↓

Java Object
```

---

# Serialization vs Deserialization

| Serialization | Deserialization |
|----------------|-----------------|
| Object → Bytes | Bytes → Object |
| ObjectOutputStream | ObjectInputStream |
| writeObject() | readObject() |
| Saves object | Restores object |

---

# Production Usage

Serialization is widely used in:

- Spring Boot
- HTTP Sessions
- Distributed Systems
- Caching (Redis, Hazelcast)
- RMI (Remote Method Invocation)
- Messaging Systems
- Object Persistence

Example

```
User Logs In

↓

Session Object

↓

Serialize

↓

Redis Cache

↓

Deserialize

↓

User Continues Session
```

---

# Advantages

- Saves object state
- Easy network transfer
- Supports distributed applications
- Useful for caching
- Easy object persistence

---

# Limitations

- Slight performance overhead
- Larger serialized data
- Version compatibility issues
- Security risks when deserializing untrusted data

---

# Best Practices

✅ Always define `serialVersionUID`.

✅ Mark sensitive fields as `transient`.

✅ Close streams using `try-with-resources`.

✅ Never deserialize data from untrusted sources.

✅ Serialize only when necessary.

---

# Common Mistakes

❌ Forgetting to implement `Serializable`.

---

❌ Forgetting `serialVersionUID`.

---

❌ Serializing passwords or sensitive data.

---

❌ Deserializing data from unknown or untrusted sources.

---

# Interview Questions

### 1. What is Serialization?

Serialization is the process of converting an object into a byte stream.

---

### 2. What is Deserialization?

Deserialization converts a byte stream back into an object.

---

### 3. Which interface enables serialization?

```java
Serializable
```

---

### 4. What is a Marker Interface?

An interface with no methods that provides metadata to the JVM.

---

### 5. What is `serialVersionUID`?

A unique version identifier used to verify compatibility during deserialization.

---

### 6. What happens if `serialVersionUID` changes?

Deserialization may fail with an `InvalidClassException`.

---

### 7. What is the purpose of the `transient` keyword?

It prevents a field from being serialized.

---

### 8. Are static fields serialized?

No.

Static fields belong to the class, not to the object.

---

### 9. Which classes perform serialization and deserialization?

- `ObjectOutputStream`
- `ObjectInputStream`

---

### 10. Where is Serialization used in Spring Boot?

It is used in session management, distributed caching, messaging systems, and object transfer between services.

---

# Quick Revision

- Serialization → Object → Bytes.
- Deserialization → Bytes → Object.
- Implement `Serializable`.
- Use `ObjectOutputStream.writeObject()`.
- Use `ObjectInputStream.readObject()`.
- `Serializable` is a marker interface.
- Use `serialVersionUID`.
- Use `transient` for sensitive fields.
- Static fields are not serialized.
- Never deserialize untrusted data.

---

# Keywords

- Serialization
- Deserialization
- Serializable
- ObjectOutputStream
- ObjectInputStream
- Marker Interface
- serialVersionUID
- transient
- writeObject()
- readObject()
- Byte Stream
- Java File I/O