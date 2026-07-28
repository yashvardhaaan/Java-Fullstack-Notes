# HikariCP

## What is HikariCP?

**HikariCP** is a **high-performance JDBC Connection Pool** used by Spring Boot to efficiently manage database connections.

It is the **default connection pool** in Spring Boot because it is:

- Fast
- Lightweight
- Reliable
- Memory Efficient

> **In simple words:**
>
> HikariCP maintains a pool of ready-to-use database connections so your application doesn't have to create a new connection for every request.

---

# Why Do We Need HikariCP?

Suppose 100 users access your application simultaneously.

Without Connection Pool

```
User 1

↓

Create Connection

↓

Database

↓

Close Connection

----------------------

User 2

↓

Create Connection

↓

Database

↓

Close Connection
```

Every request creates and closes a database connection.

Problems

- Slow performance
- High CPU usage
- Increased database load

---

With HikariCP

```
Users

↓

HikariCP

↓

Connection Pool

↓

Database
```

Connections are reused instead of recreated.

---

# Real-World Example

Imagine a taxi stand.

Without Pool

```
Customer

↓

Buy New Taxi

↓

Travel

↓

Discard Taxi
```

Very expensive and slow.

With Pool

```
Customer

↓

Taxi Stand

↓

Take Taxi

↓

Return Taxi

↓

Next Customer Uses Same Taxi
```

HikariCP works exactly like the taxi stand.

---

# Connection Pool Architecture

```
Client

↓

Spring Boot

↓

HikariCP

↓

Connection Pool

↓

Database
```

---

# How HikariCP Works

```
Application Request

↓

Request Connection

↓

Connection Pool

↓

Available?

↓

Yes

↓

Use Connection

↓

Return Connection

↓

Pool
```

Connections are reused instead of destroyed.

---

# Connection Lifecycle

```
Application

↓

Borrow Connection

↓

Execute SQL

↓

Return Connection

↓

Pool
```

The connection remains open inside the pool for future requests.

---

# Why is Connection Pool Faster?

Creating a database connection is expensive.

```
Create Connection

↓

Authentication

↓

Network

↓

Session Creation
```

This process takes time.

Using HikariCP

```
Ready Connection

↓

Immediate Use
```

No setup cost for every request.

---

# Spring Boot Default Connection Pool

From Spring Boot 2.x onwards,

HikariCP is the default implementation.

```
Spring Boot

↓

HikariCP

↓

Database
```

No additional dependency is required in most Spring Boot projects.

---

# Maven Dependency

Usually included automatically through:

```xml
<dependency>

    <groupId>

        org.springframework.boot

    </groupId>

    <artifactId>

        spring-boot-starter-data-jpa</artifactId>

</dependency>
```

If needed explicitly:

```xml
<dependency>

    <groupId>

        com.zaxxer

    </groupId>

    <artifactId>

        HikariCP

    </artifactId>

</dependency>
```

---

# Basic Configuration

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/shop

spring.datasource.username=root

spring.datasource.password=password
```

Spring Boot automatically configures HikariCP.

---

# HikariCP Configuration

```properties
spring.datasource.hikari.maximum-pool-size=10

spring.datasource.hikari.minimum-idle=5

spring.datasource.hikari.connection-timeout=30000

spring.datasource.hikari.idle-timeout=600000

spring.datasource.hikari.max-lifetime=1800000
```

---

# Important Properties

| Property | Purpose |
|----------|---------|
| maximum-pool-size | Maximum number of connections |
| minimum-idle | Minimum idle connections |
| connection-timeout | Time to wait for a connection |
| idle-timeout | Close idle connections after this time |
| max-lifetime | Maximum lifetime of a connection |

---

# Request Flow

```
HTTP Request

↓

Service

↓

Repository

↓

HikariCP

↓

Database

↓

Return Connection

↓

Pool
```

---

# Connection Pool Example

Pool Size = 5

```
Pool

│

├── Connection 1

├── Connection 2

├── Connection 3

├── Connection 4

└── Connection 5
```

When a request arrives:

```
Request

↓

Connection 2 Borrowed

↓

Execute Query

↓

Connection Returned
```

---

# What Happens When the Pool is Full?

```
Pool Full

↓

New Request

↓

Wait

↓

Connection Available

↓

Continue
```

If no connection becomes available within the timeout,

an exception is thrown.

---

# HikariCP vs No Connection Pool

| HikariCP | No Pool |
|-----------|----------|
| Reuses connections | Creates new connection every request |
| Fast | Slow |
| Lower database load | Higher database load |
| Better scalability | Poor scalability |

---

# HikariCP vs Other Connection Pools

| HikariCP | Apache DBCP | C3P0 |
|-----------|-------------|-------|
| Very Fast | Moderate | Slower |
| Lightweight | Moderate | Heavy |
| Default in Spring Boot | No | No |
| Excellent performance | Good | Good |

---

# Common Use Cases

- Spring Boot REST APIs
- Banking Applications
- E-Commerce Systems
- Microservices
- Enterprise Applications
- High-Traffic Websites

---

# Common Mistakes

❌ Setting the pool size too large.

❌ Setting the pool size too small.

❌ Not closing database resources properly.

❌ Ignoring connection timeout settings.

❌ Keeping transactions open for too long, causing connections to remain occupied.

---

# Real-World Example

## Banking Application

```
Money Transfer

↓

Borrow Connection

↓

Update Database

↓

Return Connection
```

---

## E-Commerce Website

```
Order Request

↓

Connection Pool

↓

Database

↓

Return Connection
```

---

## Food Delivery App

```
Place Order

↓

Connection Pool

↓

Restaurant Database

↓

Connection Returned
```

---

# Advantages

- Extremely fast.
- Efficient connection reuse.
- Reduces database overhead.
- Better scalability.
- Low memory usage.
- Default in Spring Boot.

---

# Best Practices

- Use the default HikariCP unless you have a specific reason to change it.
- Configure an appropriate maximum pool size based on your database capacity.
- Keep database transactions short.
- Monitor connection pool usage in production.
- Avoid connection leaks by properly completing database operations.
- Tune timeout values according to application requirements.

---

# Interview Questions

### 1. What is HikariCP?

HikariCP is a high-performance JDBC connection pool used by Spring Boot to efficiently manage database connections.

---

### 2. Why is HikariCP used?

It improves application performance by reusing database connections instead of creating a new connection for every request.

---

### 3. Is HikariCP the default connection pool in Spring Boot?

Yes.

Spring Boot uses HikariCP as its default connection pool.

---

### 4. What is `maximum-pool-size`?

It defines the maximum number of database connections that HikariCP can maintain.

---

### 5. What happens when all connections are busy?

New requests wait for an available connection until the configured `connection-timeout` is reached.

---

### 6. Why is creating database connections expensive?

Because it involves network communication, authentication, session creation, and resource allocation.

---

### 7. What are the benefits of using HikariCP?

High performance, efficient connection reuse, lower database load, faster response times, and excellent scalability.

---

# Quick Revision

- HikariCP is Spring Boot's default JDBC connection pool.
- It manages and reuses database connections.
- Connection pooling improves performance and scalability.
- Important properties include `maximum-pool-size`, `minimum-idle`, `connection-timeout`, `idle-timeout`, and `max-lifetime`.
- HikariCP reduces the cost of creating database connections.
- Keep transactions short to avoid exhausting the connection pool.
- HikariCP is widely used in production Spring Boot applications.