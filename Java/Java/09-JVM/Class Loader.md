# Class Loader

## What is a Class Loader?

A **Class Loader** is a JVM component responsible for **loading Java classes (.class files) into memory** before they are executed.

Whenever the JVM needs a class, it asks the Class Loader to find it, load it, and prepare it for execution.

> **Definition:** Class Loader is a subsystem of the JVM that dynamically loads Java classes into memory.

---

# Why Do We Need a Class Loader?

Suppose you run

```java
public class Main {
    public static void main(String[] args) {
        Student s = new Student();
    }
}
```

The JVM cannot execute `Student.class` unless it is first loaded into memory.

The Class Loader performs this task automatically.

---

# Real-World Example

Imagine a library.

```
Student

↓

Requests Book

↓

Librarian

↓

Finds Book

↓

Brings Book

↓

Student Reads
```

Similarly,

```
Java Program

↓

Needs Class

↓

Class Loader

↓

Loads Class

↓

JVM Executes
```

---

# Class Loading Process

The Class Loader follows three major phases.

```
Loading

↓

Linking

↓

Initialization
```

---

# Complete Flow

```
Student.class

↓

Loading

↓

Linking

↓

Initialization

↓

Execution
```

---

# Phase 1: Loading

The JVM finds the `.class` file and loads it into memory.

Example

```
Student.class

↓

Class Loader

↓

Memory
```

During loading:

- Reads bytecode
- Creates a `Class` object
- Stores class information in Metaspace

---

# Phase 2: Linking

Linking has three steps.

```
Linking

├── Verification
├── Preparation
└── Resolution
```

---

## Verification

The JVM checks whether the bytecode is valid and secure.

Checks include:

- Invalid bytecode
- Illegal memory access
- Stack overflow possibility
- File corruption

Example

```
Bytecode

↓

Verifier

↓

Valid?

↓

Yes

↓

Continue
```

If invalid,

```
ClassFormatError
```

or another verification-related error may occur.

---

## Preparation

Memory is allocated for **static variables**.

Default values are assigned.

Example

```java
static int count;
```

After preparation

```
count = 0
```

No custom initialization happens yet.

---

## Resolution

The JVM converts symbolic references into actual memory references.

Example

```
Student

↓

Reference

↓

Actual Memory Address
```

This makes class relationships ready for execution.

---

# Phase 3: Initialization

Now static variables receive their actual values and static blocks execute.

Example

```java
static int count = 100;

static {
    System.out.println("Loaded");
}
```

Initialization

```
count = 100

↓

Static Block Runs
```

This phase happens only once for a class.

---

# Types of Class Loaders

Java mainly has three built-in Class Loaders.

```
Bootstrap Class Loader

↓

Platform Class Loader

↓

Application Class Loader
```

---

# Bootstrap Class Loader

It is the parent of all Class Loaders.

Loads core Java classes.

Examples

```
java.lang.String

java.lang.Object

java.util.ArrayList
```

Location

```
JDK Runtime Libraries
```

It is implemented by the JVM (native code), not as a regular Java class.

---

# Platform Class Loader

Introduced in Java 9.

Loads platform libraries provided by the JDK.

Examples

```
java.sql

java.xml

java.management
```

---

# Application Class Loader

Also called the **System Class Loader**.

Loads classes from:

- Current Project
- Classpath
- External JAR files

Example

```
Student.class

Employee.class

Main.class
```

These are usually loaded by the Application Class Loader.

---

# Class Loader Hierarchy

```
Bootstrap

↓

Platform

↓

Application

↓

Your Classes
```

---

# Parent Delegation Model

Java follows the **Parent Delegation Model**.

Instead of loading a class directly,

the child first asks its parent.

```
Application Loader

↓

Platform Loader

↓

Bootstrap Loader
```

If the parent cannot find the class,

the request comes back.

```
Bootstrap ❌

↓

Platform ❌

↓

Application ✅
```

---

# Why Parent Delegation?

It provides:

- Security
- Prevents duplicate loading
- Ensures core Java classes are loaded correctly

Example

Suppose someone creates

```
java.lang.String
```

inside their project.

Without Parent Delegation,

the fake class might be loaded.

With Parent Delegation,

Bootstrap loads the real `String` class.

---

# Custom Class Loader

Developers can create their own Class Loader.

Example

```java
class MyLoader extends ClassLoader {

}
```

Common use cases

- Plugin systems
- Encryption
- Dynamic class loading
- Application servers
- Hot deployment

---

# Class.forName()

A class can also be loaded dynamically.

```java
Class.forName("Student");
```

This loads the class and triggers initialization.

Useful in:

- JDBC Drivers
- Reflection
- Frameworks
- Spring
- Hibernate

---

# Internal Working

Suppose

```java
Student s = new Student();
```

Internally

```
Student.class

↓

Application Class Loader

↓

Loading

↓

Verification

↓

Preparation

↓

Resolution

↓

Initialization

↓

Metaspace

↓

Object Created

↓

Heap

↓

Reference Stored

↓

Stack
```

---

# Production Usage

Class Loaders are used in:

- Spring Boot
- Tomcat
- Hibernate
- Maven
- Gradle
- IntelliJ IDEA
- Jenkins
- Plugin-based applications

Example

When Spring Boot starts

```
Spring Boot

↓

Application Class Loader

↓

Loads Controllers

↓

Loads Services

↓

Loads Repositories

↓

Application Starts
```

---

# Advantages

- Dynamic class loading
- Improves security
- Efficient memory usage
- Supports modular applications
- Enables runtime extensibility

---

# Limitations

- Incorrect custom loaders can cause memory leaks
- Class loading issues are difficult to debug
- Loading many classes increases startup time

---

# Best Practices

✅ Follow the Parent Delegation Model.

✅ Avoid unnecessary custom Class Loaders.

✅ Understand the loading lifecycle.

✅ Use `Class.forName()` only when dynamic loading is required.

---

# Common Mistakes

❌ Thinking all classes are loaded at JVM startup.

Only required classes are loaded.

---

❌ Confusing loading with object creation.

Loading a class is different from creating an object.

---

❌ Assuming every class is loaded by the Bootstrap Class Loader.

Most application classes are loaded by the Application Class Loader.

---

❌ Ignoring static initialization order.

Static variables and static blocks execute during class initialization.

---

# Interview Questions

### 1. What is a Class Loader?

A JVM subsystem that loads `.class` files into memory.

---

### 2. What are the phases of class loading?

- Loading
- Linking
- Initialization

---

### 3. What are the steps in Linking?

- Verification
- Preparation
- Resolution

---

### 4. What is Verification?

It checks whether the bytecode is valid and secure.

---

### 5. What happens during Preparation?

Memory is allocated for static variables, and default values are assigned.

---

### 6. What happens during Initialization?

Static variables receive their assigned values, and static blocks execute.

---

### 7. What are the three built-in Class Loaders?

- Bootstrap Class Loader
- Platform Class Loader
- Application Class Loader

---

### 8. What is Parent Delegation?

A child Class Loader first delegates the class-loading request to its parent before attempting to load the class itself.

---

### 9. Why is Parent Delegation important?

It prevents duplicate loading, improves security, and ensures core Java classes are loaded correctly.

---

### 10. What is `Class.forName()`?

It dynamically loads a class by its fully qualified name and initializes it.

---

# Quick Revision

- Class Loader loads `.class` files.
- Phases:
  - Loading
  - Linking
  - Initialization
- Linking:
  - Verification
  - Preparation
  - Resolution
- Built-in Class Loaders:
  - Bootstrap
  - Platform
  - Application
- Uses Parent Delegation Model.
- Stores class metadata in Metaspace.
- Dynamic loading using `Class.forName()`.

---

# Keywords

- Class Loader
- Loading
- Linking
- Verification
- Preparation
- Resolution
- Initialization
- Bootstrap Class Loader
- Platform Class Loader
- Application Class Loader
- Parent Delegation
- Class.forName()
- Metaspace
- JVM
- Bytecode
```