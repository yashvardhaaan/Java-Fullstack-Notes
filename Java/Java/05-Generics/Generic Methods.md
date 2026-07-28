# Generic Methods

## What are Generic Methods?

A **Generic Method** is a method that introduces its own **type parameter**, allowing it to work with different data types regardless of whether the class itself is generic.

> **Definition:** A Generic Method is a method that uses one or more type parameters to operate on different data types while maintaining compile-time type safety.

---

# Why Do We Need Generic Methods?

Suppose we want to print different types of values.

Without Generics

```java
void printString(String value){

    System.out.println(value);

}

void printInteger(Integer value){

    System.out.println(value);

}

void printDouble(Double value){

    System.out.println(value);

}
```

Problem

- Duplicate code
- Hard to maintain
- Not reusable

Generics solve this problem.

---

# Real-World Example

Imagine a printer.

Without Generics

```text
Photo Printer

↓

Only Photos
```

```text
Document Printer

↓

Only Documents
```

With Generics

```text
Universal Printer

↓

Print Anything
```

One method,

Many data types.

---

# Generic Method Syntax

```java
public <T> void display(T value){

}
```

Notice

```java
<T>
```

comes **before** the return type.

---

# First Generic Method

```java
public class Demo {

    public <T> void print(T value){

        System.out.println(value);

    }

}
```

Usage

```java
Demo demo = new Demo();

demo.print("Java");

demo.print(100);

demo.print(99.9);
```

Output

```text
Java
100
99.9
```

---

# How It Works

Suppose

```java
demo.print("Spring");
```

Internally

```text
T

↓

String
```

Suppose

```java
demo.print(500);
```

Internally

```text
T

↓

Integer
```

The compiler automatically determines the type.

---

# Generic Method with Return Type

```java
public <T> T getValue(T value){

    return value;

}
```

Usage

```java
String name = getValue("Java");

Integer number = getValue(100);
```

---

# Generic Static Method

Static methods can also be generic.

```java
public class Utility {

    public static <T> void display(T value){

        System.out.println(value);

    }

}
```

Usage

```java
Utility.display("Spring");

Utility.display(500);
```

---

# Generic Method with Multiple Parameters

```java
public <T> void print(T first, T second){

    System.out.println(first);

    System.out.println(second);

}
```

Usage

```java
print("Java", "Spring");
```

---

# Multiple Type Parameters

A Generic Method can have more than one type parameter.

```java
public <K, V> void display(K key, V value){

    System.out.println(key);

    System.out.println(value);

}
```

Usage

```java
display(101, "Yash");
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

# Generic Method Inside a Non-Generic Class

A class does **not** have to be generic.

```java
class Demo {

    public <T> void show(T value){

        System.out.println(value);

    }

}
```

The method is generic,

not the class.

---

# Generic Method Inside a Generic Class

```java
class Box<T>{

    public T get(T value){

        return value;

    }

}
```

Here,

the method uses the class's type parameter.

---

Another example

```java
class Box<T>{

    public <U> void print(U value){

        System.out.println(value);

    }

}
```

Notice

- `T` belongs to the class.
- `U` belongs only to the method.

---

# Type Inference

The compiler usually determines the type automatically.

```java
display("Java");
```

Compiler

```text
T

↓

String
```

Another example

```java
display(200);
```

Compiler

```text
T

↓

Integer
```

Usually, you don't need to specify the type explicitly.

---

# Explicit Type Specification

Although uncommon,

you can write

```java
Demo.<String>display("Java");
```

The compiler already knows the type,

so this is rarely needed.

---

# Generic Methods with Collections

```java
public <T> void printList(List<T> list){

    for(T item : list){

        System.out.println(item);

    }

}
```

Usage

```java
List<String> names = List.of("Java", "Spring");

printList(names);
```

---

# Internal Working

Example

```java
print("Java");
```

Internally

```text
Generic Method

↓

Compiler Determines Type

↓

Type Checking

↓

Type Erasure

↓

Bytecode
```

At runtime,

generic type information is removed.

---

# Production Usage

Generic Methods are widely used in Java APIs.

Examples

```java
Collections.sort()

Collections.max()

Arrays.asList()

Optional.of()

List.of()
```

Spring Boot Example

```java
ResponseEntity.ok(user);
```

The compiler infers the type of the response automatically.

---

# Advantages

- Reusable methods
- Type safety
- Less duplicate code
- Compile-time checking
- No explicit casting
- Cleaner APIs

---

# Limitations

- Cannot use primitive types directly
- Type information removed at runtime
- Some operations are restricted because of Type Erasure

---

# Best Practices

✅ Use Generic Methods for reusable utility functions.

✅ Let the compiler infer types whenever possible.

✅ Keep type parameter names meaningful.

✅ Avoid unnecessary explicit type declarations.

---

# Common Mistakes

❌ Forgetting to place `<T>` before the return type.

Incorrect

```java
public void <T> display(T value)
```

Correct

```java
public <T> void display(T value)
```

---

❌ Using primitive types.

```java
display(10);
```

The compiler automatically uses `Integer`, not `int`.

---

❌ Confusing Generic Classes with Generic Methods.

A Generic Method can exist inside a non-generic class.

---

❌ Assuming Generic Methods keep type information at runtime.

They also use Type Erasure.

---

# Interview Questions

### 1. What is a Generic Method?

A method that uses one or more type parameters to work with different data types.

---

### 2. How is a Generic Method declared?

```java
public <T> void display(T value)
```

---

### 3. Can a Generic Method exist inside a non-generic class?

Yes.

---

### 4. Can a static method be generic?

Yes.

```java
public static <T> void display(T value)
```

---

### 5. What is type inference?

The compiler automatically determines the actual type parameter based on the method arguments.

---

### 6. Can a Generic Method have multiple type parameters?

Yes.

Example

```java
public <K, V> void display(K key, V value)
```

---

### 7. What's the difference between a Generic Class and a Generic Method?

- Generic Class: The entire class uses type parameters.
- Generic Method: Only the method uses type parameters.

---

### 8. Why are Generic Methods useful?

They improve code reuse and provide compile-time type safety.

---

### 9. Do Generic Methods work with primitive types?

No.

Wrapper classes like `Integer` are used instead.

---

### 10. What happens to Generic Methods at runtime?

Their generic type information is removed through **Type Erasure**.

---

# Quick Revision

- Generic Methods use type parameters.
- Syntax:

```java
public <T> void method(T value)
```

- Can be static.
- Can exist inside non-generic classes.
- Support multiple type parameters.
- Compiler performs type inference.
- Provide compile-time type safety.
- Use Type Erasure internally.

---

# Keywords

- Generic Method
- Type Parameter
- Type Inference
- Static Generic Method
- Compile-Time Checking
- Type Safety
- Type Erasure
- Generic Class
- Collections
- Java Generics
- Reusability
- Wrapper Classes