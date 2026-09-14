# 03 — Uncontrolled Components in React

## WHY?

In a **controlled component**, React state controls the input value.

But sometimes we don't need React to track every keystroke.

Instead, we can let the **DOM manage the input value** and access it when needed.

This is called an **Uncontrolled Component**.

It can be useful when:

* The form is simple
* You don't need the value on every render
* You only need the value when submitting
* You are working with existing non-React code
* You want to use a DOM `ref`

---

# WHAT?

An **uncontrolled component** is a form element where the **DOM is the source of truth**, rather than React state.

Instead of:

```jsx
value={name}
```

we commonly use:

```jsx
defaultValue="Yash"
```

and a `ref` when we need to read the current value.

### Controlled

```jsx
const [name, setName] = useState("");

<input
  value={name}
  onChange={(e) => setName(e.target.value)}
/>
```

### Uncontrolled

```jsx
const inputRef = useRef(null);

<input
  ref={inputRef}
  defaultValue="Yash"
/>
```

The key difference:

```text
CONTROLLED
React → Input

UNCONTROLLED
Input/DOM → React reads when needed
```

---

# WHERE?

Uncontrolled components are useful for:

```text
Simple forms
Quick prototypes
File inputs
Integrating non-React code
Large forms where every keystroke doesn't need React state
```

A particularly important case is:

### File input

```jsx
<input type="file" />
```

File inputs are generally handled using the DOM/ref rather than controlling their value with React state.

---

# HOW?

## 1. Create a ref

```jsx
const nameRef = useRef(null);
```

---

## 2. Attach it to the input

```jsx
<input ref={nameRef} />
```

---

## 3. Read the value

```jsx
nameRef.current.value
```

Example:

```jsx
import { useRef } from "react";

function Form() {
  const nameRef = useRef(null);

  function handleSubmit(event) {
    event.preventDefault();

    console.log(nameRef.current.value);
  }

  return (
    <form onSubmit={handleSubmit}>
      <input
        ref={nameRef}
        type="text"
      />

      <button type="submit">
        Submit
      </button>
    </form>
  );
}
```

Here, React isn't storing the input value in state.

The DOM maintains it.

---

# `defaultValue`

For uncontrolled inputs, use:

```jsx
defaultValue
```

rather than `value`.

Example:

```jsx
<input
  type="text"
  defaultValue="Yash"
/>
```

This gives the input its **initial value**.

After the user changes it, the DOM manages the current value.

---

# `defaultChecked`

For checkboxes:

```jsx
<input
  type="checkbox"
  defaultChecked
/>
```

This sets the initial checked state.

After that, the DOM manages whether the checkbox is checked.

---

# Practical Example — Uncontrolled Login Form

```jsx
import { useRef } from "react";

function LoginForm() {
  const emailRef = useRef(null);
  const passwordRef = useRef(null);

  function handleSubmit(event) {
    event.preventDefault();

    const email = emailRef.current.value;
    const password = passwordRef.current.value;

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
        ref={emailRef}
      />

      <label htmlFor="password">
        Password
      </label>

      <input
        id="password"
        type="password"
        ref={passwordRef}
      />

      <button type="submit">
        Login
      </button>

    </form>
  );
}
```

Notice something important:

There is **no**:

```jsx
const [email, setEmail] = useState("");
```

and no:

```jsx
onChange={...}
```

React only reads the values when the form is submitted.

---

# Controlled vs Uncontrolled

This is a **very important interview question**.

| Controlled                 | Uncontrolled                                |
| -------------------------- | ------------------------------------------- |
| React state controls value | DOM controls value                          |
| Uses `value`               | Uses `defaultValue`                         |
| Uses `checked`             | Uses `defaultChecked`                       |
| Usually uses `onChange`    | `onChange` isn't required for basic reading |
| React is source of truth   | DOM is source of truth                      |
| Easy real-time validation  | Simple for basic forms                      |
| More React code            | Less React state code                       |

### Controlled

```jsx
<input
  value={name}
  onChange={(e) => setName(e.target.value)}
/>
```

### Uncontrolled

```jsx
<input
  ref={nameRef}
  defaultValue="Yash"
/>
```

---

# Important Difference: `value` vs `defaultValue`

This is frequently asked in interviews.

### `value`

```jsx
<input value={name} />
```

React controls the current value.

Changing the state changes the input.

---

### `defaultValue`

```jsx
<input defaultValue="Yash" />
```

It establishes the **initial value**.

The DOM manages subsequent changes.

Think:

```text
value
 ↓
CURRENT value controlled by React

defaultValue
 ↓
INITIAL value
```

---

# Practical Example — Checkbox

```jsx
import { useRef } from "react";

function TermsForm() {
  const termsRef = useRef(null);

  function handleSubmit(event) {
    event.preventDefault();

    console.log(
      termsRef.current.checked
    );
  }

  return (
    <form onSubmit={handleSubmit}>

      <label>
        <input
          type="checkbox"
          ref={termsRef}
        />

        Accept Terms
      </label>

      <button type="submit">
        Continue
      </button>

    </form>
  );
}
```

Read the checkbox state using:

```jsx
termsRef.current.checked
```

---

# File Input

File inputs are an important practical example.

```jsx
import { useRef } from "react";

function UploadForm() {
  const fileRef = useRef(null);

  function handleSubmit(event) {
    event.preventDefault();

    const file = fileRef.current.files[0];

    console.log(file);
  }

  return (
    <form onSubmit={handleSubmit}>

      <input
        type="file"
        ref={fileRef}
      />

      <button type="submit">
        Upload
      </button>

    </form>
  );
}
```

The selected file can be accessed through:

```jsx
fileRef.current.files
```

---

# When Should You Choose Uncontrolled?

Ask yourself:

> **"Do I need React to know the value while the user is typing?"**

### YES → Controlled

For example:

```text
User types password
       ↓
React immediately checks strength
       ↓
Show password strength
```

Use controlled state.

---

### NO → Uncontrolled can be suitable

For example:

```text
User fills simple form
       ↓
Clicks Submit
       ↓
Read values from DOM
       ↓
Send data
```

An uncontrolled approach may be sufficient.

---

# ⚠️ Common Mistakes

## Mistake 1 — Using `value` when you want uncontrolled behavior

```jsx
<input
  value="Yash"
/>
```

This makes React control the value.

For an uncontrolled input with an initial value:

```jsx
<input
  defaultValue="Yash"
/>
```

---

## Mistake 2 — Expecting `defaultValue` to keep controlling the input

```jsx
<input defaultValue={name} />
```

`defaultValue` is primarily for the **initial value**.

It does not continuously control the input as state changes.

---

## Mistake 3 — Forgetting the ref

If you want to read the value using a ref:

```jsx
const inputRef = useRef(null);
```

then:

```jsx
<input ref={inputRef} />
```

and:

```jsx
inputRef.current.value
```

---

## Mistake 4 — Using uncontrolled inputs when you need real-time validation

Suppose you need:

```text
Password
   ↓
Check strength while typing
   ↓
Show:
Weak
Medium
Strong
```

A controlled input is usually more appropriate because React needs the current value to render that UI.

---

# Controlled vs Uncontrolled Example

### Controlled

```jsx
function Form() {
  const [name, setName] = useState("");

  return (
    <input
      value={name}
      onChange={(e) => setName(e.target.value)}
    />
  );
}
```

Flow:

```text
User types
   ↓
onChange
   ↓
setName()
   ↓
React state
   ↓
Re-render
   ↓
Input value
```

---

### Uncontrolled

```jsx
function Form() {
  const nameRef = useRef(null);

  return (
    <input ref={nameRef} />
  );
}
```

Flow:

```text
User types
   ↓
DOM stores value
   ↓
Submit
   ↓
ref.current.value
   ↓
React reads value
```

---

# 🎯 Interview Questions

### Q1. What is an uncontrolled component?

**Answer:**

An uncontrolled component is a form element whose current value is maintained by the DOM rather than React state.

---

### Q2. How do you access the value of an uncontrolled input?

Using a `ref`:

```jsx
const inputRef = useRef(null);

<input ref={inputRef} />
```

Then:

```jsx
inputRef.current.value
```

---

### Q3. What is the difference between `value` and `defaultValue`?

**Answer:**

`value` controls the current input value through React, while `defaultValue` specifies the initial value of an uncontrolled input.

---

### Q4. Controlled vs uncontrolled?

**Answer:**

```text
Controlled
→ React state is the source of truth

Uncontrolled
→ DOM is the source of truth
```

---

### Q5. When would you use an uncontrolled component?

**Answer:**

For simple forms where React doesn't need to track every input change, or when working with DOM-oriented APIs such as file inputs.

---

### Q6. Can an uncontrolled input use `onChange`?

**Answer:**

Yes. "Uncontrolled" describes who owns the current value, not whether event handlers are forbidden. You can listen to `onChange` without making the input controlled.

---

# ⭐ Remember

```text
          FORM INPUT
              │
       ┌──────┴──────┐
       ↓             ↓
  CONTROLLED    UNCONTROLLED
       │             │
 React State         DOM
       │             │
   value          ref/value
       │             │
  onChange       read when needed
```

### Golden rule:

```text
value       → Controlled
defaultValue → Uncontrolled initial value

checked       → Controlled
defaultChecked → Uncontrolled initial value
```

### One-line interview answer:

> **An uncontrolled component lets the DOM maintain the form value, while React accesses it when needed, commonly through a `ref`; `defaultValue` and `defaultChecked` are used for initial values.**
