# Classes and Objects

## What is a Class?

A **Class** is a blueprint or template used to create objects.

It defines:

- Data (Fields/Variables)
- Behavior (Methods)

A class itself does **not** occupy memory for its fields. Memory is allocated only when objects are created.

> **Definition:** A Class is a user-defined blueprint that defines the properties and behaviors of objects.

---

# Why Do We Need Classes?

Imagine developing a Student Management System.

Without classes,

you would create separate variables for every student.

```java
String student1Name = "John";
int student1Age = 20;

String student2Name = "Alice";
int student2Age = 21;
```

As the number of students grows,

the code becomes difficult to manage.

Instead,

we define a class once.

```java
class Student{

}
```

Then create multiple objects.

---

# Real-World Example

Imagine a car factory.

```text
Car Blueprint

↓

Manufacture Cars

↓

Car 1

Car 2

Car 3
```

Similarly,

```text
Student Class

↓

Create Objects

↓

Student 1

Student 2

Student 3
```

The blueprint is the class.

The actual cars are objects.

---

# What is an Object?

An **Object** is a real instance of a class.

It has:

- State (Data)
- Behavior (Methods)

Example

```java
Student s1 = new Student();
```

Here

```text
Student

↓

Class

----------------

s1

↓

Object
```

---

# Class Syntax

```java
class Student{

    String name;

    int age;

    void study(){

        System.out.println("Studying...");

    }

}
```

---

# Components of a Class

```java
class Student{

    String name;

    int age;

    void study(){

    }

}
```

Contains

- Fields
- Methods
- Constructors
- Nested Classes (optional)

---

# Fields (Instance Variables)

Fields store data about an object.

Example

```java
class Student{

    String name;

    int age;

}
```

Memory

```text
Student Object

↓

name

↓

age
```

Each object has its own copy of instance variables.

---

# Methods

Methods define behavior.

Example

```java
class Student{

    void study(){

        System.out.println("Studying");

    }

}
```

Objects use methods to perform actions.

---

# Creating an Object

Syntax

```java
ClassName objectName = new ClassName();
```

Example

```java
Student s1 = new Student();
```

Meaning

```text
new

↓

Create Object

↓

Allocate Heap Memory

↓

Call Constructor

↓

Return Reference

↓

Store in s1
```

---

# The new Keyword

The `new` keyword performs several operations.

```java
Student s1 = new Student();
```

Internally

```text
new

↓

Allocate Heap Memory

↓

Initialize Fields

↓

Call Constructor

↓

Return Reference
```

---

# Memory Representation

Example

```java
Student s1 = new Student();

s1.name = "John";
```

Memory

```text
Stack

↓

s1

↓

Heap

↓

Student Object

↓

name = John

↓

age = 0
```

Notice

- Reference variable → Stack
- Object → Heap

---

# Multiple Objects

```java
Student s1 = new Student();

Student s2 = new Student();
```

Memory

```text
Stack

↓

s1 ───────┐
           │
           ▼
        Object 1

----------------

s2 ───────┐
           │
           ▼
        Object 2
```

Each object has its own data.

---

# Accessing Members

Example

```java
Student s = new Student();

s.name = "Java";

s.age = 20;

s.study();
```

The **dot (`.`) operator** is used to access fields and methods.

---

# Default Values

When an object is created,

instance variables receive default values.

| Data Type | Default Value |
|-----------|---------------|
| int | 0 |
| double | 0.0 |
| boolean | false |
| char | '\u0000' |
| Object | null |

Example

```java
class Student{

    int age;

    String name;

}
```

New Object

```text
age = 0

name = null
```

---

# Difference Between Class and Object

| Class | Object |
|--------|---------|
| Blueprint | Instance |
| Logical entity | Physical entity |
| No object data | Stores actual data |
| Created once | Can create many |

---

# Object Lifecycle

```text
Class Created

↓

Object Created

↓

Object Used

↓

Reference Removed

↓

Garbage Collector Frees Memory
```

---

# this Keyword (Introduction)

Inside a class,

`this` refers to the **current object**.

Example

```java
class Student{

    String name;

    void setName(String name){

        this.name = name;

    }

}
```

Here

```text
this.name

↓

Current Object's Variable
```

A detailed explanation of `this` will be covered later.

---

# Internal Working

Suppose

```java
Student s = new Student();

s.study();
```

Internally

```text
Student Class

↓

Class Loaded

↓

new

↓

Heap Object Created

↓

Reference Returned

↓

Stack Variable

↓

Method Called
```

---

# Production Usage

Classes and Objects are used everywhere in Java.

Examples

- Spring Boot Controllers
- Services
- Repositories
- Entities
- DTOs
- Utility Classes

Example

```java
User user = new User();

Order order = new Order();
```

Spring Boot creates many objects automatically using **Dependency Injection**.

---

# Advantages

- Code reusability
- Better organization
- Easier maintenance
- Supports Object-Oriented Programming
- Models real-world entities

---

# Limitations

- More objects increase memory usage
- Poor class design can make maintenance difficult
- Large object graphs can affect performance

---

# Best Practices

✅ Keep one responsibility per class.

✅ Use meaningful class names.

✅ Keep fields private (Encapsulation).

✅ Create reusable methods.

---

# Common Mistakes

❌ Confusing a class with an object.

A class is only a blueprint.

---

❌ Thinking objects are stored in the Stack.

Objects are stored in the Heap.

---

❌ Creating unnecessary objects.

Too many temporary objects increase Garbage Collection work.

---

❌ Accessing instance members without creating an object (unless they are `static`).

---

# Interview Questions

### 1. What is a Class?

A class is a blueprint used to create objects.

---

### 2. What is an Object?

An object is an instance of a class that contains actual data and behavior.

---

### 3. Where are objects stored?

Objects are stored in the Heap.

---

### 4. Where is the reference variable stored?

If it is a local variable, it is stored in the Stack.

---

### 5. What does the `new` keyword do?

It:

- Allocates Heap memory
- Initializes fields
- Calls the constructor
- Returns the object's reference

---

### 6. Can one class create multiple objects?

Yes.

One class can create any number of objects.

---

### 7. What are fields?

Variables that store an object's data.

---

### 8. What are methods?

Functions that define an object's behavior.

---

### 9. What is the difference between a class and an object?

A class is a blueprint.

An object is the actual instance created from that blueprint.

---

### 10. What does `this` refer to?

It refers to the current object.

---

# Quick Revision

- Class = Blueprint.
- Object = Instance of a class.
- `new` creates an object.
- Object memory is allocated in the Heap.
- Reference variables (local) are stored in the Stack.
- Fields store data.
- Methods define behavior.
- One class can create many objects.
- `this` refers to the current object.

---

# Keywords

- Class
- Object
- Blueprint
- Instance
- Heap
- Stack
- Fields
- Methods
- new Keyword
- Reference Variable
- Instance Variable
- this Keyword
- Constructor
- Object-Oriented Programming
```