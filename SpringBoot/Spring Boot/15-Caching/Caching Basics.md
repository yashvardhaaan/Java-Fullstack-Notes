# Caching Basics

## What is Caching?

**Caching** is the process of storing **frequently accessed data** in a temporary, fast storage location so that future requests can be served much faster.

Instead of fetching data repeatedly from a slow source like a database,

the application first checks the cache.

> **In simple words:**
>
> Cache is a temporary storage that keeps frequently used data so it can be accessed quickly.

---

# Why Do We Need Caching?

Suppose your application needs product information.

Without Cache

```
Client

↓

Application

↓

Database

↓

Return Data
```

Every request goes to the database.

Problems

- Slow response
- High database load
- Poor scalability

---

With Cache

```
Client

↓

Application

↓

Cache

↓

Return Data
```

Database is accessed only when necessary.

---

# Real-World Example

Imagine a library.

Without memory,

every student searches the shelves every time.

```
Student

↓

Library Shelf

↓

Find Book
```

With memory,

the librarian remembers popular books.

```
Student

↓

Librarian

↓

Book Ready
```

Cache works in the same way.

---

# How Caching Works

```
Client Request

↓

Check Cache

↓

Data Found?

↓

Yes

↓

Return Data

OR

↓

No

↓

Database

↓

Store in Cache

↓

Return Data
```

---

# Cache Hit

A **Cache Hit** occurs when data is already available in the cache.

```
Request

↓

Cache

↓

Data Found

↓

Response
```

Fast response.

---

# Cache Miss

A **Cache Miss** occurs when data is not available in the cache.

```
Request

↓

Cache

↓

Not Found

↓

Database

↓

Store in Cache

↓

Response
```

Slightly slower because the database is accessed.

---

# Cache Hit vs Cache Miss

| Cache Hit | Cache Miss |
|------------|------------|
| Data found in cache | Data not found in cache |
| Very fast | Slower |
| No database access | Database access required |
| Better performance | Data added to cache after retrieval |

---

# Cache Architecture

```
Client

↓

Application

↓

Cache

↓

Database
```

The application checks the cache before querying the database.

---

# Data Flow

```
Request

↓

Cache

↓

Found?

↓

Yes

↓

Return Data

OR

↓

Database

↓

Update Cache

↓

Return Data
```

---

# Where Can Cache Be Used?

- Product Details
- User Profiles
- Configuration Data
- API Responses
- Frequently Used Queries
- Authentication Information
- Static Content

---

# Types of Cache

## In-Memory Cache

Stored inside the application.

Examples

- ConcurrentHashMap
- Caffeine

```
Application

↓

Memory

↓

Cache
```

---

## Distributed Cache

Shared by multiple applications.

Examples

- Redis
- Memcached

```
Application 1

Application 2

Application 3

↓

Redis
```

---

# Cache Eviction

Cache memory is limited.

Old data must eventually be removed.

```
Cache Full

↓

Remove Old Data

↓

Store New Data
```

---

# Common Eviction Policies

| Policy | Meaning |
|----------|----------|
| LRU | Least Recently Used |
| LFU | Least Frequently Used |
| FIFO | First In First Out |
| TTL | Remove after a fixed time |

---

# Time To Live (TTL)

Every cached item can have an expiration time.

```
Store Data

↓

5 Minutes

↓

Automatically Removed
```

This helps prevent stale data.

---

# Read Through Cache

```
Request

↓

Cache

↓

Not Found

↓

Database

↓

Cache Updated

↓

Response
```

The application automatically loads missing data into the cache.

---

# Write Through Cache

```
Application

↓

Cache

↓

Database
```

Data is written to both cache and database immediately.

---

# Write Back Cache

```
Application

↓

Cache

↓

Immediate Response

↓

Database Updated Later
```

Faster writes but more complex to manage.

---

# Cache Flow

```
Client

↓

Application

↓

Cache

↓

Database (Only if Needed)

↓

Response
```

---

# Advantages of Caching

- Faster response time.
- Reduced database load.
- Better application performance.
- Improved scalability.
- Lower latency.
- Better user experience.

---

# Disadvantages of Caching

- Extra memory usage.
- Data may become stale.
- Cache synchronization is required.
- Additional complexity.

---

# Caching vs Database

| Cache | Database |
|--------|----------|
| Very fast | Slower |
| Temporary storage | Permanent storage |
| Frequently accessed data | Complete data |
| In-memory | Disk-based |

---

# Caching vs Session

| Cache | Session |
|--------|----------|
| Shared application data | User-specific data |
| Improves performance | Maintains user state |
| Can be distributed | Belongs to one user |

---

# Common Mistakes

❌ Caching every piece of data.

❌ Never expiring cached data.

❌ Forgetting to update cache after database changes.

❌ Caching sensitive information without proper security.

❌ Using cache as permanent storage.

---

# Real-World Example

## Banking Application

```
Branch List

↓

Cache

↓

Quick Response
```

---

## E-Commerce Website

```
Product Details

↓

Cache

↓

Faster Product Page
```

---

## Food Delivery App

```
Restaurant Menu

↓

Cache

↓

Instant Loading
```

---

# Best Practices

- Cache frequently accessed data.
- Set appropriate TTL values.
- Remove stale cache when data changes.
- Monitor cache hit ratio.
- Avoid caching sensitive information unless properly secured.
- Use distributed cache for multiple application instances.

---

# Interview Questions

### 1. What is Caching?

Caching is the process of storing frequently accessed data in fast temporary storage to improve performance.

---

### 2. What is a Cache Hit?

A Cache Hit occurs when the requested data is already available in the cache.

---

### 3. What is a Cache Miss?

A Cache Miss occurs when the requested data is not found in the cache, so it must be retrieved from the database.

---

### 4. What is TTL?

TTL (Time To Live) defines how long cached data remains valid before it expires automatically.

---

### 5. What is the difference between Cache and Database?

A cache stores temporary frequently accessed data for fast access, while a database stores permanent application data.

---

### 6. Why should stale cache be avoided?

Because it may return outdated or incorrect information to users.

---

### 7. Which distributed cache is commonly used with Spring Boot?

**Redis** is the most commonly used distributed cache.

---

# Quick Revision

- Caching stores frequently accessed data for faster retrieval.
- The application checks the cache before accessing the database.
- Cache Hit means data is found in cache.
- Cache Miss means data must be fetched from the database.
- Common eviction policies are LRU, LFU, FIFO, and TTL.
- Redis is a popular distributed cache.
- Proper cache expiration prevents stale data.
- Caching improves performance, scalability, and user experience.