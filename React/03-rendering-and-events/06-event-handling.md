# 06 — Event Handling in React

## WHY?

Web applications need to **respond to user actions**.

For example:

* User clicks a button → perform an action
* User types in an input → update data
* User submits a form → send data
* User moves the mouse → change UI
* User selects an option → update state

React provides **event handling** to make components interactive.

Without event handling, a React application would mostly be static.

---

# WHAT?

**Event handling** means executing a function when a particular event occurs.

React uses event props such as:

```jsx
onClick
onChange
onSubmit
onMouseEnter
onMouseLeave
onFocus
onBlur
onKeyDown
```

Example:

```jsx
function App() {
  function handleClick() {
    alert("Button clicked!");
  }

  return (
    <button onClick={handleClick}>
      Click Me
    </button>
  );
}
```

Here:

```jsx
onClick={handleClick}
```

means:

> When the button is clicked, execute `handleClick`.

---

# WHERE?

Event handling is mainly used inside **JSX elements**.

```jsx
<button onClick={handleClick}>
  Click
</button>
```

```jsx
<input onChange={handleChange} />
```

```jsx
<form onSubmit={handleSubmit}>
  ...
</form>
```

It is also heavily used with **state**.

```jsx
const [count, setCount] = useState(0);

<button onClick={() => setCount(count + 1)}>
  {count}
</button>
```

---

# HOW?

## 1. Create an event handler

```jsx
function handleClick() {
  console.log("Clicked");
}
```

## 2. Pass it to the event

```jsx
<button onClick={handleClick}>
  Click
</button>
```

### Important

Do **not** write:

```jsx
<button onClick={handleClick()}>
```

❌ Wrong.

This calls the function immediately during rendering.

Write:

```jsx
<button onClick={handleClick}>
```

✅ Correct.

React will call the function when the event happens.

---

# Example 1 — Button Click

```jsx
function App() {
  function handleClick() {
    console.log("Hello React");
  }

  return (
    <div>
      <button onClick={handleClick}>
        Click Me
      </button>
    </div>
  );
}

export default App;
```

### Flow

```text
User clicks button
       ↓
onClick event occurs
       ↓
handleClick()
       ↓
"Hello React" printed
```

---

# Example 2 — Updating State on Click

```jsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  function handleClick() {
    setCount(count + 1);
  }

  return (
    <div>
      <h2>{count}</h2>

      <button onClick={handleClick}>
        Increase
      </button>
    </div>
  );
}
```

Every click:

```text
Click
 ↓
handleClick()
 ↓
setCount(count + 1)
 ↓
State changes
 ↓
React re-renders
 ↓
New count displayed
```

---

# Example 3 — Inline Event Handler

You can write the function directly.

```jsx
<button onClick={() => alert("Clicked")}>
  Click
</button>
```

This is useful for small operations.

However, for complex logic, prefer a separate function:

```jsx
function handleClick() {
  // complex logic
}

<button onClick={handleClick}>
  Click
</button>
```

---

# Example 4 — Passing Arguments

Suppose we want to delete a particular user.

```jsx
function deleteUser(id) {
  console.log("Deleting:", id);
}
```

We can pass the ID like this:

```jsx
<button onClick={() => deleteUser(101)}>
  Delete
</button>
```

The arrow function is necessary because we want to call the function **when the button is clicked**, not during rendering.

---

# Example 5 — Input Event

React commonly uses `onChange` for input fields.

```jsx
import { useState } from "react";

function App() {
  const [name, setName] = useState("");

  function handleChange(event) {
    setName(event.target.value);
  }

  return (
    <div>
      <input
        type="text"
        value={name}
        onChange={handleChange}
      />

      <p>Hello {name}</p>
    </div>
  );
}
```

### Flow

```text
User types "Yash"
       ↓
onChange
       ↓
handleChange(event)
       ↓
event.target.value
       ↓
setName("Yash")
       ↓
React re-renders
       ↓
Hello Yash
```

---

# Example 6 — Form Submission

```jsx
function Login() {

  function handleSubmit(event) {
    event.preventDefault();

    console.log("Form submitted");
  }

  return (
    <form onSubmit={handleSubmit}>
      <input type="email" />

      <button type="submit">
        Login
      </button>
    </form>
  );
}
```

## Why `preventDefault()`?

Normally, submitting an HTML form can cause the browser to reload/navigate.

```jsx
event.preventDefault();
```

prevents that default browser behavior.

React can then handle the submission itself.

---

# Common React Events

| Event          | Used for              |
| -------------- | --------------------- |
| `onClick`      | Button/click actions  |
| `onChange`     | Input changes         |
| `onSubmit`     | Form submission       |
| `onMouseEnter` | Mouse enters element  |
| `onMouseLeave` | Mouse leaves element  |
| `onFocus`      | Input receives focus  |
| `onBlur`       | Input loses focus     |
| `onKeyDown`    | Keyboard key pressed  |
| `onKeyUp`      | Keyboard key released |

---

# React Event Naming

HTML traditionally uses:

```html
onclick
```

React uses:

```jsx
onClick
```

HTML:

```html
onchange
```

React:

```jsx
onChange
```

So React event names generally use **camelCase**.

---

# WHEN?

Use event handling whenever the UI needs to **react to user interaction**.

For example:

### Login

```jsx
<form onSubmit={handleLogin}>
```

### Search

```jsx
<input onChange={handleSearch} />
```

### Counter

```jsx
<button onClick={increase}>
```

### Dropdown

```jsx
<select onChange={handleSelect}>
```

### Keyboard shortcut

```jsx
<input onKeyDown={handleKeyDown} />
```

---

# Common Mistakes

## ❌ Mistake 1 — Calling function immediately

```jsx
<button onClick={handleClick()}>
```

Wrong because the function executes during rendering.

### ✅ Correct

```jsx
<button onClick={handleClick}>
```

---

## ❌ Mistake 2 — Using lowercase event names

```jsx
<button onclick={handleClick}>
```

### ✅ Correct

```jsx
<button onClick={handleClick}>
```

---

## ❌ Mistake 3 — Forgetting `event.preventDefault()`

For forms:

```jsx
function handleSubmit(event) {
  event.preventDefault();
}
```

This is commonly required when you don't want the browser's default form submission behavior.

---

## ❌ Mistake 4 — Too much logic inline

Avoid making JSX difficult to read:

```jsx
<button onClick={() => {
  // 20 lines of logic
}}>
```

Prefer:

```jsx
function handleClick() {
  // logic
}

<button onClick={handleClick}>
```

---

# Event Handler Naming Convention

A common React convention is:

```jsx
handleClick
handleSubmit
handleChange
handleDelete
handleLogin
handleLogout
```

Example:

```jsx
function handleLogin() {
  // login logic
}

function handleLogout() {
  // logout logic
}
```

This makes the code easier to understand.

---

# Event Handling + State

This combination is extremely important in React.

```jsx
const [isOpen, setIsOpen] = useState(false);

function handleToggle() {
  setIsOpen(!isOpen);
}
```

```jsx
<button onClick={handleToggle}>
  Toggle
</button>
```

React applications are largely built around:

```text
User Event
    ↓
Event Handler
    ↓
State Update
    ↓
Re-render
    ↓
Updated UI
```

---

# Interview Questions

### 1. What is event handling in React?

**Answer:**
Event handling in React is the process of responding to user interactions such as clicks, typing, form submissions, and keyboard events using event props like `onClick`, `onChange`, and `onSubmit`.

---

### 2. Why do we use `onClick={handleClick}` instead of `onClick={handleClick()}`?

**Answer:**
`onClick={handleClick}` passes the function to React so React can execute it when the event occurs. `handleClick()` executes the function immediately during rendering.

---

### 3. How do you pass arguments to an event handler?

```jsx
<button onClick={() => deleteUser(10)}>
  Delete
</button>
```

The arrow function delays the function call until the click happens.

---

### 4. What is `event` in React?

It is the event object containing information about the event.

```jsx
function handleChange(event) {
  console.log(event.target.value);
}
```

---

### 5. How do you prevent default browser behavior?

```jsx
event.preventDefault();
```

Example:

```jsx
function handleSubmit(event) {
  event.preventDefault();
}
```

---

### 6. What is the difference between `onChange` and `onClick`?

```text
onClick
   ↓
Triggered when an element is clicked

onChange
   ↓
Triggered when the value of a form/input element changes
```

---

# ⭐ Remember

```jsx
<button onClick={handleClick}>
```

means:

> **"React, call `handleClick` when this button is clicked."**

And:

```jsx
<button onClick={handleClick()}>
```

means:

> **"Execute `handleClick` right now and use its result as the event handler."** ❌

### One-line interview answer

> **React event handling allows components to respond to user interactions by passing handler functions to camelCase event props such as `onClick`, `onChange`, and `onSubmit`.**
