# Abstract Classes

## What is an Abstract Class?

An **Abstract Class** is a class that **cannot be instantiated (cannot create objects directly)**.

It is mainly used to provide a **common base** for multiple related classes.

An abstract class can contain:

- Abstract methods (without implementation)
- Concrete methods (with implementation)
- Variables
- Constructors
- Static methods
- Final methods

> **Definition:** An Abstract Class is a partially implemented class that provides common functionality while forcing child classes to implement specific methods.

---

# Why Do We Need Abstract Classes?

Suppose we have different animals.

```java
class Dog{

    void eat(){

    }

    void sound(){

        System.out.println("Bark");

    }

}

class Cat{

    void eat(){

    }

    void sound(){

        System.out.println("Meow");

    }

}
```

Notice,

`eat()` is common,

but `sound()` is different.

Instead,

```text
Animal (Abstract)

↓

Dog

Cat

Lion
```

The common code is written once,

while each child provides its own implementation.

---

# Real-World Example

Imagine a company.

```text
Employee

↓

Developer

Tester

Manager
```

Every employee has

- ID
- Name
- Salary

But,

their work is different.

So,

`Employee` can be an abstract class.

---

# Syntax

```java
abstract class Animal{

}
```

The keyword

```java
abstract
```

makes the class abstract.

---

# Abstract Method

An abstract method has

- No body
- Only declaration

```java
abstract class Animal{

    abstract void sound();

}
```

The child class must implement it.

---

# Concrete Method

An abstract class can also contain normal methods.

```java
abstract class Animal{

    void eat(){

        System.out.println("Eating");

    }

}
```

Child classes automatically inherit this method.

---

# Complete Example

```java
abstract class Animal{

    abstract void sound();

    void eat(){

        System.out.println("Eating");

    }

}

class Dog extends Animal{

    @Override

    void sound(){

        System.out.println("Bark");

    }

}

class Cat extends Animal{

    @Override

    void sound(){

        System.out.println("Meow");

    }

}
```

Usage

```java
Animal a1 = new Dog();

Animal a2 = new Cat();

a1.sound();

a2.sound();

a1.eat();
```

Output

```text
Bark

Meow

Eating
```

---

# Can We Create an Object?

No.

```java
Animal animal = new Animal();
```

Compiler Error

```text
Cannot instantiate the type Animal
```

Instead,

```java
Animal animal = new Dog();
```

This is valid.

---

# Constructors in Abstract Classes

Abstract classes can have constructors.

```java
abstract class Animal{

    Animal(){

        System.out.println("Animal Constructor");

    }

}
```

Usage

```java
class Dog extends Animal{

}

new Dog();
```

Output

```text
Animal Constructor
```

The constructor initializes the parent part of the object.

---

# Variables in Abstract Classes

Abstract classes can have instance variables.

```java
abstract class Animal{

    String name;

}
```

Child classes inherit these variables.

---

# Static Methods

Abstract classes can contain static methods.

```java
abstract class Animal{

    static void info(){

        System.out.println("Animals");

    }

}
```

Usage

```java
Animal.info();
```

---

# Final Methods

Abstract classes can also have final methods.

```java
abstract class Animal{

    final void sleep(){

        System.out.println("Sleeping");

    }

}
```

Child classes cannot override them.

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

Inherited Variables

↓

Inherited Methods

↓

Overridden Methods
```

---

# Rules of Abstract Classes

✅ Can contain abstract methods.

✅ Can contain normal methods.

✅ Can have constructors.

✅ Can have variables.

✅ Can have static methods.

✅ Can have final methods.

❌ Cannot be instantiated.

---

# Abstract Class vs Concrete Class

| Abstract Class | Concrete Class |
|----------------|----------------|
| Cannot create objects | Can create objects |
| May contain abstract methods | Cannot contain abstract methods |
| Can contain implemented methods | Contains only implemented methods |
| Used as a base class | Used directly |

---

# Abstract Class vs Interface

| Abstract Class | Interface |
|----------------|-----------|
| Uses `extends` | Uses `implements` |
| Can have constructors | Cannot have constructors |
| Can have instance variables | Only constants (`public static final`) |
| Single inheritance | Multiple interfaces can be implemented |
| Partial implementation | Contract/behavior definition |

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

Although the reference is `Animal`,

the actual object is `Dog`.

---

# Production Usage

Abstract classes are widely used.

Examples

- Spring Framework
- Servlet API
- Collection Framework
- InputStream
- OutputStream

Example

```java
abstract class HttpServlet
```

Developers extend it

instead of creating it directly.

Spring Boot Example

```java
abstract class BaseService{

    void log(){

    }

}
```

Different services inherit common functionality.

---

# Advantages

- Code reuse
- Partial implementation
- Common functionality
- Better maintainability
- Supports runtime polymorphism

---

# Limitations

- Cannot create objects directly
- Java supports only single class inheritance
- Overusing abstract classes can make designs rigid

---

# Best Practices

✅ Put common functionality in abstract classes.

✅ Declare only methods that every child must implement as abstract.

✅ Keep abstract classes focused on a single responsibility.

✅ Use interfaces when multiple unrelated classes need the same contract.

---

# Common Mistakes

❌ Trying to instantiate an abstract class.

---

❌ Forgetting to implement abstract methods in child classes.

---

❌ Using an abstract class when an interface is more appropriate.

---

❌ Making every method abstract even when common implementation exists.

---

# Interview Questions

### 1. What is an Abstract Class?

An abstract class is a class that cannot be instantiated and may contain both abstract and concrete methods.

---

### 2. Can an abstract class have constructors?

Yes.

Constructors are executed when a child object is created.

---

### 3. Can an abstract class have normal methods?

Yes.

It can contain both abstract and implemented methods.

---

### 4. Can an abstract class have variables?

Yes.

It can contain instance variables, static variables, and constants.

---

### 5. Can we create an object of an abstract class?

No.

Objects must be created through a concrete subclass.

---

### 6. Why do we use abstract classes?

To provide common functionality while forcing subclasses to implement specific behavior.

---

### 7. What is the difference between an abstract method and a concrete method?

| Abstract Method | Concrete Method |
|-----------------|-----------------|
| No implementation | Has implementation |
| Must be overridden | Can be inherited directly |

---

### 8. Can an abstract class contain static methods?

Yes.

---

### 9. When should we use an Abstract Class instead of an Interface?

Use an abstract class when related classes share common state or implementation.

Use an interface when only a common contract is needed.

---

### 10. Where are Abstract Classes used in Spring Boot?

They are commonly used for base services, template classes, framework classes, and reusable business logic.

---

# Quick Revision

- Abstract classes **cannot be instantiated**.
- Use the `abstract` keyword.
- Can contain:
  - Abstract methods
  - Concrete methods
  - Constructors
  - Variables
  - Static methods
  - Final methods
- Child classes extend abstract classes.
- Widely used for code reuse and runtime polymorphism.

---

# Keywords

- Abstract Class
- Abstract Method
- Concrete Method
- extends
- Runtime Polymorphism
- Constructor
- Partial Implementation
- OOP
- Code Reuse
- Spring Boot
- Base Class
- Java