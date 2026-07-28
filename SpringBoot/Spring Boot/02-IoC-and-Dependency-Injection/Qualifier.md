# @Qualifier

## What is `@Qualifier`?

`@Qualifier` is a Spring annotation used to **specify exactly which Bean should be injected** when multiple Beans of the same type are available.

> **In simple words:**
>
> `@Qualifier` tells Spring:
> **"Inject this specific Bean."**

---

# Why Do We Need `@Qualifier`?

Suppose we have an interface:

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

Now, if we inject:

```java
@Autowired
private PaymentService paymentService;
```

Spring finds **two Beans** of type `PaymentService` and doesn't know which one to use.

Result:

```
NoUniqueBeanDefinitionException
```

---

# Using `@Qualifier`

Specify the Bean name.

```java
@Autowired
@Qualifier("upiPaymentService")
private PaymentService paymentService;
```

Now Spring injects only:

```
UpiPaymentService
```

---

# Constructor Injection Example

```java
@Service
public class OrderService {

    private final PaymentService paymentService;

    public OrderService(
            @Qualifier("creditCardPaymentService")
            PaymentService paymentService) {

        this.paymentService = paymentService;
    }

}
```

Spring injects:

```
CreditCardPaymentService
```

---

# Complete Example

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

    public UserService(
            @Qualifier("emailService")
            NotificationService notificationService) {

        this.notificationService = notificationService;
    }

}
```

Spring injects:

```
EmailService
```

---

# How `@Qualifier` Works

```
Spring Finds Beans

        │

        ▼

EmailService
SmsService

        │

        ▼

Reads @Qualifier("emailService")

        │

        ▼

Selects EmailService

        │

        ▼

Injects Bean
```

---

# Bean Name Used in `@Qualifier`

By default, the bean name is the class name with the **first letter in lowercase**.

Example:

```java
@Service
public class EmailService {

}
```

Bean Name:

```
emailService
```

So,

```java
@Qualifier("emailService")
```

is correct.

---

# Custom Bean Name

You can define your own bean name.

```java
@Service("mailService")
public class EmailService implements NotificationService {

}
```

Injection:

```java
@Autowired
@Qualifier("mailService")
private NotificationService notificationService;
```

---

# `@Qualifier` vs `@Primary`

| `@Qualifier` | `@Primary` |
|--------------|------------|
| Selects a specific Bean | Selects the default Bean |
| Used at the injection point | Used on the Bean class |
| Higher priority | Lower priority |

If both are used:

```java
@Primary
@Service
public class SmsService implements NotificationService {

}
```

```java
@Autowired
@Qualifier("emailService")
private NotificationService notificationService;
```

Spring injects:

```
EmailService
```

because `@Qualifier` overrides `@Primary`.

---

# Advantages

- Resolves Bean ambiguity
- Gives precise control over Dependency Injection
- Works well with multiple implementations
- Improves code readability

---

# Best Practices

- Prefer **Constructor Injection** with `@Qualifier`.
- Use meaningful bean names.
- Use `@Primary` for the common default implementation and `@Qualifier` when a specific implementation is needed.

---

# Interview Questions

### 1. What is `@Qualifier`?

`@Qualifier` specifies which Bean should be injected when multiple Beans of the same type exist.

---

### 2. Why is `@Qualifier` needed?

It resolves ambiguity by selecting a specific Bean for Dependency Injection.

---

### 3. What happens without `@Qualifier` or `@Primary`?

Spring throws:

```
NoUniqueBeanDefinitionException
```

because it cannot decide which Bean to inject.

---

### 4. What is the difference between `@Qualifier` and `@Primary`?

- `@Qualifier` selects a specific Bean.
- `@Primary` marks the default Bean.
- `@Qualifier` takes precedence over `@Primary`.

---

### 5. Can `@Qualifier` be used with Constructor Injection?

Yes. It is commonly used with Constructor Injection and is the recommended approach.

---

# Quick Revision

- `@Qualifier` selects a specific Bean.
- Used when multiple Beans of the same type exist.
- Prevents `NoUniqueBeanDefinitionException`.
- Uses the bean name to identify the required Bean.
- `@Qualifier` has higher priority than `@Primary`.
- Best used with Constructor Injection.