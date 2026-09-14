# 09 — Prop Drilling in React

## WHY?

In React, data is usually passed from a parent component to a child using **props**.

This works perfectly when the child is directly below the parent.

But what happens when the data needs to reach a **deeply nested component**?

You may have to pass the prop through several components that **don't actually use the data**.

This is called **Prop Drilling**.

---

# WHAT?

### Definition

> **Prop drilling is the process of passing data through multiple intermediate components via props just to reach a deeply nested component that actually needs the data.**

Example:

```text
App
 ↓ user
Layout
 ↓ user
Dashboard
 ↓ user
Profile
```

Here:

* `App` owns `user`
* `Profile` needs `user`
* `Layout` doesn't need `user`
* `Dashboard` doesn't need `user`

But they still have to pass it.

---

# Simple Example

```jsx
function App() {
  const user = {
    name: "Yash",
    age: 21
  };

  return <Layout user={user} />;
}

function Layout({ user }) {
  return <Dashboard user={user} />;
}

function Dashboard({ user }) {
  return <Profile user={user} />;
}

function Profile({ user }) {
  return <h1>Hello {user.name}</h1>;
}
```

Notice the flow:

```text
App
 |
 | user
 ↓
Layout
 |
 | user
 ↓
Dashboard
 |
 | user
 ↓
Profile
```

Only `Profile` actually uses `user`.

---

# WHERE?

Prop drilling commonly happens in:

* Large component trees
* Dashboards
* Forms
* Authentication/user information
* Shopping carts
* Theme settings
* Application settings
* Callback functions

For example:

```text
App
 ↓
Layout
 ↓
Sidebar
 ↓
UserSection
 ↓
UserProfile
```

If `UserProfile` needs `user`, you might end up doing:

```jsx
<App user={user}>
  <Layout user={user}>
    <Sidebar user={user}>
      <UserSection user={user}>
        <UserProfile user={user} />
      </UserSection>
    </Sidebar>
  </Layout>
</App>
```

This becomes difficult to maintain.

---

# HOW?

## Step 1 — Parent creates the data

```jsx
function App() {
  const user = {
    name: "Yash"
  };

  return <Layout user={user} />;
}
```

---

## Step 2 — Intermediate component receives it

```jsx
function Layout({ user }) {
  return <Dashboard user={user} />;
}
```

But `Layout` doesn't actually need `user`.

---

## Step 3 — Another intermediate component passes it

```jsx
function Dashboard({ user }) {
  return <Profile user={user} />;
}
```

Again, `Dashboard` doesn't need it.

---

## Step 4 — Deep child finally uses it

```jsx
function Profile({ user }) {
  return <h1>{user.name}</h1>;
}
```

That's prop drilling.

---

# Callback Prop Drilling

Prop drilling isn't limited to data.

You can also drill **functions**.

```jsx
function App() {
  function handleUpdate() {
    console.log("Updated!");
  }

  return <Layout onUpdate={handleUpdate} />;
}
```

Then:

```jsx
function Layout({ onUpdate }) {
  return <Dashboard onUpdate={onUpdate} />;
}
```

Then:

```jsx
function Dashboard({ onUpdate }) {
  return <Form onUpdate={onUpdate} />;
}
```

Finally:

```jsx
function Form({ onUpdate }) {
  return <button onClick={onUpdate}>Update</button>;
}
```

Flow:

```text
handleUpdate
     ↓
   App
     ↓
  Layout
     ↓
 Dashboard
     ↓
   Form
```

---

# WHY CAN PROP DRILLING BE A PROBLEM?

## 1. Intermediate components become coupled

`Layout` doesn't need `user`, but now it must know about it.

```jsx
function Layout({ user }) {
  return <Dashboard user={user} />;
}
```

---

## 2. Components become harder to refactor

If you change:

```jsx
user
```

to:

```jsx
currentUser
```

you may need to modify several components.

---

## 3. Props become noisy

You can end up with:

```jsx
<Layout
  user={user}
  theme={theme}
  language={language}
  settings={settings}
/>
```

even though `Layout` doesn't use any of them.

---

## 4. Maintenance becomes difficult

Imagine:

```text
App
 ↓
A
 ↓
B
 ↓
C
 ↓
D
 ↓
E
```

If `E` needs some data from `App`, every component in between may need to pass it.

---

# Is Prop Drilling Always Bad?

**No.**

This is important for interviews.

Prop drilling is not inherently wrong.

For a shallow component tree:

```text
Parent
 ↓
Child
 ↓
GrandChild
```

Passing props is completely normal.

```jsx
<Child user={user} />
```

You should not introduce Context or a state-management library just because you passed a prop through one or two components.

### The problem is when it becomes excessive.

---

# HOW TO SOLVE PROP DRILLING?

There are several approaches.

---

## Solution 1 — Component Composition

Sometimes you can restructure components using `children`.

Instead of:

```jsx
function App() {
  const user = { name: "Yash" };

  return <Layout user={user} />;
}
```

You can compose the component:

```jsx
function App() {
  const user = { name: "Yash" };

  return (
    <Layout>
      <Profile user={user} />
    </Layout>
  );
}
```

Now:

```jsx
function Layout({ children }) {
  return (
    <div>
      <header>Dashboard</header>
      {children}
    </div>
  );
}
```

`Layout` doesn't need to know about `user`.

---

# Solution 2 — Context API

If many deeply nested components need the same data, **Context** can be useful.

```jsx
import { createContext, useContext } from "react";

const UserContext = createContext(null);
```

Provide the value:

```jsx
function App() {
  const user = {
    name: "Yash"
  };

  return (
    <UserContext.Provider value={user}>
      <Layout />
    </UserContext.Provider>
  );
}
```

Now `Layout` doesn't need to pass `user`.

```jsx
function Layout() {
  return <Dashboard />;
}
```

```jsx
function Dashboard() {
  return <Profile />;
}
```

`Profile` can directly access the context:

```jsx
function Profile() {
  const user = useContext(UserContext);

  return <h1>Hello {user.name}</h1>;
}
```

Flow becomes:

```text
UserContext
     |
     +----------------+
     |                |
   Layout          Profile
                      |
                  useContext()
```

No prop drilling.

> In newer React versions, you may also see the provider written using the context object directly, while `<UserContext.Provider>` remains the familiar/common syntax.

---

# Solution 3 — Move State Closer

Sometimes the best solution isn't Context.

Maybe the state doesn't actually need to live in `App`.

### Before

```text
App
 ↓
Layout
 ↓
Dashboard
 ↓
Search
```

If only `Search` needs:

```jsx
const [query, setQuery] = useState("");
```

put the state inside `Search`.

```jsx
function Search() {
  const [query, setQuery] = useState("");

  return (
    <input
      value={query}
      onChange={(e) => setQuery(e.target.value)}
    />
  );
}
```

This eliminates unnecessary prop passing.

---

# Solution 4 — State Management Libraries

For large applications with complicated shared state, you may use a state-management solution such as:

```text
Redux
Zustand
Jotai
MobX
```

But don't use them simply because you have one drilled prop.

---

# Prop Drilling vs Lifting State Up

These concepts are related but **not the same**.

### Lifting State Up

You move state **up** to a common parent so multiple components can share it.

```text
      Parent
      /    \
   Child  Child
```

State:

```text
Parent
  ↓
Child
Child
```

### Prop Drilling

You pass props **through intermediate components** to reach a deeply nested component.

```text
Parent
  ↓
A
  ↓
B
  ↓
C
```

### Remember

```text
Lifting State Up = Where should shared state live?

Prop Drilling = How is that state/data being passed through the tree?
```

---

# Practical Example — Theme

Suppose:

```text
App
 ↓
Layout
 ↓
Sidebar
 ↓
Menu
 ↓
Button
```

`Button` needs the theme.

### ❌ Prop drilling

```jsx
<App theme={theme}>
  <Layout theme={theme}>
    <Sidebar theme={theme}>
      <Menu theme={theme}>
        <Button theme={theme} />
      </Menu>
    </Sidebar>
  </Layout>
</App>
```

### ✅ Context

```jsx
const ThemeContext = createContext("light");
```

```jsx
function App() {
  return (
    <ThemeContext.Provider value="dark">
      <Layout />
    </ThemeContext.Provider>
  );
}
```

Then:

```jsx
function Button() {
  const theme = useContext(ThemeContext);

  return (
    <button className={theme}>
      Click
    </button>
  );
}
```

---

# WHEN?

### Use normal props when:

```text
Parent → Child
```

or the component tree is shallow.

---

### Consider lifting state when:

```text
Sibling A
   ↕
Shared state
   ↕
Sibling B
```

---

### Consider Context when:

```text
Many descendants need the same value
```

Examples:

* Theme
* Current user
* Locale
* Authentication information
* Some shared application settings

---

### Consider a state-management library when:

```text
Large application
+
Complex shared state
+
Many updates
+
Complex state relationships
```

---

# Decision Tree

```text
Does another component need this data?
             |
            YES
             |
       Is it nearby?
        /          \
      YES           NO
       |             |
     Props       Is it deeply
                 shared?
                    |
                   YES
                    |
              Consider Context
                    |
          Is the state very complex?
              /             \
            NO              YES
             |                |
          Context       State Management
```

---

# Common Mistakes

### ❌ Mistake 1: Thinking all prop drilling is bad

Passing:

```jsx
<Child user={user} />
```

is perfectly normal.

---

### ❌ Mistake 2: Using Context for everything

Don't create:

```text
UserContext
ThemeContext
ButtonContext
InputContext
ColorContext
...
```

just to avoid a couple of props.

---

### ❌ Mistake 3: Using Redux/state libraries unnecessarily

A simple parent-child relationship doesn't require Redux.

---

### ❌ Mistake 4: Forgetting component composition

Sometimes `children` or passing elements can solve the problem without Context.

---

# 🎯 Interview Questions

### 1. What is prop drilling?

> Prop drilling is passing data through multiple intermediate components via props to reach a deeply nested component that actually needs the data.

---

### 2. Is prop drilling bad?

> Not necessarily. It is perfectly fine for shallow component trees. It becomes a problem when many intermediate components have to pass data they don't use.

---

### 3. How can you avoid prop drilling?

Common approaches include:

1. Component composition
2. Context API
3. Moving state closer to consumers
4. State-management libraries for complex shared state

---

### 4. What is the difference between props and Context?

**Props:**

```text
Parent → Child
```

Data is explicitly passed.

**Context:**

```text
Provider → Any descendant
```

Data can be consumed without passing it through every intermediate component.

---

### 5. Is Context a state-management library?

Not exactly.

Context is primarily a mechanism for **making values available to descendants without explicit prop passing**. It can be combined with `useState` or `useReducer` to share state.

---

### 6. What is the difference between prop drilling and lifting state up?

> Lifting state up means moving state to a common parent so components can share it, while prop drilling refers to passing props through intermediate components to reach a deeply nested component.

---

# ⭐ Remember

```text
Prop Drilling

Parent
  ↓ props
Component A
  ↓ props
Component B
  ↓ props
Component C
  ↓
Actual Consumer
```

### Golden Rule

> **Props are the default. Don't avoid prop drilling at all costs; solve it when the prop path becomes cumbersome.**

### One-line interview answer

> **Prop drilling is the practice of passing data through intermediate React components that don't need it, simply to deliver that data to a deeply nested component.**
