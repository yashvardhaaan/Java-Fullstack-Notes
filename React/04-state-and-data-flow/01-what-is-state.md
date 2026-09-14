# 01 — What is State in React?

## WHY?

A React component needs to **remember information that can change over time**.

For example:

* Counter value
* Login status
* Input text
* Selected product
* Dark/light mode
* Whether a menu is open
* Shopping cart items

Normal JavaScript variables do not tell React:

> "The UI needs to be updated because this value changed."

React **state** solves this problem.

---

# WHAT?

**State is data that belongs to a component and can change over time.**

When state changes, React can **re-render the component** and update the UI.

Simple example:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  return <h1>{count}</h1>;
}
```

Here:

```text
count
  ↓
Current state value

setCount
  ↓
Function used to update state

0
  ↓
Initial value
```

---

# State vs Normal Variable

Consider this:

```jsx
function Counter() {
  let count = 0;

  function increase() {
    count++;
    console.log(count);
  }

  return (
    <button onClick={increase}>
      {count}
    </button>
  );
}
```

You might expect the button to display:

```text
1
2
3
```

But it won't work as expected.

Why?

Because changing:

```jsx
count++;
```

does **not tell React to render the component again**.

---

## With State

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  function increase() {
    setCount(count + 1);
  }

  return (
    <button onClick={increase}>
      {count}
    </button>
  );
}
```

Now:

```text
Click
 ↓
setCount()
 ↓
State changes
 ↓
React re-renders
 ↓
Updated count appears
```

---

# WHERE?

State is used inside React components when information needs to:

1. Persist between renders
2. Change over time
3. Affect what appears on the screen

Examples:

### Form

```jsx
const [email, setEmail] = useState("");
```

### Counter

```jsx
const [count, setCount] = useState(0);
```

### Menu

```jsx
const [isOpen, setIsOpen] = useState(false);
```

### User

```jsx
const [user, setUser] = useState(null);
```

### Shopping cart

```jsx
const [cart, setCart] = useState([]);
```

---

# HOW?

React provides hooks for managing state.

The most basic one is:

```jsx
useState()
```

Example:

```jsx
import { useState } from "react";

function App() {
  const [name, setName] = useState("Yash");

  return (
    <h1>
      Hello {name}
    </h1>
  );
}
```

Here:

```jsx
const [name, setName] = useState("Yash");
```

contains three important concepts:

```text
name
 ↓
Current state

setName
 ↓
State updater

"Yash"
 ↓
Initial state
```

---

# State Changes Trigger Rendering

This is one of the most important concepts in React.

```jsx
setName("Rahul");
```

causes React to schedule an update.

Conceptually:

```text
Initial State
     ↓
name = "Yash"
     ↓
User performs an action
     ↓
setName("Rahul")
     ↓
State update
     ↓
Component renders again
     ↓
name = "Rahul"
     ↓
UI updates
```

---

# Practical Example — Counter

```jsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <h1>Count: {count}</h1>

      <button onClick={() => setCount(count + 1)}>
        Increase
      </button>

      <button onClick={() => setCount(count - 1)}>
        Decrease
      </button>
    </div>
  );
}

export default Counter;
```

### Initial state

```text
count = 0
```

Click Increase:

```text
count = 1
```

Click again:

```text
count = 2
```

---

# State Can Store Different Types

State isn't limited to numbers.

## String

```jsx
const [name, setName] = useState("Yash");
```

## Number

```jsx
const [age, setAge] = useState(21);
```

## Boolean

```jsx
const [isLoggedIn, setIsLoggedIn] = useState(false);
```

## Array

```jsx
const [items, setItems] = useState([]);
```

## Object

```jsx
const [user, setUser] = useState({
  name: "Yash",
  age: 21
});
```

---

# State and UI

A useful way to understand React is:

```text
             State
               ↓
        Component renders
               ↓
              UI
```

When state changes:

```text
State changes
     ↓
React renders again
     ↓
UI reflects new state
```

This is why React is called a **declarative UI library**.

You describe:

> "What should the UI look like for this state?"

React handles updating the DOM.

---

# State Is Local by Default

Consider:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  return <h1>{count}</h1>;
}
```

The state belongs to that component instance.

If you render the component twice:

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

You get two independent state values:

```text
Counter 1
count = 0

Counter 2
count = 0
```

If Counter 1 becomes:

```text
count = 5
```

Counter 2 remains:

```text
count = 0
```

This is called **local component state**.

---

# State vs Props

This is a very important distinction.

| State                      | Props                              |
| -------------------------- | ---------------------------------- |
| Managed by component       | Passed from parent                 |
| Can change                 | Read-only from child               |
| Updated using state setter | Parent controls the value          |
| Used for changing data     | Used for passing data              |
| Can trigger re-render      | Can trigger re-render when changed |

Example:

```jsx
function Parent() {
  const [name, setName] = useState("Yash");

  return <Child name={name} />;
}
```

Here:

```text
Parent
  │
  │ name prop
  ↓
Child
```

`name` is **state in Parent** but **prop in Child**.

---

# State vs Props Example

```jsx
function Parent() {
  const [count, setCount] = useState(0);

  return (
    <Child
      count={count}
      onIncrease={() => setCount(count + 1)}
    />
  );
}
```

Parent owns the state:

```jsx
const [count, setCount] = useState(0);
```

Child receives:

```jsx
count
```

and:

```jsx
onIncrease
```

as props.

---

# When Should Something Be State?

Ask these three questions:

### 1. Can the value change?

```text
Yes → Continue
No  → Probably doesn't need state
```

### 2. Does the value need to survive re-renders?

```text
Yes → State may be appropriate
```

### 3. Should changing it update the UI?

```text
Yes → State is a strong candidate
```

---

# Example — Is This State?

Suppose you have:

```jsx
const firstName = "Yash";
const lastName = "Mahamuni";
```

Do we need:

```jsx
const [fullName, setFullName] = useState("");
```

Usually **no**.

Because:

```jsx
const fullName = `${firstName} ${lastName}`;
```

can be calculated directly.

This is called **derived data**, which we'll cover later.

---

# Common Mistakes

## ❌ Mistake 1 — Using normal variables for UI state

```jsx
let count = 0;

count++;
```

This doesn't tell React to update the UI.

### ✅ Use state

```jsx
const [count, setCount] = useState(0);

setCount(count + 1);
```

---

## ❌ Mistake 2 — Directly modifying state

If state contains an object:

```jsx
const [user, setUser] = useState({
  name: "Yash"
});
```

Don't do:

```jsx
user.name = "Rahul";
```

We'll cover **state immutability** in detail later.

---

## ❌ Mistake 3 — Storing everything in state

Not every variable needs to be state.

Bad design:

```jsx
const [firstName, setFirstName] = useState("Yash");
const [lastName, setLastName] = useState("Mahamuni");
const [fullName, setFullName] = useState("Yash Mahamuni");
```

If `fullName` can be calculated, don't unnecessarily store it.

---

# WHEN?

Use state when a value:

```text
Changes over time
      +
Needs to persist between renders
      +
Affects the UI
```

Examples:

| Situation              | State?    |
| ---------------------- | --------- |
| Counter value          | ✅         |
| Input text             | ✅         |
| Menu open/closed       | ✅         |
| Login status           | ✅         |
| Selected tab           | ✅         |
| Shopping cart          | ✅         |
| Constant API URL       | ❌         |
| Fixed application name | ❌         |
| Calculated full name   | Usually ❌ |
| Temporary calculation  | Usually ❌ |

---

# Interview Questions

### 1. What is state in React?

**Answer:**

> State is data managed by a React component that can change over time. When state changes, React can re-render the component and update the UI.

---

### 2. Why do we need state?

Because React needs a mechanism to remember changing data between renders and update the UI when that data changes.

---

### 3. What happens when state changes?

Conceptually:

```text
State update
    ↓
React schedules an update
    ↓
Component renders again
    ↓
React commits necessary DOM changes
```

---

### 4. Can state store objects and arrays?

Yes.

```jsx
const [user, setUser] = useState({});
```

```jsx
const [items, setItems] = useState([]);
```

---

### 5. Is state local to a component?

By default, yes. State belongs to the component instance where it is declared.

---

### 6. What is the difference between state and props?

> **State is data managed by a component, while props are data passed into a component by its parent.**

---

### 7. Does every variable need to be state?

**No.**

Only values that need to persist between renders and whose changes should affect rendering generally need state.

---

# ⭐ Remember

Think of state like the **memory of a component**:

```text
Component
    │
    ├── State
    │     ↓
    │   Remembers changing data
    │
    ↓
    UI
```

The core React relationship is:

```text
STATE
  ↓
RENDER
  ↓
UI
  ↑
  │
USER EVENT
  │
  └── STATE UPDATE
```

### One-line interview answer

> **State is React-managed data that persists between renders and, when updated, causes React to update the component's UI.**
