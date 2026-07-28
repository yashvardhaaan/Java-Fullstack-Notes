# Logging Best Practices

## What are Logging Best Practices?

**Logging Best Practices** are guidelines that help developers write **useful, secure, and efficient log messages**.

Good logging makes applications easier to:

- Debug
- Monitor
- Maintain
- Troubleshoot

Poor logging can make production issues difficult to identify and may even expose sensitive information.

> **In simple words:**
>
> Logging Best Practices help you write logs that are useful without affecting security or performance.

---

# Why Do We Need Good Logging?

Imagine an application crashes in production.

Without logs

```
Application Error

↓

No Information

↓

Difficult to Find Problem
```

With good logs

```
Application Error

↓

Logs Available

↓

Identify Root Cause

↓

Fix Issue
```

---

# Real-World Example

Think about the black box in an airplane.

```
Flight

↓

Events Recorded

↓

Accident Investigation

↓

Root Cause Found
```

Similarly,

logs help developers understand what happened inside an application.

---

# Good Logging Flow

```
User Request

↓

Application

↓

Business Logic

↓

Log Important Events

↓

Response
```

---

# Log Important Events

Good examples

- Application Started
- User Logged In
- Order Created
- Payment Successful
- Exception Occurred

Example

```java
logger.info(

        "Order {} created successfully",

        orderId

);
```

---

# Do NOT Log Everything

Bad

```java
logger.info("Method Started");

logger.info("Variable Created");

logger.info("Loop Started");

logger.info("Loop Ended");
```

Too many unnecessary logs make debugging difficult.

Instead,

log only meaningful events.

---

# Use Appropriate Log Levels

| Level | When to Use |
|--------|-------------|
| TRACE | Detailed execution flow |
| DEBUG | Debugging during development |
| INFO | Normal business events |
| WARN | Recoverable or unexpected situations |
| ERROR | Exceptions and failures |

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

Choose the correct level for each message.

---

# Never Use System.out.println()

Avoid

```java
System.out.println(

        "User Logged In"

);
```

Instead

```java
logger.info(

        "User Logged In"

);
```

Benefits

- Configurable
- Supports log levels
- Better performance
- Production ready

---

# Use Placeholders

Avoid

```java
logger.info(

        "User Id = " + userId

);
```

Preferred

```java
logger.info(

        "User Id = {}",

        userId

);
```

Advantages

- Better performance
- Cleaner code
- Easier to read

---

# Log Exceptions Properly

Avoid

```java
catch(Exception e){

    logger.error("Error");

}
```

The exception details are lost.

Preferred

```java
catch(Exception e){

    logger.error(

            "Payment failed",

            e

    );

}
```

This logs

- Error message
- Stack trace

---

# Never Log Sensitive Information

❌ Avoid logging

- Passwords
- JWT Tokens
- API Keys
- Credit Card Numbers
- OTPs
- Secret Keys

Bad

```java
logger.info(

        "Password = {}",

        password

);
```

Good

```java
logger.info(

        "User {} logged in",

        username

);
```

---

# Write Meaningful Messages

Bad

```java
logger.info("Done");
```

Good

```java
logger.info(

        "Order {} created successfully",

        orderId

);
```

The second message clearly explains what happened.

---

# Include Business Context

Instead of

```java
logger.error("Payment Failed");
```

Write

```java
logger.error(

        "Payment failed for Order {}",

        orderId

);
```

Now the log is much more useful.

---

# Don't Duplicate Logs

Bad

```java
logger.error("Error");

throw e;

logger.error("Error Again");
```

The same exception gets logged multiple times.

Log it only where it is handled.

---

# Use DEBUG for Development

Development

```java
logger.debug(

        "Fetched {} records",

        records.size()

);
```

Production

```
DEBUG

↓

Usually Disabled
```

This avoids unnecessary log volume.

---

# Keep INFO Logs Clean

INFO logs should describe important business events.

Example

```java
logger.info(

        "User {} placed Order {}",

        userId,

        orderId

);
```

Avoid logging every small internal operation at INFO level.

---

# Log Request Processing

Example

```
Request Received

↓

Business Logic

↓

Response Sent

↓

INFO Log
```

This helps trace application activity.

---

# Logging Flow in Production

```
Application

↓

SLF4J

↓

Logback

↓

Console

↓

Log File

↓

Monitoring System
```

---

# Use Correlation IDs

In distributed systems,

multiple services may handle one request.

```
Request

↓

Service A

↓

Service B

↓

Service C
```

A **Correlation ID** helps track the same request across all services.

Example

```
Request ID

↓

12345

↓

Appears in Every Log
```

This makes debugging much easier.

---

# Rotate Log Files

Instead of one huge file

```
application.log

↓

10 GB
```

Use rolling logs

```
application.log

↓

application-1.log

↓

application-2.log
```

This improves storage management.

---

# Logging Best Practices Flow

```
Meaningful Event

↓

Choose Correct Log Level

↓

Avoid Sensitive Data

↓

Write Clear Message

↓

Store Log

↓

Monitor
```

---

# Good vs Bad Logging

| Good Logging | Bad Logging |
|--------------|-------------|
| Meaningful messages | Generic messages |
| Correct log level | Everything logged as ERROR |
| Uses placeholders | String concatenation |
| Logs exceptions with stack trace | Ignores exception details |
| Avoids sensitive data | Logs passwords and tokens |

---

# Logging vs Monitoring

| Logging | Monitoring |
|----------|------------|
| Records events | Observes application health |
| Useful for debugging | Useful for performance tracking |
| Text-based | Metric-based |

---

# Common Mistakes

❌ Logging passwords.

❌ Logging JWT tokens.

❌ Using `System.out.println()`.

❌ Logging everything at INFO level.

❌ Ignoring exceptions.

❌ Writing unclear messages.

❌ Logging the same exception multiple times.

---

# Real-World Example

## Banking Application

Good

```
Money Transfer

↓

INFO

↓

Transfer Successful

↓

Transaction ID Logged
```

---

## E-Commerce Website

Good

```
Order Created

↓

INFO

↓

Order ID Logged
```

---

## Food Delivery App

Good

```
Payment Failed

↓

ERROR

↓

Stack Trace Logged
```

---

# Advantages

- Faster debugging.
- Easier production monitoring.
- Better troubleshooting.
- Improved application security.
- Cleaner log files.
- Easier root cause analysis.

---

# Best Practices

- Use SLF4J with Logback.
- Select the correct log level.
- Use placeholders `{}`.
- Never log sensitive information.
- Log exceptions with stack traces.
- Keep INFO logs meaningful.
- Enable DEBUG only during development.
- Use rolling log files in production.
- Include correlation IDs in distributed systems.
- Regularly review and clean logging configurations.

---

# Interview Questions

### 1. Why should `System.out.println()` not be used in production?

Because it has no log levels, cannot be configured, cannot write to managed log files, and is not suitable for production environments.

---

### 2. Which log level should be used for normal business events?

```text
INFO
```

---

### 3. Why should placeholders `{}` be used instead of string concatenation?

They improve performance and readability by avoiding unnecessary string creation when a log level is disabled.

---

### 4. Should passwords or JWT tokens be logged?

No.

Sensitive information should never be written to logs.

---

### 5. Why should exceptions be logged with the exception object?

Passing the exception object records the complete stack trace, making debugging much easier.

---

### 6. What is a Correlation ID?

A Correlation ID is a unique identifier attached to a request so it can be traced across multiple services in a distributed system.

---

### 7. Why are rolling log files recommended?

They prevent log files from growing indefinitely and make storage and log management easier.

---

# Quick Revision

- Write meaningful log messages.
- Use appropriate log levels (TRACE, DEBUG, INFO, WARN, ERROR).
- Never use `System.out.println()` in production.
- Use placeholders `{}` instead of string concatenation.
- Never log passwords, tokens, or secret keys.
- Log exceptions with stack traces.
- Use rolling log files.
- Include Correlation IDs in distributed applications.
- Keep logs clean, useful, and secure.