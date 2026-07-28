# Custom Validation

## What is Custom Validation?

**Custom Validation** allows us to create our own validation rules when the built-in validation annotations are not sufficient.

Spring Boot provides annotations like:

- `@NotNull`
- `@Email`
- `@Size`

But sometimes we need business-specific validations, such as:

- Employee ID must start with **EMP**
- Password must contain at least one uppercase letter, one number, and one special character
- Age must be between 18 and 60
- Product code must follow a company-specific format

In these cases, we create a **Custom Validation Annotation**.

> **In simple words:**
>
> Custom Validation allows you to create your own validation annotations for business rules.

---

# Why Do We Need Custom Validation?

Suppose a company has employee IDs like:

```
EMP1001
EMP1002
EMP1050
```

A user submits:

```
ABC1234
```

Built-in annotations cannot validate this format.

So we create:

```java
@ValidEmployeeId
```

Now Spring Boot validates it automatically.

---

# How Custom Validation Works

```
Client

↓

@RequestBody

↓

@Valid

↓

@ValidEmployeeId

↓

ConstraintValidator

↓

Valid?

↓

Yes → Controller

No → Validation Exception
```

---

# Components of Custom Validation

A custom validation consists of:

1. Custom Annotation
2. Constraint Validator
3. DTO using the annotation
4. `@Valid` in Controller

---

# Step 1: Create Custom Annotation

```java
@Target(ElementType.FIELD)

@Retention(RetentionPolicy.RUNTIME)

@Constraint(validatedBy = EmployeeIdValidator.class)

public @interface ValidEmployeeId {

    String message() default "Invalid Employee ID";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

}
```

### Explanation

- `@Target` → Where the annotation can be used.
- `@Retention` → Keeps the annotation available at runtime.
- `@Constraint` → Connects the annotation with its validator class.

---

# Step 2: Create Validator Class

```java
public class EmployeeIdValidator
        implements ConstraintValidator<
            ValidEmployeeId,
            String> {

    @Override
    public boolean isValid(
            String value,
            ConstraintValidatorContext context) {

        if (value == null) {
            return false;
        }

        return value.startsWith("EMP");
    }

}
```

This validator checks whether the employee ID starts with `"EMP"`.

---

# Step 3: Use the Annotation

```java
public class EmployeeDTO {

    @ValidEmployeeId
    private String employeeId;

}
```

---

# Step 4: Trigger Validation

```java
@PostMapping("/employees")
public String createEmployee(

        @Valid
        @RequestBody
        EmployeeDTO dto

) {

    return "Employee Created";

}
```

Spring Boot automatically executes `EmployeeIdValidator`.

---

# Example Requests

## Valid Request

```json
{
    "employeeId": "EMP1001"
}
```

Output

```
Employee Created
```

---

## Invalid Request

```json
{
    "employeeId": "ABC123"
}
```

Output

```
400 Bad Request
```

---

# Validation Flow

```
JSON Request

↓

EmployeeDTO

↓

@ValidEmployeeId

↓

EmployeeIdValidator

↓

Validation Passed?

↓

Yes

↓

Controller

↓

Service

↓

Repository

↓

Database
```

---

# Example: Password Validation

Custom Annotation

```java
@ValidPassword
private String password;
```

Validator

```java
@Override
public boolean isValid(
        String password,
        ConstraintValidatorContext context) {

    if (password == null) {
        return false;
    }

    return password.matches(
        "^(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=]).{8,}$"
    );
}
```

Valid Password

```
Spring@123
```

Invalid Password

```
spring123
```

---

# Custom Validation Message

```java
@ValidEmployeeId(
    message = "Employee ID must start with EMP"
)
private String employeeId;
```

Returned Error

```json
{
    "message": "Employee ID must start with EMP"
}
```

---

# Multiple Custom Validations

```java
public class UserDTO {

    @ValidEmployeeId
    private String employeeId;

    @ValidPassword
    private String password;

}
```

Spring validates both fields automatically.

---

# Combining Built-in and Custom Validation

```java
public class EmployeeDTO {

    @NotBlank

    @ValidEmployeeId

    private String employeeId;

}
```

Both validations are applied.

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

@ValidEmployeeId

↓

ConstraintValidator

↓

Controller
```

---

# Real-World Examples

## Banking Application

Account Number

```java
@ValidAccountNumber
private String accountNumber;
```

Checks:

- Starts with BANK
- Correct length
- Valid format

---

## E-Commerce Application

Coupon Code

```java
@ValidCoupon
private String couponCode;
```

Checks:

- Valid format
- Not expired
- Company-specific rules

---

## University System

Student ID

```java
@ValidStudentId
private String studentId;
```

Checks:

- Starts with STU
- Correct length
- Valid department code

---

# Custom Validation vs Built-in Validation

| Built-in Validation | Custom Validation |
|---------------------|-------------------|
| Provided by Jakarta Validation | Created by developer |
| Generic rules | Business-specific rules |
| Examples: `@Email`, `@NotBlank` | Example: `@ValidEmployeeId` |
| No coding required | Requires custom annotation and validator |

---

# Advantages

- Supports business-specific validation rules
- Reusable across the application
- Keeps validation logic separate from business logic
- Improves code readability
- Easily integrates with Spring Boot

---

# Best Practices

- Use built-in annotations whenever possible.
- Create custom validation only for business-specific rules.
- Keep validator classes focused on a single responsibility.
- Provide meaningful error messages.
- Combine custom validation with `@Valid` and Global Exception Handling.

---

# Interview Questions

### 1. What is Custom Validation?

Custom Validation is used to create business-specific validation rules that are not available through built-in validation annotations.

---

### 2. Which interface is implemented to create a custom validator?

```java
ConstraintValidator
```

---

### 3. Which annotation connects a custom annotation with its validator?

```java
@Constraint
```

---

### 4. Can custom validation be used with built-in annotations?

Yes.

```java
@NotBlank
@ValidEmployeeId
private String employeeId;
```

---

### 5. When should you use Custom Validation?

Use it when built-in validation annotations cannot satisfy your application's business requirements.

---

# Quick Revision

- Custom Validation creates business-specific validation rules.
- It consists of a custom annotation and a `ConstraintValidator`.
- `@Constraint` links the annotation to the validator class.
- `@Valid` triggers custom validation during request processing.
- Custom validations can be combined with built-in validation annotations.
- Use custom validation for rules like employee IDs, coupon codes, account numbers, and password policies.