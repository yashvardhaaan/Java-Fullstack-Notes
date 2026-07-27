# Thread Creation

---

# What is Thread Creation?

Thread creation means creating a new path of execution inside a process so that multiple tasks can run concurrently.

Every Java application starts with one thread called the **main thread**.

```
JVM Process
     |
 Main Thread
```

---

# Ways to Create a Thread

There are two traditional ways and one modern way.

1. Extend `Thread` class
2. Implement `Runnable` interface ✅ (Most Common)
3. Use `ExecutorService` (Production)

---

# 1. Extending Thread Class

```java
class MyThread extends Thread {
    @Override
    public void run() {
        System.out.println("Thread is running");
    }
}

public class Main {
    public static void main(String[] args) {
        MyThread t = new MyThread();
        t.start();
    }
}
```

### Pros

- Simple
- Easy to understand

### Cons

- Cannot extend another class
- Rarely used in real projects

---

# 2. Implementing Runnable (Recommended)

```java
class MyTask implements Runnable {

    @Override
    public void run() {
        System.out.println("Task is running");
    }
}

public class Main {

    public static void main(String[] args) {

        Thread t = new Thread(new MyTask());

        t.start();
    }
}
```

### Why use Runnable?

- Supports multiple inheritance
- Better code separation
- Reusable task
- Preferred in interviews

---

# 3. Lambda Expression (Java 8+)

```java
Thread t = new Thread(() -> {
    System.out.println("Running...");
});

t.start();
```

Short and clean.

---

# 4. ExecutorService (Production)

Instead of creating threads manually, companies use a **Thread Pool**.

```java
ExecutorService executor =
        Executors.newFixedThreadPool(5);

executor.execute(() -> {
    System.out.println("Task running");
});

executor.shutdown();
```

### Why?

- Reuses threads
- Better performance
- Controls thread creation
- Prevents creating thousands of threads

---

# start() vs run()

```java
t.start();
```

Creates a **new thread**.

```java
t.run();
```

Runs like a normal method on the current thread.

Always use **start()**.

---

# Thread Lifecycle (Overview)

```
New
 ↓
Runnable
 ↓
Running
 ↓
Blocked / Waiting
 ↓
Terminated
```

---

# Which Method is Used Where?

| Method | Used In |
|---------|----------|
| Thread Class | Learning |
| Runnable | Interviews |
| ExecutorService | Production |
| Virtual Threads | Modern Java (Java 21+) |

---

# Interview Questions

### 1. How many ways can you create a thread?

- Extend `Thread`
- Implement `Runnable`
- Use `ExecutorService` (preferred in production)

---

### 2. Which approach is preferred?

Implementing **Runnable** or using **ExecutorService**.

---

### 3. Why not extend Thread?

Java doesn't support multiple class inheritance, so extending `Thread` limits flexibility.

---

### 4. What is the difference between `start()` and `run()`?

- `start()` creates a new thread.
- `run()` executes on the current thread like a normal method.

---

### 5. Why do companies use ExecutorService?

To reuse threads through a thread pool, improving performance and avoiding the overhead of creating a new thread for every task.

---

# Revision

- Thread = Unit of execution
- `start()` → New thread
- `run()` → Normal method
- `Runnable` > `Thread`
- `ExecutorService` → Production
- Thread Pool → Reuses threads