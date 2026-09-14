# 07 — Error Messages in React Forms

## WHY?

Validation tells us **that something is wrong**, but the user also needs to know **what is wrong and how to fix it**.

For example, instead of simply:

```text
Invalid
```

we should show:

```text
Email is required
```

or:

```text
Password must be at least 8 characters
```

Good error messages make forms easier to complete and reduce user frustration.

---

# WHAT?

An **error message** is UI feedback displayed when a form field fails a validation rule.

A common React pattern is:

```jsx
{errors.email && (
  <p>{errors.email}</p>
)}
```

Where:

```jsx
errors = {
  email: "Invalid email address"
}
```

The flow is:

```text
User enters data
       ↓
Validate
       ↓
Error?
   ↓       ↓
 Yes      No
  ↓        ↓
errors    Continue
  ↓
Show message
```

---

# WHERE?

Error messages can be displayed:

### Below an input

```jsx
<input />

{errors.email && (
  <p>{errors.email}</p>
)}
```

### Beside a field

```text
Email [ abc ]
      ↑
   Invalid email
```

### At the top of the form

Useful when there are many errors:

```text
Please fix the following errors:
• Email is invalid
• Password is too short
```

For accessibility, field-level errors should also be properly associated with their inputs.

---

# HOW?

## 1. Create Error State

```jsx
const [errors, setErrors] = useState({});
```

Initially:

```jsx
{}
```

If email is invalid:

```jsx
{
  email: "Enter a valid email"
}
```

If multiple fields are invalid:

```jsx
{
  name: "Name is required",
  email: "Enter a valid email",
  password: "Password must be at least 8 characters"
}
```

---

# 2. Validate the Form

```jsx
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

# 3. Store Errors

```jsx
function handleSubmit(event) {
  event.preventDefault();

  const validationErrors = validate(form);

  setErrors(validationErrors);

  if (Object.keys(validationErrors).length > 0) {
    return;
  }

  // Submit form
}
```

---

# 4. Display the Error

```jsx
<input
  name="email"
  value={form.email}
  onChange={handleChange}
/>

{errors.email && (
  <p>{errors.email}</p>
)}
```

This is conditional rendering.

If:

```jsx
errors.email
```

exists → show the message.

If it doesn't → show nothing.

---

# Complete Example

```jsx
import { useState } from "react";

function LoginForm() {
  const [form, setForm] = useState({
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

  function validate() {
    const errors = {};

    if (!form.email.trim()) {
      errors.email = "Email is required";
    }

    if (!form.password) {
      errors.password = "Password is required";
    } else if (form.password.length < 8) {
      errors.password =
        "Password must be at least 8 characters";
    }

    return errors;
  }

  function handleSubmit(event) {
    event.preventDefault();

    const validationErrors = validate();

    setErrors(validationErrors);

    if (Object.keys(validationErrors).length > 0) {
      return;
    }

    console.log("Form submitted");
  }

  return (
    <form onSubmit={handleSubmit}>

      <label htmlFor="email">
        Email
      </label>

      <input
        id="email"
        name="email"
        type="email"
        value={form.email}
        onChange={handleChange}
        aria-invalid={Boolean(errors.email)}
        aria-describedby={
          errors.email ? "email-error" : undefined
        }
      />

      {errors.email && (
        <p id="email-error">
          {errors.email}
        </p>
      )}

      <label htmlFor="password">
        Password
      </label>

      <input
        id="password"
        name="password"
        type="password"
        value={form.password}
        onChange={handleChange}
        aria-invalid={Boolean(errors.password)}
        aria-describedby={
          errors.password ? "password-error" : undefined
        }
      />

      {errors.password && (
        <p id="password-error">
          {errors.password}
        </p>
      )}

      <button type="submit">
        Login
      </button>

    </form>
  );
}
```

---

# Accessibility

This is an important **real-world and interview concept**.

Simply displaying:

```jsx
<p>Invalid email</p>
```

isn't always enough.

You can associate the error with the input:

```jsx
<input
  aria-describedby="email-error"
/>

<p id="email-error">
  Enter a valid email address
</p>
```

Now assistive technologies can understand that the message describes the input.

You can also indicate invalid state:

```jsx
aria-invalid={Boolean(errors.email)}
```

When there's an error:

```text
aria-invalid = true
```

When there's no error:

```text
aria-invalid = false
```

---

# Error Message + Touched State

You usually don't want errors displayed immediately when the form first loads.

Use:

```jsx
const [touched, setTouched] = useState({});
```

When the user leaves a field:

```jsx
function handleBlur(event) {
  const { name } = event.target;

  setTouched(prev => ({
    ...prev,
    [name]: true
  }));
}
```

Then:

```jsx
{touched.email && errors.email && (
  <p id="email-error">
    {errors.email}
  </p>
)}
```

The flow becomes:

```text
Page loads
   ↓
No error shown

User interacts
   ↓
Leaves field
   ↓
touched.email = true
   ↓
Show error if invalid
```

---

# Clearing Errors

Suppose the user initially enters:

```text
abc
```

and gets:

```text
Invalid email
```

Then they change it to:

```text
abc@gmail.com
```

You should remove the error once the field becomes valid.

One simple approach:

```jsx
function handleChange(event) {
  const { name, value } = event.target;

  setForm(prev => ({
    ...prev,
    [name]: value
  }));

  setErrors(prev => ({
    ...prev,
    [name]: ""
  }));
}
```

For more robust forms, you can revalidate the specific field and set/remove its error based on the current value.

---

# Field-Level vs Form-Level Errors

## Field-level

Associated with a particular field:

```text
Email
[ abc ]

Invalid email address
```

Good for:

```text
Required fields
Email format
Password length
Phone format
```

---

## Form-level

The error applies to the whole submission:

```text
Unable to create account.
Please try again.
```

Example:

```jsx
const [formError, setFormError] = useState("");
```

Then:

```jsx
{formError && (
  <p role="alert">
    {formError}
  </p>
)}
```

This is particularly useful for server/API errors.

---

# Server Errors

Suppose the frontend validation succeeds:

```text
Email ✓
Password ✓
```

but the server responds:

```text
Email already registered
```

You can put that into error state:

```jsx
setErrors({
  email: "This email is already registered"
});
```

Or for a general API failure:

```jsx
setFormError(
  "Unable to create your account. Please try again."
);
```

So the complete process can be:

```text
Client validation
       ↓
Valid
       ↓
API request
       ↓
Server validation
       ↓
Success / Error
```

---

# Good vs Bad Error Messages

### ❌ Bad

```text
Invalid
```

### ❌ Bad

```text
Error 400
```

### ❌ Bad

```text
Wrong input
```

### ✅ Better

```text
Email is required.
```

### ✅ Better

```text
Enter a valid email address.
```

### ✅ Better

```text
Password must contain at least 8 characters.
```

The message should tell the user **what they need to do**.

---

# WHEN?

Show errors when they are useful to the user.

Common strategies:

### On Submit

Good for:

```text
Simple forms
```

### On Blur

Good for:

```text
Field-level validation
```

### On Change

Good for:

```text
Password strength
Live validation
Immediate feedback
```

### After Server Response

Good for:

```text
Duplicate email
Invalid credentials
Business rules
Server-side validation
```

A practical strategy is often:

```text
Initial
  ↓
Don't show errors

Blur
  ↓
Validate field

Change
  ↓
Update / clear error

Submit
  ↓
Validate entire form

API
  ↓
Handle server errors
```

---

# ⚠️ Common Mistakes

## Mistake 1 — Showing errors before user interaction

Avoid immediately showing:

```text
Email is required
Password is required
```

when the user hasn't touched anything.

Use touched state or an appropriate validation strategy.

---

## Mistake 2 — Only showing a generic error

Instead of:

```text
Invalid form
```

tell the user which field needs attention and how to fix it.

---

## Mistake 3 — Ignoring server errors

Client validation cannot detect every business rule.

For example:

```text
Email already exists
Username already taken
Insufficient permissions
```

These may only be discovered by the server.

---

## Mistake 4 — Making errors inaccessible

Prefer associating errors with their fields:

```jsx
aria-describedby="email-error"
```

and:

```jsx
<p id="email-error">
  Invalid email
</p>
```

---

# 🎯 Interview Questions

### Q1. How do you display validation errors in React?

Use error state and conditional rendering:

```jsx
{errors.email && (
  <p>{errors.email}</p>
)}
```

---

### Q2. What is touched state?

It tracks whether a user has interacted with a field, allowing errors to be shown at an appropriate time.

---

### Q3. How do you associate an error message with an input for accessibility?

Use:

```jsx
aria-describedby="email-error"
```

on the input and:

```jsx
<p id="email-error">
  Invalid email
</p>
```

for the corresponding message.

---

### Q4. What is `aria-invalid`?

It communicates that a form control currently contains an invalid value.

Example:

```jsx
aria-invalid={Boolean(errors.email)}
```

---

### Q5. What is the difference between field-level and form-level errors?

```text
Field-level
→ Error belongs to a specific field

Form-level
→ Error applies to the overall submission/form
```

---

### Q6. Can server errors be displayed using the same error state?

Yes. Server validation errors can be mapped to individual fields or displayed as a general form-level error.

---

# ⭐ Remember

```text
                 FORM
                   ↓
               Validate
                   ↓
              Error found?
              /          \
            YES           NO
             ↓             ↓
        Error State      Submit
             ↓             ↓
        Show Message      API
                           ↓
                    Server Response
                       /        \
                    Error       Success
                      ↓
                 Show feedback
```

### Golden pattern:

```jsx
const [errors, setErrors] = useState({});

{errors.email && (
  <p id="email-error">
    {errors.email}
  </p>
)}
```

### One-line interview answer:

> **Error messages in React forms are UI feedback derived from validation or server errors, usually stored in state and conditionally rendered next to the relevant field, with appropriate accessibility attributes such as `aria-describedby` and `aria-invalid`.**
