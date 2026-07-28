# Default Methods (Java 8)

## What are Default Methods?

A **Default Method** is a method inside an interface that has a body.

It is declared using the **default** keyword.

Before Java 8, interfaces could contain only abstract methods.

Java 8 introduced **Default Methods** so that interfaces can evolve without breaking existing implementations.

> **Definition:** A Default Method is a method with an implementation inside an interface.

---

# Why Do We Need Default Methods?

Suppose an interface is already used by thousands of classes.

```java
interface Vehicle {

    void start();

}
```

Now suppose we want to add a new method.

```java
interface Vehicle {

    void start();

    void stop();

}
```

Every existing class must now implement `stop()`.

This breaks old code.

To solve this problem, Java introduced **Default Methods**.

```java
interface Vehicle {

    void start();

    default void stop() {

        System.out.println("Vehicle Stopped");

    }

}
```

Existing classes continue to work without modification.

---

# Real-World Example

Imagine a mobile phone.

```
Software Update

↓

New Feature Added

↓

Phone Still Works
```

Similarly,

```
Interface

↓

New Default Method Added

↓

Existing Classes Still Work
```

---

# Syntax

```java
interface Vehicle {

    default void stop() {

        System.out.println("Stopped");

    }

}
```

---

# Simple Example

```java
interface Vehicle {

    void start();

    default void stop() {

        System.out.println("Vehicle Stopped");

    }

}
```

Implementation

```java
class Car implements Vehicle {

    @Override
    public void start() {

        System.out.println("Car Started");

    }

}
```

Usage

```java
Car car = new Car();

car.start();

car.stop();
```

Output

```text
Car Started
Vehicle Stopped
```

---

# Overriding Default Methods

A class can override a Default Method.

```java
class Car implements Vehicle {

    @Override
    public void start() {

        System.out.println("Car Started");

    }

    @Override
    public void stop() {

        System.out.println("Car Stopped");

    }

}
```

Output

```text
Car Stopped
```

---

# Multiple Default Methods

```java
interface Vehicle {

    default void stop() {

        System.out.println("Stopped");

    }

    default void horn() {

        System.out.println("Horn");

    }

}
```

Interfaces can have multiple Default Methods.

---

# Static Methods in Interfaces

Java 8 also introduced **static methods** in interfaces.

```java
interface Vehicle {

    static void info() {

        System.out.println("Vehicle Interface");

    }

}
```

Calling

```java
Vehicle.info();
```

Output

```text
Vehicle Interface
```

Static methods belong to the interface itself and **cannot be overridden**.

---

# Default Method vs Static Method

| Default Method | Static Method |
|---------------|---------------|
| Called using object | Called using interface |
| Can be overridden | Cannot be overridden |
| Inherited by implementing class | Not inherited |

---

# Diamond Problem

Suppose two interfaces contain the same Default Method.

```java
interface A {

    default void show() {

        System.out.println("A");

    }

}

interface B {

    default void show() {

        System.out.println("B");

    }

}
```

Now

```java
class Test implements A, B {

}
```

Compilation Error

```text
Duplicate default methods
```

Java does not know which `show()` method to use.

---

# Solving Diamond Problem

The class must override the method.

```java
class Test implements A, B {

    @Override
    public void show() {

        System.out.println("Own Implementation");

    }

}
```

Or call a specific interface's method.

```java
class Test implements A, B {

    @Override
    public void show() {

        A.super.show();

    }

}
```

Output

```text
A
```

Similarly

```java
B.super.show();
```

calls B's implementation.

---

# Internal Working

Suppose

```java
car.stop();
```

Internally

```text
Method Call

↓

Does Class Override?

↓

Yes

↓

Call Class Method

↓

No

↓

Call Interface Default Method
```

The JVM first looks for the method in the implementing class. If not found, it uses the Default Method from the interface.

---

# Default Methods vs Abstract Methods

| Default Method | Abstract Method |
|---------------|-----------------|
| Has implementation | No implementation |
| Uses `default` keyword | No keyword needed |
| Optional to override | Must be implemented |
| Introduced in Java 8 | Available since Java 1 |

---

# Production Usage

Default Methods are widely used in:

- Java Collections Framework
- Streams API
- Spring Boot interfaces
- Library upgrades
- Backward compatibility

Example

Many interfaces in the Java Collections Framework gained new methods in Java 8 without breaking older code.

---

# Advantages

- Backward compatibility
- Less code duplication
- Easier library evolution
- Existing implementations continue to work
- Can provide common behavior

---

# Limitations

- Cannot store instance variables
- Can create ambiguity with multiple inheritance (Diamond Problem)
- Should not contain complex business logic

---

# Best Practices

✅ Keep Default Methods small.

✅ Use them only for common behavior.

✅ Override when class-specific behavior is required.

✅ Use Static Methods for utility functions.

---

# Common Mistakes

❌ Putting too much business logic inside Default Methods.

---

❌ Forgetting to resolve the Diamond Problem.

---

❌ Trying to override static interface methods.

---

❌ Using Default Methods instead of abstract methods when every implementation should provide its own logic.

---

# Interview Questions

### 1. What is a Default Method?

A method with an implementation inside an interface using the `default` keyword.

---

### 2. Why were Default Methods introduced?

To add new methods to existing interfaces without breaking existing implementations.

---

### 3. Can Default Methods be overridden?

Yes.

Implementing classes can override them.

---

### 4. Can interfaces have static methods?

Yes.

Java 8 introduced static methods in interfaces.

---

### 5. Can static interface methods be overridden?

No.

They belong to the interface itself.

---

### 6. What is the Diamond Problem?

It occurs when two interfaces provide the same Default Method and a class implements both.

---

### 7. How is the Diamond Problem solved?

By overriding the method or calling a specific interface implementation using:

```java
A.super.show();
```

---

### 8. Can Default Methods access instance variables?

No.

Interfaces cannot have instance variables.

---

### 9. Where are Default Methods used in Spring Boot?

They are used in framework interfaces and library APIs to introduce new functionality while maintaining backward compatibility.

---

### 10. What is the difference between Default and Static Methods?

Default Methods are inherited and can be overridden, whereas Static Methods belong to the interface and cannot be overridden.

---

# Quick Revision

- Default Method = Method with implementation inside an interface.
- Uses the `default` keyword.
- Introduced in Java 8.
- Helps maintain backward compatibility.
- Can be overridden.
- Static Methods belong to the interface.
- Diamond Problem occurs when two interfaces provide the same Default Method.
- Solve it using method overriding or `InterfaceName.super.method()`.

---

# Keywords

- Default Method
- Interface
- Java 8
- default keyword
- Static Method
- Backward Compatibility
- Diamond Problem
- A.super.method()
- Interface Evolution
- Multiple Inheritance