# CompletableFuture

## What is CompletableFuture?

**CompletableFuture** is a Java class introduced in **Java 8** that allows you to execute asynchronous tasks and handle their results without blocking the current thread.

It is an improved version of the older `Future` interface.

It is commonly used with:

- Spring Boot
- `@Async`
- Microservices
- Parallel API Calls
- Background Processing

> **In simple words:**
>
> CompletableFuture lets your application perform a task in the background and receive the result later when it is ready.

---

# Why Do We Need CompletableFuture?

Imagine an E-Commerce application.

To display an order page, we need:

- User Details
- Order Details
- Payment Details

Without CompletableFuture

```
Get User

↓

Wait

↓

Get Order

↓

Wait

↓

Get Payment

↓

Response
```

Problems

- Slow response
- Tasks execute one after another
- Poor performance

---

With CompletableFuture

```
Get User

        ↘

         ↘

Get Order -----> Run Together

         ↗

        ↗

Get Payment

↓

Combine Results

↓

Response
```

Multiple tasks run in parallel.

---

# Real-World Example

Imagine preparing dinner.

Without parallel work

```
Cook Rice

↓

Cook Curry

↓

Make Salad

↓

Serve
```

Everything happens one after another.

With parallel work

```
Person A → Cook Rice

Person B → Cook Curry

Person C → Make Salad

↓

Serve Together
```

CompletableFuture works in the same way.

---

# CompletableFuture Architecture

```
Main Thread

↓

CompletableFuture

↓

Thread Pool

↓

Background Task

↓

Result
```

---

# Basic Example

```java
CompletableFuture<String> future =

        CompletableFuture

                .completedFuture(

                        "Hello"

                );

System.out.println(

        future.get()

);
```

---

# Running a Task

```java
CompletableFuture.runAsync(

        () -> {

            System.out.println(

                    "Running..."

            );

        }

);
```

Used when no result is required.

---

# Returning a Result

```java
CompletableFuture<String> future =

        CompletableFuture

                .supplyAsync(

                        () -> "Spring Boot"

                );
```

Used when the task returns a value.

---

# runAsync vs supplyAsync

| runAsync() | supplyAsync() |
|-------------|---------------|
| No return value | Returns a value |
| Uses `Runnable` | Uses `Supplier<T>` |
| Fire-and-forget tasks | Background tasks with results |

---

# Getting the Result

```java
String result =

        future.get();
```

`get()` waits until the task finishes.

---

# Joining the Result

```java
String result =

        future.join();
```

`join()` also waits for completion but throws unchecked exceptions instead of checked exceptions.

---

# Combining Two Tasks

```java
CompletableFuture<String> user =

        CompletableFuture

                .supplyAsync(

                        () -> "Yash"

                );

CompletableFuture<String> order =

        CompletableFuture

                .supplyAsync(

                        () -> "Order"

                );

CompletableFuture<String> result =

        user.thenCombine(

                order,

                (u, o) -> u + " " + o

        );
```

Flow

```
Task A

↓

Task B

↓

Combine

↓

Result
```

---

# Running Multiple Tasks

```java
CompletableFuture.allOf(

        future1,

        future2,

        future3

).join();
```

Flow

```
Task 1

Task 2

Task 3

↓

Wait for All

↓

Continue
```

---

# Waiting for Any Task

```java
CompletableFuture.anyOf(

        future1,

        future2

);
```

Flow

```
Task A

Task B

↓

First Completed

↓

Continue
```

---

# Exception Handling

```java
CompletableFuture

        .supplyAsync(

                () -> 10 / 0

        )

        .exceptionally(

                ex -> "Error"

        );
```

If an exception occurs,

a fallback value is returned.

---

# Using CompletableFuture with @Async

```java
@Async
public CompletableFuture<String> sendEmail(){

    return CompletableFuture.completedFuture(

            "Email Sent"

    );

}
```

Flow

```
Controller

↓

@Async Method

↓

CompletableFuture

↓

Background Thread

↓

Result
```

---

# Spring Boot Architecture

```
Client

↓

Controller

↓

Service

↓

@Async

↓

CompletableFuture

↓

Thread Pool

↓

Response
```

---

# Common Use Cases

- Parallel API Calls
- Sending Emails
- File Processing
- Payment Processing
- Report Generation
- Notification Services
- Image Processing
- Microservices Communication

---

# CompletableFuture vs Future

| CompletableFuture | Future |
|-------------------|--------|
| Java 8 | Java 5 |
| Supports chaining | No chaining |
| Supports callbacks | No callbacks |
| Better exception handling | Limited exception handling |
| Can combine tasks | Cannot combine tasks easily |

---

# CompletableFuture vs Thread

| CompletableFuture | Thread |
|-------------------|--------|
| High-level API | Low-level API |
| Uses thread pools | Manual thread creation |
| Easy to combine tasks | More complex |
| Better for async programming | Better for simple thread control |

---

# Common Mistakes

❌ Calling `get()` too early, making the code block unnecessarily.

❌ Ignoring exceptions in asynchronous tasks.

❌ Creating too many asynchronous tasks without a proper thread pool.

❌ Using asynchronous processing for very small operations where it adds unnecessary overhead.

❌ Forgetting to combine related tasks efficiently.

---

# Real-World Example

## Banking Application

```
Transfer Money

↓

Run Together

├── Update Balance

├── Send SMS

└── Send Email

↓

Complete
```

---

## E-Commerce Website

```
Order Placed

↓

Parallel Tasks

├── Payment

├── Inventory

├── Email

└── Invoice

↓

Success
```

---

## Food Delivery App

```
Order Delivered

↓

Parallel Tasks

├── Reward Points

├── Notification

└── Analytics

↓

Completed
```

---

# Advantages

- Supports asynchronous programming.
- Executes multiple tasks in parallel.
- Better performance.
- Easy task chaining.
- Built-in exception handling.
- Integrates well with Spring Boot.

---

# Best Practices

- Prefer `supplyAsync()` when a result is required.
- Use `runAsync()` for fire-and-forget tasks.
- Avoid blocking with `get()` unless necessary.
- Handle exceptions using `exceptionally()` or `handle()`.
- Use thread pools instead of creating new threads.
- Combine independent tasks to improve performance.

---

# Interview Questions

### 1. What is CompletableFuture?

CompletableFuture is a Java 8 class used for asynchronous programming and handling task results in the future.

---

### 2. What is the difference between `runAsync()` and `supplyAsync()`?

- `runAsync()` executes a task without returning a result.
- `supplyAsync()` executes a task and returns a result.

---

### 3. What is the difference between `get()` and `join()`?

- `get()` throws checked exceptions.
- `join()` throws unchecked exceptions (`CompletionException`).

---

### 4. What does `allOf()` do?

`allOf()` waits for multiple `CompletableFuture` instances to complete before continuing.

---

### 5. What does `anyOf()` do?

`anyOf()` completes as soon as the first `CompletableFuture` finishes.

---

### 6. Can CompletableFuture be used with `@Async`?

Yes.

Spring Boot commonly uses `CompletableFuture` as the return type for `@Async` methods when the result is needed later.

---

### 7. Why is CompletableFuture better than Future?

Because it supports chaining, combining multiple tasks, callbacks, and better exception handling.

---

# Quick Revision

- `CompletableFuture` is used for asynchronous programming in Java.
- `runAsync()` executes tasks without returning a result.
- `supplyAsync()` executes tasks and returns a value.
- `get()` and `join()` retrieve results.
- `allOf()` waits for all tasks.
- `anyOf()` waits for the first completed task.
- It integrates well with Spring Boot and `@Async`.
- It is widely used for parallel API calls and background processing.