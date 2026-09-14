# 03 — Conditional Rendering

## WHY?

### Why do we need Conditional Rendering?

In a real application, the UI should change depending on the current situation.

For example:

```text
User logged in?
      ↓
   YES → Show Dashboard
   NO  → Show Login
```

Other examples:

```text
Loading?
  ↓
YES → Show Loading...

Error?
  ↓
YES → Show Error

Products available?
  ↓
YES → Show Products
NO  → Show "No products"
```

Instead of creating completely separate applications for every situation, React allows us to **conditionally decide what UI should be rendered**.

---

# WHAT?

## What is Conditional Rendering?

Conditional rendering means:

> **Rendering different UI based on a condition.**

Example:

```jsx
function App() {
  const isLoggedIn = true;

  return (
    <div>
      {isLoggedIn ? (
        <h1>Dashboard</h1>
      ) : (
        <h1>Login</h1>
      )}
    </div>
  );
}
```

If:

```text
isLoggedIn = true
```

React renders:

```text
Dashboard
```

If:

```text
isLoggedIn = false
```

React renders:

```text
Login
```

---

# WHERE?

Conditional rendering is used throughout React applications.

Common examples:

### Authentication

```text
Logged in
   ↓
Dashboard

Logged out
   ↓
Login
```

### Loading

```text
API request
   ↓
Loading → "Loading..."
   ↓
Success → Data
   ↓
Error → Error message
```

### Permissions

```text
isAdmin
   ↓
YES → Admin Panel
NO  → Normal User UI
```

### Empty data

```text
products.length
       ↓
0 → "No products"
>0 → Product list
```

---

# HOW?

There are several common ways to perform conditional rendering in React.

---

# 1. `if` Statement

## WHY?

Use an `if` statement when the logic is more complex or when you need to decide what to return.

Example:

```jsx
function Greeting({ isLoggedIn }) {
  if (isLoggedIn) {
    return <h1>Welcome back!</h1>;
  }

  return <h1>Please login.</h1>;
}
```

Flow:

```text
isLoggedIn?
   │
   ├── true  → Welcome
   │
   └── false → Login message
```

---

# 2. Ternary Operator

The ternary operator is very common inside JSX.

Syntax:

```javascript
condition ? valueIfTrue : valueIfFalse
```

Example:

```jsx
function App() {
  const isLoggedIn = true;

  return (
    <h1>
      {isLoggedIn ? "Dashboard" : "Login"}
    </h1>
  );
}
```

Flow:

```text
isLoggedIn
    ↓
 true ──→ Dashboard
 false ─→ Login
```

---

# When should you use a Ternary?

Use a ternary when you have **two clear alternatives**.

Good:

```jsx
{isLoggedIn ? <Dashboard /> : <Login />}
```

Avoid making it unnecessarily complicated:

```jsx
{
  condition1
    ? condition2
      ? condition3
        ? <A />
        : <B />
      : <C />
    : <D />
}
```

For complicated conditions, use normal JavaScript logic before the return or split the UI into components.

---

# 3. Logical AND `&&`

## WHY?

Sometimes we only want to show something when a condition is true.

Example:

```jsx
function App({ isAdmin }) {
  return (
    <div>
      <h1>Dashboard</h1>

      {isAdmin && <button>Delete User</button>}
    </div>
  );
}
```

If:

```text
isAdmin = true
```

the button is rendered.

If:

```text
isAdmin = false
```

the button isn't rendered.

Conceptually:

```text
isAdmin && UI
     ↓
true  → UI
false → nothing
```

---

# Important `&&` Mistake

Be careful with numbers.

Consider:

```jsx
{items.length && <ProductList />}
```

If:

```text
items.length = 0
```

JavaScript evaluates:

```text
0 && <ProductList />
```

and the expression produces:

```text
0
```

That can result in `0` being rendered.

### Better:

```jsx
{items.length > 0 && <ProductList />}
```

Now the condition is explicitly boolean.

---

# 4. `if...else`

You can calculate what should be rendered before the `return`.

```jsx
function Status({ isLoading, error }) {
  let content;

  if (isLoading) {
    content = <p>Loading...</p>;
  } else if (error) {
    content = <p>Something went wrong.</p>;
  } else {
    content = <p>Data loaded.</p>;
  }

  return (
    <div>
      {content}
    </div>
  );
}
```

This is often easier to read than deeply nested ternaries.

---

# 5. Multiple Conditions

Consider an API request:

```text
Loading
Success
Error
```

We can write:

```jsx
function UserList({ loading, error, users }) {
  if (loading) {
    return <p>Loading...</p>;
  }

  if (error) {
    return <p>Failed to load users.</p>;
  }

  if (users.length === 0) {
    return <p>No users found.</p>;
  }

  return (
    <ul>
      {users.map(user => (
        <li key={user.id}>
          {user.name}
        </li>
      ))}
    </ul>
  );
}
```

Flow:

```text
             UserList
                ↓
             Loading?
           /          \
         YES           NO
         ↓              ↓
      Loading         Error?
                       /    \
                     YES     NO
                     ↓        ↓
                   Error    Users?
                             /    \
                            0      >0
                            ↓       ↓
                         Empty    List
```

This pattern is very common in real React applications.

---

# WHERE DOES CONDITIONAL RENDERING HAPPEN?

It can happen:

### Inside JSX

```jsx
{isLoggedIn ? <Dashboard /> : <Login />}
```

### Inside component logic

```jsx
if (isLoggedIn) {
  return <Dashboard />;
}
```

### While rendering lists

```jsx
{users.length > 0
  ? <UserList users={users} />
  : <p>No users</p>
}
```

---

# HOW TO CONDITIONALLY RENDER CSS / CLASSES?

You can also conditionally assign classes.

```jsx
function Button({ isActive }) {
  return (
    <button className={isActive ? "active" : "inactive"}>
      Click
    </button>
  );
}
```

If:

```text
isActive = true
```

then:

```html
class="active"
```

Otherwise:

```html
class="inactive"
```

---

# Practical Example — Login System

```jsx
function App() {
  const isLoggedIn = false;

  return (
    <div>
      {isLoggedIn ? (
        <Dashboard />
      ) : (
        <Login />
      )}
    </div>
  );
}
```

Component tree changes based on state:

```text
isLoggedIn = true

App
 ↓
Dashboard
```

```text
isLoggedIn = false

App
 ↓
Login
```

---

# Practical Example — Loading Data

```jsx
function Users({ loading, users }) {
  if (loading) {
    return <h2>Loading...</h2>;
  }

  if (users.length === 0) {
    return <h2>No users found.</h2>;
  }

  return (
    <div>
      {users.map(user => (
        <p key={user.id}>
          {user.name}
        </p>
      ))}
    </div>
  );
}
```

This is a very common real-world pattern.

---

# WHEN?

## When should I use Conditional Rendering?

Use it whenever the UI depends on some condition.

### Authentication

```jsx
{isLoggedIn ? <Dashboard /> : <Login />}
```

### Permissions

```jsx
{isAdmin && <AdminPanel />}
```

### Loading

```jsx
{loading && <Spinner />}
```

### Empty state

```jsx
{users.length === 0 && <EmptyState />}
```

### Error

```jsx
{error && <ErrorMessage />}
```

---

# Conditional Rendering + State

Conditional rendering becomes especially powerful when combined with state.

Example:

```jsx
import { useState } from "react";

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  return (
    <div>
      {isLoggedIn ? (
        <h1>Dashboard</h1>
      ) : (
        <h1>Please Login</h1>
      )}

      <button
        onClick={() => setIsLoggedIn(!isLoggedIn)}
      >
        Toggle Login
      </button>
    </div>
  );
}
```

Flow:

```text
Initial:
isLoggedIn = false
       ↓
Please Login

Click button
       ↓
isLoggedIn = true
       ↓
Dashboard
```

---

# Common Mistakes

## Mistake 1 — Using `=` instead of `===`

❌

```jsx
{isLoggedIn = true && <Dashboard />}
```

This assigns a value.

✅

```jsx
{isLoggedIn === true && <Dashboard />}
```

Or simply:

```jsx
{isLoggedIn && <Dashboard />}
```

---

# Mistake 2 — Using `0 &&`

❌

```jsx
{items.length && <List />}
```

If length is `0`, you can accidentally render `0`.

✅

```jsx
{items.length > 0 && <List />}
```

---

# Mistake 3 — Too Many Nested Ternaries

❌

```jsx
{
  loading
    ? <Loading />
    : error
      ? <Error />
      : users.length
        ? <Users />
        : <Empty />
}
```

This can become difficult to read.

Better:

```jsx
if (loading) {
  return <Loading />;
}

if (error) {
  return <Error />;
}

if (users.length === 0) {
  return <Empty />;
}

return <Users />;
```

---

# Mistake 4 — Hiding Something With CSS When You Don't Need It

These are different:

```jsx
{isVisible && <Modal />}
```

and:

```css
display: none;
```

With conditional rendering, the component isn't rendered when the condition is false.

With CSS, the element can still exist in the DOM while being hidden.

Choose based on what your UI actually needs.

---

# Interview Questions

### Q1. What is conditional rendering?

> Conditional rendering means displaying different UI based on a condition.

---

### Q2. How can you perform conditional rendering in React?

Common approaches:

```text
if / else
ternary operator
&& operator
switch
variables containing JSX
```

---

### Q3. When should you use a ternary?

When there are two clear alternatives:

```jsx
{isLoggedIn ? <Dashboard /> : <Login />}
```

---

### Q4. When should you use `&&`?

When you want to render something only if a condition is truthy:

```jsx
{isAdmin && <AdminPanel />}
```

---

### Q5. What is the problem with this?

```jsx
{items.length && <List />}
```

If `items.length` is `0`, the expression can produce `0`, which React may render.

Use:

```jsx
{items.length > 0 && <List />}
```

---

### Q6. Can we use `if` directly inside JSX?

No.

This is invalid:

```jsx
return (
  <div>
    {if (isLoggedIn) ...}
  </div>
);
```

Instead, use a ternary/`&&`, or perform the `if` logic before the JSX return.

---

# Remember

```text
CONDITIONAL RENDERING

Condition
   ↓
 ┌───────────────┐
 ↓               ↓
TRUE            FALSE
 ↓               ↓
UI A             UI B
```

### Three patterns you should remember

**Two alternatives:**

```jsx
{isLoggedIn ? <Dashboard /> : <Login />}
```

**Show only when true:**

```jsx
{isAdmin && <AdminPanel />}
```

**Complex conditions:**

```jsx
if (loading) {
  return <Loading />;
}

if (error) {
  return <Error />;
}

return <Data />;
```

### One-line interview answer

> **Conditional rendering in React allows components to display different UI based on conditions using JavaScript techniques such as `if`, ternary operators, and logical `&&` expressions.**
