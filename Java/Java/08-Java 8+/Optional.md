# Optional (Java 8)

## What is Optional?

`Optional` is a container object introduced in **Java 8** that may or may not contain a value.

It is mainly used to **avoid NullPointerException (NPE)** and make code more readable.

> **Definition:** `Optional<T>` is a wrapper object that can either contain a value or be empty.

---

# Why Do We Need Optional?

Before Java 8

```java
String name = null;

System.out.println(name.length());
```

Output

```text
Exception in thread "main"
java.lang.NullPointerException
```

A `NullPointerException` occurs because `name` is `null`.

Using `Optional`

```java
Optional<String> name =
Optional.ofNullable(null);
```

Now we can safely check whether a value exists.

---

# Real-World Example

Imagine a gift box.

```
Gift Box

↓

Open Box

↓

Gift Present?

↓

Yes → Use Gift

No → Return Empty
```

Similarly,

```
Optional

↓

Contains Value?

↓

Yes → Get Value

No → Return Default
```

---

# Creating an Optional

There are three ways.

## 1. Optional.of()

Used when the value is **guaranteed not to be null**.

```java
Optional<String> name =

Optional.of("Java");
```

Output

```text
Optional[Java]
```

---

⚠ If value is null

```java
Optional.of(null);
```

Output

```text
NullPointerException
```

---

## 2. Optional.ofNullable()

Used when the value **may be null**.

```java
Optional<String> name =

Optional.ofNullable(null);
```

Output

```text
Optional.empty
```

---

## 3. Optional.empty()

Creates an empty Optional.

```java
Optional<String> name =

Optional.empty();
```

---

# Checking Value

## isPresent()

```java
Optional<String> name =

Optional.of("Java");

System.out.println(

name.isPresent()

);
```

Output

```text
true
```

---

## isEmpty() (Java 11)

```java
Optional<String> name =

Optional.empty();

System.out.println(

name.isEmpty()

);
```

Output

```text
true
```

---

# Getting Value

## get()

```java
Optional<String> name =

Optional.of("Java");

System.out.println(

name.get()

);
```

Output

```text
Java
```

⚠ Never call `get()` without checking if a value is present.

---

# ifPresent()

Executes code only if a value exists.

```java
Optional<String> name =

Optional.of("Java");

name.ifPresent(

System.out::println

);
```

Output

```text
Java
```

---

# orElse()

Returns the value if present.

Otherwise returns a default value.

```java
Optional<String> name =

Optional.empty();

System.out.println(

name.orElse("Unknown")

);
```

Output

```text
Unknown
```

---

# orElseGet()

Computes the default value only when needed.

```java
Optional<String> name =

Optional.empty();

System.out.println(

name.orElseGet(

() -> "Guest"

)

);
```

Output

```text
Guest
```

---

# orElseThrow()

Throws an exception if the value is absent.

```java
Optional<String> name =

Optional.empty();

name.orElseThrow(

() -> new RuntimeException(
    "Name Not Found"
)

);
```

Output

```text
RuntimeException:
Name Not Found
```

---

# map()

Transforms the value if present.

```java
Optional<String> name =

Optional.of("java");

Optional<String> upper =

name.map(String::toUpperCase);

System.out.println(

upper.get()

);
```

Output

```text
JAVA
```

---

# flatMap()

Used when the mapping function itself returns an `Optional`.

Without `flatMap()`

```text
Optional<Optional<String>>
```

With `flatMap()`

```text
Optional<String>
```

Example

```java
Optional<String> name =

Optional.of("Java");

Optional<String> result =

name.flatMap(

value -> Optional.of(
    value.toUpperCase()
)

);
```

---

# filter()

Returns the value only if it satisfies a condition.

```java
Optional<String> name =

Optional.of("Java");

Optional<String> result =

name.filter(

n -> n.startsWith("J")

);

System.out.println(

result.isPresent()

);
```

Output

```text
true
```

---

# Common Optional Methods

| Method | Purpose |
|---------|----------|
| of() | Creates Optional (non-null value) |
| ofNullable() | Creates Optional (nullable value) |
| empty() | Creates empty Optional |
| get() | Returns value |
| isPresent() | Checks value |
| isEmpty() | Checks empty |
| ifPresent() | Executes if value exists |
| orElse() | Returns default value |
| orElseGet() | Lazily computes default value |
| orElseThrow() | Throws exception |
| map() | Transforms value |
| flatMap() | Transforms Optional |
| filter() | Filters value |

---

# orElse() vs orElseGet()

```java
orElse(value)
```

The default value is created **every time**, even if the Optional contains a value.

---

```java
orElseGet(() -> value)
```

The default value is created **only when needed**.

---

# Internal Working

Suppose

```java
Optional<String> name =

Optional.of("Java");
```

Internally

```text
Value

↓

Optional Object

↓

Contains Value?

↓

Yes

↓

Return Value
```

If empty

```text
Optional.empty()

↓

No Value

↓

Return Default

or

Throw Exception
```

---

# Optional vs Null

| Null | Optional |
|------|----------|
| Can cause NullPointerException | Helps avoid NullPointerException |
| No methods | Useful utility methods |
| Harder to read | More expressive |
| Error-prone | Safer API design |

---

# Production Usage

Optional is widely used in:

- Spring Boot
- Repository methods
- Service layer
- Java Streams
- REST APIs

Example

```java
Optional<User> user =

userRepository.findById(id);
```

Then

```java
user.orElseThrow(

() -> new UserNotFoundException()

);
```

---

# Advantages

- Reduces NullPointerException
- Cleaner code
- Expressive API
- Better readability
- Encourages proper null handling

---

# Limitations

- Small memory overhead
- Not meant for every field in an entity
- Avoid using it for method parameters or serialization in most cases

---

# Best Practices

✅ Use `Optional` as a **return type** when a value may be absent.

✅ Prefer `orElseGet()` when creating the default value is expensive.

✅ Use `ifPresent()` for simple actions.

✅ Use `orElseThrow()` when absence is an error.

---

# Common Mistakes

❌ Calling `get()` without checking if a value exists.

---

❌ Using `Optional.of(null)`.

---

❌ Using `Optional` for entity fields or method parameters in most applications.

---

❌ Returning `null` instead of `Optional.empty()`.

---

# Interview Questions

### 1. What is Optional?

A container object that may or may not contain a value.

---

### 2. Why was Optional introduced?

To reduce `NullPointerException` and improve null handling.

---

### 3. What is the difference between `of()` and `ofNullable()`?

- `of()` does not allow `null`.
- `ofNullable()` accepts both `null` and non-null values.

---

### 4. What is `Optional.empty()`?

It creates an Optional that contains no value.

---

### 5. What is the difference between `orElse()` and `orElseGet()`?

- `orElse()` always creates the default value.
- `orElseGet()` creates it only when needed.

---

### 6. Why should `get()` be avoided?

Because it throws `NoSuchElementException` if the Optional is empty.

---

### 7. What does `map()` do?

It transforms the value inside an Optional if present.

---

### 8. What is `flatMap()` used for?

To avoid nested `Optional<Optional<T>>` results when the mapping function already returns an `Optional`.

---

### 9. Where is Optional used in Spring Boot?

It is commonly used as the return type of repository methods such as `findById()`.

---

### 10. Should Optional be used for entity fields?

Generally, no. It is mainly intended for **method return types**, not entity fields or method parameters.

---

# Quick Revision

- Optional = Wrapper for nullable values.
- `of()` → Non-null value.
- `ofNullable()` → Nullable value.
- `empty()` → Empty Optional.
- `isPresent()` → Check value.
- `ifPresent()` → Execute if value exists.
- `orElse()` → Default value.
- `orElseGet()` → Lazy default value.
- `orElseThrow()` → Throw exception.
- `map()` → Transform value.
- `flatMap()` → Flatten nested Optionals.
- Used mainly as a return type.

---

# Keywords

- Optional
- Optional.of()
- Optional.ofNullable()
- Optional.empty()
- isPresent()
- isEmpty()
- get()
- ifPresent()
- orElse()
- orElseGet()
- orElseThrow()
- map()
- flatMap()
- filter()
- NullPointerException
- Java 8