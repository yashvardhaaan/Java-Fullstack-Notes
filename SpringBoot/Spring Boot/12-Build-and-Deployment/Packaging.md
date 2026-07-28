# Packaging

## What is Packaging?

**Packaging** is the process of converting your application's source code into a **deployable artifact** such as a:

- JAR (Java Archive)
- WAR (Web Archive)

The packaged file contains everything required to run or deploy the application.

> **In simple words:**
>
> Packaging is the final step where your project is bundled into a single file that can be deployed to a server.

---

# Why Do We Need Packaging?

Without Packaging

```
Java Files

↓

Resources

↓

Libraries

↓

Configuration

↓

Many Files

↓

Deployment Difficult
```

Problems

- Many files to manage
- Missing dependencies
- Difficult deployment

---

With Packaging

```
Source Code

↓

Package

↓

Single JAR/WAR

↓

Deploy

↓

Run
```

Deployment becomes simple and reliable.

---

# Packaging Workflow

```
Source Code

↓

Compile

↓

Run Tests

↓

Package

↓

Deployable Artifact

↓

Deployment
```

---

# Types of Packaging

| Packaging | Extension | Used For |
|------------|-----------|----------|
| JAR | `.jar` | Standalone Java/Spring Boot Applications |
| WAR | `.war` | Traditional Web Servers (Tomcat, Jetty) |
| POM | `.pom` | Parent or Multi-module Projects |

---

# JAR Packaging

A **JAR (Java Archive)** contains:

- Compiled Classes
- Dependencies (Spring Boot Fat JAR)
- Resources
- Configuration
- Manifest File

```
Application

↓

Executable JAR

↓

java -jar app.jar
```

Example

```xml
<packaging>jar</packaging>
```

---

# WAR Packaging

A **WAR (Web Archive)** is used when deploying to an external application server.

Example

```xml
<packaging>war</packaging>
```

Deployment

```
Application.war

↓

Apache Tomcat

↓

Application Running
```

---

# JAR vs WAR

| JAR | WAR |
|------|-----|
| Standalone | Requires External Server |
| Embedded Tomcat | External Tomcat |
| Easy Deployment | Traditional Deployment |
| Recommended for Spring Boot | Used for Legacy Applications |

---

# Spring Boot Packaging Process

```
Source Code

↓

Maven / Gradle

↓

Compile

↓

Run Tests

↓

Package

↓

Executable JAR

↓

Deployment
```

---

# Packaging with Maven

Create Package

```bash
mvn package
```

Clean + Package

```bash
mvn clean package
```

Generated File

```
target/

↓

application.jar
```

---

# Packaging with Gradle

Create Package

```bash
./gradlew build
```

or

```bash
./gradlew bootJar
```

Generated File

```
build/libs/

↓

application.jar
```

---

# Maven Packaging Configuration

Example

```xml
<packaging>jar</packaging>
```

For WAR

```xml
<packaging>war</packaging>
```

---

# Packaging Lifecycle

```
Validate

↓

Compile

↓

Test

↓

Package

↓

Install

↓

Deploy
```

Packaging happens after successful compilation and testing.

---

# What Happens During Packaging?

```
Java Files

↓

Compile

↓

.class Files

↓

Resources Added

↓

Dependencies Included

↓

JAR/WAR Created
```

---

# Packaging Output

Typical Maven Output

```
project

├── src

├── pom.xml

└── target

    ├── classes

    ├── generated-sources

    ├── test-classes

    └── application.jar
```

---

# Running Packaged Application

For JAR

```bash
java -jar application.jar
```

For WAR

```
Deploy to

↓

Tomcat

↓

Access Through Browser
```

---

# Packaging for Docker

```
Spring Boot

↓

Package JAR

↓

Docker Build

↓

Docker Image

↓

Docker Container
```

---

# Packaging in CI/CD

```
Git Push

↓

Build

↓

Run Tests

↓

Package

↓

Deploy
```

Packaging is an essential stage in every CI/CD pipeline.

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

Single JAR
```

---

## Thin JAR

Contains only the application.

Dependencies are downloaded separately.

---

| Fat JAR | Thin JAR |
|----------|----------|
| Self-contained | External Dependencies Needed |
| Larger Size | Smaller Size |
| Easy Deployment | More Configuration |

Spring Boot creates a **Fat JAR** by default.

---

# Packaging Best Practices

- Run tests before packaging.
- Keep dependencies updated.
- Remove unused libraries.
- Use executable JARs for Spring Boot.
- Store configuration outside the package for production.
- Use environment variables for secrets.
- Version every release.

---

# Common Mistakes

❌ Packaging without running tests.

❌ Including unnecessary dependencies.

❌ Hardcoding configuration.

❌ Deploying the wrong artifact version.

❌ Committing generated `target/` or `build/` folders to Git.

---

# Advantages

- Easy deployment.
- Portable application.
- Single deployable file.
- Better dependency management.
- Consistent builds.
- Suitable for automation and CI/CD.

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
Source Code

↓

Package JAR

↓

Docker Build

↓

Docker Image

↓

Production
```

---

# Packaging vs Deployment

| Packaging | Deployment |
|------------|------------|
| Creates Deployable Artifact | Runs Artifact on Server |
| Produces JAR/WAR | Makes Application Accessible |
| Happens Before Deployment | Happens After Packaging |

---

# Interview Questions

### 1. What is Packaging?

Packaging is the process of converting source code into a deployable artifact such as a JAR or WAR file.

---

### 2. What is the difference between JAR and WAR?

- **JAR** is a standalone executable package used by Spring Boot.
- **WAR** is deployed to an external application server like Apache Tomcat.

---

### 3. Which packaging type is recommended for Spring Boot?

**JAR**, because Spring Boot includes an embedded server by default.

---

### 4. Which Maven command creates a packaged application?

```bash
mvn package
```

or

```bash
mvn clean package
```

---

### 5. Which Gradle command creates a packaged application?

```bash
./gradlew build
```

or

```bash
./gradlew bootJar
```

---

### 6. What is a Fat JAR?

A Fat JAR contains both the application code and all required dependencies in a single executable file.

---

### 7. What is the difference between Packaging and Deployment?

Packaging creates the deployable artifact, while deployment places and runs that artifact on a server or cloud environment.

---

### 8. Why should tests run before packaging?

Running tests helps ensure that only stable and working code is packaged and deployed.

---

# Quick Revision

- Packaging converts source code into **JAR** or **WAR** files.
- Spring Boot recommends **Executable JARs**.
- Maven: `mvn clean package`
- Gradle: `./gradlew build` or `./gradlew bootJar`
- Packaging occurs after **Compile** and **Test**.
- **Fat JARs** include application code and dependencies.
- Packaging is completed **before deployment**.
- Packaged artifacts are commonly used in Docker, AWS, and CI/CD pipelines.