# Try Catch Finally (Java)

## What are try, catch, and finally?

`try`, `catch`, and `finally` are Java keywords used for **exception handling**.

They allow a program to **handle runtime errors gracefully** instead of crashing.

---

# Why Do We Need try-catch?

Without exception handling, a program stops immediately when an exception occurs.

Example

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

# With try-catch

```java
public class Main {

    public static void main(String[] args) {

        try {

            int result = 10 / 0;

        } catch (ArithmeticException e) {

            System.out.println("Cannot divide by zero");

        }

        System.out.println("Program Finished");

    }

}
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
Car Breaks Down

↓

Journey Ends
```

With Exception Handling:

```
Car Breaks Down

↓

Repair Car

↓

Continue Journey
```

---

# try Block

The `try` block contains code that **may throw an exception**.

Syntax

```java
try {

    // Risky Code

}
```

Example

```java
try {

    int result = 10 / 0;

}
```

---

# catch Block

The `catch` block handles the exception thrown by the `try` block.

Syntax

```java
catch(ExceptionType e) {

}
```

Example

```java
catch(ArithmeticException e) {

    System.out.println("Division by zero");

}
```

---

# finally Block

The `finally` block **always executes**, whether an exception occurs or not.

It is mainly used for **resource cleanup**.

Syntax

```java
finally {

}
```

Example

```java
finally {

    System.out.println("Closing Database Connection");

}
```

---

# Execution Flow

## Case 1 : No Exception

```text
try

↓

No Exception

↓

Skip catch

↓

finally

↓

Program Continues
```

---

## Case 2 : Exception Occurs

```text
try

↓

Exception

↓

Matching catch

↓

finally

↓

Program Continues
```

---

## Case 3 : Exception Not Handled

```text
try

↓

Exception

↓

No Matching catch

↓

finally

↓

JVM Terminates Program
```

---

# Complete Example

```java
public class Main {

    public static void main(String[] args) {

        try {

            int result = 10 / 0;

        }

        catch (ArithmeticException e) {

            System.out.println("Cannot divide by zero");

        }

        finally {

            System.out.println("Finally Executed");

        }

    }

}
```

Output

```text
Cannot divide by zero

Finally Executed
```

---

# Multiple catch Blocks

One `try` block can have multiple `catch` blocks.

```java
try {

    String str = null;

    System.out.println(str.length());

}

catch (ArithmeticException e) {

    System.out.println("Arithmetic Error");

}

catch (NullPointerException e) {

    System.out.println("Null Error");

}
```

Output

```text
Null Error
```

---

# Multi-Catch (Java 7)

Multiple exceptions can be handled using one `catch`.

```java
try {

}

catch (IOException | SQLException e) {

    System.out.println("Handled");

}
```

Useful when handling logic is the same.

---

# Nested try-catch

A `try` block can be placed inside another `try` block.

```java
try {

    try {

        int a = 10 / 0;

    }

    catch (ArithmeticException e) {

        System.out.println("Inner Catch");

    }

}

catch (Exception e) {

    System.out.println("Outer Catch");

}
```

---

# finally with return Statement

```java
public static int test() {

    try {

        return 10;

    }

    finally {

        System.out.println("Finally");

    }

}
```

Output

```text
Finally

10
```

The `finally` block executes **before** the method actually returns.

---

# When finally May Not Execute

`finally` almost always executes, except in rare situations such as:

- JVM crashes
- `System.exit()`
- Power failure
- Forced process termination

Example

```java
System.exit(0);
```

---

# Internal Working

```text
Program Starts

↓

Enter try

↓

Exception?

↓

No

↓

Skip catch

↓

finally

↓

Continue

------------------------

Yes

↓

Create Exception Object

↓

Search Matching catch

↓

Execute catch

↓

finally

↓

Continue
```

---

# try-with-resources (Java 7)

Used for automatically closing resources.

Example

```java
try (FileReader file =
        new FileReader("test.txt")) {

    // Read File

}
catch (IOException e) {

    e.printStackTrace();

}
```

No need to manually close the file.

Resources that implement `AutoCloseable` are closed automatically.

Examples:

- File streams
- Database connections
- Network sockets

---

# Production Usage

`try-catch-finally` is used everywhere in enterprise applications.

Examples:

- Database operations
- File handling
- REST APIs
- Spring Boot services
- Payment processing
- External API calls

Example

```text
Open Database

↓

Execute Query

↓

Close Connection
```

The connection is usually closed in `finally` or by using **try-with-resources**.

---

# Advantages

- Prevents application crashes
- Allows graceful recovery
- Ensures cleanup code executes
- Makes applications more reliable

---

# Disadvantages

- Too many nested try-catch blocks reduce readability
- Catching generic exceptions may hide bugs
- Improper handling can make debugging difficult

---

# Best Practices

✅ Catch the most specific exception.

✅ Use `finally` for cleanup.

✅ Prefer **try-with-resources** for resources.

✅ Log exceptions properly.

✅ Keep try blocks as small as possible.

---

# Common Mistakes

❌ Empty catch block.

```java
catch(Exception e) {

}
```

---

❌ Catching `Exception` unnecessarily.

```java
catch(Exception e)
```

when a specific exception is expected.

---

❌ Forgetting to close resources.

---

❌ Writing very large `try` blocks.

---

# Interview Questions

### 1. What is the purpose of the try block?

It contains code that may throw an exception.

---

### 2. What does the catch block do?

It handles the exception thrown from the `try` block.

---

### 3. What is finally?

A block that executes regardless of whether an exception occurs, typically used for cleanup.

---

### 4. Does finally always execute?

Almost always.

Exceptions include:

- `System.exit()`
- JVM crash
- Power failure

---

### 5. Can we have multiple catch blocks?

Yes.

One `try` block can have multiple `catch` blocks.

---

### 6. Can we have a try block without catch?

Yes, if it has a `finally` block.

Example:

```java
try {

}
finally {

}
```

---

### 7. Can we have a catch block without try?

No.

A `catch` block must always follow a `try` block.

---

### 8. What is try-with-resources?

A feature introduced in Java 7 that automatically closes resources implementing `AutoCloseable`.

---

### 9. Why is try-with-resources preferred over finally?

Because it automatically closes resources and reduces the chance of resource leaks.

---

### 10. What happens if an exception is not caught?

The exception propagates up the call stack. If it remains unhandled, the JVM terminates the program.

---

# Quick Revision

- `try` → Contains risky code.
- `catch` → Handles exceptions.
- `finally` → Executes for cleanup.
- Multiple catch blocks are allowed.
- Multi-catch introduced in Java 7.
- `finally` executes even after `return` (in most cases).
- Prefer **try-with-resources** for files, streams, and database connections.
- Keep try blocks small and catch specific exceptions.

---

# Keywords

- try
- catch
- finally
- try-with-resources
- AutoCloseable
- Multi-catch
- Nested try
- Exception Handling
- Resource Cleanup
- Java 7
- IOException
- ArithmeticException
- NullPointerException