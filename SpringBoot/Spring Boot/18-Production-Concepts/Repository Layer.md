# Repository Layer

## What is the Repository Layer?

The **Repository Layer** is responsible for **interacting with the database**.

It performs operations like:

- Insert
- Update
- Delete
- Fetch

In Spring Boot, the Repository Layer is usually implemented using **Spring Data JPA**.

> **In simple words:**
>
> The Repository Layer is the bridge between your application and the database.

---

# Why Do We Need the Repository Layer?

Imagine a user wants to fetch product details.

Without Repository

```
Controller

↓

SQL Query

↓

Database
```

Problems

- SQL inside Controller
- Poor maintainability
- Difficult testing
- Tight coupling

---

With Repository

```
Controller

↓

Service

↓

Repository

↓

Database
```

Each layer has one responsibility.

---

# Real-World Example

Imagine a library.

```
Student

↓

Librarian

↓

Bookshelf
```

The student doesn't search the storage room directly.

Similarly,

```
Controller

↓

Service

↓

Repository

↓

Database
```

The Repository communicates with the database.

---

# Repository Architecture

```
Client

↓

Controller

↓

Service

↓

Repository

↓

Database
```

---

# Responsibilities

The Repository Layer is responsible for:

- CRUD operations
- Database queries
- Fetching records
- Saving entities
- Deleting records
- Custom database queries

It **should not contain business logic**.

---

# Spring Data JPA Repository

```java
@Repository
public interface UserRepository

        extends JpaRepository<User, Long> {

}
```

Spring automatically creates the implementation at runtime.

---

# How It Works

```
Controller

↓

Service

↓

UserRepository

↓

Hibernate

↓

Database
```

---

# JpaRepository

`JpaRepository` provides built-in CRUD methods.

```java
public interface UserRepository

        extends JpaRepository<User, Long>{

}
```

No implementation code is required.

---

# Common CRUD Methods

```java
save(entity);
```

Save or update an entity.

---

```java
findById(id);
```

Find by primary key.

---

```java
findAll();
```

Retrieve all records.

---

```java
deleteById(id);
```

Delete by primary key.

---

```java
existsById(id);
```

Check if a record exists.

---

```java
count();
```

Count total records.

---

# Example Entity

```java
@Entity
public class User {

    @Id
    private Long id;

    private String name;

    private String email;

}
```

---

# Example Repository

```java
@Repository
public interface UserRepository

        extends JpaRepository<User, Long>{

}
```

---

# Using Repository in Service

```java
@Service
public class UserService {

    private final UserRepository repository;

    public UserService(

            UserRepository repository

    ){

        this.repository = repository;

    }

    public User getUser(

            Long id

    ){

        return repository.findById(id)

                .orElseThrow();

    }

}
```

---

# Custom Query Method

Spring Data JPA generates SQL automatically.

```java
List<User> findByName(

        String name

);
```

Spring generates SQL similar to

```sql
SELECT *

FROM user

WHERE name = ?;
```

---

# Multiple Conditions

```java
List<User> findByNameAndEmail(

        String name,

        String email

);
```

Generated SQL

```sql
SELECT *

FROM user

WHERE

name = ?

AND email = ?;
```

---

# Custom JPQL Query

```java
@Query("""

SELECT u

FROM User u

WHERE u.email = :email

""")
User findUser(

        String email

);
```

---

# Native SQL Query

```java
@Query(

value = """

SELECT *

FROM users

WHERE email = :email

""",

nativeQuery = true

)
User findByEmail(

        String email

);
```

---

# Repository Request Flow

```
Controller

↓

Service

↓

Repository

↓

Hibernate

↓

Database

↓

Result

↓

Service

↓

Controller

↓

Client
```

---

# Repository vs Service

| Repository | Service |
|------------|----------|
| Database access | Business logic |
| CRUD operations | Business rules |
| Queries | Calls repositories |
| No business decisions | Coordinates application flow |

---

# Repository vs DAO

| Repository | DAO |
|------------|-----|
| Spring Data abstraction | Traditional design pattern |
| Less boilerplate | More manual code |
| Auto-generated methods | Manual implementation |
| Easier development | More control |

---

# Repository Interfaces

Spring provides several repository interfaces.

```
Repository

↓

CrudRepository

↓

PagingAndSortingRepository

↓

JpaRepository
```

`JpaRepository` is the most commonly used because it includes CRUD, pagination, and sorting support.

---

# Common Use Cases

- User Management
- Product Catalog
- Order Processing
- Employee Records
- Payment Transactions
- Inventory Management

---

# Common Mistakes

❌ Writing business logic inside the Repository.

❌ Calling the Repository directly from the Controller.

❌ Writing unnecessary native SQL queries.

❌ Returning huge datasets without pagination.

❌ Ignoring transaction management.

---

# Real-World Example

## Banking Application

```
Transfer Request

↓

Service

↓

Account Repository

↓

Database
```

---

## E-Commerce Website

```
Search Product

↓

Repository

↓

Database

↓

Product List
```

---

## Food Delivery App

```
Find Restaurant

↓

Repository

↓

Database
```

---

# Advantages

- Clean separation of concerns.
- Less boilerplate code.
- Built-in CRUD methods.
- Easy custom query creation.
- Supports pagination and sorting.
- Integrates seamlessly with Spring Data JPA.

---

# Best Practices

- Keep Repositories focused only on data access.
- Put business logic in the Service Layer.
- Prefer derived query methods before writing custom SQL.
- Use pagination for large datasets.
- Use JPQL unless native SQL is truly required.
- Keep repository methods small and meaningful.

---

# Interview Questions

### 1. What is the Repository Layer?

The Repository Layer is responsible for communicating with the database and performing CRUD operations.

---

### 2. What is `JpaRepository`?

`JpaRepository` is a Spring Data JPA interface that provides built-in CRUD, pagination, and sorting methods.

---

### 3. Should business logic be written inside a Repository?

No. The Repository should only handle database access. Business logic belongs in the Service Layer.

---

### 4. What is the difference between `findById()` and `getById()`?

- `findById()` returns an `Optional` and immediately queries the database.
- `getById()` (deprecated in newer versions in favor of `getReferenceById()`) returns a lazy reference that may not hit the database until accessed.

---

### 5. What is a derived query method?

A derived query method is a repository method whose SQL/JPQL is automatically generated from its method name, such as `findByEmail()`.

---

### 6. When should native SQL queries be used?

Only when JPQL or derived query methods cannot efficiently solve the problem or when database-specific features are required.

---

### 7. Why is `JpaRepository` preferred?

Because it reduces boilerplate code and provides ready-to-use CRUD operations, pagination, sorting, and query support.

---

# Quick Revision

- Repository Layer communicates with the database.
- It is commonly implemented using `JpaRepository`.
- It performs CRUD operations and database queries.
- Keep business logic out of the Repository.
- Use derived query methods whenever possible.
- Use JPQL before native SQL.
- Controllers should call Services, and Services should call Repositories.