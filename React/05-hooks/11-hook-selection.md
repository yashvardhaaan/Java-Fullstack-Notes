# 11 — Hook Selection in React

## WHY?

React provides many Hooks, but **you should not use a Hook just because it exists**.

The important skill is knowing:

> **Which Hook should I choose for a particular problem?**

For example:

* Need changing data → `useState`
* Need side effects/external synchronization → `useEffect`
* Need a DOM reference → `useRef`
* Need shared context value → `useContext`
* Need complex state transitions → `useReducer`
* Need expensive calculation optimization → `useMemo`
* Need stable function reference → `useCallback`
* Need reusable Hook logic → Custom Hook
* Need unique DOM ID → `useId`

---

# WHAT?

**Hook selection** means choosing the appropriate React Hook based on the problem you are trying to solve.

A simple decision tree:

```text
What do I need?
       │
       ├── Store changing data?
       │       ↓
       │    useState
       │
       ├── Complex state transitions?
       │       ↓
       │    useReducer
       │
       ├── Synchronize with external system?
       │       ↓
       │    useEffect
       │
       ├── Store DOM reference / mutable value?
       │       ↓
       │    useRef
       │
       ├── Read shared Context value?
       │       ↓
       │    useContext
       │
       ├── Cache expensive calculation?
       │       ↓
       │    useMemo
       │
       ├── Cache function reference?
       │       ↓
       │    useCallback
       │
       ├── Need reusable Hook logic?
       │       ↓
       │    Custom Hook
       │
       └── Need unique DOM ID?
               ↓
             useId
```

---

# WHERE?

## 1. `useState`

Use when a component needs to **remember changing data** and that data affects the UI.

```jsx
const [count, setCount] = useState(0);
```

Example:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  return (
    <button onClick={() => setCount(count + 1)}>
      {count}
    </button>
  );
}
```

### Choose `useState` when:

```text
Input value
Counter
Modal open/close
Selected item
Loading state
Form values
```

---

# 2. `useEffect`

Use when React needs to **synchronize with something outside React**.

Examples:

```text
API/network connection
Browser event listener
Timer
Subscription
Third-party library
DOM/external system
```

Example:

```jsx
useEffect(() => {
  const handleOnline = () => {
    console.log("Online");
  };

  window.addEventListener("online", handleOnline);

  return () => {
    window.removeEventListener("online", handleOnline);
  };
}, []);
```

### Don't automatically choose `useEffect` for:

```text
Calculating a value
Handling a button click
Transforming data
Updating state based purely on other state
```

Those often don't require an Effect.

---

# 3. `useRef`

Use when you need a value that **persists between renders without causing a re-render when it changes**.

### DOM example

```jsx
const inputRef = useRef(null);

function focusInput() {
  inputRef.current.focus();
}
```

```jsx
<input ref={inputRef} />
```

Other examples:

```text
DOM element
Timer ID
Previous value
Third-party object
Mutable value
```

### Question to ask:

> "Should changing this value update the UI?"

If **yes** → consider `useState`.

If **no** → `useRef` may be appropriate.

---

# 4. `useContext`

Use when a component needs to read a value provided through React Context.

Example:

```jsx
const ThemeContext = createContext();

function Button() {
  const theme = useContext(ThemeContext);

  return <button className={theme}>Click</button>;
}
```

Useful for values such as:

```text
Theme
Authentication information
Locale
Application configuration
Shared state exposed through Context
```

Remember:

> Context is a mechanism for delivering values through the component tree; it is not automatically a global state-management solution.

---

# 5. `useReducer`

Use when state management involves **multiple related transitions or complex update logic**.

Instead of:

```jsx
setLoading(...)
setError(...)
setData(...)
setStatus(...)
```

you might use:

```jsx
const [state, dispatch] = useReducer(reducer, initialState);
```

Example:

```jsx
function reducer(state, action) {
  switch (action.type) {
    case "increment":
      return {
        ...state,
        count: state.count + 1
      };

    case "decrement":
      return {
        ...state,
        count: state.count - 1
      };

    default:
      return state;
  }
}
```

### Choose `useReducer` when:

```text
Many related state variables
Many possible transitions
Complex update rules
Action-based state changes
```

---

# 6. `useMemo`

Use when you need to **cache the result of an expensive calculation**.

```jsx
const filteredProducts = useMemo(() => {
  return products.filter(product =>
    product.name.includes(search)
  );
}, [products, search]);
```

Important:

`useMemo` is primarily a **performance optimization**.

Don't use it simply because a calculation exists.

---

# 7. `useCallback`

Use when you need to **cache a function reference** between renders.

```jsx
const handleClick = useCallback(() => {
  console.log("Clicked");
}, []);
```

It is particularly useful when function identity matters, for example when passing callbacks to memoized children.

```jsx
const Child = memo(function Child({ onClick }) {
  return <button onClick={onClick}>Click</button>;
});
```

### Difference:

```text
useMemo
   ↓
Caches a VALUE

useCallback
   ↓
Caches a FUNCTION
```

Conceptually:

```jsx
useCallback(fn, deps)
```

is similar to:

```jsx
useMemo(() => fn, deps)
```

---

# 8. Custom Hook

Use when you have **reusable Hook-based logic**.

Example:

```jsx
function useOnlineStatus() {
  const [online, setOnline] = useState(navigator.onLine);

  // Hook logic...

  return online;
}
```

Then:

```jsx
const online = useOnlineStatus();
```

### Choose Custom Hook when:

```text
Same Hook logic appears in multiple components
```

Remember:

> Custom Hooks share logic, not automatically the same state.

---

# 9. `useId`

Use when you need a React-generated ID for **DOM relationships and accessibility**.

```jsx
const id = useId();

return (
  <>
    <label htmlFor={id}>Email</label>
    <input id={id} />
  </>
);
```

Don't use it for:

```text
Database IDs
React list keys
Business identifiers
```

---

# HOW? — Practical Hook Selection

Imagine you are building a login form.

### Problem 1: Store email

```jsx
const [email, setEmail] = useState("");
```

**Choose:** `useState`

---

### Problem 2: Focus email input

```jsx
const emailRef = useRef(null);
```

**Choose:** `useRef`

---

### Problem 3: Connect label to input

```jsx
const emailId = useId();
```

**Choose:** `useId`

---

### Problem 4: Listen for browser events

```jsx
useEffect(() => {
  // external synchronization
}, []);
```

**Choose:** `useEffect`

---

### Problem 5: Complex form state

```jsx
const [state, dispatch] = useReducer(reducer, initialState);
```

**Choose:** `useReducer`

---

### Problem 6: Share authentication value through Context

```jsx
const auth = useContext(AuthContext);
```

**Choose:** `useContext`

---

### Problem 7: Expensive filtering

```jsx
const result = useMemo(() => {
  return expensiveFilter(products);
}, [products]);
```

**Choose:** `useMemo`

---

### Problem 8: Stable callback for memoized child

```jsx
const handleSelect = useCallback(() => {
  // ...
}, []);
```

**Choose:** `useCallback`

---

### Problem 9: Same Hook logic in many components

```jsx
const online = useOnlineStatus();
```

**Choose:** Custom Hook.

---

# ⭐ The Most Important Decision Table

| Requirement                        | Hook          |
| ---------------------------------- | ------------- |
| Store UI state                     | `useState`    |
| Complex state transitions          | `useReducer`  |
| External system synchronization    | `useEffect`   |
| DOM reference                      | `useRef`      |
| Mutable value without re-render    | `useRef`      |
| Read Context                       | `useContext`  |
| Expensive calculation optimization | `useMemo`     |
| Stable function reference          | `useCallback` |
| Reusable Hook-based logic          | Custom Hook   |
| Unique DOM/accessibility ID        | `useId`       |

---

# 🔥 Common Interview Scenarios

### Scenario 1

> I have a counter whose value appears on the screen. Which Hook?

**Answer:** `useState`

---

### Scenario 2

> I need to focus an input programmatically.

**Answer:** `useRef`

---

### Scenario 3

> I need to subscribe to a browser event and clean it up.

**Answer:** `useEffect`

---

### Scenario 4

> I have complicated state transitions.

**Answer:** `useReducer`

---

### Scenario 5

> I need the current theme from a Context.

**Answer:** `useContext`

---

### Scenario 6

> I have a very expensive calculation and want to cache its result.

**Answer:** `useMemo`

---

### Scenario 7

> A memoized child receives a callback whose identity should remain stable.

**Answer:** `useCallback`

---

### Scenario 8

> I have the same Hook logic in five components.

**Answer:** Create a **Custom Hook**.

---

### Scenario 9

> I need to associate a label with an input using a generated ID.

**Answer:** `useId`

---

# ⚠️ Biggest Mistake in Hook Selection

Don't think:

> "I need to do something after rendering, so I'll use `useEffect`."

Instead ask:

> **"Am I synchronizing React with an external system?"**

If not, you may not need an Effect.

Similarly, don't think:

> "This calculation exists, so I need `useMemo`."

Ask:

> **"Is this calculation expensive enough that caching its result is useful?"**

And don't think:

> "I need a value that survives renders, so I'll use `useRef`."

Ask:

> **"Should changing this value cause the UI to update?"**

---

# 🎯 Interview Questions

### Q1. When should you use `useState` instead of `useRef`?

**Answer:**

Use `useState` when changing the value should cause the component to re-render. Use `useRef` when the value should persist but changing it should not trigger a re-render.

---

### Q2. When should you use `useReducer` instead of `useState`?

**Answer:**

When state transitions become complex, numerous, or closely related, `useReducer` can make the update logic more structured and predictable.

---

### Q3. `useMemo` vs `useCallback`?

**Answer:**

```text
useMemo     → caches calculated value
useCallback → caches function reference
```

---

### Q4. When should you use `useEffect`?

**Answer:**

When you need to synchronize a component with an external system such as a network connection, subscription, timer, browser API, or third-party library.

---

### Q5. Which Hook should you use for sharing state?

**Answer:**

There isn't one universal Hook. Depending on the requirement, you might use:

```text
Parent-child → props
Shared subtree → Context
Complex local transitions → useReducer
Application-wide state → appropriate state-management solution
```

---

# ⭐ Remember This Shortcut

```text
STATE?
   ↓
useState

COMPLEX STATE?
   ↓
useReducer

EXTERNAL SYSTEM?
   ↓
useEffect

DOM / MUTABLE VALUE?
   ↓
useRef

CONTEXT VALUE?
   ↓
useContext

EXPENSIVE VALUE?
   ↓
useMemo

FUNCTION IDENTITY?
   ↓
useCallback

REUSABLE HOOK LOGIC?
   ↓
Custom Hook

UNIQUE DOM ID?
   ↓
useId
```

### One-line interview answer:

> **Hook selection means choosing the simplest React Hook that matches the problem: `useState` for UI state, `useEffect` for external synchronization, `useRef` for persistent non-rendering values, `useContext` for Context values, `useReducer` for complex state transitions, `useMemo`/`useCallback` for targeted performance optimizations, Custom Hooks for reusable logic, and `useId` for DOM IDs.**
