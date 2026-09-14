# 03 — State Updates in React

## WHY?

State is not just about **storing data**. You also need to understand **how React updates that data**.

A common beginner mistake is thinking:

```jsx
setCount(10);
```

means:

> "Change `count` immediately to 10."

React's state update system is more controlled than that.

Understanding state updates helps you avoid:

* Incorrect counter values
* Multiple updates behaving unexpectedly
* Stale state
* Race-condition-like bugs
* Incorrect object/array updates

---

# WHAT?

A **state update** is a request to React to update a component's state.

For example:

```jsx
const [count, setCount] = useState(0);

setCount(1);
```

Here:

```text
count
  ↓
Current state

setCount()
  ↓
Requests a state update
```

After React processes the update, the component renders with the new state.

---

# WHERE?

State updates happen whenever the user or application needs to change state.

Examples:

```jsx
setCount(10);
```

```jsx
setName("Yash");
```

```jsx
setIsOpen(true);
```

```jsx
setItems(newItems);
```

Common places where state updates occur:

* Event handlers
* Form interactions
* API responses
* Timers
* Effects
* Other application logic

---

# HOW?

## 1. Basic State Update

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

Initially:

```text
count = 0
```

After clicking:

```text
count = 1
```

---

# 2. State Updates Trigger a Re-render

When you call:

```jsx
setCount(1);
```

React schedules an update.

Conceptually:

```text
setCount(1)
     ↓
State update requested
     ↓
React renders component
     ↓
Component sees count = 1
     ↓
UI is updated
```

You don't manually update the DOM.

---

# 3. State Updates Are Not Immediately Reflected in the Same Function

This is very important.

Consider:

```jsx
function handleClick() {
  setCount(count + 1);

  console.log(count);
}
```

You might expect:

```text
1
```

But the `console.log` can still see the **current render's value**, for example:

```text
0
```

Why?

Because calling the setter schedules the state update; it doesn't change the `count` variable from the current render in place.

Think of each render as having its own snapshot:

```text
Render 1
count = 0

      ↓ setCount(1)

Render 2
count = 1
```

---

# 4. Multiple Updates Can Be Surprising

Consider:

```jsx
function handleClick() {
  setCount(count + 1);
  setCount(count + 1);
  setCount(count + 1);
}
```

If:

```text
count = 0
```

you might expect:

```text
3
```

But these updates all use the `count` value from the same render.

So they effectively request:

```text
setCount(1)
setCount(1)
setCount(1)
```

The final result can therefore be:

```text
1
```

rather than `3`.

This leads to the next important concept.

---

# 5. Functional State Updates

When the new state depends on the **previous state**, use the functional updater form:

```jsx
setCount(prevCount => prevCount + 1);
```

Now:

```jsx
function handleClick() {
  setCount(prev => prev + 1);
  setCount(prev => prev + 1);
  setCount(prev => prev + 1);
}
```

If the initial value is:

```text
0
```

React can process them conceptually as:

```text
0 → 1
1 → 2
2 → 3
```

Result:

```text
3
```

This topic is covered in depth in the next file:

**`04-functional-state-updates.md`**

---

# 6. React Batches State Updates

React can **batch multiple state updates** together so that it can avoid unnecessary rendering work.

Example:

```jsx
function handleClick() {
  setFirstName("Yash");
  setLastName("Mahamuni");
}
```

React can process these updates together rather than unnecessarily rendering after each individual setter call.

Conceptually:

```text
setFirstName()
setLastName()
      ↓
   Batch updates
      ↓
   Render
      ↓
 Updated UI
```

Batching is one reason you shouldn't assume that every `setState` call immediately causes a separate DOM update.

---

# 7. State Updates Replace the State Value

For primitive values this is straightforward.

```jsx
const [count, setCount] = useState(0);

setCount(10);
```

The state becomes:

```text
10
```

For objects, however, you need to be careful.

Suppose:

```jsx
const [user, setUser] = useState({
  name: "Yash",
  age: 21
});
```

Don't do:

```jsx
setUser({
  age: 22
});
```

if you intend to keep `name`.

The new object would only contain:

```js
{
  age: 22
}
```

Instead:

```jsx
setUser({
  ...user,
  age: 22
});
```

Result:

```js
{
  name: "Yash",
  age: 22
}
```

We'll cover this more deeply in **state immutability**.

---

# 8. Updating Arrays

Suppose:

```jsx
const [items, setItems] = useState([]);
```

To add an item:

```jsx
setItems([
  ...items,
  "Apple"
]);
```

To remove an item:

```jsx
setItems(
  items.filter(item => item !== "Apple")
);
```

To update an item:

```jsx
setItems(
  items.map(item =>
    item.id === 1
      ? { ...item, completed: true }
      : item
  )
);
```

The key idea:

> Create a new array instead of modifying the existing state array.

---

# 9. State Updates with Objects

Example:

```jsx
const [user, setUser] = useState({
  name: "Yash",
  age: 21
});
```

Update only age:

```jsx
setUser(prevUser => ({
  ...prevUser,
  age: 22
}));
```

The functional form is especially useful when the new value depends on previous state.

---

# 10. State Updates from Events

Most React state updates happen inside event handlers.

```jsx
function App() {
  const [isOpen, setIsOpen] = useState(false);

  function handleToggle() {
    setIsOpen(prev => !prev);
  }

  return (
    <button onClick={handleToggle}>
      {isOpen ? "Close" : "Open"}
    </button>
  );
}
```

Flow:

```text
User clicks
    ↓
handleToggle()
    ↓
setIsOpen(...)
    ↓
State update
    ↓
React renders
    ↓
Button text changes
```

---

# 11. Don't Depend on the Updated State Immediately

Avoid thinking like this:

```jsx
setCount(count + 1);

doSomething(count);
```

`count` here still represents the value from the current render.

If you need to perform something based on the new value, design the logic appropriately—for example, calculate the next value yourself or use an effect when the operation truly needs to respond to committed state changes.

---

# Practical Example — Counter

### ❌ Potentially confusing

```jsx
function increase() {
  setCount(count + 1);

  console.log(count);
}
```

### ✅ If you need the next value

```jsx
function increase() {
  const nextCount = count + 1;

  setCount(nextCount);

  console.log(nextCount);
}
```

Or, when the update itself must be based on previous state:

```jsx
function increase() {
  setCount(prev => prev + 1);
}
```

---

# Practical Example — Shopping Cart

```jsx
function Cart() {
  const [cart, setCart] = useState([]);

  function addProduct(product) {
    setCart(prevCart => [
      ...prevCart,
      product
    ]);
  }

  return (
    <button
      onClick={() =>
        addProduct({
          id: 1,
          name: "Laptop"
        })
      }
    >
      Add to Cart
    </button>
  );
}
```

Using:

```jsx
setCart(prevCart => [
  ...prevCart,
  product
]);
```

makes it explicit that we're adding to the **previous cart state**.

---

# State Update Mental Model

Remember this:

```text
Current Render
     ↓
Current State Snapshot
     ↓
User Action
     ↓
setState(...)
     ↓
React schedules update
     ↓
New Render
     ↓
New State Snapshot
     ↓
Updated UI
```

The key concept is:

> **A state variable belongs to a particular render.**

Calling the setter doesn't mutate that variable in the current render.

---

# Common Mistakes

## ❌ Mistake 1 — Expecting immediate state change

```jsx
setCount(count + 1);

console.log(count);
```

Don't expect the log to show the newly updated value immediately.

---

## ❌ Mistake 2 — Multiple direct updates

```jsx
setCount(count + 1);
setCount(count + 1);
setCount(count + 1);
```

When each update depends on the previous value, prefer:

```jsx
setCount(prev => prev + 1);
setCount(prev => prev + 1);
setCount(prev => prev + 1);
```

---

## ❌ Mistake 3 — Mutating state

Wrong:

```jsx
items.push("Apple");
setItems(items);
```

Better:

```jsx
setItems(prev => [
  ...prev,
  "Apple"
]);
```

---

## ❌ Mistake 4 — Replacing an object accidentally

Wrong:

```jsx
setUser({
  age: 22
});
```

if you wanted to preserve the other fields.

Better:

```jsx
setUser(prev => ({
  ...prev,
  age: 22
}));
```

---

# WHEN?

Use a direct update:

```jsx
setCount(10);
```

when you're simply assigning a new value.

Use a functional update:

```jsx
setCount(prev => prev + 1);
```

when the new value depends on the previous state.

### Simple rule

```text
New value does NOT depend on old value
              ↓
setState(newValue)

New value DOES depend on old value
              ↓
setState(prev => newValue)
```

---

# Interview Questions

### 1. Are state updates synchronous?

Don't think of React state setters as normal synchronous assignments.

Calling a setter requests/schedules a state update, and the updated value is available in a subsequent render.

---

### 2. Why doesn't state update immediately after calling the setter?

Because the state variable belongs to the current render. The setter requests a new render rather than mutating that current render's variable.

---

### 3. What happens when multiple state updates occur?

React can batch updates, and when updates depend on previous state, functional updates ensure each update receives the appropriate previous value.

---

### 4. When should you use a functional state update?

When the next state depends on the previous state.

```jsx
setCount(prev => prev + 1);
```

---

### 5. What is batching?

Batching means React can group multiple state updates together to reduce unnecessary rendering work.

---

### 6. Can we directly modify state?

No.

Wrong:

```jsx
count++;
```

Correct:

```jsx
setCount(prev => prev + 1);
```

---

# ⭐ Remember

The most important rule:

```text
If next state depends on previous state:

setState(prev => ...)
```

Example:

```jsx
setCount(prev => prev + 1);
```

Think of state like a **snapshot**:

```text
Render 1 → count = 0
               ↓
          setCount(1)
               ↓
Render 2 → count = 1
```

### One-line interview answer

> **A React state update schedules a new render rather than immediately changing the current render's state variable; when the next value depends on the previous value, functional updates should be used.**
