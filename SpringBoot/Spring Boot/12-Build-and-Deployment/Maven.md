# Maven

## What is Maven?

**Maven** is an **open-source build automation and dependency management tool** used primarily for Java projects.

It helps developers:

- Compile Code
- Download Dependencies
- Run Tests
- Package Applications
- Generate Executable JAR/WAR Files
- Manage Project Lifecycle

> **In simple words:**
>
> Maven automates the process of building, testing, and packaging your Java application.

---

# Why Do We Need Maven?

Without Maven

```
Write Code

↓

Download JAR Files Manually

↓

Add to Project

↓

Compile

↓

Run Tests

↓

Package

↓

Deploy
```

Problems

- Dependency conflicts
- Manual work
- Difficult maintenance

---

With Maven

```
Write Code

↓

mvn clean package

↓

Dependencies Downloaded

↓

Compiled

↓

Tests Executed

↓

JAR Created
```

Everything is automated.

---

# What is Build Automation?

Build Automation means automating repetitive tasks like:

- Compilation
- Dependency Download
- Testing
- Packaging
- Deployment

Instead of doing everything manually.

---

# Maven Architecture

```
Developer

↓

pom.xml

↓

Maven

↓

Download Dependencies

↓

Compile

↓

Run Tests

↓

Package

↓

application.jar
```

---

# Maven Project Structure

```
project

├── src

│   ├── main

│   │   ├── java

│   │   └── resources

│   └── test

│       └── java

├── pom.xml

└── target
```

---

# What is pom.xml?

**POM** stands for

```
Project Object Model
```

It is the heart of every Maven project.

It contains

- Project Information
- Dependencies
- Plugins
- Build Configuration
- Repository Information

---

# Sample pom.xml

```xml
<project>

    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>

    <artifactId>spring-demo</artifactId>

    <version>1.0.0</version>

    <dependencies>

        <dependency>

            <groupId>
                org.springframework.boot
            </groupId>

            <artifactId>
                spring-boot-starter-web
            </artifactId>

        </dependency>

    </dependencies>

</project>
```

---

# Important pom.xml Elements

## groupId

Identifies the organization.

Example

```xml
<groupId>com.example</groupId>
```

---

## artifactId

Project name.

Example

```xml
<artifactId>spring-demo</artifactId>
```

---

## version

Project version.

Example

```xml
<version>1.0.0</version>
```

---

## packaging

Specifies the package type.

Example

```xml
<packaging>jar</packaging>
```

Possible values

- jar
- war
- pom

---

# Maven Build Lifecycle

```
Validate

↓

Compile

↓

Test

↓

Package

↓

Verify

↓

Install

↓

Deploy
```

---

## Validate

Checks project structure.

---

## Compile

Compiles Java source files.

Command

```bash
mvn compile
```

---

## Test

Runs unit tests.

Command

```bash
mvn test
```

---

## Package

Creates JAR/WAR.

Command

```bash
mvn package
```

---

## Install

Copies artifact to local Maven repository.

Command

```bash
mvn install
```

Location

```
~/.m2/repository
```

(Windows)

```
C:\Users\<username>\.m2\repository
```

---

## Deploy

Uploads artifact to a remote repository.

Example

```
Nexus

or

Artifactory
```

---

# Maven Repository

A Maven Repository stores dependencies.

Types

```
Local Repository

↓

Remote Repository

↓

Central Repository
```

---

## Local Repository

Stored on your computer.

Example

```
.m2/repository
```

Dependencies are cached here after the first download.

---

## Central Repository

Default repository used by Maven.

Contains millions of Java libraries.

---

## Remote Repository

Used inside organizations.

Examples

- Nexus
- JFrog Artifactory

---

# Dependency Management

Example

```xml
<dependency>

    <groupId>
        org.springframework.boot
    </groupId>

    <artifactId>
        spring-boot-starter-data-jpa
    </artifactId>

</dependency>
```

Maven automatically downloads the required JAR files.

---

# Maven Plugins

Plugins extend Maven's functionality.

Common plugins

- Compiler Plugin
- Surefire Plugin
- Spring Boot Maven Plugin
- JAR Plugin

---

# Spring Boot Maven Plugin

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

Purpose

- Create Executable JAR
- Run Spring Boot Application

---

# Common Maven Commands

Check Version

```bash
mvn -version
```

---

Compile

```bash
mvn compile
```

---

Run Tests

```bash
mvn test
```

---

Package

```bash
mvn package
```

---

Clean

```bash
mvn clean
```

Deletes the

```
target/
```

folder.

---

Install

```bash
mvn install
```

---

Clean + Package

```bash
mvn clean package
```

---

Run Spring Boot

```bash
mvn spring-boot:run
```

---

# Maven Dependency Resolution

```
pom.xml

↓

Dependency Declared

↓

Check Local Repository

↓

Found?

↓

Yes → Use It

↓

No

↓

Download from Maven Central

↓

Store in Local Repository
```

---

# Spring Boot Build Flow

```
Developer

↓

pom.xml

↓

Maven

↓

Download Dependencies

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

# Maven vs Gradle

| Maven | Gradle |
|--------|---------|
| XML Configuration | Groovy/Kotlin DSL |
| Convention-Based | More Flexible |
| Easy to Learn | More Powerful |
| Slower Incremental Builds | Faster Incremental Builds |
| Uses `pom.xml` | Uses `build.gradle` |

---

# Advantages

- Easy dependency management.
- Standard project structure.
- Automatic builds.
- Large plugin ecosystem.
- Excellent Spring Boot support.
- Strong community support.

---

# Disadvantages

- XML configuration is verbose.
- Less flexible than Gradle.
- Can be slower for very large projects.

---

# Best Practices

- Keep dependencies updated.
- Remove unused dependencies.
- Use Maven Wrapper (`mvnw`) for consistent builds.
- Use appropriate plugin versions.
- Keep `pom.xml` clean and organized.
- Avoid duplicate dependencies.

---

# Common Mistakes

❌ Adding unnecessary dependencies.

❌ Ignoring dependency conflicts.

❌ Hardcoding plugin versions incorrectly.

❌ Editing files inside the `target/` folder.

❌ Committing the `target/` directory to Git.

---

# Real-World Example

## Spring Boot Project

```
Developer

↓

Write Code

↓

mvn clean package

↓

Executable JAR

↓

Deploy to Server
```

---

## CI/CD Pipeline

```
Git Push

↓

GitHub Actions

↓

mvn clean verify

↓

Tests

↓

Package

↓

Deploy
```

---

# Interview Questions

### 1. What is Maven?

Maven is a build automation and dependency management tool used to compile, test, package, and manage Java projects.

---

### 2. What is `pom.xml`?

`pom.xml` (Project Object Model) is Maven's main configuration file that contains project information, dependencies, plugins, and build settings.

---

### 3. What is the Maven Build Lifecycle?

The default lifecycle consists of:

- Validate
- Compile
- Test
- Package
- Verify
- Install
- Deploy

---

### 4. What is the difference between `mvn package` and `mvn install`?

- `mvn package` creates the JAR/WAR file in the `target/` directory.
- `mvn install` also copies the generated artifact into the local Maven repository (`.m2/repository`).

---

### 5. Where does Maven store downloaded dependencies?

In the local Maven repository:

- Windows: `C:\Users\<username>\.m2\repository`
- Linux/macOS: `~/.m2/repository`

---

### 6. What is the purpose of the Spring Boot Maven Plugin?

It packages Spring Boot applications as executable JARs and provides goals like `spring-boot:run`.

---

### 7. What command removes old build files?

```bash
mvn clean
```

---

### 8. What command creates an executable JAR?

```bash
mvn clean package
```

---

### 9. What command runs a Spring Boot application?

```bash
mvn spring-boot:run
```

---

### 10. What is the difference between Maven and Gradle?

Maven uses XML (`pom.xml`) and follows convention over configuration, while Gradle uses Groovy/Kotlin DSL (`build.gradle`) and offers greater flexibility and faster incremental builds.

---

# Quick Revision

- Maven is a **build automation and dependency management tool**.
- Main configuration file: **pom.xml**.
- Lifecycle: **Validate → Compile → Test → Package → Verify → Install → Deploy**.
- `mvn clean` removes the `target/` folder.
- `mvn package` creates a JAR/WAR.
- `mvn install` copies the artifact to the local Maven repository.
- `mvn spring-boot:run` starts a Spring Boot application.
- Dependencies are downloaded from **Maven Central** and cached in `.m2/repository`.
- Spring Boot uses the **Spring Boot Maven Plugin** to create executable JARs.