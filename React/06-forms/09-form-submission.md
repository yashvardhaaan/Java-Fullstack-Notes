# 09 — Form Submission in React

Form submission is the final step where the data entered by the user is **validated, collected, and sent to a server/API**.

---

## WHY?

In a real application, entering data is not enough.

For example, when a user enters:

```text
Email: yash@example.com
Password: ********
```

React needs to:

1. Capture the data
2. Validate it
3. Prevent unwanted browser refresh
4. Send the data to the backend
5. Show loading state
6. Handle success
7. Handle errors
8. Prevent duplicate submissions

Typical flow:

```text
User fills form
      ↓
Submit
      ↓
Validate
      ↓
Send API request
      ↓
 ┌────┴────┐
 ↓         ↓
Success   Error
 ↓         ↓
Update    Show error
UI
```

---

# WHAT?

Form submission in React is usually handled using the **`onSubmit` event on `<form>`**.

Basic example:

```jsx
function LoginForm() {
  function handleSubmit(event) {
    event.preventDefault();

    console.log("Form submitted");
  }

  return (
    <form onSubmit={handleSubmit}>
      <input type="email" />
      <input type="password" />

      <button type="submit">
        Login
      </button>
    </form>
  );
}
```

### Important

```jsx
<form onSubmit={handleSubmit}>
```

is preferred over:

```jsx
<button onClick={handleSubmit}>
```

because the form's `submit` event also works when the user submits using keyboard interaction such as **Enter**.

---

# WHERE?

Form submission is used everywhere:

### Login

```text
Email + Password
        ↓
POST /api/login
```

### Registration

```text
Name + Email + Password
        ↓
POST /api/users
```

### Contact form

```text
Name + Email + Message
        ↓
POST /api/contact
```

### Checkout

```text
Address + Payment information
        ↓
Order API
```

### CRUD application

```text
Product form
     ↓
Create / Update product
```

---

# HOW?

## Step 1 — Handle `onSubmit`

```jsx
function handleSubmit(event) {
  event.preventDefault();

  console.log("Submitted");
}
```

### Why `preventDefault()`?

Normally, an HTML form submission can cause the browser to perform its default submission/navigation behavior.

In a React SPA, we usually want React/JavaScript to control the process.

```jsx
event.preventDefault();
```

means:

> "Don't perform the browser's default form submission."

---

# Step 2 — Get the form data

If you are using controlled components:

```jsx
import { useState } from "react";

function LoginForm() {
  const [form, setForm] = useState({
    email: "",
    password: ""
  });

  function handleSubmit(event) {
    event.preventDefault();

    console.log(form);
  }

  return (
    <form onSubmit={handleSubmit}>
      <input
        name="email"
        value={form.email}
        onChange={(e) =>
          setForm({
            ...form,
            email: e.target.value
          })
        }
      />

      <input
        name="password"
        type="password"
        value={form.password}
        onChange={(e) =>
          setForm({
            ...form,
            password: e.target.value
          })
        }
      />

      <button type="submit">
        Login
      </button>
    </form>
  );
}
```

At submission:

```jsx
console.log(form);
```

might produce:

```js
{
  email: "yash@example.com",
  password: "123456"
}
```

---

# Step 3 — Validate before submitting

```jsx
async function handleSubmit(event) {
  event.preventDefault();

  if (!form.email || !form.password) {
    setFormError("All fields are required");
    return;
  }

  // API call
}
```

The important part is:

```jsx
return;
```

If validation fails, don't continue to the API request.

---

# Step 4 — Show submitting/loading state

```jsx
const [isSubmitting, setIsSubmitting] = useState(false);
```

Then:

```jsx
async function handleSubmit(event) {
  event.preventDefault();

  setIsSubmitting(true);

  try {
    // API request
  } finally {
    setIsSubmitting(false);
  }
}
```

Button:

```jsx
<button
  type="submit"
  disabled={isSubmitting}
>
  {isSubmitting ? "Logging in..." : "Login"}
</button>
```

This prevents users from repeatedly clicking the button while the request is running.

---

# Step 5 — Send data to the API

Using `fetch()`:

```jsx
async function handleSubmit(event) {
  event.preventDefault();

  setIsSubmitting(true);

  try {
    const response = await fetch("/api/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(form)
    });

    if (!response.ok) {
      throw new Error("Login failed");
    }

    const data = await response.json();

    console.log("Success:", data);

  } catch (error) {
    console.error(error);

  } finally {
    setIsSubmitting(false);
  }
}
```

---

# ⭐ Important: `fetch()` and HTTP errors

A common interview question:

> Does `fetch()` reject automatically for HTTP 404 or 500?

**No.**

For example:

```js
const response = await fetch("/api/login");
```

A `404` or `500` response does not automatically cause `fetch()` to throw.

Therefore:

```js
if (!response.ok) {
  throw new Error("Request failed");
}
```

is important.

---

# Complete Practical Example

```jsx
import { useState } from "react";

function LoginForm() {
  const [form, setForm] = useState({
    email: "",
    password: ""
  });

  const [isSubmitting, setIsSubmitting] = useState(false);
  const [formError, setFormError] = useState("");

  function handleChange(event) {
    const { name, value } = event.target;

    setForm((prev) => ({
      ...prev,
      [name]: value
    }));
  }

  async function handleSubmit(event) {
    event.preventDefault();

    setFormError("");

    // Validation
    if (!form.email || !form.password) {
      setFormError("Email and password are required");
      return;
    }

    setIsSubmitting(true);

    try {
      const response = await fetch("/api/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify(form)
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.message || "Login failed");
      }

      console.log("Login successful", data);

      // Example:
      // navigate("/dashboard");

    } catch (error) {
      setFormError(error.message);
    } finally {
      setIsSubmitting(false);
    }
  }

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="email"
        name="email"
        value={form.email}
        onChange={handleChange}
        placeholder="Email"
      />

      <input
        type="password"
        name="password"
        value={form.password}
        onChange={handleChange}
        placeholder="Password"
      />

      {formError && (
        <p>{formError}</p>
      )}

      <button
        type="submit"
        disabled={isSubmitting}
      >
        {isSubmitting ? "Logging in..." : "Login"}
      </button>
    </form>
  );
}

export default LoginForm;
```

---

# FormData — Another Way

You don't always need React state to collect form values.

You can use the browser's `FormData` API:

```jsx
function handleSubmit(event) {
  event.preventDefault();

  const formData = new FormData(event.currentTarget);

  const data = Object.fromEntries(formData.entries());

  console.log(data);
}
```

Form:

```jsx
<form onSubmit={handleSubmit}>
  <input name="name" />
  <input name="email" />

  <button type="submit">
    Submit
  </button>
</form>
```

Result:

```js
{
  name: "Yash",
  email: "yash@example.com"
}
```

For repeated field names, such as multiple checkboxes, use:

```js
formData.getAll("skills");
```

rather than relying on `Object.fromEntries()`.

---

# `type="submit"` vs `type="button"`

This is important.

### Submit button

```jsx
<button type="submit">
  Save
</button>
```

Triggers:

```jsx
<form onSubmit={...}>
```

### Normal button

```jsx
<button type="button">
  Cancel
</button>
```

Does **not** submit the form.

This mistake is common:

```jsx
<button onClick={handleCancel}>
  Cancel
</button>
```

Inside a form, explicitly use:

```jsx
<button type="button">
```

for non-submit actions.

---

# React Hook Form Submission

Since you learned React Hook Form, submission becomes simpler.

```jsx
import { useForm } from "react-hook-form";

function LoginForm() {
  const {
    register,
    handleSubmit,
    formState: {
      errors,
      isSubmitting
    }
  } = useForm();

  async function onSubmit(data) {
    console.log(data);

    const response = await fetch("/api/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(data)
    });

    if (!response.ok) {
      throw new Error("Login failed");
    }
  }

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input
        {...register("email", {
          required: "Email is required"
        })}
      />

      {errors.email && (
        <p>{errors.email.message}</p>
      )}

      <input
        type="password"
        {...register("password", {
          required: "Password is required"
        })}
      />

      <button
        type="submit"
        disabled={isSubmitting}
      >
        {isSubmitting ? "Submitting..." : "Login"}
      </button>
    </form>
  );
}
```

Here:

```jsx
handleSubmit(onSubmit)
```

handles the submission flow and calls:

```jsx
onSubmit(data)
```

with validated form data.

---

# GET vs POST

Forms can submit using different HTTP methods.

### GET

Usually used when retrieving/searching data:

```text
Search → GET /products?query=laptop
```

### POST

Commonly used when sending data that creates an action/resource:

```text
Registration → POST /users
```

```text
Login → POST /login
```

The exact method depends on the API design.

---

# Successful Submission

After successful submission, you might:

### Reset the form

```jsx
setForm({
  email: "",
  password: ""
});
```

With React Hook Form:

```jsx
reset();
```

### Navigate

For example, with a routing library:

```jsx
navigate("/dashboard");
```

### Show success message

```jsx
setSuccess("Account created successfully!");
```

### Update application state

For example:

```text
Submit product
      ↓
API success
      ↓
Update product list
      ↓
UI displays new product
```

---

# WHEN?

Use form submission handling whenever form data needs to produce an action.

Examples:

| Situation    | Action                |
| ------------ | --------------------- |
| Login        | Send credentials      |
| Registration | Create account        |
| Contact form | Send message          |
| Search       | Query API             |
| Checkout     | Create order          |
| Profile edit | Update user           |
| Product form | Create/update product |
| Feedback     | Send feedback         |

---

# ❌ Common Mistakes

### 1. Forgetting `preventDefault()`

```jsx
function handleSubmit(event) {
  // ❌
}
```

Instead:

```jsx
event.preventDefault();
```

---

### 2. Using `onClick` instead of form `onSubmit`

Prefer:

```jsx
<form onSubmit={handleSubmit}>
```

instead of putting all submission logic only on:

```jsx
<button onClick={handleSubmit}>
```

---

### 3. Not checking `response.ok`

❌

```jsx
const response = await fetch("/api/login");
const data = await response.json();
```

Better:

```jsx
if (!response.ok) {
  throw new Error("Request failed");
}
```

---

### 4. Allowing duplicate submissions

❌

```jsx
<button type="submit">
```

with no submitting protection.

Better:

```jsx
<button
  type="submit"
  disabled={isSubmitting}
>
```

---

### 5. Resetting before success

Don't do:

```jsx
setForm(initialForm);

await fetch(...);
```

If the request fails, the user's input has already been lost.

Prefer resetting **after successful submission**.

---

### 6. Forgetting `type="button"`

Inside a form:

```jsx
<button type="button">
  Cancel
</button>
```

---

# 🔥 Interview Questions

### Q1. How do you handle form submission in React?

**Answer:**

> I handle the form's `onSubmit` event, prevent the browser's default behavior, validate the data, send it to the backend, and manage loading, success, and error states.

---

### Q2. Why use `onSubmit` instead of `onClick`?

Because `onSubmit` represents the actual form submission and also supports submission through keyboard interaction such as pressing Enter.

---

### Q3. Why use `event.preventDefault()`?

To stop the browser's default form submission/navigation when React is handling the submission.

---

### Q4. Does `fetch()` throw an error for HTTP 404?

**No.**

`fetch()` generally rejects for network-level failures, not normal HTTP error responses. Check:

```js
response.ok
```

---

### Q5. How do you prevent double form submission?

Use a submitting state:

```jsx
<button disabled={isSubmitting}>
```

and set it around the asynchronous request.

---

### Q6. What happens after successful form submission?

Depending on the application, you can:

* reset the form
* show a success message
* navigate to another page
* update application state
* refresh/revalidate relevant data

---

### Q7. What is `FormData`?

`FormData` is a browser API for collecting form field values in a structure that can be submitted to a server, including support for file uploads.

---

# ⭐ Remember

```text
FORM SUBMISSION
      ↓
onSubmit
      ↓
preventDefault()
      ↓
Validate
      ↓
Set loading
      ↓
API request
      ↓
Check response.ok
      ↓
 ┌────┴────┐
 ↓         ↓
Success   Error
 ↓         ↓
Reset/    Show
Navigate  error
      ↓
finally
      ↓
Stop loading
```

### 🎯 One-line interview answer

> **Form submission in React uses `onSubmit` to validate and collect form data, send it to an API, and manage loading, success, and error states without relying on the browser's default navigation.**
