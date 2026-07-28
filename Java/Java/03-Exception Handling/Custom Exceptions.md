# Custom Exceptions (Java)

## What are Custom Exceptions?

A **Custom Exception** is a user-defined exception created by a programmer to represent **application-specific or business-specific errors**.

Java provides many built-in exceptions, but sometimes they are not enough to represent business rules.

> **Definition:** A Custom Exception is a class that extends `Exception` or `RuntimeException` to represent a specific error condition in an application.

---

# Why Do We Need Custom Exceptions?

Built-in exceptions describe general programming errors.

Example:

```java
ArithmeticException
NullPointerException
IOException
```

But what about situations like:

- Age cannot be negative
- Insufficient bank balance
- Product out of stock
- Invalid Employee ID
- Invalid OTP

Java has no built-in exceptions for these.

We create **Custom Exceptions**.

---

# Real-World Example

Imagine a bank.

```
Withdraw Money

↓

Balance = ₹500

↓

Withdraw ₹1000

↓

InsufficientBalanceException
```

Instead of showing:

```
RuntimeException
```

We show:

```
InsufficientBalanceException
```

which is much more meaningful.

---

# Types of Custom Exceptions

There are two types.

## 1. Checked Custom Exception

Extends:

```java
Exception
```

Compiler forces handling.

---

## 2. Unchecked Custom Exception

Extends:

```java
RuntimeException
```

Compiler does not force handling.

---

# Creating a Checked Custom Exception

```java
public class InvalidAgeException
        extends Exception {

    public InvalidAgeException(String message) {

        super(message);

    }

}
```

---

# Using Checked Custom Exception

```java
public class Main {

    static void vote(int age)
            throws InvalidAgeException {

        if(age < 18) {

            throw new InvalidAgeException(
                "Age must be at least 18"
            );

        }

        System.out.println("Eligible to Vote");

    }

    public static void main(String[] args) {

        try {

            vote(15);

        }

        catch (InvalidAgeException e) {

            System.out.println(e.getMessage());

        }

    }

}
```

Output

```text
Age must be at least 18
```

---

# Creating an Unchecked Custom Exception

```java
public class InvalidAgeException
        extends RuntimeException {

    public InvalidAgeException(String message) {

        super(message);

    }

}
```

No `throws` declaration is required.

---

# How Custom Exceptions Work

```text
Business Rule

↓

Condition Fails

↓

throw new CustomException()

↓

JVM Searches catch Block

↓

Handled

↓

Program Continues
```

---

# Why Call super(message)?

```java
super(message);
```

This passes the message to the parent `Exception` class.

Example

```java
throw new InvalidAgeException(
    "Age must be at least 18"
);
```

Then,

```java
e.getMessage();
```

returns

```text
Age must be at least 18
```

---

# Custom Exception Hierarchy

```text
                Throwable
                    │
             Exception
                 │
     InvalidAgeException

----------------------------

            RuntimeException
                 │
     InsufficientBalanceException
```

---

# Example 1 : Banking

```java
class InsufficientBalanceException
        extends Exception {

    public InsufficientBalanceException(
            String message) {

        super(message);

    }

}
```

Usage

```java
if(balance < amount) {

    throw new InsufficientBalanceException(
        "Insufficient Balance"
    );

}
```

---

# Example 2 : Student

```java
if(marks < 0 || marks > 100) {

    throw new InvalidMarksException(
        "Marks should be between 0 and 100"
    );

}
```

---

# Example 3 : E-commerce

```java
if(stock == 0) {

    throw new ProductOutOfStockException(
        "Product is Out of Stock"
    );

}
```

---

# Checked vs Unchecked Custom Exception

| Checked | Unchecked |
|----------|-----------|
| Extends `Exception` | Extends `RuntimeException` |
| Must be handled | Handling optional |
| Recoverable situations | Programming or business errors |
| Uses `throws` | Usually no `throws` required |

---

# Internal Working

```text
Business Logic

↓

Validation

↓

Condition Fails

↓

Create Exception Object

↓

throw

↓

Search Matching catch

↓

Execute catch

↓

Continue Program
```

---

# Production Usage

Custom Exceptions are widely used in:

- Spring Boot
- Banking Systems
- Payment Gateways
- E-commerce
- Hospital Management
- Airline Booking
- Authentication Systems

Examples

- UserNotFoundException
- InvalidOTPException
- PaymentFailedException
- ProductNotFoundException
- InsufficientBalanceException
- OrderNotFoundException

---

# Advantages

- Meaningful error messages
- Better readability
- Easier debugging
- Better API design
- Cleaner business logic

---

# Disadvantages

- More classes to maintain
- Overusing custom exceptions can make projects complex
- Poor naming can confuse developers

---

# Best Practices

✅ Name exceptions clearly.

Examples

```java
UserNotFoundException

PaymentFailedException

InvalidOTPException
```

---

✅ Extend the correct parent class.

- `Exception` → Recoverable errors
- `RuntimeException` → Programming/business validation errors

---

✅ Always provide meaningful messages.

---

✅ Keep custom exceptions simple.

---

# Common Mistakes

❌ Creating a custom exception when a built-in exception is sufficient.

---

❌ Extending the wrong parent class.

---

❌ Throwing generic exceptions instead of meaningful ones.

---

❌ Using custom exceptions for normal program flow.

---

# Interview Questions

### 1. What is a Custom Exception?

A user-defined exception created to represent application-specific or business-specific errors.

---

### 2. Why do we create Custom Exceptions?

To provide meaningful and domain-specific error handling instead of relying only on generic Java exceptions.

---

### 3. How do you create a Checked Custom Exception?

By extending:

```java
Exception
```

---

### 4. How do you create an Unchecked Custom Exception?

By extending:

```java
RuntimeException
```

---

### 5. Why is `super(message)` used?

It passes the error message to the parent exception class so it can be retrieved using `getMessage()`.

---

### 6. When should you use Checked Custom Exceptions?

For recoverable situations where the caller is expected to handle the problem.

---

### 7. When should you use Runtime Custom Exceptions?

For programming errors, validation failures, or business rule violations.

---

### 8. Can a Custom Exception have constructors?

Yes.

It can have default constructors, constructors with messages, causes, or both.

---

### 9. Are Custom Exceptions used in Spring Boot?

Yes.

Common examples include:

- ResourceNotFoundException
- UserAlreadyExistsException
- InvalidRequestException
- PaymentFailedException

---

### 10. What are the benefits of Custom Exceptions?

- Better readability
- Easier debugging
- Clear business logic
- More meaningful API responses

---

# Quick Revision

- Custom Exception = User-defined exception.
- Used for business-specific errors.
- Checked → extends `Exception`.
- Unchecked → extends `RuntimeException`.
- Throw using `throw`.
- Use `super(message)` to pass the error message.
- Common in Spring Boot and enterprise applications.
- Prefer meaningful exception names.

---

# Keywords

- Custom Exception
- Exception
- RuntimeException
- Checked Exception
- Unchecked Exception
- throw
- throws
- super(message)
- Business Validation
- InvalidAgeException
- InsufficientBalanceException
- UserNotFoundException
- Java Exception Handling