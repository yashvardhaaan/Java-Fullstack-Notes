# Database Indexes

## What is an Index?

A **Database Index** is a data structure that helps the database **find rows much faster** without scanning the entire table.

It works similarly to an index in a book.

Instead of reading every page,

you directly jump to the required page.

> **In simple words:**
>
> An Index is like a shortcut that helps the database locate data quickly.

---

# Why Do We Need Indexes?

Suppose an **Employee** table contains **10 million records**.

Without an Index

```
Search Employee

↓

Read Row 1

↓

Read Row 2

↓

Read Row 3

↓

...

↓

Read Row 10,000,000
```

Problems

- Slow search
- High CPU usage
- Poor performance

---

With an Index

```
Search Employee

↓

Index

↓

Exact Location

↓

Required Row
```

The database quickly finds the required record.

---

# Real-World Example

Imagine a dictionary.

Without Index

```
Need Word

↓

Read Every Page

↓

Find Word
```

Very slow.

With Index

```
Need Word

↓

Alphabetical Index

↓

Correct Page

↓

Word Found
```

Indexes work the same way.

---

# How an Index Works

```
Application

↓

SQL Query

↓

Database

↓

Index

↓

Locate Row

↓

Return Result
```

Instead of scanning the complete table,

the database first checks the index.

---

# Table Scan vs Index Scan

## Table Scan

```
Database

↓

Row 1

↓

Row 2

↓

Row 3

↓

...

↓

Target Row
```

Every row is checked.

---

## Index Scan

```
Database

↓

Index

↓

Pointer

↓

Target Row
```

Only the required row is accessed.

---

# Primary Key Index

Every Primary Key automatically creates an index.

Example

```sql
CREATE TABLE employee (

    id INT PRIMARY KEY,

    name VARCHAR(100)

);
```

```
Employee

↓

Primary Key

↓

Automatic Index
```

---

# Creating an Index

```sql
CREATE INDEX idx_employee_email

ON employee(email);
```

This creates an index on the `email` column.

---

# Unique Index

Ensures duplicate values are not allowed.

```sql
CREATE UNIQUE INDEX idx_email

ON employee(email);
```

Example

```
Email

↓

Unique

↓

No Duplicates
```

---

# Composite Index

An index on multiple columns.

```sql
CREATE INDEX idx_name_city

ON employee(name, city);
```

Useful when queries search using both columns.

Example

```
Name

+

City

↓

Composite Index
```

---

# Query Flow

Without Index

```
SELECT * FROM employee

WHERE email='abc@test.com'

↓

Full Table Scan
```

With Index

```
SELECT * FROM employee

WHERE email='abc@test.com'

↓

Index Lookup

↓

Return Result
```

---

# B-Tree Index

Most relational databases use a **B-Tree** for indexes.

```
          Root

        /      \

      A-M      N-Z

     /  \      /  \

   Data Data Data Data
```

Benefits

- Fast search
- Fast insertion
- Fast deletion

---

# Clustered vs Non-Clustered Index

## Clustered Index

The table data is physically stored in index order.

```
Clustered Index

↓

Rows Stored

↓

Sorted Order
```

Usually only **one** clustered index exists.

---

## Non-Clustered Index

Stores pointers to the actual rows.

```
Index

↓

Pointer

↓

Table Row
```

Multiple non-clustered indexes can exist.

---

# Spring Boot Entity Example

```java
@Entity
@Table(

        indexes = {

            @Index(

                    name = "idx_email",

                    columnList = "email"

            )

        }

)
public class Employee {

    @Id
    private Long id;

    private String email;

}
```

Hibernate creates the index during schema generation (when enabled).

---

# When Should You Create an Index?

Create indexes on columns that are:

- Frequently searched
- Used in `WHERE` clauses
- Used in `JOIN` conditions
- Used in `ORDER BY`
- Used in `GROUP BY`

---

# When Should You Avoid Indexes?

Avoid indexes on:

- Very small tables
- Columns that change frequently
- Columns with very few unique values (in many cases)
- Tables with heavy write operations where unnecessary indexes slow inserts and updates

---

# Advantages of Indexes

- Faster search queries.
- Faster filtering.
- Better JOIN performance.
- Improved sorting.
- Reduced query execution time.

---

# Disadvantages of Indexes

- Extra storage space.
- Slower INSERT operations.
- Slower UPDATE operations.
- Slower DELETE operations.
- Additional maintenance overhead.

---

# Index Flow

```
SQL Query

↓

Optimizer

↓

Index Available?

↓

Yes

↓

Index Scan

↓

Fetch Row

↓

Return Result
```

---

# Index vs Primary Key

| Index | Primary Key |
|--------|-------------|
| Improves query performance | Uniquely identifies a row |
| Multiple indexes allowed | Only one primary key |
| Can contain duplicate values (unless unique) | Values must be unique |
| Optional | Mandatory when defined |

---

# Index vs Full Table Scan

| Index Scan | Full Table Scan |
|-------------|-----------------|
| Reads only required rows | Reads every row |
| Faster | Slower |
| Best for selective queries | Better for very small tables |

---

# Common Use Cases

- User Login (`email`)
- Product Search
- Customer Lookup
- Order Search
- Banking Transactions
- Report Generation

---

# Common Mistakes

❌ Creating indexes on every column.

❌ Forgetting that indexes slow INSERT, UPDATE, and DELETE operations.

❌ Creating duplicate indexes.

❌ Never analyzing slow queries before adding indexes.

❌ Creating indexes on columns that are rarely searched.

---

# Real-World Example

## Banking Application

```
Account Number

↓

Index

↓

Customer Record
```

---

## E-Commerce Website

```
Search Product

↓

Product Name Index

↓

Product Found
```

---

## Food Delivery App

```
Restaurant Name

↓

Index

↓

Restaurant Details
```

---

# Advantages

- Faster query execution.
- Better database performance.
- Faster joins and sorting.
- Improved scalability.
- Essential for large tables.

---

# Best Practices

- Create indexes only where needed.
- Index frequently searched columns.
- Monitor slow queries before adding indexes.
- Remove unused indexes.
- Use composite indexes carefully.
- Regularly analyze query execution plans.

---

# Interview Questions

### 1. What is a database index?

A database index is a data structure that improves query performance by allowing faster data retrieval.

---

### 2. Why are indexes faster than full table scans?

Indexes allow the database to directly locate matching rows instead of reading every row in the table.

---

### 3. Does a Primary Key automatically create an index?

Yes.

Most relational databases automatically create an index for the Primary Key.

---

### 4. What is a composite index?

A composite index is an index created on multiple columns.

---

### 5. What are the disadvantages of indexes?

They consume additional storage and slow down INSERT, UPDATE, and DELETE operations because indexes must also be maintained.

---

### 6. Should every column have an index?

No.

Indexes should only be created on columns that are frequently used in searches, joins, sorting, or filtering.

---

### 7. Which type of data structure is commonly used to implement database indexes?

Most relational databases use a **B-Tree** structure for indexes.

---

# Quick Revision

- An Index is a shortcut that speeds up database queries.
- It avoids full table scans by locating rows efficiently.
- Primary Keys automatically create indexes.
- Common index types include Primary, Unique, Composite, Clustered, and Non-Clustered.
- Indexes improve SELECT performance but slow INSERT, UPDATE, and DELETE operations.
- Create indexes on frequently searched columns.
- Avoid unnecessary indexes to reduce maintenance overhead.