# Thread Pool (Java)

## What is a Thread Pool?

A **Thread Pool** is a collection of **pre-created worker threads** that are reused to execute multiple tasks instead of creating a new thread for every task.

Instead of:

```
Task 1 → New Thread
Task 2 → New Thread
Task 3 → New Thread
...
```

We do:

```
Task 1 ─┐
Task 2 ─┼──► Thread Pool (Reusable Threads)
Task 3 ─┘
```

A thread completes one task, returns to the pool, and is reused for the next task.

> **Definition:** A Thread Pool is a group of reusable worker threads managed by the JVM (through `ExecutorService`) to execute tasks efficiently.

---

# Why Do We Need a Thread Pool?

Creating a thread is expensive because the JVM and Operating System must:

- Allocate memory
- Create a native OS thread
- Register it with the scheduler
- Perform context switching
- Destroy the thread after completion

Imagine a web server receiving **10,000 requests**.

Without a thread pool:

```
10,000 Requests
       │
       ▼
10,000 New Threads
```

Problems:

- Huge memory consumption
- Slow thread creation
- Heavy CPU scheduling
- Poor performance
- Possible OutOfMemoryError

With a thread pool:

```
10,000 Requests
        │
        ▼
   Queue of Tasks
        │
        ▼
20 Worker Threads
```

The same 20 threads keep executing all requests one by one.

---

# Real-World Example

Imagine a restaurant.

### Without Thread Pool

Every customer gets a **new chef**.

- Customer arrives
- Hire a chef
- Cook food
- Fire the chef

Very expensive.

---

### With Thread Pool

Restaurant already has **5 chefs**.

```
Customer
    │
    ▼
Available Chef
    │
Cook Food
    │
Chef Becomes Free
    │
Next Customer
```

The chef is reused.

**Chef = Thread**

**Customer Order = Task**

---

# How Thread Pool Works

```text
Tasks Submitted
       │
       ▼
+----------------+
| ExecutorService|
+----------------+
       │
       ▼
+----------------+
|  Thread Pool   |
+----------------+
 │     │      │
 ▼     ▼      ▼
T1     T2     T3
 │      │      │
Execute Tasks
 │      │      │
 └──────┴──────┘
       │
 Thread Returns to Pool
```

---

# Components of a Thread Pool

## 1. Task

The work that needs to be executed.

Usually a:

- Runnable
- Callable

Example

```java
Runnable task = () -> System.out.println("Hello");
```

---

## 2. Worker Thread

A thread inside the pool that executes tasks.

Example:

```
Thread-1

Thread-2

Thread-3
```

---

## 3. Task Queue

If every thread is busy,

incoming tasks wait inside a queue.

```
Queue

Task 6

Task 7

Task 8
```

As soon as a worker becomes free,

it picks the next task.

---

## 4. ExecutorService

Main interface used to manage the thread pool.

It:

- Creates threads
- Assigns tasks
- Reuses threads
- Shuts down threads

---

# ExecutorService

```java
ExecutorService executor =
        Executors.newFixedThreadPool(4);
```

Here,

4 worker threads are created.

Whenever tasks arrive,

one available worker executes them.

---

# Creating a Fixed Thread Pool

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Main {

    public static void main(String[] args) {

        ExecutorService executor =
                Executors.newFixedThreadPool(3);

        for(int i=1;i<=10;i++){

            int task=i;

            executor.execute(() -> {

                System.out.println(
                        "Task "
                        + task +
                        " executed by "
                        + Thread.currentThread().getName());

            });

        }

        executor.shutdown();
    }

}
```

Possible Output

```
Task 1 executed by pool-1-thread-1
Task 2 executed by pool-1-thread-2
Task 3 executed by pool-1-thread-3
Task 4 executed by pool-1-thread-1
Task 5 executed by pool-1-thread-2
...
```

Notice:

Only **3 threads** execute **10 tasks**.

Threads are reused.

---

# Internal Working

Suppose we have

```
Pool Size = 3

Tasks = 8
```

Initially

```
Thread1 Free

Thread2 Free

Thread3 Free
```

Task Assignment

```
Thread1 → Task1

Thread2 → Task2

Thread3 → Task3
```

Now Task4 arrives.

All workers are busy.

```
Queue

Task4
```

Thread1 finishes.

```
Thread1

Task4
```

No new thread is created.

The existing thread is reused.

---

# Types of Thread Pools

## 1. Fixed Thread Pool

```java
ExecutorService executor =
Executors.newFixedThreadPool(5);
```

Features

- Fixed number of threads
- Extra tasks wait in queue
- Most commonly used

Best for

- REST APIs
- Database operations
- Banking systems

---

## 2. Cached Thread Pool

```java
ExecutorService executor =
Executors.newCachedThreadPool();
```

Features

- Creates threads when needed
- Reuses idle threads
- No fixed limit

Best for

- Many short-lived tasks

**Note:** It can create a very large number of threads if tasks arrive faster than they complete.

---

## 3. Single Thread Executor

```java
ExecutorService executor =
Executors.newSingleThreadExecutor();
```

Only one thread.

Tasks execute in order.

```
Task1

↓

Task2

↓

Task3
```

Useful when execution order matters.

---

## 4. Scheduled Thread Pool

```java
ScheduledExecutorService scheduler =
Executors.newScheduledThreadPool(2);
```

Runs tasks

- after a delay
- periodically

Used for

- Notifications
- Health checks
- Cleanup jobs
- Scheduled reports

---

# Important Methods

## execute()

Executes a Runnable.

```java
executor.execute(task);
```

Returns

Nothing

---

## submit()

Executes Runnable or Callable.

Returns

Future

```java
Future<Integer> future =
executor.submit(() -> 100);
```

Retrieve result

```java
System.out.println(future.get());
```

---

## shutdown()

Gracefully stops the thread pool.

```java
executor.shutdown();
```

Already submitted tasks finish.

No new tasks are accepted.

---

## shutdownNow()

Immediately attempts to stop running tasks.

```java
executor.shutdownNow();
```

Not guaranteed to stop every task immediately.

---

# Thread Pool vs Creating Threads

| Thread Pool | Creating Threads |
|-------------|------------------|
| Reuses threads | Creates new thread every time |
| Faster | Slower |
| Better memory usage | High memory usage |
| Better scalability | Poor scalability |
| Used in production | Mostly for learning |

---

# Advantages

- Faster execution
- Better CPU utilization
- Lower memory usage
- Thread reuse
- Easy thread management
- Better scalability
- Reduces thread creation overhead

---

# Disadvantages

- Choosing the wrong pool size can reduce performance.
- Long-running tasks may block worker threads.
- Requires proper shutdown.
- Poor configuration can cause task delays.

---

# Production Usage

Thread Pools are everywhere in enterprise Java.

Examples:

- Spring Boot REST APIs
- Tomcat request handling
- Database operations
- Email services
- File processing
- Payment gateways
- Kafka consumers
- Background jobs
- Scheduled tasks
- Microservices

**Example:**

A Spring Boot server receives **5,000 HTTP requests**.

Instead of creating 5,000 threads,

Tomcat uses a configured thread pool (for example, 200 worker threads).

Each request is assigned to an available worker thread, processed, and then the thread is reused for the next request.

---

# Best Practices

✅ Prefer `ExecutorService` over manually creating threads.

✅ Choose the thread pool size based on your workload.

✅ Always call `shutdown()`.

✅ Handle exceptions inside tasks.

✅ Use `Callable` when you need a return value.

---

# Common Mistakes

❌ Creating a new thread for every request.

❌ Forgetting `shutdown()`.

❌ Using `newCachedThreadPool()` without understanding its behavior.

❌ Blocking worker threads with very long operations.

❌ Ignoring exceptions thrown by tasks.

---

# Interview Questions

### 1. What is a Thread Pool?

A Thread Pool is a collection of reusable worker threads used to execute multiple tasks efficiently.

---

### 2. Why is Thread Pool better than creating threads manually?

Because creating and destroying threads is expensive. Thread pools reuse existing threads, improving performance and reducing memory usage.

---

### 3. What is ExecutorService?

`ExecutorService` is a Java interface that manages thread pools, schedules tasks, and controls thread execution.

---

### 4. What happens when all threads are busy?

New tasks are placed into a **task queue** and wait until a worker thread becomes available.

---

### 5. Difference between execute() and submit()?

| execute() | submit() |
|------------|-----------|
| Returns nothing | Returns a `Future` |
| Runnable only | Runnable or Callable |
| No result | Can return a result |

---

### 6. Why should we call shutdown()?

To stop accepting new tasks and allow the JVM to terminate gracefully after all submitted tasks finish.

---

### 7. Which Thread Pool is most common?

`newFixedThreadPool()` is commonly used for predictable workloads. In enterprise applications, developers often configure a `ThreadPoolExecutor` directly for greater control.

---

### 8. Does Spring Boot use Thread Pools?

Yes.

Examples include:

- Tomcat request processing
- `@Async`
- `@Scheduled`
- Background task execution

---

### 9. Can one thread execute multiple tasks?

Yes.

After completing one task, the worker thread returns to the pool and executes another task.

---

### 10. What happens if we create thousands of threads?

It can lead to:

- High memory usage
- Excessive context switching
- Reduced performance
- Possible `OutOfMemoryError`

---

# Quick Revision

- Thread Pool = Collection of reusable worker threads.
- Managed using `ExecutorService`.
- Reuses threads instead of creating new ones.
- Tasks wait in a queue if all workers are busy.
- `execute()` → No return value.
- `submit()` → Returns a `Future`.
- Common types: Fixed, Cached, Single, Scheduled.
- Always call `shutdown()`.
- Used heavily in Spring Boot, Tomcat, and enterprise applications.
- Improves performance, scalability, and resource utilization.

---

# Keywords

- Thread Pool
- ExecutorService
- ThreadPoolExecutor
- Worker Thread
- Task Queue
- Runnable
- Callable
- Future
- execute()
- submit()
- shutdown()
- Fixed Thread Pool
- Cached Thread Pool
- Single Thread Executor
- Scheduled Thread Pool
- Concurrency
- Context Switching
- Reusable Threads
```