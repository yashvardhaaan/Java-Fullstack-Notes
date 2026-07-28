# Validation Annotations

## What are Validation Annotations?

**Validation Annotations** are predefined annotations provided by **Jakarta Bean Validation** that are used to validate object fields automatically.

Instead of writing validation logic manually, we simply place annotations on fields.

Spring Boot validates the object before executing the controller method.

> **In simple words:**
>
> Validation annotations define the rules that input data must follow.

---

# Why Do We Need Validation Annotations?

Suppose a registration form contains:

- Name
- Email
- Password
- Age

Without validation, users could submit:

- Empty name
- Invalid email
- Negative age
- Blank password

Validation annotations prevent such invalid data from entering the application.

---

# How Validation Works

```
Client

↓

JSON Request

↓

Spring Boot

↓

@Valid

↓

Validation Annotations

↓

Validation Passed?

↓

Yes → Controller

No → 400 Bad Request
```

---

# Example DTO

```java
public class UserDTO {

    @NotBlank
    private String name;

    @Email
    private String email;

    @Min(18)
    private int age;

}
```

---

# Common Validation Annotations

## 1. `@NotNull`

Checks that the value is **not null**.

```java
@NotNull
private String name;
```

Valid

```text
"John"
```

Invalid

```text
null
```

---

## 2. `@NotEmpty`

Checks that the value is:

- Not null
- Not empty

Works with:

- String
- List
- Set
- Map
- Arrays

```java
@NotEmpty
private String name;
```

Valid

```text
"John"
```

Invalid

```text
""
```

```text
null
```

---

## 3. `@NotBlank`

Checks that the string is:

- Not null
- Not empty
- Not only whitespace

```java
@NotBlank
private String name;
```

Valid

```text
"John"
```

Invalid

```text
""
```

```text
"     "
```

```text
null
```

---

# Difference

| Annotation | Null | Empty | Spaces |
|------------|------|--------|--------|
| `@NotNull` | ❌ | ✅ | ✅ |
| `@NotEmpty` | ❌ | ❌ | ✅ |
| `@NotBlank` | ❌ | ❌ | ❌ |

---

## 4. `@Email`

Validates email format.

```java
@Email
private String email;
```

Valid

```text
john@gmail.com
```

Invalid

```text
johngmail.com
```

---

## 5. `@Size`

Checks minimum and maximum length.

```java
@Size(min = 3, max = 20)
private String username;
```

Valid

```
John
```

Invalid

```
Jo
```

```
ThisUsernameIsTooLong
```

---

## 6. `@Min`

Checks minimum numeric value.

```java
@Min(18)
private int age;
```

Valid

```
20
```

Invalid

```
15
```

---

## 7. `@Max`

Checks maximum numeric value.

```java
@Max(60)
private int age;
```

Valid

```
35
```

Invalid

```
75
```

---

## 8. `@Positive`

Value must be greater than zero.

```java
@Positive
private int salary;
```

Valid

```
5000
```

Invalid

```
0
```

```
-5
```

---

## 9. `@PositiveOrZero`

```java
@PositiveOrZero
private int quantity;
```

Valid

```
0
```

```
25
```

Invalid

```
-1
```

---

## 10. `@Negative`

```java
@Negative
private int temperature;
```

Valid

```
-5
```

Invalid

```
0
```

```
10
```

---

## 11. `@NegativeOrZero`

```java
@NegativeOrZero
private int balance;
```

Valid

```
0
```

```
-50
```

Invalid

```
10
```

---

## 12. `@Pattern`

Validates using Regular Expressions.

```java
@Pattern(
    regexp = "[A-Z][a-z]+"
)
private String firstName;
```

Valid

```
John
```

Invalid

```
john
```

---

## 13. `@Past`

Date must be in the past.

```java
@Past
private LocalDate dob;
```

Valid

```
2000-10-12
```

Invalid

```
2035-01-01
```

---

## 14. `@Future`

Date must be in the future.

```java
@Future
private LocalDate interviewDate;
```

Valid

```
2030-06-01
```

Invalid

```
2025-01-01
```

---

## 15. `@PastOrPresent`

```java
@PastOrPresent
private LocalDate joiningDate;
```

---

## 16. `@FutureOrPresent`

```java
@FutureOrPresent
private LocalDate bookingDate;
```

---

# Using Custom Messages

```java
@NotBlank(message = "Name cannot be blank")
private String name;
```

```java
@Email(message = "Invalid email format")
private String email;
```

```java
@Min(
    value = 18,
    message = "Age must be at least 18"
)
private int age;
```

---

# Multiple Validations

```java
@NotBlank
@Size(min = 3, max = 20)
private String username;
```

The field must satisfy both validations.

---

# Complete Example

```java
public class UserDTO {

    @NotBlank(message = "Name is required")
    private String name;

    @Email(message = "Invalid Email")
    private String email;

    @Size(min = 8, max = 20)
    private String password;

    @Min(18)
    private int age;

}
```

---

# Request Flow

```
Client

↓

@RequestBody

↓

@Valid

↓

@NotBlank

↓

@Email

↓

@Size

↓

Validation Passed?

↓

Yes → Controller

No → Exception
```

---

# Real-World Example

### Banking Application

Customer Registration

```java
@NotBlank
private String customerName;

@Email
private String email;

@Positive
private double balance;
```

---

### E-Commerce Application

Product

```java
@NotBlank
private String productName;

@Positive
private double price;

@PositiveOrZero
private int quantity;
```

---

### Student Management System

```java
@NotBlank
private String name;

@Email
private String email;

@Min(18)
private int age;
```

---

# Advantages

- Eliminates manual validation
- Easy to read
- Reusable
- Standard Java validation
- Integrates with Spring Boot
- Improves code quality

---

# Best Practices

- Use DTOs for validation instead of entities.
- Provide meaningful validation messages.
- Use `@NotBlank` for text fields instead of `@NotNull`.
- Combine multiple annotations when required.
- Handle validation errors using Global Exception Handling.

---

# Interview Questions

### 1. What are Validation Annotations?

Validation annotations define rules that input data must satisfy before processing.

---

### 2. What is the difference between `@NotNull`, `@NotEmpty`, and `@NotBlank`?

- `@NotNull` → Value cannot be null.
- `@NotEmpty` → Value cannot be null or empty.
- `@NotBlank` → Value cannot be null, empty, or only whitespace.

---

### 3. Which annotation validates email addresses?

```java
@Email
```

---

### 4. Which annotation validates a regular expression?

```java
@Pattern
```

---

### 5. How do you define a custom validation message?

```java
@NotBlank(message = "Name is required")
```

---

# Quick Revision

- Validation annotations define validation rules for fields.
- `@NotNull` → Not null.
- `@NotEmpty` → Not null and not empty.
- `@NotBlank` → Not null, not empty, and not only whitespace.
- `@Email` validates email format.
- `@Size` validates length.
- `@Min` and `@Max` validate numeric ranges.
- `@Positive` and `@Negative` validate number signs.
- `@Pattern` validates using regular expressions.
- Use custom messages for better error responses.