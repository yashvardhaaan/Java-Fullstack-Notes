# application.properties vs application.yml

## Introduction

Spring Boot allows you to configure your application using either:

- `application.properties`
- `application.yml` (or `application.yaml`)

Both files serve the **same purpose**—they store application configuration such as server settings, database credentials, logging, security, and custom properties.

The difference lies only in **how the configuration is written**.

> **In simple words:**
>
> - `application.properties` uses **key=value** format.
> - `application.yml` uses **hierarchical YAML** format.
> - Both are supported by Spring Boot.

---

# What is application.properties?

`application.properties` stores configuration using **key=value** pairs.

Example:

```properties
spring.application.name=EmployeeService
server.port=8080

spring.datasource.url=jdbc:mysql://localhost:3306/company
spring.datasource.username=root
spring.datasource.password=password
```

Simple and easy to understand.

---

# What is application.yml?

`application.yml` stores configuration using **YAML syntax**.

The same configuration becomes:

```yaml
spring:
  application:
    name: EmployeeService

  datasource:
    url: jdbc:mysql://localhost:3306/company
    username: root
    password: password

server:
  port: 8080
```

Notice how related properties are grouped together.

---

# Side-by-Side Comparison

## application.properties

```properties
server.port=8080

spring.application.name=DemoApp

spring.datasource.url=jdbc:mysql://localhost:3306/demo
spring.datasource.username=root
spring.datasource.password=root

spring.jpa.show-sql=true
```

---

## application.yml

```yaml
server:
  port: 8080

spring:
  application:
    name: DemoApp

  datasource:
    url: jdbc:mysql://localhost:3306/demo
    username: root
    password: root

  jpa:
    show-sql: true
```

Both configurations produce the **exact same result**.

---

# Syntax Difference

## Properties File

Uses:

```properties
key=value
```

Example:

```properties
server.port=8080
```

---

## YAML File

Uses:

- Indentation
- Colons (`:`)

Example:

```yaml
server:
  port: 8080
```

Indentation is mandatory in YAML.

---

# Nested Configuration

## Properties

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/demo
spring.datasource.username=root
spring.datasource.password=root
```

---

## YAML

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/demo
    username: root
    password: root
```

YAML is much easier to read for nested configurations.

---

# Lists Example

## Properties

```properties
app.cities[0]=Pune
app.cities[1]=Mumbai
app.cities[2]=Delhi
```

---

## YAML

```yaml
app:
  cities:
    - Pune
    - Mumbai
    - Delhi
```

YAML is much cleaner for collections.

---

# Profiles

## Properties

```properties
spring.profiles.active=dev
```

---

## YAML

```yaml
spring:
  profiles:
    active: dev
```

---

# Custom Properties

## Properties

```properties
company.name=ABC Technologies
company.city=Pune
```

---

## YAML

```yaml
company:
  name: ABC Technologies
  city: Pune
```

---

# Advantages of application.properties

- Simple syntax
- Easy for beginners
- No indentation issues
- Easier to edit manually
- Widely used in small projects

---

# Advantages of application.yml

- Cleaner and more readable
- Better for nested configuration
- Easier to manage large configuration files
- Excellent support for lists and maps
- Less repetitive

---

# Disadvantages

## application.properties

- Repetitive keys
- Harder to read in large projects
- Large files become cluttered

---

## application.yml

- Indentation is mandatory
- Incorrect spacing causes parsing errors
- Slightly harder for beginners

---

# Can We Use Both Together?

Yes.

Spring Boot supports both files.

However, **it is recommended to use only one format in a project** for consistency.

If both files contain the same property, Spring Boot gives **higher priority to `application.properties`**.

Example:

`application.properties`

```properties
server.port=8080
```

`application.yml`

```yaml
server:
  port: 9090
```

Result:

```
Application runs on port 8080
```

---

# Which One Should You Choose?

Use **application.properties** if:

- You're learning Spring Boot.
- The project is small.
- The configuration is simple.

Use **application.yml** if:

- The project is large.
- There are many nested configurations.
- You want cleaner and more readable configuration.

Many modern Spring Boot projects prefer **YAML**, while many existing enterprise projects still use **properties**.

---

# Comparison Table

| Feature | application.properties | application.yml |
|---------|-------------------------|-----------------|
| Format | key=value | YAML |
| Readability | Good | Excellent |
| Nested Configuration | Repetitive | Clean |
| Lists | Difficult | Very Easy |
| Indentation Required | No | Yes |
| Beginner Friendly | Yes | Moderate |
| Large Projects | Okay | Better |

---

# Interview Questions

### 1. What is the difference between `application.properties` and `application.yml`?

Both store Spring Boot configuration. The difference is only the syntax. `application.properties` uses `key=value`, while `application.yml` uses YAML.

---

### 2. Which file is better?

Neither is universally better. `application.properties` is simpler, while `application.yml` is more readable for large and nested configurations.

---

### 3. Can we use both in the same project?

Yes, but it is recommended to use only one format for consistency.

---

### 4. Which file has higher priority if both define the same property?

`application.properties` takes precedence over `application.yml`.

---

### 5. Which format is commonly used in modern Spring Boot projects?

Many modern projects prefer **application.yml** because it is cleaner and easier to manage, though both formats are fully supported.

---

# Quick Revision

- Both files store Spring Boot configuration.
- `application.properties` uses `key=value`.
- `application.yml` uses YAML with indentation.
- YAML is cleaner for nested properties and lists.
- Properties is simpler for beginners.
- Use one format consistently within a project.
- If both define the same property, `application.properties` has higher priority.