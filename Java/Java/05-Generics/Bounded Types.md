# Bounded Types

## What are Bounded Types?

**Bounded Types** allow us to restrict the type parameter of a Generic Class or Generic Method to a specific class or interface.

Instead of accepting every type, we can specify which types are allowed.

> **Definition:** Bounded Types are Generic type parameters that are limited to a particular class or interface using the `extends` keyword.

---

# Why Do We Need Bounded Types?

Suppose we write

```java
class Box<T>{

    T value;

}
```

This accepts everything.

```java
Box<String>

Box<Integer>

Box<Student>

Box<Car>

Box<Boolean>
```

Sometimes we don't want every type.

Example

We are writing a calculator.

Only numeric types should be allowed.

Generics alone cannot enforce this.

Bounded Types solve the problem.

---

# Real-World Example

Imagine a parking lot.

Without restrictions

```text
Parking

↓

Car

Bike

Truck

Dog

Chair
```

Everything enters.

With restrictions

```text
Parking

↓

Only Vehicles
```

Similarly,

```text
Box<T>

↓

Accepts Everything
```

```text
Box<T extends Number>

↓

Only Numbers
```

---

# Upper Bound

The most common bound is the **Upper Bound**.

Syntax

```java
class Box<T extends Number>{

}
```

Meaning

```text
T

↓

Number

or

Subclass of Number
```

Allowed

- Integer
- Double
- Float
- Long
- Short
- Byte

Not Allowed

- String
- Boolean
- Student

---

# Example

```java
class Box<T extends Number>{

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
Box<Integer> box = new Box<>(100);

Box<Double> box2 = new Box<>(99.5);
```

---

Invalid

```java
Box<String> box = new Box<>("Java");
```

Compiler

```text
Error

↓

String

is not a subclass of Number
```

---

# Why Use extends?

For Generics,

the keyword

```java
extends
```

means

```text
Class

OR

Interface
```

Even interfaces use `extends`.

Example

```java
class Demo<T extends Runnable>{

}
```

Here,

`Runnable` is an interface.

---

# Access Parent Methods

Since `T` extends `Number`,

all methods of `Number` are available.

Example

```java
class Calculator<T extends Number>{

    public void print(T value){

        System.out.println(value.doubleValue());

    }

}
```

Usage

```java
Calculator<Integer> c = new Calculator<>();

c.print(100);
```

Output

```text
100.0
```

---

# Generic Method with Bounds

Methods can also use bounded types.

```java
public <T extends Number> void print(T value){

    System.out.println(value);

}
```

Usage

```java
print(100);

print(50.5);
```

Invalid

```java
print("Java");
```

---

# Multiple Bounds

A type parameter can have multiple bounds.

Syntax

```java
<T extends ClassName & Interface1 & Interface2>
```

Example

```java
class Demo<T extends Number & Comparable<T>>{

}
```

Here,

`T`

must

- extend `Number`
- implement `Comparable`

---

# Rule for Multiple Bounds

The class must come first.

Correct

```java
<T extends Number & Comparable<T>>
```

Incorrect

```java
<T extends Comparable<T> & Number>
```

Compiler Error.

---

# Bounded Generic Class

```java
class Repository<T extends Number>{

    private T id;

    public Repository(T id){
        this.id = id;
    }

    public T getId(){
        return id;
    }

}
```

Usage

```java
Repository<Integer> repo =
        new Repository<>(101);
```

---

# Bounded Generic Method

```java
public <T extends Comparable<T>>
T maximum(T a, T b){

    if(a.compareTo(b) > 0)
        return a;

    return b;

}
```

Usage

```java
maximum(10, 20);

maximum("Apple", "Banana");
```

Both `Integer` and `String` implement `Comparable`.

---

# Bounds with Custom Classes

```java
class Animal{

}
```

```java
class Dog extends Animal{

}
```

Generic

```java
class Cage<T extends Animal>{

}
```

Allowed

```java
Cage<Dog>
```

Not Allowed

```java
Cage<String>
```

---

# Internal Working

Suppose

```java
Box<Integer> box =
        new Box<>(100);
```

Internally

```text
Compiler

↓

Check

↓

Integer extends Number

↓

Allowed

↓

Compile
```

If

```java
Box<String>
```

Compiler

```text
String

↓

Not Number

↓

Compilation Failed
```

---

# Production Usage

Bounded Types are used in many Java APIs.

Examples

- Collections
- Streams
- Comparable
- Comparator
- Optional
- Spring Framework
- Hibernate

Example

```java
Collections.max(list);
```

The elements must implement `Comparable`.

---

# Advantages

- Restricts invalid types
- Compile-time safety
- Access parent methods
- Cleaner APIs
- Better code reuse

---

# Limitations

- Cannot use primitive types
- Only one class can be extended
- Type information removed at runtime

---

# Best Practices

✅ Restrict type parameters only when necessary.

✅ Use interface bounds whenever possible.

✅ Keep bounds simple and meaningful.

---

# Common Mistakes

❌ Thinking `extends` only means inheritance.

In Generics,

it also works with interfaces.

---

❌ Forgetting the class must come before interfaces.

Correct

```java
<T extends Number & Comparable<T>>
```

---

❌ Using unrelated bounds.

Only use bounds that make logical sense.

---

❌ Confusing Bounded Types with Wildcards.

Bounds restrict the **type parameter**.

Wildcards restrict **usage** of generic objects.

---

# Interview Questions

### 1. What are Bounded Types?

They restrict Generic type parameters to specific classes or interfaces.

---

### 2. Which keyword is used?

```java
extends
```

---

### 3. What does `T extends Number` mean?

`T` must be `Number` or one of its subclasses.

---

### 4. Can interfaces be used with `extends`?

Yes.

Example

```java
<T extends Runnable>
```

---

### 5. Can we have multiple bounds?

Yes.

Example

```java
<T extends Number & Comparable<T>>
```

---

### 6. What is the rule for multiple bounds?

The class must come first,

followed by interfaces.

---

### 7. Why are Bounded Types useful?

They provide compile-time restrictions and allow access to methods of the parent class or interface.

---

### 8. Can Generic Methods use bounds?

Yes.

Example

```java
public <T extends Number> void print(T value)
```

---

### 9. Do Bounded Types improve type safety?

Yes.

Invalid types are rejected during compilation.

---

### 10. Are Bounded Types available at runtime?

No.

They are affected by **Type Erasure**.

---

# Quick Revision

- Bounded Types restrict Generic types.
- Uses:

```java
extends
```

- Supports:
  - Classes
  - Interfaces
- Multiple bounds are allowed.
- Class comes before interfaces.
- Provides compile-time safety.
- Gives access to parent methods.
- Used throughout Java Collections and Frameworks.

---

# Keywords

- Bounded Types
- Upper Bound
- Generic Class
- Generic Method
- Type Parameter
- Number
- Comparable
- Interface Bound
- Multiple Bounds
- Compile-Time Checking
- Type Safety
- Type Erasure
- Java Generics