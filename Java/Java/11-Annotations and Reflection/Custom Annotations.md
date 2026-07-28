# Custom Annotations (Java)

## What are Custom Annotations?

A **Custom Annotation** is an annotation created by the programmer to provide custom metadata for classes, methods, fields, constructors, or parameters.

Just like Java provides built-in annotations (`@Override`, `@Deprecated`), we can create our own annotations.

> **Definition:** A Custom Annotation is a user-defined annotation used to attach metadata that can be processed by the compiler, JVM, or frameworks.

---

# Why Do We Need Custom Annotations?

Sometimes built-in annotations are not enough.

Suppose you want to mark methods that require authorization.

Without Custom Annotation

```java
public void deleteUser() {

    // Authorization logic

}
```

There is no indication that this method requires authorization.

With Custom Annotation

```java
@AdminOnly
public void deleteUser() {

}
```

Now frameworks or reflection can detect that only administrators should access this method.

---

# Real-World Example

Imagine employee ID cards.

```
Employee

↓

ID Card

↓

Department

↓

HR Reads Information
```

Similarly,

```
Java Class

↓

Custom Annotation

↓

Reflection / Framework

↓

Execute Logic
```

---

# Creating a Custom Annotation

Syntax

```java
@interface Author {

}
```

Usage

```java
@Author

class Student {

}
```

---

# Annotation with Elements

Annotations can contain elements.

```java
@interface Author {

    String name();

}
```

Usage

```java
@Author(name = "Yash")

class Student {

}
```

---

# Multiple Elements

```java
@interface StudentInfo {

    String name();

    int age();

}
```

Usage

```java
@StudentInfo(

    name = "Yash",

    age = 21

)

class Student {

}
```

---

# Default Values

Elements can have default values.

```java
@interface Version {

    int value() default 1;

}
```

Usage

```java
@Version

class Student {

}
```

or

```java
@Version(2)

class Student {

}
```

---

# Marker Annotation

A Marker Annotation has **no elements**.

Example

```java
@interface Important {

}
```

Usage

```java
@Important

class Student {

}
```

Examples from Java

- `@Override`
- `@Deprecated`

---

# Single-Value Annotation

Contains one element named `value`.

```java
@interface Author {

    String value();

}
```

Usage

```java
@Author("Yash")

class Student {

}
```

Notice that `value =` is optional.

---

# Multi-Value Annotation

Contains multiple elements.

```java
@interface Course {

    String name();

    int duration();

}
```

Usage

```java
@Course(

    name = "Java",

    duration = 60

)

class Training {

}
```

---

# Using Meta Annotations

Custom annotations usually use meta annotations.

```java
@Target(ElementType.TYPE)

@Retention(RetentionPolicy.RUNTIME)

@interface Author {

    String name();

}
```

---

# @Target

Specifies where the annotation can be used.

Examples

```java
@Target(ElementType.METHOD)
```

```java
@Target(ElementType.FIELD)
```

```java
@Target(ElementType.TYPE)
```

---

# @Retention

Specifies how long the annotation is available.

```java
@Retention(RetentionPolicy.RUNTIME)
```

Retention types

- SOURCE
- CLASS
- RUNTIME

Most custom annotations used with Spring use **RUNTIME**.

---

# Reading Custom Annotation Using Reflection

Create annotation

```java
@Retention(RetentionPolicy.RUNTIME)

@interface Author {

    String name();

}
```

Apply annotation

```java
@Author(name = "Yash")

class Student {

}
```

Read annotation

```java
Author author =

Student.class.getAnnotation(

Author.class

);

System.out.println(

author.name()

);
```

Output

```text
Yash
```

---

# Internal Working

```text
Custom Annotation

↓

Compiler

↓

.class File

↓

JVM

↓

Reflection

↓

Read Annotation

↓

Perform Action
```

The annotation itself does **not execute any logic**.

Reflection or a framework reads it and decides what to do.

---

# Production Usage

Custom Annotations are widely used in frameworks.

Spring Boot

```java
@RestController

@Service

@Repository

@Component
```

These are custom annotations provided by Spring.

---

Validation

```java
@NotNull

@Email

@Size
```

---

Security

```java
@PreAuthorize

@RolesAllowed
```

---

Testing

```java
@Test

@BeforeEach
```

---

# Advantages

- Cleaner code
- Less configuration
- Better readability
- Reusable metadata
- Easy framework integration

---

# Limitations

- Cannot execute logic by themselves
- Usually require Reflection or Annotation Processing
- Excessive use can reduce readability

---

# Best Practices

✅ Use meaningful annotation names.

✅ Choose the correct `@Target`.

✅ Use `RetentionPolicy.RUNTIME` if the annotation must be available during execution.

✅ Keep annotations focused on one responsibility.

---

# Common Mistakes

❌ Forgetting `@Retention(RetentionPolicy.RUNTIME)` when the annotation must be read at runtime.

---

❌ Choosing the wrong `@Target`.

---

❌ Putting business logic inside annotations.

---

❌ Creating custom annotations when built-in ones already exist.

---

# Interview Questions

### 1. What is a Custom Annotation?

A programmer-defined annotation used to provide metadata for Java code.

---

### 2. How do you create a Custom Annotation?

Using the `@interface` keyword.

```java
@interface MyAnnotation {

}
```

---

### 3. What is a Marker Annotation?

An annotation that has no elements.

---

### 4. What is a Single-Value Annotation?

An annotation with one element named `value`.

---

### 5. What is a Multi-Value Annotation?

An annotation containing two or more elements.

---

### 6. Why is `@Retention(RetentionPolicy.RUNTIME)` important?

It keeps the annotation available at runtime so it can be read using Reflection.

---

### 7. Which meta annotation specifies where an annotation can be used?

`@Target`

---

### 8. How are Custom Annotations read at runtime?

Using Java Reflection APIs.

---

### 9. Do Custom Annotations execute code automatically?

No.

They only provide metadata. Reflection, annotation processors, or frameworks interpret them.

---

### 10. Where are Custom Annotations used in Spring Boot?

They are used for dependency injection (`@Autowired`), REST controllers (`@RestController`), validation (`@NotNull`), transactions (`@Transactional`), security (`@PreAuthorize`), and many other framework features.

---

# Quick Revision

- Custom Annotation = User-defined metadata.
- Created using `@interface`.
- Types:
  - Marker Annotation
  - Single-Value Annotation
  - Multi-Value Annotation
- Common meta annotations:
  - `@Target`
  - `@Retention`
- Runtime annotations are read using Reflection.
- Widely used in Spring Boot, Hibernate, Validation, and JUnit.

---

# Keywords

- Custom Annotation
- @interface
- Marker Annotation
- Single-Value Annotation
- Multi-Value Annotation
- @Target
- @Retention
- RetentionPolicy.RUNTIME
- Reflection
- Metadata
- Spring Boot
- Java