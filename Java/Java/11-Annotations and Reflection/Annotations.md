# Annotations (Java)

## What are Annotations?

An **Annotation** is a special type of metadata that provides information about classes, methods, fields, constructors, parameters, and other program elements.

Annotations **do not directly change the program's logic**. Instead, they provide information that can be used by the compiler, JVM, or frameworks.

> **Definition:** An Annotation is metadata that describes Java code and can be processed at compile time or runtime.

---

# Why Do We Need Annotations?

Before annotations, developers often used:

- XML configuration
- Naming conventions
- Comments

These approaches were difficult to maintain.

Annotations allow configuration directly in code.

Example

Without Annotation

```java
public void save() {

}
```

With Annotation

```java
@Override
public String toString() {

    return "Student";

}
```

The compiler now knows that this method overrides a parent method.

---

# Real-World Example

Imagine a library book.

```
Book

↓

Sticker

↓

Reference Only
```

The sticker doesn't change the book.

It simply provides additional information.

Similarly,

```
Java Class

↓

Annotation

↓

Extra Information

↓

Compiler / JVM / Framework
```

---

# Annotation Syntax

```java
@Override
public String toString() {

    return "Student";

}
```

An annotation always starts with

```java
@
```

---

# Where Can Annotations Be Used?

Annotations can be applied to:

- Classes
- Interfaces
- Methods
- Fields
- Constructors
- Parameters
- Local Variables
- Packages
- Type Use

Example

```java
class Student {

    @Deprecated
    void oldMethod() {

    }

}
```

---

# Built-in Annotations

Java provides several built-in annotations.

```text
Annotations

↓

@Override

@Deprecated

@SuppressWarnings

@FunctionalInterface

@SafeVarargs
```

---

# @Override

Indicates that a method overrides a superclass method.

```java
class Animal {

    void sound() {

    }

}

class Dog extends Animal {

    @Override
    void sound() {

        System.out.println("Bark");

    }

}
```

If the method name is incorrect

```java
@Override
void sounds() {

}
```

Compilation Error.

---

# @Deprecated

Marks code that should no longer be used.

```java
@Deprecated

void oldMethod() {

}
```

Compiler Warning

```text
oldMethod() is deprecated
```

A newer method is usually provided.

---

# @SuppressWarnings

Suppresses compiler warnings.

```java
@SuppressWarnings("unchecked")

List list = new ArrayList();
```

Common values

- unchecked
- deprecation
- unused
- serial

---

# @FunctionalInterface

Indicates that an interface has exactly one abstract method.

```java
@FunctionalInterface

interface Greeting {

    void hello();

}
```

If another abstract method is added,

Compilation Error.

---

# @SafeVarargs

Used to suppress warnings when using generic varargs.

```java
@SafeVarargs

public static <T>

void print(T... values){

}
```

Used only on methods or constructors that are safe for generic varargs.

---

# Meta Annotations

Meta Annotations are annotations that describe other annotations.

```text
@Target

@Retention

@Inherited

@Documented

@Repeatable
```

---

# @Target

Specifies where an annotation can be applied.

Example

```java
@Target(ElementType.METHOD)
```

Possible targets

- TYPE
- METHOD
- FIELD
- PARAMETER
- CONSTRUCTOR
- LOCAL_VARIABLE
- PACKAGE
- TYPE_USE

---

# @Retention

Specifies how long an annotation is available.

```java
@Retention(RetentionPolicy.RUNTIME)
```

Three retention policies exist.

---

## SOURCE

Available only during compilation.

Removed after compilation.

Example

```text
Compiler

↓

Annotation Removed

↓

.class File
```

Used by

- @Override
- @SuppressWarnings

---

## CLASS

Stored inside the `.class` file.

Not available at runtime.

```text
Compiler

↓

.class File

↓

JVM Cannot Read
```

---

## RUNTIME

Available while the program is running.

```text
Compiler

↓

.class File

↓

JVM

↓

Reflection
```

Spring Boot uses **RUNTIME** annotations extensively.

---

# @Inherited

Allows subclasses to inherit an annotation.

```java
@Inherited

@interface MyAnnotation{

}
```

---

# @Documented

Includes the annotation in generated JavaDocs.

---

# @Repeatable

Allows the same annotation to be applied multiple times.

```java
@Role("Admin")

@Role("Manager")
```

---

# Annotation Parameters

Annotations can have values.

```java
@interface Author {

    String name();

}
```

Usage

```java
@Author(name = "Yash")
```

---

Default Value

```java
@interface Version {

    int value() default 1;

}
```

Usage

```java
@Version
```

---

# Retention Policy Summary

| Policy | Available During |
|---------|------------------|
| SOURCE | Compilation |
| CLASS | Class File |
| RUNTIME | Runtime |

---

# Internal Working

Suppose

```java
@Override

void display(){

}
```

Internally

```text
Java Source

↓

Compiler Reads Annotation

↓

Validation

↓

.class File

↓

JVM / Framework
```

For runtime annotations

```text
Runtime

↓

Reflection

↓

Read Annotation

↓

Execute Logic
```

---

# Production Usage

Annotations are used everywhere in Java.

Examples

Spring Boot

```java
@RestController

@Service

@Repository

@Component

@Autowired
```

Hibernate

```java
@Entity

@Id

@Column

@OneToMany
```

JUnit

```java
@Test

@BeforeEach

@AfterEach
```

Lombok

```java
@Getter

@Setter

@Builder

@Data
```

---

# Advantages

- Cleaner code
- Less XML configuration
- Easier maintenance
- Better readability
- Framework integration
- Compile-time validation

---

# Limitations

- Do not execute business logic by themselves
- Require compiler, JVM, or frameworks to process them
- Excessive annotations can reduce readability

---

# Best Practices

✅ Use annotations only where appropriate.

✅ Prefer built-in annotations before creating custom ones.

✅ Use `@Override` whenever overriding methods.

✅ Remove deprecated APIs gradually.

✅ Keep annotation usage meaningful.

---

# Common Mistakes

❌ Forgetting `@Override`.

---

❌ Using incorrect retention policies.

---

❌ Assuming annotations execute code automatically.

---

❌ Creating unnecessary custom annotations.

---

# Interview Questions

### 1. What is an Annotation?

An Annotation is metadata that provides additional information about Java code without directly changing its behavior.

---

### 2. Why were Annotations introduced?

To replace XML configuration and improve code readability and maintainability.

---

### 3. What is `@Override`?

It tells the compiler that a method overrides a superclass method.

---

### 4. What is `@Deprecated`?

It marks APIs that should no longer be used.

---

### 5. What is `@SuppressWarnings`?

It suppresses specific compiler warnings.

---

### 6. What is `@FunctionalInterface`?

It ensures an interface contains exactly one abstract method.

---

### 7. What is the purpose of `@Target`?

It specifies where an annotation can be applied.

---

### 8. What is the purpose of `@Retention`?

It specifies how long an annotation is retained.

- SOURCE
- CLASS
- RUNTIME

---

### 9. Which retention policy does Spring Boot mostly use?

`RetentionPolicy.RUNTIME`

because Spring reads annotations using Reflection at runtime.

---

### 10. Do annotations execute code?

No.

Annotations only provide metadata. The compiler, JVM, or frameworks decide how to process them.

---

# Quick Revision

- Annotation = Metadata for Java code.
- Starts with `@`.
- Common annotations:
  - `@Override`
  - `@Deprecated`
  - `@SuppressWarnings`
  - `@FunctionalInterface`
  - `@SafeVarargs`
- Meta annotations:
  - `@Target`
  - `@Retention`
  - `@Inherited`
  - `@Documented`
  - `@Repeatable`
- Retention policies:
  - SOURCE
  - CLASS
  - RUNTIME
- Spring Boot uses runtime annotations with Reflection.

---

# Keywords

- Annotation
- Metadata
- @Override
- @Deprecated
- @SuppressWarnings
- @FunctionalInterface
- @SafeVarargs
- @Target
- @Retention
- @Inherited
- @Documented
- @Repeatable
- RetentionPolicy
- Reflection
- Java