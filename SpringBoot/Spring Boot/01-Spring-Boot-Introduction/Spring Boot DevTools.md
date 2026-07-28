# Spring Boot DevTools

## What is Spring Boot DevTools?

**Spring Boot DevTools** is a development tool that improves the developer experience by providing features like automatic restart, LiveReload, and development-friendly configurations.

It is **only intended for development**, not for production.

> **In simple words:**  
> DevTools automatically restarts your application whenever you make changes, so you don't have to restart it manually.

---

# Why Do We Need DevTools?

Without DevTools:

1. Modify Java code
2. Stop the application
3. Rebuild the project
4. Start the application again

This process is slow and repetitive.

With DevTools:

1. Modify Java code
2. Save the file
3. Application restarts automatically

This significantly speeds up development.

---

# How DevTools Works

```
Developer Changes Code
          │
          ▼
      Save File
          │
          ▼
Spring Boot DevTools Detects Changes
          │
          ▼
Automatic Restart
          │
          ▼
Updated Application Runs
```

---

# Adding DevTools Dependency

### Maven

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-devtools</artifactId>
    <scope>runtime</scope>
    <optional>true</optional>
</dependency>
```

---

### Gradle

```gradle
developmentOnly("org.springframework.boot:spring-boot-devtools")
```

---

# Features of DevTools

## 1. Automatic Restart

Whenever you modify Java code and save the file, Spring Boot restarts the application automatically.

Example:

Before DevTools:

```
Save Code
      │
Stop Application
      │
Run Again
```

With DevTools:

```
Save Code
      │
Automatic Restart
```

---

## 2. LiveReload

Automatically refreshes the browser when static resources change.

Examples:

- HTML
- CSS
- JavaScript
- Templates

Instead of pressing **F5**, the browser refreshes automatically.

> **Note:** A LiveReload browser extension may be required, depending on your setup.

---

## 3. Faster Restart

DevTools uses **two classloaders**:

- Base ClassLoader
- Restart ClassLoader

```
Application
       │
       ├── Base ClassLoader
       │      (Framework Libraries)
       │
       └── Restart ClassLoader
              (Your Application Code)
```

Only your application's classes are reloaded during a restart, making it much faster than a full restart.

---

## 4. Development Property Defaults

DevTools automatically enables developer-friendly settings.

Examples:

- Disable template caching
- Disable static resource caching
- Show detailed error pages
- Faster reload during development

This allows changes to appear immediately without restarting the browser or clearing caches.

---

# Example

Without DevTools:

```
Edit Controller

↓

Stop Application

↓

Run Application

↓

Open Browser

↓

Test Again
```

---

With DevTools:

```
Edit Controller

↓

Save File

↓

Automatic Restart

↓

Refresh (or LiveReload)

↓

Done
```

---

# DevTools vs Manual Restart

| Feature | Manual Restart | DevTools |
|----------|----------------|----------|
| Restart Required | Yes | Automatic |
| Development Speed | Slower | Faster |
| Browser Refresh | Manual | Automatic (LiveReload) |
| Configuration | Manual | Automatic |
| Recommended | No | Yes |

---

# Does DevTools Work in Production?

**No.**

DevTools is designed **only for development**.

It is automatically disabled when the application is packaged and run as an executable JAR or deployed to production.

---

# Common Development Workflow

```
Write Code
      │
      ▼
Save File
      │
      ▼
DevTools Detects Change
      │
      ▼
Restart Application
      │
      ▼
Test Changes
```

---

# Advantages

- Faster development
- Automatic restart
- Automatic browser refresh
- Less manual work
- Improved productivity
- Better development experience

---

# Limitations

- Not meant for production use
- Restart still takes a few seconds for large applications
- LiveReload requires browser support or an extension

---

# Real World Example

Imagine writing a document.

### Without Auto Save

You:

- Write
- Save manually
- Reopen the document
- Continue editing

---

### With Auto Save

Every change is saved automatically.

You simply continue working.

Similarly, DevTools automatically restarts your application whenever you save changes.

---

# Interview Questions

### 1. What is Spring Boot DevTools?

Spring Boot DevTools is a development utility that provides automatic restart, LiveReload, and development-friendly configurations to improve developer productivity.

---

### 2. Why do we use DevTools?

To reduce development time by automatically restarting the application after code changes and providing faster feedback.

---

### 3. Does DevTools work in production?

No. It is intended only for development and is disabled in production environments.

---

### 4. What is LiveReload?

LiveReload automatically refreshes the browser when static resources like HTML, CSS, or JavaScript files are modified.

---

### 5. How does DevTools restart applications quickly?

It uses two classloaders:

- Base ClassLoader for framework libraries
- Restart ClassLoader for application classes

Only the application's classes are reloaded, making restarts much faster.

---

# Best Practices

- Use DevTools only during development.
- Do not include DevTools in production deployments.
- Pair DevTools with your IDE's automatic build feature for the best experience.
- Keep LiveReload enabled when working on frontend resources.

---

# Quick Revision

- DevTools improves the development experience.
- Automatically restarts the application after code changes.
- Supports LiveReload for browser refresh.
- Uses two classloaders for faster restarts.
- Applies development-friendly default configurations.
- Should **never** be used in production.