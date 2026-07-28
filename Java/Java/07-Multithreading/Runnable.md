# Runnable Interface (Java)

## What is Runnable?

`Runnable` is a **functional interface** in Java used to define the **task (work)** that a thread should execute.

It **does not create a thread** by itself. Instead, it provides the code that will run inside a thread.

```java
@FunctionalInterface
public interface Runnable {
    void run();
}
```

The interface contains only **one method**:

```java
void run();
```

---

# Why do we need Runnable?

Suppose you want multiple tasks to run simultaneously.

Examples:

- Downloading a file
- Playing music
- Sending emails
- Processing payments
- Reading data from a database

Instead of writing everything in one thread, we can place each task inside a `Runnable` and execute it using different threads.

---

# Real World Example

Imagine a **chef** in a restaurant.

- **Runnable** → The recipe (task to perform)
- **Thread** → The chef (who performs the task)

A recipe alone cannot cook food.

A chef needs the recipe to cook.

Similarly,

- Runnable = Work
- Thread = Executes the work

---

# How Runnable Works

```text
Create Runnable
        │
        ▼
Pass Runnable to Thread
        │
        ▼
Call start()
        │
        ▼
JVM creates a new thread
        │
        ▼
run() executes
```

---

# Creating a Runnable

```java
class MyTask implements Runnable {

    @Override
    public void run() {
        System.out.println("Task is running...");
    }
}
```

---

# Executing Runnable

```java
class MyTask implements Runnable {

    @Override
    public void run() {
        System.out.println("Task is running...");
    }

    public static void main(String[] args) {

        MyTask task = new MyTask();

        Thread thread = new Thread(task);

        thread.start();
    }
}
```

Output

```
Task is running...
```

---

# Using Lambda Expression

Since `Runnable` is a Functional Interface,

```java
Runnable task = () -> {
    System.out.println("Running...");
};

Thread t = new Thread(task);

t.start();
```

---

# Runnable vs Thread

| Runnable | Thread |
|-----------|---------|
| Interface | Class |
| Defines work | Executes work |
| Cannot run independently | Creates a new thread |
| Supports multiple inheritance | Cannot extend another class if already extending Thread |
| Preferred approach | Less preferred |

---

# Why Runnable is Preferred?

Instead of

```java
class MyThread extends Thread
```

Use

```java
class MyTask implements Runnable
```

Reasons:

- Better object-oriented design
- Can extend another class
- Reusable task
- Separation of task and execution
- Works well with thread pools and executors

---

# Internal Working

When you write

```java
Thread t = new Thread(task);
```

The thread stores the Runnable object.

When you call

```java
t.start();
```

The JVM creates a new native thread.

Eventually, that new thread executes:

```java
task.run();
```

**Important:**

Never call

```java
task.run();
```

directly if you want concurrency.

It behaves like a normal method call and runs on the current thread.

---

# start() vs run()

### Correct

```java
Thread t = new Thread(task);

t.start();
```

Creates a **new thread**.

---

### Wrong (for multithreading)

```java
task.run();
```

or

```java
t.run();
```

No new thread is created.

The method executes on the current thread.

---

# Runnable with Multiple Threads

```java
class Task implements Runnable {

    @Override
    public void run() {
        System.out.println(Thread.currentThread().getName());
    }

    public static void main(String[] args) {

        Task task = new Task();

        Thread t1 = new Thread(task);

        Thread t2 = new Thread(task);

        t1.start();

        t2.start();
    }
}
```

Possible Output

```
Thread-0
Thread-1
```

One Runnable object can be executed by multiple threads.

---

# Production Usage

Runnable is widely used in:

- Spring Boot applications
- Web servers
- Thread Pools
- Scheduled tasks
- Background jobs
- File processing
- API calls
- Email services
- Logging
- Payment systems

---

# Advantages

- Lightweight
- Reusable
- Supports multiple inheritance
- Cleaner design
- Easy to test
- Works with Executors
- Supports lambda expressions

---

# Disadvantages

- No return value
- Cannot throw checked exceptions directly
- For returning results, use `Callable`

---

# Runnable vs Callable

| Runnable | Callable |
|-----------|-----------|
| run() | call() |
| No return value | Returns a value |
| Cannot throw checked exceptions | Can throw checked exceptions |
| Introduced in Java 1.0 | Introduced in Java 5 |
| Used with Thread | Used with ExecutorService |

---

# Common Mistakes

❌ Calling `run()` instead of `start()`.

❌ Extending `Thread` when only defining a task.

❌ Assuming `Runnable` creates a thread.

❌ Sharing mutable data between threads without synchronization.

---

# Interview Questions

### 1. What is Runnable?

A functional interface that represents a task to be executed by a thread.

---

### 2. Does Runnable create a thread?

No.

It only defines the work.

A `Thread` executes the Runnable.

---

### 3. Why is Runnable preferred over extending Thread?

- Better design
- Supports multiple inheritance
- Task and execution are separated
- Easier to reuse
- Compatible with thread pools

---

### 4. Can one Runnable object be used by multiple threads?

Yes.

Multiple threads can execute the same Runnable object.

---

### 5. What happens if we call run() directly?

No new thread is created.

The code runs on the current thread like a normal method call.

---

### 6. Is Runnable a Functional Interface?

Yes.

It contains exactly one abstract method:

```java
void run();
```

---

### 7. Which is used more in production?

`Runnable` is generally preferred over extending `Thread`. In modern applications, you'll often use `Runnable` with `ExecutorService` or thread pools.

---

### 8. When should we use Callable instead?

When the task needs to:

- Return a result
- Throw checked exceptions

---

# Quick Revision

- `Runnable` is an interface.
- It represents a task, not a thread.
- It has one method: `run()`.
- Pass a Runnable to a `Thread` and call `start()`.
- `run()` alone does not create a new thread.
- Preferred over extending `Thread`.
- Supports lambda expressions.
- Reusable across multiple threads.
- Commonly used with thread pools (`ExecutorService`).

---

# Keywords

- Runnable
- Functional Interface
- run()
- Thread
- start()
- Lambda Expression
- Multithreading
- ExecutorService
- Thread Pool
- Task
- Concurrency
```