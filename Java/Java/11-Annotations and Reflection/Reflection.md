# Reflection (Java)

## What is Reflection?

**Reflection** is a feature in Java that allows a program to inspect and manipulate its own classes, methods, fields, constructors, and objects at runtime.

Normally, Java code knows everything at compile time.

With Reflection, Java can discover information dynamically while the program is running.

> **Definition:** Reflection is the process of examining and modifying the behavior of classes, methods, fields, and constructors during runtime.

---

# Why Do We Need Reflection?

Suppose you only know the class name at runtime.

Without Reflection

```java
Student student = new Student();
```

The class must be known during compilation.

With Reflection

```java
Class<?> clazz =

Class.forName("Student");
```

Now Java loads the class dynamically.

This is how frameworks like **Spring**, **Hibernate**, and **JUnit** work.

---

# Real-World Example

Imagine a mechanic.

```
Car

↓

Open Engine

↓

Inspect Parts

↓

Repair Parts
```

Similarly,

```
Class

↓

Reflection

↓

Inspect Fields

↓

Inspect Methods

↓

Create Object

↓

Invoke Methods
```

---

# Reflection API

Reflection classes are available in

```java
java.lang.reflect
```

Main classes

- Class
- Method
- Field
- Constructor
- Modifier

---

# Class Class

Everything in Java has a corresponding `Class` object.

```java
Student student =

new Student();

Class<?> clazz =

student.getClass();
```

---

Another way

```java
Class<?> clazz =

Student.class;
```

---

Another way

```java
Class<?> clazz =

Class.forName(

"Student"

);
```

---

# Getting Class Information

```java
System.out.println(

clazz.getName()

);
```

Output

```text
Student
```

---

Package

```java
clazz.getPackageName();
```

Superclass

```java
clazz.getSuperclass();
```

Interfaces

```java
clazz.getInterfaces();
```

---

# Getting Constructors

```java
Constructor<?>[] constructors =

clazz.getDeclaredConstructors();
```

Loop

```java
for(Constructor<?> c : constructors){

    System.out.println(c);

}
```

---

# Creating Object Using Reflection

Suppose

```java
class Student{

}
```

Create object

```java
Class<?> clazz =

Student.class;

Object obj =

clazz.getDeclaredConstructor()

     .newInstance();
```

No `new Student()` is required.

---

# Getting Methods

```java
Method[] methods =

clazz.getDeclaredMethods();
```

Example

```java
for(Method method : methods){

    System.out.println(

        method.getName()

    );

}
```

---

# Invoking Methods

Suppose

```java
class Student{

    public void display(){

        System.out.println("Hello");

    }

}
```

Reflection

```java
Student student =

new Student();

Method method =

Student.class.getDeclaredMethod(

"display"

);

method.invoke(student);
```

Output

```text
Hello
```

---

# Getting Fields

Suppose

```java
class Student{

    private String name = "Yash";

}
```

Reflection

```java
Field field =

Student.class

.getDeclaredField("name");
```

---

# Accessing Private Fields

Normally

```java
private
```

fields cannot be accessed.

Reflection allows access.

```java
field.setAccessible(true);

System.out.println(

field.get(student)

);
```

Output

```text
Yash
```

---

# Modifying Private Fields

```java
field.set(

student,

"Rahul"

);
```

Now

```java
System.out.println(

field.get(student)

);
```

Output

```text
Rahul
```

---

# Reflection and Annotations

Reflection is used to read annotations.

Example

```java
@Retention(

RetentionPolicy.RUNTIME

)

@interface Author{

    String name();

}
```

Usage

```java
@Author(name="Yash")

class Student{

}
```

Reading

```java
Author author =

Student.class

.getAnnotation(

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

# Reflection Flow

```text
Class

↓

Class Object

↓

Read Fields

↓

Read Methods

↓

Read Constructors

↓

Read Annotations

↓

Invoke Methods

↓

Create Objects
```

---

# Internal Working

Suppose

```java
Student.class
```

Internally

```text
.class File

↓

JVM Loads Class

↓

Creates Class Object

↓

Reflection API

↓

Methods

↓

Fields

↓

Constructors

↓

Annotations
```

The JVM stores metadata about every loaded class.

Reflection reads this metadata.

---

# Reflection vs Normal Java

| Normal Java | Reflection |
|-------------|------------|
| Compile-time | Runtime |
| Faster | Slightly slower |
| Direct method calls | Dynamic method calls |
| More secure | Can bypass access checks |
| Easy to optimize | More flexible |

---

# Performance Considerations

Reflection is slower because:

- JVM performs runtime lookups.
- Security checks may occur.
- Method invocation is indirect.

For most applications, the overhead is small, but avoid Reflection inside performance-critical loops.

---

# Security Considerations

Reflection can access private members using

```java
setAccessible(true)
```

This can bypass encapsulation.

Because of this, Reflection should be used carefully.

---

# Production Usage

Reflection is heavily used in modern Java frameworks.

## Spring Boot

- `@Autowired`
- `@Component`
- `@Service`
- `@RestController`

Spring scans classes using Reflection.

---

## Hibernate

```java
@Entity

@Id
```

Hibernate reads entity classes using Reflection.

---

## JUnit

```java
@Test
```

JUnit finds test methods using Reflection.

---

## Jackson

```java
ObjectMapper
```

Reflection converts JSON into Java objects and vice versa.

---

## Dependency Injection

Spring creates objects dynamically using Reflection.

---

# Advantages

- Dynamic class loading
- Runtime object creation
- Framework support
- Reads annotations
- Flexible programming

---

# Limitations

- Slower than direct calls
- Can break encapsulation
- More complex code
- Harder to debug
- Security concerns

---

# Best Practices

✅ Use Reflection only when necessary.

✅ Cache reflected objects (`Method`, `Field`, etc.) if reused frequently.

✅ Prefer normal method calls for business logic.

✅ Avoid unnecessary use of `setAccessible(true)`.

---

# Common Mistakes

❌ Using Reflection everywhere.

---

❌ Ignoring checked exceptions.

---

❌ Accessing private fields unnecessarily.

---

❌ Calling Reflection repeatedly inside loops.

---

# Interview Questions

### 1. What is Reflection?

Reflection is the ability of Java to inspect and manipulate classes, methods, fields, constructors, and objects at runtime.

---

### 2. Which package provides Reflection?

```java
java.lang.reflect
```

---

### 3. What is the `Class` class?

It represents metadata about a loaded Java class.

---

### 4. How do you obtain a `Class` object?

Three common ways:

```java
Student.class
```

```java
student.getClass()
```

```java
Class.forName("Student")
```

---

### 5. Can Reflection access private members?

Yes.

Using

```java
setAccessible(true)
```

---

### 6. Why is Reflection slower?

Because it performs method lookups and invocations dynamically at runtime.

---

### 7. Which frameworks use Reflection?

- Spring Boot
- Hibernate
- JUnit
- Jackson
- Mockito

---

### 8. How does Spring Boot use Reflection?

Spring scans classes, reads annotations, creates beans, injects dependencies, and invokes lifecycle methods using Reflection.

---

### 9. Can Reflection create objects?

Yes.

Using

```java
clazz.getDeclaredConstructor().newInstance();
```

---

### 10. Is Reflection thread-safe?

The Reflection API itself is thread-safe for reading metadata, but thread safety depends on the objects being accessed and modified.

---

# Quick Revision

- Reflection = Inspect and modify Java code at runtime.
- Main classes:
  - `Class`
  - `Method`
  - `Field`
  - `Constructor`
- Load class:
  - `Student.class`
  - `student.getClass()`
  - `Class.forName()`
- Create objects dynamically.
- Invoke methods dynamically.
- Access fields dynamically.
- Read annotations.
- Used by Spring Boot, Hibernate, JUnit, Jackson, and many other frameworks.

---

# Keywords

- Reflection
- Class
- Method
- Field
- Constructor
- Class.forName()
- getDeclaredMethods()
- getDeclaredFields()
- getDeclaredConstructor()
- invoke()
- newInstance()
- setAccessible()
- Runtime
- Metadata
- Spring Boot
- Hibernate
- JUnit
- Java