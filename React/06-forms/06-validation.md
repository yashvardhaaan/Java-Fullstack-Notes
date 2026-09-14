# 06 — Form Validation in React

## WHY?

Users don't always enter valid information.

For example:

```text id="m8q3v7"
Email → abc
Password → 123
Age → -5
Phone → abcxyz
```

Before sending this data to the server, we should check whether it is valid.

**Form validation** helps us:

* Prevent invalid input
* Give useful feedback
* Improve user experience
* Prevent incomplete submissions
* Catch errors before making an API request

The typical flow is:

```text id="k5n8x2"
User enters data
      ↓
Form state
      ↓
Validation
      ↓
Valid? ───── No ───→ Show errors
  │
 Yes
  ↓
Submit
  ↓
API / Server
```

---

# WHAT?

**Form validation** is the process of checking whether the values entered into a form satisfy the required rules.

Example:

```jsx id="v7p2m9"
function validate(form) {
  const errors = {};

  if (!form.name) {
    errors.name = "Name is required";
  }

  if (!form.email) {
    errors.email = "Email is required";
  }

  return errors;
}
```

If everything is valid:

```jsx id="q4x8n3"
errors = {};
```

If something is invalid:

```jsx id="n6m2k7"
errors = {
  email: "Email is required"
};
```

---

# WHERE?

Validation is commonly used in:

```text id="y3k8m5"
Login
Registration
Checkout
Payment
Profile forms
Job applications
Search filters
Admin forms
```

---

# TYPES OF VALIDATION

There are two major categories.

## 1. Client-Side Validation

Validation happens in the browser.

```text id="r8m3x6"
React
 ↓
Validate input
 ↓
Show error
```

Examples:

```text id="p5n7q2"
Required field
Email format
Minimum password length
Password confirmation
Number range
```

It provides fast feedback.

---

## 2. Server-Side Validation

The server validates the submitted data.

```text id="u2k9m4"
React
 ↓
API request
 ↓
Server validation
 ↓
Response
```

**Important:**

Client-side validation does **not** replace server-side validation.

A malicious or modified client can bypass browser-side checks.

The server must validate data before trusting or processing it.

---

# HOW?

## Step 1 — Create Form State

```jsx id="f8q3m7"
const [form, setForm] = useState({
  name: "",
  email: "",
  password: ""
});
```

---

## Step 2 — Create Error State

```jsx id="j4n8p2"
const [errors, setErrors] = useState({});
```

---

## Step 3 — Create Validation Function

```jsx id="x6m2q9"
function validate(form) {
  const errors = {};

  if (!form.name.trim()) {
    errors.name = "Name is required";
  }

  if (!form.email.trim()) {
    errors.email = "Email is required";
  }

  if (form.password.length < 8) {
    errors.password =
      "Password must be at least 8 characters";
  }

  return errors;
}
```

---

# 4. Validate on Submit

```jsx id="w3k7n5"
function handleSubmit(event) {
  event.preventDefault();

  const validationErrors = validate(form);

  if (Object.keys(validationErrors).length > 0) {
    setErrors(validationErrors);
    return;
  }

  console.log("Form is valid");
}
```

The important part:

```jsx id="c9m2x6"
if (Object.keys(validationErrors).length > 0) {
  setErrors(validationErrors);
  return;
}
```

If there are errors:

```text id="p8q4m1"
Don't submit
```

If there are no errors:

```text id="z5n7k3"
Submit data
```

---

# Complete Example

```jsx id="r4m8x2"
import { useState } from "react";

function RegistrationForm() {
  const [form, setForm] = useState({
    name: "",
    email: "",
    password: ""
  });

  const [errors, setErrors] = useState({});

  function handleChange(event) {
    const { name, value } = event.target;

    setForm(prev => ({
      ...prev,
      [name]: value
    }));
  }

  function validate(form) {
    const errors = {};

    if (!form.name.trim()) {
      errors.name = "Name is required";
    }

    if (!form.email.trim()) {
      errors.email = "Email is required";
    }

    if (form.password.length < 8) {
      errors.password =
        "Password must be at least 8 characters";
    }

    return errors;
  }

  function handleSubmit(event) {
    event.preventDefault();

    const validationErrors = validate(form);

    if (Object.keys(validationErrors).length > 0) {
      setErrors(validationErrors);
      return;
    }

    console.log("Submitting:", form);
  }

  return (
    <form onSubmit={handleSubmit}>

      <input
        name="name"
        value={form.name}
        onChange={handleChange}
        placeholder="Name"
      />

      {errors.name && (
        <p>{errors.name}</p>
      )}

      <input
        name="email"
        type="email"
        value={form.email}
        onChange={handleChange}
        placeholder="Email"
      />

      {errors.email && (
        <p>{errors.email}</p>
      )}

      <input
        name="password"
        type="password"
        value={form.password}
        onChange={handleChange}
        placeholder="Password"
      />

      {errors.password && (
        <p>{errors.password}</p>
      )}

      <button type="submit">
        Register
      </button>

    </form>
  );
}
```

---

# Validation Rules

Different fields require different rules.

## Required

```jsx id="u6k3p8"
if (!form.name.trim()) {
  errors.name = "Name is required";
}
```

---

## Minimum Length

```jsx id="y8m2q5"
if (form.password.length < 8) {
  errors.password =
    "Password must be at least 8 characters";
}
```

---

## Maximum Length

```jsx id="n4x7c2"
if (form.username.length > 20) {
  errors.username =
    "Username must be 20 characters or less";
}
```

---

## Number Range

```jsx id="m9p3v6"
const age = Number(form.age);

if (age < 18 || age > 100) {
  errors.age = "Age must be between 18 and 100";
}
```

---

# Email Validation

A basic client-side check could be:

```jsx id="b5q8k2"
if (!form.email.includes("@")) {
  errors.email = "Enter a valid email";
}
```

For more structured validation, you might use a suitable validation library or a carefully designed validation rule.

Don't rely on a simplistic regex as proof that an email address is truly valid.

---

# Password Confirmation

Suppose we have:

```jsx id="j7m4x9"
const [form, setForm] = useState({
  password: "",
  confirmPassword: ""
});
```

Validation:

```jsx id="c3n8p5"
if (form.password !== form.confirmPassword) {
  errors.confirmPassword =
    "Passwords do not match";
}
```

This is an example of **cross-field validation** because one field depends on another.

---

# WHEN?

There are several times when you can validate.

## 1. On Submit

```text id="v8m3q5"
User fills form
      ↓
Clicks Submit
      ↓
Validate
```

This is simple and often a good default.

---

## 2. On Change

```jsx id="x2k7n4"
onChange={handleChange}
```

You can validate while the user types.

Useful for things like:

```text id="p6q9m3"
Password strength
Username availability
Character limits
```

But validating every keystroke can sometimes create noisy UX.

---

## 3. On Blur

```jsx id="w5n8c2"
onBlur={handleBlur}
```

This means:

```text id="r3m7q1"
User enters field
      ↓
User leaves field
      ↓
Validate
```

This is often useful for field-level validation.

---

# Validation + Touched State

A common UX pattern is to track whether a field has been touched.

```jsx id="f9k2m6"
const [touched, setTouched] = useState({});
```

Then:

```jsx id="j3p8x5"
function handleBlur(event) {
  const { name } = event.target;

  setTouched(prev => ({
    ...prev,
    [name]: true
  }));
}
```

Display the error only when:

```jsx id="n6q4v8"
touched.email && errors.email
```

Example:

```jsx id="y7m2c9"
{touched.email && errors.email && (
  <p>{errors.email}</p>
)}
```

This avoids showing:

```text id="d4k8p1"
Email is required
```

the instant the page loads.

---

# Validation Timing

A good strategy is often:

```text id="x5n9m2"
Initial render
      ↓
Don't show field errors
      ↓
User interacts
      ↓
onBlur
      ↓
Show field error
      ↓
onChange
      ↓
Update/remove error
      ↓
Submit
      ↓
Validate everything again
```

The exact UX depends on the application.

---

# Client Validation ≠ Security

This is **very important**.

Suppose your frontend says:

```jsx id="h3q7m8"
if (age < 18) {
  showError();
}
```

A user can potentially bypass your frontend.

Therefore:

```text id="k8m2x5"
Frontend validation
       ↓
UX + early feedback

Backend validation
       ↓
Security + data integrity
```

Both can be necessary.

---

# HTML Validation vs React Validation

HTML already provides some validation:

```jsx id="v4n8q2"
<input
  type="email"
  required
/>
```

You can also use:

```jsx id="c7m3x9"
<input
  required
  minLength={8}
/>
```

This is useful built-in browser validation.

React applications can additionally implement custom validation logic when more control is required.

---

# Common Mistakes

## ❌ Mistake 1 — Only validating on the client

Client validation improves UX but should not be treated as a security boundary.

Always validate important data on the server too.

---

## ❌ Mistake 2 — Showing every error immediately

If the form loads with:

```text id="b2q6m9"
Name required
Email required
Password required
```

the user may get an unnecessarily poor experience.

Consider touched/blur/submit-based validation.

---

## ❌ Mistake 3 — Mutating errors

❌

```jsx id="r5m8k2"
errors.email = "Invalid";
```

Instead:

```jsx id="z3q7n1"
setErrors(prev => ({
  ...prev,
  email: "Invalid"
}));
```

---

## ❌ Mistake 4 — Submitting even when validation fails

Always stop submission when errors exist:

```jsx id="m7x2p4"
if (Object.keys(errors).length > 0) {
  return;
}
```

---

# 🎯 Interview Questions

### Q1. What is form validation?

**Answer:**

Form validation checks whether user-entered values satisfy the application's required rules before processing or submitting them.

---

### Q2. Where should validation happen?

**Answer:**

Client-side validation is useful for immediate user feedback, but important data must also be validated on the server because client-side checks can be bypassed.

---

### Q3. What is touched state?

**Answer:**

It tracks whether a user has interacted with a particular field, commonly to decide when its validation error should be displayed.

---

### Q4. When can you validate a form?

Common approaches are:

```text id="x8q4m1"
onChange
onBlur
onSubmit
```

Often a combination is used depending on the UX requirement.

---

### Q5. How do you prevent submission when validation fails?

```jsx id="q6m3v8"
const errors = validate(form);

if (Object.keys(errors).length > 0) {
  setErrors(errors);
  return;
}
```

---

### Q6. What is cross-field validation?

**Answer:**

Validation where the validity of one field depends on another field.

Example:

```text id="p4n7x2"
password
      ↕
confirmPassword
```

---

# ⭐ Remember

```text id="w8m3q6"
              FORM
                ↓
             Values
                ↓
            Validate
                ↓
       ┌────────┴────────┐
       ↓                 ↓
    Invalid             Valid
       ↓                 ↓
    Errors             Submit
       ↓                 ↓
   Show user          API/Server
```

### Golden rule:

> **Client validation is for user experience; server validation is essential for trust and data integrity.**

### One-line interview answer:

> **Form validation verifies user input against defined rules, typically providing immediate client-side feedback while still requiring server-side validation for security and data integrity.**
