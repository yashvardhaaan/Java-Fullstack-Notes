# Email Service

## What is an Email Service?

An **Email Service** is a system that allows a Spring Boot application to **send emails** to users.

Common use cases include:

- User Registration
- OTP Verification
- Password Reset
- Order Confirmation
- Payment Receipt
- Notifications

> **In simple words:**
>
> An Email Service allows your application to automatically send emails to users.

---

# Why Do We Need an Email Service?

Imagine a user registers on an e-commerce website.

Without Email Service

```
User Registers

↓

Account Created

↓

No Confirmation
```

The user doesn't know whether registration was successful.

---

With Email Service

```
User Registers

↓

Account Created

↓

Send Email

↓

Welcome Email Delivered
```

Better user experience.

---

# Real-World Example

When you reset your password on Gmail,

```
Click Forgot Password

↓

Receive OTP Email

↓

Verify OTP

↓

Reset Password
```

This is an Email Service in action.

---

# Email Service Architecture

```
Client

↓

Controller

↓

Service

↓

JavaMailSender

↓

SMTP Server

↓

Recipient Email
```

---

# How Email Sending Works

```
Application

↓

Create Email

↓

SMTP Server

↓

Internet

↓

Recipient Inbox
```

---

# What is SMTP?

**SMTP (Simple Mail Transfer Protocol)** is the standard protocol used for sending emails.

Popular SMTP providers:

- Gmail SMTP
- Outlook SMTP
- Yahoo SMTP
- SendGrid
- Mailgun
- Amazon SES

---

# Required Dependency

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-mail</artifactId>
</dependency>
```

---

# Configuration

```properties
spring.mail.host=smtp.gmail.com

spring.mail.port=587

spring.mail.username=your-email@gmail.com

spring.mail.password=your-app-password

spring.mail.properties.mail.smtp.auth=true

spring.mail.properties.mail.smtp.starttls.enable=true
```

> Never use your Gmail account password directly. Use an **App Password** when required.

---

# JavaMailSender

Spring Boot provides

```java
JavaMailSender
```

It is responsible for sending emails.

---

# Simple Email Example

```java
@Service
public class EmailService {

    private final JavaMailSender mailSender;

    public EmailService(JavaMailSender mailSender) {

        this.mailSender = mailSender;

    }

    public void sendEmail() {

        SimpleMailMessage message = new SimpleMailMessage();

        message.setTo("user@example.com");

        message.setSubject("Welcome");

        message.setText("Welcome to our application!");

        mailSender.send(message);

    }

}
```

---

# Request Flow

```
Client

↓

Controller

↓

Email Service

↓

JavaMailSender

↓

SMTP Server

↓

Recipient
```

---

# Sending HTML Emails

Simple text emails are limited.

For HTML emails,

```
Application

↓

MimeMessage

↓

SMTP

↓

HTML Email
```

Example

```java
MimeMessage message = mailSender.createMimeMessage();
```

HTML emails support:

- Images
- Buttons
- Tables
- Colors
- CSS Styling

---

# Email with Attachment

```
Invoice Generated

↓

Attach PDF

↓

Send Email
```

Example

```java
MimeMessageHelper helper =
        new MimeMessageHelper(message, true);

helper.addAttachment(
        "invoice.pdf",
        file
);
```

---

# Common Email Types

## Welcome Email

```
User Registers

↓

Welcome Email
```

---

## OTP Email

```
Generate OTP

↓

Send Email

↓

Verify OTP
```

---

## Password Reset

```
Forgot Password

↓

Generate Token

↓

Send Reset Link
```

---

## Order Confirmation

```
Order Placed

↓

Confirmation Email
```

---

# Asynchronous Email

Sending emails can take time.

Instead of blocking the request,

```
User Registers

↓

Save User

↓

Return Response

↓

Background Thread

↓

Send Email
```

Example

```java
@Async
public void sendEmail(){

}
```

---

# Exception Handling

Always handle email failures.

```java
try {

    mailSender.send(message);

} catch (Exception ex) {

    // Log error

}
```

---

# Email Service Flow

```
User Action

↓

Business Logic

↓

Generate Email

↓

SMTP

↓

Recipient Inbox
```

---

# Common Use Cases

- User Registration
- Password Reset
- OTP Verification
- Payment Receipt
- Order Confirmation
- Promotional Emails
- Newsletter

---

# Advantages

- Improves user communication.
- Automates notifications.
- Increases user trust.
- Supports HTML emails and attachments.
- Easy integration with Spring Boot.

---

# Disadvantages

- SMTP servers may have rate limits.
- Email delivery is not guaranteed instantly.
- Spam filters may block emails.
- Requires proper SMTP configuration.

---

# Best Practices

- Send emails asynchronously using `@Async`.
- Store SMTP credentials securely.
- Never hardcode passwords in source code.
- Use HTML emails for better user experience.
- Validate email addresses before sending.
- Retry failed email deliveries when appropriate.
- Log email failures for monitoring.

---

# Common Mistakes

❌ Hardcoding SMTP credentials.

❌ Sending emails synchronously for every request.

❌ Ignoring exceptions during email sending.

❌ Not validating email addresses.

❌ Sending sensitive information in plain text emails.

---

# Real-World Example

## Banking Application

```
Money Transferred

↓

Send Transaction Receipt
```

---

## E-Commerce Website

```
Order Placed

↓

Order Confirmation Email
```

---

## Food Delivery App

```
Order Delivered

↓

Delivery Confirmation Email
```

---

# Interview Questions

### 1. What is an Email Service?

An Email Service allows an application to send automated emails such as OTPs, welcome messages, and order confirmations.

---

### 2. Which Spring Boot dependency is used for email support?

```xml
spring-boot-starter-mail
```

---

### 3. What is `JavaMailSender`?

`JavaMailSender` is Spring Boot's interface for creating and sending emails.

---

### 4. What is SMTP?

SMTP (Simple Mail Transfer Protocol) is the protocol used to send emails over the internet.

---

### 5. How can HTML emails be sent?

By using `MimeMessage` and `MimeMessageHelper`.

---

### 6. Why should emails be sent asynchronously?

Because sending emails can be slow. Using `@Async` prevents blocking the user's request.

---

### 7. How should SMTP credentials be stored?

They should be stored securely using environment variables, configuration servers, or secret management tools—never hardcoded in source code.

---

# Quick Revision

- Email Service sends automated emails.
- Spring Boot uses `spring-boot-starter-mail`.
- `JavaMailSender` is the core email-sending interface.
- SMTP is the protocol used to send emails.
- Use `MimeMessage` for HTML emails and attachments.
- Prefer asynchronous email sending with `@Async`.
- Secure SMTP credentials and handle email failures properly.