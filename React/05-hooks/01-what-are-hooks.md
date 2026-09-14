# 01 — What Are Hooks in React?

## WHY?

Before Hooks, React mainly used **class components** to handle things like:

* State
* Lifecycle methods
* Side effects

Functional components were simpler, but they couldn't easily use these React features.

**Hooks solved this problem.**

Hooks allow functional components to use React features such as:

```text
State
Side Effects
Context
Refs
Reducers
Memoization
```

So instead of writing:

```jsx
class Counter extends React.Component {
  // state and lifecycle methods
}
```

we can write:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  return <button>{count}</button>;
}
```

---

# WHAT?

### Definition

> **Hooks are special React functions that allow functional components to use React features such as state, context, refs, effects, and other capabilities.**

Hooks normally start with:

```text
use...
```

Examples:

```jsx
useState()
useEffect()
useRef()
useContext()
useReducer()
useMemo()
useCallback()
```

---

# WHERE?

Hooks are primarily used **inside React function components** or **inside custom Hooks**.

Example:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  return <p>{count}</p>;
}
```

You can also create your own Hook:

```jsx
function useUser() {
  // Hook logic
}
```

Then use it inside a component:

```jsx
function Profile() {
  const user = useUser();

  return <h1>{user.name}</h1>;
}
```

---

# HOW?

Hooks provide different capabilities.

## 1. `useState`

Used to manage component state.

```jsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <button onClick={() => setCount(count + 1)}>
      {count}
    </button>
  );
}
```

Flow:

```text
useState
   ↓
State
   ↓
setState()
   ↓
Component re-renders
   ↓
Updated UI
```

---

# 2. `useEffect`

Used to synchronize a component with an **external system** or perform side-effect logic.

Example:

```jsx
import { useEffect } from "react";

function App() {
  useEffect(() => {
    console.log("Component rendered");
  }, []);

  return <h1>Hello</h1>;
}
```

Common uses include:

* API synchronization
* Subscriptions
* Timers
* Event listeners
* Browser APIs

---

# 3. `useRef`

Used to hold a value across renders without causing a re-render when that value changes.

It is also commonly used to access DOM elements.

```jsx
import { useRef } from "react";

function Input() {
  const inputRef = useRef(null);

  function focusInput() {
    inputRef.current.focus();
  }

  return (
    <>
      <input ref={inputRef} />
      <button onClick={focusInput}>
        Focus
      </button>
    </>
  );
}
```

---

# 4. `useContext`

Used to consume data from React Context.

```jsx
const theme = useContext(ThemeContext);
```

Useful for avoiding unnecessary prop drilling.

---

# 5. `useReducer`

Useful when state logic becomes more complex.

```jsx
const [state, dispatch] = useReducer(reducer, initialState);
```

Instead of directly changing state:

```text
setState(...)
```

you dispatch actions:

```jsx
dispatch({ type: "increment" });
```

---

# 6. `useMemo`

Used to cache the result of a calculation between renders when appropriate.

```jsx
const result = useMemo(() => {
  return expensiveCalculation(data);
}, [data]);
```

---

# 7. `useCallback`

Used to cache a function between renders when appropriate.

```jsx
const handleClick = useCallback(() => {
  console.log("Clicked");
}, []);
```

---

# Hooks at a Glance

| Hook          | Main Purpose                      |
| ------------- | --------------------------------- |
| `useState`    | Manage state                      |
| `useEffect`   | Synchronize with external systems |
| `useRef`      | Store mutable values / access DOM |
| `useContext`  | Read Context                      |
| `useReducer`  | Manage complex state logic        |
| `useMemo`     | Cache calculated values           |
| `useCallback` | Cache function references         |
| Custom Hook   | Reuse stateful logic              |

---

# Practical Example

Imagine you're building a shopping application.

You might use:

```text
useState
   ↓
Shopping cart state

useEffect
   ↓
Synchronize with server/local storage

useContext
   ↓
Current user/theme

useRef
   ↓
Focus search input

useMemo
   ↓
Calculate filtered products

useCallback
   ↓
Stable callback for optimized child components
```

---

# Hooks vs Normal Functions

This is important.

### Normal function

```jsx
function add(a, b) {
  return a + b;
}
```

This is just a JavaScript function.

### Hook

```jsx
function useCounter() {
  const [count, setCount] = useState(0);

  return { count, setCount };
}
```

A Hook follows React's Hook rules and can use other Hooks.

---

# Can Hooks Be Called Anywhere?

**No.**

You cannot randomly call:

```jsx
function calculate() {
  const [count, setCount] = useState(0); // ❌
}
```

Hooks must follow the **Rules of Hooks**.

We'll cover those in the next topic.

---

# WHEN?

Use Hooks when you need React functionality inside a function component.

### Need state?

```jsx
useState()
```

### Need an external-system synchronization?

```jsx
useEffect()
```

### Need a DOM reference?

```jsx
useRef()
```

### Need shared Context data?

```jsx
useContext()
```

### Need complex state logic?

```jsx
useReducer()
```

### Need reusable stateful logic?

```jsx
Custom Hook
```

---

# Common Mistakes

### ❌ Calling a Hook conditionally

```jsx
if (isLoggedIn) {
  useState(); // ❌
}
```

### ❌ Calling Hooks inside loops

```jsx
for (...) {
  useState(); // ❌
}
```

### ❌ Calling Hooks inside normal helper functions

```jsx
function helper() {
  useEffect(...); // ❌
}
```

### ❌ Thinking every `use...` function is a React Hook

```jsx
function useAdd(a, b) {
  return a + b;
}
```

The `use` prefix conventionally indicates a custom Hook, but the important point is whether it follows Hook usage rules and uses React Hooks appropriately.

---

# 🎯 Interview Questions

### 1. What are Hooks in React?

> Hooks are special React functions that allow function components to use features such as state, effects, context, refs, and reducers.

---

### 2. Why were Hooks introduced?

> Hooks were introduced to allow function components to use state and other React features without needing class components, and to make reusable stateful logic easier.

---

### 3. Can Hooks be used inside class components?

No. Hooks are designed for **function components and custom Hooks**.

---

### 4. What are some commonly used Hooks?

```text
useState
useEffect
useContext
useRef
useReducer
useMemo
useCallback
```

---

### 5. What is a Custom Hook?

A Custom Hook is a JavaScript function that follows the Hook naming convention (`use...`) and can use other Hooks to encapsulate and reuse stateful logic.

Example:

```jsx
function useOnlineStatus() {
  // reusable Hook logic
}
```

---

### 6. Are Hooks just JavaScript functions?

They are JavaScript functions provided by React (or custom functions built using Hooks), but they have **special rules about where and how they can be called**.

---

# ⭐ Remember

```text
Hooks = React features available in function components

useState     → State
useEffect    → External-system synchronization
useRef       → Persistent mutable value / DOM reference
useContext   → Context
useReducer   → Complex state logic
useMemo      → Cached calculation
useCallback  → Cached function
Custom Hook  → Reusable stateful logic
```

### One-line interview answer

> **Hooks are special React functions that let function components use state, effects, context, refs, and other React features without writing class components.**
