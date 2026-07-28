# SOLID Principles

## What are SOLID Principles?

**SOLID** is a collection of **5 Object-Oriented Design Principles** that help developers write code that is:

- Easy to understand
- Easy to maintain
- Easy to extend
- Easy to test
- Less tightly coupled

These principles are widely used in **Spring Boot**, **Microservices**, and large-scale enterprise applications.

> **Definition:** SOLID is a set of five design principles that help developers build flexible, maintainable, and scalable software.

---

# Why Do We Need SOLID?

Imagine a project with hundreds of classes.

Without SOLID,

```text
Huge Class

↓

Many Responsibilities

↓

Hard to Maintain

↓

More Bugs

↓

Difficult Testing
```

With SOLID,

```text
Small Classes

↓

Single Responsibility

↓

Easy Maintenance

↓

Easy Testing

↓

Easy Extension
```

---

# Real-World Example

Imagine a hospital.

```text
Doctor

↓

Treat Patients
```

```text
Receptionist

↓

Book Appointments
```

```text
Accountant

↓

Handle Payments
```

Each person has one responsibility.

If one person handled everything,

the system would become difficult to manage.

Similarly,

software classes should also have clear responsibilities.

---

# What Does SOLID Stand For?

```text
S → Single Responsibility Principle

O → Open/Closed Principle

L → Liskov Substitution Principle

I → Interface Segregation Principle

D → Dependency Inversion Principle
```

---

# 1. Single Responsibility Principle (SRP)

## Definition

A class should have **only one reason to change**.

In simple words,

one class should perform **one responsibility only**.

---

### Bad Example

```java
class UserService{

    void registerUser(){

    }

    void sendEmail(){

    }

    void saveToDatabase(){

    }

}
```

The class handles

- Registration
- Email
- Database

Too many responsibilities.

---

### Good Example

```java
class UserService{

    void registerUser(){

    }

}

class EmailService{

    void sendEmail(){

    }

}

class UserRepository{

    void save(){

    }

}
```

Each class has one responsibility.

---

### Production Usage

Spring Boot follows SRP.

```text
Controller

↓

Service

↓

Repository
```

Each layer has its own responsibility.

---

# 2. Open/Closed Principle (OCP)

## Definition

Software should be

- **Open for Extension**
- **Closed for Modification**

Instead of modifying existing code,

extend it.

---

### Bad Example

```java
class PaymentService{

    void pay(String type){

        if(type.equals("UPI")){

        }

        else if(type.equals("CARD")){

        }

    }

}
```

Every new payment method requires changing this class.

---

### Good Example

```java
interface Payment{

    void pay();

}

class UpiPayment implements Payment{

    public void pay(){

    }

}

class CardPayment implements Payment{

    public void pay(){

    }

}
```

Adding a new payment method

does not require modifying existing classes.

---

### Production Usage

Spring Boot

```text
Payment Interface

↓

UPI

Card

Wallet

Crypto
```

New implementations can be added without changing existing code.

---

# 3. Liskov Substitution Principle (LSP)

## Definition

A child class should be able to replace its parent class **without changing the correctness of the program**.

---

### Good Example

```java
class Animal{

    void sound(){

    }

}

class Dog extends Animal{

    @Override

    void sound(){

    }

}
```

Usage

```java
Animal animal = new Dog();

animal.sound();
```

Works correctly.

---

### Bad Example

```java
class Bird{

    void fly(){

    }

}

class Penguin extends Bird{

    @Override

    void fly(){

        throw new UnsupportedOperationException();

    }

}
```

Penguins cannot fly.

The inheritance hierarchy is incorrect.

---

### Better Design

```text
Bird

↓

FlyingBird

↓

Eagle

Parrot

Bird

↓

Penguin
```

---

### Production Usage

Whenever a subclass cannot properly behave like its parent,

the design should be reconsidered.

---

# 4. Interface Segregation Principle (ISP)

## Definition

Clients should **not be forced to implement methods they do not use**.

Prefer many small interfaces over one large interface.

---

### Bad Example

```java
interface Worker{

    void work();

    void eat();

}
```

```java
class Robot implements Worker{

    public void work(){

    }

    public void eat(){

    }

}
```

A robot does not eat.

---

### Good Example

```java
interface Workable{

    void work();

}

interface Eatable{

    void eat();

}
```

```java
class Human
        implements Workable, Eatable{

}

class Robot
        implements Workable{

}
```

Each class implements only what it needs.

---

### Production Usage

Spring Data JPA provides many small repository interfaces,

allowing developers to implement only required functionality.

---

# 5. Dependency Inversion Principle (DIP)

## Definition

High-level modules should **depend on abstractions, not concrete implementations**.

---

### Bad Example

```java
class UserService{

    private MySqlDatabase database =
            new MySqlDatabase();

}
```

The service is tightly coupled to MySQL.

---

### Good Example

```java
interface Database{

    void save();

}

class MySqlDatabase
        implements Database{

    public void save(){

    }

}

class UserService{

    private Database database;

    UserService(Database database){

        this.database = database;

    }

}
```

Now,

`UserService` depends on the interface,

not the implementation.

---

### Spring Boot Example

```java
@Service

public class UserService{

    private final UserRepository repository;

    public UserService(UserRepository repository){

        this.repository = repository;

    }

}
```

Spring injects the implementation automatically.

This is **Dependency Injection**, which follows DIP.

---

# SOLID Summary

| Principle | Meaning |
|------------|---------|
| SRP | One responsibility per class |
| OCP | Extend without modifying existing code |
| LSP | Child objects should replace parent objects safely |
| ISP | Create small, focused interfaces |
| DIP | Depend on abstractions, not implementations |

---

# Internal Working

A Spring Boot application commonly follows SOLID like this:

```text
Controller

↓

Service Interface

↓

Service Implementation

↓

Repository Interface

↓

Database
```

Each layer has a single responsibility,

depends on abstractions,

and can be replaced independently.

---

# Production Usage

SOLID principles are used in

- Spring Boot
- Hibernate
- Microservices
- Android Development
- Enterprise Applications
- Design Patterns

Almost every large Java application follows these principles.

---

# Advantages

- Easy maintenance
- Better scalability
- Cleaner code
- Easier testing
- Loose coupling
- High reusability

---

# Limitations

- More classes and interfaces
- Slightly higher initial design effort
- Can feel excessive for very small projects

---

# Best Practices

✅ Keep each class focused on one job.

✅ Prefer interfaces over concrete classes.

✅ Use constructor injection.

✅ Favor composition over unnecessary inheritance.

✅ Keep interfaces small and meaningful.

---

# Common Mistakes

❌ Creating "God Classes" with many responsibilities.

---

❌ Depending directly on concrete classes.

---

❌ Creating huge interfaces with unrelated methods.

---

❌ Modifying existing code instead of extending it.

---

❌ Using inheritance where composition is more appropriate.

---

# Interview Questions

### 1. What does SOLID stand for?

- Single Responsibility Principle
- Open/Closed Principle
- Liskov Substitution Principle
- Interface Segregation Principle
- Dependency Inversion Principle

---

### 2. What is SRP?

A class should have only one responsibility or one reason to change.

---

### 3. What is OCP?

Software should be open for extension but closed for modification.

---

### 4. What is LSP?

A subclass should be usable wherever its parent class is expected without breaking the program.

---

### 5. What is ISP?

Clients should not be forced to depend on methods they don't use.

---

### 6. What is DIP?

High-level modules should depend on abstractions instead of concrete implementations.

---

### 7. How does Spring Boot follow DIP?

Through Dependency Injection using interfaces and constructor injection.

---

### 8. Why are SOLID principles important?

They improve maintainability, scalability, flexibility, and testability.

---

### 9. Which SOLID principle is most visible in Spring Boot?

Dependency Inversion Principle (DIP), implemented through Dependency Injection.

---

### 10. Can small projects ignore SOLID?

Small projects may not need every principle immediately, but following SOLID generally leads to cleaner, more maintainable code as the project grows.

---

# Quick Revision

- **S** → Single Responsibility Principle
- **O** → Open/Closed Principle
- **L** → Liskov Substitution Principle
- **I** → Interface Segregation Principle
- **D** → Dependency Inversion Principle
- Spring Boot heavily uses **DIP** through Dependency Injection.
- SOLID makes software easier to maintain, test, and extend.

---

# Keywords

- SOLID
- SRP
- OCP
- LSP
- ISP
- DIP
- Dependency Injection
- Constructor Injection
- Loose Coupling
- Abstraction
- Interface
- Spring Boot
- Design Principles
- Clean Code
```