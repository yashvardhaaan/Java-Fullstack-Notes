# 10 — State Design in React

## WHY?

In React, **how you design your state matters**.

Bad state design can cause:

* Unnecessary re-renders
* Duplicate/inconsistent data
* Difficult state updates
* Complex components
* Bugs caused by stale or conflicting state

Good state design means:

> **Keep the minimum amount of state necessary and derive everything else from it.**

### Example of bad state design

```jsx
function Cart() {
  const [items, setItems] = useState([]);
  const [totalItems, setTotalItems] = useState(0);

  // Now both states must stay synchronized
}
```

`totalItems` can be calculated from `items`.

So storing both creates unnecessary state.

### Better

```jsx
function Cart() {
  const [items, setItems] = useState([]);

  const totalItems = items.length;

  return <p>Total: {totalItems}</p>;
}
```

---

# WHAT?

**State design** means deciding:

1. What data should actually be state?
2. Where should that state live?
3. What data can be derived?
4. Which component needs access to it?
5. Should it be local, lifted, or shared?

---

## ⭐ Principle: Store the Minimum State

Suppose you have:

```jsx
const [firstName, setFirstName] = useState("");
const [lastName, setLastName] = useState("");
```

You don't need:

```jsx
const [fullName, setFullName] = useState("");
```

Instead:

```jsx
const fullName = `${firstName} ${lastName}`;
```

### Rule

```text
If something can be calculated from existing state,
don't store it separately.
```

---

# WHERE?

State should generally live in the **lowest component that needs to own/control it**.

### Example

```text
App
 ├── Header
 └── ProductList
       ├── Product
       └── Product
```

If only `ProductList` needs `products`:

```jsx
function ProductList() {
  const [products, setProducts] = useState([]);

  // ...
}
```

Don't automatically put it in `App`.

---

## When multiple components need the state

Move it to their nearest common parent.

```text
        App
       /   \
   Search  ProductList
      \      /
       products
```

The state can live in `App`:

```jsx
function App() {
  const [products, setProducts] = useState([]);

  return (
    <>
      <Search products={products} />
      <ProductList products={products} />
    </>
  );
}
```

This is **lifting state up**.

---

# HOW?

## 1. Identify the actual state

Ask:

> Does this value need to change over time and affect rendering?

If yes, it may be state.

```jsx
const [count, setCount] = useState(0);
```

---

## 2. Remove duplicate state

### ❌ Bad

```jsx
const [user, setUser] = useState({
  firstName: "Yash",
  lastName: "Mahamuni",
});

const [fullName, setFullName] = useState("Yash Mahamuni");
```

Now you have to keep both synchronized.

### ✅ Good

```jsx
const [user, setUser] = useState({
  firstName: "Yash",
  lastName: "Mahamuni",
});

const fullName = `${user.firstName} ${user.lastName}`;
```

---

# 3. Don't store values that can be derived

### ❌

```jsx
const [items, setItems] = useState([]);
const [itemCount, setItemCount] = useState(0);
```

### ✅

```jsx
const [items, setItems] = useState([]);

const itemCount = items.length;
```

---

# 4. Keep state close to where it is used

### Example

```jsx
function SearchBox() {
  const [query, setQuery] = useState("");

  return (
    <input
      value={query}
      onChange={(e) => setQuery(e.target.value)}
    />
  );
}
```

If only `SearchBox` needs `query`, there is no reason to move it to `App`.

### Principle

```text
Keep state local unless another component needs it.
```

---

# 5. Group related state

Suppose a form has:

```jsx
const [name, setName] = useState("");
const [email, setEmail] = useState("");
const [phone, setPhone] = useState("");
```

This can be reasonable.

Or you can group related data:

```jsx
const [form, setForm] = useState({
  name: "",
  email: "",
  phone: "",
});
```

Update immutably:

```jsx
setForm({
  ...form,
  email: "yash@example.com",
});
```

Or with a functional update:

```jsx
setForm(prev => ({
  ...prev,
  email: "yash@example.com",
}));
```

---

# 6. Avoid contradictory state

### ❌ Bad

```jsx
const [isLoading, setIsLoading] = useState(false);
const [isLoaded, setIsLoaded] = useState(true);
```

These two values can accidentally contradict each other.

For example:

```text
isLoading = true
isLoaded = true
```

What does that mean?

### Better

Use one clear state representation:

```jsx
const [status, setStatus] = useState("loading");
```

Possible values:

```text
"loading"
"success"
"error"
```

Then:

```jsx
if (status === "loading") {
  return <p>Loading...</p>;
}

if (status === "error") {
  return <p>Something went wrong.</p>;
}

return <p>Data loaded!</p>;
```

---

# 7. Don't put everything in global state

A common beginner mistake is:

```text
Everything → Redux / Context / Global Store
```

Instead:

```text
Local UI state → useState
Shared parent-child state → lift state
Deep subtree data → Context
Complex application state → state management solution
```

---

# Practical Example — Shopping Cart

### ❌ Poor state design

```jsx
const [items, setItems] = useState([]);
const [totalItems, setTotalItems] = useState(0);
const [totalPrice, setTotalPrice] = useState(0);
```

Now every time `items` changes, you must update:

```text
items
totalItems
totalPrice
```

There is a risk of inconsistency.

---

### ✅ Better state design

```jsx
const [items, setItems] = useState([
  { id: 1, name: "Laptop", price: 50000 },
  { id: 2, name: "Mouse", price: 1000 },
]);
```

Derive the rest:

```jsx
const totalItems = items.length;

const totalPrice = items.reduce(
  (total, item) => total + item.price,
  0
);
```

Now there is only **one source of truth**.

---

# State Design Decision Tree

```text
Do I need this value to change and affect UI?
            |
           YES
            |
       Is it derived?
       /          \
     YES           NO
      |             |
 Calculate it    Store as state
                    |
          Who needs the state?
             /          \
          One          Multiple
           |              |
       Keep local     Lift state up
                          |
                 Deep subtree?
                    /       \
                  YES        NO
                   |          |
                Context      Props
```

---

# WHEN?

Use good state design when:

* Designing a new component
* Building forms
* Managing API data
* Building shopping carts
* Creating filters/search
* Sharing data between components
* Deciding whether to use Context/Redux/etc.
* Refactoring complicated components

---

# Common Mistakes

### ❌ Storing derived data

```jsx
const [items, setItems] = useState([]);
const [count, setCount] = useState(0);
```

Prefer:

```jsx
const count = items.length;
```

### ❌ Keeping the same data in multiple places

```text
User data in App
User data in Context
User data in Profile
```

Try to maintain a **single source of truth**.

### ❌ Putting all state in App

Not every state needs to live at the top.

### ❌ Making everything global

Global state adds complexity. Use it only when sharing actually requires it.

### ❌ Contradictory state

```jsx
isLoading
isLoaded
hasFinishedLoading
```

These can conflict.

Prefer a clear state model:

```jsx
status = "loading" | "success" | "error"
```

---

# 🎯 Interview Questions

### 1. What is state design in React?

State design is the process of deciding **what should be stored as state, where it should live, and what should instead be derived from existing data**.

---

### 2. Why shouldn't we store derived state?

Because it creates duplicate data that can become inconsistent.

```jsx
const total = items.reduce(...);
```

is better than maintaining a separate `total` state when it can be calculated from `items`.

---

### 3. What is the single source of truth?

It means a particular piece of data should have **one authoritative location** rather than multiple independently maintained copies.

---

### 4. Where should state live?

Generally:

> **At the lowest common ancestor of the components that need to access or modify it.**

---

### 5. Should all state be global?

No.

Keep state local whenever possible and share it only when necessary.

---

### 6. How do you avoid contradictory state?

Represent the state using a single, clear model.

Instead of:

```jsx
isLoading
isLoaded
hasError
```

you might use:

```jsx
status
```

with:

```text
loading
success
error
```

---

### 7. What is the difference between state and derived data?

**State:**

```jsx
const [price, setPrice] = useState(100);
```

**Derived data:**

```jsx
const discountedPrice = price * 0.9;
```

`discountedPrice` doesn't need its own state because it can be calculated.

---

# ⭐ Remember

```text
Good React State Design

1. Store only necessary state
2. Avoid duplicate state
3. Derive calculated values
4. Keep state close to its consumers
5. Lift state when components need to share it
6. Avoid contradictory state
7. Don't make everything global
8. Maintain a single source of truth
```

### One-line interview answer

> **State design in React means keeping the minimum necessary state, placing it at the right component level, and deriving everything else from that state to maintain a single source of truth.**
