# JUnit 5

## What is JUnit 5?

**JUnit 5** is the most popular testing framework for Java. It is used to write and execute **Unit Tests** for Java and Spring Boot applications.

It provides annotations, assertions, and testing utilities to verify that your code behaves correctly.

> **In simple words:**
>
> JUnit 5 is a tool that automatically checks whether your Java code is working correctly.

---

# Why Do We Need JUnit 5?

Suppose you have a method.

```java
public int square(int n) {

    return n * n;

}
```

Instead of manually checking:

```
square(5)

↓

25

✓
```

every time,

JUnit can test it automatically.

```
Write Code

↓

Write Test

↓

Run Test

↓

Pass or Fail
```

---

# Real-World Example

Imagine a teacher checking 500 exam papers.

Without automation

```
Teacher

↓

Check Every Paper

↓

Very Slow
```

With automation

```
Computer

↓

Check Every Paper

↓

Few Seconds
```

JUnit automatically checks your code the same way.

---

# JUnit 5 Architecture

```
JUnit 5

│

├── JUnit Platform

├── JUnit Jupiter

└── JUnit Vintage
```

---

## JUnit Platform

Responsible for running tests.

```
Run Test

↓

JUnit Platform

↓

Execute Tests
```

---

## JUnit Jupiter

Contains all JUnit 5 annotations and APIs.

Examples

```
@Test

@BeforeEach

@AfterEach
```

---

## JUnit Vintage

Allows older JUnit 3 and JUnit 4 tests to run.

---

# JUnit Test Flow

```
Developer

↓

Write Method

↓

Write Test

↓

JUnit

↓

Execute Test

↓

Assertion

↓

Pass or Fail
```

---

# Adding JUnit in Spring Boot

Spring Boot automatically includes JUnit through

```xml
spring-boot-starter-test
```

Example

```xml
<dependency>

    <groupId>

        org.springframework.boot

    </groupId>

    <artifactId>

        spring-boot-starter-test

    </artifactId>

    <scope>

        test

    </scope>

</dependency>
```

---

# Writing Your First Test

Application

```java
public class Calculator {

    public int add(int a, int b) {

        return a + b;

    }

}
```

JUnit Test

```java
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CalculatorTest {

    @Test
    void testAdd() {

        Calculator calculator =

                new Calculator();

        assertEquals(

                10,

                calculator.add(4,6)

        );

    }

}
```

---

# @Test Annotation

Marks a method as a test.

```java
@Test
void testAddition() {

}
```

Flow

```
JUnit

↓

Find @Test

↓

Execute Method
```

---

# Assertions

Assertions compare the expected and actual values.

Example

```java
assertEquals(20, result);
```

Meaning

```
Expected

↓

20
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
| `assertNotEquals()` | Compare unequal values |
| `assertTrue()` | Verify true |
| `assertFalse()` | Verify false |
| `assertNull()` | Verify null |
| `assertNotNull()` | Verify not null |
| `assertThrows()` | Verify exceptions |

---

# assertTrue()

```java
assertTrue(

        10 > 5

);
```

Passes because

```
10 > 5

↓

True
```

---

# assertFalse()

```java
assertFalse(

        5 > 10

);
```

Passes because

```
5 > 10

↓

False
```

---

# assertNull()

```java
String name = null;

assertNull(name);
```

---

# assertNotNull()

```java
String name = "Spring";

assertNotNull(name);
```

---

# assertThrows()

Suppose

```java
public int divide(

        int a,

        int b

){

    return a / b;

}
```

Test

```java
assertThrows(

        ArithmeticException.class,

        () -> calculator.divide(10,0)

);
```

Expected

```
10 / 0

↓

ArithmeticException

↓

Pass
```

---

# @BeforeEach

Runs before every test.

```java
@BeforeEach
void setup() {

    calculator = new Calculator();

}
```

Flow

```
@BeforeEach

↓

Create Object

↓

Run Test
```

---

# @AfterEach

Runs after every test.

```java
@AfterEach
void cleanup() {

}
```

Useful for releasing resources.

---

# @BeforeAll

Runs only once before all tests.

```java
@BeforeAll
static void init() {

}
```

---

# @AfterAll

Runs only once after all tests.

```java
@AfterAll
static void close() {

}
```

---

# Test Lifecycle

```
@BeforeAll

↓

@BeforeEach

↓

@Test

↓

@AfterEach

↓

Repeat

↓

@AfterAll
```

---

# Multiple Test Methods

```java
@Test
void testAdd(){

}

@Test
void testSubtract(){

}

@Test
void testMultiply(){

}
```

JUnit runs each test independently.

---

# Display Name

```java
@DisplayName(

        "Addition Test"

)
@Test
void testAdd(){

}
```

Makes test reports more readable.

---

# Disabled Test

```java
@Disabled

@Test
void testDatabase(){

}
```

JUnit skips this test.

---

# Test Execution Flow

```
Run Tests

↓

JUnit Platform

↓

@BeforeEach

↓

@Test

↓

Assertion

↓

Pass

↓

@AfterEach
```

---

# JUnit 5 vs JUnit 4

| JUnit 5 | JUnit 4 |
|----------|----------|
| `@BeforeEach` | `@Before` |
| `@AfterEach` | `@After` |
| `@BeforeAll` | `@BeforeClass` |
| `@AfterAll` | `@AfterClass` |
| Modern architecture | Older architecture |

---

# Real-World Example

## Banking Application

```
calculateInterest()

↓

JUnit Test

↓

Correct Value

↓

Pass
```

---

## E-Commerce Website

```
calculateDiscount()

↓

JUnit Test

↓

Correct Discount

↓

Pass
```

---

## Food Delivery Application

```
calculateDeliveryFee()

↓

JUnit Test

↓

Correct Fee

↓

Pass
```

---

# Advantages

- Easy to write tests.
- Automatically executes tests.
- Detects bugs early.
- Supports assertions.
- Integrates with Spring Boot.
- Works well with CI/CD pipelines.

---

# Best Practices

- Keep one behavior per test.
- Use meaningful test names.
- Use `@BeforeEach` for common setup.
- Write both positive and negative test cases.
- Keep tests independent.
- Avoid sharing state between tests.
- Run tests frequently during development.

---

# Interview Questions

### 1. What is JUnit 5?

JUnit 5 is a Java testing framework used to write and execute unit tests.

---

### 2. Which annotation marks a test method?

```java
@Test
```

---

### 3. What is the purpose of `assertEquals()`?

It verifies that the expected value matches the actual value.

---

### 4. What is the difference between `@BeforeEach` and `@BeforeAll`?

- `@BeforeEach` runs before every test method.
- `@BeforeAll` runs only once before all test methods.

---

### 5. Which assertion verifies that an exception is thrown?

```java
assertThrows()
```

---

### 6. What is the purpose of `@Disabled`?

It skips the execution of a test method.

---

### 7. Does Spring Boot include JUnit automatically?

Yes.

The `spring-boot-starter-test` dependency includes JUnit 5 by default.

---

# Quick Revision

- JUnit 5 is the standard testing framework for Java and Spring Boot.
- Use `@Test` to mark test methods.
- Assertions verify expected results.
- `@BeforeEach` and `@AfterEach` run before and after every test.
- `@BeforeAll` and `@AfterAll` run once for the entire test class.
- `assertThrows()` verifies exceptions.
- Spring Boot includes JUnit through `spring-boot-starter-test`.
- JUnit helps automate testing and improves code quality.