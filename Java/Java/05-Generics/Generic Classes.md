# Generic Classes

## What is a Generic Class?

A **Generic Class** is a class that can work with **different data types** using **type parameters**.

Instead of creating separate classes for every data type, we create one generic class.

> **Definition:** A Generic Class is a class that uses one or more type parameters to work with different object types while maintaining compile-time type safety.

---

# Why Do We Need Generic Classes?

Without Generics

```java
class StringBox {

    private String value;

}
```

Now suppose we also need Integer.

```java
class IntegerBox {

    private Integer value;

}
```

Need Double?

```java
class DoubleBox {

    private Double value;

}
```

This causes **code duplication**.

Generics solve this problem.

---

# Real-World Example

Imagine a storage box.

Without Generics

```text
String Box

↓

Stores Only Strings
```

```text
Integer Box

↓

Stores Only Integers
```

With Generics

```text
Generic Box<T>

↓

Store Any Type
```

One box,

Many data types.

---

# Generic Class Syntax

```java
class Box<T> {

}
```

Here

```text
T

↓

Type Parameter
```

`T` acts as a placeholder.

---

# First Generic Class

```java
class Box<T> {

    private T value;

    public void set(T value) {
        this.value = value;
    }

    public T get() {
        return value;
    }

}
```

---

# Using Generic Class

```java
public class Main {

    public static void main(String[] args) {

        Box<String> box = new Box<>();

        box.set("Java");

        System.out.println(box.get());

    }

}
```

Output

```text
Java
```

---

# Using Integer

```java
Box<Integer> box = new Box<>();

box.set(100);

System.out.println(box.get());
```

Output

```text
100
```

Notice

Same class,

Different data type.

---

# Using Double

```java
Box<Double> box = new Box<>();

box.set(99.9);
```

No code changes are required.

---

# Compile-Time Type Safety

```java
Box<String> box = new Box<>();

box.set("Spring");

// box.set(100);
```

Compiler

```text
Error

↓

Expected String

↓

Found Integer
```

The error is detected before the program runs.

---

# Generic Class with Multiple Methods

```java
class Box<T>{

    private T value;

    public void set(T value){
        this.value = value;
    }

    public T get(){
        return value;
    }

    public void display(){
        System.out.println(value);
    }

}
```

---

# Multiple Type Parameters

A Generic Class can have more than one type parameter.

Syntax

```java
class Pair<K, V>{

}
```

Example

```java
class Pair<K, V>{

    private K key;

    private V value;

    public Pair(K key, V value){
        this.key = key;
        this.value = value;
    }

    public K getKey(){
        return key;
    }

    public V getValue(){
        return value;
    }

}
```

Usage

```java
Pair<Integer, String> student =
        new Pair<>(101, "Yash");
```

Memory

```text
K

↓

Integer

----------------

V

↓

String
```

---

# Common Type Parameters

| Symbol | Meaning |
|---------|---------|
| T | Type |
| E | Element |
| K | Key |
| V | Value |
| N | Number |

These are naming conventions.

---

# Generic Constructor

A Generic Class can have constructors.

```java
class Box<T>{

    private T value;

    public Box(T value){
        this.value = value;
    }

    public T get(){
        return value;
    }

}
```

Usage

```java
Box<String> box = new Box<>("Java");
```

---

# Generic Class with Collections

```java
class Data<T>{

    private List<T> list = new ArrayList<>();

    public void add(T value){
        list.add(value);
    }

    public List<T> getAll(){
        return list;
    }

}
```

Usage

```java
Data<String> data = new Data<>();

data.add("Java");

data.add("Spring");
```

---

# Generic Interfaces

Interfaces can also be generic.

```java
interface Repository<T>{

    void save(T obj);

    T find();
}
```

Implementation

```java
class UserRepository
        implements Repository<User>{

    @Override
    public void save(User obj){

    }

    @Override
    public User find(){
        return null;
    }

}
```

---

# Internal Working

Suppose

```java
Box<String> box = new Box<>();

box.set("Java");
```

Internally

```text
Box<T>

↓

T = String

↓

Compile-Time Type Checking

↓

Type Erasure

↓

Bytecode
```

At runtime,

generic type information is removed through **Type Erasure**.

---

# Production Usage

Generic Classes are used everywhere.

Examples

```java
ArrayList<String>

HashMap<Integer, String>

Optional<User>

ResponseEntity<User>

CompletableFuture<String>
```

Spring Boot Example

```java
ResponseEntity<User>
```

The response always contains a `User` object, making the API type-safe.

---

# Advantages

- Type safety
- Code reuse
- No duplicate classes
- No explicit casting
- Compile-time error detection
- Cleaner code

---

# Limitations

- Cannot use primitive types directly
- Type information removed at runtime
- Cannot create `new T()`

---

# Best Practices

✅ Use meaningful type parameter names.

✅ Avoid raw types.

✅ Use Generics with Collections.

✅ Keep Generic Classes reusable.

---

# Common Mistakes

❌ Creating separate classes for every data type.

---

❌ Using raw Generic Classes.

```java
Box box = new Box();
```

---

❌ Using primitive types.

```java
Box<int>
```

Use

```java
Box<Integer>
```

instead.

---

❌ Assuming Generic information exists at runtime.

---

# Interview Questions

### 1. What is a Generic Class?

A class that uses type parameters to work with different data types while maintaining type safety.

---

### 2. Why do we use Generic Classes?

To avoid duplicate code, improve reusability, and provide compile-time type safety.

---

### 3. What is `T` in `class Box<T>`?

A type parameter that acts as a placeholder for an actual type.

---

### 4. Can a Generic Class have multiple type parameters?

Yes.

Example

```java
class Pair<K, V>
```

---

### 5. Can constructors be used in Generic Classes?

Yes.

Constructors can accept generic type parameters just like methods.

---

### 6. Can interfaces be generic?

Yes.

Example

```java
interface Repository<T>
```

---

### 7. Can we use primitive types with Generic Classes?

No.

Use wrapper classes like `Integer`, `Double`, etc.

---

### 8. Why don't Generic Classes need casting?

Because the compiler knows the actual type during compilation.

---

### 9. Where are Generic Classes used in Java?

Collections Framework, Spring Boot, Optional, Streams, CompletableFuture, Hibernate, and many other APIs.

---

### 10. What happens to Generic Classes at runtime?

Generic type information is removed through **Type Erasure**.

---

# Quick Revision

- Generic Classes use type parameters.
- Syntax:

```java
class Box<T>
```

- One class works with multiple data types.
- Supports multiple type parameters.
- Provides compile-time type safety.
- Eliminates manual casting.
- Cannot use primitive types directly.
- Used extensively in Java Collections and Spring Boot.

---

# Keywords

- Generic Class
- Type Parameter
- Type Safety
- Box<T>
- Pair<K, V>
- Generic Interface
- Compile-Time Checking
- Type Erasure
- Collections
- Reusability
- Java Generics
- Wrapper Class
```