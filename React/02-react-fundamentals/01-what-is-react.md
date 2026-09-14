# 01 — What is React?

## WHY?

### Why do we use React?

We use React to build **interactive and dynamic user interfaces** in a structured and reusable way.

In a normal website, if the UI changes frequently, manually updating many HTML elements using JavaScript can become difficult.

React helps us manage this complexity by using:

* **Components** → reusable UI blocks
* **Props** → data passed between components
* **State** → data that changes over time
* **JSX** → syntax for describing UI
* **Declarative rendering** → describe what the UI should look like

### Example

Suppose we are building a shopping application.

The UI may contain:

```text
Navbar
Products
Cart
Search
Login
Orders
Profile
```

React allows us to divide this into components:

```text
App
│
├── Navbar
├── Search
├── ProductList
│   └── ProductCard
├── Cart
└── Footer
```

This makes the application easier to develop and maintain.

---

# WHAT?

## What is React?

**React is a JavaScript library for building user interfaces.**

It was originally developed at Facebook and is now maintained as an open-source project by Meta and the React community.

A simple React component:

```jsx
function App() {
  return <h1>Hello React</h1>;
}

export default App;
```

Here:

```text
App
 ↓
React Component
 ↓
Returns JSX
 ↓
UI
```

---

# What problem does React solve?

Without a UI library, you may manually manipulate the DOM:

```javascript
const heading = document.getElementById("heading");

heading.innerText = "Hello Yash";
```

As the application becomes complex, keeping the DOM synchronized with application data can become difficult.

React lets us describe the UI based on the current data/state:

```jsx
function App() {
  const name = "Yash";

  return <h1>Hello {name}</h1>;
}
```

Conceptually:

```text
Data / State
     ↓
React
     ↓
UI
```

When the relevant state changes, React determines the necessary UI updates.

---

# WHERE?

## Where is React used?

React is primarily used to build **frontend user interfaces**.

Common applications include:

```text
E-commerce
     ↓
Product pages / Cart

Banking
     ↓
Dashboard / Transactions

Social Media
     ↓
Feed / Profile

SaaS
     ↓
Dashboard / Settings

Admin Panel
     ↓
Tables / Forms / Charts
```

---

# Where does React run?

React code runs in a JavaScript environment, commonly in the **browser** for client-side applications.

A simplified architecture is:

```text
Browser
   ↓
JavaScript
   ↓
React
   ↓
Components
   ↓
UI
```

React can also be used in frameworks and environments that support server-side rendering and other rendering strategies.

---

# HOW?

## How does React build the UI?

React applications are built using components.

Example:

```jsx
function Navbar() {
  return <nav>My Website</nav>;
}

function App() {
  return (
    <div>
      <Navbar />
      <h1>Welcome</h1>
    </div>
  );
}
```

The structure becomes:

```text
App
│
├── Navbar
│
└── h1
```

React renders this component tree into the browser UI.

---

# How does React update the UI?

Consider a counter:

```jsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <h1>{count}</h1>

      <button onClick={() => setCount(count + 1)}>
        Increase
      </button>
    </div>
  );
}
```

Initial state:

```text
count = 0
```

User clicks:

```text
Increase
   ↓
setCount(1)
   ↓
State changes
   ↓
React renders the component again
   ↓
UI displays 1
```

The developer doesn't need to manually write:

```javascript
document.querySelector("h1").innerText = 1;
```

React handles the necessary rendering/update process.

---

# Declarative UI

One of React's most important ideas is **declarative programming**.

### Imperative approach

Tell the browser **how** to change the UI:

```javascript
const element = document.querySelector("#message");

element.innerText = "Logged In";
```

### React approach

Describe **what the UI should display**:

```jsx
function App() {
  const isLoggedIn = true;

  return (
    <h1>
      {isLoggedIn ? "Dashboard" : "Login"}
    </h1>
  );
}
```

Conceptually:

```text
State
 ↓
What should UI look like?
 ↓
React
 ↓
UI
```

---

# React's Main Building Blocks

## 1. Components

Reusable UI:

```jsx
function Button() {
  return <button>Click</button>;
}
```

---

## 2. JSX

HTML-like syntax inside JavaScript:

```jsx
<h1>Hello</h1>
```

---

## 3. Props

Data passed into components:

```jsx
<User name="Yash" />
```

---

## 4. State

Data controlled by a component that can change:

```jsx
const [count, setCount] = useState(0);
```

---

## 5. Hooks

Functions that let components use React features.

Example:

```jsx
useState()
```

and:

```jsx
useEffect()
```

---

# WHEN?

## When should we use React?

React is particularly useful when an application has:

### 1. Interactive UI

```text
Buttons
Forms
Menus
Modals
Search
Filters
```

### 2. Frequently changing data

```text
Live dashboard
Shopping cart
Notifications
User profile
```

### 3. Reusable UI

```text
Button
Card
Navbar
Modal
Table
```

### 4. Complex application structure

```text
Dashboard
Products
Orders
Users
Settings
```

---

# When should we NOT necessarily use React?

For a very simple static website:

```text
Home
About
Contact
```

plain:

```text
HTML
CSS
JavaScript
```

may be sufficient.

React is not mandatory for every website.

---

# Practical Example

Let's create a simple student dashboard.

### `StudentCard.jsx`

```jsx
function StudentCard({ name, course }) {
  return (
    <div>
      <h2>{name}</h2>
      <p>{course}</p>
    </div>
  );
}

export default StudentCard;
```

### `App.jsx`

```jsx
import StudentCard from "./StudentCard";

function App() {
  return (
    <div>
      <h1>Students</h1>

      <StudentCard
        name="Yash"
        course="Computer Science"
      />

      <StudentCard
        name="Rahul"
        course="Data Science"
      />
    </div>
  );
}

export default App;
```

Here:

```text
App
 ↓
StudentCard
 ↓
Props
 ↓
Student information
 ↓
UI
```

The same `StudentCard` component can be reused for many students.

---

# React Application Flow

A simplified React application looks like:

```text
              React Application
                     │
                     ↓
                Components
                     │
          ┌──────────┴──────────┐
          ↓                     ↓
        Props                  State
          │                     │
          └──────────┬──────────┘
                     ↓
                    JSX
                     ↓
               React Rendering
                     ↓
                Browser DOM
                     ↓
                     UI
```

---

# React vs JavaScript

Remember:

```text
JavaScript
    ↓
Programming language

React
    ↓
JavaScript library
    ↓
UI development
```

React **does not replace JavaScript**.

You still use JavaScript inside React:

```jsx
const users = ["Yash", "Rahul", "Amit"];

function Users() {
  return (
    <ul>
      {users.map(user => (
        <li key={user}>{user}</li>
      ))}
    </ul>
  );
}
```

Here:

```text
JavaScript
 ├── const
 ├── array
 └── map()
       ↓
     React
       ↓
      JSX
```

---

# Interview Questions

### Q1. What is React?

> React is a JavaScript library for building user interfaces using reusable components and declarative, state-driven rendering.

---

### Q2. Is React a framework?

React itself is generally described as a **JavaScript library for UI**. Frameworks such as Next.js build on React and provide additional application-level features.

---

### Q3. Why is React popular?

Because it provides:

* Component-based development
* Reusable UI
* Declarative rendering
* State management capabilities
* A large ecosystem
* Good support for building complex interactive interfaces

---

### Q4. What is a component?

> A component is a reusable piece of UI that can receive inputs through props and can manage state when needed.

---

### Q5. What is JSX?

> JSX is a JavaScript syntax extension that allows React UI to be written using HTML-like syntax.

---

### Q6. What is state?

> State is data managed by a component that can change over time and cause the component's UI to update.

---

### Q7. What are props?

> Props are read-only inputs passed from a parent component to a child component.

---

### Q8. Does React directly manipulate the DOM?

React ultimately updates the browser's DOM, but developers generally describe UI declaratively rather than manually manipulating DOM elements for each state change.

---

# Remember

```text
React
 ↓
JavaScript Library
 ↓
Build UI
 ↓
Components
 ↓
Props + State
 ↓
JSX
 ↓
React Rendering
 ↓
Browser UI
```

### One-line interview answer

> **React is a JavaScript library for building interactive user interfaces using reusable components and declarative, state-driven rendering.**
