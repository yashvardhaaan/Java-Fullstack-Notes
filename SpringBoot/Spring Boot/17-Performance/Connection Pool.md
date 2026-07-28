# Connection Pool

## What is a Connection Pool?

A **Connection Pool** is a cache of **pre-created database connections** that can be reused by multiple requests instead of creating a new connection every time.

> **In simple words:**
>
> Instead of creating a new database connection for every request, the application borrows one from the pool and returns it after use.

---

# Why Do We Need a Connection Pool?

Creating a database connection is expensive because it involves:

- Network communication
- Authentication
- Memory allocation
- Database session creation

Without a connection pool, every request creates a new connection, making the application slow.

---

# Without Connection Pool

```
Request 1

↓

Create Connection

↓

Database

↓

Close Connection

---------------------

Request 2

↓

Create Connection

↓

Database

↓

Close Connection
```

Problems

- Slow performance
- High CPU usage
- Increased database load

---

# With Connection Pool

```
Application Starts

↓

Create 10 Connections

↓

Connection Pool

↓

Request

↓

Borrow Connection

↓

Database

↓

Return Connection

↓

Pool
```

Connections are reused instead of recreated.

---

# Real-World Example

Imagine a taxi stand.

Without Pool

```
Customer

↓

Buy New Car

↓

Travel

↓

Discard Car
```

Very expensive.

---

With Pool

```
Customer

↓

Take Taxi

↓

Travel

↓

Return Taxi

↓

Next Customer Uses Same Taxi
```

A Connection Pool works exactly like the taxi stand.

---

# How Connection Pool Works

```
Application Starts

↓

Create Pool

↓

Incoming Request

↓

Borrow Connection

↓

Execute SQL

↓

Return Connection

↓

Available for Next Request
```

---

# Spring Boot Architecture

```
Client

↓

Controller

↓

Service

↓

Repository

↓

Connection Pool

↓

Database
```

---

# Lifecycle

```
Application Starts

↓

Create Pool

↓

Wait for Requests

↓

Borrow Connection

↓

Execute Query

↓

Return Connection

↓

Application Stops

↓

Close All Connections
```

---

# HikariCP

Spring Boot uses **HikariCP** as the default connection pool.

Features

- Extremely fast
- Lightweight
- Low memory usage
- Production ready
- Automatically configured

---

# Default Flow

```
Spring Boot

↓

HikariCP

↓

Database

↓

Execute Query

↓

Return Connection
```

---

# Configuration

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/shop

spring.datasource.username=root

spring.datasource.password=password

spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
```

Spring Boot automatically creates the connection pool.

---

# Pool Configuration

```properties
spring.datasource.hikari.maximum-pool-size=20

spring.datasource.hikari.minimum-idle=5

spring.datasource.hikari.connection-timeout=30000

spring.datasource.hikari.idle-timeout=600000

spring.datasource.hikari.max-lifetime=1800000
```

---

# Important Properties

## maximum-pool-size

Maximum number of connections.

Example

```
Maximum Pool Size = 20
```

Only 20 database connections can exist simultaneously.

---

## minimum-idle

Minimum idle connections maintained.

```
Idle Connections

↓

Always Keep

5 Ready
```

---

## connection-timeout

Maximum waiting time to get a connection.

Example

```
30 Seconds

↓

No Connection Available

↓

Exception
```

---

## idle-timeout

How long an unused connection stays in the pool before being removed.

---

## max-lifetime

Maximum lifetime of a connection before it is replaced with a fresh one.

---

# Request Flow

```
Request

↓

Connection Pool

↓

Borrow Connection

↓

Database

↓

Return Connection

↓

Pool
```

---

# Without vs With Connection Pool

| Without Pool | With Pool |
|--------------|-----------|
| New connection every request | Reuses existing connections |
| Slow | Fast |
| High CPU usage | Low CPU usage |
| High database load | Optimized database usage |
| Poor scalability | Better scalability |

---

# Common Use Cases

- Banking Applications
- E-Commerce Platforms
- Social Media Applications
- Hospital Management Systems
- Airline Reservation Systems
- Enterprise Applications

---

# Advantages

- Faster database access.
- Better application performance.
- Reduces database overhead.
- Improves scalability.
- Efficient resource utilization.
- Lower response time.

---

# Disadvantages

- Consumes memory for idle connections.
- Incorrect configuration can reduce performance.
- Pool exhaustion may occur if connections are not returned properly.

---

# Common Mistakes

❌ Setting the pool size too high.

❌ Setting the pool size too low.

❌ Forgetting to close connections in manual JDBC code.

❌ Holding database connections for a long time.

❌ Ignoring pool monitoring in production.

---

# Best Practices

- Use the default HikariCP unless there is a strong reason to change it.
- Choose the pool size based on your application's workload and database capacity.
- Keep database operations fast.
- Avoid long-running transactions.
- Monitor connection pool metrics in production.
- Always release database connections promptly.

---

# Interview Questions

### 1. What is a Connection Pool?

A Connection Pool is a collection of reusable database connections that improves performance by avoiding the cost of creating a new connection for every request.

---

### 2. Why is a Connection Pool required?

Creating database connections is expensive. A Connection Pool reuses existing connections, reducing latency and improving scalability.

---

### 3. Which Connection Pool does Spring Boot use by default?

**HikariCP**

---

### 4. What happens when all connections are busy?

New requests wait until a connection becomes available. If the wait exceeds the configured `connection-timeout`, an exception is thrown.

---

### 5. What is `maximum-pool-size`?

It defines the maximum number of database connections that can exist in the pool.

---

### 6. What is `minimum-idle`?

It specifies the minimum number of idle (ready-to-use) connections that the pool should maintain.

---

### 7. Why shouldn't the pool size be extremely large?

A very large pool can overload the database server, consume unnecessary memory, and reduce overall performance instead of improving it.

---

# Quick Revision

- A Connection Pool stores reusable database connections.
- Spring Boot uses **HikariCP** by default.
- Requests borrow a connection, execute SQL, and return it to the pool.
- Connection Pooling improves performance and scalability.
- Important properties include `maximum-pool-size`, `minimum-idle`, `connection-timeout`, `idle-timeout`, and `max-lifetime`.
- Configure the pool based on application workload and database capacity.
- Monitor pool usage in production to avoid bottlenecks.