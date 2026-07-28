# Logback

## What is Logback?

**Logback** is a **logging framework (implementation)** for Java applications.

It is the **default logging framework used by Spring Boot** and works together with **SLF4J**.

While **SLF4J** provides the logging API,

**Logback** actually writes the log messages to:

- Console
- Log Files
- Rolling Log Files

> **In simple words:**
>
> SLF4J tells Logback what to log, and Logback writes the logs.

---

# Why Do We Need Logback?

Suppose your application receives thousands of requests every minute.

```
Request

↓

Processing

↓

Response
```

You need to know

- Who logged in?
- Which API failed?
- Which SQL query failed?
- When did the application start?

Logback records all these events.

---

# Real-World Example

Imagine a security guard at a company.

Every visitor is recorded in a register.

```
Visitor

↓

Entry

↓

Register

↓

Exit
```

Later,

if something goes wrong,

the company checks the register.

Similarly,

developers check Logback logs.

---

# SLF4J + Logback

```
Application

↓

SLF4J

↓

Logback

↓

Console

OR

↓

Log File
```

---

# Logging Flow

```
logger.info()

↓

SLF4J

↓

Logback

↓

Console/File
```

---

# Default Logging in Spring Boot

No extra dependency is needed.

Spring Boot automatically includes

```
spring-boot-starter-logging
```

which contains

```
SLF4J

+

Logback
```

---

# Default Console Output

Example

```java
logger.info("Application Started");
```

Output

```
2026-07-28

INFO

UserService

Application Started
```

The log usually contains

- Timestamp
- Log Level
- Thread Name
- Class Name
- Message

---

# Logback Configuration File

The default configuration file is

```
logback-spring.xml
```

or

```
logback.xml
```

Spring Boot recommends using

```
logback-spring.xml
```

because it supports Spring features like profiles.

---

# Project Structure

```
src

└── main

    └── resources

        └── logback-spring.xml
```

---

# Simple Configuration

```xml
<configuration>

    <root level="INFO">

        <appender-ref ref="CONSOLE"/>

    </root>

</configuration>
```

This tells Logback

```
Log Level

↓

INFO

↓

Print to Console
```

---

# Log Levels

| Level | Purpose |
|--------|----------|
| TRACE | Very detailed logs |
| DEBUG | Developer debugging |
| INFO | Normal application events |
| WARN | Warning messages |
| ERROR | Errors and exceptions |

---

# Log Level Flow

```
TRACE

↓

DEBUG

↓

INFO

↓

WARN

↓

ERROR
```

If log level is set to

```
INFO
```

Then

```
TRACE

✗
```

```
DEBUG

✗
```

```
INFO

✓
```

```
WARN

✓
```

```
ERROR

✓
```

---

# Console Appender

An **Appender** decides where logs are written.

Console Appender

```
Application

↓

Logback

↓

Console
```

Example

```xml
<appender

        name="CONSOLE"

        class="ch.qos.logback.core.ConsoleAppender">

</appender>
```

---

# File Appender

Instead of printing logs to the console,

Logback can save them to a file.

```
Application

↓

Logback

↓

application.log
```

Example

```xml
<appender

        name="FILE"

        class="ch.qos.logback.core.FileAppender">

</appender>
```

---

# Rolling File Appender

Instead of creating one huge log file,

Logback creates new files automatically.

```
application.log

↓

application-1.log

↓

application-2.log

↓

application-3.log
```

Useful for production applications.

---

# Pattern Layout

Defines how logs appear.

Example

```xml
<pattern>

%d %-5level %logger - %msg%n

</pattern>
```

Sample Output

```
2026-07-28

INFO

UserService

Application Started
```

---

# Example Logging

```java
private static final Logger logger =

        LoggerFactory.getLogger(

                UserService.class

        );

logger.info(

        "User {} logged in",

        userId

);
```

Flow

```
Application

↓

Logger

↓

SLF4J

↓

Logback

↓

Console/File
```

---

# Logging to File

Example

```xml
<property

        name="LOG_FILE"

        value="logs/application.log"/>

```

Result

```
Project

│

└── logs

    └── application.log
```

---

# Logging Exception

```java
try{

    int result = 10 / 0;

}catch(Exception e){

    logger.error(

            "Calculation failed",

            e

    );

}
```

Output contains

- Error message
- Stack trace
- Timestamp

---

# Logback Architecture

```
Application

↓

Logger

↓

SLF4J

↓

Logback

↓

Appender

↓

Console/File
```

---

# Common Appenders

| Appender | Purpose |
|-----------|----------|
| ConsoleAppender | Prints logs to console |
| FileAppender | Writes logs to a file |
| RollingFileAppender | Creates multiple log files automatically |

---

# Logback vs SLF4J

| Logback | SLF4J |
|----------|--------|
| Logging implementation | Logging API |
| Writes logs | Defines logging methods |
| Creates log files | Forwards log requests |
| Default in Spring Boot | Used with Logback |

---

# Logback vs System.out.println()

| Logback | System.out.println() |
|----------|----------------------|
| Supports log levels | No log levels |
| Can write to files | Console only |
| Configurable | Not configurable |
| Production ready | Not recommended |

---

# Common Mistakes

❌ Logging passwords or JWT tokens.

❌ Setting log level to TRACE in production.

❌ Writing every log as ERROR.

❌ Not using RollingFileAppender in production.

❌ Ignoring log file size.

---

# Real-World Example

## Banking Application

```
Money Transfer

↓

INFO Log

↓

Transfer Successful
```

---

## E-Commerce Website

```
Order Created

↓

INFO Log

↓

Order Saved
```

---

## Food Delivery App

```
Payment Failed

↓

ERROR Log

↓

Stack Trace Saved
```

---

# Advantages

- Default logging framework in Spring Boot.
- Highly configurable.
- Supports console and file logging.
- Supports rolling log files.
- Excellent performance.
- Integrates seamlessly with SLF4J.

---

# Best Practices

- Use `logback-spring.xml` in Spring Boot.
- Keep log level as `INFO` in production.
- Use `DEBUG` only during development.
- Never log sensitive information.
- Use RollingFileAppender for production systems.
- Store logs outside the application directory in production.

---

# Interview Questions

### 1. What is Logback?

Logback is a logging framework that implements the SLF4J API and is the default logging framework in Spring Boot.

---

### 2. What is the difference between SLF4J and Logback?

SLF4J is a logging API, while Logback is the implementation that writes logs.

---

### 3. Which configuration file is commonly used in Spring Boot?

```text
logback-spring.xml
```

---

### 4. What is an Appender?

An Appender determines where log messages are written, such as the console or a file.

---

### 5. Why is RollingFileAppender used?

It automatically creates new log files when the current file reaches a size or time limit, preventing a single log file from becoming too large.

---

### 6. Which appender prints logs to the console?

```text
ConsoleAppender
```

---

### 7. Should TRACE logging be enabled in production?

Generally, no. TRACE generates a very large amount of log data and can impact performance.

---

# Quick Revision

- Logback is the default logging implementation in Spring Boot.
- It works together with the SLF4J API.
- Configure Logback using `logback-spring.xml`.
- Appenders determine where logs are written.
- Common appenders are ConsoleAppender, FileAppender, and RollingFileAppender.
- Use INFO for normal production logs and DEBUG for development.
- Never log sensitive information.
- Logback provides flexible, high-performance logging for Spring Boot applications.