# Performance Tuning

## What is Performance Tuning?

**Performance Tuning** is the process of improving an application's **speed, scalability, resource usage, and overall efficiency**.

The goal is to make the application:

- Faster
- More scalable
- More responsive
- More efficient

Performance tuning is done at multiple levels:

- Database
- Backend
- Network
- JVM
- Application
- Infrastructure

> **In simple words:**
>
> Performance tuning means finding bottlenecks in your application and optimizing them so users get faster responses.

---

# Why Do We Need Performance Tuning?

Imagine an E-Commerce application.

Thousands of users visit during a sale.

Without Optimization

```
Users

↓

Application

↓

Slow Database

↓

Slow Response
```

Problems

- Slow APIs
- Timeouts
- High CPU usage
- Poor user experience

---

With Performance Tuning

```
Users

↓

Optimized Application

↓

Optimized Database

↓

Fast Response
```

The application handles more users efficiently.

---

# Real-World Example

Imagine a highway.

Without optimization

```
One Lane

↓

Traffic Jam

↓

Slow Vehicles
```

After widening the road

```
Multiple Lanes

↓

Smooth Traffic

↓

Fast Travel
```

Performance tuning works in the same way.

---

# Performance Tuning Layers

```
Client

↓

Network

↓

Spring Boot

↓

Business Logic

↓

Database

↓

Storage
```

Each layer can become a bottleneck.

---

# Common Performance Bottlenecks

```
Slow SQL Queries

Large API Responses

Too Many Database Calls

No Caching

Blocking Operations

Memory Leaks

Thread Contention

Poor Algorithms
```

---

# Performance Tuning Process

```
Measure Performance

↓

Identify Bottleneck

↓

Optimize

↓

Test Again

↓

Deploy
```

Never optimize without measuring first.

---

# Database Optimization

Most applications spend a large amount of time accessing the database.

Optimize by:

- Creating indexes
- Writing efficient SQL
- Avoiding unnecessary joins
- Reducing database calls
- Solving the N+1 Query Problem

Example

```
Slow Query

↓

Index Added

↓

Fast Query
```

---

# Connection Pool Optimization

Use HikariCP.

```
Application

↓

Connection Pool

↓

Database
```

Instead of creating new connections repeatedly.

---

# Caching

Store frequently used data.

```
Client

↓

Redis

↓

Database
```

Cache reduces database load.

---

# Pagination

Avoid loading huge datasets.

Bad

```java
findAll();
```

Good

```java
Page<Product> products =

        repository.findAll(

                pageable

        );
```

Flow

```
Database

↓

20 Records

↓

Response
```

Instead of

```
1 Million Records
```

---

# Lazy Loading

Load related data only when needed.

```
Customer

↓

Orders

↓

Load Only If Required
```

This reduces unnecessary queries.

---

# DTO Projection

Instead of returning entire entities,

return only required fields.

Bad

```
Customer Entity

↓

50 Fields
```

Good

```
CustomerDTO

↓

5 Fields
```

Smaller responses improve performance.

---

# Asynchronous Processing

Move long-running tasks to background threads.

```
Request

↓

Save Data

↓

Response

↓

Background

↓

Send Email
```

Improves response time.

---

# Thread Pool

Reuse threads instead of creating new ones.

```
Tasks

↓

Thread Pool

↓

Workers

↓

Completed
```

---

# JVM Optimization

Common JVM tuning techniques

- Choose appropriate heap size
- Monitor garbage collection
- Reduce object creation
- Avoid memory leaks

```
Application

↓

JVM

↓

Heap

↓

Garbage Collector
```

---

# API Optimization

Improve REST APIs by:

- Returning only required fields
- Compressing responses
- Using pagination
- Avoiding unnecessary serialization

Example

```
Client

↓

Small JSON

↓

Fast Response
```

---

# Logging Optimization

Avoid excessive logging.

Bad

```
Every Loop

↓

Log Message
```

Good

```
Errors

Warnings

Important Events
```

Too much logging affects performance.

---

# Batch Processing

Instead of inserting one record at a time

```
Insert

↓

Insert

↓

Insert
```

Use batch operations

```
Insert

↓

100 Records

↓

Single Batch
```

Fewer database round trips improve performance.

---

# Monitoring

Continuously monitor the application.

Common metrics

- CPU Usage
- Memory Usage
- Response Time
- Database Connections
- Cache Hit Ratio
- Thread Count

---

# Performance Tuning Flow

```
Users

↓

Controller

↓

Service

↓

Cache?

↓

Yes

↓

Response

OR

↓

Repository

↓

Optimized SQL

↓

Database

↓

Response
```

---

# Common Optimization Techniques

| Technique | Benefit |
|------------|----------|
| Indexing | Faster database queries |
| Caching | Faster responses |
| Pagination | Smaller result sets |
| DTOs | Less data transferred |
| Lazy Loading | Reduced unnecessary fetching |
| HikariCP | Faster database connections |
| Async Processing | Better responsiveness |
| Batch Processing | Fewer database calls |

---

# Things to Avoid

- N+1 Query Problem
- Full Table Scans
- Loading unnecessary entities
- Large JSON responses
- Long-running transactions
- Repeated database queries
- Blocking operations

---

# Performance Tuning Checklist

```
✔ SQL Optimized

✔ Indexes Created

✔ Pagination Added

✔ Redis Cache

✔ DTOs Used

✔ Lazy Loading

✔ HikariCP

✔ Async Tasks

✔ Batch Processing

✔ Monitoring Enabled
```

---

# Common Use Cases

- Banking Applications
- E-Commerce Websites
- Food Delivery Apps
- Social Media Platforms
- Booking Systems
- Enterprise Applications

---

# Common Mistakes

❌ Optimizing without measuring performance.

❌ Returning huge API responses.

❌ Ignoring SQL execution plans.

❌ Creating unnecessary indexes.

❌ Using `FetchType.EAGER` everywhere.

❌ Ignoring caching opportunities.

❌ Keeping database transactions open for too long.

---

# Real-World Example

## Banking Application

```
Money Transfer

↓

Cache Branch Details

↓

Optimized SQL

↓

Fast Response
```

---

## E-Commerce Website

```
Search Product

↓

Redis Cache

↓

Indexed Query

↓

Pagination

↓

Response
```

---

## Food Delivery App

```
Nearby Restaurants

↓

Indexed Location Search

↓

Cache Popular Restaurants

↓

Fast Response
```

---

# Advantages

- Faster API responses.
- Better scalability.
- Lower database load.
- Improved user experience.
- Reduced server resource usage.
- Higher application reliability.

---

# Best Practices

- Measure before optimizing.
- Optimize slow SQL queries first.
- Use indexes wisely.
- Implement caching for frequently accessed data.
- Use pagination for large datasets.
- Return DTOs instead of full entities.
- Keep transactions short.
- Monitor production metrics continuously.

---

# Interview Questions

### 1. What is Performance Tuning?

Performance Tuning is the process of improving an application's speed, scalability, and resource utilization.

---

### 2. What are common causes of poor performance?

- Slow SQL queries
- Missing indexes
- N+1 Query Problem
- Large API responses
- No caching
- Long-running transactions

---

### 3. How can database performance be improved?

By using indexes, optimizing SQL queries, reducing unnecessary joins, using connection pooling, and implementing caching.

---

### 4. Why is pagination important?

Pagination limits the amount of data returned in each request, reducing memory usage and improving response time.

---

### 5. Why are DTOs better than returning entities?

DTOs return only the required data, reducing payload size and improving API performance.

---

### 6. How does Redis improve performance?

Redis stores frequently accessed data in memory, reducing database queries and providing faster responses.

---

### 7. What is the first step in Performance Tuning?

The first step is to **measure performance and identify the bottleneck** before making any optimizations.

---

# Quick Revision

- Performance Tuning improves speed, scalability, and efficiency.
- Measure performance before optimizing.
- Optimize SQL queries and create indexes where appropriate.
- Use HikariCP for efficient database connections.
- Cache frequently accessed data using Redis.
- Use pagination, DTOs, and Lazy Loading.
- Move long-running tasks to background threads using `@Async`.
- Continuously monitor CPU, memory, response time, and database performance.