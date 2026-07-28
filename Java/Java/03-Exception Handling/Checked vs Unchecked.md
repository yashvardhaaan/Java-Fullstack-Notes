# Checked vs Unchecked Exceptions (Java)

## What are Checked and Unchecked Exceptions?

Java divides exceptions into **two categories**:

1. **Checked Exceptions**
2. **Unchecked Exceptions (Runtime Exceptions)**

The main difference is **whether the compiler checks them or not**.

---

# Why Do We Need Two Types?

Some exceptions are **expected** and the compiler forces us to handle them.

Others are usually caused by **programming mistakes**, so the compiler does not force handling.

Example:

- File may not exist → Expected → Checked Exception
- Divide by zero → Programming mistake → Unchecked Exception

---

# Real-World Example

Imagine you're traveling.

### Checked Exception

```
Flight Ticket

↓

Passport Required

↓

Without Passport

↓

Cannot Travel
```

The rule is checked **before** traveling.

---

### Unchecked Exception

```
Driving Car

↓

Overspeeding

↓

Accident
```

No one stops you before driving, but the problem occurs **while driving**.

---

# Exception Hierarchy

```text
                    Throwable
                        │
                ┌──────────────┐
                │              │
             Error         Exception
                                │
               ┌────────────────────────┐
               │                        │
      Checked Exceptions      RuntimeException
                                        │
                           Unchecked Exceptions
```

---

# Checked Exceptions

## What are Checked Exceptions?

Checked Exceptions are checked by the **compiler**.

The compiler forces you to either:

- Handle them using `try-catch`
- Declare them using `throws`

Otherwise, the program will not compile.

---

## Example

```java
import java.io.FileReader;

public class Main {

    public static void main(String[] args) {

        FileReader file =
            new FileReader("test.txt");

    }

}
```

Compilation Error

```text
Unhandled exception:
FileNotFoundException
```

---

# Handling Checked Exception

```java
try {

    FileReader file =
        new FileReader("test.txt");

}

catch (FileNotFoundException e) {

    System.out.println("File not found");

}
```

Now the program compiles successfully.

---

# Common Checked Exceptions

- IOException
- FileNotFoundException
- SQLException
- ClassNotFoundException
- InterruptedException

---

# Unchecked Exceptions

## What are Unchecked Exceptions?

Unchecked Exceptions occur during **runtime**.

The compiler does **not** force you to handle them.

They are subclasses of:

```java
RuntimeException
```

---

## Example

```java
int result = 10 / 0;
```

Output

```text
ArithmeticException
```

The code compiles successfully.

The exception occurs only when the program runs.

---

# Common Unchecked Exceptions

- ArithmeticException
- NullPointerException
- ArrayIndexOutOfBoundsException
- NumberFormatException
- IllegalArgumentException
- IllegalStateException

---

# Checked Exception Flow

```text
Write Code

↓

Compiler Checks

↓

Exception Found

↓

Handle or Declare

↓

Compilation Successful
```

---

# Unchecked Exception Flow

```text
Write Code

↓

Compiler Ignores

↓

Program Runs

↓

Exception Occurs
```

---

# Checked vs Unchecked

| Checked Exception | Unchecked Exception |
|-------------------|---------------------|
| Checked by compiler | Checked at runtime |
| Must be handled or declared | Handling is optional |
| Subclass of `Exception` | Subclass of `RuntimeException` |
| Usually external problems | Usually programming mistakes |
| Compile-time checking | Runtime checking |

---

# Why Doesn't Java Force Runtime Exceptions?

Consider:

```java
String name = null;

System.out.println(name.length());
```

The compiler cannot always know that `name` will be `null` at runtime.

Therefore,

Java leaves it to the programmer to fix these mistakes.

---

# Internal Working

### Checked Exception

```text
Compiler

↓

Checks Code

↓

Exception?

↓

Yes

↓

Compilation Error

↓

Handle Exception
```

---

### Unchecked Exception

```text
Compiler

↓

No Checking

↓

Program Runs

↓

JVM Detects Problem

↓

Throws RuntimeException
```

---

# When to Use Checked Exceptions?

Use Checked Exceptions when:

- Reading files
- Database operations
- Network communication
- External APIs
- Interrupted threads

These are situations where the caller can reasonably recover.

---

# When to Use Unchecked Exceptions?

Use Runtime Exceptions when:

- Invalid input
- Null values
- Illegal arguments
- Programming errors
- Invalid object state

These usually indicate bugs in the code.

---

# Production Usage

### Checked Exceptions

Used in:

- File Upload
- Database Connection
- REST Client
- Email Sending
- Reading Configuration Files

Example

```text
Database Not Available

↓

SQLException

↓

Application Handles It
```

---

### Unchecked Exceptions

Used in:

- Validation failures
- Invalid user input
- Business logic errors
- Incorrect API usage

Example

```java
throw new IllegalArgumentException(
    "Age cannot be negative");
```

---

# Advantages

## Checked Exceptions

- Forces proper error handling
- Makes APIs safer
- Better for recoverable errors

---

## Unchecked Exceptions

- Cleaner code
- Less boilerplate
- Ideal for programming mistakes

---

# Disadvantages

## Checked Exceptions

- More code
- Can become verbose
- Sometimes overused

---

## Unchecked Exceptions

- Easier to ignore
- Can crash applications if not handled

---

# Best Practices

✅ Use Checked Exceptions for recoverable situations.

✅ Use Runtime Exceptions for programming mistakes.

✅ Never catch exceptions you cannot handle.

✅ Always provide meaningful exception messages.

---

# Common Mistakes

❌ Catching every exception.

```java
catch (Exception e)
```

---

❌ Using Checked Exceptions for validation errors.

---

❌ Ignoring Runtime Exceptions instead of fixing the root cause.

---

# Interview Questions

### 1. What is a Checked Exception?

An exception checked by the compiler that must be handled or declared.

---

### 2. What is an Unchecked Exception?

An exception checked at runtime that extends `RuntimeException`.

---

### 3. What is the main difference?

Checked exceptions are verified by the compiler.

Unchecked exceptions are verified during program execution.

---

### 4. Give examples of Checked Exceptions.

- IOException
- SQLException
- FileNotFoundException
- InterruptedException

---

### 5. Give examples of Unchecked Exceptions.

- NullPointerException
- ArithmeticException
- IllegalArgumentException
- ArrayIndexOutOfBoundsException

---

### 6. Is RuntimeException checked?

No.

It is an Unchecked Exception.

---

### 7. Why are Runtime Exceptions not checked by the compiler?

Because they usually represent programming mistakes that should be fixed rather than forced to be handled.

---

### 8. Should we catch Runtime Exceptions?

Only when you can recover or provide a meaningful response.

Otherwise, fix the underlying bug.

---

### 9. Which type of exception should be used for file handling?

Checked Exceptions like `IOException` or `FileNotFoundException`.

---

### 10. Which type of exception is preferred for invalid method arguments?

`IllegalArgumentException` (an Unchecked Exception).

---

# Quick Revision

- Java has **Checked** and **Unchecked** Exceptions.
- Checked Exceptions → Compiler checks.
- Unchecked Exceptions → JVM checks at runtime.
- Checked Exceptions must be handled or declared.
- Unchecked Exceptions are subclasses of `RuntimeException`.
- Use Checked Exceptions for recoverable errors.
- Use Unchecked Exceptions for programming mistakes.

---

# Keywords

- Checked Exception
- Unchecked Exception
- RuntimeException
- IOException
- SQLException
- FileNotFoundException
- NullPointerException
- ArithmeticException
- IllegalArgumentException
- Compile Time
- Runtime
- Exception Hierarchy
- Java Exception Handling