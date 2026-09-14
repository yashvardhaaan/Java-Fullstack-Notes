# 10 — Custom Hooks in React

## WHY?

As React applications grow, you often write the **same Hook-based logic** in multiple components.

For example, multiple components may need to know:

* Is the user online?
* What is the current window size?
* What is the debounced value?
* How should local storage be synchronized?
* How should a particular piece of data be fetched?

Instead of duplicating the same `useState`, `useEffect`, etc., we can extract that logic into a **Custom Hook**.

### Without Custom Hook ❌

```jsx
function Profile() {
  const [isOnline, setIsOnline] = useState(navigator.onLine);

  useEffect(() => {
    const online = () => setIsOnline(true);
    const offline = () => setIsOnline(false);

    window.addEventListener("online", online);
    window.addEventListener("offline", offline);

    return () => {
      window.removeEventListener("online", online);
      window.removeEventListener("offline", offline);
    };
  }, []);

  return <p>{isOnline ? "Online" : "Offline"}</p>;
}
```

Another component might need exactly the same logic.

This creates **duplicate code**.

### With Custom Hook ✅

```jsx
function useOnlineStatus() {
  // reusable logic
}
```

Now multiple components can use it.

---

# WHAT?

A **Custom Hook** is a JavaScript function that:

1. Starts with the word `use`
2. Can call other React Hooks
3. Encapsulates reusable Hook-based logic
4. Can return values/functions to the component

Example:

```jsx
function useOnlineStatus() {
  const [isOnline, setIsOnline] = useState(navigator.onLine);

  // Hook logic...

  return isOnline;
}
```

Then:

```jsx
function Profile() {
  const isOnline = useOnlineStatus();

  return <p>{isOnline ? "Online" : "Offline"}</p>;
}
```

---

# ⭐ Most Important Concept

### Custom Hooks share **logic**, not **state**.

Suppose:

```jsx
function ComponentA() {
  const online = useOnlineStatus();
}

function ComponentB() {
  const online = useOnlineStatus();
}
```

These are **two separate Hook calls**.

Each component gets its own state/effect lifecycle.

A Custom Hook does **not** automatically create shared state.

If you need genuinely shared state, you can use:

```text
Props
   ↓
Lift State Up
   ↓
Context
   ↓
State Management Library
```

depending on the problem.

---

# WHERE?

Custom Hooks are useful when the same **behavior/logic** appears in multiple components.

Common examples:

```text
useOnlineStatus()
useWindowSize()
useDebounce()
useLocalStorage()
usePrevious()
useFetch()
useAuthentication()
useForm()
```

For example:

```jsx
function SearchBox() {
  const debouncedSearch = useDebounce(search, 500);
}
```

and:

```jsx
function ProductSearch() {
  const debouncedSearch = useDebounce(search, 500);
}
```

Both can reuse the same logic.

---

# HOW?

## Step 1 — Find repeated logic

Suppose several components need to detect online/offline status.

---

## Step 2 — Extract the logic

Create:

```jsx
function useOnlineStatus() {
  const [isOnline, setIsOnline] = useState(navigator.onLine);

  useEffect(() => {
    function handleOnline() {
      setIsOnline(true);
    }

    function handleOffline() {
      setIsOnline(false);
    }

    window.addEventListener("online", handleOnline);
    window.addEventListener("offline", handleOffline);

    return () => {
      window.removeEventListener("online", handleOnline);
      window.removeEventListener("offline", handleOffline);
    };
  }, []);

  return isOnline;
}
```

---

## Step 3 — Use it inside components

```jsx
function Profile() {
  const isOnline = useOnlineStatus();

  return (
    <div>
      <h2>Profile</h2>

      <p>
        Status: {isOnline ? "Online" : "Offline"}
      </p>
    </div>
  );
}
```

Another component:

```jsx
function SaveButton() {
  const isOnline = useOnlineStatus();

  return (
    <button disabled={!isOnline}>
      Save
    </button>
  );
}
```

Now both components reuse the same logic.

---

# Custom Hook Structure

A common pattern is:

```jsx
function useSomething() {
  // state

  // effects

  // other hooks

  // logic

  return something;
}
```

Example:

```jsx
function useCounter(initialValue = 0) {
  const [count, setCount] = useState(initialValue);

  const increment = () => {
    setCount(c => c + 1);
  };

  const decrement = () => {
    setCount(c => c - 1);
  };

  return {
    count,
    increment,
    decrement
  };
}
```

Component:

```jsx
function Counter() {
  const {
    count,
    increment,
    decrement
  } = useCounter(10);

  return (
    <>
      <p>{count}</p>

      <button onClick={increment}>
        +
      </button>

      <button onClick={decrement}>
        -
      </button>
    </>
  );
}
```

---

# Custom Hook with `useEffect`

A very common interview/practical example is `useDebounce`.

```jsx
function useDebounce(value, delay) {
  const [debouncedValue, setDebouncedValue] = useState(value);

  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedValue(value);
    }, delay);

    return () => {
      clearTimeout(timer);
    };
  }, [value, delay]);

  return debouncedValue;
}
```

Usage:

```jsx
function Search() {
  const [search, setSearch] = useState("");

  const debouncedSearch = useDebounce(search, 500);

  return (
    <input
      value={search}
      onChange={(e) => setSearch(e.target.value)}
    />
  );
}
```

Here:

```text
User types
    ↓
search changes
    ↓
useDebounce()
    ↓
wait 500ms
    ↓
debouncedSearch updates
```

This is especially useful for search APIs.

---

# Custom Hook vs Utility Function

This is an important interview question.

### Utility function

```jsx
function formatDate(date) {
  return date.toLocaleDateString();
}
```

It doesn't use React Hooks.

So it is just a normal JavaScript function.

### Custom Hook

```jsx
function useWindowSize() {
  const [width, setWidth] = useState(window.innerWidth);

  // Hook logic

  return width;
}
```

It uses React Hooks, so it is a Custom Hook.

| Utility Function         | Custom Hook                    |
| ------------------------ | ------------------------------ |
| Normal JS function       | React Hook-based function      |
| Doesn't use Hooks        | Can use Hooks                  |
| Usually pure calculation | Can manage Hook-based behavior |
| `formatDate()`           | `useWindowSize()`              |

---

# WHEN?

Create a Custom Hook when:

### 1. Logic is repeated

```text
Component A → same Hook logic
Component B → same Hook logic
Component C → same Hook logic
```

Extract it.

---

### 2. Component logic is becoming too complicated

Instead of:

```jsx
function Dashboard() {
  // 200 lines of Hook logic
}
```

you might extract:

```jsx
const user = useUser();
const online = useOnlineStatus();
const size = useWindowSize();
```

This makes the component easier to understand.

---

### 3. You want a reusable abstraction

For example:

```jsx
const { data, loading, error } = useProducts();
```

The component doesn't need to know every implementation detail.

---

# ⚠️ Important Rules

Custom Hooks **must follow the Rules of Hooks**.

### ❌ Don't do this

```jsx
function useData(condition) {
  if (condition) {
    useEffect(() => {
      // ...
    }, []);
  }
}
```

Hooks should not be called conditionally.

### ✅ Do this

```jsx
function useData(condition) {
  useEffect(() => {
    if (condition) {
      // ...
    }
  }, [condition]);
}
```

---

# Common Mistakes

## ❌ Mistake 1 — Thinking Custom Hooks share state

```jsx
const a = useCounter();
const b = useCounter();
```

`a` and `b` don't automatically share the same counter state.

---

## ❌ Mistake 2 — Not starting with `use`

```jsx
function onlineStatus() {
  // ...
}
```

Use:

```jsx
function useOnlineStatus() {
  // ...
}
```

The `use` naming convention allows React tooling/linting to recognize it as a Hook.

---

## ❌ Mistake 3 — Putting unrelated logic into one Hook

Avoid creating:

```jsx
useEverything()
```

that handles:

```text
authentication
cart
window size
notifications
search
theme
API calls
```

Prefer focused Hooks:

```jsx
useAuth()
useCart()
useWindowSize()
useNotifications()
```

---

# Practical Project Structure

A project may organize custom Hooks like:

```text
src/
│
├── components/
│   ├── Navbar.jsx
│   └── Search.jsx
│
├── hooks/
│   ├── useOnlineStatus.js
│   ├── useDebounce.js
│   └── useWindowSize.js
│
└── App.jsx
```

Example:

```jsx
import { useDebounce } from "./hooks/useDebounce";
```

---

# 🎯 Interview Questions

### Q1. What is a Custom Hook?

**Answer:**

A Custom Hook is a reusable JavaScript function whose name starts with `use` and that can use React Hooks to encapsulate reusable stateful logic.

---

### Q2. Why do we use Custom Hooks?

**Answer:**

To reuse Hook-based logic across multiple components and avoid code duplication.

---

### Q3. Do Custom Hooks share state?

**Answer:**

No. Each call to a Custom Hook gets its own state and lifecycle. Custom Hooks share logic, not state.

---

### Q4. Can a Custom Hook call another Hook?

**Answer:**

Yes.

```jsx
function useUser() {
  const [user, setUser] = useState(null);

  useEffect(() => {
    // ...
  }, []);

  return user;
}
```

A Custom Hook can use built-in Hooks and other Custom Hooks.

---

### Q5. Can a Custom Hook be called conditionally?

**Answer:**

No. Custom Hooks follow the Rules of Hooks.

❌

```jsx
if (loggedIn) {
  useUser();
}
```

✅

```jsx
const user = useUser();

if (loggedIn) {
  // use user
}
```

---

### Q6. Custom Hook vs Context?

They solve different problems.

**Custom Hook:**

```text
Reusable logic
```

**Context:**

```text
Share a value through a component tree
```

They can also be used together:

```jsx
function useAuth() {
  return useContext(AuthContext);
}
```

Here the Custom Hook provides a convenient API for consuming Context.

---

# ⭐ Remember

```text
Custom Hook
     ↓
Reusable Hook-based logic
     ↓
Function starts with "use"
     ↓
Can use other Hooks
     ↓
Each call has independent state
     ↓
Does NOT automatically share state
```

### One-line interview answer:

> **A Custom Hook is a reusable function starting with `use` that encapsulates Hook-based logic, while each call maintains its own state and lifecycle unless it accesses shared state such as Context.**
