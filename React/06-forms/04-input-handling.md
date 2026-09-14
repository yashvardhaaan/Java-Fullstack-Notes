# 04 — Input Handling in React

## WHY?

A form becomes useful only when React can **receive and process what the user enters**.

For example:

```text id="h3x0u7"
User types:
"Yashvardhan"

        ↓

onChange event

        ↓

event.target.value

        ↓

React state

        ↓

Use the value
for validation / API / UI
```

React provides event handlers such as:

```jsx
onChange
onFocus
onBlur
onSubmit
onInput
```

For normal form input handling, **`onChange` is the most commonly used event**.

---

# WHAT?

**Input handling** means detecting changes made by the user and updating your application accordingly.

Basic pattern:

```jsx id="w6l1e2"
function Form() {
  const [name, setName] = useState("");

  function handleChange(event) {
    setName(event.target.value);
  }

  return (
    <input
      value={name}
      onChange={handleChange}
    />
  );
}
```

The most important part is:

```jsx id="x8w7l4"
event.target.value
```

It gives you the current value of the input.

---

# WHERE?

Input handling is required for:

```text id="9q3y8s"
Text inputs
Email inputs
Password inputs
Search boxes
Textareas
Select dropdowns
Checkboxes
Radio buttons
Forms
```

---

# HOW?

## 1. Text Input

```jsx id="j3m6h8"
const [name, setName] = useState("");

<input
  type="text"
  value={name}
  onChange={(event) => {
    setName(event.target.value);
  }}
/>
```

When the user types:

```text id="f8g2k1"
A
 ↓
Ab
 ↓
Abc
```

React receives each change.

---

# 2. `event.target.value`

Consider:

```jsx id="d4w8n2"
function handleChange(event) {
  console.log(event.target.value);
}
```

If the user enters:

```text
Hello
```

you get:

```text
H
He
Hel
Hell
Hello
```

as the input changes.

---

# 3. Generic Input Handler

For multiple inputs, you don't need a separate function for every input.

Use the `name` attribute:

```jsx id="p8j4y6"
function handleChange(event) {
  const { name, value } = event.target;

  setForm(prev => ({
    ...prev,
    [name]: value
  }));
}
```

Then:

```jsx id="q6x3r2"
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
```

One handler can manage both.

---

# Practical Example — Multiple Inputs

```jsx id="4y2m8w"
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

  return (
    <form>

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

    </form>
  );
}
```

Now:

```text id="2u8c5a"
name     → form.name
email    → form.email
password → form.password
```

---

# 4. Handling Checkbox

Checkboxes are different.

For text inputs:

```jsx id="7v1x3q"
event.target.value
```

For checkboxes, you generally need:

```jsx id="8q4b6m"
event.target.checked
```

Example:

```jsx id="6n3k9x"
const [accepted, setAccepted] = useState(false);

<input
  type="checkbox"
  checked={accepted}
  onChange={(event) => {
    setAccepted(event.target.checked);
  }}
/>
```

Flow:

```text id="4k2m7z"
Checkbox clicked
      ↓
event.target.checked
      ↓
true / false
      ↓
setAccepted()
```

---

# 5. Generic Handler for Text + Checkbox

You can handle both using the input type:

```jsx id="0d7r4x"
function handleChange(event) {
  const { name, type, value, checked } = event.target;

  setForm(prev => ({
    ...prev,
    [name]: type === "checkbox"
      ? checked
      : value
  }));
}
```

Then:

```jsx id="7p9c2n"
<input
  name="username"
  value={form.username}
  onChange={handleChange}
/>

<input
  name="terms"
  type="checkbox"
  checked={form.terms}
  onChange={handleChange}
/>
```

This pattern is extremely useful for larger forms.

---

# 6. Handling Select

For a dropdown:

```jsx id="8s4m1y"
const [country, setCountry] = useState("");

<select
  value={country}
  onChange={(event) => {
    setCountry(event.target.value);
  }}
>
  <option value="">
    Select country
  </option>

  <option value="india">
    India
  </option>

  <option value="usa">
    USA
  </option>
</select>
```

The selected value is:

```jsx id="3z8q5j"
event.target.value
```

---

# 7. Handling Radio Buttons

Suppose the user chooses a role:

```jsx id="1h6k9m"
const [role, setRole] = useState("");

<input
  type="radio"
  name="role"
  value="student"
  checked={role === "student"}
  onChange={(event) => {
    setRole(event.target.value);
  }}
/>

<input
  type="radio"
  name="role"
  value="developer"
  checked={role === "developer"}
  onChange={(event) => {
    setRole(event.target.value);
  }}
/>
```

Now:

```text id="n6q3j8"
role = "student"
```

or:

```text id="m2x8v4"
role = "developer"
```

---

# 8. Handling `<textarea>`

In React, a textarea can be handled similarly to an input:

```jsx id="z6y4w8"
const [message, setMessage] = useState("");

<textarea
  value={message}
  onChange={(event) => {
    setMessage(event.target.value);
  }}
/>
```

---

# 9. Input Transformation

One advantage of handling input through React is that you can transform data.

For example, convert text to uppercase:

```jsx id="g7k2p9"
function handleChange(event) {
  setName(event.target.value.toUpperCase());
}
```

If the user types:

```text
yash
```

state becomes:

```text
YASH
```

Another example:

```jsx id="t2m8v5"
setUsername(
  event.target.value.trimStart()
);
```

---

# 10. Restricting Input

You can also control what gets stored.

For example, only allow numbers:

```jsx id="v8q4n2"
function handleChange(event) {
  const value = event.target.value;

  if (/^\d*$/.test(value)) {
    setAge(value);
  }
}
```

Now:

```text
123  → allowed
12a  → rejected
```

However, remember that HTML input types and server-side validation should also be used appropriately; client-side restrictions alone are not security.

---

# `onChange` vs `onInput`

In React, `onChange` is the normal choice for form controls.

```jsx id="a7m3c5"
<input
  value={name}
  onChange={handleChange}
/>
```

You generally don't need to replace it with `onInput` for ordinary React form handling.

---

# `onFocus` and `onBlur`

Input handling isn't limited to changes.

## `onFocus`

Runs when the input receives focus.

```jsx id="y5x8k1"
<input
  onFocus={() => {
    console.log("Input focused");
  }}
/>
```

Useful for:

```text id="p4q7z2"
Showing hints
Starting UI interactions
Highlighting fields
```

---

## `onBlur`

Runs when the input loses focus.

```jsx id="r8m2v6"
<input
  onBlur={() => {
    console.log("Input lost focus");
  }}
/>
```

Very useful for validation:

```text id="j7c4x9"
User enters email
       ↓
Leaves input
       ↓
onBlur
       ↓
Validate email
       ↓
Show error if needed
```

---

# Complete Example

```jsx id="f3k7p2"
import { useState } from "react";

function ProfileForm() {
  const [form, setForm] = useState({
    name: "",
    email: "",
    country: "",
    terms: false
  });

  function handleChange(event) {
    const {
      name,
      type,
      value,
      checked
    } = event.target;

    setForm(prev => ({
      ...prev,
      [name]: type === "checkbox"
        ? checked
        : value
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
        type="email"
        value={form.email}
        onChange={handleChange}
        placeholder="Email"
      />

      <select
        name="country"
        value={form.country}
        onChange={handleChange}
      >
        <option value="">
          Select country
        </option>

        <option value="india">
          India
        </option>

        <option value="usa">
          USA
        </option>
      </select>

      <label>
        <input
          name="terms"
          type="checkbox"
          checked={form.terms}
          onChange={handleChange}
        />

        Accept terms
      </label>

      <button type="submit">
        Submit
      </button>

    </form>
  );
}
```

This single handler manages:

```text id="9x2m7c"
Text input
Email input
Select
Checkbox
```

---

# WHEN?

Use input handling whenever user interaction should change application state or trigger some logic.

Common patterns:

### While typing

```jsx id="j1p8y3"
onChange
```

### When entering a field

```jsx id="k6m4q9"
onFocus
```

### When leaving a field

```jsx id="n3x7w5"
onBlur
```

### When submitting

```jsx id="c8v2m1"
onSubmit
```

Think:

```text id="g4h9s2"
CHANGE → onChange
FOCUS  → onFocus
BLUR   → onBlur
SUBMIT → onSubmit
```

---

# ⚠️ Common Mistakes

## Mistake 1 — Using `value` for checkbox state

❌

```jsx id="q7p3k5"
<input
  type="checkbox"
  value={accepted}
/>
```

For controlled checked state:

✅

```jsx id="m9x2v6"
<input
  type="checkbox"
  checked={accepted}
  onChange={(e) => setAccepted(e.target.checked)}
/>
```

---

## Mistake 2 — Forgetting `name`

If you use a generic handler:

```jsx id="v5c8j2"
const { name, value } = event.target;
```

your inputs need meaningful `name` attributes.

```jsx id="z3q7n1"
<input name="email" />
```

---

## Mistake 3 — Replacing the entire object

❌

```jsx id="d8m4p2"
setForm({
  email: event.target.value
});
```

This removes the other properties.

Usually you want:

✅

```jsx id="a6y1k9"
setForm(prev => ({
  ...prev,
  email: event.target.value
}));
```

---

# 🎯 Interview Questions

### Q1. How do you get the value of an input in React?

```jsx id="e5k8q3"
event.target.value
```

---

### Q2. How do you get the value of a checkbox?

```jsx id="w2m6v9"
event.target.checked
```

---

### Q3. How can one handler manage multiple inputs?

Use the `name` attribute:

```jsx id="u7q3x8"
function handleChange(event) {
  const { name, value } = event.target;

  setForm(prev => ({
    ...prev,
    [name]: value
  }));
}
```

---

### Q4. What is the difference between `value` and `checked`?

```text id="b8n2m5"
Text/select → value
Checkbox/radio checked state → checked
```

---

### Q5. What is `onBlur` useful for?

**Answer:** It is commonly used for actions that should happen when an element loses focus, such as field-level validation.

---

### Q6. Why use a generic `handleChange`?

**Answer:**

It avoids creating separate change handlers for every form field and makes forms with many inputs easier to maintain.

---

# ⭐ Remember

```text id="p5x8m3"
             INPUT
                │
       ┌────────┼────────┐
       ↓        ↓        ↓
    onChange  onFocus  onBlur
       │
       ↓
 event.target
       │
   ┌───┴────┐
   ↓        ↓
 value    checked
   │        │
   └────┬───┘
        ↓
    React State
```

### Golden pattern:

```jsx id="y4m8q2"
function handleChange(event) {
  const { name, value } = event.target;

  setForm(prev => ({
    ...prev,
    [name]: value
  }));
}
```

### One-line interview answer:

> **Input handling in React means responding to form-control events such as `onChange`, reading values through `event.target.value` or `event.target.checked`, and updating the appropriate application state.**
