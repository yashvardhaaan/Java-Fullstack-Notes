# Throw vs Throws (Java)

## What are `throw` and `throws`?

Both `throw` and `throws` are Java keywords used in **Exception Handling**, but they have different purposes.

- **throw** → Used to explicitly throw an exception.
- **throws** → Used to declare that a method may throw an exception.

> **Simple Rule:**
>
> - **throw = Actually throw an exception**
> - **throws = Tell others that this method may throw an exception**

---

# Why Do We Need throw and throws?

Sometimes Java throws exceptions automatically.

Example:

```java
int result = 10 / 0;
```

JVM automatically throws:

```text
ArithmeticException
```

But sometimes we want to throw our own exception.

Example:

```java
Age cannot be negative.
```

Java doesn't know this business rule.

We use:

```java
throw new IllegalArgumentException("Invalid Age");
```

---

# Real-World Example

Imagine an airport.

### throw

```
Passenger

↓

Security Finds Problem

↓

Stops Passenger Immediately
```

Security actively stops the passenger.

---

### throws

```
Travel Agency

↓

"This flight may be delayed."
```

The agency is only informing you.

It isn't causing the delay.

---

# throw Keyword

## What is throw?

`throw` is used to **explicitly create and throw an exception object**.

Syntax

```java
throw new ExceptionType("Message");
```

---

# Example

```java
public class Main {

    public static void main(String[] args) {

        int age = -5;

        if(age < 0) {

            throw new IllegalArgumentException(
                "Age cannot be negative"
            );

        }

    }

}
```

Output

```text
Exception in thread "main"
java.lang.IllegalArgumentException:
Age cannot be negative
```

---

# How throw Works

```text
Program

↓

Condition

↓

throw

↓

Exception Object Created

↓

JVM Searches catch Block
```

---

# throws Keyword

## What is throws?

`throws` is used in a **method declaration** to indicate that the method may throw one or more exceptions.

Syntax

```java
returnType methodName()
throws ExceptionType {

}
```

---

# Example

```java
import java.io.*;

public class Main {

    static void readFile()
            throws IOException {

        FileReader file =
            new FileReader("test.txt");

    }

}
```

This method informs the caller that it may throw an `IOException`.

---

# Calling Method

```java
public static void main(String[] args) {

    try {

        readFile();

    }

    catch(IOException e) {

        System.out.println("File Error");

    }

}
```

Output

```text
File Error
```

---

# Multiple Exceptions using throws

A method can declare multiple exceptions.

```java
void test()
throws IOException,
SQLException {

}
```

---

# throw vs throws

| throw | throws |
|--------|---------|
| Keyword | Keyword |
| Used inside a method | Used in method declaration |
| Actually throws an exception | Declares possible exceptions |
| Throws one exception object at a time | Can declare multiple exceptions |
| Followed by an exception object | Followed by exception class names |

---

# Can We Throw Checked Exceptions?

Yes.

```java
throw new IOException();
```

But the compiler requires it to be handled or declared.

Example

```java
public void test()
throws IOException {

    throw new IOException();

}
```

---

# Can We Throw Runtime Exceptions?

Yes.

Example

```java
throw new IllegalArgumentException(
    "Invalid Input"
);
```

No `throws` declaration is required because it is an unchecked exception.

---

# Exception Flow

## Using throw

```text
Condition

↓

throw

↓

Exception Created

↓

JVM Searches catch

↓

Handled?
```

---

## Using throws

```text
Method

↓

throws IOException

↓

Caller

↓

Handle Exception

or

Declare Again
```

---

# Internal Working

Example

```java
throw new ArithmeticException();
```

Internally

```text
new ArithmeticException()

↓

Exception Object Created

↓

JVM Receives Exception

↓

Search Matching catch

↓

Execute catch

↓

Continue Program
```

---

# Production Usage

## throw

Used for:

- Input Validation
- Business Rules
- Authentication
- Authorization
- Payment Validation

Example

```java
throw new IllegalArgumentException(
    "Amount cannot be negative"
);
```

---

## throws

Used for:

- File Operations
- Database Access
- Network Calls
- External APIs
- Library Methods

Example

```java
public void save()
throws SQLException
```

---

# Advantages

## throw

- Custom validation
- Business rule enforcement
- Clear error messages

---

## throws

- Makes APIs easier to understand
- Forces callers to handle checked exceptions
- Improves code readability

---

# Disadvantages

## throw

- Excessive use makes code harder to read
- Should not replace normal program flow

---

## throws

- Can propagate exceptions through many methods
- Too many declarations can clutter APIs

---

# Best Practices

✅ Use `throw` for validation failures.

✅ Use `throws` for checked exceptions.

✅ Throw specific exceptions instead of generic `Exception`.

✅ Write meaningful exception messages.

---

# Common Mistakes

❌ Throwing generic exceptions.

```java
throw new Exception();
```

---

❌ Declaring unnecessary exceptions.

```java
throws Exception
```

when a specific exception should be declared.

---

❌ Using `throw` for normal control flow.

---

# Interview Questions

### 1. What is the difference between `throw` and `throws`?

`throw` actually throws an exception.

`throws` declares that a method may throw exceptions.

---

### 2. Where is `throw` used?

Inside a method or block of code.

---

### 3. Where is `throws` used?

In the method declaration.

---

### 4. Can `throw` throw multiple exceptions?

No.

One exception object is thrown at a time.

---

### 5. Can `throws` declare multiple exceptions?

Yes.

```java
throws IOException, SQLException
```

---

### 6. Is `throws` mandatory?

Only for checked exceptions that are not handled inside the method.

---

### 7. Can we throw Runtime Exceptions?

Yes.

Example:

```java
throw new IllegalArgumentException();
```

---

### 8. Does `throw` create an exception?

No.

The exception object is created using `new`.

`throw` transfers control to the exception-handling mechanism.

---

### 9. Which keyword is used for custom validation?

`throw`.

---

### 10. Which keyword is mainly used with checked exceptions?

`throws`.

---

# Quick Revision

- `throw` → Throws an exception.
- `throws` → Declares possible exceptions.
- `throw` is used inside methods.
- `throws` is used in method signatures.
- `throw` creates and passes an exception object.
- `throws` informs the caller.
- Use `throw` for validation.
- Use `throws` for checked exceptions.

---

# Keywords

- throw
- throws
- Checked Exception
- Unchecked Exception
- IllegalArgumentException
- IOException
- Exception Propagation
- Method Declaration
- Exception Object
- Java Exception Handling