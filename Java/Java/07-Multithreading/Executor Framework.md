# Executor Framework (Java)

## What is the Executor Framework?

The **Executor Framework** is a high-level API in Java used to **manage and execute multiple tasks using thread pools** instead of creating threads manually.

It was introduced in **Java 5** under the package:

```java
java.util.concurrent
```

> **Definition:** The Executor Framework provides a way to efficiently execute asynchronous tasks by managing thread creation, scheduling, and reuse.

---

# Why Do We Need the Executor Framework?

Creating threads manually is inefficient.

Example:

```java
new Thread(task1).start();
new Thread(task2).start();
new Thread(task3).start();
```

Problems:

- Creates a new thread every time
- High memory usage
- Expensive thread creation
- Difficult thread management

Instead, use an Executor.

```
Tasks

↓

Executor Framework

↓

Thread Pool

↓

Reusable Threads
```

---

# Real-World Example

Imagine an office.

Without Executor Framework:

Every new customer hires a **new employee**.

```
Customer

↓

Hire Employee

↓

Complete Work

↓

Fire Employee
```

Very expensive.

---

With Executor Framework:

The office already has **10 employees**.

```
Customer

↓

Reception

↓

Available Employee

↓

Work Done

↓

Employee Ready for Next Customer
```

Employees are reused.

**Employee = Thread**

**Customer = Task**

---

# How Executor Framework Works

```text
Tasks Submitted

↓

ExecutorService

↓

Thread Pool

↓

Worker Threads

↓

Execute Tasks

↓

Thread Returns to Pool
```

The framework automatically manages:

- Thread creation
- Thread reuse
- Task scheduling
- Thread termination

---

# Main Components

## 1. Executor

Basic interface.

```java
Executor executor;
```

Contains:

```java
void execute(Runnable command);
```

Used to execute a task.

---

## 2. ExecutorService

Extends `Executor`.

Adds features like:

- submit()
- shutdown()
- Future
- invokeAll()

Most commonly used interface.

---

## 3. ScheduledExecutorService

Executes tasks:

- after a delay
- periodically

Example:

```java
ScheduledExecutorService scheduler;
```

---

## 4. Executors

Utility class used to create different types of executors.

Example:

```java
Executors.newFixedThreadPool(5);
```

---

# Architecture

```text
Runnable / Callable

↓

Executor

↓

ExecutorService

↓

Thread Pool

↓

Worker Threads
```

---

# Creating an Executor

```java
import java.util.concurrent.*;

ExecutorService executor =
        Executors.newFixedThreadPool(3);
```

Creates:

```
3 Worker Threads
```

---

# Executing Runnable

```java
ExecutorService executor =
        Executors.newFixedThreadPool(2);

executor.execute(() -> {
    System.out.println(
        Thread.currentThread().getName());
});

executor.shutdown();
```

Output

```text
pool-1-thread-1
```

---

# Using submit()

Unlike `execute()`,

`submit()` returns a `Future`.

```java
ExecutorService executor =
        Executors.newSingleThreadExecutor();

Future<Integer> future =
        executor.submit(() -> 100);

System.out.println(future.get());

executor.shutdown();
```

Output

```text
100
```

---

# Runnable vs Callable

## Runnable

```java
Runnable task = () -> {
    System.out.println("Hello");
};
```

- No return value
- Cannot throw checked exceptions directly

---

## Callable

```java
Callable<Integer> task = () -> 50;
```

- Returns a value
- Can throw checked exceptions

---

# Future

A **Future** represents the result of an asynchronous computation.

```java
Future<String> future =
executor.submit(() -> "Java");
```

Retrieve result:

```java
System.out.println(future.get());
```

---

# Common Executor Types

## 1. Fixed Thread Pool

```java
ExecutorService executor =
Executors.newFixedThreadPool(4);
```

Features:

- Fixed number of threads
- Extra tasks wait in queue

Best for:

- REST APIs
- Backend services

---

## 2. Cached Thread Pool

```java
ExecutorService executor =
Executors.newCachedThreadPool();
```

Features:

- Creates threads when required
- Reuses idle threads

Best for:

- Many short-lived tasks

---

## 3. Single Thread Executor

```java
ExecutorService executor =
Executors.newSingleThreadExecutor();
```

Only one thread.

Tasks execute sequentially.

---

## 4. Scheduled Thread Pool

```java
ScheduledExecutorService scheduler =
Executors.newScheduledThreadPool(2);
```

Used for:

- Notifications
- Cleanup
- Background jobs

Example:

```java
scheduler.schedule(() ->
    System.out.println("Hello"),
    5,
    TimeUnit.SECONDS);
```

---

## 5. Virtual Thread Executor (Java 21)

```java
try (ExecutorService executor =
         Executors.newVirtualThreadPerTaskExecutor()) {

    executor.submit(() ->
        System.out.println("Virtual Thread"));

}
```

Each task runs in its own **Virtual Thread**.

Ideal for:

- High-concurrency
- Blocking I/O

---

# Important Methods

## execute()

```java
executor.execute(task);
```

- Executes `Runnable`
- Returns nothing

---

## submit()

```java
Future<Integer> future =
executor.submit(task);
```

- Executes `Runnable` or `Callable`
- Returns `Future`

---

## shutdown()

```java
executor.shutdown();
```

Stops accepting new tasks.

Already submitted tasks continue.

---

## shutdownNow()

```java
executor.shutdownNow();
```

Attempts to stop running tasks immediately.

---

## awaitTermination()

Waits until all tasks complete.

```java
executor.awaitTermination(
10,
TimeUnit.SECONDS
);
```

---

# Internal Working

```
Task Submitted

↓

Task Queue

↓

Worker Thread

↓

Execute Task

↓

Worker Returns to Pool

↓

Next Task
```

No new thread is created for every task.

---

# Executor Framework vs Thread

| Thread | Executor Framework |
|---------|--------------------|
| Manual thread creation | Automatic management |
| One thread per task | Thread reuse |
| Difficult to manage | Easy to manage |
| Poor scalability | High scalability |
| Not preferred in enterprise apps | Preferred in production |

---

# Executor Framework vs Fork/Join

| Executor Framework | Fork/Join |
|--------------------|-----------|
| Independent tasks | One large task split into smaller tasks |
| General-purpose | CPU-intensive recursive tasks |
| Thread pools | Work-stealing pool |
| REST APIs, services | Parallel algorithms |

---

# Production Usage

The Executor Framework is used in:

- Spring Boot
- REST APIs
- Banking systems
- Payment gateways
- Email services
- Kafka consumers
- File processing
- Scheduled jobs
- Background workers
- Notification services

Example:

A Spring Boot application receives **1,000 user requests**.

Instead of creating 1,000 threads,

Tomcat (or another server) uses an executor-backed thread pool to assign requests to reusable worker threads.

---

# Advantages

- Thread reuse
- Better performance
- Lower memory usage
- Easy task management
- Supports asynchronous programming
- Built-in scheduling
- Scalable

---

# Disadvantages

- Incorrect thread pool size can reduce performance.
- Long-running tasks may block worker threads.
- Must properly shut down executors.
- Using the wrong executor type affects performance.

---

# Best Practices

✅ Prefer `ExecutorService` over creating threads manually.

✅ Always call `shutdown()`.

✅ Use `Callable` when a result is needed.

✅ Handle exceptions inside submitted tasks.

✅ Choose the appropriate executor type.

---

# Common Mistakes

❌ Creating threads manually instead of using executors.

❌ Forgetting `shutdown()`.

❌ Blocking worker threads unnecessarily.

❌ Using `newCachedThreadPool()` without understanding that it may create many threads.

❌ Ignoring exceptions returned through `Future`.

---

# Interview Questions

### 1. What is the Executor Framework?

A high-level Java framework for managing and executing asynchronous tasks using thread pools.

---

### 2. Why is Executor Framework better than creating threads manually?

Because it reuses threads, improves performance, reduces memory usage, and simplifies thread management.

---

### 3. What is `ExecutorService`?

`ExecutorService` is the most commonly used interface that manages thread pools and provides methods like `submit()`, `shutdown()`, and `invokeAll()`.

---

### 4. What is the difference between `execute()` and `submit()`?

| execute() | submit() |
|------------|-----------|
| Returns nothing | Returns a `Future` |
| `Runnable` only | `Runnable` or `Callable` |
| Cannot retrieve result | Can retrieve result |

---

### 5. What is a `Future`?

A `Future` represents the result of an asynchronous task and allows checking completion or retrieving the result later.

---

### 6. What is the difference between `Runnable` and `Callable`?

`Runnable` does not return a value, while `Callable` returns a value and can throw checked exceptions.

---

### 7. Why should we call `shutdown()`?

To stop accepting new tasks and allow the application to terminate gracefully after existing tasks complete.

---

### 8. What are the common executor types?

- Fixed Thread Pool
- Cached Thread Pool
- Single Thread Executor
- Scheduled Thread Pool
- Virtual Thread Executor (Java 21)

---

### 9. Is Executor Framework used in Spring Boot?

Yes.

Spring Boot uses executors for:

- `@Async`
- Background tasks
- Scheduled jobs
- Request processing (through the underlying server configuration)

---

### 10. Executor Framework vs Thread Pool?

A **Thread Pool** is the group of reusable worker threads.

The **Executor Framework** is the complete API that creates, manages, schedules, and controls those thread pools and task execution.

---

# Quick Revision

- Introduced in Java 5.
- Package: `java.util.concurrent`
- Uses thread pools to execute tasks.
- `ExecutorService` is the most commonly used interface.
- `execute()` → no return value.
- `submit()` → returns `Future`.
- `Callable` returns results.
- `shutdown()` should always be called.
- Supports Fixed, Cached, Single, Scheduled, and Virtual Thread executors.
- Widely used in Spring Boot and enterprise Java.

---

# Keywords

- Executor Framework
- Executor
- ExecutorService
- ScheduledExecutorService
- Executors
- Thread Pool
- Runnable
- Callable
- Future
- execute()
- submit()
- shutdown()
- awaitTermination()
- Virtual Thread Executor
- Asynchronous Programming
- Concurrency
- Multithreading
- Java 5