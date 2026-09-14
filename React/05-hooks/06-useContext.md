# 06 — `useContext` Hook in React

## WHY?

In React, data is normally passed from parent to child using **props**.

For example:

```text id="4c5k4m"
App
 ↓ user
Layout
 ↓ user
Dashboard
 ↓ user
Profile
```

If `Profile` needs `user`, every component in between may have to pass it.

This is **prop drilling**.

`useContext` provides another way to make a value available to components deeper in the tree without explicitly passing that prop through every intermediate component.

---

# WHAT?

### Definition

> **`useContext` is a React Hook that lets a component read and subscribe to a value from a React Context.**

The basic pattern is:

```text id="2q9u0s"
createContext()
      ↓
Context Provider
      ↓
useContext()
      ↓
Component receives value
```

Example:

```jsx id="y9t7wo"
const ThemeContext = createContext("light");
```

Then a component can read it:

```jsx id="1i3q4v"
const theme = useContext(ThemeContext);
```

---

# WHERE?

`useContext` is useful when **multiple components in a subtree need the same information**.

Common examples:

* Theme
* Current user
* Authentication information
* Language/locale
* Some shared settings
* Application-level configuration

For example:

```text id="z7dy4j"
              App
               |
        Theme Provider
               |
       ┌───────┴───────┐
       ↓               ↓
    Header           Sidebar
       ↓
     Button
```

All of these components can read the theme without receiving:

```jsx id="q8r7zt"
theme={theme}
```

through every layer.

---

# HOW?

## Step 1 — Create a Context

```jsx id="7lqg2j"
import { createContext } from "react";

const ThemeContext = createContext("light");
```

The argument:

```jsx id="s9s7id"
"light"
```

is the default value used when there is no matching provider above the component.

---

# Step 2 — Provide the Value

A provider makes a value available to descendants.

Common syntax:

```jsx id="w2b8a6"
<ThemeContext.Provider value="dark">
  <App />
</ThemeContext.Provider>
```

Example:

```jsx id="a2r4cy"
function Root() {
  return (
    <ThemeContext.Provider value="dark">
      <App />
    </ThemeContext.Provider>
  );
}
```

In newer React versions, you may also see the context object used directly as the provider:

```jsx id="m0odr2"
<ThemeContext value="dark">
  <App />
</ThemeContext>
```

---

# Step 3 — Read the Context

Inside a descendant:

```jsx id="o5d1my"
import { useContext } from "react";

function Button() {
  const theme = useContext(ThemeContext);

  return (
    <button className={theme}>
      Click
    </button>
  );
}
```

The `Button` doesn't need:

```jsx id="8p3zj6"
<Button theme={theme} />
```

The value comes from Context.

---

# Complete Example

```jsx id="zq0d2d"
import {
  createContext,
  useContext
} from "react";

const ThemeContext = createContext("light");

function App() {
  return (
    <ThemeContext.Provider value="dark">
      <Dashboard />
    </ThemeContext.Provider>
  );
}

function Dashboard() {
  return <Profile />;
}

function Profile() {
  const theme = useContext(ThemeContext);

  return (
    <div>
      Current theme: {theme}
    </div>
  );
}
```

Notice:

```text id="f3d6k1"
App
 ↓
Dashboard
 ↓
Profile
```

`Dashboard` doesn't receive or pass:

```text id="y0y5b6"
theme
```

But `Profile` can directly read it.

---

# `useContext` vs Props

## Props

```jsx id="zj6q1q"
function App() {
  return <Profile theme="dark" />;
}

function Profile({ theme }) {
  return <p>{theme}</p>;
}
```

Flow:

```text id="1g3e0t"
App
 ↓ props
Profile
```

---

## Context

```jsx id="b9n0ue"
const theme = useContext(ThemeContext);
```

Flow:

```text id="m6qk8r"
Provider
   ↓
Context
   ↓
Profile
```

No explicit prop passing is required.

---

# Practical Example — User Context

Suppose many components need the current user.

### Create Context

```jsx id="2v7v3j"
const UserContext = createContext(null);
```

### Provide User

```jsx id="pph0pz"
function App() {
  const user = {
    name: "Yash",
    role: "Developer"
  };

  return (
    <UserContext.Provider value={user}>
      <Dashboard />
    </UserContext.Provider>
  );
}
```

### Consume User

```jsx id="1ykr9c"
function Profile() {
  const user = useContext(UserContext);

  return (
    <div>
      <h1>{user.name}</h1>
      <p>{user.role}</p>
    </div>
  );
}
```

---

# Context Can Contain State

Context itself isn't a state-management system.

But you can put state into the context value.

Example:

```jsx id="ldj0ot"
function App() {
  const [theme, setTheme] = useState("light");

  return (
    <ThemeContext.Provider
      value={{ theme, setTheme }}
    >
      <Dashboard />
    </ThemeContext.Provider>
  );
}
```

Now a descendant can access both:

```jsx id="n2qvwp"
function Button() {
  const { theme, setTheme } =
    useContext(ThemeContext);

  return (
    <button
      onClick={() =>
        setTheme(
          theme === "light"
            ? "dark"
            : "light"
        )
      }
    >
      {theme}
    </button>
  );
}
```

So the flow becomes:

```text id="nmx7c9"
useState
   ↓
Provider
   ↓
Context
   ↓
useContext
   ↓
Consumer
```

---

# Context and Re-rendering

This is an important interview topic.

Suppose:

```jsx id="72x4y6"
<ThemeContext.Provider value={theme}>
  <App />
</ThemeContext.Provider>
```

If the provider's `value` changes, components consuming that context may need to re-render.

For example:

```jsx id="4j8j0k"
const theme = useContext(ThemeContext);
```

When the context value changes, React updates consumers that read that context.

---

# Important Performance Problem

Consider:

```jsx id="u7jz1a"
<Context.Provider
  value={{
    user,
    setUser
  }}
>
```

If this object is recreated on every render, its identity changes.

For more complex cases, you may use memoization appropriately:

```jsx id="u7x8j5"
const value = useMemo(
  () => ({ user, setUser }),
  [user]
);
```

Then:

```jsx id="bj2g2e"
<UserContext.Provider value={value}>
```

Don't blindly add `useMemo`; first understand whether the context value's identity is actually causing unnecessary work.

---

# Context Does NOT Automatically Mean Global State

This is a very important distinction.

Context is a **delivery mechanism**.

It allows a value to be made available to descendants without explicitly passing props.

For example:

```text id="f0y0r4"
Context
  ↓
"dark"
```

The value could be:

* A string
* Object
* Function
* State
* Reducer state
* Configuration

So:

```text id="0f2s9d"
Context ≠ automatically global state
```

---

# Multiple Contexts

You can have multiple contexts.

```jsx id="4x0grn"
<ThemeContext.Provider value={theme}>
  <UserContext.Provider value={user}>
    <LanguageContext.Provider value="en">
      <App />
    </LanguageContext.Provider>
  </UserContext.Provider>
</ThemeContext.Provider>
```

A component can consume multiple contexts:

```jsx id="h5a4o2"
function Profile() {
  const theme = useContext(ThemeContext);
  const user = useContext(UserContext);
  const language = useContext(LanguageContext);

  return (
    <div>
      {user.name}
      {theme}
      {language}
    </div>
  );
}
```

---

# Custom Hook + Context

A common professional pattern is to hide the Context implementation behind a Custom Hook.

Instead of repeatedly writing:

```jsx id="l7a2kf"
useContext(UserContext);
```

create:

```jsx id="j0z9vl"
function useUser() {
  return useContext(UserContext);
}
```

Then:

```jsx id="8k1e4z"
function Profile() {
  const user = useUser();

  return <h1>{user.name}</h1>;
}
```

This makes the API cleaner.

---

# Example — Authentication

A common application structure:

```text id="qgrh3t"
AuthContext
     ↓
AuthProvider
     ↓
Application
     ↓
 ┌──────────┬──────────┐
 ↓          ↓          ↓
Header   Dashboard   Profile
```

The provider might expose:

```jsx id="k8g7b1"
{
  user,
  login,
  logout
}
```

Then:

```jsx id="3f6c5w"
const { user, logout } = useContext(AuthContext);
```

Different components can access authentication information without prop drilling.

---

# WHEN?

Use Context when:

### 1. Many descendants need the same value

```text id="u9xw8y"
Provider
  ↓
Many components
```

### 2. Prop drilling is becoming cumbersome

```text id="d6t7f3"
App
 ↓
A
 ↓
B
 ↓
C
 ↓
D
```

### 3. The value naturally belongs to a subtree

Examples:

```text id="k4yr2z"
Theme
User
Locale
Authentication
Settings
```

---

# When NOT to Use Context

If you have:

```text id="8y2r7s"
Parent
 ↓
Child
```

just use props.

```jsx id="m8y1pk"
<Child user={user} />
```

Don't create a Context just to avoid one prop.

---

# Props vs Context vs State Management

```text id="nq0yqw"
Simple parent → child
        ↓
      Props

Multiple components need shared state
        ↓
   Lift State Up

Deep subtree needs shared value
        ↓
      Context

Complex application-wide state
        ↓
State-management solution
```

---

# Practical Example — Theme Switcher

```jsx id="l5o2hv"
import {
  createContext,
  useContext,
  useState
} from "react";

const ThemeContext = createContext(null);

function App() {
  const [theme, setTheme] = useState("light");

  function toggleTheme() {
    setTheme(prev =>
      prev === "light"
        ? "dark"
        : "light"
    );
  }

  return (
    <ThemeContext.Provider
      value={{ theme, toggleTheme }}
    >
      <Dashboard />
    </ThemeContext.Provider>
  );
}

function Dashboard() {
  return <ThemeButton />;
}

function ThemeButton() {
  const { theme, toggleTheme } =
    useContext(ThemeContext);

  return (
    <button onClick={toggleTheme}>
      Current theme: {theme}
    </button>
  );
}
```

Here:

```text id="s0r1l7"
App
 ↓
ThemeContext
 ↓
Dashboard
 ↓
ThemeButton
```

`Dashboard` doesn't need to receive or pass `theme`.

---

# Common Mistakes

### ❌ Mistake 1 — Forgetting the Provider

```jsx id="s1prpz"
const theme = useContext(ThemeContext);
```

If there is no matching provider above it, the consumer gets the context's default value.

---

### ❌ Mistake 2 — Putting everything in Context

Don't turn Context into:

```text id="6ftq8s"
"Let's put the entire application here."
```

That can make state ownership and performance harder to reason about.

---

### ❌ Mistake 3 — Thinking Context replaces all state management

Context solves **value distribution**.

It doesn't automatically provide all the features of a dedicated state-management solution.

---

### ❌ Mistake 4 — Creating unnecessary Context

For:

```jsx id="x5g3jm"
<Profile user={user} />
```

props are usually simpler.

---

### ❌ Mistake 5 — Ignoring context value identity

For large or frequently updated contexts, think carefully about the shape and identity of the provided value.

---

# 🎯 Interview Questions

### 1. What is `useContext`?

> `useContext` is a React Hook that lets a component read a value from the nearest matching Context provider without explicitly passing that value through intermediate components.

---

### 2. What problem does Context solve?

Primarily **prop drilling** and making shared values available to descendants.

---

### 3. Does Context eliminate props?

No.

Props remain the normal way to pass data explicitly between components.

---

### 4. Is Context global state?

Not exactly.

> Context is a mechanism for passing values through a component subtree without manually threading props through every level.

---

### 5. What happens when a Context value changes?

Components consuming that context are updated so they can render using the new context value.

---

### 6. Can Context contain state?

Yes.

For example:

```jsx id="gq1l8h"
const [theme, setTheme] = useState("light");

<ThemeContext.Provider
  value={{ theme, setTheme }}
>
```

---

### 7. What is the difference between Context and Redux?

Context is built into React and primarily provides values through a component tree.

Redux is a dedicated state-management architecture/library with its own store, update model, middleware ecosystem, and tooling.

They solve overlapping but different problems.

---

### 8. What is the nearest Provider rule?

A component using:

```jsx id="4zq2a6"
useContext(MyContext)
```

receives the value from the **closest matching provider above it** in the rendered tree.

---

# ⭐ Remember

```text id="f4m2wl"
createContext()
      ↓
   Provider
      ↓
    value
      ↓
useContext()
      ↓
Consumer
```

### Golden Rule

> **Use props by default. Use Context when a value needs to be accessed by many descendants and passing it explicitly becomes cumbersome.**

### One-line interview answer

> **`useContext` allows a React component to consume a value from the nearest Context provider without passing that value through every intermediate component via props.**
