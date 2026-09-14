# 08 — React Hook Form

## WHY?

As forms become larger, managing every field manually can create a lot of code.

Without a form library, you may need to manage:

```text id="a1f4k7"
values
errors
touched fields
validation
submission
reset
loading
```

For a large form, this can become difficult to maintain.

**React Hook Form** is a popular library designed to simplify form management in React.

---

# WHAT?

React Hook Form is a third-party React library for building and managing forms.

Install it with:

```bash
npm install react-hook-form
```

The main Hook is:

```jsx
useForm()
```

Example:

```jsx
import { useForm } from "react-hook-form";

function LoginForm() {
  const {
    register,
    handleSubmit
  } = useForm();

  function onSubmit(data) {
    console.log(data);
  }

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register("email")} />

      <input
        type="password"
        {...register("password")}
      />

      <button type="submit">
        Login
      </button>
    </form>
  );
}
```

---

# WHERE?

React Hook Form is useful for:

```text id="n7c2m5"
Large forms
Registration forms
Checkout forms
Multi-field forms
Complex validation
Dynamic fields
Forms with many inputs
```

It is especially useful when manually managing every field with `useState` would become repetitive.

---

# HOW?

## 1. Import `useForm`

```jsx
import { useForm } from "react-hook-form";
```

---

## 2. Initialize the form

```jsx
const {
  register,
  handleSubmit
} = useForm();
```

The two most important functions initially are:

```text id="r8m3q6"
register()
handleSubmit()
```

---

# 3. Register an Input

Instead of:

```jsx
const [email, setEmail] = useState("");

<input
  value={email}
  onChange={(e) => setEmail(e.target.value)}
/>
```

React Hook Form lets you write:

```jsx
<input {...register("email")} />
```

`register("email")` connects the input to the form.

Conceptually:

```text id="k4x8p2"
register("email")
       ↓
React Hook Form
       ↓
email field
```

---

# 4. Handle Submission

```jsx
<form onSubmit={handleSubmit(onSubmit)}>
```

Then:

```jsx
function onSubmit(data) {
  console.log(data);
}
```

If the user enters:

```text id="w7m2n9"
email = yash@gmail.com
password = abc12345
```

you can receive:

```js
{
  email: "yash@gmail.com",
  password: "abc12345"
}
```

---

# Complete Basic Example

```jsx
import { useForm } from "react-hook-form";

function LoginForm() {
  const {
    register,
    handleSubmit
  } = useForm();

  function onSubmit(data) {
    console.log(data);
  }

  return (
    <form onSubmit={handleSubmit(onSubmit)}>

      <label>
        Email
      </label>

      <input
        type="email"
        {...register("email")}
      />

      <label>
        Password
      </label>

      <input
        type="password"
        {...register("password")}
      />

      <button type="submit">
        Login
      </button>

    </form>
  );
}
```

---

# Form Validation

One of the biggest advantages is built-in integration with validation rules.

Example:

```jsx
<input
  {...register("email", {
    required: "Email is required"
  })}
/>
```

For password:

```jsx
<input
  type="password"
  {...register("password", {
    required: "Password is required",
    minLength: {
      value: 8,
      message: "Password must be at least 8 characters"
    }
  })}
/>
```

---

# Reading Errors

Get errors from `formState`:

```jsx
const {
  register,
  handleSubmit,
  formState: { errors }
} = useForm();
```

Then:

```jsx
{errors.email && (
  <p>{errors.email.message}</p>
)}
```

Complete example:

```jsx
import { useForm } from "react-hook-form";

function RegistrationForm() {
  const {
    register,
    handleSubmit,
    formState: { errors }
  } = useForm();

  function onSubmit(data) {
    console.log(data);
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
          required: "Password is required",
          minLength: {
            value: 8,
            message:
              "Password must be at least 8 characters"
          }
        })}
      />

      {errors.password && (
        <p>{errors.password.message}</p>
      )}

      <button type="submit">
        Register
      </button>

    </form>
  );
}
```

---

# `register()`

`register()` connects a form control to React Hook Form.

```jsx
<input {...register("username")} />
```

You can provide validation rules:

```jsx
<input
  {...register("username", {
    required: "Username is required",
    minLength: {
      value: 3,
      message: "Minimum 3 characters"
    }
  })}
/>
```

---

# `handleSubmit()`

`handleSubmit()` handles the submission process.

```jsx
<form onSubmit={handleSubmit(onSubmit)}>
```

It:

```text id="v5n8q2"
Collects form data
       ↓
Runs validation
       ↓
If valid
   ↓
onSubmit(data)

If invalid
   ↓
errors
```

---

# `formState`

React Hook Form provides form information through `formState`.

For example:

```jsx
const {
  formState: {
    errors,
    isSubmitting,
    isDirty,
    isValid
  }
} = useForm();
```

These can tell you:

```text id="m3x7k9"
errors
   ↓
Validation errors

isSubmitting
   ↓
Submission in progress

isDirty
   ↓
User changed the form

isValid
   ↓
Current validation state
```

---

# Disabling Submit

```jsx
const {
  handleSubmit,
  formState: { isSubmitting }
} = useForm();
```

Then:

```jsx
<button
  type="submit"
  disabled={isSubmitting}
>
  {isSubmitting ? "Submitting..." : "Submit"}
</button>
```

This gives the user feedback during an asynchronous submission.

---

# Default Values

You can provide initial values:

```jsx
const {
  register,
  handleSubmit
} = useForm({
  defaultValues: {
    name: "",
    email: "",
    country: "India"
  }
});
```

Then:

```jsx
<input {...register("name")} />

<input {...register("email")} />

<select {...register("country")}>
  <option value="India">
    India
  </option>

  <option value="USA">
    USA
  </option>
</select>
```

---

# Resetting the Form

React Hook Form provides `reset()`.

```jsx
const {
  register,
  handleSubmit,
  reset
} = useForm();
```

Then:

```jsx
reset();
```

You can also reset to specific values:

```jsx
reset({
  name: "",
  email: ""
});
```

---

# Getting Form Values

You can use `getValues()`:

```jsx
const {
  register,
  getValues
} = useForm();
```

Then:

```jsx
const email = getValues("email");
```

You can also get multiple values:

```jsx
const values = getValues();
```

---

# Watching Values

React Hook Form also provides `watch()`.

```jsx
const {
  register,
  watch
} = useForm();

const password = watch("password");
```

Now the component can react to changes in that field.

Example:

```jsx
const password = watch("password");

<p>
  Password length: {password.length}
</p>
```

This is useful when one part of the UI depends on form values.

---

# React Hook Form vs Manual `useState`

### Manual React

```jsx
const [email, setEmail] = useState("");

<input
  value={email}
  onChange={(e) => setEmail(e.target.value)}
/>
```

For ten fields, you may end up with a lot of repetitive logic.

### React Hook Form

```jsx
<input {...register("email")} />
```

The library handles much of the form bookkeeping.

---

# Important Concept

React Hook Form is designed to work efficiently with **uncontrolled inputs by default**, using refs and its own form management mechanisms rather than requiring React state updates for every keystroke.

This can reduce unnecessary re-rendering compared with manually controlling every input.

But it can also work with controlled components when necessary, using tools such as `Controller`.

---

# `Controller`

Sometimes you use a component from another UI library that expects controlled behavior.

For example:

```text id="v8m2q5"
Material UI
Date picker
Select component
Custom input
Third-party component
```

React Hook Form provides `Controller`.

Conceptually:

```jsx
<Controller
  name="country"
  control={control}
  render={({ field }) => (
    <CustomSelect {...field} />
  )}
/>
```

So:

```text id="q4x7n8"
Normal input
   ↓
register()

Controlled third-party component
   ↓
Controller
```

---

# WHEN?

Use React Hook Form when:

```text id="z5m8q2"
Many form fields
Complex validation
Repeated form patterns
Need form state management
Need efficient form handling
Dynamic forms
```

For a tiny form:

```jsx
<input />
<button />
```

you may not need a form library.

Don't add a dependency just to handle two simple fields.

---

# React Hook Form + Schema Validation

For larger applications, React Hook Form is commonly combined with schema-validation libraries.

Conceptually:

```text id="n7q3x9"
React Hook Form
       ↓
Form handling
       +
Schema validator
       ↓
Validation rules
```

Common schema-validation approaches include libraries such as:

```text
Zod
Yup
```

The exact integration depends on the validation library and project requirements.

---

# Common Mistakes

## ❌ Mistake 1 — Forgetting `register`

```jsx
<input />
```

If you expect React Hook Form to manage that field, register it:

```jsx
<input {...register("email")} />
```

---

## ❌ Mistake 2 — Forgetting `handleSubmit`

Instead of:

```jsx
<form onSubmit={onSubmit}>
```

normally use:

```jsx
<form onSubmit={handleSubmit(onSubmit)}>
```

so React Hook Form can process and validate the submission.

---

## ❌ Mistake 3 — Confusing `errors` with values

```text id="g4k8m2"
form values → submitted data

errors → validation problems
```

They are different pieces of information.

---

## ❌ Mistake 4 — Using `Controller` for everything

You generally don't need `Controller` for every normal HTML input.

For standard inputs:

```jsx
<input {...register("name")} />
```

is usually enough.

Use `Controller` when a controlled component needs that integration.

---

# 🎯 Interview Questions

### Q1. What is React Hook Form?

**Answer:**

React Hook Form is a React library for managing form state, validation, submission, and related form behavior with relatively little boilerplate.

---

### Q2. What does `register()` do?

**Answer:**

It registers a form control with React Hook Form so the library can track its value, validation rules, and other form information.

---

### Q3. What does `handleSubmit()` do?

**Answer:**

It processes the form submission, performs validation, and calls the supplied submit handler when the form passes validation.

---

### Q4. What is `formState`?

**Answer:**

It provides information about the current state of the form, such as validation errors, whether the form is dirty, whether it is submitting, and validity information.

---

### Q5. What is `Controller`?

**Answer:**

`Controller` is used to integrate controlled components, especially custom or third-party UI components, with React Hook Form.

---

### Q6. React Hook Form vs controlled components?

**Answer:**

React Hook Form commonly uses an uncontrolled-input approach for efficiency, while traditional controlled components store the current input value in React state. React Hook Form can also integrate controlled components when required.

---

### Q7. Why use React Hook Form?

**Answer:**

It reduces boilerplate for complex forms and provides convenient APIs for registration, validation, errors, submission, resetting, and form-state tracking.

---

# ⭐ Remember

```text id="q8m3v6"
             React Hook Form
                    │
          ┌─────────┼─────────┐
          ↓         ↓         ↓
      register  validation  formState
          │         │         │
          ↓         ↓         ↓
        Inputs    errors    status
                    │
                    ↓
              handleSubmit
                    │
                    ↓
                  API
```

### Most important APIs:

```text id="x4n7p2"
useForm()
   ↓
register()
   ↓
handleSubmit()
   ↓
formState
   ↓
errors
   ↓
reset()
   ↓
watch()
   ↓
Controller (when needed)
```

### One-line interview answer:

> **React Hook Form is a React form-management library that simplifies form registration, validation, submission, and state tracking, commonly using uncontrolled inputs for efficient form handling.**
