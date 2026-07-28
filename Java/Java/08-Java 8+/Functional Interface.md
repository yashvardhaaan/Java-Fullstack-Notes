# Functional Interface (Java)

## What is a Functional Interface?

A **Functional Interface** is an interface that contains **exactly one abstract method**.

It can have:

- One abstract method ✅
- Multiple default methods ✅
- Multiple static methods ✅
- Methods inherited from `Object` ✅

> **Definition:** A Functional Interface is an interface with only one abstract method and is mainly used to support **Lambda Expressions**.

---

# Why Do We Need Functional Interfaces?

Before Java 8, if we wanted to pass behavior (logic) to a method, we had to create:

- A separate class
- Or an anonymous class

This resulted in a lot of boilerplate code.

Functional Interfaces allow us to use **Lambda Expressions**, making code shorter and easier to read.

---

# Real-World Example

Imagine a remote control.

```
TV Remote

↓

One Button

↓

One Action
```

Each button performs exactly one task.

Similarly,

A Functional Interface has **one abstract method** representing one action.

---

# Functional Interface Structure

```text
Functional Interface

↓

Exactly One Abstract Method

↓

Can be implemented using Lambda
```

---

# Simple Functional Interface

```java
interface Greeting {

    void sayHello();

}
```

This is a Functional Interface because it has only **one abstract method**.

---

# Using @FunctionalInterface

```java
@FunctionalInterface
interface Greeting {

    void sayHello();

}
```

The annotation tells the compiler that the interface **must remain functional**.

If another abstract method is added:

```java
@FunctionalInterface
interface Greeting {

    void sayHello();

    void sayBye();

}
```

Compilation Error

```text
Unexpected @FunctionalInterface annotation
```

---

# Implementing Without Lambda

```java
interface Greeting {

    void sayHello();

}

class Hello implements Greeting {

    @Override
    public void sayHello() {

        System.out.println("Hello");

    }

}
```

Usage

```java
Greeting g = new Hello();

g.sayHello();
```

Output

```text
Hello
```

---

# Implementing With Lambda

```java
Greeting g = () -> {

    System.out.println("Hello");

};

g.sayHello();
```

Output

```text
Hello
```

Much shorter and cleaner.

---

# Functional Interface Rules

A Functional Interface:

✅ Must have exactly one abstract method.

✅ Can have multiple default methods.

✅ Can have multiple static methods.

✅ Can inherit methods from `Object`.

---

# Example with Default Method

```java
@FunctionalInterface
interface Greeting {

    void sayHello();

    default void welcome() {

        System.out.println("Welcome");

    }

}
```

Still a Functional Interface because there is only **one abstract method**.

---

# Example with Static Method

```java
@FunctionalInterface
interface Greeting {

    void sayHello();

    static void info() {

        System.out.println("Greeting Interface");

    }

}
```

---

# Built-in Functional Interfaces

Java provides many ready-made Functional Interfaces.

| Interface | Method | Purpose |
|-----------|---------|---------|
| Predicate<T> | test() | Returns boolean |
| Function<T,R> | apply() | Converts one value to another |
| Consumer<T> | accept() | Consumes data, no return |
| Supplier<T> | get() | Produces data |
| UnaryOperator<T> | apply() | Same input and output type |
| BinaryOperator<T> | apply() | Operates on two values of the same type |
| BiFunction<T,U,R> | apply() | Takes two inputs and returns one output |

---

# Predicate Example

Used for conditions.

```java
Predicate<Integer> isEven =
        n -> n % 2 == 0;

System.out.println(
        isEven.test(10)
);
```

Output

```text
true
```

---

# Function Example

Converts one value into another.

```java
Function<String, Integer> length =
        str -> str.length();

System.out.println(
        length.apply("Java")
);
```

Output

```text
4
```

---

# Consumer Example

Consumes data but returns nothing.

```java
Consumer<String> print =
        name -> System.out.println(name);

print.accept("Yash");
```

Output

```text
Yash
```

---

# Supplier Example

Produces data.

```java
Supplier<String> message =
        () -> "Hello";

System.out.println(
        message.get()
);
```

Output

```text
Hello
```

---

# Internal Working

Suppose

```java
Greeting g =
() -> System.out.println("Hello");
```

Internally

```text
Lambda Expression

↓

Compiler

↓

Functional Interface

↓

Generated Object

↓

Method Call
```

The compiler converts the lambda into an implementation of the Functional Interface.

---

# Functional Interface vs Normal Interface

| Functional Interface | Normal Interface |
|----------------------|------------------|
| One abstract method | Any number of abstract methods |
| Supports Lambda | Cannot be implemented with Lambda |
| Used in Java 8 features | General-purpose interface |

---

# Production Usage

Functional Interfaces are widely used in:

- Java Streams API
- Lambda Expressions
- Method References
- CompletableFuture
- Collections
- Spring Boot
- Event Listeners

Examples

- `stream.filter()`
- `stream.map()`
- `stream.forEach()`
- `CompletableFuture.thenApply()`

All of these accept Functional Interfaces.

---

# Advantages

- Less boilerplate code
- Easy to read
- Supports functional programming
- Makes APIs flexible
- Enables Lambda Expressions

---

# Limitations

- Only one abstract method
- Can become confusing if overused
- Requires understanding of lambdas

---

# Best Practices

✅ Always use `@FunctionalInterface`.

✅ Give meaningful method names.

✅ Prefer built-in Functional Interfaces (`Predicate`, `Function`, etc.) instead of creating new ones when possible.

✅ Keep Functional Interfaces focused on a single responsibility.

---

# Common Mistakes

❌ Adding more than one abstract method.

---

❌ Creating custom Functional Interfaces when a built-in one already exists.

---

❌ Forgetting the generic type parameters.

---

# Interview Questions

### 1. What is a Functional Interface?

An interface with exactly one abstract method that can be implemented using a Lambda Expression.

---

### 2. Why was Functional Interface introduced?

To support Lambda Expressions and functional programming in Java 8.

---

### 3. What is `@FunctionalInterface`?

An annotation that ensures an interface contains exactly one abstract method.

---

### 4. Can a Functional Interface have default methods?

Yes.

Default methods do not count as abstract methods.

---

### 5. Can a Functional Interface have static methods?

Yes.

Static methods are allowed.

---

### 6. Can a Functional Interface extend another interface?

Yes, as long as the resulting interface still has only one abstract method.

---

### 7. Name some built-in Functional Interfaces.

- Predicate
- Function
- Consumer
- Supplier
- UnaryOperator
- BinaryOperator
- BiFunction

---

### 8. Which Functional Interface returns a boolean?

`Predicate<T>`.

---

### 9. Which Functional Interface returns no value?

`Consumer<T>`.

---

### 10. Where are Functional Interfaces used in Spring Boot?

They are used throughout the Streams API, asynchronous programming (`CompletableFuture`), event handling, collections processing, and many callback-based APIs.

---

# Quick Revision

- Functional Interface = One abstract method.
- Enables Lambda Expressions.
- Use `@FunctionalInterface`.
- Can have default and static methods.
- Common built-in interfaces:
  - Predicate
  - Function
  - Consumer
  - Supplier
  - UnaryOperator
  - BinaryOperator
  - BiFunction
- Widely used in Streams and Spring Boot.

---

# Keywords

- Functional Interface
- @FunctionalInterface
- Lambda
- Predicate
- Function
- Consumer
- Supplier
- UnaryOperator
- BinaryOperator
- BiFunction
- Abstract Method
- Default Method
- Static Method
- Java 8