# 12 — Hook Rules & Best Practices in React

## WHY?

Hooks are powerful, but React relies on a specific **calling order** to correctly associate Hook state with a component.

If Hooks are called incorrectly, React can no longer reliably determine which state/effect belongs to which Hook call.

Therefore, React has strict **Rules of Hooks**.

---

# WHAT?

There are **two fundamental Rules of Hooks**:

### Rule 1 — Only call Hooks at the top level

Don't call Hooks inside:

* `if`
* `else`
* `for`
* `while`
* nested functions
* callbacks
* `try/catch`
* conditional expressions that change whether the Hook is called

### Rule 2 — Only call Hooks from React functions

Hooks should be called from:

* Function components
* Custom Hooks

---

# WHERE?

## 1. Top Level of a Component

### ✅ Correct

```jsx id="3x7t3y"
function Counter() {
  const [count, setCount] = useState(0);

  const [name, setName] = useState("");

  return <div>{count}</div>;
}
```

Hooks are called directly inside the component.

---

### ❌ Incorrect

```jsx id="7y0xri"
function Counter() {
  if (someCondition) {
    const [count, setCount] = useState(0);
  }

  return <div />;
}
```

The Hook is conditional.

---

# HOW?

React expects Hooks to be called in the **same order on every render**.

Consider:

```jsx id="6f1x8c"
function Example() {
  const [name, setName] = useState("");
  const [age, setAge] = useState(20);

  // ...
}
```

React conceptually tracks:

```text id="1u1rkk"
Hook #1 → name
Hook #2 → age
```

On every render, that order must remain consistent.

---

## What goes wrong with conditional Hooks?

Suppose:

```jsx id="9uy5x7"
function Example({ showName }) {

  if (showName) {
    useState("");
  }

  useState(20);

  return <div />;
}
```

First render:

```text id="1e8bq7"
showName = true

Hook #1 → name
Hook #2 → age
```

Next render:

```text id="7u9w6j"
showName = false

Hook #1 → age
```

Now React's Hook ordering no longer matches.

That's why Hooks must remain at the top level.

---

# Rule 1 — Don't Use Hooks Inside Conditions

### ❌ Wrong

```jsx id="h1kq7v"
if (isLoggedIn) {
  useEffect(() => {
    console.log("Logged in");
  }, []);
}
```

### ✅ Correct

```jsx id="b6g9kz"
useEffect(() => {
  if (isLoggedIn) {
    console.log("Logged in");
  }
}, [isLoggedIn]);
```

The Hook itself is always called.

The condition is **inside the Hook**.

---

# Rule 2 — Don't Use Hooks Inside Loops

### ❌ Wrong

```jsx id="j8j5v1"
for (let i = 0; i < 5; i++) {
  const [value, setValue] = useState(0);
}
```

### ✅ Correct

Move the Hook into a component:

```jsx id="q5lqf0"
function Item() {
  const [value, setValue] = useState(0);

  return <div>{value}</div>;
}
```

Then render multiple components:

```jsx id="z9y4df"
function App() {
  return (
    <>
      <Item />
      <Item />
      <Item />
    </>
  );
}
```

Each component instance gets its own state.

---

# Rule 3 — Don't Use Hooks Inside Nested Functions

### ❌ Wrong

```jsx id="0y7m8e"
function Component() {

  function handleClick() {
    const [count, setCount] = useState(0);
  }

}
```

Hooks don't belong inside event handlers.

### ✅ Correct

```jsx id="l0z7cj"
function Component() {
  const [count, setCount] = useState(0);

  function handleClick() {
    setCount(c => c + 1);
  }

  return (
    <button onClick={handleClick}>
      {count}
    </button>
  );
}
```

---

# Rule 4 — Hooks Can Be Used in Custom Hooks

This is completely valid:

```jsx id="d3r1ka"
function useCounter() {
  const [count, setCount] = useState(0);

  return {
    count,
    setCount
  };
}
```

And:

```jsx id="r6h2pn"
function Counter() {
  const { count, setCount } = useCounter();

  return <div>{count}</div>;
}
```

A Custom Hook can use:

```text id="3h9pkl"
useState
useEffect
useRef
useContext
useReducer
useMemo
useCallback
other Custom Hooks
```

---

# Rule 5 — Don't Call Hooks from Normal JavaScript Functions

### ❌ Wrong

```jsx id="wq4c2x"
function calculateSomething() {
  const [value, setValue] = useState(0);

  return value;
}
```

If this is just a normal utility function, it should not use Hooks.

Instead:

```jsx id="l3p5y8"
function calculateSomething(value) {
  return value * 2;
}
```

Or, if the function genuinely encapsulates Hook logic:

```jsx id="8t0kpm"
function useSomething() {
  const [value, setValue] = useState(0);

  return value;
}
```

---

# Naming Convention

Custom Hooks should start with:

```text id="6atq1j"
use
```

Examples:

```jsx id="r6d4aj"
useAuth()
useFetch()
useDebounce()
useOnlineStatus()
useWindowSize()
```

Not:

```jsx id="b4o4gd"
getUser()
fetchData()
onlineStatus()
```

The `use` prefix tells React tooling and developers:

> "This function follows the Rules of Hooks."

---

# Practical Example

Consider authentication.

### ❌ Bad

```jsx id="qv8y0e"
function Login() {

  if (isLoggedIn) {
    const user = useUser();
  }

  return <div />;
}
```

### ✅ Good

```jsx id="r0p3a8"
function Login() {
  const user = useUser();

  if (user) {
    return <Dashboard />;
  }

  return <LoginForm />;
}
```

The Hook is always called in the same order.

The **rendering decision** can still be conditional.

---

# Hooks and Early Returns

This is another common interview topic.

### ❌ Potentially problematic

```jsx id="8j7l1a"
function Profile({ user }) {

  if (!user) {
    return <p>Loading...</p>;
  }

  const [name, setName] = useState(user.name);

  return <div>{name}</div>;
}
```

The Hook is skipped on some renders.

### ✅ Correct

```jsx id="x8c6t5"
function Profile({ user }) {
  const [name, setName] = useState("");

  if (!user) {
    return <p>Loading...</p>;
  }

  return <div>{name}</div>;
}
```

Hooks come before the conditional return.

---

# How to Remember the Rules

Use this simple formula:

```text id="b9x5e2"
HOOK
 ↓
TOP LEVEL
 ↓
FUNCTION COMPONENT
        OR
CUSTOM HOOK
```

Never:

```text id="f7y1kd"
if
for
while
callback
event handler
nested function
```

---

# Common Mistakes

### ❌ Conditional Hook

```jsx
if (condition) {
  useState();
}
```

### ❌ Hook inside loop

```jsx
items.forEach(() => {
  useState();
});
```

### ❌ Hook inside event

```jsx
function handleClick() {
  useState();
}
```

### ❌ Hook inside normal function

```jsx
function helper() {
  useEffect();
}
```

### ❌ Hook after an early return

```jsx
if (!user) return null;

useState();
```

---

# 🎯 Interview Questions

### Q1. What are the Rules of Hooks?

**Answer:**

Hooks must be called at the top level of React function components or Custom Hooks. They should not be called inside conditions, loops, nested functions, or event handlers.

---

### Q2. Why can't Hooks be called conditionally?

**Answer:**

React relies on the consistent order of Hook calls between renders to correctly associate Hook state and other Hook data with their respective calls.

---

### Q3. Can a Custom Hook call another Hook?

**Answer:**

Yes. Custom Hooks can call built-in Hooks and other Custom Hooks, provided they follow the Rules of Hooks.

---

### Q4. Can we use `useState()` inside an event handler?

**Answer:**

No.

❌

```jsx id="f2p5q8"
function handleClick() {
  useState();
}
```

Instead, declare the state at the component's top level and update it inside the handler.

---

### Q5. Why do Custom Hooks start with `use`?

**Answer:**

The `use` prefix identifies a function as a Hook so React's linting/tooling can enforce the Rules of Hooks and developers can recognize that the function may call Hooks.

---

### Q6. What happens if Hook order changes?

**Answer:**

React can associate Hook state with the wrong Hook call, leading to incorrect behavior. This is why Hook calls must remain in a consistent order.

---

# ⭐ Remember

```text id="r7b8u0"
              RULES OF HOOKS
                    │
          ┌─────────┴─────────┐
          ↓                   ↓
     TOP LEVEL          REACT FUNCTIONS
          │                   │
     No if/for/etc.     Component
                        Custom Hook
```

### One-line interview answer:

> **Hooks must be called unconditionally at the top level of function components or Custom Hooks so React can preserve the same Hook call order across renders.**
