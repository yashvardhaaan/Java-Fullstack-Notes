# Gradle

## What is Gradle?

**Gradle** is an **open-source build automation tool** used to:

- Compile Code
- Download Dependencies
- Run Tests
- Package Applications
- Build Executable JARs
- Automate Project Tasks

It is one of the most popular build tools for Java and Spring Boot applications.

> **In simple words:**
>
> Gradle automates everything required to build and run your application.

---

# Why Do We Need Gradle?

Without Gradle

```
Write Code

↓

Download Libraries Manually

↓

Compile

↓

Run Tests

↓

Package

↓

Deploy
```

Everything is manual.

---

With Gradle

```
Write Code

↓

./gradlew build

↓

Dependencies Downloaded

↓

Compiled

↓

Tests Executed

↓

JAR Created
```

Everything happens automatically.

---

# What is Build Automation?

Build Automation means automating repetitive development tasks.

Examples

- Compile Java Code
- Download Dependencies
- Execute Tests
- Generate Reports
- Create JAR
- Create WAR
- Build Docker Images

---

# Gradle Architecture

```
Developer

↓

build.gradle

↓

Gradle

↓

Compile

↓

Download Dependencies

↓

Run Tests

↓

Package

↓

Application.jar
```

---

# Gradle Project Structure

```
project

├── src

├── build.gradle

├── settings.gradle

├── gradlew

├── gradlew.bat

└── gradle
```

---

# Important Files

## build.gradle

Contains

- Dependencies
- Plugins
- Build Configuration
- Tasks

---

## settings.gradle

Contains project name.

Example

```gradle
rootProject.name = "spring-demo"
```

---

## gradlew

Gradle Wrapper for Linux/macOS.

---

## gradlew.bat

Gradle Wrapper for Windows.

---

# Gradle Build Lifecycle

```
Initialization

↓

Configuration

↓

Execution
```

---

## 1. Initialization

Gradle identifies

- Project
- Modules
- Build Files

---

## 2. Configuration

Gradle reads

```
build.gradle
```

Loads

- Plugins
- Dependencies
- Tasks

---

## 3. Execution

Runs requested task.

Example

```
build

↓

Compile

↓

Test

↓

Package
```

---

# Sample build.gradle

```gradle
plugins {

    id 'java'

    id 'org.springframework.boot'
            version '3.5.0'

}

group = 'com.example'

version = '1.0.0'

repositories {

    mavenCentral()

}

dependencies {

    implementation
        'org.springframework.boot:spring-boot-starter-web'

    testImplementation
        'org.springframework.boot:spring-boot-starter-test'

}
```

---

# Common Gradle Tasks

Build Project

```bash
./gradlew build
```

---

Clean Project

```bash
./gradlew clean
```

---

Run Tests

```bash
./gradlew test
```

---

Run Application

```bash
./gradlew bootRun
```

---

Create JAR

```bash
./gradlew bootJar
```

---

View Tasks

```bash
./gradlew tasks
```

---

# Dependency Management

Example

```gradle
dependencies {

    implementation
        'org.springframework.boot:spring-boot-starter-data-jpa'

    implementation
        'org.springframework.boot:spring-boot-starter-security'

}
```

Gradle automatically downloads dependencies from Maven Central.

---

# Repositories

Example

```gradle
repositories {

    mavenCentral()

}
```

Popular repositories

- Maven Central
- Google Maven
- Local Maven Repository

---

# Gradle Wrapper

Instead of installing Gradle manually,

use

```bash
./gradlew
```

Benefits

- Same Gradle version for every developer.
- No manual installation.
- Better consistency.

---

# Gradle vs Maven

| Gradle | Maven |
|----------|--------|
| Groovy/Kotlin DSL | XML Configuration |
| Faster Incremental Builds | Slightly Slower |
| Flexible | Convention-Based |
| Highly Customizable | Easier for Beginners |
| `build.gradle` | `pom.xml` |

---

# Spring Boot with Gradle

```
Spring Boot Project

↓

build.gradle

↓

Gradle Build

↓

Compile

↓

Run Tests

↓

bootJar

↓

application.jar
```

---

# Dependency Resolution

```
build.gradle

↓

Dependency Declared

↓

Maven Central

↓

Downloaded

↓

Stored in Local Cache
```

Gradle downloads each dependency only once and reuses the cached version.

---

# Advantages

- Fast incremental builds.
- Flexible build scripts.
- Automatic dependency management.
- Easy plugin support.
- Excellent performance for large projects.
- Supports multi-module projects.

---

# Disadvantages

- Steeper learning curve than Maven.
- Build scripts can become complex.
- Less readable for beginners.

---

# Best Practices

- Always use the Gradle Wrapper.
- Keep dependencies updated.
- Remove unused dependencies.
- Use the latest stable Gradle version.
- Separate development and production configurations.
- Organize custom tasks clearly.

---

# Common Mistakes

❌ Installing different Gradle versions across team members.

❌ Adding unnecessary dependencies.

❌ Ignoring dependency conflicts.

❌ Not using the Gradle Wrapper.

❌ Keeping outdated plugins.

---

# Real-World Example

## Spring Boot Application

```
Developer

↓

Write Code

↓

./gradlew build

↓

Tests

↓

bootJar

↓

application.jar
```

---

## CI/CD Pipeline

```
Git Push

↓

GitHub Actions

↓

./gradlew test

↓

./gradlew build

↓

Deploy
```

---

# Gradle vs Maven Comparison

| Feature | Gradle | Maven |
|----------|---------|--------|
| Build File | build.gradle | pom.xml |
| Language | Groovy / Kotlin | XML |
| Performance | Faster | Good |
| Incremental Build | Yes | Limited |
| Flexibility | High | Medium |
| Learning Curve | Medium | Easy |

---

# Interview Questions

### 1. What is Gradle?

Gradle is a build automation tool used to compile code, manage dependencies, run tests, and package applications.

---

### 2. What is the purpose of `build.gradle`?

It defines plugins, dependencies, repositories, tasks, and build configurations for the project.

---

### 3. What is the Gradle Wrapper?

The Gradle Wrapper (`gradlew` and `gradlew.bat`) allows a project to use a specific Gradle version without requiring developers to install Gradle manually.

---

### 4. What are the phases of the Gradle build lifecycle?

- Initialization
- Configuration
- Execution

---

### 5. Which command builds a Gradle project?

```bash
./gradlew build
```

---

### 6. Which command runs a Spring Boot application using Gradle?

```bash
./gradlew bootRun
```

---

### 7. Which command creates an executable Spring Boot JAR?

```bash
./gradlew bootJar
```

---

### 8. Why is Gradle generally faster than Maven?

Gradle supports incremental builds, build caching, and parallel execution, reducing unnecessary work during subsequent builds.

---

### 9. Where does Gradle download dependencies from?

By default, from repositories such as **Maven Central**, configured in the `repositories` block.

---

### 10. Should you install Gradle manually on every machine?

No. It is recommended to use the **Gradle Wrapper** so everyone uses the same Gradle version.

---

# Quick Revision

- Gradle is a **build automation tool**.
- Main configuration file: **build.gradle**.
- Project name is defined in **settings.gradle**.
- Gradle lifecycle: **Initialization → Configuration → Execution**.
- Build project: `./gradlew build`
- Run application: `./gradlew bootRun`
- Create executable JAR: `./gradlew bootJar`
- Clean project: `./gradlew clean`
- Use the **Gradle Wrapper** instead of installing Gradle manually.
- Gradle automatically downloads dependencies from **Maven Central**.