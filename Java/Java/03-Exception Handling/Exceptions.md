# Exceptions (Java)

## What is an Exception?

An **Exception** is an **unexpected event** that occurs during program execution and **disrupts the normal flow** of the program.

In simple words,

> **An Exception is a runtime problem that Java can detect and handle.**

---

# Why Do We Need Exception Handling?

Without exception handling, a program terminates immediately when an error occurs.

Example:

```java
public class Main {

    public static void main(String[] args) {

        int a = 10;
        int b = 0;

        System.out.println(a / b);

        System.out.println("Program Finished");

    }

}
```

Output

```text
Exception in thread "main"
java.lang.ArithmeticException: / by zero
```

The last statement never executes.

---

# With Exception Handling

```java
try {

    int result = 10 / 0;

} catch (ArithmeticException e) {

    System.out.println("Cannot divide by zero");

}

System.out.println("Program Finished");
```

Output

```text
Cannot divide by zero

Program Finished
```

The program continues normally.

---

# Real-World Example

Imagine you are driving a car.

Without Exception Handling:

```
Tyre Puncture

↓

Journey Stops
```

With Exception Handling:

```
Tyre Puncture

↓

Replace Tyre

↓

Continue Journey
```

Exception handling allows the program to recover instead of crashing.

---

# Exception Hierarchy

```text
                    Object
                       │
                 Throwable
                 /       \
                /         \
            Error      Exception
                           │
          ┌────────────────┴───────────────┐
          │                                │
 Checked Exceptions             RuntimeException
                                         │
                          Unchecked Exceptions
```

---

# What is Throwable?

`Throwable` is the parent class of everything that can be thrown in Java.

It has two major subclasses:

- Error
- Exception

---

# Error

Errors represent **serious problems** that applications usually should not try to recover from.

Examples:

- OutOfMemoryError
- StackOverflowError
- VirtualMachineError

Example

```java
StackOverflowError
```

Usually caused by infinite recursion.

---

# Exception

Exceptions represent problems that applications **can handle**.

Examples:

- IOException
- SQLException
- ArithmeticException
- NullPointerException

---

# Types of Exceptions

## 1. Checked Exceptions

Checked by the compiler.

Must be handled using:

- try-catch
- throws

Examples

```java
IOException

SQLException

FileNotFoundException
```

---

## 2. Unchecked Exceptions

Checked during runtime.

Usually caused by programming mistakes.

Examples

```java
ArithmeticException

NullPointerException

ArrayIndexOutOfBoundsException

NumberFormatException
```

---

# Common Exceptions

## ArithmeticException

```java
int result = 10 / 0;
```

---

## NullPointerException

```java
String name = null;

System.out.println(name.length());
```

---

## ArrayIndexOutOfBoundsException

```java
int[] arr = {1,2,3};

System.out.println(arr[5]);
```

---

## NumberFormatException

```java
Integer.parseInt("Java");
```

---

## FileNotFoundException

```java
FileReader file =
new FileReader("abc.txt");
```

---

# Exception Handling Keywords

| Keyword | Purpose |
|----------|----------|
| try | Wrap risky code |
| catch | Handle exception |
| finally | Always executes |
| throw | Throw an exception |
| throws | Declare possible exceptions |

---

# Exception Handling Flow

```text
Program Starts

↓

try Block

↓

Exception?

↓

No ----------------→ Continue Program

↓

Yes

↓

Matching catch Block

↓

finally Block

↓

Program Continues
```

---

# How Exceptions Work Internally

Suppose:

```java
int result = 10 / 0;
```

Internally,

```text
JVM Executes Statement

↓

ArithmeticException Created

↓

JVM Searches Matching catch

↓

Found?

↓

Yes

↓

Execute catch Block

↓

Continue Program

↓

No

↓

Program Terminates
```

---

# Exception Propagation

If a method does not handle an exception,

it is passed to the calling method.

Example

```java
methodA()

↓

methodB()

↓

methodC()

↓

Exception

↓

Back to methodB()

↓

Back to methodA()

↓

main()
```

If nobody handles it,

the JVM terminates the program.

---

# Exception vs Error

| Exception | Error |
|------------|--------|
| Can be handled | Usually cannot be handled |
| Recoverable | Serious system problem |
| Application issue | JVM/System issue |
| Example: IOException | Example: OutOfMemoryError |

---

# Exception vs Bug

A **Bug** is a mistake in your code.

An **Exception** is an event that occurs while the program is running.

Example

Bug:

```java
int a = 10 / 0;
```

Result:

```text
ArithmeticException
```

The bug caused the exception.

---

# Production Usage

Exception handling is used in every enterprise application.

Examples:

- Database operations
- REST APIs
- Payment gateways
- File uploads
- Authentication
- Spring Boot applications
- Banking software
- E-commerce systems

Example:

A banking application cannot connect to the database.

Instead of crashing,

it catches the exception, logs the error, and returns:

```text
"Service temporarily unavailable."
```

---

# Advantages

- Prevents application crashes
- Improves reliability
- Makes debugging easier
- Separates normal logic from error handling
- Enables graceful recovery

---

# Disadvantages

- Too many try-catch blocks reduce readability
- Improper handling can hide bugs
- Excessive exception creation has a performance cost

---

# Best Practices

✅ Catch only exceptions you can handle.

✅ Use meaningful exception messages.

✅ Log exceptions properly.

✅ Never ignore exceptions.

✅ Prefer specific exceptions over generic `Exception`.

---

# Common Mistakes

❌ Catching every exception.

```java
catch (Exception e)
```

when a specific exception is expected.

---

❌ Leaving an empty catch block.

```java
catch(Exception e) {

}
```

---

❌ Using exceptions for normal program flow.

---

❌ Ignoring exception messages.

---

# Interview Questions

### 1. What is an Exception?

An exception is an unexpected event that interrupts the normal execution of a program.

---

### 2. What is the difference between Error and Exception?

Errors are serious JVM/system problems, while exceptions are application-level problems that can often be handled.

---

### 3. What is Throwable?

`Throwable` is the root class for all objects that can be thrown using the `throw` statement.

---

### 4. What are Checked and Unchecked Exceptions?

Checked exceptions are verified by the compiler.

Unchecked exceptions occur at runtime and are subclasses of `RuntimeException`.

---

### 5. What happens if an exception is not handled?

The exception propagates up the call stack. If it reaches `main()` without being handled, the JVM terminates the program.

---

### 6. What is Exception Propagation?

The process of passing an unhandled exception from one method to its caller until it is handled or reaches the JVM.

---

### 7. Name some common runtime exceptions.

- ArithmeticException
- NullPointerException
- ArrayIndexOutOfBoundsException
- NumberFormatException

---

### 8. What is the parent class of all exceptions?

`Throwable`.

---

### 9. Can Errors be handled?

Technically yes using `catch (Error e)`, but in practice they are generally not meant to be handled because they represent serious JVM problems.

---

### 10. Why do we need Exception Handling?

To prevent abrupt program termination and allow applications to recover gracefully from runtime problems.

---

# Quick Revision

- Exception = Runtime problem.
- Parent class = `Throwable`.
- Two types:
  - Checked
  - Unchecked
- Errors are usually not recoverable.
- Exceptions can often be handled.
- Keywords:
  - try
  - catch
  - finally
  - throw
  - throws
- Unhandled exceptions propagate up the call stack.
- Good exception handling improves application reliability.

---

# Keywords

- Exception
- Throwable
- Error
- Checked Exception
- Unchecked Exception
- RuntimeException
- ArithmeticException
- NullPointerException
- IOException
- try
- catch
- finally
- throw
- throws
- Exception Propagation
- JVM
- Java Exception Handling