# Unit Testing

## What is Unit Testing?

**Unit Testing** is the process of testing the **smallest individual unit of code** (usually a method) in isolation to verify that it works correctly.

A unit can be:

- A Method
- A Service Class
- A Utility Class
- A Component

> **In simple words:**
>
> Unit Testing checks whether a single piece of your code works as expected.

---

# Why Do We Need Unit Testing?

Suppose you have a method:

```java
public int add(int a, int b) {
    return a + b;
}
```

How do you know it always works?

Instead of manually testing every time,

we write a Unit Test.

```
Method

↓

Input

↓

Expected Output

↓

Pass or Fail
```

---

# Real-World Example

Imagine a car factory.

Before assembling the whole car,

every individual part is tested.

```
Engine

↓

Test

↓

Pass
```

```
Brake

↓

Test

↓

Pass
```

Only after every unit passes,

the complete car is assembled.

Similarly,

we test individual methods before testing the entire application.

---

# Why is Unit Testing Important?

Without Unit Testing

```
Write Code

↓

Deploy

↓

Bug Found

↓

Production Issue
```

With Unit Testing

```
Write Code

↓

Write Test

↓

Run Test

↓

Bug Found Early

↓

Fix

↓

Deploy
```

---

# What is a Unit?

Example

```java
public class Calculator {

    public int multiply(int a, int b) {

        return a * b;

    }

}
```

The method

```
multiply()
```

is one unit.

---

# Unit Testing Flow

```
Developer

↓

Write Method

↓

Write Test Case

↓

Run Test

↓

Pass?

↓

Yes

↓

Commit Code

OR

↓

Fix Code

↓

Run Again
```

---

# Example Without Unit Testing

```java
public int divide(int a, int b) {

    return a / b;

}
```

Possible issue

```
divide(10,0)

↓

ArithmeticException
```

Without tests,

this bug may reach production.

---

# Example With Unit Testing

Test Cases

```
add(2,3)

↓

5

✓
```

```
multiply(4,5)

↓

20

✓
```

```
divide(10,2)

↓

5

✓
```

---

# Unit Test Architecture

```
Application

│

├── Controller

├── Service

├── Repository

└── Utility

            │

            ▼

      Unit Test

            │

            ▼

     Verify Output
```

---

# Unit Testing in Spring Boot

Spring Boot commonly uses:

- JUnit 5
- Mockito
- Spring Boot Test

These tools help test individual components efficiently.

---

# Example Service

```java
@Service
public class CalculatorService {

    public int add(int a, int b) {

        return a + b;

    }

}
```

---

# Unit Test Example

```java
class CalculatorServiceTest {

    @Test
    void testAdd() {

        CalculatorService service =

                new CalculatorService();

        int result = service.add(10, 20);

        assertEquals(30, result);

    }

}
```

Flow

```
Call Method

↓

Receive Result

↓

Compare

↓

Expected Value

↓

Pass
```

---

# What is Assertion?

An **Assertion** verifies that the actual result matches the expected result.

Example

```java
assertEquals(10, result);
```

Meaning

```
Expected

↓

10
```

```
Actual

↓

result
```

If both are equal,

the test passes.

---

# Common Assertions

| Assertion | Purpose |
|------------|----------|
| `assertEquals()` | Compare values |
| `assertTrue()` | Check true condition |
| `assertFalse()` | Check false condition |
| `assertNull()` | Verify null |
| `assertNotNull()` | Verify not null |
| `assertThrows()` | Verify exception |

---

# Test Execution Flow

```
Run Tests

↓

JUnit

↓

Execute Test

↓

Assertion

↓

Pass?

↓

Yes

↓

Green

OR

↓

Red

↓

Fix Code
```

---

# Good Unit Test Characteristics

A good unit test should be:

- Fast
- Independent
- Repeatable
- Easy to read
- Focused on one behavior

---

# Unit Testing vs Manual Testing

| Unit Testing | Manual Testing |
|--------------|----------------|
| Automated | Performed by humans |
| Fast | Slow |
| Repeatable | Repetitive |
| Runs with every build | Requires manual effort |
| Detects bugs early | Bugs found later |

---

# Unit Testing vs Integration Testing

| Unit Testing | Integration Testing |
|--------------|---------------------|
| Tests one class or method | Tests multiple components together |
| Uses mocks if required | Uses actual components |
| Very fast | Slower |
| No database required | May require a database |

---

# Test Pyramid

```
            UI Tests
           (Few)

              ▲

      Integration Tests

              ▲

        Unit Tests
        (Most Tests)
```

Most tests in a project should be **Unit Tests** because they are fast and inexpensive.

---

# Common Mistakes

❌ Testing multiple classes in one unit test.

❌ Accessing a real database.

❌ Calling external APIs.

❌ Depending on execution order.

❌ Writing one huge test for many scenarios.

---

# Real-World Example

## Banking Application

```
calculateInterest()

↓

Unit Test

↓

Correct Interest

↓

Pass
```

---

## E-Commerce Website

```
calculateDiscount()

↓

Unit Test

↓

Correct Discount

↓

Pass
```

---

## Food Delivery App

```
calculateDeliveryCharge()

↓

Unit Test

↓

Correct Charge

↓

Pass
```

---

# Advantages

- Detects bugs early.
- Improves code quality.
- Makes refactoring safer.
- Increases developer confidence.
- Supports Continuous Integration (CI).
- Reduces debugging time.

---

# Best Practices

- Test one method at a time.
- Use meaningful test method names.
- Keep tests independent.
- Cover both positive and negative scenarios.
- Do not access databases or external APIs in unit tests.
- Use mocks for dependencies.
- Run tests frequently.

---

# Interview Questions

### 1. What is Unit Testing?

Unit Testing is the process of testing an individual unit (usually a method or class) in isolation.

---

### 2. What is a unit?

A unit is the smallest testable part of an application, typically a single method or class.

---

### 3. Which tools are commonly used for Unit Testing in Spring Boot?

- JUnit 5
- Mockito
- Spring Boot Test

---

### 4. What is an Assertion?

An Assertion verifies that the actual output matches the expected output.

---

### 5. Why should Unit Tests not access a real database?

Because Unit Tests should test only one unit of code in isolation. External systems make tests slower and less reliable.

---

### 6. What is the difference between Unit Testing and Integration Testing?

Unit Testing verifies a single component in isolation, while Integration Testing verifies how multiple components work together.

---

### 7. What are the characteristics of a good Unit Test?

A good Unit Test is fast, independent, repeatable, easy to understand, and focused on a single behavior.

---

# Quick Revision

- Unit Testing verifies individual methods or classes.
- It helps detect bugs early in development.
- Spring Boot commonly uses JUnit 5 and Mockito.
- Assertions compare expected and actual results.
- Unit Tests should be fast, isolated, and repeatable.
- Avoid real databases and external services in Unit Tests.
- Write small, focused test cases.
- Most tests in a project should be Unit Tests.