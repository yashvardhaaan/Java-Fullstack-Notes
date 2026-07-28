# `@Valid` Annotation

## What is `@Valid`?

`@Valid` is a validation annotation provided by **Jakarta Bean Validation**.

It tells Spring Boot to **validate an object before executing the controller method**.

If any validation rule fails, Spring Boot automatically throws a validation exception and returns an error response.

> **In simple words:**
>
> `@Valid` tells Spring Boot:
> **"Before processing this object, make sure all validation rules are satisfied."**

---

# Why Do We Need `@Valid`?

Suppose a client sends this request.

```json
{
    "name": "",
    "email": "abc",
    "age": 15
}
```

Without `@Valid`, Spring Boot accepts the request and executes the controller.

With `@Valid`, Spring Boot validates the request first.

If validation fails:

- Controller method is not executed.
- An exception is thrown.
- A **400 Bad Request** response is returned.

---

# How `@Valid` Works

```
Client

↓

JSON Request

↓

@RequestBody

↓

@Valid

↓

Bean Validation

↓

Valid?

↓

Yes → Controller Method

↓

Business Logic

↓

Database

OR

No

↓

MethodArgumentNotValidException

↓

400 Bad Request
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

# Using `@Valid`

```java
@RestController
@RequestMapping("/users")
public class UserController {

    @PostMapping
    public String createUser(

            @Valid
            @RequestBody
            UserDTO user

    ) {

        return "User Created";
    }

}
```

Spring Boot validates `UserDTO` automatically before entering the method.

---

# Valid Request

```json
{
    "name": "John",
    "email": "john@gmail.com",
    "age": 25
}
```

Output

```
User Created
```

---

# Invalid Request

```json
{
    "name": "",
    "email": "abc",
    "age": 10
}
```

Output

```
400 Bad Request
```

The controller method is never executed.

---

# Validation Flow

```
Client

↓

POST Request

↓

@RequestBody

↓

@Valid

↓

@NotBlank

↓

@Email

↓

@Min

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

# What Happens When Validation Fails?

Spring Boot throws:

```text
MethodArgumentNotValidException
```

Example

```java
@PostMapping
public String createUser(

        @Valid
        @RequestBody
        UserDTO user

) {

    return "Success";

}
```

Invalid Request

```json
{
    "name": ""
}
```

Spring Boot automatically throws

```
MethodArgumentNotValidException
```

---

# Custom Error Handling

Using Global Exception Handling

```java
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(
        MethodArgumentNotValidException.class
    )
    public String handleValidationException() {

        return "Validation Failed";

    }

}
```

Now custom responses can be returned instead of the default error.

---

# Nested Object Validation

Suppose a User contains an Address.

AddressDTO

```java
public class AddressDTO {

    @NotBlank
    private String city;

}
```

UserDTO

```java
public class UserDTO {

    @NotBlank
    private String name;

    @Valid
    private AddressDTO address;

}
```

Now Spring validates:

- UserDTO
- AddressDTO

Both objects are validated automatically.

---

# Validation on Collections

```java
public class OrderDTO {

    @Valid
    private List<ProductDTO> products;

}
```

Every product inside the list is validated.

---

# `@Valid` with `@RequestBody`

Most common usage.

```java
@PostMapping
public ResponseEntity<User> save(

        @Valid
        @RequestBody
        UserDTO dto

) {

}
```

---

# `@Valid` with `@ModelAttribute`

```java
@PostMapping
public String register(

        @Valid
        @ModelAttribute
        UserDTO user

) {

}
```

Useful for HTML form submissions.

---

# `@Valid` with `@PathVariable`

`@Valid` is generally **not used** directly with `@PathVariable`.

Instead, use validation annotations like:

```java
@GetMapping("/{id}")
public User getUser(

        @Positive
        @PathVariable
        Long id

) {

}
```

---

# `@Valid` with `@RequestParam`

```java
@GetMapping
public User search(

        @Positive
        @RequestParam
        Long id

) {

}
```

---

# `@Valid` vs `@Validated`

| `@Valid` | `@Validated` |
|-----------|--------------|
| Standard Jakarta Bean Validation annotation | Spring Framework annotation |
| Validates the entire object | Supports validation groups |
| Most commonly used for DTO validation | Used for advanced validation scenarios |
| Supports nested validation | Supports nested validation and groups |

For most Spring Boot applications, `@Valid` is sufficient.

---

# Request Processing Flow

```
Client

↓

@RequestBody

↓

JSON → Java Object

↓

@Valid

↓

Validation Rules

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

# Real-World Example

### Banking Application

Account Creation

```java
public class AccountDTO {

    @NotBlank
    private String customerName;

    @Email
    private String email;

    @Positive
    private double initialDeposit;

}
```

Controller

```java
@PostMapping("/accounts")
public void create(

        @Valid
        @RequestBody
        AccountDTO dto

) {

}
```

---

### E-Commerce Application

Product

```java
public class ProductDTO {

    @NotBlank
    private String name;

    @Positive
    private double price;

}
```

Spring validates every product before saving it.

---

# Advantages

- Automatic validation
- Reduces manual code
- Improves code readability
- Prevents invalid data
- Works seamlessly with Spring Boot
- Supports nested object validation

---

# Best Practices

- Always place `@Valid` before `@RequestBody`.
- Validate DTOs instead of JPA entities.
- Use Global Exception Handling for validation errors.
- Combine `@Valid` with Bean Validation annotations.
- Use `@Validated` only when validation groups are required.

---

# Interview Questions

### 1. What is `@Valid`?

`@Valid` tells Spring Boot to validate an object before executing the controller method.

---

### 2. Which exception is thrown when validation fails?

```text
MethodArgumentNotValidException
```

---

### 3. Can `@Valid` validate nested objects?

Yes.

Use:

```java
@Valid
private AddressDTO address;
```

---

### 4. What is the difference between `@Valid` and `@Validated`?

- `@Valid` is the standard Jakarta Bean Validation annotation.
- `@Validated` is a Spring annotation that also supports validation groups.

---

### 5. Where is `@Valid` most commonly used?

```java
@Valid
@RequestBody
UserDTO dto
```

---

# Quick Revision

- `@Valid` triggers Bean Validation in Spring Boot.
- It validates objects before the controller method executes.
- Invalid requests throw `MethodArgumentNotValidException`.
- Works with `@RequestBody`, `@ModelAttribute`, nested objects, and collections.
- Use validation annotations like `@NotBlank`, `@Email`, and `@Min` with `@Valid`.
- Use `@Validated` for advanced scenarios such as validation groups.