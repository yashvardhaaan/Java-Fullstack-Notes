# 01 — How React Renders

## WHY?

### Why do we need rendering in React?

A React application is not just a collection of JavaScript functions. The purpose of React is to take your **component code and data** and produce the UI that the user sees.

For example:

```jsx
function App() {
  return <h1>Hello React</h1>;
}
```

React needs to take this component and display:

```text
Hello React
```

in the browser.

That process is called **rendering**.

---

# WHAT?

## What is Rendering?

**Rendering is the process in which React calls your components to determine what UI should appear.**

For example:

```jsx
function App() {
  return <h1>Hello Yash</h1>;
}
```

React essentially needs to determine:

```text
App()
 ↓
<h1>Hello Yash</h1>
 ↓
React UI
```

The important point is:

> **Rendering means React calculates what the UI should look like.**

Rendering does not necessarily mean that React changes the browser DOM every time.

---

# React Rendering Flow

A simplified React flow is:

```text
Component
    ↓
Render
    ↓
React elements
    ↓
Reconciliation
    ↓
Commit necessary DOM changes
    ↓
Browser displays UI
```

There are two important ideas here:

```text
Render
  ↓
"What should the UI look like?"

Commit
  ↓
"What actual DOM changes are necessary?"
```

We will study the render/commit distinction in the next file.

---

# WHERE?

Rendering happens whenever React needs to calculate the UI.

Common situations include:

```text
Initial application load
        ↓
State update
        ↓
Props change
        ↓
Parent renders
        ↓
Context changes
```

For example:

```jsx
const [count, setCount] = useState(0);
```

When:

```jsx
setCount(1);
```

is called, React schedules an update and the component may render again.

---

# HOW?

## 1. Initial Rendering

Suppose we have:

```jsx
function App() {
  return <h1>Hello React</h1>;
}
```

And:

```jsx
createRoot(document.getElementById("root")).render(
  <App />
);
```

The simplified flow is:

```text
createRoot()
     ↓
<App />
     ↓
React calls App
     ↓
App returns JSX
     ↓
React determines UI
     ↓
DOM is committed
     ↓
Browser shows "Hello React"
```

---

# Practical Example

### `main.jsx`

```jsx
import { createRoot } from "react-dom/client";
import App from "./App";

createRoot(document.getElementById("root")).render(
  <App />
);
```

### `App.jsx`

```jsx
function App() {
  return (
    <div>
      <h1>Hello React</h1>
      <p>Welcome to my application.</p>
    </div>
  );
}

export default App;
```

The browser ultimately displays:

```text
Hello React

Welcome to my application.
```

---

# 2. Rendering After State Changes

Consider:

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

Initially:

```text
count = 0
```

UI:

```text
0
[ Increase ]
```

User clicks the button.

```text
Click
 ↓
setCount(1)
 ↓
React schedules update
 ↓
Counter renders again
 ↓
New UI contains 1
 ↓
React commits required DOM changes
```

The browser displays:

```text
1
[ Increase ]
```

---

# IMPORTANT: Re-render ≠ Full Page Reload

This is a very common misunderstanding.

Suppose:

```jsx
setCount(count + 1);
```

causes a component to render again.

It does **not** mean:

```text
Browser refresh
     ↓
HTML downloaded again
     ↓
Entire page recreated
```

Instead, React performs its rendering/reconciliation process and commits the necessary DOM changes.

Conceptually:

```text
State changes
     ↓
Component renders
     ↓
React determines changes
     ↓
Necessary DOM update
```

---

# HOW DOES REACT KNOW WHAT TO RENDER?

React calls the component function.

Example:

```jsx
function User({ name }) {
  return <h1>Hello {name}</h1>;
}
```

If:

```jsx
<User name="Yash" />
```

React gets:

```text
Hello Yash
```

If the parent provides:

```jsx
<User name="Rahul" />
```

the rendered result becomes:

```text
Hello Rahul
```

The component's output depends on its inputs.

```text
Props
  +
State
  +
Context
  ↓
Component rendering
  ↓
UI
```

---

# Parent and Child Rendering

Consider:

```jsx
function Parent() {
  return <Child />;
}

function Child() {
  return <h2>Hello</h2>;
}
```

The tree is:

```text
Parent
  ↓
Child
```

When `Parent` renders, React evaluates its returned element tree and determines what child elements should be rendered.

---

# Important Concept: Render Is Not DOM Manipulation

Consider:

```jsx
function App() {
  return <h1>Hello</h1>;
}
```

During rendering, React determines the UI representation.

Rendering itself isn't the same as:

```javascript
document.querySelector("h1").innerText = "Hello";
```

Instead:

```text
Render
 ↓
Calculate desired UI
```

Then:

```text
Commit
 ↓
Apply necessary DOM changes
```

---

# HOW TO THINK ABOUT RENDERING

Think of a React component as a function of its inputs.

```text
UI = f(props, state, context)
```

For example:

```jsx
function Greeting({ name }) {
  return <h1>Hello {name}</h1>;
}
```

You can think:

```text
name = "Yash"
      ↓
Greeting()
      ↓
Hello Yash
```

If the input changes:

```text
name = "Rahul"
      ↓
Greeting()
      ↓
Hello Rahul
```

---

# Render Trigger vs Render Result

This distinction is important.

## What triggers rendering?

Examples:

```text
Initial render
State update
Parent update
Props changes
Context update
```

## What happens during rendering?

React:

```text
Calls components
     ↓
Gets React elements
     ↓
Determines the next UI tree
```

## What happens after rendering?

React commits required changes to the DOM.

```text
Render
  ↓
Reconciliation
  ↓
Commit
  ↓
Browser DOM
```

---

# Practical Example — Props

```jsx
function User({ name }) {
  return <h2>{name}</h2>;
}

function App() {
  return (
    <User name="Yash" />
  );
}
```

If the parent later provides different data:

```jsx
<User name="Rahul" />
```

React can render the child based on the new props.

---

# Practical Example — State

```jsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  function increase() {
    setCount(count + 1);
  }

  return (
    <>
      <h1>{count}</h1>

      <button onClick={increase}>
        Increase
      </button>
    </>
  );
}
```

Execution:

```text
Initial render
      ↓
count = 0
      ↓
User clicks
      ↓
increase()
      ↓
setCount(1)
      ↓
React schedules update
      ↓
Counter renders again
      ↓
count = 1
      ↓
React commits necessary DOM update
```

---

# WHEN?

## When does React render?

### 1. Initial Render

When the application starts:

```jsx
createRoot(root).render(<App />);
```

React performs the initial rendering.

---

### 2. State Update

```jsx
setCount(10);
```

A state update can cause the component to render again.

---

### 3. Parent Render

If a parent component renders again, its child components may also be evaluated as part of the rendering process, subject to React's optimization mechanisms.

Example:

```text
Parent
 ↓
Child
```

Parent update:

```text
Parent renders
 ↓
Child may render
```

---

### 4. Props Changes

If a component receives new props:

```jsx
<User name="Yash" />
```

and later:

```jsx
<User name="Rahul" />
```

React needs to render based on the new input.

---

### 5. Context Changes

If a component consumes a context value and that relevant context value changes, React can re-render the component.

---

# When Does React NOT Necessarily Change the DOM?

A component can render again without requiring a visible DOM change.

Example:

```jsx
function App() {
  const message = "Hello";

  return <h1>{message}</h1>;
}
```

If React renders the same result again:

```text
Previous UI
<h1>Hello</h1>

New UI
<h1>Hello</h1>
```

There may be **no DOM mutation required**.

This is why:

> **A re-render does not mean the DOM is completely rebuilt.**

---

# Common Mistake

### ❌ Wrong understanding

> "Every time React re-renders, React destroys the whole DOM and creates it again."

### ✅ Correct understanding

> React renders to determine the next UI representation, compares it with the previous result, and commits the necessary DOM changes.

---

# Practical Interview Example

### Question:

What happens when you call:

```jsx
setCount(count + 1);
```

### Answer:

```text
setCount()
    ↓
State update is scheduled
    ↓
Component renders again
    ↓
React calculates the new UI
    ↓
React reconciles the result
    ↓
Necessary DOM changes are committed
```

---

# Interview Questions

### Q1. What is rendering in React?

> Rendering is the process of React calling components to determine what the UI should look like based on their current inputs such as props, state, and context.

---

### Q2. What causes a React component to render?

Common causes include:

* Initial render
* State updates
* Parent rendering
* Relevant props changes
* Relevant context changes

---

### Q3. Does re-render mean the DOM is recreated?

**No.**

React determines the necessary changes and commits only the required DOM updates.

---

### Q4. What happens when state changes?

> A state update schedules a new render. React calculates the new UI and then commits the necessary changes to the DOM.

---

### Q5. What is the difference between render and commit?

**Render:**

```text
Calculate what UI should look like
```

**Commit:**

```text
Apply necessary changes to the DOM
```

---

### Q6. Does React call the component function during rendering?

Yes. React evaluates the component to obtain its next UI representation.

---

# Remember

```text
              REACT RENDERING

Initial render / State / Props / Context
                    ↓
              Component runs
                    ↓
             JSX is returned
                    ↓
        React determines next UI
                    ↓
             Reconciliation
                    ↓
                 Commit
                    ↓
              Browser DOM
```

### Most important point

> **Rendering is React calculating what the UI should look like; committing is when React applies the necessary changes to the browser DOM.**

---

### One-line interview answer

> **React rendering is the process of evaluating components to determine the next UI based on current props, state, and context, after which React reconciles and commits the necessary DOM changes.**
