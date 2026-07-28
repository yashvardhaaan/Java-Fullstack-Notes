# Executable JAR

## What is an Executable JAR?

An **Executable JAR (Java Archive)** is a packaged Java application that contains:

- Compiled Java Classes
- Required Libraries (Dependencies)
- Configuration Files
- Resources
- Manifest File

It can be executed directly using the Java Runtime.

> **In simple words:**
>
> An Executable JAR is a single file that contains your entire Spring Boot application and can be started with one command.

---

# Why Do We Need an Executable JAR?

Without Executable JAR

```
Application

↓

Classes

↓

Libraries

↓

Configurations

↓

Manual Setup

↓

Run
```

Problems

- Difficult deployment
- Dependency issues
- Multiple files to manage

---

With Executable JAR

```
Application

↓

Single JAR File

↓

java -jar app.jar

↓

Application Running
```

---

# What is Inside an Executable JAR?

```
app.jar

├── META-INF

│   └── MANIFEST.MF

├── BOOT-INF

│   ├── classes

│   └── lib

└── org
```

---

# Spring Boot Packaging Flow

```
Source Code

↓

Compile

↓

Test

↓

Package

↓

Executable JAR

↓

Deploy
```

---

# Build Executable JAR Using Maven

Command

```bash
mvn clean package
```

Output

```
target/

↓

my-app-0.0.1-SNAPSHOT.jar
```

---

# Build Using Gradle

Command

```bash
./gradlew build
```

Generated File

```
build/libs/

↓

application.jar
```

---

# Running the Executable JAR

Command

```bash
java -jar app.jar
```

Flow

```
JAR File

↓

JVM

↓

Spring Boot Starts

↓

Embedded Tomcat

↓

Application Ready
```

---

# Embedded Server

Spring Boot packages an embedded server inside the JAR.

Usually

```
Embedded Tomcat
```

Other options

- Jetty
- Undertow

No external server installation is required.

---

# Manifest File

Location

```
META-INF/MANIFEST.MF
```

Example

```
Main-Class:
org.springframework.boot.loader.launch.JarLauncher

Start-Class:
com.example.Application
```

The manifest tells Java how to start the application.

---

# Spring Boot Executable JAR Structure

```
application.jar

├── META-INF

├── BOOT-INF

│   ├── classes

│   └── lib

└── Spring Boot Loader
```

---

# BOOT-INF Folder

## classes

Contains

- Compiled Java Classes
- application.properties
- Static Resources

---

## lib

Contains

- Spring Libraries
- Third-party Libraries
- Dependencies

Example

```
spring-web.jar

hibernate.jar

jackson.jar
```

---

# Build Lifecycle

```
Source Code

↓

Compile

↓

Run Tests

↓

Package

↓

Executable JAR
```

---

# Deployment Flow

```
Developer

↓

Build JAR

↓

Upload Server

↓

java -jar app.jar

↓

Application Live
```

---

# Running on Custom Port

Using Command Line

```bash
java -jar app.jar --server.port=9090
```

---

Using application.properties

```properties
server.port=9090
```

---

# Passing Environment Variables

Linux

```bash
export DB_PASSWORD=password

java -jar app.jar
```

Windows

```cmd
set DB_PASSWORD=password

java -jar app.jar
```

Spring Boot automatically reads supported environment variables.

---

# Running in Background

Linux

```bash
nohup java -jar app.jar &
```

Application continues running even after closing the terminal.

---

# Check Running Process

Linux

```bash
ps -ef
```

Windows

```cmd
tasklist
```

---

# Stop the Application

Linux

```bash
kill PID
```

Windows

```cmd
taskkill /PID PID /F
```

---

# Fat JAR vs Thin JAR

## Fat JAR

Contains

- Application
- Dependencies

```
Application

+

Libraries

↓

One JAR
```

---

## Thin JAR

Contains

- Application Only

Dependencies are downloaded separately.

---

| Fat JAR | Thin JAR |
|----------|----------|
| Self-contained | Requires external dependencies |
| Larger Size | Smaller Size |
| Easier Deployment | More Setup Required |

Spring Boot creates a **Fat JAR** by default.

---

# Maven Plugin

Spring Boot uses

```xml
<plugin>

    <groupId>
        org.springframework.boot
    </groupId>

    <artifactId>
        spring-boot-maven-plugin
    </artifactId>

</plugin>
```

This plugin creates the executable JAR.

---

# Advantages

- Single deployable file.
- Embedded server included.
- Easy deployment.
- Platform independent.
- No external Tomcat installation.
- Ideal for cloud deployment.

---

# Disadvantages

- Larger file size compared to Thin JAR.
- Startup can be slightly slower because of bundled dependencies.
- Updating a single dependency requires rebuilding the JAR.

---

# Best Practices

- Use `mvn clean package` before deployment.
- Store configuration outside the JAR for different environments.
- Use environment variables for secrets.
- Keep dependencies updated.
- Run the JAR as a service (`systemd`) in production.
- Monitor logs after deployment.

---

# Common Mistakes

❌ Forgetting to include the Spring Boot Maven Plugin.

❌ Hardcoding database credentials.

❌ Editing files inside the JAR.

❌ Running the application as the root user.

❌ Not checking logs after deployment.

---

# Real-World Example

## Spring Boot Deployment

```
Developer

↓

mvn clean package

↓

application.jar

↓

AWS EC2

↓

java -jar application.jar

↓

Live Application
```

---

## Docker Deployment

```
Executable JAR

↓

Docker Image

↓

Docker Container

↓

Production
```

---

# Interview Questions

### 1. What is an Executable JAR?

An Executable JAR is a packaged Java application that includes compiled code, dependencies, and an entry point so it can be run using `java -jar`.

---

### 2. Which command creates an Executable JAR using Maven?

```bash
mvn clean package
```

---

### 3. Which command runs an Executable JAR?

```bash
java -jar app.jar
```

---

### 4. Why doesn't Spring Boot require an external Tomcat server?

Because Spring Boot packages an embedded web server (such as Tomcat) inside the executable JAR.

---

### 5. What is the purpose of the Manifest file?

It tells the JVM which class should be used to start the application.

---

### 6. What is the difference between a Fat JAR and a Thin JAR?

A Fat JAR contains both the application and its dependencies, while a Thin JAR contains only the application and requires dependencies to be available separately.

---

### 7. Which Maven plugin creates the Spring Boot Executable JAR?

`spring-boot-maven-plugin`

---

# Quick Revision

- Executable JAR is a **self-contained deployable Java application**.
- Built using `mvn clean package` or `gradlew build`.
- Run using `java -jar app.jar`.
- Spring Boot includes an **embedded Tomcat** by default.
- `BOOT-INF/classes` contains application classes.
- `BOOT-INF/lib` contains dependencies.
- Spring Boot generates a **Fat JAR** by default.
- Use environment variables for configuration.
- Ideal for cloud, Docker, and server deployments.