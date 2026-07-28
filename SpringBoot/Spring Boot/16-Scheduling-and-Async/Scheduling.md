# Scheduling

## What is Scheduling?

**Scheduling** is the process of executing a task **automatically at a specific time or at regular intervals** without manual intervention.

Spring Boot provides scheduling support using the `@Scheduled` annotation.

It is commonly used for:

- Database Backups
- Sending Emails
- Cleaning Logs
- Refreshing Cache
- Generating Reports

> **In simple words:**
>
> Scheduling allows your application to automatically execute tasks at predefined times or intervals.

---

# Why Do We Need Scheduling?

Imagine a Banking Application.

Every day, the system must:

- Generate transaction reports
- Backup the database
- Delete temporary files
- Send daily account summaries

Without Scheduling

```
Administrator

↓

Run Tasks Manually

↓

Task Completed
```

Problems

- Human errors
- Time consuming
- Easy to forget

---

With Scheduling

```
Server

↓

Scheduled Time

↓

Task Executes Automatically
```

Everything runs automatically.

---

# Real-World Example

Imagine a school bell.

```
Time Reached

↓

Bell Rings

↓

Students Change Class
```

Nobody manually rings the bell every period.

Scheduling works the same way.

---

# Spring Boot Scheduling Architecture

```
Application Starts

↓

Scheduler

↓

Check Time

↓

Task Scheduled?

↓

Yes

↓

Execute Method
```

---

# Enable Scheduling

Before using scheduling,

enable it in your application.

```java
@SpringBootApplication

@EnableScheduling
public class Application {

}
```

This tells Spring Boot to activate scheduled tasks.

---

# @Scheduled Annotation

```java
@Component
public class ReportService {

    @Scheduled(

            fixedRate = 5000

    )
    public void generateReport(){

        System.out.println(

                "Generating Report"

        );

    }

}
```

This method executes every **5 seconds**.

---

# Scheduling Flow

```
Application

↓

@EnableScheduling

↓

Scheduler

↓

@Scheduled Method

↓

Execute Task
```

---

# fixedRate

Runs a task at a **fixed interval**, regardless of how long the previous execution took.

```java
@Scheduled(

        fixedRate = 5000

)
public void task(){

}
```

Flow

```
Start

↓

5 Seconds

↓

Run Again

↓

5 Seconds

↓

Run Again
```

---

# fixedDelay

Runs a task **after the previous execution finishes**.

```java
@Scheduled(

        fixedDelay = 5000

)
public void task(){

}
```

Flow

```
Task Starts

↓

Task Completes

↓

Wait 5 Seconds

↓

Run Again
```

---

# initialDelay

Delays the **first execution** of the task.

```java
@Scheduled(

        initialDelay = 10000,

        fixedRate = 5000

)
public void task(){

}
```

Flow

```
Application Starts

↓

Wait 10 Seconds

↓

First Execution

↓

Every 5 Seconds
```

---

# Cron Scheduling

Run tasks at specific calendar times.

```java
@Scheduled(

        cron = "0 0 9 * * ?"

)
public void sendReport(){

}
```

Runs every day at **9:00 AM**.

---

# Complete Scheduling Flow

```
Application Starts

↓

@EnableScheduling

↓

Scheduler

↓

Current Time

↓

Matches Schedule?

↓

Yes

↓

Execute Method
```

---

# Types of Scheduling

| Type | Description |
|------|-------------|
| `fixedRate` | Runs at fixed intervals |
| `fixedDelay` | Runs after previous execution completes |
| `cron` | Runs at specific calendar times |
| `initialDelay` | Delays the first execution |

---

# fixedRate vs fixedDelay

| fixedRate | fixedDelay |
|------------|------------|
| Runs every fixed interval | Waits after previous execution |
| Can overlap if tasks take longer | No overlap for a single-thread scheduler |
| Best for periodic updates | Best for long-running tasks |

---

# Cron vs fixedRate

| Cron | fixedRate |
|-------|-----------|
| Time-based | Interval-based |
| Runs at specific times | Runs every fixed duration |
| Example: 9 AM daily | Example: Every 10 seconds |

---

# Scheduling Thread

By default,

Spring Boot uses a scheduler thread to execute scheduled tasks.

```
Scheduler Thread

↓

Execute Scheduled Task

↓

Wait

↓

Execute Again
```

For multiple scheduled tasks,

a custom thread pool can be configured.

---

# Common Use Cases

- Database Backup
- Email Notifications
- SMS Reminders
- Log Cleanup
- Cache Refresh
- Report Generation
- Session Cleanup
- Data Synchronization

---

# Common Mistakes

❌ Forgetting `@EnableScheduling`.

❌ Running heavy tasks too frequently.

❌ Using `fixedRate` when `fixedDelay` is more appropriate.

❌ Ignoring time zones for cron jobs.

❌ Not handling exceptions inside scheduled methods.

---

# Real-World Example

## Banking Application

```
Every Midnight

↓

Backup Database

↓

Generate Daily Report
```

---

## E-Commerce Website

```
Every Hour

↓

Refresh Product Cache

↓

Remove Expired Coupons
```

---

## Food Delivery App

```
Every Night

↓

Delete Old Notifications

↓

Generate Sales Report
```

---

# Advantages

- Automates repetitive tasks.
- Reduces manual work.
- Improves reliability.
- Easy to configure.
- Built into Spring Boot.
- Supports interval-based and calendar-based scheduling.

---

# Best Practices

- Enable scheduling using `@EnableScheduling`.
- Keep scheduled tasks short and efficient.
- Use `fixedDelay` for long-running tasks.
- Use Cron for calendar-based schedules.
- Handle exceptions properly.
- Configure a custom scheduler for multiple concurrent tasks.
- Monitor scheduled jobs in production.

---

# Interview Questions

### 1. What is Scheduling?

Scheduling is the automatic execution of tasks at predefined times or intervals.

---

### 2. Which annotation enables scheduling?

```java
@EnableScheduling
```

---

### 3. Which annotation is used to schedule a method?

```java
@Scheduled
```

---

### 4. What is the difference between `fixedRate` and `fixedDelay`?

- `fixedRate` runs tasks at fixed intervals.
- `fixedDelay` waits until the previous execution finishes before starting the delay.

---

### 5. When should Cron scheduling be used?

Cron scheduling should be used when tasks need to run at specific dates or times, such as every day at 9:00 AM or every Sunday at midnight.

---

### 6. What does `initialDelay` do?

It delays the first execution of a scheduled task after the application starts.

---

### 7. What are common real-world uses of scheduling?

Database backups, email notifications, cache refresh, log cleanup, report generation, and session cleanup.

---

# Quick Revision

- Scheduling executes tasks automatically.
- Enable scheduling using `@EnableScheduling`.
- Use `@Scheduled` to schedule methods.
- `fixedRate` runs at fixed intervals.
- `fixedDelay` waits after the previous execution finishes.
- `initialDelay` postpones the first execution.
- `cron` schedules tasks at specific calendar times.
- Scheduling is commonly used for backups, reports, cache refresh, and automated maintenance tasks.