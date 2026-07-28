# Callable Interface (Java)

## What is Callable?

`Callable` is a **functional interface** in Java that represents a task which:

- Returns a result
- Can throw checked exceptions

It was introduced in **Java 5** as part of the `java.util.concurrent` package.

> **Definition:** `Callable` is a functional interface whose `call()` method executes a task and returns a value.

---

# Why Do We Need Callable?

Suppose you want to calculate:

```
10 + 20
```

using another thread.

With `Runnable`:

```java
Runnable task = () -> {
    System.out.println(10 + 20);
};
```

Problem:

You **cannot get the result back**.

With `Callable`:

```java
Callable<Integer> task = () -> 10 + 20;
```

Now,

You can retrieve:

```
30
```

---

# Real-World Example

Imagine ordering food.

### Runnable

```
Customer

↓

Order Food

↓

Food Prepared

↓

No Feedback
```

You don't receive any result.

---

### Callable

```
Customer

↓

Order Food

↓

Food Prepared

↓

Food Delivered
```

You receive something back.

**Callable = Task + Result**

---

# Callable Interface

```java
@FunctionalInterface
public interface Callable<V> {

    V call() throws Exception;

}
```

The interface has only **one abstract method**:

```java
V call() throws Exception;
```

---

# How Callable Works

```text
Callable Task

↓

ExecutorService

↓

Worker Thread

↓

call()

↓

Future

↓

Result
```

Unlike `Runnable`, a `Callable` is typically executed using an `ExecutorService`.

---

# Creating a Callable

```java
Callable<Integer> task = () -> {

    return 100;

};
```

---

# Executing Callable

```java
import java.util.concurrent.*;

public class Main {

    public static void main(String[] args)
            throws Exception {

        ExecutorService executor =
                Executors.newSingleThreadExecutor();

        Callable<Integer> task = () -> 50;

        Future<Integer> future =
                executor.submit(task);

        System.out.println(future.get());

        executor.shutdown();

    }

}
```

Output

```text
50
```

---

# What is Future?

A `Future` represents the result of an asynchronous task.

```java
Future<Integer> future =
executor.submit(task);
```

Retrieve result:

```java
Integer result = future.get();
```

---

# Future Methods

## get()

Returns the task result.

```java
future.get();
```

---

## isDone()

Checks whether the task has finished.

```java
future.isDone();
```

Returns

```text
true

or

false
```

---

## cancel()

Attempts to cancel the task.

```java
future.cancel(true);
```

---

# Callable Example

```java
Callable<String> task = () -> {

    return "Hello Java";

};
```

Output

```text
Hello Java
```

---

# Callable Throwing Exception

Unlike `Runnable`,

`Callable` can throw checked exceptions.

```java
Callable<Integer> task = () -> {

    if (true)
        throw new Exception("Error");

    return 10;

};
```

This is one of the biggest advantages of `Callable`.

---

# Internal Working

```
Callable

↓

ExecutorService

↓

Thread Pool

↓

call()

↓

Future

↓

Main Thread Receives Result
```

The calling thread can continue doing other work while the task executes in the background.

---

# Callable vs Runnable

| Runnable | Callable |
|----------|----------|
| `run()` | `call()` |
| No return value | Returns a value |
| Cannot throw checked exceptions directly | Can throw checked exceptions |
| Introduced in Java 1.0 | Introduced in Java 5 |
| Used with `Thread` or `ExecutorService` | Used with `ExecutorService` |

---

# submit() vs execute()

| submit() | execute() |
|-----------|-----------|
| Returns `Future` | Returns nothing |
| Supports `Callable` and `Runnable` | Supports only `Runnable` |
| Can retrieve result | No result |
| Can retrieve exceptions through `Future` | Exceptions are not returned to the caller |

---

# Production Usage

`Callable` is widely used in:

- Spring Boot
- Database queries
- REST API calls
- Payment systems
- Report generation
- Background processing
- Parallel computations
- File processing

Example:

A Spring Boot application needs to fetch:

- User Details
- Order History
- Payment Details

These tasks can run in parallel using `Callable`, and their results are collected when complete.

---

# Advantages

- Returns a value
- Can throw checked exceptions
- Supports asynchronous programming
- Works with thread pools
- Easy to retrieve results using `Future`

---

# Disadvantages

- Cannot be executed directly using `Thread.start()`
- Requires an `ExecutorService` (or another framework that supports `Callable`)
- Slightly more complex than `Runnable`

---

# Best Practices

✅ Use `Callable` when a task must return a result.

✅ Use `Runnable` for fire-and-forget tasks.

✅ Always shut down the `ExecutorService`.

✅ Handle exceptions from `future.get()`.

---

# Common Mistakes

❌ Trying to pass a `Callable` directly to a `Thread`.

```java
Thread t = new Thread(task); // ❌ Not allowed
```

`Thread` accepts a `Runnable`, not a `Callable`.

---

❌ Forgetting to call `shutdown()`.

---

❌ Calling `future.get()` immediately after every submission, which may block and reduce concurrency.

---

# Interview Questions

### 1. What is Callable?

A functional interface that represents a task capable of returning a result and throwing checked exceptions.

---

### 2. What is the difference between Runnable and Callable?

| Runnable | Callable |
|----------|----------|
| No return value | Returns a value |
| `run()` | `call()` |
| Cannot throw checked exceptions directly | Can throw checked exceptions |

---

### 3. Can Callable return a value?

Yes.

That is its primary purpose.

---

### 4. Can Callable throw exceptions?

Yes.

It can throw checked exceptions.

---

### 5. What is Future?

A `Future` represents the result of an asynchronous computation and allows you to retrieve the result later.

---

### 6. Which method executes a Callable?

```java
executor.submit(task);
```

---

### 7. Can we create a Thread using Callable?

No.

`Thread` works with `Runnable`.

To execute a `Callable`, use an `ExecutorService`.

---

### 8. What does `future.get()` do?

It waits (if necessary) until the task completes and then returns the result.

---

### 9. Is Callable a Functional Interface?

Yes.

It contains one abstract method:

```java
V call() throws Exception;
```

---

### 10. When should we use Callable?

Use it when:

- A result is required.
- The task may throw checked exceptions.
- The task runs asynchronously.

---

# Quick Revision

- `Callable` introduced in Java 5.
- Package: `java.util.concurrent`.
- Functional interface.
- Method: `call()`.
- Returns a value.
- Can throw checked exceptions.
- Executed using `ExecutorService`.
- `submit()` returns a `Future`.
- `future.get()` retrieves the result.
- Preferred over `Runnable` when a result is needed.

---

# Keywords

- Callable
- call()
- Future
- ExecutorService
- submit()
- Asynchronous Programming
- Thread Pool
- Functional Interface
- java.util.concurrent
- Result
- Checked Exception
- Concurrency
- Multithreading
- Java 5