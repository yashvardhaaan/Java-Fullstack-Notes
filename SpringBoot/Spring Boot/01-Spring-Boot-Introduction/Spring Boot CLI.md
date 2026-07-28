# Spring Boot CLI

## What is Spring Boot CLI?

**Spring Boot CLI (Command Line Interface)** is a command-line tool that allows you to quickly create, run, and test Spring Boot applications without setting up a complete project.

It uses **Groovy** scripts and automatically manages dependencies behind the scenes.

> **In simple words:**  
> Spring Boot CLI lets you write and run Spring Boot applications directly from the command line with minimal setup.

---

# Why Do We Need Spring Boot CLI?

Normally, to create a Spring Boot application you need to:

- Create a Maven or Gradle project
- Write `pom.xml` or `build.gradle`
- Download dependencies
- Import into an IDE
- Build the project
- Run the application

With Spring Boot CLI, you can quickly write a Groovy script and run it directly.

---

# How Spring Boot CLI Works

```
Write Groovy Script
        │
        ▼
Spring Boot CLI
        │
        ▼
Automatically Downloads Dependencies
        │
        ▼
Starts Embedded Server
        │
        ▼
Application Runs
```

---

# Installing Spring Boot CLI

You can install Spring Boot CLI using:

### Windows

Using SDKMAN (via WSL), Scoop, or by downloading the Spring Boot CLI distribution.

---

### macOS

Using Homebrew:

```bash
brew install springboot
```

---

### Linux

Using SDKMAN:

```bash
sdk install springboot
```

---

# Verify Installation

Run:

```bash
spring --version
```

Example output:

```text
Spring CLI v3.x.x
```

---

# Creating Your First CLI Application

Create a file named:

```
app.groovy
```

Write the following code:

```groovy
@RestController
class HelloController {

    @GetMapping("/")
    String home() {
        return "Hello Spring Boot CLI!"
    }

}
```

Run the application:

```bash
spring run app.groovy
```

Open:

```
http://localhost:8080
```

Output:

```text
Hello Spring Boot CLI!
```

---

# Dependency Resolution

Suppose you use:

```groovy
@RestController
```

Spring Boot CLI automatically detects that Spring MVC is required and downloads the necessary libraries.

You don't need to manually configure Maven or Gradle.

---

# Commands in Spring Boot CLI

## 1. Run an Application

```bash
spring run app.groovy
```

Runs the Groovy application.

---

## 2. Check Version

```bash
spring --version
```

Displays the installed Spring Boot CLI version.

---

## 3. Help

```bash
spring help
```

Shows all available commands.

---

## 4. List Commands

```bash
spring help run
```

Displays help for the `run` command.

---

## 5. Test Application

```bash
spring test app.groovy
```

Runs tests written in Groovy.

---

# Project Structure

A CLI application can be as simple as:

```
project/
│
└── app.groovy
```

Unlike a normal Spring Boot project, there is no need for:

- `pom.xml`
- `build.gradle`
- `src/main/java`
- `src/test/java`

for simple experiments.

---

# Spring Boot CLI vs Traditional Project

| Feature | Traditional Spring Boot | Spring Boot CLI |
|----------|-------------------------|-----------------|
| Build Tool | Maven/Gradle | Not Required |
| Project Structure | Required | Minimal |
| Language | Java/Kotlin | Groovy |
| Dependency Management | Manual (via Maven/Gradle) | Automatic |
| Best For | Production Applications | Learning, Demos, Prototypes |

---

# Real World Example

Imagine making a cup of instant coffee.

### Traditional Way

You:

- Boil water
- Measure coffee
- Add sugar
- Add milk
- Mix everything

---

### Instant Coffee

Just pour hot water into the cup.

Everything else is already prepared.

Spring Boot CLI works in a similar way—it minimizes setup so you can focus on writing code.

---

# Advantages

- Quick application development
- Minimal setup
- Automatic dependency resolution
- Great for learning and experimentation
- No Maven or Gradle configuration needed for simple apps

---

# Limitations

- Uses Groovy instead of Java
- Not commonly used in production projects
- Limited compared to a full IDE and build tool setup
- Less popular than Spring Initializr

---

# When Should You Use Spring Boot CLI?

Use it for:

- Learning Spring Boot
- Trying small examples
- Building quick prototypes
- Demonstrating concepts
- Testing ideas

Avoid using it for:

- Large enterprise applications
- Team projects
- Production systems

For those, use Spring Initializr with Maven or Gradle.

---

# Interview Questions

### 1. What is Spring Boot CLI?

Spring Boot CLI is a command-line tool that allows developers to create and run Spring Boot applications using Groovy scripts with automatic dependency management.

---

### 2. Which language does Spring Boot CLI primarily use?

Groovy.

---

### 3. Does Spring Boot CLI require Maven or Gradle?

No. It automatically resolves dependencies for simple CLI applications.

---

### 4. Is Spring Boot CLI commonly used in production?

No. Most production projects are created using Spring Initializr with Maven or Gradle.

---

### 5. What command is used to run a CLI application?

```bash
spring run app.groovy
```

---

# Best Practices

- Use Spring Boot CLI for learning and rapid prototyping.
- Use Spring Initializr for real-world and production applications.
- Learn the concepts through CLI, then build full projects using Maven or Gradle.

---

# Quick Revision

- Spring Boot CLI is a command-line tool for Spring Boot.
- It primarily uses **Groovy** scripts.
- Automatically downloads required dependencies.
- No Maven or Gradle setup is needed for simple applications.
- Useful for learning, demos, and quick prototypes.
- Production applications typically use **Spring Initializr** with Maven or Gradle.