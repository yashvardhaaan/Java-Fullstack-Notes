# HTTP Client (Java 11)

## What is HTTP Client?

The **HTTP Client API** is a modern networking API introduced in **Java 11** for sending HTTP requests and receiving HTTP responses.

It replaces the older `HttpURLConnection` API with a cleaner, more powerful, and easier-to-use interface.

> **Definition:** The Java 11 HTTP Client is a built-in API used to communicate with web servers and REST APIs using HTTP and HTTPS.

---

# Why Do We Need HTTP Client?

Before Java 11, developers used

```java
HttpURLConnection
```

It required lots of boilerplate code.

Java 11 introduced

```java
HttpClient
```

which provides:

- Cleaner syntax
- Better readability
- HTTP/2 support
- Asynchronous requests
- WebSocket support

---

# Real-World Example

Imagine ordering food online.

```text
Customer

↓

Place Order

↓

Restaurant

↓

Prepare Food

↓

Deliver Food
```

Similarly,

```text
Java Application

↓

HTTP Request

↓

Web Server

↓

HTTP Response

↓

Application
```

---

# HTTP Client Components

The Java HTTP Client API has three main classes.

```text
HttpClient

↓

HttpRequest

↓

HttpResponse
```

---

# HttpClient

`HttpClient` sends HTTP requests.

Create a client

```java
HttpClient client =

HttpClient.newHttpClient();
```

Or using the Builder

```java
HttpClient client =

HttpClient.newBuilder()

.build();
```

---

# HttpRequest

Represents an HTTP request.

Example

```java
HttpRequest request =

HttpRequest.newBuilder()

.uri(

URI.create(

"https://jsonplaceholder.typicode.com/posts/1"

)

)

.GET()

.build();
```

---

# HttpResponse

Represents the server's response.

```java
HttpResponse<String> response =

client.send(

request,

HttpResponse.BodyHandlers.ofString()

);
```

---

# Sending a GET Request

```java
HttpClient client =

HttpClient.newHttpClient();

HttpRequest request =

HttpRequest.newBuilder()

.uri(

URI.create(

"https://jsonplaceholder.typicode.com/posts/1"

)

)

.GET()

.build();

HttpResponse<String> response =

client.send(

request,

HttpResponse.BodyHandlers.ofString()

);

System.out.println(

response.body()

);
```

---

# Sending a POST Request

```java
String json =

"""
{
    "name":"Yash"
}
""";

HttpRequest request =

HttpRequest.newBuilder()

.uri(

URI.create(

"https://example.com/users"

)

)

.header(

"Content-Type",

"application/json"

)

.POST(

HttpRequest.BodyPublishers

.ofString(json)

)

.build();
```

---

# PUT Request

```java
request =

HttpRequest.newBuilder()

.uri(

URI.create(

"https://example.com/users/1"

)

)

.PUT(

HttpRequest.BodyPublishers

.ofString(json)

)

.build();
```

---

# DELETE Request

```java
request =

HttpRequest.newBuilder()

.uri(

URI.create(

"https://example.com/users/1"

)

)

.DELETE()

.build();
```

---

# Reading Response

Status Code

```java
response.statusCode();
```

Body

```java
response.body();
```

Headers

```java
response.headers();
```

---

# Setting Headers

```java
HttpRequest request =

HttpRequest.newBuilder()

.header(

"Accept",

"application/json"

)

.header(

"Authorization",

"Bearer token"

)

.build();
```

---

# Setting Timeout

```java
HttpRequest request =

HttpRequest.newBuilder()

.timeout(

Duration.ofSeconds(5)

)

.build();
```

---

# Synchronous Request

Blocks until the response is received.

```java
HttpResponse<String> response =

client.send(

request,

HttpResponse.BodyHandlers.ofString()

);
```

```text
Application

↓

Wait

↓

Server Responds

↓

Continue
```

---

# Asynchronous Request

Returns immediately.

Uses

```java
CompletableFuture
```

```java
client.sendAsync(

request,

HttpResponse.BodyHandlers.ofString()

)

.thenApply(

HttpResponse::body

)

.thenAccept(

System.out::println

);
```

The application can perform other work while waiting for the response.

---

# HTTP Methods

| Method | Purpose |
|---------|----------|
| GET | Read data |
| POST | Create data |
| PUT | Update entire resource |
| PATCH | Partially update resource *(can be used via `.method("PATCH", ...)` since there is no dedicated `.PATCH()` builder method)* |
| DELETE | Delete data |

---

# Body Handlers

Common Body Handlers

```java
BodyHandlers.ofString()
```

Returns

```java
String
```

---

```java
BodyHandlers.ofFile(path)
```

Downloads directly to a file.

---

```java
BodyHandlers.ofByteArray()
```

Returns

```java
byte[]
```

---

# Internal Working

Suppose

```text
GET /users
```

Internally

```text
Java Application

↓

HttpClient

↓

HttpRequest

↓

TCP Connection

↓

HTTP Request

↓

Web Server

↓

HTTP Response

↓

HttpResponse

↓

Application
```

---

# HTTP Client vs HttpURLConnection

| HttpClient | HttpURLConnection |
|-------------|-------------------|
| Java 11 | Java 1.1 |
| Cleaner API | Verbose |
| HTTP/2 support | HTTP/1.1 |
| Async support | Limited |
| Builder Pattern | Traditional API |
| Easier to use | More boilerplate |

---

# Production Usage

The Java 11 HTTP Client is used for:

- Calling REST APIs
- Microservices communication
- Payment Gateway Integration
- Weather APIs
- Authentication Services
- Third-party APIs

Example

```text
Spring Boot Service

↓

HttpClient

↓

Payment API

↓

JSON Response
```

Although Spring Boot applications often use **RestTemplate** (legacy) or **WebClient**, the Java 11 `HttpClient` is an excellent choice for standard Java applications and many backend integrations.

---

# Advantages

- Modern API
- HTTP/2 support
- Asynchronous requests
- Better performance
- Easy Builder pattern
- Built into Java

---

# Limitations

- Requires Java 11 or newer
- Spring projects often prefer `WebClient` for reactive applications
- More configuration may be needed for advanced scenarios (proxies, SSL customization)

---

# Best Practices

✅ Reuse `HttpClient` instances instead of creating one per request.

✅ Set connection and request timeouts.

✅ Check the HTTP status code before processing the response.

✅ Use asynchronous requests for long-running network calls when appropriate.

---

# Common Mistakes

❌ Creating a new `HttpClient` for every request.

---

❌ Ignoring response status codes.

---

❌ Forgetting timeouts.

---

❌ Blocking unnecessarily when asynchronous requests would be more appropriate.

---

# Interview Questions

### 1. What is HttpClient?

A modern Java 11 API for sending HTTP requests and receiving HTTP responses.

---

### 2. Which package contains HttpClient?

```java
java.net.http
```

---

### 3. What are the three main classes?

- HttpClient
- HttpRequest
- HttpResponse

---

### 4. How do you create an HttpClient?

```java
HttpClient client =

HttpClient.newHttpClient();
```

---

### 5. What is the difference between `send()` and `sendAsync()`?

- `send()` is synchronous and blocks the current thread.
- `sendAsync()` is asynchronous and returns a `CompletableFuture`.

---

### 6. Does HttpClient support HTTP/2?

Yes.

It supports both HTTP/1.1 and HTTP/2.

---

### 7. Which class represents the HTTP response?

```java
HttpResponse
```

---

### 8. Which body handler returns a String?

```java
HttpResponse.BodyHandlers.ofString()
```

---

### 9. Where is HttpClient used in Spring Boot?

It can be used to call external REST APIs and microservices. However, Spring applications commonly use **WebClient** (recommended) or **RestTemplate** (legacy) depending on the project.

---

### 10. Why is HttpClient preferred over HttpURLConnection?

Because it has a cleaner API, supports HTTP/2, asynchronous programming, and is easier to use.

---

# Quick Revision

- Java 11 Networking API.
- Main classes:
  - HttpClient
  - HttpRequest
  - HttpResponse
- Supports:
  - GET
  - POST
  - PUT
  - PATCH
  - DELETE
- `send()` → Synchronous.
- `sendAsync()` → Asynchronous (`CompletableFuture`).
- Supports HTTP/2.
- Preferred over `HttpURLConnection`.

---

# Keywords

- HttpClient
- HttpRequest
- HttpResponse
- BodyHandler
- GET
- POST
- PUT
- PATCH
- DELETE
- HTTP/2
- CompletableFuture
- Async
- REST API
- Java 11
- java.net.http