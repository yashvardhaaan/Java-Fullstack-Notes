# Spring Boot Auto Configuration

## What is Auto Configuration?

**Spring Boot Auto Configuration** is a feature that automatically configures your Spring application based on the dependencies present in the project and the settings in your configuration files.

Instead of manually creating and configuring beans, Spring Boot does it for you.

> **In simple words:**  
> Spring Boot looks at your project, understands what you need, and configures it automatically.

---

# Why Do We Need Auto Configuration?

Before Spring Boot, developers had to manually configure almost everything.

For example, if you wanted to connect to a database, you had to configure:

- DataSource
- EntityManager
- Transaction Manager
- Hibernate
- JDBC Template

This required many configuration classes or XML files.

With Spring Boot, you simply add the required dependency and properties.

Spring Boot automatically configures everything.

---

# Real World Example

Imagine buying a new smartphone.

### Without Auto Configuration

After buying it, you manually install:

- Camera App
- Gallery
- Contacts
- Messages
- Browser
- Settings

Everything must be configured yourself.

---

### With Auto Configuration

When you turn on the phone, everything is already installed and configured.

You just start using it.

Spring Boot works the same way.

---

# How Auto Configuration Works

```
Developer Adds Dependency
            │
            ▼
Spring Boot Starts
            │
            ▼
Checks Available Libraries
            │
            ▼
Creates Required Beans
            │
            ▼
Application Ready
```

---

# Example 1: Spring Web Dependency

Suppose you add:

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
```

Spring Boot automatically configures:

- DispatcherServlet
- Tomcat
- Jackson
- Request Mapping
- Error Handling
- Message Converters

You don't need to configure them manually.

---

# Example 2: Spring Data JPA

Suppose you add:

```xml
spring-boot-starter-data-jpa
```

and configure:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/demo
spring.datasource.username=root
spring.datasource.password=password
```

Spring Boot automatically creates:

- DataSource
- EntityManagerFactory
- Hibernate
- TransactionManager

without writing Java configuration.

---

# How Does Spring Boot Know What to Configure?

Spring Boot checks:

1. Dependencies on the classpath
2. Configuration properties
3. Existing beans

Then it decides what should be configured.

Example:

```
Is Spring MVC available?

YES

↓

Configure DispatcherServlet
```

```
Is Hibernate available?

YES

↓

Configure JPA
```

```
Is Tomcat available?

YES

↓

Start Embedded Tomcat
```

---

# @SpringBootApplication

Most Spring Boot applications start with:

```java
@SpringBootApplication
public class DemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

}
```

`@SpringBootApplication` is a combination of three annotations:

```java
@SpringBootConfiguration
@EnableAutoConfiguration
@ComponentScan
```

---

# @EnableAutoConfiguration

This annotation enables Spring Boot's Auto Configuration mechanism.

```
Application Starts
        │
        ▼
@EnableAutoConfiguration
        │
        ▼
Load Auto Configuration Classes
        │
        ▼
Create Required Beans
```

In modern Spring Boot, `@SpringBootApplication` already includes it, so you usually don't need to add it separately.

---

# Conditional Auto Configuration

Spring Boot only creates beans when certain conditions are met.

Examples:

## @ConditionalOnClass

Configure a bean only if a specific class exists.

Example:

```
If Hibernate exists

↓

Configure JPA
```

---

## @ConditionalOnMissingBean

Create a bean only if the user hasn't already created one.

This allows developers to override Spring Boot's default configuration.

---

## @ConditionalOnProperty

Configure a bean only if a specific property is present or has a certain value.

Example:

```properties
feature.enabled=true
```

Then the feature is enabled automatically.

---

# Can We Override Auto Configuration?

Yes.

If you define your own bean, Spring Boot usually backs off and uses your custom configuration.

Example:

```java
@Bean
public ObjectMapper objectMapper() {
    return new ObjectMapper();
}
```

Spring Boot will use this bean instead of creating its default `ObjectMapper`.

---

# Viewing Auto Configuration Report

Run the application with debug enabled:

```properties
debug=true
```

or

```bash
mvn spring-boot:run -Dspring-boot.run.arguments=--debug
```

Spring Boot prints a report showing:

- Which auto-configurations were applied
- Which were skipped
- Why they were skipped

This is very useful for debugging.

---

# Auto Configuration Workflow

```
Application Starts
        │
        ▼
Read Dependencies
        │
        ▼
Read application.properties
        │
        ▼
Evaluate Conditions
        │
        ▼
Create Required Beans
        │
        ▼
Application Ready
```

---

# Advantages

- Less manual configuration
- Faster development
- Cleaner code
- Fewer configuration errors
- Easy to customize
- Production-ready defaults

---

# Limitations

- Internal behavior may seem "magical" to beginners
- Sometimes extra configuration is needed for advanced use cases
- Understanding the auto-configuration process helps with debugging

---

# Interview Questions

### 1. What is Auto Configuration?

Auto Configuration is a Spring Boot feature that automatically configures beans based on the project's dependencies, configuration properties, and existing beans.

---

### 2. Which annotation enables Auto Configuration?

`@EnableAutoConfiguration`

However, it is already included in `@SpringBootApplication`.

---

### 3. How does Spring Boot decide what to configure?

It checks:

- Available dependencies
- Configuration properties
- Existing beans
- Conditional annotations

---

### 4. Can we override Auto Configuration?

Yes.

By defining your own bean or custom configuration, you can replace Spring Boot's default configuration.

---

### 5. What is `@ConditionalOnMissingBean`?

It tells Spring Boot to create a bean only if another bean of the same type does not already exist.

---

### 6. How can we see which auto-configurations are applied?

Enable debug mode by setting:

```properties
debug=true
```

Spring Boot prints a detailed auto-configuration report during startup.

---

# Best Practices

- Trust auto-configuration for common use cases.
- Override defaults only when necessary.
- Use the debug report to understand configuration decisions.
- Avoid unnecessary manual bean definitions.

---

# Quick Revision

- Auto Configuration automatically configures your application.
- It is enabled by `@EnableAutoConfiguration`.
- `@SpringBootApplication` already includes it.
- Spring Boot checks dependencies, properties, and existing beans.
- Conditional annotations control when beans are created.
- You can override default auto-configured beans.
- Use `debug=true` to view the auto-configuration report.