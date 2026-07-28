# Abstraction

## What is Abstraction?

**Abstraction** is the process of **hiding implementation details and showing only the essential features** of an object.

The user only knows **what** an object does, not **how** it does it.

> **Definition:** Abstraction is an OOP principle that hides complex implementation details and exposes only the necessary functionality.

---

# Why Do We Need Abstraction?

Suppose you're driving a car.

You only need to know

- Start the car
- Press the accelerator
- Apply the brake

You don't need to know

- How fuel is injected
- How the engine works
- How gears rotate

Similarly,

software users should only interact with required features.

---

# Real-World Example

ATM Machine

```text
User

↓

Insert Card

↓

Enter PIN

↓

Withdraw Money

↓

ATM Performs Internal Operations

↓

Cash Dispensed
```

The customer only sees the options,

not the banking logic.

Similarly,

Java hides complex implementation from users.

---

# How Abstraction Works

```text
User

↓

Interface / Abstract Class

↓

Concrete Class

↓

Implementation
```

The user interacts only with the interface or abstract class.

---

# Ways to Achieve Abstraction

Java provides two ways.

```text
Abstraction

├── Abstract Class
└── Interface
```

---

# Example Without Abstraction

```java
class Car{

    void startEngine(){

        System.out.println("Checking Battery");

        System.out.println("Injecting Fuel");

        System.out.println("Starting Engine");

    }

}
```

The user sees all implementation details.

---

# Example With Abstraction

```java
abstract class Vehicle{

    abstract void start();

}
```

Implementation

```java
class Car extends Vehicle{

    @Override

    void start(){

        System.out.println("Car Started");

    }

}
```

Usage

```java
Vehicle vehicle = new Car();

vehicle.start();
```

Output

```text
Car Started
```

The user only calls `start()`.

---

# Abstract Method

An abstract method has

- No implementation
- Only declaration

Example

```java
abstract class Animal{

    abstract void sound();

}
```

Subclasses must implement it.

---

# Concrete Method

An abstract class can also contain normal methods.

```java
abstract class Animal{

    void sleep(){

        System.out.println("Sleeping");

    }

}
```

---

# Abstraction Using Interface

```java
interface Payment{

    void pay();

}
```

Implementation

```java
class UpiPayment implements Payment{

    @Override

    public void pay(){

        System.out.println("UPI Payment");

    }

}
```

Usage

```java
Payment payment = new UpiPayment();

payment.pay();
```

Output

```text
UPI Payment
```

---

# Memory Representation

```java
Vehicle vehicle = new Car();
```

Memory

```text
Stack

↓

vehicle

↓

Heap

↓

Car Object

↓

start()
```

The reference type is `Vehicle`,

but the object is `Car`.

---

# Abstraction vs Encapsulation

| Abstraction | Encapsulation |
|-------------|---------------|
| Hides implementation | Hides data |
| Focuses on "What" | Focuses on "How" data is protected |
| Achieved using Abstract Classes and Interfaces | Achieved using private fields and getters/setters |

---

# Abstraction vs Inheritance

| Abstraction | Inheritance |
|-------------|-------------|
| Hides implementation | Reuses code |
| Defines behavior | Extends behavior |
| Uses abstract classes/interfaces | Uses `extends` keyword |

---

# Abstraction vs Polymorphism

| Abstraction | Polymorphism |
|-------------|--------------|
| Defines what operations are available | Decides which implementation executes |
| Achieved through interfaces/abstract classes | Achieved through overriding and overloading |

---

# Internal Working

Suppose

```java
Vehicle vehicle = new Car();

vehicle.start();
```

Internally

```text
Vehicle Reference

↓

Car Object

↓

JVM Finds Car.start()

↓

Execute
```

The user only knows `start()`.

The implementation remains hidden.

---

# Production Usage

Abstraction is heavily used in Java.

Examples

- Spring Boot Services
- Repository Interfaces
- JDBC
- Servlet API
- Collection Framework

Spring Boot Example

```java
public interface UserService{

    void registerUser();

}
```

Implementation

```java
@Service

public class UserServiceImpl
        implements UserService{

    @Override

    public void registerUser(){

    }

}
```

The controller depends only on `UserService`.

---

# Advantages

- Hides complexity
- Loose coupling
- Easier maintenance
- Improves code readability
- Easier testing
- Flexible design

---

# Limitations

- Adds more classes/interfaces
- Learning curve for beginners
- Over-abstraction can make code harder to follow

---

# Best Practices

✅ Expose only necessary methods.

✅ Program to interfaces instead of implementations.

✅ Keep implementation details private.

✅ Use meaningful abstraction levels.

---

# Common Mistakes

❌ Confusing abstraction with encapsulation.

---

❌ Creating interfaces with only one unnecessary implementation.

---

❌ Exposing internal implementation through public methods.

---

❌ Putting business logic directly into interfaces.

---

# Interview Questions

### 1. What is Abstraction?

Abstraction hides implementation details and exposes only essential functionality.

---

### 2. Why is Abstraction used?

To reduce complexity, improve maintainability, and hide implementation details.

---

### 3. How is Abstraction achieved in Java?

Using

- Abstract Classes
- Interfaces

---

### 4. Can an abstract class have implemented methods?

Yes.

It can contain both abstract and concrete methods.

---

### 5. Can we create an object of an abstract class?

No.

Abstract classes cannot be instantiated directly.

---

### 6. What is an abstract method?

A method without a body that must be implemented by subclasses.

---

### 7. What is the difference between Abstraction and Encapsulation?

Abstraction hides implementation.

Encapsulation hides data.

---

### 8. Why are interfaces important for abstraction?

They define a contract that multiple classes can implement in different ways.

---

### 9. Where is Abstraction used in Spring Boot?

- Service interfaces
- Repository interfaces
- Strategy pattern implementations
- Dependency Injection

---

### 10. What is the main benefit of Abstraction?

It allows developers to focus on **what an object does** instead of **how it does it**.

---

# Quick Revision

- Abstraction = Hiding implementation details.
- Shows only essential features.
- Achieved using:
  - Abstract Classes
  - Interfaces
- Abstract methods have no body.
- Abstract classes cannot be instantiated.
- Widely used in Spring Boot through interfaces and Dependency Injection.

---

# Keywords

- Abstraction
- Abstract Class
- Abstract Method
- Interface
- Implementation Hiding
- OOP
- extends
- implements
- Dependency Injection
- Spring Boot
- Contract
- Loose Coupling
```