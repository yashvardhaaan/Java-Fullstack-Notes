# Lazy Loading

## What is Lazy Loading?

**Lazy Loading** is a strategy where related data is **loaded only when it is actually needed**.

Instead of fetching all related data immediately,

Hibernate waits until the application accesses the relationship.

> **In simple words:**
>
> Lazy Loading means "Don't load data now. Load it only when someone asks for it."

---

# Why Do We Need Lazy Loading?

Imagine an E-Commerce application.

A Customer has:

- Orders
- Addresses
- Reviews
- Wishlist
- Cart Items

Without Lazy Loading

```
Load Customer

↓

Orders

↓

Addresses

↓

Reviews

↓

Wishlist

↓

Cart

↓

Response
```

Problems

- Slow queries
- More memory usage
- Unnecessary data fetching

---

With Lazy Loading

```
Load Customer

↓

Customer Only

↓

Need Orders?

↓

Yes

↓

Load Orders
```

Only required data is fetched.

---

# Real-World Example

Imagine watching a TV series.

Without Lazy Loading

```
Download

Episode 1

Episode 2

Episode 3

...

Episode 100
```

Huge waste of storage and time.

With Lazy Loading

```
Watch Episode 1

↓

Need Episode 2?

↓

Download Episode 2
```

Only the required episode is downloaded.

---

# How Lazy Loading Works

```
Application

↓

Customer Entity

↓

Orders Not Loaded

↓

Access Orders

↓

Hibernate Loads Orders

↓

Return Data
```

---

# Hibernate Proxy

Hibernate creates a **Proxy Object** instead of immediately loading the related entity.

```
Customer

↓

Proxy

↓

Actual Data Loaded Later
```

The proxy fetches the data only when required.

---

# Entity Relationship Example

```java
@Entity
public class Customer {

    @Id
    private Long id;

    @OneToMany(

            mappedBy = "customer",

            fetch = FetchType.LAZY

    )
    private List<Order> orders;

}
```

The `orders` list is not loaded immediately.

---

# Lazy Loading Flow

```
Fetch Customer

↓

Customer Loaded

↓

Orders?

↓

Not Loaded

↓

Access getOrders()

↓

SQL Executed

↓

Orders Loaded
```

---

# Example

```java
Customer customer =

        repository.findById(1L)

                .orElseThrow();
```

Only Customer is fetched.

Later

```java
customer.getOrders();
```

Now Hibernate executes another SQL query to fetch the orders.

---

# SQL Execution

First Query

```sql
SELECT *

FROM customer

WHERE id = 1;
```

Later

```sql
SELECT *

FROM orders

WHERE customer_id = 1;
```

Notice that the second query executes **only when orders are accessed**.

---

# Eager Loading vs Lazy Loading

## Eager Loading

```
Customer

↓

Orders

↓

Address

↓

Reviews

↓

Loaded Immediately
```

Everything is loaded at once.

---

## Lazy Loading

```
Customer

↓

Orders

↓

Not Loaded

↓

Access Needed

↓

Load Orders
```

Only requested data is loaded.

---

# Default Fetch Types

| Relationship | Default Fetch Type |
|--------------|--------------------|
| `@ManyToOne` | EAGER |
| `@OneToOne` | EAGER |
| `@OneToMany` | LAZY |
| `@ManyToMany` | LAZY |

> Although these are the JPA defaults, many developers explicitly specify the fetch type for better readability and control.

---

# Changing Fetch Type

```java
@OneToMany(

        fetch = FetchType.LAZY

)
private List<Order> orders;
```

Eager Example

```java
@OneToMany(

        fetch = FetchType.EAGER

)
private List<Order> orders;
```

---

# LazyInitializationException

One common error is:

```
LazyInitializationException
```

It happens when:

```
Entity Loaded

↓

Session Closed

↓

Access Lazy Data

↓

Exception
```

Example

```java
Customer customer =

        repository.findById(1L)

                .orElseThrow();

// Session Closed

customer.getOrders(); // Exception
```

---

# How to Avoid LazyInitializationException?

- Access lazy data inside a transaction.
- Use `JOIN FETCH` when related data is definitely needed.
- Use DTO projections.
- Avoid changing everything to `FetchType.EAGER`.

---

# JOIN FETCH Example

```java
@Query("""

SELECT c

FROM Customer c

JOIN FETCH c.orders

WHERE c.id = :id

""")
Customer findCustomer(

        Long id

);
```

Both Customer and Orders are loaded in a single query.

---

# Lazy Loading Flow

```
Client

↓

Controller

↓

Service

↓

Repository

↓

Customer

↓

Access Orders

↓

Hibernate

↓

Database
```

---

# Advantages

- Faster initial queries.
- Lower memory usage.
- Better performance.
- Loads only required data.
- Ideal for large relationships.

---

# Disadvantages

- Additional SQL queries.
- Can lead to the N+1 Query Problem.
- May throw `LazyInitializationException`.
- Requires careful transaction management.

---

# Lazy vs Eager Loading

| Lazy Loading | Eager Loading |
|--------------|---------------|
| Loads data only when needed | Loads data immediately |
| Better performance for large relationships | May fetch unnecessary data |
| Lower memory usage | Higher memory usage |
| Can trigger additional queries | Usually fewer queries initially |

---

# Common Use Cases

- Customer → Orders
- User → Roles
- Product → Reviews
- Category → Products
- Employee → Projects

---

# Common Mistakes

❌ Using `FetchType.EAGER` for every relationship.

❌ Accessing lazy-loaded entities after the transaction has ended.

❌ Ignoring the N+1 Query Problem.

❌ Returning JPA entities directly from REST APIs without considering lazy relationships.

❌ Fetching unnecessary relationships.

---

# Real-World Example

## Banking Application

```
Load Customer

↓

Need Transactions?

↓

Yes

↓

Load Transactions
```

---

## E-Commerce Website

```
Open Product

↓

Need Reviews?

↓

Load Reviews
```

---

## Food Delivery App

```
Open Restaurant

↓

Need Menu?

↓

Load Menu
```

---

# Best Practices

- Use `FetchType.LAZY` for most entity relationships.
- Fetch only the data required for the current use case.
- Use `JOIN FETCH` to avoid multiple queries when appropriate.
- Use DTOs for API responses.
- Keep transactions short and well-defined.
- Monitor generated SQL queries during development.

---

# Interview Questions

### 1. What is Lazy Loading?

Lazy Loading is a strategy where related data is loaded only when it is first accessed.

---

### 2. Which Hibernate fetch type loads data only when required?

```java
FetchType.LAZY
```

---

### 3. What is LazyInitializationException?

It occurs when lazy-loaded data is accessed after the Hibernate session or persistence context has been closed.

---

### 4. How can LazyInitializationException be avoided?

By accessing the data within a transaction, using `JOIN FETCH`, or using DTO projections.

---

### 5. What is the difference between Lazy and Eager Loading?

Lazy Loading fetches related data only when needed, while Eager Loading fetches related data immediately.

---

### 6. What is a Hibernate Proxy?

A proxy is a placeholder object created by Hibernate that loads the actual entity data only when it is accessed.

---

### 7. What is the main advantage of Lazy Loading?

It improves performance by avoiding unnecessary database queries and reducing memory usage.

---

# Quick Revision

- Lazy Loading loads related data only when required.
- Use `FetchType.LAZY` to enable lazy fetching.
- Hibernate uses proxy objects for lazy-loaded entities.
- Lazy Loading reduces initial query time and memory usage.
- Accessing lazy data after the session closes causes `LazyInitializationException`.
- Use `JOIN FETCH` or DTOs when related data is required immediately.
- Lazy Loading is commonly used with `@OneToMany` and `@ManyToMany` relationships.