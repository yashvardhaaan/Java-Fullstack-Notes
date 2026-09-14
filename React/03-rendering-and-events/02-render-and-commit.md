# 02 — Render and Commit

## WHY?

### Why do we need to understand Render and Commit?

When React updates the UI, two different things happen conceptually:

```text
Render
  ↓
Figure out what the UI should look like

Commit
  ↓
Apply the necessary changes to the DOM
```

Understanding this distinction helps you understand:

* Why a component can render without changing the DOM
* Why re-rendering does not mean the whole page is recreated
* How state updates work
* Why render code should be kept free of side effects

---

# WHAT?

React's update process can be understood in three broad stages:

```text
1. Trigger
     ↓
2. Render
     ↓
3. Commit
```

---

# 1. TRIGGER

## WHAT is a Trigger?

A trigger is something that causes React to schedule an update.

Common triggers include:

```text
Initial render
State update
Parent render
Props change
Context change
```

Example:

```jsx
setCount(count + 1);
```

The state update triggers React to perform another render.

---

# 2. RENDER

## WHAT happens during Render?

During rendering, React evaluates components to determine the **next UI representation**.

Example:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  return <h1>{count}</h1>;
}
```

Initially:

```text
count = 0
```

React determines:

```jsx
<h1>0</h1>
```

After:

```jsx
setCount(1);
```

React renders again and determines:

```jsx
<h1>1</h1>
```

---

# 3. COMMIT

## WHAT happens during Commit?

After React has determined the required UI changes, it commits the necessary changes to the browser DOM.

Conceptually:

```text
Render
 ↓
New UI representation
 ↓
Compare/reconcile
 ↓
Commit
 ↓
DOM updated
```

For our counter:

```text
Before:
<h1>0</h1>

After render:
<h1>1</h1>

Commit:
DOM text changes 0 → 1
```

---

# WHERE?

This process happens inside React's rendering system.

From a developer's perspective, you mainly work with:

```jsx
function App() {
  return <h1>Hello</h1>;
}
```

and React handles the process:

```text
Component
   ↓
Render
   ↓
Reconciliation
   ↓
Commit
   ↓
Browser DOM
```

You generally don't manually call "render phase" or "commit phase" functions.

---

# HOW?

## Initial Render

Consider:

```jsx
import { createRoot } from "react-dom/client";

function App() {
  return <h1>Hello React</h1>;
}

createRoot(
  document.getElementById("root")
).render(<App />);
```

The process is approximately:

```text
createRoot().render()
        ↓
      Trigger
        ↓
    Render phase
        ↓
React determines <h1>Hello React</h1>
        ↓
   Commit phase
        ↓
Browser DOM
```

The browser displays:

```text
Hello React
```

---

# Render Phase in Detail

During rendering, React evaluates the component.

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

React determines:

```text
Hello Yash
```

If the prop changes:

```jsx
<User name="Rahul" />
```

React determines:

```text
Hello Rahul
```

The render phase is essentially about **figuring out the next UI**.

---

# Commit Phase in Detail

Suppose the previous UI is:

```html
<h1>Hello Yash</h1>
```

and the new UI should be:

```html
<h1>Hello Rahul</h1>
```

React determines the required change and commits it to the DOM.

Conceptually:

```text
Previous UI
    ↓
Hello Yash

New UI
    ↓
Hello Rahul

Required change
    ↓
Text update

Commit
    ↓
DOM updated
```

---

# IMPORTANT: Render Does Not Mean DOM Update

This is one of the most important concepts.

Suppose:

```jsx
function App() {
  return <h1>Hello</h1>;
}
```

React may evaluate the component again and get the same result:

```jsx
<h1>Hello</h1>
```

There is no reason to make a visible DOM change if the committed result is already the same.

Therefore:

```text
Render ≠ DOM mutation
```

---

# Practical Example — Counter

```jsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <h1>{count}</h1>

      <button
        onClick={() => setCount(count + 1)}
      >
        Increase
      </button>
    </div>
  );
}
```

Initial:

```text
count = 0
```

UI:

```text
0
[ Increase ]
```

User clicks.

### Trigger

```text
setCount(1)
```

### Render

React evaluates:

```jsx
<h1>1</h1>
```

### Reconciliation

React determines what changed.

```text
0 → 1
```

### Commit

React updates the necessary DOM content.

```text
1
[ Increase ]
```

---

# WHY RENDER SHOULD BE PURE

React expects rendering logic to be **pure**.

That means:

> Given the same inputs, rendering should produce the same result without causing external side effects.

Good:

```jsx
function User({ name }) {
  return <h1>{name}</h1>;
}
```

Problematic:

```jsx
function User({ name }) {
  fetch("/api/users");

  return <h1>{name}</h1>;
}
```

Why?

Rendering can happen more than once, so side effects inside render can execute unexpectedly or repeatedly.

Side effects such as data fetching, subscriptions, timers, or manually interacting with external systems generally belong in appropriate mechanisms such as event handlers or Effects, depending on the use case.

---

# Render Phase vs Commit Phase

| Render                          | Commit                                    |
| ------------------------------- | ----------------------------------------- |
| Determines next UI              | Applies necessary DOM changes             |
| Evaluates components            | Updates browser DOM                       |
| Can happen without DOM mutation | Performs actual DOM mutations when needed |
| Should remain pure              | React performs the actual commit work     |

---

# HOW DOES STATE UPDATE CONNECT TO RENDER + COMMIT?

Consider:

```jsx
const [count, setCount] = useState(0);
```

When:

```jsx
setCount(1);
```

is called:

```text
setCount(1)
    ↓
Update scheduled
    ↓
Render
    ↓
Component evaluated
    ↓
New UI determined
    ↓
Reconciliation
    ↓
Commit
    ↓
DOM updated
```

---

# WHEN?

## When does the Render phase happen?

It can happen during:

### Initial rendering

```jsx
root.render(<App />);
```

### State updates

```jsx
setCount(10);
```

### Parent updates

When a parent renders, child components may also be evaluated as part of the rendering process.

### Props changes

```jsx
<User name="Yash" />
```

changing to:

```jsx
<User name="Rahul" />
```

can result in a new render.

### Context updates

A component consuming a relevant context value can render again when that value changes.

---

# When does Commit happen?

After React completes the necessary rendering/reconciliation work for an update, React commits the result.

Conceptually:

```text
Trigger
  ↓
Render
  ↓
Reconciliation
  ↓
Commit
```

---

# Practical Example — No DOM Change

Consider:

```jsx
function App() {
  const message = "Hello";

  return <h1>{message}</h1>;
}
```

Suppose React evaluates this component again.

Previous result:

```jsx
<h1>Hello</h1>
```

New result:

```jsx
<h1>Hello</h1>
```

The render happened, but there may be **no DOM mutation** because nothing visible needs to change.

This is why:

> A component rendering again does not mean the browser DOM is completely rebuilt.

---

# Practical Example — Parent and Child

```jsx
function Child() {
  console.log("Child rendered");

  return <h2>Hello</h2>;
}

function Parent() {
  const [count, setCount] = useState(0);

  return (
    <>
      <button onClick={() => setCount(count + 1)}>
        {count}
      </button>

      <Child />
    </>
  );
}
```

When `count` changes:

```text
Parent state changes
       ↓
Parent renders
       ↓
Child may also be evaluated
       ↓
React determines whether DOM changes are needed
       ↓
Commit
```

Notice:

```text
Child render
     ≠
Child DOM necessarily changes
```

---

# A Very Important Interview Concept

### Question:

**Does React update the DOM during the render phase?**

A good answer is:

> The render phase determines what the UI should look like. The commit phase is where React applies the necessary changes to the host environment, such as the browser DOM.

---

# Common Mistakes

### ❌ Mistake 1

> "Render means updating the DOM."

Not exactly.

Better:

> Render means calculating the next UI.

---

### ❌ Mistake 2

> "Every render recreates the entire DOM."

Incorrect.

React reconciles the result and commits necessary changes.

---

### ❌ Mistake 3

> "If a component renders, something visible must have changed."

Incorrect.

A component can render and produce the same result.

---

### ❌ Mistake 4

> "I should perform API calls directly inside the component body."

Generally avoid side effects during render. Use an appropriate Effect or event handler depending on the operation.

---

# Interview Questions

### Q1. What are the main stages of a React update?

```text
Trigger
 ↓
Render
 ↓
Commit
```

---

### Q2. What happens during the render phase?

> React evaluates components and determines what the next UI should look like.

---

### Q3. What happens during the commit phase?

> React applies the necessary changes to the host environment, such as updating the browser DOM.

---

### Q4. Does every render cause a DOM update?

**No.**

React may determine that no DOM changes are necessary.

---

### Q5. Why should render logic be pure?

> Because React may render components multiple times, and rendering should not cause unintended side effects.

---

### Q6. What happens after `setState()`?

> The update is scheduled, React renders the affected component tree, reconciles the result, and commits the necessary changes.

---

# Remember

```text
              UPDATE
                 ↓
              Trigger
                 ↓
              RENDER
                 ↓
      "What should UI look like?"
                 ↓
          Reconciliation
                 ↓
              COMMIT
                 ↓
       "Apply required changes"
                 ↓
             DOM / UI
```

### Golden Rule

> **Render calculates. Commit applies.**

### One-line interview answer

> **In React, the render phase determines the next UI representation, while the commit phase applies the necessary changes to the DOM or other rendering environment.**
