# Polymorphism

## What is Polymorphism?

**Polymorphism** means **"many forms."**

In Java, the same method call can perform different actions depending on the object.

For example,

```java
animal.sound();
```

may produce

```text
Dog → Bark

Cat → Meow

Lion → Roar
```

The method call is the same,

but the behavior changes.

> **Definition:** Polymorphism is an OOP concept where one interface or method can have multiple implementations.

---

# Why Do We Need Polymorphism?

Without Polymorphism

```java
Dog dog = new Dog();
dog.sound();

Cat cat = new Cat();
cat.sound();

Lion lion = new Lion();
lion.sound();
```

Every object must be handled separately.

With Polymorphism

```java
Animal animal;

animal = new Dog();
animal.sound();

animal = new Cat();
animal.sound();

animal = new Lion();
animal.sound();
```

Same reference,

different behavior.

---

# Real-World Example

Imagine a remote control.

```text
Remote

↓

TV

↓

AC

↓

Speaker
```

The same **Power Button** behaves differently depending on the device.

Similarly,

```text
Animal

↓

Dog

↓

Cat

↓

Lion
```

The same method call behaves differently.

---

# Types of Polymorphism

```text
Polymorphism

├── Compile-Time Polymorphism
└── Runtime Polymorphism
```

---

# 1. Compile-Time Polymorphism

Also called

- Static Polymorphism
- Method Overloading

The compiler decides which method to call.

Example

```java
class Calculator{

    int add(int a, int b){

        return a + b;

    }

    double add(double a, double b){

        return a + b;

    }

}
```

Usage

```java
Calculator c = new Calculator();

c.add(10,20);

c.add(10.5,20.5);
```

Compiler selects the correct method.

---

# Method Overloading

Same method name,

Different parameter list.

Example

```java
class Print{

    void show(String s){

    }

    void show(int n){

    }

    void show(double d){

    }

}
```

Rules

- Same method name
- Different parameters
- Return type alone cannot differ

---

# Invalid Overloading

```java
int add(int a){

    return a;

}

double add(int a){

    return a;

}
```

Compiler Error.

Only changing the return type is **not** overloading.

---

# 2. Runtime Polymorphism

Also called

- Dynamic Polymorphism
- Method Overriding

The JVM decides which method to execute during runtime.

---

# Method Overriding

```java
class Animal{

    void sound(){

        System.out.println("Animal");

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
Animal animal = new Dog();

animal.sound();
```

Output

```text
Bark
```

The decision happens at runtime.

---

# Dynamic Method Dispatch

Example

```java
Animal animal = new Dog();

animal.sound();
```

Execution

```text
Animal Reference

↓

Dog Object

↓

sound()

↓

Dog Version Executes
```

This runtime decision is called **Dynamic Method Dispatch**.

---

# Upcasting

Converting a Child reference into a Parent reference.

Example

```java
Dog dog = new Dog();

Animal animal = dog;
```

or

```java
Animal animal = new Dog();
```

Diagram

```text
Dog Object

↓

Animal Reference
```

Upcasting is

- Automatic
- Safe

---

# Downcasting

Converting a Parent reference back to a Child reference.

Example

```java
Animal animal = new Dog();

Dog dog = (Dog) animal;
```

Diagram

```text
Animal Reference

↓

Dog Reference
```

Downcasting requires an explicit cast.

---

# Invalid Downcasting

```java
Animal animal = new Animal();

Dog dog = (Dog) animal;
```

Runtime

```text
ClassCastException
```

The object is actually an `Animal`, not a `Dog`.

---

# instanceof Operator

Before downcasting,

check the object type.

```java
if(animal instanceof Dog){

    Dog dog = (Dog) animal;

}
```

This prevents `ClassCastException`.

---

# Polymorphism Example

```java
class Animal{

    void sound(){

        System.out.println("Animal");

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
```

Output

```text
Bark

Meow
```

---

# Compile-Time vs Runtime Polymorphism

| Compile-Time | Runtime |
|---------------|----------|
| Method Overloading | Method Overriding |
| Compiler decides | JVM decides |
| Faster | Slightly slower |
| Same class | Parent-Child classes |

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

Points to Dog Object

↓

JVM Looks Inside Dog

↓

Dog.sound()

↓

Execute
```

The method depends on the object,

not the reference type.

---

# Production Usage

Polymorphism is used everywhere.

Examples

- Spring Boot
- Hibernate
- Collections Framework
- JDBC
- Servlet API

Spring Boot Example

```java
PaymentService payment;

payment = new UpiPayment();

payment.pay();

payment = new CardPayment();

payment.pay();
```

The same method works for different payment implementations.

---

# Advantages

- Code reusability
- Loose coupling
- Extensibility
- Cleaner design
- Easier maintenance

---

# Limitations

- Runtime polymorphism has slight method lookup overhead
- Excessive inheritance can complicate design
- Incorrect downcasting causes exceptions

---

# Best Practices

✅ Program to interfaces or parent classes.

✅ Always use `@Override`.

✅ Prefer polymorphism over long `if-else` chains.

✅ Use `instanceof` before downcasting if necessary.

---

# Common Mistakes

❌ Confusing overloading with overriding.

---

❌ Forgetting `@Override`.

---

❌ Unsafe downcasting.

```java
Dog dog = (Dog) animal;
```

without checking the actual object type.

---

❌ Thinking the reference type decides which overridden method executes.

The **object type** decides.

---

# Interview Questions

### 1. What is Polymorphism?

Polymorphism allows the same method call to behave differently depending on the object.

---

### 2. What are the types of Polymorphism?

- Compile-Time (Method Overloading)
- Runtime (Method Overriding)

---

### 3. What is Method Overloading?

Multiple methods with the same name but different parameter lists.

---

### 4. What is Method Overriding?

A child class provides its own implementation of a parent class method.

---

### 5. What is Dynamic Method Dispatch?

The JVM deciding which overridden method to execute at runtime based on the object's actual type.

---

### 6. What is Upcasting?

Assigning a child object to a parent reference.

Example

```java
Animal animal = new Dog();
```

---

### 7. What is Downcasting?

Converting a parent reference back to a child reference using an explicit cast.

---

### 8. Why use `instanceof`?

To verify the object's type before downcasting and avoid `ClassCastException`.

---

### 9. Which is faster: Overloading or Overriding?

Method Overloading is resolved at compile time and is generally faster than runtime method dispatch.

---

### 10. How is Polymorphism used in Spring Boot?

Spring injects different implementations through interfaces, allowing the same interface methods to work with different implementations.

---

# Quick Revision

- Polymorphism = Many Forms.
- Types:
  - Compile-Time → Overloading
  - Runtime → Overriding
- Runtime polymorphism uses Dynamic Method Dispatch.
- Upcasting is automatic.
- Downcasting requires explicit casting.
- Use `instanceof` before downcasting.
- JVM chooses overridden methods based on the object's type.

---

# Keywords

- Polymorphism
- Method Overloading
- Method Overriding
- Compile-Time Polymorphism
- Runtime Polymorphism
- Dynamic Method Dispatch
- Upcasting
- Downcasting
- instanceof
- @Override
- OOP
- Java
- Spring Boot
```