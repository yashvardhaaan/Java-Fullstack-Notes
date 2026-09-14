# 07 — Event Object in React

## WHY?

When a user performs an action, React often needs **information about that action**.

For example:

* Which button was clicked?
* What did the user type?
* Which key was pressed?
* Which element triggered the event?
* Was the form submitted?
* What value does the input currently contain?

React provides this information through the **event object**.

---

# WHAT?

The **event object** is an object automatically passed by React to an event handler.

Example:

```jsx
function handleClick(event) {
  console.log(event);
}

<button onClick={handleClick}>
  Click Me
</button>
```

When the button is clicked, React passes the event object to:

```jsx
handleClick(event)
```

The event object contains information about the event.

---

# WHERE?

You commonly use the event object with:

```jsx
onClick
onChange
onSubmit
onKeyDown
onFocus
onBlur
```

For example:

```jsx
<input onChange={handleChange} />
```

```jsx
<form onSubmit={handleSubmit}>
```

---

# HOW?

## 1. Access the Event Object

```jsx
function handleClick(event) {
  console.log(event);
}

<button onClick={handleClick}>
  Click
</button>
```

React automatically provides `event`.

You don't have to manually create it.

---

# 2. `event.target`

One of the most important properties is:

```jsx
event.target
```

It represents the element that triggered the event.

Example:

```jsx
function handleClick(event) {
  console.log(event.target);
}
```

If the button was clicked, `event.target` refers to that button.

---

# 3. Getting Input Value

This is one of the **most commonly used patterns in React**.

```jsx
function handleChange(event) {
  console.log(event.target.value);
}

<input onChange={handleChange} />
```

Suppose the user types:

```text
Yash
```

Then:

```jsx
event.target.value
```

will contain:

```text
Yash
```

---

# Practical Example — Controlled Input

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
        value={name}
        onChange={handleChange}
      />

      <h2>Hello {name}</h2>
    </div>
  );
}

export default App;
```

### Flow

```text
User types
    ↓
onChange
    ↓
handleChange(event)
    ↓
event.target.value
    ↓
setName(value)
    ↓
State updates
    ↓
Component re-renders
```

---

# 4. `event.target` vs `event.currentTarget`

This is an important interview question.

### `event.target`

The element that **actually triggered the event**.

### `event.currentTarget`

The element whose **event handler is currently executing**.

Example:

```jsx
function handleClick(event) {
  console.log("target:", event.target);
  console.log("current:", event.currentTarget);
}

<button onClick={handleClick}>
  <span>Click Me</span>
</button>
```

If the user clicks the `<span>`:

```text
event.target
      ↓
<span>

event.currentTarget
      ↓
<button>
```

So:

```text
target
→ actual source of event

currentTarget
→ element with the handler
```

---

# 5. `event.preventDefault()`

The event object provides:

```jsx
event.preventDefault();
```

It prevents the browser's default behavior.

Example:

```jsx
function handleSubmit(event) {
  event.preventDefault();

  console.log("Form submitted");
}
```

Used commonly with forms:

```jsx
<form onSubmit={handleSubmit}>
  <button type="submit">
    Submit
  </button>
</form>
```

---

# 6. `event.stopPropagation()`

Sometimes an event can **bubble from a child element to its parent**.

Example:

```jsx
<div onClick={() => console.log("Parent")}>
  <button onClick={() => console.log("Button")}>
    Click
  </button>
</div>
```

Clicking the button can produce:

```text
Button
Parent
```

To stop the event from propagating:

```jsx
function handleButtonClick(event) {
  event.stopPropagation();

  console.log("Button");
}
```

```jsx
<div onClick={() => console.log("Parent")}>
  <button onClick={handleButtonClick}>
    Click
  </button>
</div>
```

Now the parent handler won't run because propagation was stopped.

---

# 7. Keyboard Events

The event object is also useful for keyboard interactions.

```jsx
function handleKeyDown(event) {
  console.log(event.key);
}

<input onKeyDown={handleKeyDown} />
```

If the user presses:

```text
Enter
```

then:

```jsx
event.key
```

returns:

```text
"Enter"
```

Example:

```jsx
function handleKeyDown(event) {
  if (event.key === "Enter") {
    console.log("Enter pressed");
  }
}
```

---

# 8. Getting Button Information

You can access attributes from the target element.

```jsx
function handleClick(event) {
  console.log(event.target.dataset.id);
}
```

```jsx
<button data-id="101" onClick={handleClick}>
  Delete
</button>
```

Output:

```text
101
```

This can be useful when working with lists.

---

# 9. Passing Event + Your Own Argument

Sometimes you need both:

* your own value
* the event object

Example:

```jsx
function handleDelete(id, event) {
  console.log(id);
  console.log(event.target);
}
```

Call it like:

```jsx
<button onClick={(event) => handleDelete(101, event)}>
  Delete
</button>
```

Here:

```text
101
 ↓
id

event
 ↓
React event object
```

---

# Common Event Object Properties

| Property / Method         | Purpose                          |
| ------------------------- | -------------------------------- |
| `event.target`            | Element that triggered the event |
| `event.currentTarget`     | Element handling the event       |
| `event.target.value`      | Current input value              |
| `event.key`               | Keyboard key pressed             |
| `event.type`              | Event type                       |
| `event.preventDefault()`  | Prevent default browser behavior |
| `event.stopPropagation()` | Stop event propagation           |

---

# Example — Login Form

```jsx
function Login() {

  function handleSubmit(event) {
    event.preventDefault();

    const form = event.currentTarget;

    console.log("Form:", form);
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

Notice:

```jsx
event.currentTarget
```

is useful here because we want the `<form>` that owns the handler.

---

# Common Mistakes

## ❌ Mistake 1 — Forgetting the event parameter

```jsx
function handleChange() {
  console.log(event.target.value);
}
```

This is incorrect.

### ✅ Correct

```jsx
function handleChange(event) {
  console.log(event.target.value);
}
```

---

## ❌ Mistake 2 — Confusing `target` and `currentTarget`

Remember:

```text
target
→ where the event originated

currentTarget
→ where the handler is attached
```

---

## ❌ Mistake 3 — Calling `preventDefault()` without event

Wrong:

```jsx
function handleSubmit() {
  event.preventDefault();
}
```

Correct:

```jsx
function handleSubmit(event) {
  event.preventDefault();
}
```

---

# WHEN?

Use the event object when you need information about **what happened during an event**.

### Input value

```jsx
event.target.value
```

### Keyboard key

```jsx
event.key
```

### Prevent form submission

```jsx
event.preventDefault()
```

### Stop bubbling

```jsx
event.stopPropagation()
```

### Find the element handling the event

```jsx
event.currentTarget
```

---

# Interview Questions

### 1. What is the event object in React?

**Answer:**
The event object contains information and methods related to a user interaction. React automatically passes it to the event handler.

---

### 2. What is `event.target`?

**Answer:**
`event.target` refers to the element that actually triggered the event.

---

### 3. What is the difference between `target` and `currentTarget`?

**Answer:**

```text
target
→ element where the event originated

currentTarget
→ element where the event handler is attached
```

---

### 4. How do you get an input's value?

```jsx
function handleChange(event) {
  console.log(event.target.value);
}
```

---

### 5. What does `preventDefault()` do?

It prevents the browser's default behavior for an event.

---

### 6. What does `stopPropagation()` do?

It prevents an event from continuing to propagate through the DOM event hierarchy.

---

### 7. How do you detect the Enter key?

```jsx
function handleKeyDown(event) {
  if (event.key === "Enter") {
    console.log("Enter pressed");
  }
}
```

---

# ⭐ Remember

The most important patterns are:

```jsx
event.target.value
```

→ Get input value.

```jsx
event.target
```

→ Get the element that triggered the event.

```jsx
event.currentTarget
```

→ Get the element handling the event.

```jsx
event.preventDefault()
```

→ Prevent default browser behavior.

```jsx
event.stopPropagation()
```

→ Stop event propagation.

### One-line interview answer

> **The React event object is automatically passed to event handlers and provides information about the event, such as the target element, input value, pressed key, and methods like `preventDefault()` and `stopPropagation()`.**
