# 02 — `useState` in React

## WHY?

A React component needs a way to **create and manage state**.

For this, React provides the `useState` Hook.

Without `useState`, changing a normal JavaScript variable does not cause React to update the UI.

```jsx
let count = 0;

count++;
```

The value changes in JavaScript, but React doesn't automatically re-render because of it.

With `useState`:

```jsx
const [count, setCount] = useState(0);
```

React knows that `count` is state and can update the UI when `setCount()` is called.

---

# WHAT?

`useState` is a React Hook that allows a **function component to have state**.

Basic syntax:

```jsx
const [state, setState] = useState(initialValue);
```

Example:

```jsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  return <h1>{count}</h1>;
}
```

There are three parts:

```text
useState(0)
     ↓
Initial value

count
     ↓
Current state

setCount
     ↓
Function used to update state
```

---

# WHERE?

You use `useState` inside React function components.

```jsx
function App() {
  const [name, setName] = useState("Yash");

  return <h1>{name}</h1>;
}
```

Common use cases:

* Counters
* Forms
* Checkboxes
* Dropdowns
* Modals
* Tabs
* Shopping carts
* Login/logout UI
* Loading states

---

# HOW?

## 1. Import `useState`

```jsx
import { useState } from "react";
```

---

## 2. Declare State

```jsx
const [count, setCount] = useState(0);
```

This creates:

```text
count = 0
setCount = state updater function
```

---

## 3. Read State

```jsx
<h1>{count}</h1>
```

---

## 4. Update State

```jsx
setCount(10);
```

React will update the state and schedule a re-render.

---

# Practical Example — Counter

```jsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  function increase() {
    setCount(count + 1);
  }

  return (
    <div>
      <h1>Count: {count}</h1>

      <button onClick={increase}>
        Increase
      </button>
    </div>
  );
}

export default Counter;
```

### Flow

```text
Initial state
count = 0
    ↓
User clicks button
    ↓
increase()
    ↓
setCount(1)
    ↓
React schedules update
    ↓
Component renders again
    ↓
count = 1
    ↓
UI shows 1
```

---

# Initial State

The value passed to `useState()` becomes the initial state.

```jsx
const [name, setName] = useState("Yash");
```

Initial value:

```text
"Yash"
```

Another example:

```jsx
const [count, setCount] = useState(100);
```

Initial value:

```text
100
```

Boolean:

```jsx
const [isOpen, setIsOpen] = useState(false);
```

Array:

```jsx
const [items, setItems] = useState([]);
```

Object:

```jsx
const [user, setUser] = useState({
  name: "Yash",
  age: 21
});
```

---

# Updating Different Types of State

## String

```jsx
const [name, setName] = useState("");

setName("Yash");
```

---

## Number

```jsx
const [count, setCount] = useState(0);

setCount(10);
```

---

## Boolean

```jsx
const [isOpen, setIsOpen] = useState(false);

setIsOpen(true);
```

---

## Array

```jsx
const [items, setItems] = useState([]);

setItems(["Apple", "Mango"]);
```

---

## Object

```jsx
const [user, setUser] = useState({
  name: "Yash",
  age: 21
});
```

When updating an object, preserve the other properties:

```jsx
setUser({
  ...user,
  age: 22
});
```

We'll study this more deeply under **state immutability**.

---

# Multiple State Variables

A component can have multiple pieces of state.

```jsx
function Profile() {
  const [name, setName] = useState("Yash");
  const [age, setAge] = useState(21);
  const [isOnline, setIsOnline] = useState(true);

  return (
    <div>
      <h1>{name}</h1>
      <p>{age}</p>
      <p>{isOnline ? "Online" : "Offline"}</p>
    </div>
  );
}
```

Conceptually:

```text
Component
   │
   ├── name
   ├── age
   └── isOnline
```

Each state variable has its own updater.

---

# Updating State Based on Current State

Suppose:

```jsx
const [count, setCount] = useState(0);
```

You can write:

```jsx
setCount(count + 1);
```

This is fine when the update is straightforward and based on the current render's value.

But when the new state depends on the **previous state**, a functional update is often the safer pattern:

```jsx
setCount(prevCount => prevCount + 1);
```

This is especially important when performing multiple updates.

We'll cover **functional state updates** separately.

---

# State Updates Are Not Normal Assignments

You should not do:

```jsx
count = 10;
```

❌ Don't directly assign to state.

Use:

```jsx
setCount(10);
```

✅

Think:

```text
Wrong:
count = 10

Correct:
setCount(10)
```

---

# State Is Preserved Between Renders

Consider:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  console.log("Rendering");

  return (
    <button onClick={() => setCount(count + 1)}>
      {count}
    </button>
  );
}
```

After clicking:

```text
Render 1 → count = 0
       ↓
Click
       ↓
setCount(1)
       ↓
Render 2 → count = 1
```

React remembers the state value between renders.

That's one of the main reasons `useState` exists.

---

# State Is Associated With Component Position

Consider:

```jsx
function App() {
  return (
    <>
      <Counter />
      <Counter />
    </>
  );
}
```

Each `Counter` gets its own state.

```text
Counter #1
count = 0

Counter #2
count = 0
```

If Counter #1 becomes:

```text
count = 5
```

Counter #2 remains:

```text
count = 0
```

State is not automatically shared between component instances.

---

# Lazy Initial State

Sometimes calculating the initial state is expensive.

Instead of:

```jsx
const [data, setData] = useState(expensiveCalculation());
```

you can provide a function:

```jsx
const [data, setData] = useState(() => expensiveCalculation());
```

The function tells React how to calculate the initial value.

Example:

```jsx
const [items, setItems] = useState(() => {
  return createInitialItems();
});
```

This pattern is called **lazy initialization**.

---

# Important: Function vs Function Result

These two are different:

```jsx
useState(expensiveCalculation())
```

and:

```jsx
useState(() => expensiveCalculation())
```

The second form passes a function for React to use for initialization.

This is useful when the initial value requires meaningful computation.

---

# `useState` and Re-rendering

When you call:

```jsx
setCount(10);
```

React doesn't simply change the DOM immediately like:

```jsx
document.querySelector(...).innerText = 10;
```

Instead, React updates its state and renders the component based on the new state.

Conceptually:

```text
setState()
   ↓
State update
   ↓
React renders
   ↓
React compares output
   ↓
Necessary DOM updates
```

---

# Common Mistakes

## ❌ Mistake 1 — Directly modifying state

```jsx
count = count + 1;
```

Wrong.

### ✅

```jsx
setCount(count + 1);
```

---

## ❌ Mistake 2 — Forgetting to import `useState`

```jsx
const [count, setCount] = useState(0);
```

If using the named import style, you need:

```jsx
import { useState } from "react";
```

---

## ❌ Mistake 3 — Calling `useState` outside a component

Don't do:

```jsx
const [count, setCount] = useState(0);

function App() {
  ...
}
```

Hooks must follow the **Rules of Hooks** and are normally called at the top level of a React function component or custom Hook.

Correct:

```jsx
function App() {
  const [count, setCount] = useState(0);

  return <h1>{count}</h1>;
}
```

---

## ❌ Mistake 4 — Calling Hooks conditionally

Don't:

```jsx
if (isLoggedIn) {
  const [user, setUser] = useState(null);
}
```

Hooks should not be called inside:

* `if`
* `for`
* `while`
* nested functions
* conditional branches

Instead:

```jsx
function App() {
  const [user, setUser] = useState(null);

  if (!user) {
    return <Login />;
  }

  return <Dashboard />;
}
```

---

# WHEN?

Use `useState` when a component needs to remember **changing information that affects its UI**.

### Counter

```jsx
const [count, setCount] = useState(0);
```

### Input

```jsx
const [email, setEmail] = useState("");
```

### Modal

```jsx
const [isModalOpen, setIsModalOpen] = useState(false);
```

### Selected tab

```jsx
const [activeTab, setActiveTab] = useState("home");
```

### Loading state

```jsx
const [loading, setLoading] = useState(false);
```

---

# When NOT to Use `useState`

Don't automatically put every variable into state.

For example:

```jsx
const price = 100;
const tax = 18;
```

If these values don't change and don't need to persist as state, regular variables/constants are sufficient.

Similarly, don't create state for something that can simply be calculated from existing state.

```jsx
const fullName = `${firstName} ${lastName}`;
```

rather than maintaining another `fullName` state unnecessarily.

---

# Interview Questions

### 1. What is `useState`?

> `useState` is a React Hook that allows function components to create and manage state.

---

### 2. What does `useState()` return?

It returns an array containing:

```text
[currentState, stateUpdater]
```

Example:

```jsx
const [count, setCount] = useState(0);
```

---

### 3. What is the first argument of `useState`?

The first argument is the **initial state value**.

```jsx
useState(0)
useState("")
useState(false)
useState([])
useState({})
```

---

### 4. Can `useState` store objects?

Yes.

```jsx
const [user, setUser] = useState({
  name: "Yash",
  age: 21
});
```

---

### 5. Can a component have multiple `useState` calls?

Yes.

```jsx
const [name, setName] = useState("");
const [age, setAge] = useState(21);
const [active, setActive] = useState(false);
```

---

### 6. Why can't we directly modify state?

Because React needs state updates to go through its state-update mechanism.

Use:

```jsx
setCount(10);
```

instead of:

```jsx
count = 10;
```

---

### 7. Can Hooks be called inside an `if` statement?

**No.**

Hooks must be called consistently at the top level of a component or custom Hook.

---

### 8. What is lazy initialization in `useState`?

Instead of immediately calculating an expensive initial value:

```jsx
useState(expensiveCalculation())
```

you can provide an initializer function:

```jsx
useState(() => expensiveCalculation())
```

---

# ⭐ Remember

The most important syntax:

```jsx
const [state, setState] = useState(initialValue);
```

Think of it as:

```text
useState()
    ↓
Creates state
    ↓
[state, setter]
    ↓
setter changes state
    ↓
React renders again
    ↓
UI reflects new state
```

### One-line interview answer

> **`useState` is a React Hook that lets function components store changing data and provides a setter function that schedules an update when the state changes.**
