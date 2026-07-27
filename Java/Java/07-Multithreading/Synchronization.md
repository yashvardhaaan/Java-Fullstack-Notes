# Synchronization

---

# What is Synchronization?

**Synchronization** is a mechanism in Java that ensures **only one thread can access a shared resource at a time**.

It is used to make multithreaded programs **safe** and **consistent**.

**Definition:**

> Synchronization is the process of controlling multiple threads' access to shared resources to prevent data inconsistency.

---

# Why Do We Need Synchronization?

Suppose two threads are updating the same bank account.

Initial Balance:

```
₹1000
```

Thread A withdraws **₹500**

Thread B withdraws **₹300**

Without synchronization:

```
Thread A reads 1000

Thread B reads 1000

Thread A writes 500

Thread B writes 700
```

Final Balance

```
₹700 ❌
```

Correct Balance

```
₹200 ✅
```

Both threads read the same old value.

This problem is called a **Race Condition**.

---

# Real Life Example

Imagine a printer in an office.

```
Employee A

        Printer

Employee B
```

If both employees print at the same time,

the pages get mixed.

Synchronization acts like a queue.

```
Employee A
     ↓
   Printer
     ↓
Employee B
```

Only one employee uses the printer at a time.

---

# When Do We Need Synchronization?

Synchronization is needed whenever

- Multiple threads
- Access the same object
- At the same time
- And at least one thread modifies the data

Example

```
Shared Counter

Thread 1 → increment()

Thread 2 → increment()
```

---

# What is a Shared Resource?

A shared resource is any object or variable accessed by multiple threads.

Examples

- Counter
- Bank Account
- File
- Database Connection
- List
- Queue

---

# What is a Critical Section?

A **Critical Section** is the part of the program where shared data is accessed or modified.

Example

```java
balance = balance - amount;
```

Only one thread should execute this code at a time.

---

# What is a Race Condition?

A race condition occurs when two or more threads access and modify shared data simultaneously, leading to unpredictable results.

Example

```java
count++;
```

Looks like one statement,

but internally it is

```
Read count

Increase count

Write count
```

Suppose

```
count = 5
```

```
Thread A reads 5

Thread B reads 5

Thread A writes 6

Thread B writes 6
```

Expected

```
7
```

Actual

```
6
```

One update is lost.

---

# How Java Solves This Problem?

Java provides the

```
synchronized
```

keyword.

It allows only one thread to execute the protected code.

---

# Synchronized Method

```java
class Counter {

    private int count = 0;

    public synchronized void increment() {
        count++;
    }
}
```

When one thread enters

```
increment()
```

all other threads wait.

---

# Synchronized Block

Instead of locking the entire method,

lock only the required code.

```java
class Counter {

    private int count = 0;

    public void increment() {

        synchronized(this) {
            count++;
        }

    }
}
```

This improves performance because only the critical section is locked.

---

# How Synchronization Works?

Every Java object has a

```
Monitor Lock
```

Example

```
Object

      Monitor

Thread A ----> Lock

Thread B ----> Waiting

Thread C ----> Waiting
```

When Thread A finishes,

the monitor lock is released.

Then another thread gets access.

---

# Monitor Lock

Every Java object automatically contains one monitor.

```
Object

↓

Monitor

↓

Lock
```

The JVM manages this lock automatically.

You don't create it manually.

---

# Object Lock vs Class Lock

## Object Lock

```java
public synchronized void display()
```

Locks one object.

Different objects can execute simultaneously.

---

## Class Lock

```java
public static synchronized void display()
```

Locks the entire class.

Only one thread across all objects can execute.

---

# Advantages

✅ Prevents race conditions

✅ Ensures data consistency

✅ Makes code thread-safe

✅ Protects shared resources

---

# Disadvantages

❌ Threads may wait

❌ Performance decreases

❌ Wrong usage may cause deadlock

❌ Reduced parallelism

---

# Where is Synchronization Used?

- Banking applications
- Ticket booking
- Payment systems
- Inventory management
- Shared counters
- Logging
- File writing

---

# Spring Boot Example

Suppose only one movie seat is left.

```
User A

Book Seat

User B
```

Without synchronization

Both users may book the same seat.

With synchronization

```
User A

↓

Seat Booked

↓

User B

↓

Seat Already Reserved
```

---

# Is Synchronization Used Everywhere?

No.

Synchronization is used only when shared mutable data exists.

If data isn't shared,

no synchronization is required.

Too much synchronization reduces performance.

---

# Synchronization vs Thread Safety

Synchronization is **one way** to achieve thread safety.

Other ways include

- Atomic Classes
- ReentrantLock
- Concurrent Collections
- Immutable Objects

---

# Interview Questions

## 1. What is Synchronization?

Synchronization is a mechanism that allows only one thread to access shared resources at a time to prevent data inconsistency.

---

## 2. Why do we need Synchronization?

To prevent race conditions and ensure thread safety.

---

## 3. What is a Race Condition?

A race condition occurs when multiple threads modify shared data simultaneously, causing incorrect or unpredictable results.

---

## 4. What is a Critical Section?

The part of code where shared resources are accessed or modified.

---

## 5. What is the difference between synchronized method and synchronized block?

| Synchronized Method | Synchronized Block |
|---------------------|--------------------|
| Locks entire method | Locks only selected code |
| Easier to write | Better performance |
| Less flexible | More flexible |

---

## 6. What is a Monitor Lock?

A monitor lock is an internal lock associated with every Java object. The JVM uses it to ensure only one thread executes synchronized code for that object at a time.

---

## 7. Does synchronized improve performance?

No.

It improves correctness and thread safety.

Too much synchronization can reduce performance.

---

## 8. Can two synchronized methods run simultaneously?

- **Same object:** ❌ No
- **Different objects:** ✅ Yes
- **Static synchronized methods:** ❌ Only one thread for the entire class

---

## 9. Is synchronized enough for all multithreading problems?

No.

For high-performance applications, Java also provides:

- `ReentrantLock`
- `ReadWriteLock`
- `AtomicInteger`
- `ConcurrentHashMap`

---

## 10. Is synchronization used in Spring Boot?

Yes, but selectively.

Most concurrency is handled using thread-safe libraries, transactions, locks, and concurrent utilities rather than synchronizing every method.

---

# Quick Revision

- Synchronization = One thread at a time
- Protects shared resources
- Prevents race conditions
- Uses `synchronized`
- Every object has a monitor lock
- Method lock → Entire method
- Block lock → Specific code
- Object lock → One object
- Class lock → Entire class
- Improves correctness, not speed
- Used only when data is shared