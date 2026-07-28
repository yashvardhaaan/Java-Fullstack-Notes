# Thread Life Cycle (Java)

## What is Thread Life Cycle?

A **Thread Life Cycle** represents the different states a thread goes through from the moment it is created until it finishes execution.

Think of it like a person:

- Born → Created
- Waiting for work → Ready
- Working → Running
- Taking a break → Waiting
- Finished → Dead

A Java thread moves between these states based on CPU scheduling and synchronization.

---

# Why do we need Thread States?

The operating system and JVM need to know:

- Which thread is ready to run
- Which thread is currently executing
- Which thread is waiting for a resource
- Which thread has completed

This helps in efficient CPU scheduling.

---

# Thread Life Cycle Diagram

```text
                 new Thread()
                      │
                      ▼
                +------------+
                |    NEW     |
                +------------+
                      │
                  start()
                      │
                      ▼
                +------------+
                | RUNNABLE   |
                +------------+
                      │
          CPU Scheduler selects it
                      │
                      ▼
                +------------+
                |  RUNNING   |
                +------------+
                /     |      \
               /      |       \
sleep()   wait()   blocked
join()   notify()   lock
   │         │        │
   ▼         ▼        ▼
+---------------------------+
| WAITING / BLOCKED /       |
| TIMED_WAITING             |
+---------------------------+
              │
      Resource available
              │
              ▼
         RUNNABLE again
              │
              ▼
        run() finishes
              │
              ▼
        +-------------+
        | TERMINATED  |
        +-------------+
```

> **Note:** Java officially exposes the states `NEW`, `RUNNABLE`, `BLOCKED`, `WAITING`, `TIMED_WAITING`, and `TERMINATED`. Many books informally describe a separate "Running" state to explain execution, but internally Java groups ready-to-run and running under `RUNNABLE`.

---

# Java Thread States

## 1. NEW

A thread object is created, but `start()` has not been called.

```java
Thread t = new Thread();
```

Current State:

```
NEW
```

CPU does **not** execute it.

---

## 2. RUNNABLE

After calling `start()`, the thread enters the Runnable state.

```java
t.start();
```

This means:

- Thread is ready to execute.
- JVM waits for CPU scheduling.
- It may or may not be running right now.

Current State:

```
RUNNABLE
```

---

## 3. RUNNING (Conceptual)

Once the CPU scheduler picks the thread, it starts executing the `run()` method.

```java
public void run() {
    System.out.println("Running...");
}
```

While running, it may:

- Finish
- Sleep
- Wait
- Become blocked

> Although commonly used for teaching, "Running" is **not** a separate value in `Thread.State`.

---

## 4. BLOCKED

The thread wants a synchronized resource (monitor lock), but another thread already owns it.

Example:

```java
synchronized(lock) {
    // critical section
}
```

If another thread already has the lock:

```
BLOCKED
```

The thread waits until the lock is released.

---

## 5. WAITING

The thread waits indefinitely until another thread wakes it up.

Common methods:

- `wait()`
- `join()`

Example:

```java
thread.join();
```

The current thread waits until `thread` finishes.

---

## 6. TIMED_WAITING

The thread waits for a specified amount of time.

Examples:

```java
Thread.sleep(5000);
```

or

```java
thread.join(2000);
```

or

```java
wait(1000);
```

After the timeout:

```
TIMED_WAITING → RUNNABLE
```

---

## 7. TERMINATED (Dead)

The thread has completed execution.

Example:

```java
public void run() {
    System.out.println("Done");
}
```

After `run()` finishes:

```
TERMINATED
```

A terminated thread **cannot** be restarted.

```java
t.start();
t.start();   // Exception
```

Throws:

```
IllegalThreadStateException
```

---

# Complete Example

```java
class MyThread extends Thread {

    public void run() {
        System.out.println("Thread Running");
    }

    public static void main(String[] args) {

        MyThread t = new MyThread();

        System.out.println(t.getState());

        t.start();

        System.out.println(t.getState());
    }
}
```

Possible Output

```
NEW
RUNNABLE
Thread Running
```

---

# State Transition Summary

| Current State | Event | Next State |
|---------------|-------|------------|
| NEW | start() | RUNNABLE |
| RUNNABLE | CPU schedules thread | Running (conceptually) |
| Running | sleep() | TIMED_WAITING |
| Running | wait() | WAITING |
| Running | synchronized lock unavailable | BLOCKED |
| BLOCKED | Lock acquired | RUNNABLE |
| WAITING | notify()/join completes | RUNNABLE |
| TIMED_WAITING | Time expires | RUNNABLE |
| Running | run() finishes | TERMINATED |

---

# Real-World Example

Imagine waiting at a bank.

- **NEW** → You entered the bank.
- **RUNNABLE** → You have a token and are waiting.
- **RUNNING** → You're at the counter.
- **BLOCKED** → Another customer is using the counter you need.
- **WAITING** → Waiting for someone to sign your documents.
- **TIMED_WAITING** → Waiting for 10 minutes until your appointment.
- **TERMINATED** → Your work is done and you leave.

---

# Internal Working

1. You create a thread object.
2. `start()` asks the JVM to create a native OS thread.
3. The JVM registers the thread with the scheduler.
4. The OS scheduler decides when the thread gets CPU time.
5. The thread may move between runnable, blocked, and waiting states.
6. When `run()` completes, the JVM marks it as terminated and releases its resources.

---

# Production Usage

Thread states are common in:

- Spring Boot applications
- Web servers (Tomcat, Jetty)
- Banking systems
- Online shopping applications
- Database connection pools
- Background workers
- Scheduled tasks

Developers inspect thread states when diagnosing performance issues or deadlocks using thread dumps.

---

# Advantages of Understanding Thread States

- Easier debugging
- Better concurrency design
- Avoid deadlocks
- Improve performance
- Useful for interview questions
- Helps analyze thread dumps

---

# Common Mistakes

❌ Calling `run()` instead of `start()`.

❌ Calling `start()` twice on the same thread.

❌ Confusing `sleep()` with `wait()`.

❌ Assuming `RUNNABLE` always means the thread is actively executing.

❌ Forgetting that `BLOCKED` only occurs while waiting for a monitor lock.

---

# Interview Questions

### 1. What are the states of a Java thread?

**Answer:**
- NEW
- RUNNABLE
- BLOCKED
- WAITING
- TIMED_WAITING
- TERMINATED

---

### 2. What is the difference between NEW and RUNNABLE?

**NEW:** Thread object exists but `start()` hasn't been called.

**RUNNABLE:** `start()` has been called, and the thread is eligible to run.

---

### 3. Why isn't RUNNING part of `Thread.State`?

Java combines **ready** and **currently executing** threads into the `RUNNABLE` state. Whether a runnable thread is actually on the CPU is managed by the OS scheduler.

---

### 4. What moves a thread to BLOCKED?

Trying to enter a `synchronized` block when another thread already owns the monitor lock.

---

### 5. What is the difference between WAITING and TIMED_WAITING?

**WAITING:** Waits indefinitely until another thread wakes it.

**TIMED_WAITING:** Waits for a specified duration and becomes runnable after the timeout.

---

### 6. Can a terminated thread be restarted?

No. Calling `start()` again throws `IllegalThreadStateException`.

---

### 7. Does `sleep()` release the monitor lock?

No. `sleep()` pauses the thread but **does not release** any monitor lock it holds.

---

### 8. Does `wait()` release the monitor lock?

Yes. `wait()` releases the monitor lock and waits until notified.

---

# Quick Revision

- Thread life cycle = states from creation to completion.
- `start()` moves thread from **NEW → RUNNABLE**.
- CPU scheduler chooses when a runnable thread executes.
- `BLOCKED` = waiting for a synchronized monitor lock.
- `WAITING` = indefinite wait (`wait()`, `join()`).
- `TIMED_WAITING` = waiting with a timeout (`sleep()`, `join(timeout)`).
- `TERMINATED` = execution finished.
- A thread **cannot** be started twice.
- `sleep()` does **not** release locks.
- `wait()` **does** release the monitor lock.

---

# Keywords

- Thread
- JVM
- Thread Scheduler
- NEW
- RUNNABLE
- BLOCKED
- WAITING
- TIMED_WAITING
- TERMINATED
- start()
- run()
- sleep()
- wait()
- notify()
- notifyAll()
- join()
- synchronized
- Monitor Lock
- Thread.State