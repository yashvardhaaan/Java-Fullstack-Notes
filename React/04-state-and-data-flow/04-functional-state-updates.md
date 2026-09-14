# 04 — Functional State Updates in React

## WHY?

Sometimes the new state depends on the **previous state**.

For example:

```jsx
setCount(count + 1);
```

Here, the next value depends on the current `count`.

This can become problematic when:

* Multiple state updates happen together
* Updates happen quickly
* Updates are queued/batched
* The calculation depends on the previous state

React provides the **functional state updater** for exactly this situation.

---

# WHAT?

A functional state update passes a **function** to the state setter.

Instead of:

```jsx
setCount(count + 1);
```

you write:

```jsx
setCount(prevCount => prevCount + 1);
```

The `prevCount` parameter represents the state value that React should use as the previous state for that update.

---

# Basic Syntax

```jsx
setState(previousState => {
  return newState;
});
```

Short form:

```jsx
setState(previousState => newValue);
```

Example:

```jsx
setCount(prevCount => prevCount + 1);
```

---

# WHERE?

Functional updates are useful whenever your new state depends on the old state.

Examples:

### Counter

```jsx
setCount(prev => prev + 1);
```

### Boolean toggle

```jsx
setIsOpen(prev => !prev);
```

### Adding to an array

```jsx
setItems(prev => [...prev, newItem]);
```

### Updating an object

```jsx
setUser(prev => ({
  ...prev,
  age: prev.age + 1
}));
```

---

# HOW?

## 1. Normal State Update

Suppose:

```jsx
const [count, setCount] = useState(0);
```

You can write:

```jsx
setCount(count + 1);
```

This uses the `count` value from the current render.

---

## 2. Functional State Update

Instead:

```jsx
setCount(prevCount => prevCount + 1);
```

React provides the appropriate previous state value to the updater function.

Conceptually:

```text
Previous state
      ↓
prevCount
      ↓
prevCount + 1
      ↓
New state
```

---

# Example — Counter

```jsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  function increase() {
    setCount(prevCount => prevCount + 1);
  }

  return (
    <div>
      <h1>{count}</h1>

      <button onClick={increase}>
        Increase
      </button>
    </div>
  );
}
```

When clicked:

```text
0
 ↓
prevCount = 0
 ↓
0 + 1
 ↓
1
```

Next click:

```text
1
 ↓
prevCount = 1
 ↓
1 + 1
 ↓
2
```

---

# The Important Problem: Multiple Updates

Consider:

```jsx
function increase() {
  setCount(count + 1);
  setCount(count + 1);
  setCount(count + 1);
}
```

Suppose:

```text
count = 0
```

All three expressions are based on the same `count` from that render:

```text
setCount(1)
setCount(1)
setCount(1)
```

So you should not use this pattern when you intend to apply three sequential increments.

---

# Functional Version

```jsx
function increase() {
  setCount(prev => prev + 1);
  setCount(prev => prev + 1);
  setCount(prev => prev + 1);
}
```

Now each updater can be applied to the result of the preceding update:

```text
Initial
  0
  ↓
prev = 0 → 1
  ↓
prev = 1 → 2
  ↓
prev = 2 → 3
```

Result:

```text
3
```

---

# Why Does This Work?

Think of each functional updater as saying:

> "React, take whatever the latest state value is for this update and calculate the next value from it."

Instead of:

```jsx
setCount(count + 1);
```

which effectively says:

> "Set it to the value based on my current render's `count`."

Functional update:

```jsx
setCount(prev => prev + 1);
```

says:

> "Take the previous state supplied by React and add 1."

---

# Practical Example — Toggle

Suppose:

```jsx
const [isOpen, setIsOpen] = useState(false);
```

You want to toggle it.

### Recommended

```jsx
setIsOpen(prev => !prev);
```

Why?

Because the new value depends on the previous value:

```text
false → true
true → false
```

Complete example:

```jsx
function Menu() {
  const [isOpen, setIsOpen] = useState(false);

  function toggleMenu() {
    setIsOpen(prev => !prev);
  }

  return (
    <div>
      <button onClick={toggleMenu}>
        Toggle Menu
      </button>

      {isOpen && <p>Menu is open</p>}
    </div>
  );
}
```

---

# Practical Example — Array

Suppose:

```jsx
const [items, setItems] = useState([]);
```

To add an item:

```jsx
setItems(prevItems => [
  ...prevItems,
  "Apple"
]);
```

Here the new array depends on the previous array.

Flow:

```text
Previous items
      ↓
   prevItems
      ↓
[...prevItems, "Apple"]
      ↓
New items
```

---

# Practical Example — Object

Suppose:

```jsx
const [user, setUser] = useState({
  name: "Yash",
  age: 21
});
```

Increase the age:

```jsx
setUser(prevUser => ({
  ...prevUser,
  age: prevUser.age + 1
}));
```

The previous object is used to construct the new object.

Result:

```js
{
  name: "Yash",
  age: 22
}
```

---

# Functional Updates and Immutability

Functional updates are often combined with immutable updates.

For an array:

```jsx
setItems(prev => [
  ...prev,
  newItem
]);
```

For an object:

```jsx
setUser(prev => ({
  ...prev,
  age: prev.age + 1
}));
```

Notice that we aren't modifying:

```jsx
prev.push(...)
```

or:

```jsx
prev.age++
```

Instead, we create a new value.

---

# Functional Update vs Normal Update

| Normal                                            | Functional                                 |
| ------------------------------------------------- | ------------------------------------------ |
| `setCount(count + 1)`                             | `setCount(prev => prev + 1)`               |
| Uses current render's value                       | Receives previous state                    |
| Fine for simple assignments                       | Best when next value depends on previous   |
| Can be problematic for multiple dependent updates | Handles queued dependent updates correctly |

---

# When Should You Use It?

Use:

```jsx
setState(prev => ...)
```

when the next state depends on the previous state.

### ✅ Increment

```jsx
setCount(prev => prev + 1);
```

### ✅ Decrement

```jsx
setCount(prev => prev - 1);
```

### ✅ Toggle

```jsx
setOpen(prev => !prev);
```

### ✅ Add item

```jsx
setItems(prev => [...prev, item]);
```

### ✅ Remove item

```jsx
setItems(prev =>
  prev.filter(item => item.id !== id)
);
```

### ✅ Update object

```jsx
setUser(prev => ({
  ...prev,
  age: prev.age + 1
}));
```

---

# When You Don't Necessarily Need It

If you're simply replacing the state with a value that doesn't depend on the previous state:

```jsx
setName("Rahul");
```

or:

```jsx
setIsLoading(true);
```

a normal update is perfectly appropriate.

You don't have to write:

```jsx
setName(() => "Rahul");
```

That adds no useful benefit.

---

# Common Mistakes

## ❌ Mistake 1 — Using stale state for dependent updates

```jsx
setCount(count + 1);
setCount(count + 1);
```

If you intend two increments, prefer:

```jsx
setCount(prev => prev + 1);
setCount(prev => prev + 1);
```

---

## ❌ Mistake 2 — Forgetting to return the new state

Wrong:

```jsx
setCount(prev => {
  prev + 1;
});
```

The block-bodied arrow function doesn't implicitly return the expression.

Correct:

```jsx
setCount(prev => {
  return prev + 1;
});
```

Or:

```jsx
setCount(prev => prev + 1);
```

---

## ❌ Mistake 3 — Mutating previous state

Wrong:

```jsx
setUser(prev => {
  prev.age++;
  return prev;
});
```

This mutates the existing object.

Better:

```jsx
setUser(prev => ({
  ...prev,
  age: prev.age + 1
}));
```

---

# Important Mental Model

Think of:

```jsx
setCount(prev => prev + 1);
```

as a **recipe for the next state**.

```text
Previous State
      ↓
     prev
      ↓
  calculation
      ↓
  New State
```

Whereas:

```jsx
setCount(count + 1);
```

uses the `count` snapshot from the current render.

---

# Interview Questions

### 1. What is a functional state update?

> A functional state update passes a function to the state setter. React calls that function with the previous state, allowing the next state to be calculated from it.

Example:

```jsx
setCount(prev => prev + 1);
```

---

### 2. When should you use functional updates?

When the new state depends on the previous state.

---

### 3. Why is this better for multiple updates?

Because each updater receives the appropriate previous state rather than repeatedly calculating from the same render's state snapshot.

---

### 4. Is functional update required every time?

No.

This is perfectly fine:

```jsx
setName("Yash");
```

Functional updates are useful when the new value depends on the previous value.

---

### 5. How would you toggle a boolean state?

```jsx
setIsOpen(prev => !prev);
```

---

### 6. How would you add an item to an array state?

```jsx
setItems(prev => [
  ...prev,
  newItem
]);
```

---

### 7. How would you update an object based on its previous value?

```jsx
setUser(prev => ({
  ...prev,
  age: prev.age + 1
}));
```

---

# ⭐ Remember

The golden rule:

```text
If NEW STATE depends on OLD STATE
              ↓
Use functional update
              ↓
setState(prev => ...)
```

### Examples

```jsx
setCount(prev => prev + 1);
```

```jsx
setOpen(prev => !prev);
```

```jsx
setItems(prev => [...prev, item]);
```

```jsx
setUser(prev => ({
  ...prev,
  age: prev.age + 1
}));
```

### One-line interview answer

> **Use a functional state update when the next state depends on the previous state, because React provides the updater function with the appropriate previous state value.**
