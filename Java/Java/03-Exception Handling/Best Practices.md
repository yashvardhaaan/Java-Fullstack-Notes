# Exception Handling Best Practices (Java)

## What are Exception Handling Best Practices?

Exception Handling Best Practices are guidelines that help us write **clean, readable, maintainable, and reliable** Java code.

Good exception handling makes applications easier to debug and prevents unexpected crashes.

---

# Why Do We Need Best Practices?

Poor exception handling can:

- Hide bugs
- Make debugging difficult
- Cause resource leaks
- Reduce code readability
- Crash applications unexpectedly

Following best practices makes applications more stable and production-ready.

---

# Real-World Example

Imagine a hospital.

Good Practice:

```
Patient Problem

↓

Correct Doctor

↓

Correct Treatment

↓

Patient Recovers
```

Bad Practice:

```
Patient Problem

↓

Send to Any Doctor

↓

Wrong Treatment

↓

More Problems
```

Similarly, catching the correct exception leads to better error handling.

---

# 1. Catch Specific Exceptions

❌ Bad

```java
try {

    int result = 10 / 0;

}

catch (Exception e) {

    System.out.println("Error");

}
```

This catches every exception, making debugging harder.

---

✅ Good

```java
try {

    int result = 10 / 0;

}

catch (ArithmeticException e) {

    System.out.println("Cannot divide by zero");

}
```

Always catch the most specific exception possible.

---

# 2. Never Ignore Exceptions

❌ Bad

```java
try {

    FileReader file =
        new FileReader("test.txt");

}

catch (Exception e) {

}
```

The exception disappears, making bugs difficult to find.

---

✅ Good

```java
catch (Exception e) {

    System.out.println(e.getMessage());

}
```

In real applications, use a logging framework instead of `System.out.println()`.

---

# 3. Write Meaningful Exception Messages

❌ Bad

```java
throw new IllegalArgumentException("Error");
```

---

✅ Good

```java
throw new IllegalArgumentException(
    "Age cannot be negative"
);
```

Meaningful messages make debugging much easier.

---

# 4. Use Custom Exceptions for Business Rules

Instead of:

```java
throw new RuntimeException(
    "Invalid User"
);
```

Use:

```java
throw new UserNotFoundException(
    "User ID 101 not found"
);
```

This makes the code easier to understand.

---

# 5. Don't Use Exceptions for Normal Flow

❌ Bad

```java
try {

    int value = Integer.parseInt(input);

}

catch (NumberFormatException e) {

    value = 0;

}
```

Using exceptions for expected situations is inefficient.

---

✅ Better

```java
if(input.matches("\\d+")) {

    int value = Integer.parseInt(input);

}
```

Validate input before relying on exceptions.

---

# 6. Keep try Blocks Small

❌ Bad

```java
try {

    // 100 lines of code

}
```

Large `try` blocks make it harder to identify where the exception occurred.

---

✅ Good

```java
try {

    FileReader file =
        new FileReader("test.txt");

}
```

Only include code that might throw the exception.

---

# 7. Always Close Resources

❌ Bad

```java
FileReader file =
    new FileReader("test.txt");
```

If an exception occurs, the file may remain open.

---

✅ Good (Java 7+)

```java
try (FileReader file =
        new FileReader("test.txt")) {

    // Read file

}
```

`try-with-resources` automatically closes the file.

---

# 8. Log Exceptions Properly

❌ Bad

```java
catch(Exception e) {

    System.out.println("Error");

}
```

---

✅ Good

```java
catch(Exception e) {

    e.printStackTrace();

}
```

In production, use logging frameworks such as Logback or Log4j instead of `printStackTrace()`.

---

# 9. Don't Catch Throwable or Error

❌ Bad

```java
catch(Throwable t) {

}
```

or

```java
catch(Error e) {

}
```

These include serious JVM errors that applications usually should not handle.

---

# 10. Throw the Right Exception

❌ Bad

```java
throw new Exception("Invalid Password");
```

---

✅ Good

```java
throw new IllegalArgumentException(
    "Password cannot be empty"
);
```

Choose the most appropriate exception type.

---

# 11. Preserve the Original Exception

When wrapping an exception, include the original cause.

❌ Bad

```java
catch(IOException e) {

    throw new RuntimeException();

}
```

---

✅ Good

```java
catch(IOException e) {

    throw new RuntimeException(
        "Failed to read file",
        e
    );

}
```

This keeps the original stack trace for debugging.

---

# 12. Document Checked Exceptions

If a method throws a checked exception, document it clearly.

```java
/**
 * Reads a file.
 *
 * @throws IOException
 * if the file cannot be read.
 */
public void readFile()
        throws IOException {

}
```

---

# Internal Flow

```text
Risky Code

↓

Specific Exception

↓

Handle Correctly

↓

Log Error

↓

Clean Resources

↓

Continue Program
```

---

# Production Usage

Good exception handling is essential in:

- Spring Boot Applications
- Banking Systems
- E-commerce Platforms
- Payment Gateways
- REST APIs
- Healthcare Systems
- Microservices

Example:

```text
User Login

↓

Database Error

↓

Catch SQLException

↓

Log Error

↓

Return HTTP 500

↓

Application Continues Running
```

---

# Advantages

- Cleaner code
- Easier debugging
- Better readability
- Better maintainability
- Fewer application crashes
- Easier production monitoring

---

# Common Mistakes

❌ Catching generic `Exception`.

❌ Ignoring exceptions.

❌ Using exceptions for normal logic.

❌ Throwing generic exceptions.

❌ Large `try` blocks.

❌ Forgetting to close resources.

❌ Poor exception messages.

---

# Best Practices Summary

| Practice | Recommendation |
|----------|----------------|
| Catch exceptions | Catch the most specific exception |
| Ignore exceptions | Never ignore them |
| Messages | Use meaningful messages |
| Resources | Use try-with-resources |
| Logging | Log exceptions properly |
| Custom Exceptions | Use for business rules |
| try Block | Keep it small |
| Generic Exception | Avoid unless necessary |
| Original Cause | Preserve it when wrapping exceptions |

---

# Interview Questions

### 1. Why should we catch specific exceptions?

Because they make error handling more precise and debugging easier.

---

### 2. Why should we avoid catching `Exception`?

It can hide programming mistakes and make debugging difficult.

---

### 3. Why shouldn't we ignore exceptions?

Ignored exceptions make it difficult to identify and fix problems.

---

### 4. Why is `try-with-resources` preferred?

It automatically closes resources and prevents resource leaks.

---

### 5. Why are meaningful exception messages important?

They help developers quickly understand the cause of the error.

---

### 6. Why should we preserve the original exception?

To retain the original stack trace and debugging information.

---

### 7. Why should we use Custom Exceptions?

To represent business-specific errors with clear and meaningful names.

---

### 8. Should we catch `Throwable`?

Generally, no. It includes serious JVM errors that applications usually should not handle.

---

### 9. What logging framework is commonly used in Spring Boot?

Spring Boot commonly uses **Logback** (through SLF4J) by default.

---

### 10. What is the biggest mistake in exception handling?

Ignoring exceptions or catching overly generic exceptions without proper handling.

---

# Quick Revision

- Catch **specific** exceptions.
- Never ignore exceptions.
- Write meaningful error messages.
- Prefer **try-with-resources**.
- Keep `try` blocks small.
- Use Custom Exceptions for business rules.
- Preserve the original exception when wrapping.
- Log exceptions properly.
- Avoid catching `Throwable` or `Error`.
- Exception handling should make applications more reliable, not hide problems.

---

# Keywords

- Exception Handling
- Best Practices
- try-with-resources
- Logging
- Custom Exception
- Specific Exception
- Exception Message
- Resource Leak
- Stack Trace
- Logback
- SLF4J
- Throwable
- Error
- Java Exception Handling