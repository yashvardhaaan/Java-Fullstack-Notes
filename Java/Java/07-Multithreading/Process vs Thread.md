# Process vs Thread

---

# What is a Process?

A **process** is a program that is currently running.

When you open an application, the operating system creates a process for it.

Examples:
- Opening Chrome creates a Chrome process.
- Opening VS Code creates a VS Code process.
- Running a Spring Boot application creates a Java process.

Think of a process as a **complete house**.

The house has:
- Its own rooms
- Electricity
- Water supply
- Furniture

Everything belongs only to that house.

Similarly, a process has its own:
- Memory
- Resources
- Files
- Security
- Address space

---

# Real World Example

Imagine you are using your laptop.

You open

- Chrome
- Spotify
- VS Code
- Discord

Each application becomes a separate process.

```
Operating System

├── Chrome Process
├── VS Code Process
├── Spotify Process
└── Discord Process
```

Each process has its own memory.

If Chrome crashes,

VS Code continues working.

Because every process is isolated.

---

# Process Memory Layout

Every process gets its own memory.

```
+----------------------+
| Code Segment         |
+----------------------+
| Global Variables     |
+----------------------+
| Heap                 |
+----------------------+
| Stack                |
+----------------------+
```

No other process can directly access this memory.

---

# Characteristics of Process

- Independent execution
- Own memory
- Own resources
- Heavyweight
- Communication is slower
- Crash doesn't affect other processes

---

# What is a Thread?

A thread is the **smallest unit of execution** inside a process.

One process can contain multiple threads.

Think of a thread as a worker inside a company.

Company = Process

Workers = Threads

```
Java Process

        |
        |
+----------------------+
|      Process         |
|                      |
| Thread 1             |
| Thread 2             |
| Thread 3             |
+----------------------+
```

All workers work inside the same company.

---

# Thread Shares Memory

Threads share

- Heap
- Variables
- Objects
- Files

Each thread has its own

- Stack
- Program Counter
- Registers

```
                Process

      Shared Heap Memory

      Object A
      Object B
      Object C

        /      |      \

   Thread1 Thread2 Thread3

Each thread has

Stack
Program Counter
Registers
```

---

# Why Do We Need Threads?

Suppose Chrome had only one thread.

You click

- Open YouTube
- Download a file
- Play music

Everything would happen one after another.

The browser would freeze.

Instead Chrome creates many threads.

One thread

Loads webpage

Another thread

Downloads files

Another thread

Runs JavaScript

Another thread

Handles UI

Everything happens simultaneously.

---

# Spring Boot Example

Suppose 100 users call your API.

```
GET /users
```

The server creates multiple threads.

```
Java Process

Thread 1 -> User 1

Thread 2 -> User 2

Thread 3 -> User 3

...

Thread 100 -> User 100
```

All these threads share

- Database Connection Pool
- Objects
- Heap Memory

This is why Spring Boot can serve many users concurrently.

---

# Process vs Thread

| Process | Thread |
|----------|---------|
| Heavyweight | Lightweight |
| Own memory | Shared memory |
| Slower creation | Faster creation |
| Communication slower | Communication faster |
| Context switch expensive | Context switch cheaper |
| Independent | Dependent on process |
| Crash usually isolated | Bug can affect whole process |

---

# Context Switching

CPU executes only one thread on one CPU core at a time.

Example

```
CPU

Thread A

↓

Thread B

↓

Thread C

↓

Thread A
```

Switching from one execution context to another is called

**Context Switching**

Process switching is expensive.

Thread switching is cheaper.

---

# Why Process Switching is Slow?

Operating system has to switch

- Memory mapping
- Address space
- Registers
- Security information
- Cache

Lots of work.

---

# Why Thread Switching is Fast?

Threads already share

- Memory
- Heap
- Open files

Only

- Registers
- Stack
- Program Counter

need switching.

Hence it is much faster.

---

# Process Communication

Processes don't share memory.

They communicate using IPC.

Examples

- Pipes
- Shared Memory
- Message Queue
- Socket
- Semaphore

---

# Thread Communication

Threads communicate simply by sharing variables.

Example

```java
int counter = 0;

Thread A
counter++;

Thread B
System.out.println(counter);
```

Since memory is shared, synchronization is needed.

---

# Advantages of Process

✔ Better security

✔ Isolation

✔ Independent execution

✔ Stable

---

# Advantages of Thread

✔ Fast

✔ Lightweight

✔ Better CPU utilization

✔ Shared resources

✔ High performance

---

# Disadvantages of Process

- Heavy
- Slow
- High memory usage

---

# Disadvantages of Thread

- Synchronization problems
- Race conditions
- Deadlocks
- Hard debugging

---

# Real Production Example

Spring Boot application

One Java process starts.

```
java -jar app.jar
```

Inside that process,

Tomcat creates a thread pool.

```
Java Process

|

Tomcat

|

Thread Pool

|

Request Threads
```

Incoming HTTP requests are handled by threads.

The process remains one.

Threads keep changing.

---

# Interview Questions

## 1. What is a process?

A process is a running program with its own memory, resources, and execution context.

---

## 2. What is a thread?

A thread is the smallest unit of execution inside a process.

---

## 3. Difference between process and thread?

A process has its own memory and resources, while threads share the process's memory but have separate stacks and execution contexts.

---

## 4. Why are threads faster than processes?

Threads share the same address space, so switching between them requires saving and restoring less state than switching between processes.

---

## 5. Can one process have multiple threads?

Yes.

Example:

Chrome

Spring Boot

VS Code

All use many threads.

---

## 6. Can two processes share memory?

Not directly.

They require IPC mechanisms like shared memory, pipes, sockets, or message queues.

---

## 7. Why does Spring Boot use threads instead of processes?

Creating a new process for every HTTP request would be slow and memory-intensive.

Using threads inside one JVM process is much faster and allows efficient sharing of application resources.

---

## 8. Does every Java application create a process?

Yes.

Running

```bash
java Main
```

creates one JVM process.

Inside that process, multiple threads may run.

---

## 9. What is the main thread?

The JVM automatically creates a **main thread** to execute the `main()` method.

Other threads can be created from it.

---

## 10. What is context switching?

Context switching is the process of saving the state of one process or thread and loading the state of another so the CPU can switch execution.

---

# One-Line Revision

- Process = Running program
- Thread = Smallest execution unit
- Process owns memory
- Threads share process memory
- Process = Heavyweight
- Thread = Lightweight
- Process communication = IPC
- Thread communication = Shared memory
- Process switching = Expensive
- Thread switching = Cheap
- One process can have many threads
- Spring Boot = One JVM process + Thread Pool