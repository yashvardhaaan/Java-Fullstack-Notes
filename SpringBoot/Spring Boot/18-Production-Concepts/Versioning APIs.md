# API Versioning

## What is API Versioning?

**API Versioning** is the practice of maintaining **multiple versions of an API** so that new changes can be introduced **without breaking existing clients**.

It allows old applications to continue working while newer applications use the latest API.

> **In simple words:**
>
> API Versioning lets you improve your APIs while keeping older applications working.

---

# Why Do We Need API Versioning?

Imagine a mobile application.

Version 1 returns

```json
{
    "name": "John"
}
```

Later, the API changes to

```json
{
    "firstName": "John",
    "lastName": "Doe"
}
```

Without Versioning

```
Old Mobile App

↓

Calls New API

↓

Unexpected Response

↓

Application Breaks
```

---

With Versioning

```
Old App

↓

/api/v1/users

↓

Works

----------------------

New App

↓

/api/v2/users

↓

Works
```

Both applications continue working.

---

# Real-World Example

Imagine a software company.

```
Windows 10

↓

Still Supported

----------------

Windows 11

↓

Latest Features
```

Old users don't have to upgrade immediately.

API Versioning works the same way.

---

# API Versioning Flow

```
Client

↓

API Version

↓

Controller

↓

Service

↓

Response
```

---

# Versioning Strategies

The most common strategies are:

- URI Versioning
- Request Parameter Versioning
- Header Versioning
- Media Type Versioning

---

# 1. URI Versioning (Most Common)

Version is part of the URL.

```
GET /api/v1/users

GET /api/v2/users
```

Controller

```java
@RestController
@RequestMapping("/api/v1/users")
public class UserControllerV1 {

}
```

Version 2

```java
@RestController
@RequestMapping("/api/v2/users")
public class UserControllerV2 {

}
```

Advantages

- Simple
- Easy to understand
- Easy to test

---

# 2. Request Parameter Versioning

Version is passed as a query parameter.

```
GET /users?version=1

GET /users?version=2
```

Example

```java
@GetMapping(params = "version=1")
public String version1(){

    return "API V1";

}
```

---

# 3. Header Versioning

Version is passed in an HTTP header.

Request

```
GET /users

API-Version: 2
```

Controller

```java
@GetMapping(

        headers = "API-Version=2"

)
public String version2(){

    return "API V2";

}
```

---

# 4. Media Type Versioning

Version is specified in the `Accept` header.

Request

```
Accept:

application/vnd.company.v1+json
```

Controller

```java
@GetMapping(

        produces = "application/vnd.company.v1+json"

)
public User version1(){

    return new User();

}
```

---

# Version Comparison

| Strategy | Example |
|----------|----------|
| URI | `/api/v1/users` |
| Parameter | `/users?version=1` |
| Header | `API-Version: 1` |
| Media Type | `Accept: application/vnd.company.v1+json` |

---

# Spring Boot Example

Version 1

```java
@RestController
@RequestMapping("/api/v1/products")
public class ProductControllerV1 {

    @GetMapping
    public String getProducts(){

        return "Products V1";

    }

}
```

---

Version 2

```java
@RestController
@RequestMapping("/api/v2/products")
public class ProductControllerV2 {

    @GetMapping
    public String getProducts(){

        return "Products V2";

    }

}
```

---

# Request Flow

```
Client

↓

GET /api/v2/users

↓

Controller V2

↓

Service

↓

Repository

↓

Database

↓

Response
```

---

# Backward Compatibility

Old Clients

```
Use

/api/v1
```

New Clients

```
Use

/api/v2
```

Both continue working.

---

# When Should You Create a New Version?

Create a new version when:

- Response structure changes
- Request structure changes
- Existing behavior changes
- Fields are removed
- Authentication mechanism changes

---

# When Should You NOT Create a New Version?

Avoid creating a new version for:

- Bug fixes
- Performance improvements
- Internal code refactoring
- Adding optional response fields (if it doesn't break clients)
- Documentation updates

---

# Deprecation Process

Instead of removing Version 1 immediately,

```
Release V2

↓

Announce Deprecation

↓

Support V1

↓

Clients Migrate

↓

Remove V1
```

This avoids breaking existing applications.

---

# API Versioning Architecture

```
Client

↓

Version

↓

Controller V1 / V2

↓

Service

↓

Repository

↓

Database
```

---

# Advantages

- Backward compatibility.
- Safe API evolution.
- Easier client migration.
- Reduced production issues.
- Better long-term maintenance.

---

# Disadvantages

- More code to maintain.
- Multiple API versions increase testing effort.
- Documentation becomes larger.
- Older versions require ongoing support.

---

# Best Practices

- Prefer URI Versioning for public REST APIs because it is simple and widely understood.
- Version only when breaking changes are introduced.
- Keep old versions available for a reasonable period.
- Clearly document supported and deprecated versions.
- Plan a deprecation strategy before removing an API version.
- Avoid unnecessary version proliferation.

---

# Common Mistakes

❌ Changing an existing API without versioning.

❌ Removing old API versions immediately.

❌ Maintaining too many unsupported versions.

❌ Using inconsistent version naming.

❌ Forgetting to document API changes.

---

# Real-World Example

## Banking Application

```
Mobile App V1

↓

/api/v1/accounts

--------------------

Mobile App V2

↓

/api/v2/accounts
```

---

## E-Commerce Website

```
Old Website

↓

/api/v1/products

--------------------

New Website

↓

/api/v2/products
```

---

## Food Delivery App

```
Old Mobile App

↓

/api/v1/orders

--------------------

Latest App

↓

/api/v2/orders
```

---

# Interview Questions

### 1. What is API Versioning?

API Versioning is the practice of maintaining multiple API versions so that new changes can be introduced without breaking existing clients.

---

### 2. Why is API Versioning important?

It ensures backward compatibility and allows clients to migrate to newer versions gradually.

---

### 3. What are the common API Versioning strategies?

- URI Versioning
- Request Parameter Versioning
- Header Versioning
- Media Type Versioning

---

### 4. Which API Versioning strategy is most commonly used?

URI Versioning using paths such as:

```
/api/v1/users
```

---

### 5. When should a new API version be created?

When there are breaking changes, such as modifying request/response formats or changing API behavior.

---

### 6. Should a new version be created for bug fixes?

No. Bug fixes and performance improvements generally do not require a new API version if they don't break existing clients.

---

### 7. What is backward compatibility?

Backward compatibility means older clients can continue using the existing API without modification after newer versions are introduced.

---

# Quick Revision

- API Versioning prevents breaking existing clients.
- Common strategies are URI, Header, Parameter, and Media Type Versioning.
- URI Versioning (`/api/v1/...`) is the most widely used.
- Create new versions only for breaking changes.
- Support old versions during a migration period.
- Document version changes and deprecation plans.
- API Versioning improves maintainability and client compatibility.