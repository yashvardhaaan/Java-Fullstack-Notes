v# Many-to-Many Relationship (`@ManyToMany`)

## What is a Many-to-Many Relationship?

A **Many-to-Many (N:N)** relationship means **multiple records in one table can be associated with multiple records in another table**.

In Spring Data JPA, this relationship is created using the `@ManyToMany` annotation.

> **In simple words:**
>
> Many objects can be related to many other objects.

---

# Why Do We Need a Many-to-Many Relationship?

Suppose a university has:

- Many Students
- Many Courses

One student can enroll in multiple courses.

One course can have multiple students.

This cannot be represented using only a foreign key.

Instead, a **Join Table** is used.

---

# Real-World Examples

### Students ↔ Courses

```
Students

↕️

Courses
```

One student → Many courses

One course → Many students

---

### Users ↔ Roles

```
Users

↕️

Roles
```

One user may have multiple roles.

One role may belong to multiple users.

---

### Products ↔ Categories

```
Products

↕️

Categories
```

A product may belong to multiple categories.

A category contains multiple products.

---

# Database Representation

## Student Table

| id | name |
|----|------|
| 1 | John |
| 2 | Alice |

---

## Course Table

| id | course |
|----|--------|
| 101 | Java |
| 102 | Spring Boot |

---

## Student_Course (Join Table)

| student_id | course_id |
|------------|-----------|
| 1 | 101 |
| 1 | 102 |
| 2 | 101 |

The join table stores the relationship.

---

# How Many-to-Many Works

```
Students

N -------- N

Courses

↓

Join Table
```

Hibernate automatically manages the join table.

---

# Entity Example

## Student Entity

```java
@Entity
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @ManyToMany
    @JoinTable(

        name = "student_course",

        joinColumns =
            @JoinColumn(name = "student_id"),

        inverseJoinColumns =
            @JoinColumn(name = "course_id")

    )
    private List<Course> courses;

}
```

---

## Course Entity

```java
@Entity
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String courseName;

}
```

---

# Understanding `@JoinTable`

```java
@JoinTable(

    name = "student_course",

    joinColumns =
        @JoinColumn(name = "student_id"),

    inverseJoinColumns =
        @JoinColumn(name = "course_id")

)
```

Meaning:

- Create a join table named `student_course`
- `student_id` references Student
- `course_id` references Course

---

# Generated Tables

```
Student

↓

student_course

↓

Course
```

Hibernate automatically creates all three tables.

---

# Bidirectional Many-to-Many

Student Entity

```java
@ManyToMany
@JoinTable(

    name = "student_course",

    joinColumns =
        @JoinColumn(name = "student_id"),

    inverseJoinColumns =
        @JoinColumn(name = "course_id")

)
private List<Course> courses;
```

---

Course Entity

```java
@ManyToMany(mappedBy = "courses")
private List<Student> students;
```

Now:

- Student knows its courses.
- Course knows its students.

---

# What is `mappedBy`?

```java
@ManyToMany(mappedBy = "courses")
```

It tells Hibernate:

- Student owns the relationship.
- Course references the existing relationship.
- Do not create another join table.

---

# Owning Side vs Inverse Side

```
Student

↓

@JoinTable

↓

student_course

↓

Course

↓

mappedBy
```

- **Owning Side** → Student
- **Inverse Side** → Course

Only the owning side manages the join table.

---

# Saving Data

```java
Course java = new Course();
java.setCourseName("Java");

Course spring = new Course();
spring.setCourseName("Spring Boot");

Student student = new Student();
student.setName("John");

student.setCourses(
        List.of(java, spring)
);

studentRepository.save(student);
```

---

# Generated SQL

```sql
INSERT INTO student(name)
VALUES ('John');
```

```sql
INSERT INTO course(course_name)
VALUES ('Java');
```

```sql
INSERT INTO course(course_name)
VALUES ('Spring Boot');
```

```sql
INSERT INTO student_course
(student_id, course_id)
VALUES
(1,1);
```

```sql
INSERT INTO student_course
(student_id, course_id)
VALUES
(1,2);
```

---

# Fetch Type

Default fetch type for `@ManyToMany` is:

```java
FetchType.LAZY
```

Meaning:

```
Load Student

↓

Courses are loaded only when accessed
```

Example

```java
student.getCourses();
```

---

# Cascade Operations

```java
@ManyToMany(
        cascade = {
            CascadeType.PERSIST,
            CascadeType.MERGE
        }
)
```

> **Note:** Avoid using `CascadeType.REMOVE` because deleting one student should not delete shared courses.

---

# Removing Relationships

Remove a course from a student.

```java
student.getCourses().remove(course);

studentRepository.save(student);
```

Hibernate removes only the record from the join table.

Example

Before

| student_id | course_id |
|------------|-----------|
| 1 | 101 |
| 1 | 102 |

After

| student_id | course_id |
|------------|-----------|
| 1 | 102 |

The `Course` entity is **not deleted**.

---

# Request Flow

```
Controller

↓

Service

↓

Repository

↓

Hibernate

↓

Student

↓

Join Table

↓

Course
```

---

# Database Structure

```
Student
+----+-------+
| id | name  |
+----+-------+
| 1  | John  |
| 2  | Alice |
+----+-------+

Course
+-----+--------------+
| id  | course_name  |
+-----+--------------+
|101  | Java         |
|102  | Spring Boot  |
+-----+--------------+

Student_Course
+------------+-----------+
| student_id | course_id |
+------------+-----------+
| 1          | 101       |
| 1          | 102       |
| 2          | 101       |
+------------+-----------+
```

---

# Many-to-Many vs One-to-Many

| Many-to-Many | One-to-Many |
|---------------|-------------|
| Many parents ↔ Many children | One parent → Many children |
| Uses Join Table | Uses Foreign Key |
| Example: Student ↔ Course | Example: Department → Employees |

---

# Many-to-Many vs Many-to-One

| Many-to-Many | Many-to-One |
|--------------|-------------|
| Uses Join Table | Uses Foreign Key |
| Many ↔ Many | Many → One |
| Example: User ↔ Role | Example: Employee → Department |

---

# Real-World Example

### E-Commerce Application

```
Products

↕

Categories
```

A product can belong to multiple categories.

A category contains many products.

---

### Banking Application

```
Customers

↕

Bank Accounts (Joint Accounts)
```

A joint account can have multiple customers.

A customer can own multiple accounts.

---

### Social Media

```
Users

↕

Groups
```

A user can join many groups.

A group can have many users.

---

# Advantages

- Represents complex real-world relationships
- Eliminates duplicate data
- Automatically manages join tables
- Easy to retrieve related entities
- Supports bidirectional navigation

---

# Best Practices

- Use `@JoinTable` only on the owning side.
- Use `mappedBy` on the inverse side.
- Prefer `FetchType.LAZY`.
- Avoid `CascadeType.REMOVE` for shared entities.
- If the join table contains extra fields (e.g., enrollment date, quantity, role), create a separate entity instead of using `@ManyToMany`.
- Use DTOs in REST APIs to avoid infinite recursion.

---

# Interview Questions

### 1. What is a Many-to-Many relationship?

A Many-to-Many relationship means multiple entities on one side can be associated with multiple entities on the other side.

---

### 2. Which annotation is used?

```java
@ManyToMany
```

---

### 3. Why is `@JoinTable` used?

`@JoinTable` defines the join table that stores the relationship between two entities.

---

### 4. What is the default fetch type for `@ManyToMany`?

```java
FetchType.LAZY
```

---

### 5. When should you avoid using `@ManyToMany`?

When the join table contains additional attributes (such as enrollment date, quantity, or role). In that case, model the join table as a separate entity with two `@ManyToOne` relationships.

---

# Quick Revision

- `@ManyToMany` represents many-to-many relationships.
- It uses a **join table** instead of a foreign key.
- Use `@JoinTable` on the owning side.
- Use `mappedBy` on the inverse side.
- Default fetch type is `LAZY`.
- Avoid `CascadeType.REMOVE` for shared entities.
- If the join table has extra columns, replace `@ManyToMany` with an explicit join entity.