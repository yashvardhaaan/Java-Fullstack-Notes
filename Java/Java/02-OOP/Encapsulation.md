# Encapsulation

## What is Encapsulation?

**Encapsulation** is the process of **binding data (fields) and methods together into a single unit (class)** while **restricting direct access to the data**.

Instead of allowing anyone to modify object data directly, access is controlled using **private fields** and **public methods (getters and setters)**.

> **Definition:** Encapsulation is an OOP principle that protects an object's data by hiding it and providing controlled access through methods.

---

# Why Do We Need Encapsulation?

Suppose we have

```java
class Student{

    String name;

    int age;

}
```

Anyone can modify the data.

```java
Student s = new Student();

s.age = -10;
```

Now,

```text
Age = -10
```

This is invalid.

Encapsulation prevents such situations.

---

# Real-World Example

Imagine an ATM.

Without Encapsulation

```text
Bank Account

↓

Anyone Can Change Balance
```

With Encapsulation

```text
Bank Account

↓

ATM

↓

Deposit

Withdraw

Check Balance
```

You cannot directly change the balance.

You must use the ATM.

Similarly,

objects should expose methods,

not internal variables.

---

# How Encapsulation Works

Encapsulation uses

- Private Fields
- Public Methods

```text
User

↓

Getter / Setter

↓

Private Variables
```

---

# Without Encapsulation

```java
class Student{

    public String name;

    public int age;

}
```

Usage

```java
Student s = new Student();

s.age = -20;
```

Invalid data is stored.

---

# With Encapsulation

```java
class Student{

    private String name;

    private int age;

}
```

Now,

direct access is not allowed.

```java
Student s = new Student();

// s.age = 20; ❌
```

Compiler

```text
Error

↓

age has private access
```

---

# Getter Method

A Getter returns the value.

Example

```java
class Student{

    private String name;

    public String getName(){

        return name;

    }

}
```

Usage

```java
Student s = new Student();

System.out.println(s.getName());
```

---

# Setter Method

A Setter updates the value.

```java
class Student{

    private String name;

    public void setName(String name){

        this.name = name;

    }

}
```

Usage

```java
Student s = new Student();

s.setName("John");
```

---

# Complete Example

```java
class Student{

    private String name;

    private int age;

    public String getName(){

        return name;

    }

    public void setName(String name){

        this.name = name;

    }

    public int getAge(){

        return age;

    }

    public void setAge(int age){

        this.age = age;

    }

}
```

Usage

```java
Student s = new Student();

s.setName("John");

s.setAge(20);

System.out.println(s.getName());
```

---

# Validation Using Setters

One major advantage of Encapsulation is validation.

```java
public void setAge(int age){

    if(age > 0){

        this.age = age;

    }

}
```

Now,

```java
s.setAge(-5);
```

The invalid value is rejected.

---

# Read-Only Class

Suppose we only provide Getter.

```java
private String name;

public String getName(){

    return name;

}
```

No Setter.

Result

```text
Read Only
```

The value can be read,

but not modified.

---

# Write-Only Class

Suppose we only provide Setter.

```java
public void setPassword(String password){

    this.password = password;

}
```

No Getter.

Result

```text
Write Only
```

Often used for passwords.

---

# Immutable Class

An Immutable object cannot be modified after creation.

Example

```java
class Student{

    private final String name;

    public Student(String name){

        this.name = name;

    }

    public String getName(){

        return name;

    }

}
```

Characteristics

- Private fields
- Final fields
- No setters

Example

```java
String
```

is immutable.

---

# JavaBean

A JavaBean is a class that follows these rules:

- Private fields
- Public getters
- Public setters
- Public no-argument constructor

Example

```java
class User{

    private String name;

    public User(){

    }

    public String getName(){

        return name;

    }

    public void setName(String name){

        this.name = name;

    }

}
```

Frameworks like Spring and Hibernate commonly work with JavaBeans.

---

# Encapsulation vs Data Hiding

Many people think they are the same.

| Encapsulation | Data Hiding |
|---------------|-------------|
| Bundles data and methods | Restricts access to data |
| OOP Principle | Implementation technique |
| Achieved using classes | Achieved using access modifiers |

Data Hiding is one way to achieve Encapsulation.

---

# Internal Working

Suppose

```java
Student s = new Student();

s.setAge(20);
```

Internally

```text
Object

↓

Setter Called

↓

Validation

↓

Private Variable Updated
```

No direct access to the variable occurs.

---

# Production Usage

Encapsulation is used everywhere.

Examples

- Spring Boot Entities
- DTOs
- Configuration Classes
- Domain Models
- Hibernate Entities

Example

```java
public class User{

    private Long id;

    private String username;

}
```

The fields are private,

and access is provided through methods.

---

# Advantages

- Data security
- Data validation
- Better maintainability
- Loose coupling
- Easy debugging
- Better code organization

---

# Limitations

- Slightly more code
- Getters and setters may seem repetitive
- Poorly designed setters can still allow invalid data

---

# Best Practices

✅ Keep fields private.

✅ Validate data inside setters.

✅ Make fields `final` whenever possible.

✅ Expose only required methods.

---

# Common Mistakes

❌ Making every field public.

---

❌ Writing setters without validation.

---

❌ Returning mutable internal objects directly.

---

❌ Generating getters and setters for every field without considering whether modification should be allowed.

---

# Interview Questions

### 1. What is Encapsulation?

Encapsulation is the process of binding data and methods together while restricting direct access to data.

---

### 2. Why do we use Encapsulation?

To protect object data, validate input, and improve maintainability.

---

### 3. How is Encapsulation achieved?

Using:

- Private fields
- Public getters
- Public setters

---

### 4. What is Data Hiding?

Restricting direct access to an object's internal data using access modifiers.

---

### 5. What is the difference between Encapsulation and Data Hiding?

Encapsulation bundles data and behavior together.

Data Hiding prevents direct access to internal data.

---

### 6. What is a Getter?

A method that returns the value of a private field.

---

### 7. What is a Setter?

A method that updates the value of a private field, often with validation.

---

### 8. What is an Immutable Class?

A class whose objects cannot be modified after creation.

---

### 9. What is a JavaBean?

A class with private fields, public getters/setters, and a public no-argument constructor.

---

### 10. How is Encapsulation used in Spring Boot?

Entities, DTOs, request/response objects, and configuration classes typically use private fields with controlled access through methods.

---

# Quick Revision

- Encapsulation = Data + Methods in one class.
- Uses:
  - Private fields
  - Public getters
  - Public setters
- Prevents direct data modification.
- Enables validation.
- Supports immutable objects.
- JavaBeans follow encapsulation principles.
- Widely used in Spring Boot and Hibernate.

---

# Keywords

- Encapsulation
- Data Hiding
- Private
- Getter
- Setter
- Validation
- Immutable Class
- JavaBean
- Access Modifiers
- OOP
- Spring Boot
- Hibernate
- DTO
- Entity
```