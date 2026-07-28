# Fork/Join Framework (Java)

## What is the Fork/Join Framework?

The **Fork/Join Framework** is a Java framework used to **divide a large task into smaller subtasks, execute them in parallel, and then combine the results**.

It was introduced in **Java 7** under the package:

```java
java.util.concurrent
```

> **Definition:** The Fork/Join Framework is a parallel execution framework that uses multiple CPU cores to process recursive tasks efficiently.

---

# Why Do We Need Fork/Join?

Suppose you want to calculate the sum of **10 million numbers**.

Without Fork/Join:

```
One Thread

↓

Processes 10 Million Numbers
```

Slow because only one CPU core is used.

With Fork/Join:

```
10 Million Numbers

↓

Split into Smaller Parts

↓

Core1   Core2   Core3   Core4

↓

Combine Results
```

All CPU cores work together, making execution much faster for CPU-intensive tasks.

---

# Real-World Example

Imagine counting books in a huge library.

Without Fork/Join:

- One person counts every book.

With Fork/Join:

- Divide the library into sections.
- Four people count different sections simultaneously.
- Add all counts together.

```
Library

↓

Split into Sections

↓

Person1 Person2 Person3 Person4

↓

Total Books
```

This is exactly how Fork/Join works.

---

# How Fork/Join Works

```text
Large Task

↓

Fork (Split)

↓

Task1   Task2

↓

Fork Again

↓

Small Tasks

↓

Execute in Parallel

↓

Join (Combine Results)

↓

Final Result
```

---

# What Does "Fork" Mean?

**Fork** means:

> Divide a large task into smaller subtasks.

Example:

```
Array

1 2 3 4 5 6 7 8

↓

Split

1 2 3 4

5 6 7 8
```

---

# What Does "Join" Mean?

**Join** means:

> Combine the results of all completed subtasks.

Example:

```
Task1 Result = 10

Task2 Result = 26

↓

Join

↓

36
```

---

# Main Components

## 1. ForkJoinPool

The thread pool that manages worker threads.

```java
ForkJoinPool pool =
        new ForkJoinPool();
```

---

## 2. ForkJoinTask

Base class for all Fork/Join tasks.

Two important subclasses:

- RecursiveTask
- RecursiveAction

---

## 3. RecursiveTask

Used when the task **returns a result**.

Example:

```java
class SumTask extends RecursiveTask<Integer>
```

---

## 4. RecursiveAction

Used when the task **does not return a result**.

Example:

```java
class PrintTask extends RecursiveAction
```

---

# RecursiveTask Example

```java
import java.util.concurrent.*;

class SumTask extends RecursiveTask<Integer> {

    int start;
    int end;

    SumTask(int start, int end) {
        this.start = start;
        this.end = end;
    }

    @Override
    protected Integer compute() {

        if (end - start <= 5) {

            int sum = 0;

            for (int i = start; i <= end; i++)
                sum += i;

            return sum;
        }

        int mid = (start + end) / 2;

        SumTask left =
                new SumTask(start, mid);

        SumTask right =
                new SumTask(mid + 1, end);

        left.fork();

        int rightResult = right.compute();

        int leftResult = left.join();

        return leftResult + rightResult;
    }

}
```

---

# Running the Task

```java
public class Main {

    public static void main(String[] args) {

        ForkJoinPool pool =
                new ForkJoinPool();

        SumTask task =
                new SumTask(1, 20);

        int result =
                pool.invoke(task);

        System.out.println(result);

    }

}
```

Output

```text
210
```

---

# Why `left.fork()`, `right.compute()`, `left.join()`?

This is the recommended pattern.

```java
left.fork();

int rightResult = right.compute();

int leftResult = left.join();
```

Why?

- `left.fork()` schedules the left task for another worker.
- The current thread immediately computes the right task instead of waiting.
- `left.join()` waits only if the left task hasn't finished yet.

This reduces idle time and improves CPU utilization.

---

# Work-Stealing Algorithm

The Fork/Join Framework uses a **Work-Stealing Algorithm**.

Example:

```
Worker1

Task A

Task B

Task C
```

Worker2 finishes early.

Instead of staying idle,

it steals work from Worker1.

```
Worker1

Task A

Task B

↓

Worker2

Steals Task C
```

This keeps all CPU cores busy.

---

# Internal Working

```
ForkJoinPool

↓

Worker Threads

↓

Each Thread Has Its Own Queue

↓

If Queue Empty

↓

Steal Task From Another Queue

↓

Execute

↓

Join Results
```

This automatic balancing is one of the biggest advantages of the framework.

---

# RecursiveAction Example

```java
class PrintTask extends RecursiveAction {

    @Override
    protected void compute() {
        System.out.println("Hello");
    }

}
```

No value is returned.

---

# RecursiveTask vs RecursiveAction

| RecursiveTask | RecursiveAction |
|---------------|-----------------|
| Returns a result | No return value |
| Extends `RecursiveTask<V>` | Extends `RecursiveAction` |
| Used for calculations | Used for operations like printing or updating data |

---

# Fork/Join vs Thread Pool

| Thread Pool | Fork/Join Pool |
|--------------|----------------|
| Executes independent tasks | Splits one large task into smaller tasks |
| General-purpose | Optimized for recursive parallel algorithms |
| No work stealing | Uses work stealing |
| Good for web requests | Good for CPU-intensive calculations |

---

# When Should We Use Fork/Join?

Use it for:

- Large array processing
- Merge Sort
- Quick Sort
- Matrix multiplication
- Searching large datasets
- Image processing
- Scientific calculations
- Parallel algorithms

---

# When Should We NOT Use Fork/Join?

Avoid it for:

- Database operations
- REST API calls
- File I/O
- Network communication
- Blocking operations

These are **I/O-bound** tasks. Use thread pools or virtual threads instead.

---

# Production Usage

Fork/Join is used in:

- Java Parallel Streams
- Parallel sorting
- Big data processing
- Image rendering
- Scientific computing
- Machine learning preprocessing
- Financial calculations

Example:

```java
list.parallelStream()
```

Internally,

Java commonly uses the **ForkJoinPool.commonPool()** to execute parallel stream operations.

---

# Advantages

- Utilizes multiple CPU cores
- Faster for CPU-intensive work
- Automatic work stealing
- Good load balancing
- Easy recursive task decomposition
- High performance

---

# Disadvantages

- Not suitable for blocking tasks
- Recursive splitting adds overhead for small tasks
- More complex than regular thread pools
- Performance depends on choosing an appropriate task size

---

# Best Practices

✅ Split tasks until they are small enough to process efficiently.

✅ Use `RecursiveTask` when returning results.

✅ Use `RecursiveAction` for tasks without return values.

✅ Keep tasks CPU-intensive.

✅ Avoid blocking operations inside `compute()`.

---

# Common Mistakes

❌ Creating very small tasks (too much overhead).

❌ Using Fork/Join for database or network calls.

❌ Forgetting to define a stopping condition in recursive tasks.

❌ Assuming Fork/Join is always faster than a normal loop.

---

# Interview Questions

### 1. What is the Fork/Join Framework?

A framework for dividing a large task into smaller subtasks, executing them in parallel, and combining the results.

---

### 2. What do "Fork" and "Join" mean?

- **Fork:** Split a large task into smaller tasks.
- **Join:** Combine the results of completed subtasks.

---

### 3. What is `ForkJoinPool`?

A specialized thread pool that manages worker threads for Fork/Join tasks.

---

### 4. What is the difference between `RecursiveTask` and `RecursiveAction`?

`RecursiveTask` returns a result, while `RecursiveAction` does not.

---

### 5. What is Work Stealing?

If one worker thread finishes early, it steals tasks from another worker's queue to improve CPU utilization.

---

### 6. Why is Fork/Join faster?

It executes subtasks in parallel across multiple CPU cores and balances work automatically using work stealing.

---

### 7. Is Fork/Join good for database calls?

No.

It is designed for **CPU-bound** work, not blocking I/O operations.

---

### 8. Does Java Parallel Stream use Fork/Join?

Yes.

Parallel streams generally use the `ForkJoinPool.commonPool()` by default.

---

### 9. What is the recommended pattern inside `compute()`?

```java
left.fork();
int rightResult = right.compute();
int leftResult = left.join();
return leftResult + rightResult;
```

This maximizes parallelism while minimizing waiting.

---

### 10. What is the difference between Fork/Join and ExecutorService?

`ExecutorService` runs independent tasks, while Fork/Join is optimized for recursively splitting one large task into smaller parallel tasks.

---

# Quick Revision

- Fork/Join introduced in Java 7.
- Used for CPU-intensive parallel tasks.
- Fork = Split task.
- Join = Combine results.
- `ForkJoinPool` manages worker threads.
- `RecursiveTask` returns a value.
- `RecursiveAction` returns nothing.
- Uses a **Work-Stealing Algorithm**.
- Not suitable for blocking I/O.
- Used internally by Java Parallel Streams.

---

# Keywords

- Fork/Join Framework
- ForkJoinPool
- ForkJoinTask
- RecursiveTask
- RecursiveAction
- Work Stealing
- Parallel Processing
- CPU-bound
- Parallel Stream
- Fork
- Join
- Concurrency
- Multithreading
- Java 7
- Work Queue