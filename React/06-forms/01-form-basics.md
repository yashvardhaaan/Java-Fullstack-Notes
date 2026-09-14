# 01 — Form Basics in React

## WHY?

Forms are one of the most common ways users **send data to an application**.

Examples:

```text
Login
Registration
Search
Contact form
Payment
Feedback
Profile update
Job application
```

In React, forms need special attention because we usually want React to:

* Read input values
* Track changes
* Validate data
* Display errors
* Submit data
* Reset the form
* Send data to an API

Example:

```text
User enters email
       ↓
React receives input
       ↓
Validate email
       ↓
User clicks Submit
       ↓
React handles submission
       ↓
Send data to API
```

---

# WHAT?

A **form** in React is built using normal HTML form elements such as:

```jsx
<form>
<input />
<textarea />
<select>
<button />
```

React adds JavaScript logic to control how these elements behave.

A basic form:

```jsx
function LoginForm() {
  return (
    <form>
      <input type="email" />
      <input type="password" />

      <button type="submit">
        Login
      </button>
    </form>
  );
}
```

This is essentially normal HTML inside JSX.

---

# WHERE?

Forms are used whenever the application needs **user input**.

For example:

### Login

```jsx
<form>
  <input type="email" />
  <input type="password" />
  <button type="submit">
    Login
  </button>
</form>
```

### Registration

```jsx
<form>
  <input type="text" />
  <input type="email" />
  <input type="password" />

  <button type="submit">
    Register
  </button>
</form>
```

### Search

```jsx
<form>
  <input type="search" />
  <button type="submit">
    Search
  </button>
</form>
```

---

# HOW?

## 1. Create a `<form>`

```jsx
function ContactForm() {
  return (
    <form>
      {/* inputs */}
    </form>
  );
}
```

---

## 2. Add input fields

```jsx
function ContactForm() {
  return (
    <form>
      <input type="text" />
      <input type="email" />
      <textarea />
    </form>
  );
}
```

Different HTML elements collect different types of information.

---

# Common Form Elements

| Element                   | Purpose           |
| ------------------------- | ----------------- |
| `<input>`                 | Single-line input |
| `<textarea>`              | Multi-line text   |
| `<select>`                | Dropdown          |
| `<option>`                | Dropdown option   |
| `<input type="checkbox">` | Boolean selection |
| `<input type="radio">`    | Choose one option |
| `<button>`                | Action/submit     |

---

# 3. Add Labels

Always give form controls meaningful labels.

### Better accessibility

```jsx
function LoginForm() {
  return (
    <form>
      <label htmlFor="email">
        Email
      </label>

      <input
        id="email"
        type="email"
      />

      <label htmlFor="password">
        Password
      </label>

      <input
        id="password"
        type="password"
      />

      <button type="submit">
        Login
      </button>
    </form>
  );
}
```

Important React detail:

HTML uses:

```html
for="email"
```

JSX uses:

```jsx
htmlFor="email"
```

because `for` is a JavaScript keyword.

---

# 4. The `name` Attribute

The `name` attribute identifies a form field.

```jsx
<input
  type="email"
  name="email"
/>
```

Example:

```jsx
<form>
  <input
    type="text"
    name="username"
  />

  <input
    type="email"
    name="email"
  />

  <input
    type="password"
    name="password"
  />
</form>
```

You will use `name` frequently when handling multiple inputs.

---

# 5. Submit Button

Use:

```jsx
<button type="submit">
  Submit
</button>
```

inside the form.

Example:

```jsx
function LoginForm() {
  return (
    <form>
      <input type="email" />
      <input type="password" />

      <button type="submit">
        Login
      </button>
    </form>
  );
}
```

Clicking the button submits the form.

---

# 6. Handling Form Submission

In React, we normally handle submission using `onSubmit`.

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

---

# WHY `event.preventDefault()`?

By default, the browser performs its normal form submission behavior.

That can cause the page to navigate/reload.

React applications commonly want to handle the submission with JavaScript instead.

Therefore:

```jsx
event.preventDefault();
```

prevents the browser's default submission behavior.

Then React can handle the data.

```text
Submit
  ↓
onSubmit
  ↓
preventDefault()
  ↓
Read form data
  ↓
Validate
  ↓
API request
```

---

# Practical Example — Login Form

```jsx
import { useState } from "react";

function LoginForm() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  function handleSubmit(event) {
    event.preventDefault();

    console.log({
      email,
      password
    });
  }

  return (
    <form onSubmit={handleSubmit}>

      <label htmlFor="email">
        Email
      </label>

      <input
        id="email"
        type="email"
        name="email"
        value={email}
        onChange={(event) => {
          setEmail(event.target.value);
        }}
      />

      <label htmlFor="password">
        Password
      </label>

      <input
        id="password"
        type="password"
        name="password"
        value={password}
        onChange={(event) => {
          setPassword(event.target.value);
        }}
      />

      <button type="submit">
        Login
      </button>

    </form>
  );
}
```

Here we have:

```text
useState
   ↓
Store input values

onChange
   ↓
Update state

onSubmit
   ↓
Handle form submission

preventDefault()
   ↓
Prevent browser's default submission
```

**This example is also introducing controlled components**, which is the next topic.

---

# GET vs POST

Traditional HTML forms can submit data using different HTTP methods.

```html
<form method="GET">
```

or:

```html
<form method="POST">
```

### GET

Usually used when submitting data that can appear in the URL.

Example:

```text
Search
Filters
```

### POST

Usually used when sending data to create/process something.

Example:

```text
Login
Registration
Create account
Submit application
```

In modern React applications, you will often intercept the submission with `onSubmit` and make an API request using `fetch`, a library, or a framework-specific mechanism.

---

# Form Data

For a simple form, React state can hold the values:

```jsx
const [email, setEmail] = useState("");
```

For larger forms, you may eventually use an object:

```jsx
const [formData, setFormData] = useState({
  name: "",
  email: "",
  password: ""
});
```

Then:

```text
formData
├── name
├── email
└── password
```

This becomes important when we study **Form State**.

---

# WHEN?

Use a React form when the user needs to provide or modify data.

Typical workflow:

```text
                 FORM
                   │
                   ↓
             User enters data
                   │
                   ↓
              Track input
                   │
                   ↓
               Validate
                   │
                   ↓
                Submit
                   │
                   ↓
               API/Server
                   │
                   ↓
             Success/Error
```

---

# ⚠️ Common Mistakes

## Mistake 1 — Using `onClick` instead of `onSubmit`

### Less appropriate

```jsx
<button onClick={handleSubmit}>
  Submit
</button>
```

### Better

```jsx
<form onSubmit={handleSubmit}>
  <button type="submit">
    Submit
  </button>
</form>
```

Why?

Because `onSubmit` represents the **form submission event**, including submissions triggered by keyboard interaction such as pressing Enter.

---

## Mistake 2 — Forgetting `preventDefault()`

```jsx
function handleSubmit(event) {
  console.log("submitted");
}
```

The browser's default form behavior can still occur.

For a client-side React submission:

```jsx
function handleSubmit(event) {
  event.preventDefault();

  // handle submission
}
```

---

## Mistake 3 — Missing labels

Avoid:

```jsx
<input type="email" />
```

Prefer:

```jsx
<label htmlFor="email">
  Email
</label>

<input
  id="email"
  type="email"
/>
```

This improves accessibility and usability.

---

## Mistake 4 — Wrong button type

Inside a form:

```jsx
<button>
  Save
</button>
```

A button without an explicit `type` defaults to submit in HTML.

If it isn't supposed to submit:

```jsx
<button type="button">
  Cancel
</button>
```

For submission:

```jsx
<button type="submit">
  Save
</button>
```

---

# 🎯 Interview Questions

### Q1. How do you handle form submission in React?

**Answer:**

Use the form's `onSubmit` event:

```jsx
<form onSubmit={handleSubmit}>
```

and generally call:

```jsx
event.preventDefault();
```

when handling the submission entirely on the client.

---

### Q2. Why use `onSubmit` instead of `onClick`?

**Answer:**

`onSubmit` represents the form submission itself and works for different ways of submitting the form, including pressing Enter. It also keeps the submission logic associated with the `<form>`.

---

### Q3. Why do we use `event.preventDefault()`?

**Answer:**

It prevents the browser's default form submission behavior, allowing React/JavaScript to handle the submission without the browser navigating or reloading the page.

---

### Q4. What is the purpose of the `name` attribute?

**Answer:**

It identifies a form field and is useful when reading or serializing form data.

---

### Q5. Why do we use `htmlFor` instead of `for` in JSX?

**Answer:**

JSX uses the React/DOM property name `htmlFor` to associate a `<label>` with an input.

---

### Q6. What is the difference between `type="submit"` and `type="button"`?

```jsx
<button type="submit">
```

submits the form.

```jsx
<button type="button">
```

does not submit the form by itself.

---

# ⭐ Remember

```text
<form>
   ↓
<input>
<textarea>
<select>
   ↓
User enters data
   ↓
onChange
   ↓
React handles values
   ↓
onSubmit
   ↓
preventDefault()
   ↓
Validate
   ↓
Send data
```

### One-line interview answer:

> **A React form uses standard HTML form elements combined with React event handling, typically using `onSubmit` to process the submitted data and `preventDefault()` when the browser's default submission behavior should be prevented.**
