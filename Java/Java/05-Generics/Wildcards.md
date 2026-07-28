# Wildcards

## What are Wildcards?

A **Wildcard** in Java Generics is represented by the **`?`** symbol.

It represents an **unknown type**.

Wildcards are mainly used when working with **generic collections** and **method parameters**, allowing flexibility while still maintaining type safety.

> **Definition:** A Wildcard (`?`) is a special type parameter that represents an unknown type in Java Generics.

---

# Why Do We Need Wildcards?

Suppose we have

```java
List<Integer> numbers = List.of(1, 2, 3);
```

and a method

```java
void print(List<Object> list){

}
```

Can we pass

```java
print(numbers);
```

❌ No.

Although `Integer` is a subclass of `Object`,

```java
List<Integer>
```

is **NOT** a subclass of

```java
List<Object>
```

Generics are **invariant**.

Wildcards solve this problem.

---

# Real-World Example

Imagine a parking lot.

Without Wildcards

```text
Parking

↓

Only Cars
```

With Wildcards

```text
Parking

↓

Any Vehicle
```

Similarly,

```text
List<Integer>

List<Double>

List<String>

↓

List<?>
```

---

# Unbounded Wildcard

Syntax

```java
List<?>
```

Meaning

```text
List

↓

Unknown Type
```

It can accept

- List<String>
- List<Integer>
- List<Double>
- List<Student>

Example

```java
public void print(List<?> list){

    for(Object obj : list){

        System.out.println(obj);

    }

}
```

Usage

```java
print(List.of(1,2,3));

print(List.of("Java","Spring"));
```

---

# What Can We Do?

Read

✅ Allowed

```java
Object obj = list.get(0);
```

Write

❌ Not Allowed

```java
list.add("Java");
```

Why?

Because the compiler does not know the actual type.

---

# Upper Bounded Wildcard

Syntax

```java
List<? extends Number>
```

Meaning

```text
Number

↓

Integer

Double

Float

Long
```

Accepts

- List<Integer>
- List<Double>
- List<Float>

Does NOT accept

- List<String>

---

# Example

```java
public void print(List<? extends Number> list){

    for(Number n : list){

        System.out.println(n);

    }

}
```

Usage

```java
print(List.of(10,20,30));

print(List.of(10.5,20.8));
```

---

# Reading with extends

Allowed

```java
Number number = list.get(0);
```

Not Allowed

```java
list.add(100);
```

Reason

The compiler doesn't know whether the list is actually

```text
List<Integer>

or

List<Double>
```

Adding could break type safety.

---

# Lower Bounded Wildcard

Syntax

```java
List<? super Integer>
```

Meaning

```text
Integer

↓

Number

↓

Object
```

Accepts

- List<Integer>
- List<Number>
- List<Object>

---

# Example

```java
public void add(List<? super Integer> list){

    list.add(10);

}
```

Usage

```java
List<Number> numbers = new ArrayList<>();

add(numbers);
```

---

# Reading with super

Reading

```java
Object obj = list.get(0);
```

Only `Object` is guaranteed.

Writing

```java
list.add(100);
```

Allowed.

---

# Wildcard Comparison

## ?

```java
List<?>
```

- Read ✅
- Write ❌

---

## ? extends

```java
List<? extends Number>
```

- Read ✅
- Write ❌

---

## ? super

```java
List<? super Integer>
```

- Read as `Object`
- Write ✅

---

# PECS Principle

One of the most important interview concepts.

PECS means

```text
Producer

↓

Extends

Consumer

↓

Super
```

---

# Producer

If a collection **produces** data,

use

```java
? extends
```

Example

```java
List<? extends Number>
```

You only read values.

---

# Consumer

If a collection **consumes** data,

use

```java
? super
```

Example

```java
List<? super Integer>
```

You mainly add values.

---

# PECS Example

Reading

```java
public void print(List<? extends Number> list){

    for(Number n : list){

        System.out.println(n);

    }

}
```

Writing

```java
public void add(List<? super Integer> list){

    list.add(10);

}
```

---

# Internal Working

Suppose

```java
List<Integer> numbers = List.of(1,2,3);

print(numbers);
```

Compiler

```text
List<Integer>

↓

Matches

↓

List<? extends Number>

↓

Compilation Success
```

---

# Production Usage

Wildcards are used throughout Java.

Examples

- Collections Framework
- Streams API
- Comparator
- Comparable
- Spring Framework
- Hibernate

Example

```java
Collections.copy(destination, source);
```

The method uses wildcards internally to safely copy elements between compatible collections.

---

# Advantages

- Flexible APIs
- Better code reuse
- Compile-time safety
- Works with multiple Generic types
- Prevents invalid operations

---

# Limitations

- Can make code harder to understand
- Cannot always add elements
- Type information removed at runtime

---

# Best Practices

✅ Use `? extends` when only reading.

✅ Use `? super` when only writing.

✅ Follow the PECS principle.

✅ Use unbounded wildcards for methods that only inspect objects.

---

# Common Mistakes

❌ Thinking

```java
List<Integer>
```

is a subtype of

```java
List<Number>
```

It is not.

---

❌ Using `extends` when you need to add elements.

---

❌ Using `super` when you only need to read typed values.

---

❌ Forgetting the PECS rule.

---

# Interview Questions

### 1. What is a Wildcard?

A Wildcard (`?`) represents an unknown type in Java Generics.

---

### 2. What is an Unbounded Wildcard?

```java
List<?>
```

It accepts a list of any type.

---

### 3. What is an Upper Bounded Wildcard?

```java
List<? extends Number>
```

It accepts `Number` and its subclasses.

---

### 4. What is a Lower Bounded Wildcard?

```java
List<? super Integer>
```

It accepts `Integer` and its superclasses.

---

### 5. What does PECS stand for?

**Producer Extends, Consumer Super.**

---

### 6. Why can't we add elements to `List<? extends Number>`?

Because the compiler doesn't know the exact subtype of `Number`, so adding an element could violate type safety.

---

### 7. Why can we add elements to `List<? super Integer>`?

Because the list is guaranteed to accept `Integer` objects.

---

### 8. Why is `List<Integer>` not a subtype of `List<Number>`?

Because Java Generics are **invariant**.

---

### 9. Where are Wildcards commonly used?

Collections Framework, Streams API, Spring Framework, Hibernate, and many utility methods in the JDK.

---

### 10. What is the difference between `?`, `? extends`, and `? super`?

| Wildcard | Read | Write |
|----------|------|-------|
| `?` | ✅ (`Object`) | ❌ |
| `? extends T` | ✅ (`T`) | ❌ |
| `? super T` | ✅ (`Object`) | ✅ (`T`) |

---

# Quick Revision

- Wildcard = `?`
- Represents an unknown type.
- Types:
  - `?`
  - `? extends T`
  - `? super T`
- `extends` → Read (Producer)
- `super` → Write (Consumer)
- Follow **PECS**:
  - **Producer Extends**
  - **Consumer Super**
- Generics are invariant (`List<Integer>` ≠ `List<Number>`).

---

# Keywords

- Wildcard
- `?`
- Unbounded Wildcard
- Upper Bounded Wildcard
- Lower Bounded Wildcard
- PECS
- Producer Extends
- Consumer Super
- Invariance
- Generic Collections
- Type Safety
- Java Generics
```