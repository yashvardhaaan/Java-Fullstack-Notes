# Constructors

## What is a Constructor?

A **Constructor** is a special method that is automatically called when an object is created.

Its main purpose is to **initialize the object**.

> **Definition:** A Constructor is a special member of a class that has the same name as the class and is automatically executed when an object is created.

---

# Why Do We Need Constructors?

Suppose we have

```java
class Student{

    String name;

    int age;

}
```

Creating an object

```java
Student s = new Student();
```

Now,

```java
System.out.println(s.name);
```

Output

```text
null
```

Because the object was not initialized.

Instead,

```java
Student s = new Student("John",20);
```

The constructor initializes the object immediately.

---

# Real-World Example

Imagine buying a new phone.

Without Constructor

```text
Phone

↓

No SIM

↓

No Language

↓

No WiFi
```

You must configure everything manually.

With Constructor

```text
Phone

↓

Configured

↓

Ready to Use
```

Similarly,

Constructors prepare objects before they are used.

---

# Constructor Syntax

```java
class Student{

    Student(){

    }

}
```

Notice

- Same name as class
- No return type
- Called automatically

---

# Characteristics

A constructor

- Has the same name as the class
- Has no return type
- Executes automatically
- Can be overloaded
- Initializes objects

---

# Default Constructor

If you do not create any constructor,

the Java compiler automatically provides one.

Example

```java
class Student{

}
```

Compiler internally creates

```java
class Student{

    Student(){

    }

}
```

This is called the **Default Constructor**.

---

# User-Defined Constructor

Example

```java
class Student{

    Student(){

        System.out.println("Object Created");

    }

}
```

Usage

```java
Student s = new Student();
```

Output

```text
Object Created
```

Now,

the compiler does **not** generate a default constructor.

---

# Parameterized Constructor

A constructor can accept parameters.

```java
class Student{

    String name;

    int age;

    Student(String name, int age){

        this.name = name;

        this.age = age;

    }

}
```

Usage

```java
Student s =
        new Student("John",20);
```

Memory

```text
Heap

↓

Student Object

↓

name = John

↓

age = 20
```

---

# Constructor Overloading

Multiple constructors can exist in the same class.

```java
class Student{

    Student(){

    }

    Student(String name){

    }

    Student(String name,int age){

    }

}
```

Compiler chooses the constructor based on arguments.

---

# Constructor Chaining

One constructor can call another constructor.

Example

```java
class Student{

    Student(){

        this("John");

    }

    Student(String name){

        System.out.println(name);

    }

}
```

Usage

```java
new Student();
```

Output

```text
John
```

---

# this()

`this()` calls another constructor of the **same class**.

```java
Student(){

    this("Java");

}
```

Rules

- Must be the first statement.
- Calls another constructor in the same class.

---

# super()

`super()` calls the constructor of the **parent class**.

Example

```java
class Animal{

    Animal(){

        System.out.println("Animal");

    }

}

class Dog extends Animal{

    Dog(){

        super();

        System.out.println("Dog");

    }

}
```

Output

```text
Animal

Dog
```

If not written explicitly,

Java inserts `super()` automatically (if the parent has a no-argument constructor).

---

# Constructor Execution Order

Example

```java
Animal

↓

Dog
```

Execution

```text
Parent Constructor

↓

Child Constructor
```

Parent constructors always execute first.

---

# Constructor vs Method

| Constructor | Method |
|-------------|--------|
| Initializes objects | Performs actions |
| Same name as class | Any valid name |
| No return type | Has a return type (or `void`) |
| Called automatically | Called explicitly |
| Executes once per object creation | Can be called many times |

---

# Can Constructors Be Private?

Yes.

Example

```java
class Database{

    private Database(){

    }

}
```

Used in

- Singleton Pattern
- Utility Classes
- Factory Methods

---

# Copy Constructor

Java does **not** provide a built-in copy constructor like C++.

We can create one manually.

Example

```java
class Student{

    String name;

    Student(Student s){

        this.name = s.name;

    }

}
```

Usage

```java
Student s2 =
        new Student(s1);
```

---

# Internal Working

Suppose

```java
Student s =
        new Student("John",20);
```

Internally

```text
new

↓

Heap Memory Allocated

↓

Fields Initialized

↓

Constructor Called

↓

Reference Returned

↓

Object Ready
```

---

# Production Usage

Constructors are used in every Java application.

Examples

- Spring Beans
- Entities
- DTOs
- Services
- Configuration Classes

Example

```java
public UserService(UserRepository repo){

    this.repo = repo;

}
```

This is called **Constructor Injection**, the recommended dependency injection approach in Spring Boot.

---

# Advantages

- Automatic initialization
- Cleaner code
- Object consistency
- Supports constructor overloading
- Required for Dependency Injection

---

# Limitations

- Cannot have a return type
- Cannot be inherited
- Cannot be overridden
- Cannot be `static`

---

# Best Practices

✅ Initialize mandatory fields in constructors.

✅ Prefer Constructor Injection in Spring Boot.

✅ Use constructor overloading carefully.

✅ Keep constructors simple.

---

# Common Mistakes

❌ Giving constructors a return type.

Incorrect

```java
public void Student(){

}
```

This is a method, not a constructor.

---

❌ Forgetting that `this()` must be the first statement.

---

❌ Calling both `this()` and `super()` in the same constructor.

Only one can appear, and it must be the first statement.

---

❌ Putting complex business logic inside constructors.

---

# Interview Questions

### 1. What is a Constructor?

A special member of a class used to initialize objects.

---

### 2. When is a constructor called?

Automatically when an object is created using the `new` keyword.

---

### 3. Can constructors have parameters?

Yes.

These are called **Parameterized Constructors**.

---

### 4. What is Constructor Overloading?

Creating multiple constructors with different parameter lists.

---

### 5. What is Constructor Chaining?

Calling one constructor from another using `this()`.

---

### 6. What is the difference between `this()` and `super()`?

| `this()` | `super()` |
|----------|-----------|
| Calls another constructor in the same class | Calls the parent class constructor |

---

### 7. Can constructors be private?

Yes.

They are commonly used in the Singleton design pattern.

---

### 8. Can constructors be overridden?

No.

Constructors are not inherited, so they cannot be overridden.

---

### 9. Why is Constructor Injection preferred in Spring Boot?

Because it makes dependencies mandatory, supports immutability, and improves testability.

---

### 10. What happens internally when `new` is used?

- Heap memory is allocated.
- Fields receive default values.
- Constructor is executed.
- Reference to the object is returned.

---

# Quick Revision

- Constructor initializes objects.
- Same name as class.
- No return type.
- Called automatically.
- Types:
  - Default Constructor
  - User-Defined Constructor
  - Parameterized Constructor
- Supports overloading.
- `this()` → Same class constructor.
- `super()` → Parent class constructor.
- Parent constructor executes first.
- Constructor Injection is preferred in Spring Boot.

---

# Keywords

- Constructor
- Default Constructor
- Parameterized Constructor
- Constructor Overloading
- Constructor Chaining
- `this()`
- `super()`
- Object Initialization
- Constructor Injection
- Singleton
- Heap Memory
- `new` Keyword
- Java OOP
```