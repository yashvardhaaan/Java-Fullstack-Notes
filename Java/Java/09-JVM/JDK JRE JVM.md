# JDK, JRE & JVM

## What are JDK, JRE, and JVM?

Whenever we write a Java program, three important components work together:

- **JDK (Java Development Kit)** – Used to develop Java applications.
- **JRE (Java Runtime Environment)** – Used to run Java applications.
- **JVM (Java Virtual Machine)** – Executes Java bytecode.

Think of them as different parts of a car.

- **JDK** → Garage with tools to build the car.
- **JRE** → The complete car.
- **JVM** → The engine that actually runs the car.

---

# Why Do We Need Them?

Suppose you write a Java program.

```java
public class Hello {
    public static void main(String[] args) {
        System.out.println("Hello World");
    }
}
```

Your computer understands only **machine code (0s and 1s)**.

So Java needs something that converts your program into machine code.

This is where JDK, JRE, and JVM come into the picture.

---

# Real-World Example

Imagine writing a book.

```
Author

↓

Writes Book

↓

Publisher

↓

Prints Book

↓

Reader

↓

Reads Book
```

Similarly,

```
Developer

↓

Writes Java Code

↓

JDK Compiles

↓

Bytecode

↓

JVM Executes

↓

Output
```

---

# What is JDK?

**JDK (Java Development Kit)** is a software package used to **develop Java applications**.

It contains everything required to write, compile, debug, and run Java programs.

> **Definition:** JDK is a development kit that contains the JRE along with development tools like the Java compiler.

---

# Components of JDK

```
JDK

├── JRE
├── javac
├── java
├── jar
├── javadoc
├── jdb
└── Other Development Tools
```

Important tools

| Tool | Purpose |
|------|---------|
| javac | Compiles Java source code |
| java | Runs Java programs |
| jar | Creates JAR files |
| javadoc | Generates documentation |
| jdb | Java Debugger |

---

# What is JRE?

**JRE (Java Runtime Environment)** provides everything needed to **run** a Java application.

It does **not** contain development tools like `javac`.

> **Definition:** JRE is the runtime environment that contains the JVM and required libraries to execute Java programs.

---

# Components of JRE

```
JRE

├── JVM
├── Java Libraries
└── Runtime Files
```

---

# What is JVM?

**JVM (Java Virtual Machine)** is the engine that executes Java bytecode.

It converts bytecode into machine code that the operating system understands.

> **Definition:** JVM is a virtual machine responsible for loading, verifying, and executing Java bytecode.

---

# Relationship

```
JDK

└── JRE

      └── JVM
```

So,

- JDK contains JRE.
- JRE contains JVM.

---

# How Java Program Runs

```
Hello.java

↓

javac

↓

Hello.class

(Bytecode)

↓

JVM

↓

Machine Code

↓

Operating System

↓

Output
```

---

# Compilation Process

Step 1

Write

```java
Hello.java
```

↓

Step 2

Compile

```text
javac Hello.java
```

↓

Produces

```text
Hello.class
```

↓

Step 3

Run

```text
java Hello
```

↓

JVM loads the class and executes it.

---

# Why Bytecode?

Instead of generating machine code directly,

Java generates **Bytecode**.

```
Java Code

↓

Bytecode

↓

Windows JVM

↓

Runs
```

```
Java Code

↓

Bytecode

↓

Linux JVM

↓

Runs
```

```
Java Code

↓

Bytecode

↓

macOS JVM

↓

Runs
```

This gives Java its famous slogan:

> **"Write Once, Run Anywhere (WORA)"**

---

# Platform Independence

```
Java Source Code

↓

Bytecode (.class)

↓

Different JVMs

↓

Windows

Linux

macOS
```

The same `.class` file can run on any platform that has a compatible JVM.

---

# JDK vs JRE vs JVM

| Feature | JDK | JRE | JVM |
|---------|-----|-----|-----|
| Used for Development | ✅ | ❌ | ❌ |
| Runs Java Programs | ✅ | ✅ | ✅ |
| Contains Compiler | ✅ | ❌ | ❌ |
| Contains JVM | ✅ | ✅ | ❌ |
| Contains Libraries | ✅ | ✅ | Limited internal components |

---

# Internal Working

Suppose you execute

```text
java Hello
```

Internally

```
Hello.class

↓

Class Loader

↓

Bytecode Verifier

↓

JVM Memory

↓

Execution Engine

↓

Machine Code

↓

CPU

↓

Output
```

We'll study each of these components in the upcoming JVM topics.

---

# Production Usage

When you run a Spring Boot application

```text
mvn spring-boot:run
```

or

```text
java -jar app.jar
```

the following happens:

```
Spring Boot Application

↓

JDK Tools

↓

Bytecode

↓

JVM

↓

Embedded Tomcat

↓

Application Starts
```

Without the JVM, no Java application—including Spring Boot—can run.

---

# Advantages

- Platform independent
- Secure execution
- Automatic memory management
- Rich development tools
- Large standard library
- Supports multiple operating systems

---

# Limitations

- JVM startup time
- Higher memory usage than some native languages
- Performance can be lower than optimized native code for certain workloads

---

# Best Practices

✅ Install only the JDK for development.

✅ Keep the JDK updated.

✅ Match the JDK version with your project requirements.

✅ Understand the JVM before learning advanced Java topics.

---

# Common Mistakes

❌ Thinking JDK, JRE, and JVM are the same.

---

❌ Assuming the JVM compiles Java source code.

The **compiler (`javac`)** in the JDK creates bytecode. The JVM executes that bytecode.

---

❌ Thinking Java code runs directly on the operating system.

It always runs through the JVM.

---

❌ Believing JRE is enough for development.

You need the JDK because it includes development tools like `javac`.

---

# Interview Questions

### 1. What is JDK?

JDK (Java Development Kit) is used to develop Java applications. It includes the JRE and development tools like `javac`.

---

### 2. What is JRE?

JRE (Java Runtime Environment) provides the environment required to run Java applications. It includes the JVM and Java libraries.

---

### 3. What is JVM?

JVM (Java Virtual Machine) executes Java bytecode by converting it into machine code.

---

### 4. What is Bytecode?

Bytecode is the intermediate code (`.class` file) generated by the Java compiler. It is platform-independent and executed by the JVM.

---

### 5. Why is Java platform-independent?

Because Java compiles source code into platform-independent bytecode, and each operating system has its own JVM that executes that bytecode.

---

### 6. Does JDK contain JRE?

Yes.

---

### 7. Does JRE contain JVM?

Yes.

---

### 8. Can we run Java programs without JDK?

Yes, if a JRE (or a modern JDK, which includes the runtime) is available. However, you cannot **compile** Java source code without the JDK.

---

### 9. What is the role of `javac`?

`javac` compiles `.java` source files into `.class` bytecode files.

---

### 10. Which component converts bytecode into machine code?

The JVM, using its execution engine (including the JIT compiler when applicable).

---

# Quick Revision

- JDK = Development Kit.
- JRE = Runtime Environment.
- JVM = Virtual Machine.
- JDK contains JRE.
- JRE contains JVM.
- `javac` compiles Java code.
- JVM executes bytecode.
- Bytecode enables platform independence.
- Java follows **Write Once, Run Anywhere (WORA)**.

---

# Keywords

- JDK
- JRE
- JVM
- Java Compiler
- javac
- Bytecode
- Class File
- Machine Code
- Platform Independence
- WORA
- Java Runtime
- Execution Engine
- Spring Boot
- Java Development Kit
- Java Runtime Environment
- Java Virtual Machine