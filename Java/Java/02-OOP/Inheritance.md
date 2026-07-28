# Inheritance

## What is Inheritance?

**Inheritance** is an Object-Oriented Programming (OOP) concept in which one class acquires the properties and behaviors of another class.

The existing class is called the **Parent (Super/Base) Class**, and the new class is called the **Child (Sub/Derived) Class**.

> **Definition:** Inheritance is the mechanism by which one class inherits the fields and methods of another class, promoting code reuse and creating an **IS-A** relationship.

---

# Why Do We Need Inheritance?

Suppose we have two classes.

```java
class Dog{

    String name;

    void eat(){

    }

}

class Cat{

    String name;

    void eat(){

    }

}
```

Notice

- Same variables
- Same methods

This duplicates code.

Instead,

create a common parent.

```text
Animal

↓

Dog

Cat
```

Now,

common code exists only once.

---

# Real-World Example

Imagine a family.

```text
Parent

↓

Child 1

Child 2
```

Children inherit characteristics from their parents.

Similarly,

```text
Animal

↓

Dog

Cat
```

Dog and Cat inherit common behavior from Animal.

---

# Syntax

```java
class Parent{

}

class Child extends Parent{

}
```

The keyword

```java
extends
```

creates an inheritance relationship.

---

# First Example

```java
class Animal{

    void eat(){

        System.out.println("Eating");

    }

}

class Dog extends Animal{

}
```

Usage

```java
Dog dog = new Dog();

dog.eat();
```

Output

```text
Eating
```

The `Dog` class inherits the `eat()` method.

---

# IS-A Relationship

Inheritance represents an **IS-A** relationship.

Examples

```text
Dog

IS-A

Animal
```

```text
Car

IS-A

Vehicle
```

Incorrect Example

```text
Engine

IS-A

Car
```

This is wrong.

Engine is **part of** a Car.

That is a **HAS-A** relationship (Composition), not Inheritance.

---

# Parent Class

```java
class Animal{

    void eat(){

        System.out.println("Eating");

    }

}
```

Contains common functionality.

---

# Child Class

```java
class Dog extends Animal{

    void bark(){

        System.out.println("Barking");

    }

}
```

Usage

```java
Dog dog = new Dog();

dog.eat();

dog.bark();
```

Output

```text
Eating

Barking
```

---

# Memory Representation

```java
Dog dog = new Dog();
```

Memory

```text
Stack

↓

dog

↓

Heap

↓

Dog Object

↓

Inherited Fields

↓

Own Fields
```

A `Dog` object contains both inherited and its own members.

---

# Constructor Execution

Example

```java
class Animal{

    Animal(){

        System.out.println("Animal");

    }

}

class Dog extends Animal{

    Dog(){

        System.out.println("Dog");

    }

}
```

Usage

```java
new Dog();
```

Output

```text
Animal

Dog
```

The parent constructor executes first.

---

# super Keyword

`super` refers to the **parent class**.

It can be used to

- Call parent constructor
- Access parent methods
- Access parent variables

---

# Calling Parent Constructor

```java
class Dog extends Animal{

    Dog(){

        super();

    }

}
```

If omitted,

Java automatically inserts `super()` (when possible).

---

# Access Parent Method

```java
class Animal{

    void eat(){

        System.out.println("Animal Eating");

    }

}

class Dog extends Animal{

    void display(){

        super.eat();

    }

}
```

---

# Access Parent Variable

```java
class Animal{

    String name = "Animal";

}

class Dog extends Animal{

    void print(){

        System.out.println(super.name);

    }

}
```

Output

```text
Animal
```

---

# Method Overriding

The child class can provide its own implementation.

```java
class Animal{

    void sound(){

        System.out.println("Animal Sound");

    }

}

class Dog extends Animal{

    @Override

    void sound(){

        System.out.println("Bark");

    }

}
```

Usage

```java
new Dog().sound();
```

Output

```text
Bark
```

---

# Types of Inheritance

### 1. Single Inheritance

```text
Animal

↓

Dog
```

Supported in Java.

---

### 2. Multilevel Inheritance

```text
Animal

↓

Dog

↓

Puppy
```

Supported.

---

### 3. Hierarchical Inheritance

```text
Animal

↓

Dog

Cat

Lion
```

Supported.

---

### 4. Multiple Inheritance

```text
A

↓

B

↓

C
```

One class inherits from multiple classes.

Example

```java
class C extends A, B
```

❌ Not supported for classes in Java.

Reason

Diamond Problem.

Java supports multiple inheritance through **Interfaces**.

---

### 5. Hybrid Inheritance

Combination of multiple inheritance types.

Supported only using interfaces.

---

# Diamond Problem

Suppose

```text
      Animal

      /    \

    Dog    Cat

      \    /

      Puppy
```

If both Dog and Cat define the same method,

which one should Puppy inherit?

This ambiguity is called the **Diamond Problem**.

Java avoids it by **not allowing multiple inheritance of classes**.

---

# Inheritance vs Composition

Inheritance

```text
Dog

IS-A

Animal
```

Composition

```text
Car

HAS-A

Engine
```

Prefer **Composition** when there is no true IS-A relationship.

---

# Internal Working

Suppose

```java
Dog dog = new Dog();

dog.eat();
```

Internally

```text
Animal Class Loaded

↓

Dog Class Loaded

↓

Dog Object Created

↓

Parent Constructor

↓

Child Constructor

↓

eat() Found in Parent

↓

Method Executed
```

---

# Production Usage

Inheritance is widely used in Java.

Examples

- Spring Framework
- Exception Hierarchy
- InputStream/OutputStream
- Collection Framework
- Servlet API

Example

```java
class RuntimeException
        extends Exception
```

Spring Example

```java
class JpaRepository
```

extends other repository interfaces to provide reusable functionality.

---

# Advantages

- Code reuse
- Better maintainability
- Supports polymorphism
- Reduces duplicate code
- Logical class hierarchy

---

# Limitations

- Tight coupling
- Deep inheritance trees become difficult to maintain
- Can reduce flexibility
- Not suitable for every relationship

---

# Best Practices

✅ Use Inheritance only for true **IS-A** relationships.

✅ Keep inheritance hierarchies shallow.

✅ Prefer Composition when appropriate.

✅ Use `@Override` while overriding methods.

---

# Common Mistakes

❌ Using inheritance for HAS-A relationships.

Example

```text
Car extends Engine
```

Incorrect.

---

❌ Forgetting that parent constructors execute first.

---

❌ Deep inheritance chains.

```text
A

↓

B

↓

C

↓

D

↓

E

↓

F
```

Hard to maintain.

---

❌ Overriding methods without `@Override`.

---

# Interview Questions

### 1. What is Inheritance?

Inheritance is an OOP mechanism where one class acquires the properties and methods of another class.

---

### 2. Which keyword is used for inheritance?

```java
extends
```

---

### 3. What is an IS-A relationship?

It represents inheritance.

Example

```text
Dog IS-A Animal
```

---

### 4. What is the difference between IS-A and HAS-A?

- IS-A → Inheritance
- HAS-A → Composition

---

### 5. What is the `super` keyword?

It refers to the parent class and is used to access parent constructors, methods, and variables.

---

### 6. Which constructor executes first?

The parent class constructor.

---

### 7. Does Java support multiple inheritance?

For classes, **No**.

For interfaces, **Yes**.

---

### 8. What is the Diamond Problem?

An ambiguity that occurs when a class inherits the same method from multiple parent classes.

---

### 9. What are the types of inheritance?

- Single
- Multilevel
- Hierarchical
- Multiple (not for classes)
- Hybrid (using interfaces)

---

### 10. Why is Inheritance important?

It promotes code reuse, supports polymorphism, and models real-world relationships.

---

# Quick Revision

- Inheritance creates an **IS-A** relationship.
- Uses the `extends` keyword.
- Child inherits parent fields and methods.
- Parent constructor executes first.
- `super` accesses parent members.
- Supports:
  - Single
  - Multilevel
  - Hierarchical
- Multiple inheritance of classes is **not supported**.
- Prefer Composition for **HAS-A** relationships.

---

# Keywords

- Inheritance
- Parent Class
- Child Class
- Superclass
- Subclass
- extends
- super
- IS-A
- HAS-A
- Method Overriding
- Constructor Chaining
- Diamond Problem
- Composition
- Java OOP
```