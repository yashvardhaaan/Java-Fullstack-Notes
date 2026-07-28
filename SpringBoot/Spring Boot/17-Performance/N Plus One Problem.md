# N+1 Query Problem

## What is the N+1 Query Problem?

The **N+1 Query Problem** occurs when an application executes:

- **1 query** to fetch the main data
- **N additional queries** to fetch related data

This results in many unnecessary database queries, reducing application performance.

It is one of the most common performance issues in Hibernate and Spring Data JPA.

> **In simple words:**
>
> Instead of loading everything efficiently, Hibernate loads one record first and then executes one additional query for each related record.

---

# Why Do We Need to Understand It?

Imagine an E-Commerce application.

You want to display:

- Customers
- Their Orders

Without optimization

```
Load Customers

↓

Customer 1

↓

Load Orders

↓

Customer 2

↓

Load Orders

↓

Customer 3

↓

Load Orders
```

Problems

- Too many SQL queries
- Slow response
- High database load
- Poor scalability

---

# Real-World Example

Imagine a teacher checking attendance.

Wrong way

```
Call Student 1

↓

Go to Office

↓

Call Student 2

↓

Go to Office

↓

Call Student 3

↓

Go to Office
```

Many unnecessary trips.

Better way

```
Take Attendance Register

↓

Read All Names Together
```

Only one trip.

---

# Example Database

## Customer Table

| ID | Name |
|----|------|
| 1 | John |
| 2 | Alice |
| 3 | Bob |

---

## Orders Table

| ID | Customer ID | Product |
|----|-------------|----------|
| 1 | 1 | Laptop |
| 2 | 1 | Mouse |
| 3 | 2 | Keyboard |

---

# Entity Relationship

```java
@Entity
public class Customer {

    @Id
    private Long id;

    private String name;

    @OneToMany(

            mappedBy = "customer",

            fetch = FetchType.LAZY

    )
    private List<Order> orders;

}
```

---

# What Happens?

```java
List<Customer> customers =

        customerRepository.findAll();
```

Hibernate executes

```sql
SELECT *

FROM customer;
```

Only customers are loaded.

---

Later

```java
for(Customer customer : customers){

    customer.getOrders();

}
```

Hibernate executes

```
Customer 1

↓

SELECT *

FROM orders

WHERE customer_id = 1

----------------------

Customer 2

↓

SELECT *

FROM orders

WHERE customer_id = 2

----------------------

Customer 3

↓

SELECT *

FROM orders

WHERE customer_id = 3
```

---

# Query Count

```
1 Query

↓

Customers

+

3 Queries

↓

Orders

=

4 Queries
```

General Formula

```
1 + N Queries
```

Hence the name **N+1 Query Problem**.

---

# Visualization

```
Application

↓

Customers Query

↓

Customer 1

↓

Orders Query

↓

Customer 2

↓

Orders Query

↓

Customer 3

↓

Orders Query
```

---

# Why is it Bad?

Suppose

```
1000 Customers
```

Queries executed

```
1

+

1000

=

1001 Queries
```

Huge performance impact.

---

# How to Solve It?

Several techniques can solve the problem.

- JOIN FETCH
- Entity Graph
- DTO Projection
- Batch Fetching

---

# Solution 1 : JOIN FETCH

```java
@Query("""

SELECT c

FROM Customer c

JOIN FETCH c.orders

""")
List<Customer> findAllCustomers();
```

Hibernate executes

```sql
SELECT *

FROM customer

JOIN orders

ON ...
```

Only one query.

---

Flow

```
Customer

+

Orders

↓

Single SQL Query

↓

Response
```

---

# Solution 2 : EntityGraph

```java
@EntityGraph(

        attributePaths = "orders"

)
List<Customer> findAll();
```

Hibernate automatically loads the related entity.

---

# Solution 3 : DTO Projection

Instead of loading entities,

load only required data.

```java
public record CustomerDTO(

        Long id,

        String name

){

}
```

Advantages

- Less data
- Faster queries
- Better API performance

---

# Solution 4 : Batch Fetching

Hibernate groups multiple lazy loads together.

Example

```
Instead of

100 Queries

↓

10 Batch Queries
```

Configuration

```properties
spring.jpa.properties.hibernate.default_batch_fetch_size=20
```

---

# Query Comparison

Without Optimization

```
Customers

↓

1 Query

↓

Orders

↓

100 Queries
```

Total

```
101 Queries
```

---

With JOIN FETCH

```
Customers

+

Orders

↓

1 Query
```

---

# Execution Flow

Without Optimization

```
Controller

↓

Service

↓

Repository

↓

Customers

↓

Orders

↓

Orders

↓

Orders
```

---

Optimized

```
Controller

↓

Service

↓

Repository

↓

JOIN FETCH

↓

Customer + Orders

↓

Response
```

---

# N+1 vs Lazy Loading

| Lazy Loading | N+1 Problem |
|--------------|-------------|
| Loads data only when needed | Happens because lazy loading triggers many queries |
| Feature | Performance issue |
| Can improve performance | Can degrade performance if not handled |

---

# JOIN FETCH vs EAGER

| JOIN FETCH | EAGER |
|-------------|--------|
| Used only for a specific query | Always loads related data |
| Better control | Less flexible |
| Recommended | Use carefully |

---

# Common Use Cases

- Customer → Orders
- User → Roles
- Product → Reviews
- Department → Employees
- Category → Products

---

# Common Mistakes

❌ Returning JPA entities directly from REST APIs.

❌ Ignoring SQL logs.

❌ Changing every relationship to `FetchType.EAGER`.

❌ Loading unnecessary relationships.

❌ Not testing with large datasets.

---

# Real-World Example

## Banking Application

```
Customers

↓

Transactions

↓

One Query Per Customer

↓

Slow
```

Optimized

```
Customers

+

Transactions

↓

Single Query
```

---

## E-Commerce Website

```
Products

↓

Reviews

↓

Thousands of Queries
```

Optimized

```
Products

JOIN Reviews

↓

One Query
```

---

## Food Delivery App

```
Restaurants

↓

Menus

↓

N Queries
```

Optimized

```
Restaurants

JOIN Menus

↓

One Query
```

---

# Advantages of Solving N+1

- Faster API responses.
- Fewer database queries.
- Reduced database load.
- Better scalability.
- Improved application performance.

---

# Best Practices

- Use `FetchType.LAZY` by default.
- Use `JOIN FETCH` when related data is required.
- Use DTO projections for API responses.
- Monitor generated SQL queries.
- Test with production-sized data.
- Use Entity Graphs for cleaner repository methods.

---

# Interview Questions

### 1. What is the N+1 Query Problem?

The N+1 Query Problem occurs when one query fetches parent records and additional queries are executed for each related child record.

---

### 2. Why does the N+1 Query Problem occur?

It usually occurs because lazy-loaded relationships trigger separate database queries for each parent entity.

---

### 3. How can the N+1 Query Problem be solved?

It can be solved using:

- `JOIN FETCH`
- `@EntityGraph`
- DTO Projections
- Batch Fetching

---

### 4. Is Lazy Loading always bad?

No.

Lazy Loading is useful and improves performance in many cases. The problem occurs when it results in excessive database queries.

---

### 5. Why is `JOIN FETCH` preferred over changing everything to `FetchType.EAGER`?

Because `JOIN FETCH` loads related data only for specific queries, giving better performance and control.

---

### 6. How can you detect the N+1 Query Problem?

By enabling Hibernate SQL logs and observing whether many similar queries are executed for related entities.

---

### 7. Which Hibernate property helps reduce the N+1 Query Problem using batch fetching?

```properties
spring.jpa.properties.hibernate.default_batch_fetch_size=20
```

---

# Quick Revision

- N+1 Query Problem = 1 parent query + N child queries.
- It is a common Hibernate performance issue.
- It often occurs with lazy-loaded relationships.
- `JOIN FETCH` is the most common solution.
- `@EntityGraph`, DTO Projections, and Batch Fetching are also effective solutions.
- Monitor SQL logs to detect excessive queries.
- Use `FetchType.LAZY` by default and optimize specific queries when necessary.