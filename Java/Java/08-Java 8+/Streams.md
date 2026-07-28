# Streams API (Java 8)

## What is the Streams API?

The **Streams API** is a feature introduced in **Java 8** that allows us to process collections of data in a **declarative and functional** way.

A Stream does **not store data**. It simply processes data from a source such as:

- List
- Set
- Map
- Arrays

> **Definition:** A Stream is a sequence of elements that supports operations like filtering, mapping, sorting, and collecting data.

> **Note:** This is **different** from Java File I/O Streams (`InputStream`, `OutputStream`).

---

# Why Do We Need Streams API?

Before Java 8, processing collections required:

- for loops
- Nested loops
- Manual filtering
- Temporary collections

Example:

```java
List<String> names =
List.of("Java", "Spring", "Docker");

for(String name : names){

    if(name.startsWith("J")){

        System.out.println(name);

    }

}
```

Streams make this much cleaner.

```java
names.stream()

     .filter(name -> name.startsWith("J"))

     .forEach(System.out::println);
```

---

# Real-World Example

Imagine a water purification plant.

```
Dirty Water

↓

Filter

↓

Clean Water

↓

Bottle

↓

Customer
```

Similarly,

```
Collection

↓

Filter

↓

Map

↓

Sort

↓

Collect

↓

Result
```

Each operation processes the data step by step.

---

# Stream Pipeline

A Stream works as a **pipeline**.

```text
Collection

↓

Stream

↓

Intermediate Operations

↓

Terminal Operation

↓

Result
```

---

# Creating a Stream

From a List

```java
List<String> names =
List.of("Java", "Spring", "Docker");

Stream<String> stream =
names.stream();
```

---

From an Array

```java
String[] arr =
{"Java", "Spring"};

Stream<String> stream =
Arrays.stream(arr);
```

---

Using Stream.of()

```java
Stream<String> stream =

Stream.of("Java",
          "Spring",
          "Docker");
```

---

# Stream Operations

There are two types.

## 1. Intermediate Operations

They return another Stream.

Examples:

- filter()
- map()
- flatMap()
- sorted()
- distinct()
- limit()
- skip()

They are **lazy**, meaning they execute only when a terminal operation is called.

---

## 2. Terminal Operations

They produce the final result.

Examples:

- forEach()
- collect()
- count()
- reduce()
- findFirst()
- anyMatch()
- allMatch()

---

# filter()

Filters elements based on a condition.

```java
List<Integer> numbers =
List.of(10,20,25,40);

numbers.stream()

       .filter(n -> n > 20)

       .forEach(System.out::println);
```

Output

```text
25
40
```

---

# map()

Transforms each element.

```java
List<String> names =
List.of("java","spring");

names.stream()

     .map(String::toUpperCase)

     .forEach(System.out::println);
```

Output

```text
JAVA
SPRING
```

---

# flatMap()

Used when each element contains another collection or stream.

Without `flatMap()`

```text
[[1,2],[3,4]]
```

With `flatMap()`

```text
[1,2,3,4]
```

Example

```java
List<List<Integer>> list =
List.of(
    List.of(1,2),
    List.of(3,4)
);

list.stream()

    .flatMap(List::stream)

    .forEach(System.out::println);
```

Output

```text
1
2
3
4
```

---

# sorted()

Sorts elements.

```java
numbers.stream()

       .sorted()

       .forEach(System.out::println);
```

---

# distinct()

Removes duplicate elements.

```java
List<Integer> list =
List.of(1,2,2,3,3,4);

list.stream()

    .distinct()

    .forEach(System.out::println);
```

Output

```text
1
2
3
4
```

---

# limit()

Returns the first N elements.

```java
numbers.stream()

       .limit(3)

       .forEach(System.out::println);
```

---

# skip()

Skips the first N elements.

```java
numbers.stream()

       .skip(2)

       .forEach(System.out::println);
```

---

# collect()

Collects the Stream into a collection.

```java
List<String> result =

names.stream()

     .map(String::toUpperCase)

     .collect(Collectors.toList());
```

---

# Common Collectors

| Collector | Purpose |
|-----------|---------|
| toList() | Collect into List |
| toSet() | Collect into Set |
| joining() | Join Strings |
| counting() | Count elements |
| groupingBy() | Group elements |
| partitioningBy() | Split into two groups |

---

# reduce()

Reduces multiple values into one.

```java
int sum =

List.of(1,2,3,4)

    .stream()

    .reduce(0,
            Integer::sum);

System.out.println(sum);
```

Output

```text
10
```

---

# count()

```java
long count =

names.stream()

     .count();
```

---

# findFirst()

```java
Optional<String> first =

names.stream()

     .findFirst();
```

---

# anyMatch()

```java
boolean result =

names.stream()

     .anyMatch(

         name -> name.equals("Java")

     );
```

---

# allMatch()

```java
boolean result =

numbers.stream()

       .allMatch(

           n -> n > 0

       );
```

---

# Stream Pipeline Example

```java
List<String> result =

names.stream()

     .filter(name -> name.length() > 4)

     .map(String::toUpperCase)

     .sorted()

     .collect(Collectors.toList());
```

---

# Parallel Stream

A Parallel Stream processes data using multiple threads.

```java
numbers.parallelStream()

       .forEach(System.out::println);
```

Useful for CPU-intensive operations on large datasets.

> **Note:** Parallel Streams are **not always faster**. They have overhead and are most beneficial for large datasets with independent operations.

---

# Internal Working

```text
Collection

↓

Stream Created

↓

filter()

↓

map()

↓

sorted()

↓

collect()

↓

Result
```

Intermediate operations are **lazy**.

Nothing executes until a terminal operation is called.

---

# Streams vs Collections

| Collection | Stream |
|------------|--------|
| Stores data | Processes data |
| Can modify data | Cannot modify original collection |
| Eager | Lazy (intermediate operations) |
| Reusable | Cannot be reused after a terminal operation |

---

# Production Usage

Streams are heavily used in:

- Spring Boot
- REST APIs
- Database result processing
- CSV processing
- Report generation
- Data transformation
- Filtering API responses

Example

```java
employees.stream()

         .filter(Employee::isActive)

         .map(Employee::getName)

         .sorted()

         .toList();
```

---

# Advantages

- Cleaner code
- Less boilerplate
- Functional programming
- Easy filtering and transformation
- Parallel processing support

---

# Limitations

- Not ideal for every problem
- Can be harder to debug
- Cannot reuse a Stream after a terminal operation
- Parallel Streams can introduce overhead

---

# Best Practices

✅ Keep Stream pipelines readable.

✅ Prefer Method References when possible.

✅ Avoid modifying external variables inside Streams.

✅ Use Parallel Streams only when performance testing shows a benefit.

---

# Common Mistakes

❌ Reusing a Stream after a terminal operation.

---

❌ Writing overly complex Stream pipelines.

---

❌ Using Parallel Streams for small collections.

---

❌ Using Streams when a simple loop is more readable.

---

# Interview Questions

### 1. What is a Stream in Java 8?

A Stream is a sequence of elements used to process data from collections in a functional way.

---

### 2. Is a Stream the same as `InputStream`?

No.

`InputStream` is used for File I/O.

Java Streams API is used for collection processing.

---

### 3. What are Intermediate Operations?

Operations like `filter()`, `map()`, and `sorted()` that return another Stream.

---

### 4. What are Terminal Operations?

Operations like `collect()`, `forEach()`, and `reduce()` that produce the final result.

---

### 5. What is lazy evaluation?

Intermediate operations are executed only when a terminal operation is called.

---

### 6. What is the difference between `map()` and `flatMap()`?

- `map()` transforms each element.
- `flatMap()` transforms and flattens nested collections or streams.

---

### 7. What does `reduce()` do?

It combines multiple elements into a single result.

---

### 8. Can a Stream be reused?

No.

After a terminal operation, the Stream is closed and cannot be reused.

---

### 9. What is a Parallel Stream?

A Stream that processes elements concurrently using multiple threads.

---

### 10. Where are Streams used in Spring Boot?

Streams are commonly used for filtering, transforming, sorting, grouping, and processing collections returned from databases or APIs.

---

# Quick Revision

- Stream = Processes data, doesn't store it.
- Pipeline:
  - Source
  - Intermediate Operations
  - Terminal Operation
- Intermediate:
  - filter()
  - map()
  - flatMap()
  - sorted()
  - distinct()
  - limit()
  - skip()
- Terminal:
  - collect()
  - reduce()
  - count()
  - forEach()
  - findFirst()
- Streams are lazy.
- Streams cannot be reused.
- Parallel Streams use multiple threads.

---

# Keywords

- Streams API
- Stream Pipeline
- filter()
- map()
- flatMap()
- sorted()
- distinct()
- limit()
- skip()
- collect()
- Collectors
- reduce()
- Parallel Stream
- Lazy Evaluation
- Terminal Operation
- Intermediate Operation
- Java 8