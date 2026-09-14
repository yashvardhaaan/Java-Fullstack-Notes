# 02 — React vs JavaScript

## WHY?

### Why do we need React if JavaScript already builds websites?

JavaScript can directly manipulate HTML and the DOM, but as an application becomes larger, manually managing the UI becomes difficult.

React provides a structured way to build UI using **components** and automatically update the UI when data changes.

### Example: Without React

```javascript
const button = document.getElementById("btn");
const countElement = document.getElementById("count");

let count = 0;

button.addEventListener("click", () => {
  count++;
  countElement.innerText = count;
});
```

Here, we manually:

1. Find the HTML element.
2. Listen for an event.
3. Change the DOM.
4. Keep the data and UI synchronized.

### With React

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

We tell React:

> "When `count` changes, show the new `count`."

React handles the UI update.

---

# WHAT?

## What is JavaScript?

JavaScript is a **programming language** used to add logic and behavior to applications.

For example:

```javascript
const name = "Yash";

function greet() {
  return `Hello ${name}`;
}

console.log(greet());
```

JavaScript provides:

* Variables
* Functions
* Objects
* Arrays
* Loops
* Conditions
* Events
* Promises
* API calls
* Modules

---

## What is React?

React is a **JavaScript library for building user interfaces**.

```jsx
function App() {
  return <h1>Hello React</h1>;
}
```

React provides concepts such as:

* Components
* JSX
* Props
* State
* Hooks
* Rendering
* Component composition

---

# WHERE?

## Where is JavaScript used?

JavaScript can be used in:

```text
Browser
   ↓
Frontend

Node.js
   ↓
Backend

React / Vue / Angular
   ↓
Frontend applications

React Native
   ↓
Mobile applications
```

JavaScript is the underlying language.

---

## Where is React used?

React is primarily used for building **frontend user interfaces**.

Examples:

```text
E-commerce
   ↓
Amazon-like UI

Banking
   ↓
Dashboard

Social Media
   ↓
Feed / Profile

Admin Panel
   ↓
Tables / Charts / Forms
```

---

# HOW?

## How does JavaScript create UI?

JavaScript can directly interact with the DOM.

HTML:

```html
<h1 id="title">Hello</h1>
```

JavaScript:

```javascript
const title = document.getElementById("title");

title.innerText = "Hello Yash";
```

JavaScript directly changes the DOM.

---

## How does React create UI?

React uses components.

```jsx
function Welcome() {
  return <h1>Hello Yash</h1>;
}
```

Then:

```jsx
function App() {
  return (
    <div>
      <Welcome />
    </div>
  );
}
```

React renders the component into the UI.

Conceptually:

```text
Component
    ↓
JSX
    ↓
React rendering
    ↓
Browser DOM
```

---

# React Does NOT Replace JavaScript

This is extremely important.

React is built **on top of JavaScript**.

You will still use JavaScript inside React.

### Array

```jsx
const users = ["Yash", "Rahul", "Amit"];
```

### `map()`

```jsx
function Users() {
  const users = ["Yash", "Rahul", "Amit"];

  return (
    <div>
      {users.map(user => (
        <p>{user}</p>
      ))}
    </div>
  );
}
```

Here:

```text
JavaScript
    ↓
Array
    ↓
map()
    ↓
React
    ↓
JSX
```

---

# WHEN?

## When should I use JavaScript directly?

For simple websites or when you only need small amounts of interactivity.

Example:

```text
Simple landing page
       ↓
HTML + CSS + JavaScript
```

---

## When should I use React?

React becomes useful when the UI contains many reusable and interactive parts.

Example:

```text
Large application
       ↓
React
       ↓
Components
       ↓
State
       ↓
Props
       ↓
Interactive UI
```

---

# Practical Comparison

| JavaScript                          | React                       |
| ----------------------------------- | --------------------------- |
| Programming language                | JavaScript library          |
| Can manipulate DOM directly         | React manages UI rendering  |
| General-purpose                     | Primarily UI development    |
| Functions                           | Components                  |
| DOM APIs                            | JSX + React rendering       |
| You manually manage many UI updates | UI is driven by state/props |
| Can be used without React           | Built using JavaScript      |

---

# Practical Example

Suppose you are building a shopping cart.

### JavaScript approach

You might manually:

```text
Click Add to Cart
       ↓
Find cart element
       ↓
Update cart count
       ↓
Update product list
       ↓
Update total price
       ↓
Update DOM
```

### React approach

You maintain state:

```jsx
const [cart, setCart] = useState([]);
```

Then UI depends on that state:

```jsx
<h2>Items: {cart.length}</h2>
```

When state changes:

```jsx
setCart([...cart, product]);
```

React re-renders the relevant UI.

```text
State changes
     ↓
React re-renders
     ↓
UI reflects new state
```

---

# Interview Questions

### Q1. Is React a programming language?

**No.** React is a JavaScript library for building user interfaces.

### Q2. Does React replace JavaScript?

**No.** React uses JavaScript extensively.

### Q3. Can we build a website without React?

**Yes.** HTML, CSS and JavaScript are enough for many websites.

### Q4. Why use React?

To make complex, interactive UIs easier to build and maintain using reusable components and state-driven rendering.

### Q5. Is JSX JavaScript?

JSX is a syntax extension used with JavaScript that allows HTML-like UI syntax inside JavaScript code.

### Q6. Which should I learn first?

```text
HTML
 ↓
CSS
 ↓
JavaScript
 ↓
ES6+
 ↓
React
```

---

# Remember

```text
JavaScript = Language
React      = UI Library
JSX        = UI Syntax
Component  = Reusable UI
Props      = Data passed to component
State      = Component-controlled changing data
```

**Most important concept:**

> **React doesn't replace JavaScript; React gives JavaScript a structured way to build and manage complex user interfaces.**
