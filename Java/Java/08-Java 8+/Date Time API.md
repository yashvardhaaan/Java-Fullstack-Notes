# Date & Time API (Java 8)

## What is the Date & Time API?

The **Date & Time API** is a modern date and time library introduced in **Java 8** under the **java.time** package.

It replaces the old classes like:

- `Date`
- `Calendar`
- `SimpleDateFormat`

which were difficult to use, mutable, and not thread-safe.

> **Definition:** The Java Date & Time API provides immutable, thread-safe classes for working with dates, times, durations, time zones, and formatting.

---

# Why Do We Need the Date & Time API?

Before Java 8

Problems with old classes:

- Mutable
- Not thread-safe
- Difficult formatting
- Poor API design

Example

```java
Date date = new Date();
```

Formatting required:

```java
SimpleDateFormat sdf =
new SimpleDateFormat("dd/MM/yyyy");
```

This class is **not thread-safe**.

Java 8 introduced a cleaner API.

---

# Real-World Example

Imagine a digital calendar.

```
Calendar

↓

Select Date

↓

Select Time

↓

Choose Time Zone

↓

Display
```

Similarly,

```
Date

↓

Time

↓

Time Zone

↓

Formatting

↓

Output
```

---

# Main Classes

| Class | Purpose |
|---------|----------|
| LocalDate | Date only |
| LocalTime | Time only |
| LocalDateTime | Date + Time |
| Instant | Machine timestamp |
| Duration | Time difference |
| Period | Date difference |
| ZoneId | Time Zone |
| ZonedDateTime | Date + Time + Zone |
| DateTimeFormatter | Formatting |

---

# LocalDate

Represents only a date.

```java
LocalDate today =
LocalDate.now();

System.out.println(today);
```

Output

```text
2026-07-28
```

---

Create custom date

```java
LocalDate birthday =
LocalDate.of(2005, 8, 15);
```

---

Useful methods

```java
today.getYear();

today.getMonth();

today.getDayOfMonth();

today.getDayOfWeek();
```

---

# LocalTime

Represents only time.

```java
LocalTime time =
LocalTime.now();

System.out.println(time);
```

Output

```text
10:30:15
```

---

Create custom time

```java
LocalTime time =
LocalTime.of(10,30);
```

---

Useful methods

```java
time.getHour();

time.getMinute();

time.getSecond();
```

---

# LocalDateTime

Represents date and time together.

```java
LocalDateTime now =
LocalDateTime.now();

System.out.println(now);
```

Output

```text
2026-07-28T10:30:15
```

---

Create custom value

```java
LocalDateTime dt =

LocalDateTime.of(

2026,
7,
28,
10,
30

);
```

---

# Instant

Represents a timestamp in UTC.

Useful for:

- Logging
- Databases
- Distributed systems
- REST APIs

```java
Instant instant =

Instant.now();

System.out.println(instant);
```

Output

```text
2026-07-28T05:00:00Z
```

---

# Period

Represents the difference between two dates.

```java
LocalDate start =
LocalDate.of(2020,1,1);

LocalDate end =
LocalDate.now();

Period period =
Period.between(start,end);

System.out.println(

period.getYears()

);
```

---

# Duration

Represents the difference between two times.

```java
LocalTime start =
LocalTime.of(10,0);

LocalTime end =
LocalTime.of(12,30);

Duration duration =

Duration.between(start,end);

System.out.println(

duration.toHours()

);
```

Output

```text
2
```

---

# ZoneId

Represents a time zone.

```java
ZoneId zone =

ZoneId.of("Asia/Kolkata");
```

---

# ZonedDateTime

Represents date, time, and time zone.

```java
ZonedDateTime india =

ZonedDateTime.now(

ZoneId.of("Asia/Kolkata")

);

System.out.println(india);
```

---

# DateTimeFormatter

Formats dates and times.

```java
DateTimeFormatter formatter =

DateTimeFormatter.ofPattern(

"dd/MM/yyyy"

);
```

Formatting

```java
String result =

LocalDate.now()

.format(formatter);

System.out.println(result);
```

Output

```text
28/07/2026
```

---

Parsing

```java
LocalDate date =

LocalDate.parse(

"15/08/2025",
formatter

);
```

---

# Adding Dates

```java
LocalDate today =
LocalDate.now();

today.plusDays(5);

today.plusMonths(2);

today.plusYears(1);
```

---

# Subtracting Dates

```java
today.minusDays(10);

today.minusMonths(3);

today.minusYears(2);
```

---

# Comparing Dates

```java
LocalDate d1 =
LocalDate.now();

LocalDate d2 =
LocalDate.of(2027,1,1);

System.out.println(

d1.isBefore(d2)

);

System.out.println(

d1.isAfter(d2)

);

System.out.println(

d1.equals(d2)

);
```

---

# Internal Working

```text
Application

↓

java.time Classes

↓

Immutable Objects

↓

Operations

↓

Formatted Output
```

Each operation returns a **new object** instead of modifying the existing one.

---

# Old API vs New API

| Old API | Java 8 API |
|----------|------------|
| Date | LocalDate |
| Calendar | LocalDateTime |
| SimpleDateFormat | DateTimeFormatter |
| Mutable | Immutable |
| Not Thread-safe | Thread-safe |
| Difficult to use | Easy to use |

---

# Production Usage

The Date & Time API is widely used in:

- Spring Boot
- Banking Applications
- E-commerce
- Scheduling Systems
- Logging
- REST APIs
- JWT Expiration
- Booking Systems

Example

```java
LocalDate expiryDate =

LocalDate.now()

.plusDays(30);
```

---

# Advantages

- Immutable
- Thread-safe
- Easy formatting
- Better API design
- Supports time zones
- Cleaner code

---

# Limitations

- Requires learning new classes
- Interoperability needed with legacy `Date` APIs

---

# Best Practices

✅ Prefer `java.time` over old `Date` and `Calendar`.

✅ Use `DateTimeFormatter` instead of `SimpleDateFormat`.

✅ Use `Instant` for timestamps.

✅ Use `LocalDate` for dates without time.

✅ Use `ZonedDateTime` when working with multiple time zones.

---

# Common Mistakes

❌ Using `Date` in new applications.

---

❌ Ignoring time zones.

---

❌ Modifying immutable objects without storing the returned value.

```java
today.plusDays(5);
```

Incorrect because the result is ignored.

Correct

```java
today = today.plusDays(5);
```

---

❌ Using `LocalDateTime` when an absolute timestamp (`Instant`) is required.

---

# Interview Questions

### 1. Why was the Java 8 Date & Time API introduced?

To replace the old `Date` and `Calendar` APIs with immutable, thread-safe, and easier-to-use classes.

---

### 2. What is the difference between `LocalDate` and `LocalDateTime`?

- `LocalDate` stores only the date.
- `LocalDateTime` stores both date and time.

---

### 3. What is `Instant`?

`Instant` represents a machine-readable timestamp in UTC.

---

### 4. What is the difference between `Period` and `Duration`?

- `Period` measures differences between dates.
- `Duration` measures differences between times or instants.

---

### 5. What is `ZoneId`?

It represents a time zone such as `"Asia/Kolkata"` or `"America/New_York"`.

---

### 6. What is `DateTimeFormatter`?

It formats and parses date/time values.

---

### 7. Are Java 8 Date & Time classes mutable?

No.

They are immutable.

---

### 8. Are they thread-safe?

Yes.

All major classes in `java.time` are thread-safe.

---

### 9. Why is immutability important?

It prevents accidental modification and makes objects safe to use across multiple threads.

---

### 10. Where is the Date & Time API used in Spring Boot?

It is commonly used for entity fields, API responses, scheduling, JWT expiration, logging, and timestamp management.

---

# Quick Revision

- `LocalDate` → Date only
- `LocalTime` → Time only
- `LocalDateTime` → Date + Time
- `Instant` → UTC timestamp
- `Period` → Date difference
- `Duration` → Time difference
- `ZoneId` → Time zone
- `ZonedDateTime` → Date + Time + Zone
- `DateTimeFormatter` → Formatting
- Immutable and thread-safe

---

# Keywords

- java.time
- LocalDate
- LocalTime
- LocalDateTime
- Instant
- Duration
- Period
- ZoneId
- ZonedDateTime
- DateTimeFormatter
- Immutable
- Thread-safe
- Java 8