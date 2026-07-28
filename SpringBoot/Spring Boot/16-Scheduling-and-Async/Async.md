# @Async (Asynchronous Processing)

## What is Asynchronous Processing?

**Asynchronous Processing** means executing a task **in the background** without making the caller wait for it to finish.

The application continues doing other work while the background task is executed by another thread.

> **In simple words:**
>
> Asynchronous programming allows your application to start a task and continue working instead of waiting for that task to complete.

---

# Why Do We Need Asynchronous Processing?

Imagine a user registers on an e-commerce website.

Tasks to perform:

- Save User
- Send Welcome Email
- Send SMS
- Generate Report

Without Async

```
Client

↓

Register User

↓

Save User

↓

Send Email

↓

Send SMS

↓

Generate Report

↓

Response
```

Problems

- Slow response
- User waits longer
- Poor user experience

---

With Async

```
Client

↓

Register User

↓

Save User

↓

Response Sent

↓

Background Thread

├── Send Email

├── Send SMS

└── Generate Report
```

The user receives the response immediately while background tasks continue.

---

# Real-World Example

Imagine ordering food.

```
Customer

↓

Place Order

↓

Kitchen Starts Cooking

↓

Customer Waits
```

Instead of standing in the kitchen,

you receive an order confirmation immediately.

The food is prepared in the background.

Async works the same way.

---

# Synchronous vs Asynchronous

## Synchronous

```
Task 1

↓

Wait

↓

Task 2

↓

Wait

↓

Task 3
```

Each task waits for the previous one.

---

## Asynchronous

```
Task 1

↓

Background Thread

↓

Task 2 Starts Immediately

↓

Task 3 Starts Immediately
```

Multiple tasks can run independently.

---

# Spring Boot Async Architecture

```
Client

↓

Controller

↓

Service

↓

@Async Method

↓

Thread Pool

↓

Background Execution
```

---

# How @Async Works

```
Method Called

↓

Spring Creates Another Thread

↓

Method Executes

↓

Caller Continues Immediately
```

---

# Enable Async Support

To use asynchronous methods,

enable async processing.

```java
@SpringBootApplication

@EnableAsync
public class Application {

}
```

`@EnableAsync` tells Spring to look for methods annotated with `@Async`.

---

# @Async Annotation

Example

```java
@Service
public class EmailService {

    @Async
    public void sendEmail(

            String email

    ){

        System.out.println(

                "Sending Email..."

        );

    }

}
```

Flow

```
Controller

↓

Email Service

↓

@Async

↓

Background Thread
```

---

# Calling an Async Method

```java
@Service
public class UserService {

    @Autowired
    private EmailService emailService;

    public void register(){

        // Save User

        emailService.sendEmail(

                "user@example.com"

        );

        System.out.println(

                "Registration Completed"

        );

    }

}
```

Output

```
Registration Completed

Sending Email...
```

The registration finishes immediately while the email is sent in the background.

---

# Thread Pool

Spring usually executes async methods using a **Thread Pool**.

```
Task 1

↓

Thread 1

Task 2

↓

Thread 2

Task 3

↓

Thread 3
```

Instead of creating a new thread every time,

Spring reuses existing threads.

---

# Why Thread Pool?

Without Thread Pool

```
Every Request

↓

Create New Thread

↓

High Memory Usage
```

With Thread Pool

```
Thread Pool

↓

Reuse Existing Threads

↓

Better Performance
```

---

# Async Request Flow

```
Client

↓

Controller

↓

Service

↓

@Async

↓

Thread Pool

↓

Background Task
```

---

# Return Type of @Async

## 1. void

```java
@Async
public void process(){

}
```

Used when no result is required.

---

## 2. CompletableFuture

```java
@Async
public CompletableFuture<String> process(){

    return CompletableFuture.completedFuture(

            "Completed"

    );

}
```

Used when a result is needed later.

---

# Common Use Cases

- Sending Emails
- Sending SMS
- Push Notifications
- Report Generation
- File Processing
- Image Processing
- Payment Notifications
- Background Logging

---

# Async vs Multithreading

| Async | Multithreading |
|--------|----------------|
| High-level Spring feature | Core Java concept |
| Uses `@Async` | Uses `Thread`, `ExecutorService`, etc. |
| Easier to implement | Requires manual thread management |
| Managed by Spring | Managed by developer |

---

# Async vs Scheduling

| Async | Scheduling |
|--------|------------|
| Runs when a method is called | Runs automatically at a scheduled time |
| Triggered by application logic | Triggered by a timer or cron expression |
| Executes immediately in the background | Executes at a future or recurring time |

---

# Common Mistakes

❌ Forgetting `@EnableAsync`.

❌ Calling an `@Async` method from another method in the same class (self-invocation), which bypasses Spring's proxy.

❌ Running long-running tasks without a properly configured thread pool.

❌ Ignoring exceptions thrown by asynchronous methods.

❌ Creating too many background tasks without monitoring resources.

---

# Real-World Example

## Banking Application

```
Money Transferred

↓

Response Sent

↓

Background

↓

Send SMS

↓

Send Email
```

---

## E-Commerce Website

```
Order Placed

↓

Response Sent

↓

Background

├── Invoice

├── Email

└── Loyalty Points
```

---

## Food Delivery App

```
Order Delivered

↓

Background

├── Rating Request

├── Notification

└── Analytics Update
```

---

# Advantages

- Faster response time.
- Better user experience.
- Efficient resource utilization.
- Suitable for long-running tasks.
- Easy integration with Spring Boot.
- Improves application responsiveness.

---

# Best Practices

- Use `@EnableAsync` to enable asynchronous execution.
- Use a properly configured thread pool in production.
- Keep async methods independent.
- Handle exceptions carefully.
- Use `CompletableFuture` when results are required.
- Avoid blocking operations inside async methods whenever possible.

---

# Interview Questions

### 1. What is asynchronous processing?

Asynchronous processing executes tasks in the background without blocking the caller.

---

### 2. What does `@Async` do?

`@Async` tells Spring to execute the annotated method in a separate thread.

---

### 3. What annotation enables asynchronous processing?

```java
@EnableAsync
```

---

### 4. Can an `@Async` method return a value?

Yes.

It can return `CompletableFuture`, `Future`, or `void`.

---

### 5. Why does Spring use a thread pool for async methods?

A thread pool reuses existing threads, reducing the overhead of creating new threads for every request.

---

### 6. Can `@Async` be called from another method in the same class?

No.

Self-invocation bypasses Spring's proxy, so the method executes synchronously.

---

### 7. What are common use cases for `@Async`?

Sending emails, notifications, report generation, file processing, logging, and other background tasks.

---

# Quick Revision

- Asynchronous processing runs tasks in the background.
- Spring Boot provides async support using `@Async`.
- Enable async using `@EnableAsync`.
- Async methods usually execute using a thread pool.
- `void` is used when no result is needed.
- `CompletableFuture` is used when a result is required later.
- Async improves application responsiveness and user experience.
- Common uses include emails, notifications, and background processing.