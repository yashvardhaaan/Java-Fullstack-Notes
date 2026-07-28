# @Primary

## What is `@Primary`?

`@Primary` is a Spring annotation used to specify the **default Bean** when multiple Beans of the same type are available for Dependency Injection.

> **In simple words:**
>
> If Spring finds multiple Beans of the same type, `@Primary` tells Spring:
> **"Use this Bean by default."**

---

# Why Do We Need `@Primary`?

Suppose we have two implementations of the same interface.

```java
public interface PaymentService {

    void pay();

}
```

Implementation 1:

```java
@Service
public class CreditCardPaymentService implements PaymentService {

    @Override
    public void pay() {
        System.out.println("Paid using Credit Card");
    }

}
```

Implementation 2:

```java
@Service
public class UpiPaymentService implements PaymentService {

    @Override
    public void pay() {
        System.out.println("Paid using UPI");
    }

}
```

Now Spring finds **two Beans** of type `PaymentService`.

If you write:

```java
@Autowired
private PaymentService paymentService;
```

Spring doesn't know which Bean to inject.

Result:

```
NoUniqueBeanDefinitionException
```

---

# Using `@Primary`

Mark one Bean as the default.

```java
@Service
@Primary
public class UpiPaymentService implements PaymentService {

    @Override
    public void pay() {
        System.out.println("Paid using UPI");
    }

}
```

Now Spring automatically injects:

```
UpiPaymentService
```

---

# Example

### Interface

```java
public interface NotificationService {

    void send();

}
```

---

### Email Service

```java
@Service
public class EmailService implements NotificationService {

    @Override
    public void send() {
        System.out.println("Email Sent");
    }

}
```

---

### SMS Service

```java
@Service
@Primary
public class SmsService implements NotificationService {

    @Override
    public void send() {
        System.out.println("SMS Sent");
    }

}
```

---

### Injection

```java
@Service
public class UserService {

    private final NotificationService notificationService;

    public UserService(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

}
```

Spring injects:

```
SmsService
```

because it is marked with `@Primary`.

---

# How `@Primary` Works

```
Spring Finds Beans

        │

        ▼

EmailService
SmsService (@Primary)

        │

        ▼

Chooses @Primary Bean

        │

        ▼

Injects Dependency
```

---

# `@Primary` vs `@Qualifier`

## `@Primary`

- Sets the **default** Bean.
- Used when one implementation should usually be preferred.

Example:

```java
@Primary
@Service
public class SmsService implements NotificationService {

}
```

---

## `@Qualifier`

- Selects a **specific** Bean by name.
- Overrides `@Primary` when both are used.

Example:

```java
@Autowired
@Qualifier("emailService")
private NotificationService notificationService;
```

Spring injects `EmailService`, even if another Bean is marked with `@Primary`.

---

# Advantages

- Resolves ambiguity automatically.
- Reduces configuration.
- Makes a preferred implementation explicit.
- Works well when one implementation is used most of the time.

---

# Best Practices

- Use `@Primary` when there is one common default implementation.
- Use `@Qualifier` when different implementations are required in different places.
- Avoid marking multiple Beans of the same type as `@Primary`.

---

# Interview Questions

### 1. What is `@Primary`?

`@Primary` tells Spring which Bean should be injected by default when multiple Beans of the same type exist.

---

### 2. Why is `@Primary` needed?

It resolves ambiguity when multiple Beans of the same type are available.

---

### 3. What happens without `@Primary` or `@Qualifier`?

Spring throws:

```
NoUniqueBeanDefinitionException
```

because it cannot decide which Bean to inject.

---

### 4. What is the difference between `@Primary` and `@Qualifier`?

| `@Primary` | `@Qualifier` |
|------------|--------------|
| Sets the default Bean | Selects a specific Bean |
| Applied on Bean classes | Applied at the injection point |
| Used globally | Used where needed |

---

### 5. Which annotation has higher priority?

`@Qualifier` has higher priority than `@Primary`.

---

# Quick Revision

- `@Primary` marks the default Bean.
- Used when multiple Beans of the same type exist.
- Prevents `NoUniqueBeanDefinitionException`.
- Only one Bean should normally be marked as `@Primary`.
- `@Qualifier` overrides `@Primary` when a specific Bean is requested.