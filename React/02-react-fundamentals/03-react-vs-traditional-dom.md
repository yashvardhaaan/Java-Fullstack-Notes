# 03 — React vs Traditional DOM

## WHY?

### Why do we need React when JavaScript can directly manipulate the DOM?

JavaScript allows us to directly find and modify HTML elements.

For a small application, this is perfectly fine.

But when the application becomes large, there may be:

* Hundreds of UI elements
* Many event handlers
* Frequently changing data
* Multiple components depending on the same data
* Complex UI updates

Manually keeping the **DOM and application data synchronized** becomes difficult.

React solves this by making the UI **declarative and state-driven**.

---

# WHAT?

## What is the DOM?

DOM stands for **Document Object Model**.

When the browser loads HTML:

```html
<h1>Hello</h1>
<button>Click</button>
```

the browser creates a tree-like representation:

```text
Document
│
├── h1
│   └── "Hello"
│
└── button
    └── "Click"
```

JavaScript can access and modify this tree.

---

## What is DOM manipulation?

DOM manipulation means directly changing elements using JavaScript.

Example:

```html
<h1 id="title">Hello</h1>
```

```javascript
const title = document.getElementById("title");

title.innerText = "Hello Yash";
```

JavaScript directly changes the DOM.

---

# WHAT IS THE TRADITIONAL APPROACH?

Suppose we have a counter.

### HTML

```html
<h1 id="count">0</h1>

<button id="increase">
  Increase
</button>
```

### JavaScript

```javascript
let count = 0;

const countElement = document.getElementById("count");
const button = document.getElementById("increase");

button.addEventListener("click", () => {
  count++;

  countElement.innerText = count;
});
```

The developer manually tells the browser:

> Find this element and change its text.

---

# WHAT IS THE REACT APPROACH?

In React:

```jsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <>
      <h1>{count}</h1>

      <button onClick={() => setCount(count + 1)}>
        Increase
      </button>
    </>
  );
}
```

Here we don't manually write:

```javascript
document.getElementById(...)
```

Instead, we change the **state**:

```jsx
setCount(count + 1);
```

React takes care of updating the UI.

---

# WHERE?

## Where is the traditional DOM approach useful?

Direct DOM manipulation is useful for:

* Small websites
* Simple interactions
* Vanilla JavaScript projects
* Integrating third-party libraries when necessary

Example:

```javascript
document.querySelector("#menu").classList.toggle("active");
```

---

## Where is React useful?

React is useful for larger interactive applications:

```text
E-commerce
Dashboards
Banking applications
Social media
Admin panels
SaaS applications
```

For example:

```text
Dashboard
│
├── Navbar
├── Sidebar
├── UserProfile
├── Statistics
├── Charts
└── Notifications
```

Each section can become a React component.

---

# HOW?

## How does traditional DOM manipulation work?

The developer explicitly tells JavaScript **what DOM operation to perform**.

```text
User clicks button
       ↓
JavaScript event
       ↓
Find DOM element
       ↓
Change DOM
       ↓
Browser displays result
```

Example:

```javascript
button.addEventListener("click", () => {
  document.querySelector("#message").innerText =
    "Button clicked";
});
```

---

# How does React work?

React follows a more declarative approach.

```text
State
 ↓
React renders UI
 ↓
State changes
 ↓
React determines required updates
 ↓
Browser DOM is updated
```

Example:

```jsx
function App() {
  const [message, setMessage] = useState("Hello");

  return (
    <>
      <h1>{message}</h1>

      <button onClick={() => setMessage("Hello Yash")}>
        Change
      </button>
    </>
  );
}
```

We don't tell React:

```text
Find h1
↓
Change innerText
```

We tell React:

```text
The UI should display the current value of message.
```

---

# Declarative vs Imperative

This is an important React concept.

## Imperative

**Tell the computer HOW to do something.**

```javascript
const heading = document.querySelector("h1");

heading.innerText = "Hello";
heading.style.color = "red";
```

You explicitly describe the operations.

---

## Declarative

**Tell the computer WHAT the UI should look like.**

```jsx
function App() {
  const message = "Hello";

  return (
    <h1>
      {message}
    </h1>
  );
}
```

The UI is described based on data.

---

# Virtual DOM

## WHY does React talk about Virtual DOM?

React needs an efficient way to determine which parts of the browser UI need updating when a component renders again.

React uses an internal representation of the UI and compares the new result with the previous one during reconciliation.

---

## WHAT is the Virtual DOM?

The Virtual DOM is an **in-memory representation of the UI** used by React.

Conceptually:

```text
React Component
      ↓
React element tree
      ↓
Compare with previous tree
      ↓
Determine necessary DOM changes
      ↓
Browser DOM
```

### Important

Don't think:

> "React never touches the real DOM."

It does.

React ultimately updates the browser's real DOM.

---

# Practical Example

Suppose:

```jsx
function App() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <h1>Counter</h1>

      <p>{count}</p>

      <button onClick={() => setCount(count + 1)}>
        Increase
      </button>
    </div>
  );
}
```

When the button is clicked:

```text
count = 0
   ↓
setCount(1)
   ↓
Component renders again
   ↓
React compares UI
   ↓
<p> changes from 0 → 1
```

React doesn't need you to manually write:

```javascript
document.querySelector("p").innerText = 1;
```

---

# WHEN?

## When should I use direct DOM manipulation?

Use it when:

* The project is simple.
* You are using vanilla JavaScript.
* You need a small DOM operation.
* You are integrating a library that requires direct DOM access.

Example:

```javascript
document
  .querySelector("#modal")
  .classList.add("open");
```

---

## When should I use React?

Use React when:

* UI is complex.
* UI changes based on data.
* You have many reusable components.
* Application has significant state.
* Multiple parts of UI interact with each other.

---

# Interview Questions

### Q1. What is DOM?

DOM is the browser's object representation of an HTML document that JavaScript can access and modify.

---

### Q2. What is DOM manipulation?

Changing or interacting with HTML elements programmatically using JavaScript.

Example:

```javascript
document.querySelector("h1").innerText = "Hello";
```

---

### Q3. Why is direct DOM manipulation difficult in large applications?

Because developers have to manually coordinate UI changes with application state and other DOM updates, which can become complex.

---

### Q4. What is the Virtual DOM?

It is React's in-memory representation of the UI used during its rendering and reconciliation process to determine necessary DOM updates.

---

### Q5. Does React completely avoid the real DOM?

**No.**

React eventually updates the browser's real DOM.

---

### Q6. What is declarative UI?

Describing **what the UI should look like based on the current data**, rather than manually specifying every DOM operation.

---

# Traditional DOM vs React

| Traditional JavaScript             | React                        |
| ---------------------------------- | ---------------------------- |
| Imperative                         | Declarative                  |
| Direct DOM manipulation            | React manages DOM updates    |
| Developer specifies DOM operations | Developer describes UI       |
| Manual UI synchronization          | State-driven UI              |
| Can become difficult at scale      | Component-based architecture |
| No framework/library required      | React library                |

---

# Remember This

```text
Traditional JavaScript

Data changes
     ↓
YOU find DOM
     ↓
YOU update DOM
```

```text
React

Data/state changes
       ↓
React renders
       ↓
React determines necessary updates
       ↓
DOM updates
```

### One-line interview answer

> **Traditional JavaScript requires us to manually manipulate the DOM, while React provides a declarative, component-based, state-driven approach where React handles the necessary UI updates.**
