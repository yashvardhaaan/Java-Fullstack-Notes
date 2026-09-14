# 03 — `useState` Hook in React

## WHY?

React components need to **remember information between renders**.

For example:

* Counter value
* Input value
* Login status
* Selected item
* Modal open/closed state
* Shopping cart items

A normal JavaScript variable doesn't provide the behavior we need:

```jsx
function Counter() {
  let count = 0;

  function increase() {
    count++;
  }

  return <button onClick={increase}>{count}</button>;
}
```

Changing `count` does **not tell React to render the component again**.

That's why React provides `useState`.

---

# WHAT?

### Definition

> **`useState` is a React Hook that allows a function component to store and update state.**

Import it:

```jsx
import { useState } from "react";
```

Basic syntax:

```jsx
const [state, setState] = useState(initialValue);
```

Example:

```jsx
const [count, setCount] = useState(0);
```

There are three parts:

```text
count
  ↓
Current state

setCount
  ↓
Function used to update state

0
  ↓
Initial value
```

---

# WHERE?

`useState` is used inside **function components** and Custom Hooks.

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  return <h1>{count}</h1>;
}
```

It is one of the most commonly used React Hooks.

---

# HOW?

## Basic Example

```jsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>Count: {count}</p>

      <button onClick={() => setCount(count + 1)}>
        Increase
      </button>
    </div>
  );
}
```

When the button is clicked:

```text
setCount(count + 1)
        ↓
State updates
        ↓
React schedules a re-render
        ↓
Component renders again
        ↓
New count appears
```

---

# Understanding the Syntax

```jsx
const [count, setCount] = useState(0);
```

This uses **array destructuring**.

Conceptually, React gives you:

```text
[
  currentState,
  updateFunction
]
```

So:

```jsx
const [count, setCount] = useState(0);
```

means:

```text
count     → current value
setCount  → function to update it
```

---

# Updating State

You can update state using the setter:

```jsx
setCount(10);
```

Now the next render will see:

```jsx
count === 10
```

Another example:

```jsx
const [name, setName] = useState("Yash");

setName("Rahul");
```

---

# State Can Store Different Data Types

## Number

```jsx
const [count, setCount] = useState(0);
```

## String

```jsx
const [name, setName] = useState("");
```

## Boolean

```jsx
const [isOpen, setIsOpen] = useState(false);
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

# Boolean Example

A very common use case is opening and closing a modal.

```jsx
function Modal() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <>
      <button onClick={() => setIsOpen(true)}>
        Open
      </button>

      {isOpen && (
        <div>
          <h2>Modal</h2>

          <button onClick={() => setIsOpen(false)}>
            Close
          </button>
        </div>
      )}
    </>
  );
}
```

Flow:

```text
false
 ↓
Click Open
 ↓
setIsOpen(true)
 ↓
true
 ↓
Modal appears
```

---

# Updating Object State

Suppose:

```jsx
const [user, setUser] = useState({
  name: "Yash",
  age: 21
});
```

### ❌ Don't mutate the existing object

```jsx
user.age = 22;
```

This directly changes the existing object.

### ✅ Create a new object

```jsx
setUser({
  ...user,
  age: 22
});
```

The spread operator copies the existing properties.

Result:

```jsx
{
  name: "Yash",
  age: 22
}
```

---

# Updating Array State

Suppose:

```jsx
const [items, setItems] = useState([]);
```

### Add an item

```jsx
setItems([
  ...items,
  "Laptop"
]);
```

### Remove an item

```jsx
setItems(
  items.filter(item => item !== "Laptop")
);
```

### Update an item

```jsx
setItems(
  items.map(item =>
    item === "Laptop"
      ? "MacBook"
      : item
  )
);
```

The important principle is:

> **Don't mutate state directly. Create a new value and pass it to the setter.**

---

# Functional State Updates

Sometimes the new state depends on the previous state.

Instead of:

```jsx
setCount(count + 1);
```

you can use:

```jsx
setCount(prevCount => prevCount + 1);
```

This is especially useful when multiple updates happen based on previous state.

Example:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  function increase() {
    setCount(prev => prev + 1);
    setCount(prev => prev + 1);
  }

  return (
    <button onClick={increase}>
      {count}
    </button>
  );
}
```

The functional updater ensures each update receives the latest pending state.

---

# Lazy Initial State

If calculating the initial state is expensive, you can pass a function:

```jsx
const [data, setData] = useState(() => {
  return expensiveCalculation();
});
```

The function is used to initialize the state rather than calling the calculation on every render.

### Important

```jsx
useState(expensiveCalculation());
```

calls the function while rendering.

Whereas:

```jsx
useState(() => expensiveCalculation());
```

provides an initializer function.

---

# Does `setState` Immediately Change the Variable?

Consider:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  function handleClick() {
    setCount(count + 1);

    console.log(count);
  }

  return <button onClick={handleClick}>{count}</button>;
}
```

The `console.log` does **not necessarily show the updated value**.

It sees the `count` value from the current render.

Think:

```text
Current render
     ↓
count = 0
     ↓
setCount(1)
     ↓
React schedules update
     ↓
New render
     ↓
count = 1
```

---

# State and Re-rendering

Calling the setter tells React that the component's state has changed.

```jsx
setCount(5);
```

React then renders the component again with the new state.

```text
State update
     ↓
React renders component
     ↓
React commits necessary DOM changes
     ↓
UI reflects new state
```

---

# Multiple State Variables

You can use `useState` multiple times.

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

This is completely valid.

---

# `useState` vs Normal Variable

### Normal variable

```jsx
let count = 0;

count++;
```

React isn't informed that the UI should update.

### State

```jsx
const [count, setCount] = useState(0);

setCount(count + 1);
```

React is informed about the state update and can render the component with the new state.

---

# Practical Example — Todo List

```jsx
import { useState } from "react";

function TodoApp() {
  const [todos, setTodos] = useState([]);
  const [text, setText] = useState("");

  function addTodo() {
    if (!text.trim()) return;

    setTodos(prev => [
      ...prev,
      {
        id: Date.now(),
        text: text
      }
    ]);

    setText("");
  }

  return (
    <div>
      <input
        value={text}
        onChange={e => setText(e.target.value)}
      />

      <button onClick={addTodo}>
        Add
      </button>

      {todos.map(todo => (
        <p key={todo.id}>
          {todo.text}
        </p>
      ))}
    </div>
  );
}
```

Here we have:

```text
text
 ↓
Input state

todos
 ↓
Todo list state
```

Both are managed using `useState`.

---

# WHEN?

Use `useState` when a value:

* Changes over time
* Affects what the component renders
* Needs to persist between renders

Examples:

```text
Counter
 ↓
count

Form
 ↓
input values

Modal
 ↓
isOpen

Dropdown
 ↓
isOpen

Tabs
 ↓
activeTab

Todo app
 ↓
todos

Shopping cart
 ↓
cartItems
```

---

# When NOT to Use `useState`

Don't create state just because you have a variable.

For example:

```jsx
const price = 100;
const tax = price * 0.18;
```

You don't need:

```jsx
const [tax, setTax] = useState(18);
```

because `tax` can be derived:

```jsx
const tax = price * 0.18;
```

Remember the previous topic:

> **Don't store derived data as separate state unnecessarily.**

---

# Common Mistakes

### ❌ Direct mutation

```jsx
user.name = "Rahul";
```

### ✅

```jsx
setUser({
  ...user,
  name: "Rahul"
});
```

---

### ❌ Assuming state changes immediately

```jsx
setCount(10);
console.log(count);
```

The current render's `count` doesn't change in place.

---

### ❌ Using current state when the next state depends on previous state

```jsx
setCount(count + 1);
```

Often okay for one update, but prefer:

```jsx
setCount(prev => prev + 1);
```

when the update depends on previous state, especially for multiple queued updates.

---

### ❌ Storing unnecessary derived data

```jsx
const [firstName, setFirstName] = useState("");
const [lastName, setLastName] = useState("");
const [fullName, setFullName] = useState("");
```

Prefer:

```jsx
const fullName = `${firstName} ${lastName}`;
```

---

# 🎯 Interview Questions

### 1. What is `useState`?

> `useState` is a React Hook that allows function components to maintain state between renders and update the UI when that state changes.

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

### 3. Does calling the state setter immediately change the current state variable?

No. The setter schedules a state update; the current render continues to see its existing state value.

---

### 4. Why should state not be mutated directly?

React state should be treated as immutable. Creating a new value makes state updates predictable and allows React to properly detect and process changes.

---

### 5. When should you use a functional state update?

When the next state depends on the previous state:

```jsx
setCount(prev => prev + 1);
```

---

### 6. Can a component have multiple `useState` Hooks?

Yes.

```jsx
const [name, setName] = useState("");
const [age, setAge] = useState(0);
const [isOpen, setIsOpen] = useState(false);
```

---

### 7. What is lazy initialization in `useState`?

You can provide an initializer function:

```jsx
const [value, setValue] = useState(() => expensiveCalculation());
```

This lets React initialize the state from that function rather than evaluating the calculation as a normal argument on every render.

---

# ⭐ Remember

```text
useState(initialValue)
        ↓
[currentState, setter]
        ↓
setter(...)
        ↓
State update
        ↓
Component renders again
        ↓
UI updates
```

### Golden Rules

```text
1. Don't mutate state directly.
2. Use the setter to update state.
3. Use functional updates when based on previous state.
4. Don't store unnecessary derived data.
5. State persists between renders.
6. State belongs to a particular component instance.
```

### One-line interview answer

> **`useState` is a React Hook that lets function components store state between renders and provides a setter that requests an update when the state changes.**
