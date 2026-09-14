# 05 — Form State in React

## WHY?

A real form usually contains **multiple pieces of information**.

For example, a registration form may have:

```text id="q6v3x1"
Name
Email
Password
Phone
Country
Terms accepted
```

React needs a way to keep track of all this information.

That information is called **form state**.

Good form-state design makes it easier to:

* Read user input
* Validate fields
* Show errors
* Disable/enable submission
* Reset the form
* Submit data to an API
* Track loading/submission status

---

# WHAT?

**Form state** is the collection of values and UI information associated with a form.

For example:

```jsx id="4m8q2z"
const [form, setForm] = useState({
  name: "",
  email: "",
  password: ""
});
```

Here:

```text id="r7k3m1"
form
 ├── name
 ├── email
 └── password
```

But form state can contain more than just input values:

```jsx id="x2p9v6"
const [formState, setFormState] = useState({
  values: {
    name: "",
    email: ""
  },
  errors: {},
  touched: {},
  isSubmitting: false
});
```

So think of form state as:

```text id="g8n4y2"
FORM STATE
     │
     ├── values
     ├── errors
     ├── touched
     ├── dirty
     └── submitting
```

---

# WHERE?

Form state appears in almost every serious form:

```text id="b4w7k9"
Login
Registration
Checkout
Profile update
Job application
Search/filter forms
Admin panels
Multi-step forms
```

---

# HOW?

## 1. Simple Form State

For a small form:

```jsx id="u5k8m2"
const [name, setName] = useState("");
const [email, setEmail] = useState("");
```

This is perfectly valid.

```text id="z7q3p1"
name
email
```

are separate state variables.

---

# 2. Object-Based Form State

When the form has several related fields, an object can be convenient:

```jsx id="n8v2x5"
const [form, setForm] = useState({
  name: "",
  email: "",
  password: ""
});
```

Update one field:

```jsx id="f3m9q7"
setForm(prev => ({
  ...prev,
  email: "abc@gmail.com"
}));
```

The spread operator preserves the other fields.

---

# 3. Generic Change Handler

Instead of:

```jsx id="y4k6p8"
function handleNameChange(e) {
  // ...
}

function handleEmailChange(e) {
  // ...
}

function handlePasswordChange(e) {
  // ...
}
```

we can use one handler:

```jsx id="w2n7c5"
function handleChange(event) {
  const { name, value } = event.target;

  setForm(prev => ({
    ...prev,
    [name]: value
  }));
}
```

Then:

```jsx id="j6m3q9"
<input
  name="name"
  value={form.name}
  onChange={handleChange}
/>

<input
  name="email"
  value={form.email}
  onChange={handleChange}
/>

<input
  name="password"
  value={form.password}
  onChange={handleChange}
/>
```

---

# 4. Understanding `[name]: value`

This is important.

Suppose:

```jsx id="x9k4m2"
const name = "email";
const value = "yash@gmail.com";
```

Then:

```jsx id="v7p3n8"
{
  [name]: value
}
```

produces:

```jsx id="h2q6w5"
{
  email: "yash@gmail.com"
}
```

This allows one handler to update different fields.

---

# 5. Complete Form State Example

```jsx id="r5m8x2"
import { useState } from "react";

function RegistrationForm() {
  const [form, setForm] = useState({
    name: "",
    email: "",
    password: ""
  });

  function handleChange(event) {
    const { name, value } = event.target;

    setForm(prev => ({
      ...prev,
      [name]: value
    }));
  }

  function handleSubmit(event) {
    event.preventDefault();

    console.log(form);
  }

  return (
    <form onSubmit={handleSubmit}>

      <input
        name="name"
        value={form.name}
        onChange={handleChange}
        placeholder="Name"
      />

      <input
        name="email"
        value={form.email}
        onChange={handleChange}
        placeholder="Email"
      />

      <input
        name="password"
        type="password"
        value={form.password}
        onChange={handleChange}
        placeholder="Password"
      />

      <button type="submit">
        Register
      </button>

    </form>
  );
}
```

---

# Form State Is More Than Input Values

A professional form often needs additional state.

For example:

```jsx id="n3w8k5"
const [values, setValues] = useState({
  email: "",
  password: ""
});

const [errors, setErrors] = useState({});

const [isSubmitting, setIsSubmitting] = useState(false);
```

Now:

```text id="m6q2x9"
values
  ↓
What user entered

errors
  ↓
What's invalid

isSubmitting
  ↓
Is submission currently happening?
```

---

# 6. Error State

Example:

```jsx id="k8y4m2"
const [errors, setErrors] = useState({});
```

Suppose the email is invalid:

```jsx id="v3n7q1"
setErrors({
  email: "Invalid email address"
});
```

Then render:

```jsx id="x5p9r4"
{errors.email && (
  <p>{errors.email}</p>
)}
```

The UI becomes:

```text id="d7m2k8"
Email
[ abc ]

Invalid email address
```

---

# 7. Touched State

Sometimes you don't want to show an error immediately.

For example:

```text id="g8q4n1"
User opens form
       ↓
Don't show errors yet
       ↓
User enters email
       ↓
Leaves field
       ↓
Validate
       ↓
Show error
```

We can track whether a field has been touched:

```jsx id="z2m6p9"
const [touched, setTouched] = useState({});
```

On blur:

```jsx id="r7k3x5"
function handleBlur(event) {
  const { name } = event.target;

  setTouched(prev => ({
    ...prev,
    [name]: true
  }));
}
```

Then:

```jsx id="j5n8q2"
{touched.email && errors.email && (
  <p>{errors.email}</p>
)}
```

---

# 8. Dirty State

A field/form can also be considered **dirty** when the user has changed it from its initial value.

For example:

```text id="b4x7m2"
Initial:
email = ""

User types:
email = "abc@gmail.com"

Form is now dirty.
```

This is useful for:

```text id="y6q3n9"
Unsaved changes warning
Enable Save button
Reset confirmation
Navigation protection
```

---

# 9. Submission State

When submitting data to an API:

```jsx id="p8m2v5"
const [isSubmitting, setIsSubmitting] = useState(false);
```

Then:

```jsx id="q3x7n1"
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

```jsx id="k9m4w6"
<button
  type="submit"
  disabled={isSubmitting}
>
  {isSubmitting ? "Submitting..." : "Submit"}
</button>
```

This prevents confusing UI while the request is running.

---

# 10. Form State + Validation

A common architecture:

```text id="m7q2x9"
User Input
    ↓
values
    ↓
Validation
    ↓
errors
    ↓
Display errors
    ↓
Submit
    ↓
API
```

Example:

```jsx id="c8n3p6"
function validate(form) {
  const errors = {};

  if (!form.email) {
    errors.email = "Email is required";
  }

  if (!form.password) {
    errors.password = "Password is required";
  }

  return errors;
}
```

Then:

```jsx id="v4m8x2"
function handleSubmit(event) {
  event.preventDefault();

  const validationErrors = validate(form);

  if (Object.keys(validationErrors).length > 0) {
    setErrors(validationErrors);
    return;
  }

  // Submit to API
}
```

---

# 11. Resetting Form State

Because React owns the values, resetting is simple.

```jsx id="q5m9x3"
setForm({
  name: "",
  email: "",
  password: ""
});
```

And:

```jsx id="w2k7n4"
setErrors({});
```

For example:

```jsx id="j8p3v6"
function handleReset() {
  setForm({
    name: "",
    email: "",
    password: ""
  });

  setErrors({});
}
```

Button:

```jsx id="n4x7m2"
<button
  type="button"
  onClick={handleReset}
>
  Reset
</button>
```

---

# 12. Form State Design

Don't store unnecessary duplicate information.

### ❌ Bad

```jsx id="r6m2k9"
const [firstName, setFirstName] = useState("");
const [lastName, setLastName] = useState("");

const [fullName, setFullName] = useState("");
```

`fullName` can be derived:

```jsx id="p3x8n5"
const fullName = `${firstName} ${lastName}`;
```

Now there is only one source of truth.

This follows the important React principle:

> **Don't store information in state if it can be calculated from existing state or props.**

---

# WHEN?

Use separate state variables when:

```text id="f8q2m5"
Form is small
Fields are independent
```

Use an object when:

```text id="y4n7k2"
Many related fields
Generic change handler
Form data naturally belongs together
```

Use more structured state when:

```text id="v6m3p8"
Validation
Touched fields
Submission status
Complex transitions
Multi-step forms
```

For highly complex forms, `useReducer` or a form library may make the state transitions easier to manage.

---

# `useState` vs `useReducer` for Forms

### Simple form

```jsx id="b2k8m4"
const [form, setForm] = useState({
  name: "",
  email: ""
});
```

Good.

### Complex form

```jsx id="x7n3q9"
const [state, dispatch] = useReducer(
  formReducer,
  initialState
);
```

Useful when you have many actions:

```text id="m5q8v2"
CHANGE_FIELD
BLUR_FIELD
VALIDATE
SUBMIT_START
SUBMIT_SUCCESS
SUBMIT_ERROR
RESET
```

---

# ⚠️ Common Mistakes

## Mistake 1 — Losing other fields

❌

```jsx id="r8m3x6"
setForm({
  email: "abc@gmail.com"
});
```

This replaces the entire object.

✅

```jsx id="k2q7n4"
setForm(prev => ({
  ...prev,
  email: "abc@gmail.com"
}));
```

---

## Mistake 2 — Storing derived data

❌

```jsx id="z6p3m8"
const [fullName, setFullName] = useState("");
```

if it can simply be calculated from:

```jsx id="j4x8q2"
firstName
lastName
```

Prefer:

```jsx id="n7m2v5"
const fullName = `${firstName} ${lastName}`;
```

---

## Mistake 3 — Mixing too many unrelated states

Avoid creating a huge object containing everything in your application.

```text id="w5q9k3"
form
 ├── user
 ├── products
 ├── notifications
 ├── theme
 ├── dashboard
 └── unrelated application state
```

Keep form state focused on the form.

---

# 🎯 Interview Questions

### Q1. What is form state?

**Answer:**

Form state is the collection of information needed to represent a form, including field values and often related information such as validation errors, touched fields, and submission status.

---

### Q2. How can you manage multiple form fields with one state?

Use an object:

```jsx id="c7m2x9"
const [form, setForm] = useState({
  name: "",
  email: ""
});
```

and update dynamically:

```jsx id="n4q8v6"
setForm(prev => ({
  ...prev,
  [name]: value
}));
```

---

### Q3. Why use the spread operator when updating form state?

Because state objects should be treated immutably and we usually want to update one field while preserving the other fields.

---

### Q4. What is touched state?

**Answer:**

Touched state tracks whether the user has interacted with a particular field, commonly so validation errors can be shown at an appropriate time.

---

### Q5. What is dirty state?

**Answer:**

It indicates that the form or field has changed from its initial value.

---

### Q6. Should derived values be stored in form state?

Usually no.

If a value can reliably be calculated from existing state or props, derive it instead of storing duplicate state.

---

### Q7. When would you choose `useReducer` for a form?

When the form has complex state transitions or many related actions, such as field changes, validation, submission, success/error states, and reset.

---

# ⭐ Remember

```text id="e5m8q2"
              FORM STATE
                   │
        ┌──────────┼──────────┐
        ↓          ↓          ↓
      Values     Errors    Status
        │          │          │
        ↓          ↓          ↓
      Input    Validation  Submitting
```

The fundamental structure is:

```jsx id="u8n3p6"
const [form, setForm] = useState({
  name: "",
  email: ""
});
```

Update:

```jsx id="x4m7q2"
setForm(prev => ({
  ...prev,
  [name]: value
}));
```

### One-line interview answer:

> **Form state is the state used to represent a form's input values and related UI information such as validation errors, touched fields, and submission status.**
