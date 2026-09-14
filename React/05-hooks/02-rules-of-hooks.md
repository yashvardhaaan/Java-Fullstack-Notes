# 02 — Rules of Hooks in React

## WHY?

Hooks give function components access to React features such as state, effects, context, and refs.

But React needs to know **which Hook belongs to which state/effect between renders**.

Therefore, Hooks must be called in a **consistent order on every render**.

That's why React has the **Rules of Hooks**.

The two most important rules are:

```text
1. Only call Hooks at the top level.
2. Only call Hooks from React functions.
```

---

# WHAT?

## Rule 1 — Only Call Hooks at the Top Level

Do **not** call Hooks inside:

* `if` statements
* `else`
* loops
* nested functions
* `switch`
* `try/catch`
* conditions

### ❌ Wrong

```jsx
function Counter({ loggedIn }) {

  if (loggedIn) {
    const [count, setCount] = useState(0);
  }

  return <h1>Hello</h1>;
}
```

The Hook is being called conditionally.

---

## Why is this a problem?

Consider:

```jsx
function App({ condition }) {
  if (condition) {
    useState("A");
  }

  useState("B");

  return <div />;
}
```

### First render

```text
condition = true

Hook 1 → A
Hook 2 → B
```

### Second render

```text
condition = false

Hook 1 → B
```

React can no longer reliably associate the Hook call with the same state slot.

That's why Hook calls must maintain the **same order**.

---

# Correct Approach

Move the condition **inside the Hook** or around the returned UI.

### ❌ Wrong

```jsx
if (isLoggedIn) {
  useEffect(() => {
    console.log("User logged in");
  }, []);
}
```

### ✅ Correct

```jsx
useEffect(() => {
  if (isLoggedIn) {
    console.log("User logged in");
  }
}, [isLoggedIn]);
```

The Hook itself is always called.

The condition is inside the Hook.

---

# Another Example

### ❌ Wrong

```jsx
function App({ show }) {
  if (show) {
    const [count, setCount] = useState(0);
  }

  return <div />;
}
```

### ✅ Correct

```jsx
function App({ show }) {
  const [count, setCount] = useState(0);

  if (!show) {
    return null;
  }

  return <h1>{count}</h1>;
}
```

The Hook is always called before the conditional return.

---

# Rule 2 — Only Call Hooks from React Functions

Hooks should be called from:

### 1. Function components

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  return <h1>{count}</h1>;
}
```

### 2. Custom Hooks

```jsx
function useCounter() {
  const [count, setCount] = useState(0);

  return [count, setCount];
}
```

---

# ❌ Don't Call Hooks from Normal Functions

```jsx
function calculateSomething() {
  const [value, setValue] = useState(0); // ❌
}
```

This is just a normal JavaScript function.

Instead, if the function is meant to encapsulate Hook logic, make it a **Custom Hook**:

```jsx
function useSomething() {
  const [value, setValue] = useState(0);

  return [value, setValue];
}
```

Then:

```jsx
function App() {
  const [value, setValue] = useSomething();

  return <h1>{value}</h1>;
}
```

---

# WHY CAN'T HOOKS BE CONDITIONAL?

React internally relies on the **order of Hook calls**.

Think of it conceptually like:

```text
Render 1:

Hook #1 → useState
Hook #2 → useEffect
Hook #3 → useState


Render 2:

Hook #1 → useState
Hook #2 → useEffect
Hook #3 → useState
```

The order remains consistent.

But if you do:

```text
Render 1:

Hook #1 → useState
Hook #2 → useEffect
Hook #3 → useState


Render 2:

Hook #1 → useState
Hook #2 → useState
```

the correspondence changes.

### Therefore:

> **Hooks must be called in the same order on every render.**

---

# HOW?

## Correct Hook Structure

A good function component generally looks like:

```jsx
function Profile({ user }) {

  // Hooks first
  const [name, setName] = useState(user.name);

  useEffect(() => {
    console.log(name);
  }, [name]);

  // Conditions after Hooks
  if (!user) {
    return <p>No user</p>;
  }

  return <h1>{name}</h1>;
}
```

---

# Conditions Should Come After Hooks

### ❌ Wrong

```jsx
function Profile({ user }) {

  if (!user) {
    return <p>No user</p>;
  }

  const [name, setName] = useState("");

  return <h1>{name}</h1>;
}
```

Depending on the component's render path, the Hook may not be called.

### ✅ Better

```jsx
function Profile({ user }) {

  const [name, setName] = useState("");

  if (!user) {
    return <p>No user</p>;
  }

  return <h1>{name}</h1>;
}
```

---

# Hooks Inside Loops

### ❌ Wrong

```jsx
function App() {

  for (let i = 0; i < 3; i++) {
    useState(i);
  }

  return <div />;
}
```

Don't dynamically change the number/order of Hook calls.

---

# Hooks Inside Nested Functions

### ❌ Wrong

```jsx
function App() {

  function handleSomething() {
    const [count, setCount] = useState(0);
  }

  return <button onClick={handleSomething}>Click</button>;
}
```

The Hook isn't being called directly from the component body.

### ✅ Correct

```jsx
function App() {

  const [count, setCount] = useState(0);

  function handleSomething() {
    setCount(count + 1);
  }

  return (
    <button onClick={handleSomething}>
      {count}
    </button>
  );
}
```

---

# Custom Hooks Also Follow the Rules

Suppose:

```jsx
function useUser() {
  const [user, setUser] = useState(null);

  useEffect(() => {
    // fetch user
  }, []);

  return user;
}
```

This is valid because `useUser` is a Custom Hook.

But this is still wrong:

```jsx
function useUser() {

  if (someCondition) {
    const [user, setUser] = useState(null); // ❌
  }

  return user;
}
```

Custom Hooks must also follow the Rules of Hooks.

---

# ESLint Helps Detect Violations

React projects commonly use the **Hooks linting rules** to catch many mistakes automatically.

For example:

```jsx
if (condition) {
  useState(0);
}
```

Your linter can warn you that a Hook is being called conditionally.

This is extremely useful because Hook-rule violations can otherwise produce confusing bugs.

---

# WHEN?

Follow the Rules of Hooks **every time you use a Hook**.

Especially when writing:

* `useState`
* `useEffect`
* `useRef`
* `useContext`
* `useReducer`
* `useMemo`
* `useCallback`
* Custom Hooks

---

# Practical Example

### ❌ Incorrect

```jsx
function Dashboard({ isAdmin }) {

  if (isAdmin) {
    const [users, setUsers] = useState([]);
  }

  useEffect(() => {
    console.log("Dashboard");
  }, []);

  return <h1>Dashboard</h1>;
}
```

Problem:

```text
useState() is conditional
```

---

### ✅ Correct

```jsx
function Dashboard({ isAdmin }) {

  const [users, setUsers] = useState([]);

  useEffect(() => {
    console.log("Dashboard");
  }, []);

  if (!isAdmin) {
    return <h1>Access Denied</h1>;
  }

  return (
    <div>
      <h1>Admin Dashboard</h1>

      {users.map(user => (
        <p key={user.id}>{user.name}</p>
      ))}
    </div>
  );
}
```

---

# Common Mistakes

### ❌ Hook inside `if`

```jsx
if (condition) {
  useState();
}
```

### ❌ Hook inside loop

```jsx
for (...) {
  useState();
}
```

### ❌ Hook inside event handler

```jsx
function handleClick() {
  useState(); // ❌
}
```

### ❌ Hook inside normal function

```jsx
function helper() {
  useEffect(); // ❌
}
```

### ❌ Hook after an early return

```jsx
if (!user) {
  return null;
}

useState(); // ❌ potentially conditional
```

### ✅ Better

```jsx
const [name, setName] = useState("");

if (!user) {
  return null;
}
```

---

# 🎯 Interview Questions

### 1. What are the Rules of Hooks?

The two fundamental rules are:

1. **Only call Hooks at the top level.**
2. **Only call Hooks from React function components or Custom Hooks.**

---

### 2. Why can't Hooks be called conditionally?

> React relies on the consistent order of Hook calls between renders to correctly associate Hook state and other Hook data with the component.

---

### 3. Can I use a Hook inside an `if` statement?

**No.**

```jsx
if (condition) {
  useState(); // ❌
}
```

Instead:

```jsx
const [state, setState] = useState();

if (condition) {
  // use state
}
```

---

### 4. Can Hooks be called inside event handlers?

No.

```jsx
function handleClick() {
  useState(); // ❌
}
```

Hooks should be called at the top level of the component.

---

### 5. Can a Custom Hook call another Hook?

**Yes.**

```jsx
function useUser() {
  const [user, setUser] = useState(null);

  useEffect(() => {
    // ...
  }, []);

  return user;
}
```

---

### 6. Why do Custom Hooks start with `use`?

The `use` naming convention makes them identifiable as Hooks and allows the Hooks linting rules to recognize and check them appropriately.

---

# ⭐ Remember

```text
RULE 1
Hooks → Top Level

❌ if
❌ loop
❌ nested function
❌ event handler

RULE 2
Hooks → React Function

✅ Function Component
✅ Custom Hook
```

### Golden Rule

> **Never change the order or number of Hook calls between renders.**

### One-line interview answer

> **The Rules of Hooks require Hooks to be called only at the top level of React function components or Custom Hooks, so React can maintain a consistent Hook call order across renders.**
