# @Controller

## What is `@Controller`?

`@Controller` is a Spring annotation used to create **Spring MVC Controllers** that handle HTTP requests and return **views** (HTML, JSP, Thymeleaf, etc.).

It is mainly used for **web applications** where the server renders web pages.

> **In simple words:**
>
> `@Controller` tells Spring:
> **"This class handles web requests and returns a webpage."**

---

# Why Do We Need `@Controller`?

Suppose a user opens:

```
http://localhost:8080/home
```

Instead of returning JSON, the application should display:

```
home.html
```

This is the job of `@Controller`.

---

# Syntax

```java
@Controller
public class HomeController {

}
```

Spring registers this class as a web controller.

---

# How `@Controller` Works

```
Browser

↓

HTTP Request

↓

@Controller

↓

Business Logic

↓

View Name

↓

View Resolver

↓

HTML Page

↓

Browser
```

---

# Example

```java
@Controller
public class HomeController {

    @GetMapping("/home")
    public String home() {

        return "home";

    }

}
```

If the project uses Thymeleaf:

```
src/main/resources/templates/home.html
```

Spring returns:

```
home.html
```

to the browser.

---

# Returning a View

Project Structure:

```
src
└── main
    └── resources
        └── templates
            ├── home.html
            ├── login.html
            └── about.html
```

Controller:

```java
@Controller
public class PageController {

    @GetMapping("/login")
    public String login() {

        return "login";

    }

}
```

Spring renders:

```
login.html
```

---

# Passing Data to the View

Use the `Model` object.

```java
@Controller
public class HomeController {

    @GetMapping("/home")
    public String home(Model model) {

        model.addAttribute("name", "John");

        return "home";

    }

}
```

In `home.html` (Thymeleaf):

```html
<h1 th:text="${name}"></h1>
```

Output:

```
John
```

---

# @Controller with @ResponseBody

Normally,

```java
@Controller
public class DemoController {

    @GetMapping("/hello")
    public String hello() {

        return "hello";

    }

}
```

Spring searches for:

```
hello.html
```

If you want to return text instead:

```java
@Controller
public class DemoController {

    @ResponseBody
    @GetMapping("/hello")
    public String hello() {

        return "Hello Spring";

    }

}
```

Response:

```
Hello Spring
```

---

# @Controller vs @RestController

| `@Controller` | `@RestController` |
|---------------|-------------------|
| Returns Views | Returns JSON/XML |
| Used for MVC Applications | Used for REST APIs |
| Requires `@ResponseBody` to return data | Includes `@ResponseBody` automatically |
| Works with Thymeleaf/JSP | Works with REST Clients |

---

# Internal Working

```
Client

↓

DispatcherServlet

↓

@Controller

↓

Return View Name

↓

View Resolver

↓

HTML Page

↓

Client
```

The **View Resolver** locates the appropriate HTML/JSP/Thymeleaf template and renders it.

---

# Common Mapping Annotations

| Annotation | HTTP Method |
|------------|-------------|
| `@GetMapping` | GET |
| `@PostMapping` | POST |
| `@PutMapping` | PUT |
| `@PatchMapping` | PATCH |
| `@DeleteMapping` | DELETE |
| `@RequestMapping` | Any HTTP Method |

Example:

```java
@Controller
@RequestMapping("/employees")
public class EmployeeController {

    @GetMapping
    public String employees() {

        return "employees";

    }

}
```

---

# Real-World Example

### Banking Website

When a user visits:

```
/login
```

The controller returns:

```
login.html
```

After successful login:

```
/dashboard
```

The controller returns:

```
dashboard.html
```

---

# Advantages

- Simple web page rendering
- Integrates with Spring MVC
- Works seamlessly with Thymeleaf and JSP
- Supports Model, View, and Controller architecture
- Easy routing of web requests

---

# Best Practices

- Use `@Controller` for server-side rendered web applications.
- Use `@RestController` for REST APIs.
- Keep business logic in the Service layer.
- Use `Model` only to pass data to views.

---

# Interview Questions

### 1. What is `@Controller`?

`@Controller` is a Spring MVC annotation used to handle web requests and return views such as HTML, JSP, or Thymeleaf templates.

---

### 2. What does `@Controller` return?

It typically returns the **name of a view** that is resolved by Spring's View Resolver.

---

### 3. What is the difference between `@Controller` and `@RestController`?

- `@Controller` returns web pages (views).
- `@RestController` returns data (JSON/XML).

---

### 4. How do you return plain text from a `@Controller`?

By using the `@ResponseBody` annotation.

Example:

```java
@ResponseBody
@GetMapping("/hello")
public String hello() {
    return "Hello Spring";
}
```

---

### 5. What is the purpose of the `Model` object?

The `Model` is used to pass data from the controller to the view.

---

# Quick Revision

- `@Controller` is used in Spring MVC applications.
- It returns view names instead of JSON.
- The View Resolver converts the view name into an HTML/JSP/Thymeleaf page.
- Use `Model` to send data to the view.
- Use `@ResponseBody` if you want to return data instead of a view.
- Use `@RestController` when building REST APIs.