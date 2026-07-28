# MockMvc

## What is MockMvc?

**MockMvc** is a testing framework provided by Spring that allows you to test **Spring MVC Controllers and REST APIs** without starting a real web server.

It simulates HTTP requests like:

- GET
- POST
- PUT
- DELETE

and verifies the responses.

> **In simple words:**
>
> MockMvc lets you test your REST APIs as if a real client is calling them, but without running the application on a server.

---

# Why Do We Need MockMvc?

Suppose you have a REST API:

```http
GET /users
```

Instead of opening:

- Browser
- Postman
- Swagger

every time,

MockMvc can call the API automatically.

```
Test

↓

GET Request

↓

Controller

↓

Response

↓

Pass or Fail
```

---

# Real-World Example

Imagine testing a restaurant.

Instead of inviting real customers,

the owner hires test customers.

```
Test Customer

↓

Place Order

↓

Check Food

↓

Report Result
```

Similarly,

MockMvc acts like a fake client that sends HTTP requests to your application.

---

# Why Not Use Postman?

Postman is useful for **manual testing**.

```
Developer

↓

Postman

↓

Manual Check
```

Problems

- Slow
- Manual
- Cannot run automatically

MockMvc

```
JUnit

↓

MockMvc

↓

Automatic Testing

↓

Fast
```

---

# Where Does MockMvc Work?

```
Client

↓

HTTP Request

↓

Controller

↓

Service

↓

Repository

↓

Database
```

MockMvc mainly tests the

```
Controller Layer
```

---

# MockMvc Architecture

```
JUnit Test

↓

MockMvc

↓

Controller

↓

Service

↓

Mock Repository

↓

Response
```

No real server is started.

---

# Spring Boot Dependency

MockMvc is included in

```xml
spring-boot-starter-test
```

No extra dependency is required.

---

# Sample Controller

```java
@RestController
@RequestMapping("/users")
public class UserController {

    @GetMapping
    public String getUsers() {

        return "All Users";

    }

}
```

---

# Writing a MockMvc Test

```java
@WebMvcTest(UserController.class)
class UserControllerTest {

    @Autowired
    private MockMvc mockMvc;

}
```

Flow

```
Spring Boot

↓

Create Controller

↓

Inject MockMvc

↓

Ready for Testing
```

---

# Testing GET Request

```java
@Test
void testGetUsers() throws Exception {

    mockMvc.perform(

            get("/users")

    )

    .andExpect(status().isOk())

    .andExpect(content()

            .string("All Users"));

}
```

Flow

```
GET /users

↓

Controller

↓

HTTP 200

↓

Response Verified
```

---

# Testing POST Request

Controller

```java
@PostMapping
public String createUser() {

    return "User Created";

}
```

Test

```java
@Test
void testCreateUser() throws Exception {

    mockMvc.perform(

            post("/users")

    )

    .andExpect(status().isOk())

    .andExpect(content()

            .string("User Created"));

}
```

---

# Testing Path Variables

Controller

```java
@GetMapping("/{id}")
public String getUser(

        @PathVariable int id

){

    return "User " + id;

}
```

Test

```java
mockMvc.perform(

        get("/users/10")

)

.andExpect(status().isOk())

.andExpect(content()

        .string("User 10"));
```

---

# Testing Request Parameters

Controller

```java
@GetMapping("/search")
public String search(

        @RequestParam String name

){

    return name;

}
```

Test

```java
mockMvc.perform(

        get("/users/search")

        .param("name","Yash")

)

.andExpect(status().isOk())

.andExpect(content()

        .string("Yash"));
```

---

# Testing JSON Response

Controller

```java
@GetMapping
public User getUser() {

    return new User(

            1,

            "Yash"

    );

}
```

Test

```java
mockMvc.perform(

        get("/users")

)

.andExpect(status().isOk())

.andExpect(

        jsonPath("$.id")

        .value(1)

)

.andExpect(

        jsonPath("$.name")

        .value("Yash")

);
```

---

# Testing POST with JSON

```java
String json = """

{

"name":"Yash"

}

""";
```

```java
mockMvc.perform(

        post("/users")

        .contentType(

                MediaType.APPLICATION_JSON

        )

        .content(json)

)

.andExpect(status().isOk());
```

---

# Testing Response Headers

```java
mockMvc.perform(

        get("/users")

)

.andExpect(

        header()

        .exists("Content-Type")

);
```

---

# Testing HTTP Status Codes

```java
.andExpect(status().isOk())
```

Other examples

```java
status().isCreated()

status().isBadRequest()

status().isUnauthorized()

status().isForbidden()

status().isNotFound()
```

---

# MockMvc Request Flow

```
JUnit

↓

MockMvc

↓

HTTP Request

↓

Controller

↓

Service

↓

Response

↓

Assertions
```

---

# Common MockMvc Methods

| Method | Purpose |
|---------|----------|
| `perform()` | Send HTTP request |
| `andExpect()` | Verify response |
| `status()` | Verify HTTP status |
| `content()` | Verify response body |
| `jsonPath()` | Verify JSON values |
| `header()` | Verify response headers |

---

# @WebMvcTest

```java
@WebMvcTest(UserController.class)
```

Purpose

- Loads only the Controller layer.
- Does not load the entire Spring Boot application.
- Faster than loading the full application.

---

# @MockBean

If the controller depends on a service,

replace it with a mock.

```java
@MockBean
private UserService service;
```

Flow

```
Controller

↓

Mock Service

↓

Fake Data

↓

Response
```

---

# MockMvc vs Postman

| MockMvc | Postman |
|----------|----------|
| Automated | Manual |
| Used in Unit Tests | Used for API testing |
| Runs with JUnit | Requires user interaction |
| Suitable for CI/CD | Not automated by default |

---

# MockMvc vs Integration Testing

| MockMvc | Integration Testing |
|----------|---------------------|
| Tests Controller layer | Tests complete application |
| No real server | May start application context |
| Faster | Slower |
| Uses mocked dependencies | Uses actual components |

---

# Common Mistakes

❌ Starting the full application for simple controller tests.

❌ Forgetting `@WebMvcTest`.

❌ Not mocking service dependencies.

❌ Verifying only status code and ignoring response content.

---

# Real-World Example

## Banking Application

```
GET /accounts

↓

MockMvc

↓

AccountController

↓

Response Verified
```

---

## E-Commerce Website

```
POST /products

↓

MockMvc

↓

ProductController

↓

Product Created
```

---

## Food Delivery App

```
GET /orders

↓

MockMvc

↓

OrderController

↓

JSON Response Verified
```

---

# Advantages

- Fast controller testing.
- No real web server required.
- Simulates HTTP requests.
- Supports JSON validation.
- Easy integration with JUnit and Mockito.
- Ideal for REST API testing.

---

# Best Practices

- Use `@WebMvcTest` for controller testing.
- Mock service dependencies using `@MockBean`.
- Verify both status codes and response bodies.
- Test success and failure scenarios.
- Keep controller tests focused on request handling.

---

# Interview Questions

### 1. What is MockMvc?

MockMvc is a Spring testing framework used to test controllers and REST APIs without starting a real web server.

---

### 2. What does `@WebMvcTest` do?

It loads only the Spring MVC components (such as controllers) required for testing, making tests faster.

---

### 3. Why is `@MockBean` used with MockMvc?

`@MockBean` replaces service dependencies with mock objects so that only the controller behavior is tested.

---

### 4. Can MockMvc test JSON responses?

Yes.

Using:

```java
jsonPath()
```

---

### 5. Does MockMvc start a real server?

No.

It simulates HTTP requests within the Spring Test framework.

---

### 6. What is the difference between MockMvc and Postman?

MockMvc is used for automated controller tests, while Postman is used for manual API testing.

---

### 7. Which method sends an HTTP request in MockMvc?

```java
perform()
```

---

# Quick Revision

- MockMvc tests Spring MVC controllers and REST APIs.
- It simulates HTTP requests without starting a real server.
- Use `@WebMvcTest` for controller-only tests.
- Use `@MockBean` to mock service dependencies.
- `perform()` sends requests.
- `andExpect()` verifies responses.
- `jsonPath()` validates JSON responses.
- MockMvc is fast, automated, and ideal for REST API controller testing.