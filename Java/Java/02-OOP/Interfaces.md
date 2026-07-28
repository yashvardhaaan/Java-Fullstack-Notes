# Interfaces

## What is an Interface?

An **Interface** is a blueprint that defines a **contract** for classes.

It specifies **what a class should do**, but not **how it should do it**.

A class that implements an interface must provide implementations for its methods.

> **Definition:** An Interface is a reference type in Java that contains method declarations (and other members) that implementing classes must define.

---

# Why Do We Need Interfaces?

Suppose we have different payment methods.

```text
Credit Card

UPI

Net Banking

Wallet
```

All of them perform a payment,

but the implementation is different.

Instead of writing separate unrelated classes,

we define one contract.

```text
Payment

↓

UPI

Card

Wallet
```

Every payment class follows the same contract.

---

# Real-World Example

Imagine a charger socket.

```text
Wall Socket

↓

Mobile Charger

Laptop Charger

Tablet Charger
```

The socket defines the standard.

Different chargers implement it differently.

Similarly,

an interface defines rules,

and classes implement them.

---

# Syntax

```java
interface Animal{

    void sound();

}
```

A class implements it.

```java
class Dog implements Animal{

    @Override

    public void sound(){

        System.out.println("Bark");

    }

}
```

---

# Interface Example

```java
interface Animal{

    void sound();

}

class Dog implements Animal{

    @Override

    public void sound(){

        System.out.println("Bark");

    }

}
```

Usage

```java
Animal animal = new Dog();

animal.sound();
```

Output

```text
Bark
```

---

# implements Keyword

Interfaces are implemented using

```java
implements
```

Example

```java
class Dog implements Animal{

}
```

Unlike classes,

interfaces use `implements`, not `extends`.

---

# Multiple Interface Implementation

Java does not support multiple inheritance of classes,

but it supports implementing multiple interfaces.

```java
interface Fly{

    void fly();

}

interface Swim{

    void swim();

}

class Duck implements Fly, Swim{

    @Override

    public void fly(){

    }

    @Override

    public void swim(){

    }

}
```

Diagram

```text
        Fly

          \

           \

          Duck

           /

          /

       Swim
```

---

# Default Methods (Java 8)

Interfaces can have implemented methods using the `default` keyword.

```java
interface Animal{

    default void sleep(){

        System.out.println("Sleeping");

    }

}
```

The implementing class inherits this method.

---

# Static Methods

Interfaces can contain static methods.

```java
interface MathUtil{

    static void print(){

        System.out.println("Hello");

    }

}
```

Usage

```java
MathUtil.print();
```

---

# Private Methods (Java 9)

Interfaces can have private helper methods.

```java
interface Logger{

    private void log(){

        System.out.println("Logging");

    }

}
```

These methods are used internally by default or static methods.

---

# Variables in Interfaces

All variables are automatically

- `public`
- `static`
- `final`

Example

```java
interface Demo{

    int MAX = 100;

}
```

Compiler treats it as

```java
public static final int MAX = 100;
```

Attempting to modify it

```java
Demo.MAX = 200;
```

Compiler Error.

---

# Functional Interface

An interface with exactly **one abstract method**.

Example

```java
@FunctionalInterface

interface Calculator{

    int add(int a, int b);

}
```

Functional interfaces are used with **Lambda Expressions**.

---

# Interface vs Abstract Class

| Interface | Abstract Class |
|------------|----------------|
| Uses `implements` | Uses `extends` |
| Supports multiple implementation | Single inheritance |
| No constructors | Can have constructors |
| Variables are constants | Can have instance variables |
| Defines a contract | Provides partial implementation |

---

# Interface vs Class

| Interface | Class |
|------------|-------|
| Cannot create objects | Can create objects |
| Defines behavior | Defines state and behavior |
| Uses `implements` | Uses `extends` for inheritance |
| No instance variables | Can have instance variables |

---

# Memory Representation

```java
Animal animal = new Dog();
```

Memory

```text
Stack

↓

animal

↓

Heap

↓

Dog Object

↓

sound()
```

The reference type is `Animal`,

while the actual object is `Dog`.

---

# Internal Working

Suppose

```java
Animal animal = new Dog();

animal.sound();
```

Internally

```text
Animal Reference

↓

Dog Object

↓

JVM Finds Dog.sound()

↓

Execute
```

The interface reference points to the implementing object.

---

# Production Usage

Interfaces are used everywhere in Java.

Examples

- Spring Boot Services
- Spring Data JPA Repositories
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

The controller depends only on the interface,

making it easy to switch implementations.

---

# Advantages

- Loose coupling
- Supports multiple implementations
- Better testability
- Easier maintenance
- Promotes abstraction

---

# Limitations

- Cannot have instance variables
- Cannot be instantiated
- Too many interfaces can make projects harder to navigate

---

# Best Practices

✅ Program to interfaces, not implementations.

✅ Keep interfaces focused on one responsibility.

✅ Use meaningful method names.

✅ Use default methods only for common behavior.

---

# Common Mistakes

❌ Trying to instantiate an interface.

```java
Animal a = new Animal();
```

Not allowed.

---

❌ Forgetting to implement all abstract methods.

---

❌ Using interfaces to share state.

Interfaces should define behavior,

not object state.

---

❌ Creating very large interfaces with unrelated methods.

---

# Interview Questions

### 1. What is an Interface?

An interface is a contract that defines methods which implementing classes must provide.

---

### 2. Can we create an object of an Interface?

No.

Objects are created from implementing classes.

---

### 3. Which keyword is used to implement an Interface?

```java
implements
```

---

### 4. Can a class implement multiple interfaces?

Yes.

Java supports multiple interface implementation.

---

### 5. Can interfaces have constructors?

No.

Interfaces cannot have constructors because they cannot be instantiated.

---

### 6. Can interfaces contain implemented methods?

Yes.

Using

- `default` methods
- `static` methods

---

### 7. What are Functional Interfaces?

Interfaces with exactly one abstract method.

They are mainly used with Lambda Expressions.

---

### 8. What is the difference between an Interface and an Abstract Class?

Interfaces define contracts.

Abstract classes provide partial implementation and shared state.

---

### 9. Why are Interfaces heavily used in Spring Boot?

They support Dependency Injection, loose coupling, easy testing, and interchangeable implementations.

---

### 10. What are the default access modifiers for interface methods and variables?

- Methods → `public abstract` (unless `default`, `static`, or `private`)
- Variables → `public static final`

---

# Quick Revision

- Interface = Contract.
- Uses the `interface` keyword.
- Classes use `implements`.
- Supports multiple implementations.
- Cannot be instantiated.
- Variables are `public static final`.
- Methods are `public abstract` by default.
- Can contain `default`, `static`, and `private` methods.
- Functional Interfaces have one abstract method.
- Widely used in Spring Boot for Dependency Injection.

---

# Keywords

- Interface
- implements
- Contract
- Abstraction
- Default Method
- Static Method
- Private Method
- Functional Interface
- Lambda Expression
- Dependency Injection
- Loose Coupling
- Spring Boot
- Java OOP
- Multiple Inheritance