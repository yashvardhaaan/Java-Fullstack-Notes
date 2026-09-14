# 02 — Controlled Components in React

## WHY?

When working with forms, React often needs to **know and control the current value of each input**.

For example, if a user types:

```text
Yashvardhan
```

we may want React to immediately know:

```text
name = "Yashvardhan"
```

This allows us to:

* Validate input
* Display errors
* Enable/disable buttons
* Transform input
* Submit data
* Reset fields
* Control what appears in the input

This approach is called a **Controlled Component**.

---

# WHAT?

A **controlled input** is an input whose value is controlled by **React state**.

The basic pattern is:

```jsx id="q9q3r6"
const [value, setValue] = useState("");

<input
  value={value}
  onChange={(event) => {
    setValue(event.target.value);
  }}
/>
```

The flow is:

```text id="zj2k0x"
User types
    ↓
onChange
    ↓
setValue()
    ↓
React state changes
    ↓
Component re-renders
    ↓
value={value}
    ↓
Input displays new value
```

React becomes the **source of truth** for the input value.

---

# WHERE?

Controlled components are commonly used in:

```text id="b5n6m8"
Login forms
Registration forms
Search boxes
Profile forms
Checkout forms
Admin dashboards
Validation-heavy forms
Dynamic forms
```

---

# HOW?

## Basic Controlled Input

```jsx id="4s0zq8"
import { useState } from "react";

function NameForm() {
  const [name, setName] = useState("");

  return (
    <input
      type="text"
      value={name}
      onChange={(event) => {
        setName(event.target.value);
      }}
    />
  );
}
```

There are two important parts:

### 1. `value`

```jsx id="9b3j8q"
value={name}
```

React tells the input what value it should display.

### 2. `onChange`

```jsx id="0p3n2f"
onChange={(event) => {
  setName(event.target.value);
}}
```

When the user types, React updates the state.

---

# The Source of Truth

In a controlled component:

```text id="4l5z7n"
React State
     ↓
   value
     ↓
   Input
```

The state determines what the input displays.

Example:

```jsx id="2k8d5m"
const [email, setEmail] = useState("");
```

```jsx id="5w4n2p"
<input
  value={email}
  onChange={(e) => setEmail(e.target.value)}
/>
```

Here:

```text
email state = "abc@gmail.com"
             ↓
input displays "abc@gmail.com"
```

---

# Practical Example — Login Form

```jsx id="t2p9z1"
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

Now React has complete access to:

```text id="8g8lpx"
email
password
```

---

# Controlled Textarea

A `<textarea>` can also be controlled.

```jsx id="y4w1o9"
function MessageForm() {
  const [message, setMessage] = useState("");

  return (
    <textarea
      value={message}
      onChange={(e) => {
        setMessage(e.target.value);
      }}
    />
  );
}
```

---

# Controlled Select

```jsx id="8wxg2q"
function CountrySelect() {
  const [country, setCountry] = useState("");

  return (
    <select
      value={country}
      onChange={(e) => {
        setCountry(e.target.value);
      }}
    >
      <option value="">
        Select country
      </option>

      <option value="india">
        India
      </option>

      <option value="germany">
        Germany
      </option>
    </select>
  );
}
```

---

# Controlled Checkbox

Checkboxes are slightly different.

For a checkbox, use:

```jsx id="gq2n6p"
checked
```

instead of `value` to represent whether it is checked.

```jsx id="l4b0c3"
function Terms() {
  const [accepted, setAccepted] = useState(false);

  return (
    <label>
      <input
        type="checkbox"
        checked={accepted}
        onChange={(e) => {
          setAccepted(e.target.checked);
        }}
      />

      Accept Terms
    </label>
  );
}
```

The flow:

```text id="zv7s5k"
checked={accepted}
       ↑
   React state

onChange
   ↓
e.target.checked
   ↓
setAccepted()
```

---

# Controlled Radio Buttons

```jsx id="w0n5c2"
function GenderForm() {
  const [gender, setGender] = useState("");

  return (
    <>
      <label>
        <input
          type="radio"
          name="gender"
          value="male"
          checked={gender === "male"}
          onChange={(e) => setGender(e.target.value)}
        />

        Male
      </label>

      <label>
        <input
          type="radio"
          name="gender"
          value="female"
          checked={gender === "female"}
          onChange={(e) => setGender(e.target.value)}
        />

        Female
      </label>
    </>
  );
}
```

Here:

```text id="bq9n3f"
gender = "male"
       ↓
Male radio → checked
Female radio → not checked
```

---

# Handling Multiple Inputs

Instead of creating separate state variables:

```jsx id="4c1h6d"
const [name, setName] = useState("");
const [email, setEmail] = useState("");
const [password, setPassword] = useState("");
```

you can use an object:

```jsx id="z7v8j2"
const [form, setForm] = useState({
  name: "",
  email: "",
  password: ""
});
```

Then:

```jsx id="1q6b4y"
<input
  name="name"
  value={form.name}
  onChange={handleChange}
/>
```

Create a generic handler:

```jsx id="8x9q2k"
function handleChange(event) {
  const { name, value } = event.target;

  setForm(prev => ({
    ...prev,
    [name]: value
  }));
}
```

This is extremely common in React applications.

---

# Complete Multiple-Input Example

```jsx id="y0s5k3"
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

# Why `[name]: value`?

This syntax:

```jsx id="9h8d2k"
[name]: value
```

means:

> Use the value of the `name` variable as the property name.

If:

```text id="t7y4p1"
name = "email"
value = "abc@gmail.com"
```

then:

```jsx id="5v5z9f"
{
  [name]: value
}
```

becomes:

```jsx id="l0p3q4"
{
  email: "abc@gmail.com"
}
```

This allows one `handleChange` function to handle many inputs.

---

# Controlled Component + Validation

One major advantage is that you can validate while the user types.

```jsx id="3y4k9a"
function EmailForm() {
  const [email, setEmail] = useState("");

  const isValid = email.includes("@");

  return (
    <>
      <input
        value={email}
        onChange={(e) => setEmail(e.target.value)}
      />

      {!isValid && email !== "" && (
        <p>Invalid email</p>
      )}
    </>
  );
}
```

Because React knows the current value, validation becomes straightforward.

---

# Controlled Component + Button State

You can also use the state to control other UI.

```jsx id="3x8j6d"
function Form() {
  const [email, setEmail] = useState("");

  return (
    <>
      <input
        value={email}
        onChange={(e) => setEmail(e.target.value)}
      />

      <button disabled={!email}>
        Continue
      </button>
    </>
  );
}
```

The button automatically reflects the form state.

---

# Controlled vs Uncontrolled

This is one of the **most important React form concepts**.

| Controlled                      | Uncontrolled                                 |
| ------------------------------- | -------------------------------------------- |
| React state controls value      | DOM maintains value                          |
| Uses `value` / `checked`        | Often uses `defaultValue` / `defaultChecked` |
| Uses `onChange` to update state | Can use `ref` to read value                  |
| Easy validation                 | Less React state code                        |
| React is source of truth        | DOM is source of truth                       |

### Controlled

```jsx id="p3d7w1"
<input
  value={name}
  onChange={(e) => setName(e.target.value)}
/>
```

### Uncontrolled

```jsx id="a1k5v7"
<input
  defaultValue="Yash"
  ref={inputRef}
/>
```

We will study uncontrolled components in the **next topic**.

---

# ⚠️ Common Mistakes

## Mistake 1 — `value` without `onChange`

```jsx id="4b8m3y"
<input value={name} />
```

This makes the input effectively read-only because React keeps providing the same value.

If the input is intended to be editable, provide an appropriate `onChange`.

---

## Mistake 2 — Accidentally switching between controlled and uncontrolled

Avoid starting with:

```jsx id="m3k8v0"
const [name, setName] = useState();
```

and later giving it a string.

Prefer:

```jsx id="w8k2s1"
const [name, setName] = useState("");
```

For a controlled text input, initialize the state to a suitable value such as an empty string.

---

## Mistake 3 — Mutating form state directly

❌

```jsx id="1c4x8n"
form.email = "abc@gmail.com";
```

React state should be updated through its setter.

✅

```jsx id="6q9y3b"
setForm(prev => ({
  ...prev,
  email: "abc@gmail.com"
}));
```

---

# WHEN?

Use controlled components when:

* You need real-time validation
* You need to enable/disable UI based on input
* You need to transform input
* You need the current value during rendering
* You need to reset fields from React
* Form logic is complex
* Form values affect other UI

For example:

```text id="2f7n1c"
Typing password
       ↓
React state
       ↓
Check password strength
       ↓
Show strength indicator
       ↓
Enable/disable Submit
```

Controlled components are often the natural choice for these situations.

---

# 🎯 Interview Questions

### Q1. What is a controlled component?

**Answer:**

A controlled form element is one whose current value is controlled by React state through properties such as `value` or `checked`.

---

### Q2. What is the source of truth in a controlled component?

**Answer:**

React state.

```text id="z2n8q4"
React State
    ↓
Input value
```

---

### Q3. How do you create a controlled input?

```jsx id="3q9y5v"
const [name, setName] = useState("");

<input
  value={name}
  onChange={(e) => setName(e.target.value)}
/>
```

---

### Q4. How do you control a checkbox?

Use:

```jsx id="x4g7k2"
checked={isChecked}
```

and:

```jsx id="j7n2p8"
onChange={(e) => setIsChecked(e.target.checked)}
```

---

### Q5. Why are controlled components useful?

**Answer:**

They give React direct control over form values, making validation, conditional UI, transformation, resetting, and submission logic easier.

---

### Q6. What happens if you provide `value` without `onChange`?

**Answer:**

The input becomes effectively read-only unless its value is changed through some other mechanism.

---

### Q7. Controlled vs uncontrolled?

**Answer:**

```text id="a9y1v6"
Controlled
→ React state is the source of truth

Uncontrolled
→ DOM is the source of truth
```

---

# ⭐ Remember

```text id="u5c2b8"
CONTROLLED COMPONENT

React State
     ↓
  value/checked
     ↓
    Input
     ↓
   onChange
     ↓
React State
```

### The golden pattern:

```jsx id="k4w8z0"
const [value, setValue] = useState("");

<input
  value={value}
  onChange={(e) => setValue(e.target.value)}
/>
```

### One-line interview answer:

> **A controlled component is a form element whose value is controlled by React state, making React the source of truth for the input.**
