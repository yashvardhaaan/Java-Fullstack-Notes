# 08 — State Sharing in React

## WHY?

As React applications become larger, the same piece of data may be needed by **multiple components**.

For example:

```text
                 App
                  │
             User Data
          ┌───────┼───────┐
          ↓       ↓       ↓
       Navbar   Profile   Orders
```

All three components may need information about the logged-in user.

If every component maintains its own copy:

```text
Navbar  → user
Profile → user
Orders  → user
```

you can end up with **different copies of the same information**.

That creates synchronization problems.

The goal is:

> **Keep shared data in one appropriate place and let the components that need it access that shared source of truth.**

---

# WHAT?

**State sharing** means making the same state available to multiple components that need it.

There are several ways to share state in React:

```text
1. Parent → Child
      ↓
   Props

2. Sibling components
      ↓
   Lift state up

3. Deep component tree
      ↓
   Context

4. Large/global application state
      ↓
   State management libraries
```

For now, the important idea is:

> **Choose the simplest state-sharing mechanism that matches how widely the data is needed.**

---

# WHERE?

State sharing is commonly needed for:

* Logged-in user information
* Shopping cart
* Theme
* Language preference
* Selected product
* Filters
* Authentication status
* Application settings
* Notifications
* Multi-step forms

---

# HOW?

## Level 1 — Parent to Child with Props

If only a parent and child need the data, use props.

```jsx
function Parent() {
  const [name, setName] = useState("Yash");

  return <Child name={name} />;
}

function Child({ name }) {
  return <h1>Hello {name}</h1>;
}
```

Flow:

```text
Parent State
     ↓
   Props
     ↓
  Child
```

This is the simplest form of sharing.

---

# Level 2 — Sibling Components

Suppose:

```text
App
├── SearchBox
└── ProductList
```

Both need the search value.

Put the state in `App`:

```jsx
function App() {
  const [search, setSearch] = useState("");

  return (
    <>
      <SearchBox
        search={search}
        onSearchChange={setSearch}
      />

      <ProductList
        search={search}
      />
    </>
  );
}
```

Now:

```text
             App
              │
            search
           /      \
          ↓        ↓
   SearchBox    ProductList
       │
       └── updates search
```

This is **lifting state up**.

---

# Level 3 — Deeply Nested Components

Suppose the structure is:

```text
App
 ↓
Layout
 ↓
Dashboard
 ↓
Sidebar
 ↓
UserProfile
```

If `UserProfile` needs user data from `App`, you might have to pass it through every component:

```text
App
 ↓ user
Layout
 ↓ user
Dashboard
 ↓ user
Sidebar
 ↓ user
UserProfile
```

This can become **prop drilling**.

For data that genuinely needs to be available across a component subtree, React's **Context API** can help.

---

# Context Example

Create a context:

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
      <Dashboard />
    </UserContext.Provider>
  );
}
```

A deeply nested component can consume it:

```jsx
function UserProfile() {
  const user = useContext(UserContext);

  return <h1>{user.name}</h1>;
}
```

Now the data doesn't have to be passed through every intermediate component.

---

# Modern Context Provider Syntax

In newer React versions, you may also see:

```jsx
<UserContext value={user}>
  <Dashboard />
</UserContext>
```

instead of:

```jsx
<UserContext.Provider value={user}>
  <Dashboard />
</UserContext.Provider>
```

Both represent the Context provider pattern; the exact syntax depends on the React version/project.

---

# Context Is Not Automatically "Global State"

This is an important distinction.

Context primarily solves:

> **How can a value be made available to components deeper in a tree without manually passing props through every level?**

For example:

```text
ThemeContext
UserContext
LanguageContext
```

Context can share these values across a subtree.

But Context is **not automatically a complete state-management solution**.

You can combine Context with state:

```jsx
const [user, setUser] = useState(null);

<UserContext value={{ user, setUser }}>
  ...
</UserContext>
```

Now descendants can read and update the shared state.

---

# Level 4 — Application-Wide State

Large applications sometimes need more sophisticated state management.

Examples include libraries such as:

* Redux
* Zustand
* MobX
* Jotai

The important thing is **not to immediately use a library for every state variable**.

First ask:

```text
Can props solve it?
       ↓
No?
       ↓
Can lifting state solve it?
       ↓
No?
       ↓
Would Context solve it?
       ↓
Need more complex shared state?
       ↓
Consider a state-management library
```

---

# Practical Example — Shopping Cart

Imagine:

```text
App
├── Navbar
│    └── CartCount
│
├── ProductList
│    └── Product
│
└── Cart
```

The cart may be needed by:

```text
Navbar
ProductList
Cart
```

A possible architecture is:

```text
                 App
                  │
                cart
             /    │    \
            ↓     ↓     ↓
        Navbar Product  Cart
```

The state might be:

```jsx
const [cart, setCart] = useState([]);
```

Then pass the necessary data/actions down.

For example:

```jsx
<Navbar cart={cart} />

<ProductList
  onAddToCart={addToCart}
/>

<Cart
  cart={cart}
/>
```

---

# Practical Example — Cart with Shared State

```jsx
import { useState } from "react";

function App() {
  const [cart, setCart] = useState([]);

  function addToCart(product) {
    setCart(prevCart => [
      ...prevCart,
      product
    ]);
  }

  return (
    <>
      <Navbar cart={cart} />

      <ProductList
        onAddToCart={addToCart}
      />

      <Cart cart={cart} />
    </>
  );
}
```

### Data flow

```text
                    App
                     │
              cart + addToCart
              /       |       \
             ↓        ↓        ↓
         Navbar   ProductList   Cart
             │        │
             │        │
       cart count    addToCart()
                         │
                         ↓
                        App
                         │
                    setCart()
                         │
                         ↓
                    New cart
                         │
                         ↓
                   Components
                    re-render
```

This is a very common React architecture.

---

# State Sharing Does NOT Mean Sharing Everything

Suppose:

```jsx
function SearchBox() {
  const [text, setText] = useState("");
}
```

If only `SearchBox` needs `text`, keep it local.

Don't make it shared just because you can.

```text
Only one component needs it
        ↓
Keep state local

Multiple related components need it
        ↓
Lift/share state

Many distant components need it
        ↓
Consider Context or another state solution
```

---

# Single Source of Truth

This is one of the most important concepts in state sharing.

Suppose two components need:

```text
selectedProduct
```

Don't maintain:

```text
Component A → selectedProduct
Component B → selectedProduct
```

Instead:

```text
Parent
  │
  └── selectedProduct
       /       \
      ↓         ↓
 Component A  Component B
```

There is one authoritative value.

---

# State Ownership

Whenever you share state, ask:

> **Who should own this state?**

Example:

```text
SearchBox + ProductList
        ↓
      App
```

If both need the search value, `App` can own it.

But if only SearchBox needs it:

```text
SearchBox
   ↓
Own the state locally
```

A useful rule:

> **Put state at the lowest component in the tree that needs to coordinate all of its consumers.**

---

# State Sharing vs Prop Drilling

These are different concepts.

### State sharing

The goal:

```text
Make data available to multiple components.
```

### Prop drilling

A possible problem:

```text
Passing props through components
that don't actually need them.
```

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

`Layout` and `Dashboard` might not use `user`; they are only forwarding it.

That is prop drilling.

---

# WHEN?

## Use Props When:

The data is needed by a direct child.

```text
Parent → Child
```

---

## Lift State When:

Sibling components need the same state.

```text
       Parent
       /    \
      A      B
```

---

## Use Context When:

Many descendants need the same value and passing props through intermediate components becomes cumbersome.

Examples:

```text
Theme
User
Language
```

---

## Consider State Management Libraries When:

The application has complex shared state involving things like:

* Many unrelated components
* Complex update logic
* Large state graphs
* Frequent cross-component updates
* Advanced debugging requirements

Don't add a library simply because the application has more than one state variable.

---

# Common Mistakes

## ❌ Mistake 1 — Duplicate shared state

```jsx
// Component A
const [cart, setCart] = useState([]);

// Component B
const [cart, setCart] = useState([]);
```

Now the two carts can become inconsistent.

### ✅ Better

Keep one shared source of truth.

---

## ❌ Mistake 2 — Sharing state unnecessarily

Don't put every piece of local UI state into Context.

For example:

```jsx
const [isDropdownOpen, setIsDropdownOpen] =
  useState(false);
```

If only one component needs it, keep it local.

---

## ❌ Mistake 3 — Using Context for everything

Context is useful, but it shouldn't automatically replace props.

For:

```text
Parent → Direct Child
```

simple props are usually clearer.

---

## ❌ Mistake 4 — Creating global state too early

Don't immediately install Redux/Zustand/etc. just because two components need to share data.

Start with:

```text
Local state
    ↓
Props
    ↓
Lift state
    ↓
Context
    ↓
State management library
```

Choose based on the actual problem.

---

# Interview Questions

### 1. What is state sharing?

> State sharing is the process of making the same state available to multiple components that need to read or modify it.

---

### 2. How do sibling components share state?

Move the state to their closest common parent and pass the required data and callbacks through props.

```text
Parent State
   ↓       ↓
Child A  Child B
```

---

### 3. What is the single source of truth?

> It means keeping the authoritative version of shared data in one place rather than maintaining duplicate copies.

---

### 4. When should you use Context?

When a value needs to be accessed by many components at different levels of a component tree and passing props through intermediate components becomes cumbersome.

---

### 5. Is Context the same as Redux?

No.

Context is a React mechanism for making values available through a component subtree. Redux is a separate state-management library with its own architecture and update model.

---

### 6. Should all application state be global?

**No.**

Keep state local when only one component or a small part of the tree needs it.

---

### 7. What is state ownership?

> State ownership means deciding which component should be responsible for storing and updating a particular piece of state.

---

# ⭐ Remember

Use this decision tree:

```text
Does only ONE component need the state?
        │
       YES
        ↓
   Keep it local


Do sibling components need it?
        │
       YES
        ↓
   Lift state up


Do many deeply nested components need it?
        │
       YES
        ↓
      Context


Is shared state becoming complex?
        │
       YES
        ↓
Consider a state-management solution
```

And remember:

```text
Props
  ↓
Simple sharing

Lifting State
  ↓
Sibling sharing

Context
  ↓
Deep/tree-wide sharing

State Management Library
  ↓
Complex application state
```

### One-line interview answer

> **State sharing means keeping shared data in an appropriate common location and providing access to the components that need it, using props, lifted state, Context, or a state-management solution depending on the application's complexity.**
