# Redis

## What is Redis?

**Redis (Remote Dictionary Server)** is an **open-source, in-memory data store** used as a:

- Cache
- Database
- Message Broker

Redis stores data in **RAM (Memory)** instead of disk, making it extremely fast.

It is commonly used in Spring Boot applications to improve performance.

> **In simple words:**
>
> Redis is a super-fast memory storage that keeps frequently used data so applications don't have to query the database every time.

---

# Why Do We Need Redis?

Suppose users repeatedly request product information.

Without Redis

```
Client

↓

Application

↓

Database

↓

Return Product
```

Every request reaches the database.

Problems

- Slow response
- High database load
- Poor scalability

---

With Redis

```
Client

↓

Application

↓

Redis

↓

Return Product
```

Database is accessed only when needed.

---

# Real-World Example

Imagine your study desk.

Frequently used books are kept on the desk.

```
Need Book

↓

Desk

↓

Immediate Access
```

Rarely used books remain in the bookshelf.

```
Need Rare Book

↓

Bookshelf

↓

More Time
```

Redis acts like the study desk.

---

# Redis Architecture

```
Client

↓

Spring Boot

↓

Redis

↓

Database
```

Redis sits between the application and the database.

---

# How Redis Works

```
Client Request

↓

Check Redis

↓

Data Found?

↓

Yes

↓

Return Data

OR

↓

Database

↓

Store in Redis

↓

Return Data
```

---

# Why is Redis Fast?

Redis stores data in **RAM**.

```
RAM

↓

Very Fast Access
```

Database stores data on disk.

```
Disk

↓

Slower Access
```

Memory access is much faster than disk access.

---

# Data Flow

```
Client

↓

Application

↓

Redis

↓

Database (Only if Needed)

↓

Response
```

---

# Redis Data Structures

Redis supports many data types.

| Data Type | Purpose |
|------------|----------|
| String | Text, numbers |
| List | Ordered collection |
| Set | Unique values |
| Hash | Key-Value pairs |
| Sorted Set | Ranked data |
| Stream | Event streaming |

---

# String Example

```
Key

↓

user:1

↓

Value

↓

Yash
```

---

# Hash Example

```
User

│

├── Name

├── Email

└── Age
```

Redis Hash

```
user:1

↓

name = Yash

email = yash@example.com

age = 21
```

---

# List Example

```
Recent Searches

↓

Java

↓

Spring

↓

Redis
```

---

# Set Example

```
User Roles

↓

ADMIN

USER

MANAGER
```

Duplicate values are not allowed.

---

# Sorted Set Example

```
Leaderboard

↓

Alice - 500

Bob - 450

John - 300
```

Sorted automatically based on score.

---

# Redis Expiration (TTL)

Every key can have an expiration time.

```
Store Data

↓

10 Minutes

↓

Automatically Removed
```

Useful for temporary data.

---

# Cache Hit

```
Request

↓

Redis

↓

Found

↓

Response
```

Fast.

---

# Cache Miss

```
Request

↓

Redis

↓

Not Found

↓

Database

↓

Store in Redis

↓

Response
```

---

# Spring Boot Dependency

```xml
<dependency>

    <groupId>

        org.springframework.boot

    </groupId>

    <artifactId>

        spring-boot-starter-data-redis

    </artifactId>

</dependency>
```

---

# Redis Configuration

```properties
spring.data.redis.host=localhost

spring.data.redis.port=6379
```

---

# RedisTemplate

Spring Boot uses

```java
RedisTemplate
```

to communicate with Redis.

Example

```java
@Autowired
private RedisTemplate<String, Object> redisTemplate;
```

---

# Save Data

```java
redisTemplate.opsForValue()

        .set(

                "user",

                "Yash"

        );
```

Flow

```
Application

↓

RedisTemplate

↓

Redis

↓

Store Value
```

---

# Read Data

```java
Object value =

        redisTemplate

        .opsForValue()

        .get("user");
```

Flow

```
Redis

↓

Read Value

↓

Application
```

---

# Setting Expiration Time

```java
redisTemplate.opsForValue()

        .set(

                "otp",

                "123456",

                Duration.ofMinutes(5)

        );
```

After 5 minutes,

the key is automatically removed.

---

# Redis Request Flow

```
Client

↓

Application

↓

Redis

↓

Return Data

OR

↓

Database

↓

Redis Updated

↓

Response
```

---

# Redis Features

- Extremely Fast
- In-Memory Storage
- Key-Value Database
- Supports TTL
- Multiple Data Structures
- High Performance
- Easy Scalability

---

# Redis vs Database

| Redis | Database |
|--------|----------|
| Memory-based | Disk-based |
| Very fast | Slower |
| Temporary storage | Permanent storage |
| Frequently accessed data | Complete application data |

---

# Redis vs HashMap

| Redis | HashMap |
|--------|----------|
| Shared across applications | Exists only inside one JVM |
| Can expire data | No automatic expiration |
| Supports persistence | Memory only |
| Accessible over network | Local application only |

---

# Redis vs Memcached

| Redis | Memcached |
|--------|------------|
| Multiple data structures | Key-Value only |
| Supports persistence | Memory only |
| TTL support | TTL support |
| Rich feature set | Simpler cache |

---

# Common Use Cases

- API Response Caching
- User Sessions
- OTP Storage
- Product Details
- Shopping Cart
- Leaderboards
- Rate Limiting
- Token Storage

---

# Common Mistakes

❌ Using Redis as the primary database for all data.

❌ Never setting expiration for temporary data.

❌ Storing huge objects unnecessarily.

❌ Ignoring cache invalidation.

❌ Not securing the Redis server.

---

# Real-World Example

## Banking Application

```
Branch Information

↓

Redis

↓

Fast Lookup
```

---

## E-Commerce Website

```
Product Details

↓

Redis

↓

Quick Product Page
```

---

## Food Delivery App

```
Restaurant Menu

↓

Redis

↓

Instant Response
```

---

# Advantages

- Extremely fast.
- Reduces database load.
- Improves application performance.
- Supports multiple data structures.
- Built-in expiration (TTL).
- Easy integration with Spring Boot.

---

# Best Practices

- Cache frequently accessed data.
- Set TTL for temporary data.
- Remove cache when database data changes.
- Keep cached objects small.
- Secure Redis in production.
- Monitor memory usage.

---

# Interview Questions

### 1. What is Redis?

Redis is an open-source in-memory data store commonly used as a cache, database, and message broker.

---

### 2. Why is Redis faster than a database?

Because Redis stores data in RAM, while traditional databases primarily store data on disk.

---

### 3. Which Spring Boot class is commonly used to interact with Redis?

```java
RedisTemplate
```

---

### 4. What is TTL in Redis?

TTL (Time To Live) specifies how long a key remains in Redis before it expires automatically.

---

### 5. What are some common Redis data structures?

- String
- List
- Set
- Hash
- Sorted Set
- Stream

---

### 6. What is the difference between Redis and HashMap?

HashMap exists only within a single JVM, while Redis is a network-accessible in-memory data store that can be shared across multiple applications.

---

### 7. Can Redis be used as a cache in Spring Boot?

Yes.

Redis is one of the most commonly used distributed caching solutions in Spring Boot applications.

---

# Quick Revision

- Redis is an in-memory data store used mainly for caching.
- It stores data in RAM, making it extremely fast.
- Spring Boot integrates Redis using `spring-boot-starter-data-redis`.
- `RedisTemplate` is commonly used to read and write data.
- Redis supports Strings, Hashes, Lists, Sets, Sorted Sets, and Streams.
- TTL automatically removes expired keys.
- Redis reduces database load and improves application performance.
- Redis is widely used for caching, sessions, OTPs, and leaderboards.