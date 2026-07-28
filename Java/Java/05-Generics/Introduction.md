# Introduction to Generics

## What are Generics?

**Generics** allow us to write classes, interfaces, and methods that can work with **different data types** while maintaining **type safety**.

Instead of writing separate code for every data type, we can write one generic implementation.

> **Definition:** Generics are a Java feature that allows classes, interfaces, and methods to operate on different data types while ensuring compile-time type safety.

---

# Why Do We Need Generics?

Before Java 5, collections stored objects as `Object`.

Example

```java
ArrayList list = new ArrayList();

list.add("Java");
list.add(100);
```

Since everything is stored as `Object`, Java allows different types.

Problems:

- No type safety
- Runtime errors
- Manual type casting

---

# Real-World Example

Imagine a box.

Without Generics

```text
Box

↓

Book

↓

Laptop

↓

Bottle

↓

Anything
```

You don't know what the box contains.

With Generics

```text
Box<String>

↓

Only Strings
```

or

```text
Box<Integer>

↓

Only Integers
```

Now the compiler ensures only the correct type can be stored.

---

# Problem Before Generics

Example

```java
ArrayList list = new ArrayList();

list.add("Java");
list.add(10);

String s = (String) list.get(1);
```

Output

```text
Exception in thread "main"

java.lang.ClassCastException
```

Because

```text
Integer

↓

Cannot Become

↓

String
```

The compiler could not detect the mistake.

---

# Solution Using Generics

```java
ArrayList<String> list = new ArrayList<>();

list.add("Java");

// list.add(10); ❌ Compile-time Error

String s = list.get(0);
```

Now

- No type casting
- Compile-time checking
- Safer code

---

# Generic Syntax

```java
ClassName<T>
```

Example

```java
ArrayList<String> names = new ArrayList<>();
```

Here

```text
T

↓

String
```

---

# What is T?

`T` is called a **Type Parameter**.

It acts as a placeholder for an actual data type.

Example

```java
class Box<T>{

}
```

Later,

```java
Box<String>

↓

T = String
```

or

```java
Box<Integer>

↓

T = Integer
```

---

# Common Type Parameter Names

| Symbol | Meaning |
|---------|---------|
| T | Type |
| E | Element |
| K | Key |
| V | Value |
| N | Number |

These are conventions, not keywords.

---

# Compile-Time Type Checking

Example

```java
ArrayList<String> list = new ArrayList<>();

list.add("Java");

list.add("Spring");

// list.add(100);
```

Compiler

```text
Error

↓

Expected String

↓

Found Integer
```

The mistake is caught before running the program.

---

# Type Safety

Generics provide **type safety**.

Without Generics

```text
Store Anything

↓

Runtime Error
```

With Generics

```text
Only Correct Type

↓

Compile-Time Error
```

Compile-time errors are much easier to fix than runtime errors.

---

# No Type Casting

Without Generics

```java
ArrayList list = new ArrayList();

String s = (String) list.get(0);
```

Manual casting is required.

With Generics

```java
ArrayList<String> list = new ArrayList<>();

String s = list.get(0);
```

No casting is needed.

---

# Reusability

Generics allow one class to work with many types.

Example

```java
Box<String>

Box<Integer>

Box<Double>
```

Same class,

Different data types.

---

# Generic Collections

Most Java Collection classes use Generics.

Examples

```java
List<String>

Set<Integer>

Map<Integer, String>

Queue<Double>
```

---

# Raw Types

A Generic class can be used **without specifying a type**.

Example

```java
ArrayList list = new ArrayList();
```

This is called a **Raw Type**.

Problems

- No type safety
- Compiler warnings
- Runtime errors possible

Avoid raw types in new code.

---

# Generics and Primitive Types

Generics work only with **objects**.

Incorrect

```java
ArrayList<int> list;
```

Correct

```java
ArrayList<Integer> list;
```

Why?

Because Java uses **Wrapper Classes**.

| Primitive | Wrapper |
|-----------|----------|
| int | Integer |
| double | Double |
| char | Character |
| boolean | Boolean |
| long | Long |

---

# Internal Working

Example

```java
ArrayList<String> list = new ArrayList<>();

list.add("Java");
```

Internally

```text
Generic Code

↓

Compile

↓

Type Checking

↓

Type Erasure

↓

Bytecode
```

At runtime,

Generics are removed through **Type Erasure** (covered later).

---

# Production Usage

Generics are used everywhere in Java.

Examples

- Spring Boot
- Hibernate
- Kafka
- Collections Framework
- Streams API
- Optional
- CompletableFuture

Example

```java
List<User> users;

Optional<User> user;

ResponseEntity<User> response;
```

These APIs are generic, allowing strong type safety without casting.

---

# Advantages

- Type safety
- Compile-time checking
- Code reusability
- No explicit type casting
- Cleaner code
- Fewer runtime errors

---

# Limitations

- Cannot use primitive types directly
- Type information is removed at runtime (Type Erasure)
- Some operations (like creating `new T()`) are not allowed

---

# Best Practices

✅ Always use Generics with Collections.

✅ Avoid raw types.

✅ Use meaningful type parameters.

✅ Prefer compile-time type checking over manual casting.

---

# Common Mistakes

❌ Using raw collections.

```java
ArrayList list = new ArrayList();
```

---

❌ Mixing different object types in the same generic collection.

---

❌ Using primitive types with Generics.

```java
List<int>
```

Use

```java
List<Integer>
```

instead.

---

❌ Thinking Generics exist at runtime.

Most generic type information is removed during compilation.

---

# Interview Questions

### 1. What are Generics?

Generics allow classes, interfaces, and methods to work with different data types while maintaining compile-time type safety.

---

### 2. Why were Generics introduced?

To provide type safety, eliminate unnecessary casting, and detect type-related errors at compile time.

---

### 3. What is a Type Parameter?

A placeholder for a data type, such as `T` in `class Box<T>`.

---

### 4. What are Raw Types?

Using a generic class without specifying its type parameter, such as `ArrayList list`.

---

### 5. Why should raw types be avoided?

Because they disable compile-time type checking and can lead to runtime errors.

---

### 6. Can Generics use primitive types?

No.

Use wrapper classes like `Integer` instead of `int`.

---

### 7. What is type safety?

Ensuring only the correct type of object can be stored and retrieved.

---

### 8. Why don't we need casting with Generics?

Because the compiler already knows the type of objects stored in the collection.

---

### 9. Where are Generics used in Java?

Collections, Streams, Optional, CompletableFuture, Spring Boot, Hibernate, and many other APIs.

---

### 10. What happens to Generics at runtime?

The compiler removes most generic type information through **Type Erasure**.

---

# Quick Revision

- Generics provide type safety.
- Introduced in Java 5.
- Prevent runtime `ClassCastException`.
- Eliminate manual casting.
- Improve code reusability.
- Work with objects, not primitives.
- Collections heavily use Generics.
- Avoid raw types.
- Generic type information is removed using Type Erasure.

---

# Keywords

- Generics
- Type Parameter
- Type Safety
- Compile-Time Checking
- Raw Type
- Type Erasure
- Wrapper Class
- Collection Framework
- Reusability
- Casting
- Java Generics
- Compile-Time Error