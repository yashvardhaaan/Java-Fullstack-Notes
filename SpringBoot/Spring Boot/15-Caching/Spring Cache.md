# Spring Cache

## What is Spring Cache?

**Spring Cache** is a caching abstraction provided by the Spring Framework that makes it easy to cache method results without writing caching logic manually.

Instead of writing cache code yourself,

you simply use annotations like:

- `@Cacheable`
- `@CachePut`
- `@CacheEvict`

Spring automatically manages the cache.

> **In simple words:**
>
> Spring Cache automatically stores the result of a method so that future calls with the same input can return the cached result instead of executing the method again.

---

# Why Do We Need Spring Cache?

Suppose your application fetches product details.

Without Cache

```
Client

↓

Service

↓

Database

↓

Return Product
```

Every request goes to the database.

Problems

- Slow response
- High database load
- Repeated database queries

---

With Spring Cache

```
Client

↓

Service

↓

Cache

↓

Return Product
```

Database is accessed only once.

---

# Real-World Example

Imagine asking your teacher the same question every day.

Without notes

```
Question

↓

Teacher

↓

Answer
```

Every time,

the teacher explains again.

With notes

```
Question

↓

Notebook

↓

Answer
```

You immediately get the answer.

Spring Cache works the same way.

---

# Spring Cache Architecture

```
Client

↓

Service

↓

Spring Cache

↓

Redis

↓

Database
```

Spring Cache sits between your application and the cache provider.

---

# How Spring Cache Works

```
Method Called

↓

Check Cache

↓

Result Found?

↓

Yes

↓

Return Cached Result

OR

↓

Execute Method

↓

Store Result

↓

Return Result
```

---

# Cache Workflow

```
Client Request

↓

Service Method

↓

Spring Cache

↓

Redis / Caffeine

↓

Database (Only if Needed)

↓

Response
```

---

# Enabling Spring Cache

Add the annotation

```java
@EnableCaching
```

Example

```java
@SpringBootApplication

@EnableCaching
public class Application {

}
```

This enables Spring's caching mechanism.

---

# @Cacheable

`@Cacheable` stores the method result in the cache.

Example

```java
@Cacheable("products")
public Product getProduct(

        Long id

){

    return repository.findById(id)

            .orElseThrow();

}
```

Flow

```
Method Call

↓

Cache

↓

Found?

↓

Yes

↓

Return Cached Data

OR

↓

Database

↓

Store in Cache

↓

Return Data
```

---

# First Request

```
Client

↓

getProduct(1)

↓

Database

↓

Cache Updated

↓

Response
```

---

# Second Request

```
Client

↓

getProduct(1)

↓

Cache

↓

Immediate Response
```

No database query is executed.

---

# @CachePut

`@CachePut` always executes the method and updates the cache.

Example

```java
@CachePut(

        value = "products",

        key = "#product.id"

)
public Product update(

        Product product

){

    return repository.save(product);

}
```

Flow

```
Update Product

↓

Database Updated

↓

Cache Updated
```

---

# @CacheEvict

Removes data from the cache.

Example

```java
@CacheEvict(

        value = "products",

        key = "#id"

)
public void delete(

        Long id

){

    repository.deleteById(id);

}
```

Flow

```
Delete Product

↓

Database

↓

Remove Cache
```

---

# Clear Entire Cache

```java
@CacheEvict(

        value = "products",

        allEntries = true

)
public void clearCache(){

}
```

All cached products are removed.

---

# Cache Keys

Every cached value has a key.

Example

```
products

↓

Key = 1

↓

Product Object
```

Custom key

```java
@Cacheable(

        value = "products",

        key = "#id"

)
```

---

# Cache Flow

```
Method Call

↓

Cache Key

↓

Cache Lookup

↓

Hit?

↓

Yes

↓

Return Cached Data

OR

↓

Execute Method

↓

Update Cache
```

---

# Spring Cache Providers

Spring Cache supports multiple cache implementations.

Common providers

- Redis
- Caffeine
- Ehcache
- Hazelcast
- ConcurrentHashMap (Simple Cache)

---

# Spring Cache with Redis

```
Client

↓

Service

↓

Spring Cache

↓

Redis

↓

Database
```

Redis stores the cached data.

---

# Common Cache Annotations

| Annotation | Purpose |
|------------|----------|
| `@EnableCaching` | Enables caching |
| `@Cacheable` | Reads from cache or stores result |
| `@CachePut` | Updates cache |
| `@CacheEvict` | Removes cache |

---

# Spring Cache vs Redis

| Spring Cache | Redis |
|---------------|--------|
| Caching abstraction | Cache implementation |
| Uses annotations | Stores data |
| Provider independent | One cache provider |

---

# Spring Cache vs Manual Caching

| Spring Cache | Manual Cache |
|---------------|--------------|
| Annotation-based | Custom code |
| Less boilerplate | More code |
| Easy maintenance | Harder to maintain |
| Provider independent | Tightly coupled |

---

# Common Use Cases

- Product Details
- User Profiles
- Configuration Data
- Frequently Used Queries
- Dashboard Data
- API Responses

---

# Common Mistakes

❌ Forgetting `@EnableCaching`.

❌ Never clearing stale cache.

❌ Caching frequently changing data.

❌ Using very large objects as cache values.

❌ Ignoring cache expiration.

---

# Real-World Example

## Banking Application

```
Branch Details

↓

Spring Cache

↓

Redis

↓

Fast Response
```

---

## E-Commerce Website

```
Product Details

↓

Spring Cache

↓

Redis

↓

Instant Loading
```

---

## Food Delivery App

```
Restaurant Menu

↓

Spring Cache

↓

Redis

↓

Quick Response
```

---

# Advantages

- Simple annotation-based caching.
- Reduces database load.
- Improves application performance.
- Easy integration with Redis.
- Provider independent.
- Minimal code changes.

---

# Best Practices

- Enable caching using `@EnableCaching`.
- Cache only frequently accessed data.
- Use meaningful cache names.
- Remove cache when data changes.
- Configure TTL for cached data.
- Monitor cache hit ratio.
- Use Redis for distributed applications.

---

# Interview Questions

### 1. What is Spring Cache?

Spring Cache is a caching abstraction that allows developers to cache method results using annotations.

---

### 2. What does `@EnableCaching` do?

It enables Spring's caching support.

---

### 3. What is the purpose of `@Cacheable`?

It stores the result of a method in the cache and returns the cached value for subsequent calls with the same key.

---

### 4. What is the difference between `@CachePut` and `@Cacheable`?

- `@Cacheable` skips method execution if cached data exists.
- `@CachePut` always executes the method and updates the cache.

---

### 5. What does `@CacheEvict` do?

It removes one or more entries from the cache.

---

### 6. Does Spring Cache store data by itself?

No.

Spring Cache is only a caching abstraction. Actual storage is handled by providers such as Redis, Caffeine, or Ehcache.

---

### 7. Which cache provider is commonly used in Spring Boot production applications?

**Redis** is the most commonly used distributed cache provider.

---

# Quick Revision

- Spring Cache is a caching abstraction provided by Spring.
- Enable caching using `@EnableCaching`.
- `@Cacheable` reads from or stores data in the cache.
- `@CachePut` updates the cache.
- `@CacheEvict` removes cache entries.
- Spring Cache works with providers like Redis and Caffeine.
- Cache frequently accessed data to improve performance.
- Always invalidate or update cache when underlying data changes.