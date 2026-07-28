# Lambda Expressions (Java)

## What is a Lambda Expression?

A **Lambda Expression** is a short way of implementing a **Functional Interface** without creating a separate class or anonymous class.

It represents an **anonymous function**.

> **Definition:** A Lambda Expression is an anonymous function that provides the implementation of a Functional Interface.

---

# Why Do We Need Lambda Expressions?

Before Java 8, implementing an interface required:

- Creating a class
- Creating an anonymous class

This resulted in a lot of boilerplate code.

Lambda Expressions make code:

- Shorter
- Cleaner
- Easier to read
- Easier to maintain

---

# Real-World Example

Imagine ordering food.

### Traditional Way

```
Go to Restaurant

↓

Talk to Waiter

↓

Place Order

↓

Get Food
```

---

### Online App

```
Open App

↓

Click Order

↓

Done
```

Much simpler.

Similarly, Lambda Expressions simplify Java code.

---

# Before Java 8 (Anonymous Class)

```java
interface Greeting {

    void sayHello();

}

public class Main {

    public static void main(String[] args) {

        Greeting g = new Greeting() {

            @Override
            public void sayHello() {

                System.out.println("Hello");

            }

        };

        g.sayHello();

    }

}
```

---

# Using Lambda

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

Notice how much shorter it is.

---

# Lambda Syntax

```java
(parameters) -> {

    // Body

}
```

---

# No Parameters

```java
() -> System.out.println("Hello");
```

---

# One Parameter

Parentheses are optional.

```java
name -> System.out.println(name);
```

or

```java
(name) -> System.out.println(name);
```

---

# Multiple Parameters

```java
(a, b) -> a + b;
```

---

# Returning a Value

```java
(a, b) -> {

    return a + b;

}
```

For a single expression:

```java
(a, b) -> a + b;
```

`return` is optional.

---

# Lambda with Functional Interface

```java
@FunctionalInterface
interface Calculator {

    int add(int a, int b);

}
```

Implementation

```java
Calculator calc =

(a, b) -> a + b;

System.out.println(

calc.add(10, 20)

);
```

Output

```text
30
```

---

# Lambda with Built-in Functional Interfaces

## Predicate

```java
Predicate<Integer> even =

n -> n % 2 == 0;

System.out.println(

even.test(8)

);
```

Output

```text
true
```

---

## Function

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

## Consumer

```java
Consumer<String> print =

name -> System.out.println(name);

print.accept("Yash");
```

---

## Supplier

```java
Supplier<String> msg =

() -> "Hello";

System.out.println(

msg.get()

);
```

---

# Lambda vs Anonymous Class

| Lambda | Anonymous Class |
|----------|-----------------|
| Short syntax | More code |
| No class creation | Creates anonymous class |
| Easier to read | Less readable |
| Used with Functional Interfaces | Can implement any interface or abstract class |

---

# Effectively Final Variables

A Lambda can use local variables only if they are **final** or **effectively final**.

### Correct

```java
int x = 10;

Runnable r = () ->

System.out.println(x);
```

`x` is not modified, so it is effectively final.

---

### Incorrect

```java
int x = 10;

x++;

Runnable r = () ->

System.out.println(x);
```

Compilation Error.

---

# Why Effectively Final?

Lambdas may execute later or in another thread.

Keeping captured variables effectively final avoids inconsistent values and makes Lambdas safer.

---

# this Keyword

Inside a Lambda:

```java
this
```

refers to the **current object**.

Inside an anonymous class:

```java
this
```

refers to the **anonymous class object**.

---

# Internal Working

Suppose

```java
Calculator c =

(a, b) -> a + b;
```

Internally

```text
Lambda Expression

↓

Compiler

↓

Creates Functional Interface Implementation

↓

Object Created

↓

Method Invoked
```

The JVM uses `invokedynamic` (introduced in Java 7) to efficiently implement Lambdas instead of generating a separate anonymous class for each Lambda.

---

# Production Usage

Lambda Expressions are heavily used in:

- Streams API
- Collections
- CompletableFuture
- Spring Boot
- Event Handling
- Multithreading
- Comparator
- Runnable

Examples

```java
list.forEach(

name -> System.out.println(name)

);
```

```java
stream.filter(

n -> n > 10

);
```

---

# Advantages

- Less boilerplate code
- Improves readability
- Supports functional programming
- Easy collection processing
- Works well with Streams API

---

# Limitations

- Only works with Functional Interfaces
- Can reduce readability if expressions become very complex
- Harder to debug than simple methods in some cases

---

# Best Practices

✅ Keep Lambdas short.

✅ Use meaningful parameter names.

✅ Prefer method references when they improve readability.

✅ Avoid large blocks of logic inside Lambdas.

---

# Common Mistakes

❌ Using Lambdas with interfaces that have multiple abstract methods.

---

❌ Writing very long Lambda expressions.

---

❌ Modifying captured local variables.

---

❌ Using Lambdas where a normal method is clearer.

---

# Interview Questions

### 1. What is a Lambda Expression?

A Lambda Expression is an anonymous function used to implement a Functional Interface.

---

### 2. Why were Lambdas introduced?

To reduce boilerplate code and support functional programming in Java.

---

### 3. Can Lambdas be used with any interface?

No.

They can only be used with Functional Interfaces.

---

### 4. What is the syntax of a Lambda?

```java
(parameters) -> expression
```

or

```java
(parameters) -> {

    // body

}
```

---

### 5. What is an effectively final variable?

A local variable whose value is assigned once and not modified afterward.

---

### 6. Can Lambdas access local variables?

Yes, but only if they are final or effectively final.

---

### 7. What does `this` refer to inside a Lambda?

The current enclosing object.

---

### 8. What is the difference between a Lambda and an anonymous class?

A Lambda provides a concise implementation of a Functional Interface, while an anonymous class creates a separate class instance.

---

### 9. Where are Lambdas commonly used?

Streams, Collections, CompletableFuture, Spring Boot, Event Handling, and Multithreading.

---

### 10. Why are Lambdas generally faster than anonymous classes?

They are implemented using the JVM's `invokedynamic` mechanism, which avoids creating a separate anonymous class in many cases.

---

# Quick Revision

- Lambda = Anonymous function.
- Used with Functional Interfaces.
- Syntax:

```java
(parameters) -> expression
```

- Supports zero, one, or multiple parameters.
- Captures only final or effectively final local variables.
- `this` refers to the enclosing object.
- Used heavily in Streams and Spring Boot.
- Prefer short and readable Lambdas.

---

# Keywords

- Lambda Expression
- Functional Interface
- Anonymous Function
- Predicate
- Function
- Consumer
- Supplier
- Effectively Final
- invokedynamic
- Java 8
- Streams API
- Functional Programming