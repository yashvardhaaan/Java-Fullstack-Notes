# CompletableFuture (Java)

## What is CompletableFuture?

`CompletableFuture` is a class introduced in **Java 8** that allows you to execute tasks **asynchronously**, combine multiple tasks, and process their results without blocking the current thread.

It is part of:

```java
java.util.concurrent
```

> **Definition:** `CompletableFuture` is an advanced implementation of `Future` that supports asynchronous programming, task chaining, combining multiple tasks, and exception handling.

---

# Why Do We Need CompletableFuture?

Suppose a user opens an e-commerce website.

The application needs to fetch:

- User Details
- Product List
- Order History
- Recommendations

### Without CompletableFuture

```
Fetch User

↓

Fetch Products

↓

Fetch Orders

↓

Fetch Recommendations
```

Each task waits for the previous one.

Total Time:

```
1 sec + 1 sec + 1 sec + 1 sec = 4 sec
```

---

### With CompletableFuture

```
Fetch User ───────┐

Fetch Products ───┼──► Run Together

Fetch Orders ─────┤

Fetch Recommendations ┘
```

All tasks run in parallel.

Total Time:

```
≈ 1 second
```

Much faster.

---

# Real-World Example

Imagine ordering food.

Without CompletableFuture:

```
Order Pizza

↓

Wait

↓

Order Drink

↓

Wait

↓

Order Dessert
```

Very slow.

---

With CompletableFuture:

```
Pizza

Drink

Dessert

↓

Prepared Together

↓

Delivered Together
```

Multiple tasks happen simultaneously.

---

# Why Not Use Future?

Example:

```java
Future<String> future =
executor.submit(() -> "Java");

System.out.println(future.get());
```

Problem:

`get()` blocks the current thread.

```
Main Thread

↓

Wait

↓

Result Arrives
```

Nothing else can happen.

CompletableFuture allows you to continue working while the task runs.

---

# Creating a CompletableFuture

## 1. completedFuture()

Creates an already completed future.

```java
CompletableFuture<String> future =
CompletableFuture.completedFuture("Java");
```

---

## 2. supplyAsync()

Runs a task asynchronously and **returns a result**.

```java
CompletableFuture<String> future =
CompletableFuture.supplyAsync(() -> {

    return "Hello";

});
```

---

## 3. runAsync()

Runs a task asynchronously but **returns nothing**.

```java
CompletableFuture<Void> future =
CompletableFuture.runAsync(() -> {

    System.out.println("Running");

});
```

---

# supplyAsync Example

```java
CompletableFuture<String> future =
CompletableFuture.supplyAsync(() -> {

    return "Java";

});

System.out.println(future.join());
```

Output

```text
Java
```

---

# runAsync Example

```java
CompletableFuture<Void> future =
CompletableFuture.runAsync(() -> {

    System.out.println("Task Running");

});

future.join();
```

Output

```text
Task Running
```

---

# Chaining Tasks

One task can start after another finishes.

```java
CompletableFuture<String> future =

CompletableFuture
        .supplyAsync(() -> "Java")

        .thenApply(str -> str + " Spring");

System.out.println(future.join());
```

Output

```text
Java Spring
```

---

# thenApply()

Transforms the result.

```java
.thenApply(String::toUpperCase)
```

Example

```
Java

↓

JAVA
```

---

# thenAccept()

Consumes the result.

```java
CompletableFuture
        .supplyAsync(() -> "Java")
        .thenAccept(System.out::println);
```

Output

```text
Java
```

Returns:

```
Void
```

---

# thenRun()

Runs another task after completion.

Doesn't receive any previous result.

```java
CompletableFuture
        .runAsync(() -> System.out.println("A"))
        .thenRun(() -> System.out.println("B"));
```

Output

```text
A

B
```

---

# Combining Multiple Futures

## thenCombine()

```java
CompletableFuture<String> user =

CompletableFuture
        .supplyAsync(() -> "Yash");

CompletableFuture<String> order =

CompletableFuture
        .supplyAsync(() -> "Laptop");

CompletableFuture<String> result =

user.thenCombine(order,
        (u, o) -> u + " ordered " + o);

System.out.println(result.join());
```

Output

```text
Yash ordered Laptop
```

---

# allOf()

Waits for all tasks.

```java
CompletableFuture<Void> future =

CompletableFuture.allOf(
        future1,
        future2,
        future3
);

future.join();
```

---

# anyOf()

Returns when **any one task** completes.

```java
CompletableFuture.anyOf(
future1,
future2,
future3
);
```

---

# Exception Handling

## exceptionally()

```java
CompletableFuture<String> future =

CompletableFuture
        .supplyAsync(() -> {

            throw new RuntimeException();

        })

        .exceptionally(ex -> "Default");

System.out.println(future.join());
```

Output

```text
Default
```

---

## handle()

Can process both:

- Success
- Failure

```java
future.handle((result, ex) -> {

    if (ex != null)
        return "Error";

    return result;

});
```

---

# join() vs get()

| join() | get() |
|----------|--------|
| Throws unchecked exceptions | Throws checked exceptions |
| No try-catch required | Requires exception handling |
| Commonly used | Older style |

Example

```java
future.join();
```

---

# Internal Working

```
Main Thread

↓

CompletableFuture

↓

Thread Pool

↓

Background Thread

↓

Task Executes

↓

Result Ready

↓

Callback Executes
```

Unlike `Future`, the main thread doesn't have to block immediately waiting for the result.

---

# CompletableFuture vs Future

| Future | CompletableFuture |
|----------|-------------------|
| Introduced in Java 5 | Introduced in Java 8 |
| Blocking API | Supports non-blocking task composition |
| No task chaining | Supports chaining |
| No combining | Supports combining tasks |
| Limited exception handling | Rich exception handling |

---

# CompletableFuture vs ExecutorService

| ExecutorService | CompletableFuture |
|-----------------|-------------------|
| Executes tasks | Executes tasks + asynchronous workflows |
| Thread management | Task composition |
| Basic concurrency | Advanced asynchronous programming |

> **Note:** `CompletableFuture` often uses an `ExecutorService` internally. By default, async methods use the `ForkJoinPool.commonPool()` unless you provide a custom executor.

---

# Production Usage

CompletableFuture is widely used in:

- Spring Boot
- REST APIs
- Payment gateways
- Microservices
- Database queries
- External API calls
- Email services
- Notification systems

Example:

A banking application receives a request.

It fetches simultaneously:

- Customer Details
- Account Balance
- Recent Transactions
- Loan Information

All four operations run asynchronously and the results are combined before sending the response.

---

# Advantages

- Non-blocking programming
- Better performance
- Easy task chaining
- Combine multiple asynchronous tasks
- Better exception handling
- Cleaner asynchronous code

---

# Disadvantages

- More difficult to debug
- Can become hard to read if overused
- Incorrect chaining may cause unexpected behavior
- Still needs proper thread management

---

# Best Practices

✅ Use `supplyAsync()` when a result is needed.

✅ Use `runAsync()` for background tasks without a return value.

✅ Use `thenCompose()` when one asynchronous task depends on another asynchronous task.

✅ Use `allOf()` to wait for multiple independent tasks.

✅ Provide a custom `ExecutorService` for production instead of always relying on the common pool.

---

# Common Mistakes

❌ Calling `get()` everywhere, making the code effectively synchronous.

❌ Using `join()` too early and blocking unnecessarily.

❌ Ignoring exception handling.

❌ Running blocking database or network calls on the common pool without considering its impact.

---

# Interview Questions

### 1. What is CompletableFuture?

A Java 8 class for asynchronous programming that supports task execution, chaining, combining, and exception handling.

---

### 2. Difference between Future and CompletableFuture?

`Future` mainly represents the result of one asynchronous task.

`CompletableFuture` additionally supports chaining, combining tasks, callbacks, and richer exception handling.

---

### 3. Difference between `runAsync()` and `supplyAsync()`?

| runAsync() | supplyAsync() |
|-------------|---------------|
| No return value | Returns a result |
| Returns `CompletableFuture<Void>` | Returns `CompletableFuture<T>` |

---

### 4. What does `thenApply()` do?

Transforms the result of a completed task.

---

### 5. Difference between `thenApply()` and `thenCompose()`?

- `thenApply()` transforms a value into another value.
- `thenCompose()` chains another asynchronous operation that itself returns a `CompletableFuture`.

---

### 6. What is `allOf()`?

Waits for all supplied `CompletableFuture`s to complete.

---

### 7. What is `anyOf()`?

Completes when the first supplied `CompletableFuture` completes.

---

### 8. Difference between `join()` and `get()`?

`join()` throws unchecked exceptions.

`get()` throws checked exceptions and may require handling `InterruptedException` and `ExecutionException`.

---

### 9. Which thread pool does `CompletableFuture.supplyAsync()` use by default?

By default, it uses the **ForkJoinPool.commonPool()**, unless a custom executor is supplied.

---

### 10. Is CompletableFuture used in Spring Boot?

Yes.

It is commonly used for:

- Parallel service calls
- Async REST processing
- Background tasks
- Microservices communication

---

# Quick Revision

- Introduced in Java 8.
- Package: `java.util.concurrent`.
- Advanced version of `Future`.
- `runAsync()` → No result.
- `supplyAsync()` → Returns result.
- `thenApply()` → Transform result.
- `thenAccept()` → Consume result.
- `thenRun()` → Run another task.
- `thenCombine()` → Combine two futures.
- `allOf()` → Wait for all tasks.
- `anyOf()` → Wait for any task.
- `exceptionally()` → Handle exceptions.
- `join()` → Get result (unchecked exceptions).
- Default async executor is `ForkJoinPool.commonPool()`.

---

# Keywords

- CompletableFuture
- Future
- supplyAsync()
- runAsync()
- thenApply()
- thenCompose()
- thenAccept()
- thenRun()
- thenCombine()
- allOf()
- anyOf()
- exceptionally()
- handle()
- join()
- get()
- ForkJoinPool.commonPool()
- Asynchronous Programming
- Java 8
- Concurrency
- Multithreading
```