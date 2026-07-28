# Method Reference (Java)

## What is a Method Reference?

A **Method Reference** is a shorter and cleaner way to refer to an existing method using the `::` operator.

Instead of writing a Lambda that simply calls another method, we can use a Method Reference.

> **Definition:** A Method Reference is a shorthand syntax for a Lambda Expression that directly calls an existing method.

---

# Why Do We Need Method References?

Sometimes a Lambda only calls another method.

Example:

```java
name -> System.out.println(name)
```

This can be simplified to:

```java
System.out::println
```

Method References make code:

- Shorter
- More readable
- Easier to maintain

---

# Real-World Example

Imagine calling your friend.

Without Method Reference

```
Call Friend

↓

Tell Him

↓

Open Door
```

With Method Reference

```
Call Friend

↓

"Open the Door"

↓

Done
```

You directly refer to the action.

---

# Syntax

```java
ClassName::methodName
```

or

```java
object::methodName
```

or

```java
ClassName::new
```

---

# Types of Method References

Java supports **four types** of Method References.

```text
Method Reference

↓

1. Static Method

2. Instance Method of Particular Object

3. Instance Method of Arbitrary Object

4. Constructor Reference
```

---

# 1. Static Method Reference

Suppose

```java
class MathUtil {

    static int square(int x){

        return x * x;

    }

}
```

Using Lambda

```java
Function<Integer, Integer> f =

n -> MathUtil.square(n);
```

Using Method Reference

```java
Function<Integer, Integer> f =

MathUtil::square;
```

---

# 2. Instance Method Reference (Particular Object)

```java
class Printer {

    void print(String msg){

        System.out.println(msg);

    }

}
```

Using Lambda

```java
Printer printer = new Printer();

Consumer<String> c =

msg -> printer.print(msg);
```

Using Method Reference

```java
Printer printer = new Printer();

Consumer<String> c =

printer::print;
```

---

# 3. Instance Method Reference (Arbitrary Object)

Example

```java
List<String> names =

List.of("Java", "Spring", "Docker");
```

Using Lambda

```java
names.forEach(

name -> name.toUpperCase()

);
```

Using Method Reference

```java
names.sort(

String::compareToIgnoreCase

);
```

Another example

```java
List<String> names =

List.of("Java", "Spring");

names.forEach(

System.out::println

);
```

---

# 4. Constructor Reference

Using Lambda

```java
Supplier<Student> s =

() -> new Student();
```

Using Method Reference

```java
Supplier<Student> s =

Student::new;
```

When executed

```java
Student student = s.get();
```

A new object is created.

---

# Method Reference vs Lambda

| Lambda | Method Reference |
|----------|------------------|
| `(x) -> print(x)` | `System.out::println` |
| `(x) -> Math.abs(x)` | `Math::abs` |
| `() -> new Student()` | `Student::new` |
| More flexible | More concise when simply calling an existing method |

---

# When Can We Use Method References?

Only when the Lambda **directly calls an existing method** without adding extra logic.

Example

```java
list.forEach(

System.out::println

);
```

Not suitable

```java
x -> {

    System.out.println(x);

    System.out.println("Done");

}
```

Because additional logic is present.

---

# Internal Working

Suppose

```java
Consumer<String> c =

System.out::println;
```

Internally

```text
Method Reference

↓

Compiler

↓

Equivalent Lambda

↓

Functional Interface

↓

Method Invocation
```

The compiler converts the Method Reference into an implementation of the Functional Interface.

---

# Production Usage

Method References are commonly used in:

- Streams API
- Collections
- Sorting
- Filtering
- Spring Boot
- CompletableFuture
- Event Handling

Examples

Printing

```java
list.forEach(

System.out::println

);
```

Sorting

```java
names.sort(

String::compareToIgnoreCase

);
```

Creating Objects

```java
Supplier<Student> s =

Student::new;
```

---

# Advantages

- Cleaner code
- Less boilerplate
- Easy to read
- Reuses existing methods
- Works well with Streams API

---

# Limitations

- Cannot add extra logic
- Only works when a Lambda simply delegates to another method
- Sometimes less obvious to beginners

---

# Best Practices

✅ Use Method References when they improve readability.

✅ Prefer Lambdas if additional logic is needed.

✅ Keep code simple and expressive.

---

# Common Mistakes

❌ Trying to use Method References when extra processing is required.

---

❌ Confusing static and instance method references.

---

❌ Using Method References when a Lambda is actually clearer.

---

# Interview Questions

### 1. What is a Method Reference?

A Method Reference is a shorthand syntax for a Lambda that calls an existing method.

---

### 2. Which operator is used for Method References?

```java
::
```

---

### 3. How many types of Method References are there?

Four:

- Static Method Reference
- Instance Method Reference (Particular Object)
- Instance Method Reference (Arbitrary Object)
- Constructor Reference

---

### 4. What is a Constructor Reference?

A Method Reference that refers to a constructor using:

```java
ClassName::new
```

---

### 5. What is the difference between a Lambda and a Method Reference?

A Lambda can contain custom logic, while a Method Reference only refers to an existing method.

---

### 6. Can every Lambda be replaced with a Method Reference?

No.

Only Lambdas that directly call an existing method can be replaced.

---

### 7. Which Functional Interfaces commonly use Method References?

- Consumer
- Function
- Predicate
- Supplier

---

### 8. Why are Method References useful?

They improve readability and reduce boilerplate code.

---

### 9. Where are Method References used in Spring Boot?

They are commonly used with Streams, Collections, asynchronous programming (`CompletableFuture`), and callback-based APIs.

---

### 10. Which Method Reference is used to create objects?

Constructor Reference:

```java
Student::new
```

---

# Quick Revision

- Method Reference = Shorthand for a Lambda.
- Uses the `::` operator.
- Four types:
  - Static Method
  - Instance Method (Particular Object)
  - Instance Method (Arbitrary Object)
  - Constructor Reference
- Use when a Lambda simply calls an existing method.
- Common in Streams, Collections, and Spring Boot.

---

# Keywords

- Method Reference
- ::
- Static Method Reference
- Instance Method Reference
- Constructor Reference
- Functional Interface
- Lambda
- Consumer
- Function
- Supplier
- Java 8
- Streams API