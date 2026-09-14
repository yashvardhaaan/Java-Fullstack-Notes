# 05 — `useRef` Hook in React

## WHY?

Normally, when React state changes:

```jsx
setCount(10);
```

React schedules a re-render.

But sometimes we need to **remember a value without causing a re-render**.

For example:

* Accessing a DOM element
* Focusing an input
* Storing a timer ID
* Keeping a previous value
* Storing mutable values between renders

For these situations, React provides `useRef`.

---

# WHAT?

### Definition

> **`useRef` is a React Hook that lets you keep a mutable value between renders without causing a re-render when that value changes.**

Basic syntax:

```jsx
const ref = useRef(initialValue);
```

It returns an object:

```jsx
{
  current: initialValue
}
```

Example:

```jsx
const countRef = useRef(0);

countRef.current = 10;
```

The value is accessed through:

```jsx
countRef.current
```

---

# WHERE?

`useRef` is commonly used for two major purposes:

### 1. Accessing DOM elements

```text
useRef
  ↓
<input>
  ↓
Focus / select / measure / manipulate
```

### 2. Storing mutable values between renders

```text
useRef
  ↓
.current
  ↓
Value persists
  ↓
No re-render
```

---

# HOW?

## Basic Example

```jsx
import { useRef } from "react";

function App() {
  const myRef = useRef(0);

  return <h1>Hello</h1>;
}
```

You can change the value:

```jsx
myRef.current = 10;
```

Unlike state:

```jsx
setValue(10);
```

changing:

```jsx
myRef.current
```

does **not** cause the component to re-render.

---

# `useRef` for DOM Elements

This is the most common beginner example.

```jsx
import { useRef } from "react";

function SearchBox() {
  const inputRef = useRef(null);

  function focusInput() {
    inputRef.current.focus();
  }

  return (
    <>
      <input ref={inputRef} />

      <button onClick={focusInput}>
        Focus Input
      </button>
    </>
  );
}
```

Flow:

```text
useRef(null)
     ↓
inputRef
     ↓
<input ref={inputRef}>
     ↓
inputRef.current
     ↓
DOM input element
     ↓
focus()
```

When React creates the DOM element, React sets:

```jsx
inputRef.current
```

to the corresponding DOM node.

---

# Practical Example — Auto Focus

```jsx
function Login() {
  const emailRef = useRef(null);

  useEffect(() => {
    emailRef.current.focus();
  }, []);

  return (
    <input
      ref={emailRef}
      placeholder="Enter email"
    />
  );
}
```

When the component is committed:

```text
Component renders
      ↓
Input exists in DOM
      ↓
Effect runs
      ↓
emailRef.current
      ↓
focus()
```

---

# `useRef` vs `useState`

This is extremely important.

| `useState`                    | `useRef`                                        |
| ----------------------------- | ----------------------------------------------- |
| Stores state                  | Stores a mutable value/reference                |
| Updating causes a re-render   | Updating `.current` does not cause a re-render  |
| Used when UI depends on value | Used when UI doesn't need to update immediately |
| Updated with setter           | Updated through `.current`                      |
| State is part of rendering    | Ref is not used to trigger rendering            |

Example:

### State

```jsx
const [count, setCount] = useState(0);

setCount(10);
```

React re-renders.

### Ref

```jsx
const countRef = useRef(0);

countRef.current = 10;
```

React does not re-render because of that change.

---

# Practical Comparison

Suppose:

```jsx
function App() {
  const [stateCount, setStateCount] = useState(0);
  const refCount = useRef(0);

  return (
    <div>
      <button onClick={() => setStateCount(c => c + 1)}>
        State: {stateCount}
      </button>

      <button onClick={() => {
        refCount.current++;
        console.log(refCount.current);
      }}>
        Increase Ref
      </button>
    </div>
  );
}
```

Clicking the first button:

```text
setStateCount()
     ↓
Re-render
     ↓
UI updates
```

Clicking the second:

```text
refCount.current++
     ↓
Value changes
     ↓
No re-render
```

The console will show the new ref value, but the UI won't automatically display it.

---

# Why Does `useRef` Persist Between Renders?

Consider:

```jsx
const value = 10;
```

A normal variable belongs to a particular render.

When React renders the component again, the function runs again.

But:

```jsx
const valueRef = useRef(10);
```

React maintains that ref object for the component instance.

Conceptually:

```text
Render 1
   ↓
ref.current = 10

Render 2
   ↓
same ref object
   ↓
ref.current = 10

Render 3
   ↓
same ref object
```

That's why refs are useful for values that need to survive renders.

---

# Practical Example — Timer ID

Suppose you create an interval:

```jsx
function Timer() {
  const intervalRef = useRef(null);

  function startTimer() {
    intervalRef.current = setInterval(() => {
      console.log("Running...");
    }, 1000);
  }

  function stopTimer() {
    clearInterval(intervalRef.current);
  }

  return (
    <>
      <button onClick={startTimer}>
        Start
      </button>

      <button onClick={stopTimer}>
        Stop
      </button>
    </>
  );
}
```

The timer ID needs to be remembered between renders, but changing it doesn't need to update the UI.

So `useRef` is appropriate.

---

# Practical Example — Previous Value

Refs can also be used to keep a value from a previous render.

```jsx
function Counter({ count }) {
  const previousCount = useRef(count);

  useEffect(() => {
    previousCount.current = count;
  }, [count]);

  return (
    <div>
      <p>Current: {count}</p>
      <p>Previous: {previousCount.current}</p>
    </div>
  );
}
```

Conceptually:

```text
Render
  ↓
Read previous value
  ↓
Effect runs
  ↓
Store current value for next render
```

---

# `useRef` Does NOT Mean "DOM Only"

A common misconception is:

> "`useRef` is only for accessing DOM elements."

No.

It can store **any mutable value**.

Example:

```jsx
const requestIdRef = useRef(null);
```

or:

```jsx
const timerRef = useRef(null);
```

or:

```jsx
const previousValueRef = useRef(null);
```

---

# Ref Callback

You may also see refs passed through callback functions.

```jsx
<input
  ref={(node) => {
    console.log(node);
  }}
/>
```

React calls the callback with the DOM node when it is available.

For most straightforward cases, `useRef` is easier:

```jsx
const inputRef = useRef(null);

<input ref={inputRef} />;
```

---

# Important: Don't Read/Write Refs During Rendering Unnecessarily

Avoid using refs as a substitute for state.

### ❌

```jsx
function Counter() {
  const countRef = useRef(0);

  countRef.current++;

  return <h1>{countRef.current}</h1>;
}
```

This is problematic because rendering should remain predictable, and mutating refs during render can lead to confusing behavior.

Prefer state when the value drives the UI:

```jsx
const [count, setCount] = useState(0);
```

---

# Ref Does Not Automatically Update the UI

Consider:

```jsx
function App() {
  const countRef = useRef(0);

  return (
    <>
      <p>{countRef.current}</p>

      <button onClick={() => {
        countRef.current++;
      }}>
        Increase
      </button>
    </>
  );
}
```

You might expect the paragraph to become:

```text
1
2
3
```

But it won't automatically update.

Why?

```text
ref.current changes
       ↓
No state update
       ↓
No re-render
       ↓
UI doesn't update
```

If the UI needs to react to the change, use state.

---

# `useRef` vs `useState` — Interview Trick

### Question:

> "I need to store a value between renders. Should I use `useState` or `useRef`?"

Ask:

### Does changing the value need to update the UI?

**YES → `useState`**

```jsx
const [count, setCount] = useState(0);
```

**NO → `useRef` may be appropriate**

```jsx
const timerRef = useRef(null);
```

---

# Practical Example — Click Count Without Rendering

```jsx
function App() {
  const clickCount = useRef(0);

  function handleClick() {
    clickCount.current++;

    console.log(
      "Clicked:",
      clickCount.current
    );
  }

  return (
    <button onClick={handleClick}>
      Click
    </button>
  );
}
```

The count persists:

```text
Click → 1
Click → 2
Click → 3
```

But React doesn't re-render because of the ref.

---

# WHEN?

Use `useRef` when you need:

### DOM access

```jsx
inputRef.current.focus();
```

### Timer IDs

```jsx
timerRef.current = setTimeout(...);
```

### Previous values

```jsx
previousRef.current = value;
```

### Mutable values that shouldn't trigger rendering

```jsx
someRef.current = value;
```

### Third-party library instances

```jsx
libraryRef.current = new SomeLibrary(...);
```

---

# When NOT to Use `useRef`

Don't use it when the value needs to drive the UI.

### ❌

```jsx
const countRef = useRef(0);
```

for a counter displayed on screen.

### ✅

```jsx
const [count, setCount] = useState(0);
```

Use state for rendered data.

---

# Common Mistakes

### ❌ Mistake 1 — Expecting ref changes to re-render

```jsx
ref.current++;
```

doesn't trigger rendering.

---

### ❌ Mistake 2 — Using refs for UI state

If the screen needs to update, use state.

---

### ❌ Mistake 3 — Direct DOM manipulation unnecessarily

React should normally manage the DOM.

Use refs when you have a genuine need such as:

```text
Focus
Scroll
Measure
Play/pause media
Integrate with non-React libraries
```

---

### ❌ Mistake 4 — Accessing `.current` before the DOM exists

```jsx
const inputRef = useRef(null);

console.log(inputRef.current);
```

During the initial render, it can be:

```text
null
```

After React attaches the ref to the DOM node, it becomes available.

---

# 🎯 Interview Questions

### 1. What is `useRef`?

> `useRef` is a React Hook that provides a persistent mutable object whose `.current` value can change without causing a re-render.

---

### 2. What does `useRef()` return?

An object like:

```jsx
{
  current: initialValue
}
```

---

### 3. Does changing `ref.current` cause a re-render?

**No.**

```jsx
ref.current = 10;
```

doesn't itself trigger a re-render.

---

### 4. What are the common uses of `useRef`?

* Accessing DOM elements
* Storing timer IDs
* Keeping previous values
* Storing mutable values between renders
* Holding third-party library instances

---

### 5. Difference between `useRef` and `useState`?

> State updates trigger re-rendering, while changing a ref's `.current` value does not.

---

### 6. Can `useRef` store objects?

Yes.

```jsx
const userRef = useRef({
  name: "Yash"
});
```

Then:

```jsx
userRef.current.name = "Rahul";
```

But remember: changing the ref does not update the UI.

---

### 7. Why is `useRef(null)` commonly used?

For DOM references:

```jsx
const inputRef = useRef(null);

<input ref={inputRef} />
```

React later places the DOM element in:

```jsx
inputRef.current
```

---

# ⭐ Remember

```text
useRef(initialValue)
        ↓
   { current }
        ↓
Value persists between renders
        ↓
Changing current
        ↓
NO automatic re-render
```

### Golden Rule

```text
UI needs to update?
       ↓
    useState

Need to remember something
without re-rendering?
       ↓
    useRef
```

### One-line interview answer

> **`useRef` provides a persistent mutable `.current` value that survives re-renders without causing a re-render when it changes, and it is commonly used for DOM references and non-rendering mutable values.**
