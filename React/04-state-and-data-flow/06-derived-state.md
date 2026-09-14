# 06 — Derived State in React

## WHY?

In React, you often have data that can be **calculated from existing state or props**.

For example, suppose you have:

```jsx
const [firstName, setFirstName] = useState("Yash");
const [lastName, setLastName] = useState("Mahamuni");
```

You might think you need:

```jsx
const [fullName, setFullName] = useState("");
```

But you don't.

`fullName` can simply be calculated:

```jsx
const fullName = `${firstName} ${lastName}`;
```

This is called **derived state/data**.

The main principle is:

> **Don't store something in state if you can calculate it from existing state or props.**

---

# WHAT?

**Derived state** is a value calculated from existing:

* State
* Props
* Other available data

Example:

```jsx
const [price, setPrice] = useState(100);
const [quantity, setQuantity] = useState(2);

const total = price * quantity;
```

Here:

```text
price
   +
quantity
   ↓
total
```

`total` is derived data.

It doesn't need its own state.

---

# WHERE?

Derived values are commonly used for:

* Full names
* Totals
* Filtered lists
* Search results
* Calculated prices
* Shopping cart totals
* Validation results
* Counts
* UI labels
* Boolean conditions

---

# HOW?

## Example 1 — Full Name

### ❌ Unnecessary state

```jsx
const [firstName, setFirstName] = useState("Yash");
const [lastName, setLastName] = useState("Mahamuni");

const [fullName, setFullName] = useState("Yash Mahamuni");
```

Now you have to keep:

```text
firstName
lastName
fullName
```

synchronized.

If `firstName` changes:

```text
firstName → Rahul
```

you also need to remember to update:

```text
fullName → Rahul Mahamuni
```

This creates unnecessary complexity.

---

### ✅ Derived value

```jsx
const [firstName, setFirstName] = useState("Yash");
const [lastName, setLastName] = useState("Mahamuni");

const fullName = `${firstName} ${lastName}`;
```

Now:

```text
firstName
    +
lastName
    ↓
fullName
```

Whenever either state changes, `fullName` is recalculated during rendering.

---

# Example 2 — Product Total

```jsx
function Cart() {
  const [price, setPrice] = useState(500);
  const [quantity, setQuantity] = useState(2);

  const total = price * quantity;

  return (
    <div>
      <p>Price: ₹{price}</p>
      <p>Quantity: {quantity}</p>
      <p>Total: ₹{total}</p>
    </div>
  );
}
```

There is no need for:

```jsx
const [total, setTotal] = useState(1000);
```

because:

```jsx
const total = price * quantity;
```

is enough.

---

# Example 3 — Filtered List

Suppose:

```jsx
const [products, setProducts] = useState([
  { id: 1, name: "Laptop", price: 80000 },
  { id: 2, name: "Mouse", price: 1000 },
  { id: 3, name: "Phone", price: 50000 }
]);
```

You want products costing more than ₹10,000.

### ❌ Don't create separate state

```jsx
const [expensiveProducts, setExpensiveProducts] = useState([]);
```

You would then need to keep it synchronized with `products`.

### ✅ Derive it

```jsx
const expensiveProducts = products.filter(
  product => product.price > 10000
);
```

Now:

```text
products
   ↓
filter()
   ↓
expensiveProducts
```

---

# Example 4 — Search

Suppose:

```jsx
const [products, setProducts] = useState([
  { id: 1, name: "Laptop" },
  { id: 2, name: "Phone" },
  { id: 3, name: "Keyboard" }
]);

const [search, setSearch] = useState("");
```

You can derive filtered products:

```jsx
const filteredProducts = products.filter(product =>
  product.name
    .toLowerCase()
    .includes(search.toLowerCase())
);
```

Complete example:

```jsx
function ProductSearch() {
  const [search, setSearch] = useState("");

  const products = [
    { id: 1, name: "Laptop" },
    { id: 2, name: "Phone" },
    { id: 3, name: "Keyboard" }
  ];

  const filteredProducts = products.filter(product =>
    product.name
      .toLowerCase()
      .includes(search.toLowerCase())
  );

  return (
    <div>
      <input
        value={search}
        onChange={e => setSearch(e.target.value)}
        placeholder="Search..."
      />

      {filteredProducts.map(product => (
        <p key={product.id}>
          {product.name}
        </p>
      ))}
    </div>
  );
}
```

Here:

```text
search
   +
products
   ↓
filteredProducts
   ↓
UI
```

---

# Example 5 — Derived Boolean

Suppose:

```jsx
const [email, setEmail] = useState("");
const [password, setPassword] = useState("");
```

You can calculate:

```jsx
const isFormValid =
  email.length > 0 &&
  password.length >= 8;
```

Don't necessarily create:

```jsx
const [isFormValid, setIsFormValid] = useState(false);
```

because it is directly derived from existing values.

Then:

```jsx
<button disabled={!isFormValid}>
  Login
</button>
```

---

# Example 6 — Cart Item Count

Suppose:

```jsx
const [cart, setCart] = useState([
  { id: 1, name: "Laptop" },
  { id: 2, name: "Mouse" }
]);
```

You can calculate:

```jsx
const cartCount = cart.length;
```

Then:

```jsx
<p>Cart: {cartCount} items</p>
```

No additional state is required.

---

# Derived State vs Actual State

Consider a shopping cart:

```jsx
const [cart, setCart] = useState([]);
```

The cart itself is actual state because it can change.

But:

```jsx
const cartCount = cart.length;
```

is derived.

And:

```jsx
const totalPrice = cart.reduce(
  (total, item) => total + item.price,
  0
);
```

is also derived.

Think:

```text
                    STATE
                      ↓
                    cart
                 /         \
                ↓           ↓
           cartCount     totalPrice
             derived       derived
```

---

# The "Single Source of Truth" Principle

A major React design principle is:

> **Keep the minimum necessary state and derive everything else.**

Suppose:

```jsx
const [price, setPrice] = useState(100);
const [quantity, setQuantity] = useState(2);
```

You don't need:

```jsx
const [total, setTotal] = useState(200);
```

because now you have two sources of information:

```text
price + quantity
       ↓
      200

total state
       ↓
      200
```

If they get out of sync:

```text
price = 100
quantity = 3
total = 200  ❌
```

Your UI becomes incorrect.

With derived data:

```jsx
const total = price * quantity;
```

it's always:

```text
100 × 3 = 300
```

---

# Why Derived State Is Better

### 1. Less code

You don't need extra setters.

### 2. Less synchronization

You don't have to manually keep values consistent.

### 3. Fewer bugs

There is only one source of truth.

### 4. Easier debugging

You can trace:

```text
state → calculation → UI
```

### 5. More predictable UI

Derived values automatically reflect the current state.

---

# Derived State vs `useEffect`

A common mistake is using an Effect to calculate something that can simply be calculated during rendering.

### ❌ Unnecessary

```jsx
const [firstName, setFirstName] = useState("Yash");
const [lastName, setLastName] = useState("Mahamuni");

const [fullName, setFullName] = useState("");

useEffect(() => {
  setFullName(`${firstName} ${lastName}`);
}, [firstName, lastName]);
```

This creates unnecessary state and an unnecessary Effect.

### ✅ Better

```jsx
const fullName = `${firstName} ${lastName}`;
```

If a value can be calculated synchronously from current props/state, calculate it directly.

---

# Derived Data Can Be Expensive

Sometimes the calculation itself is expensive.

Example:

```jsx
const filteredProducts = products
  .filter(...)
  .sort(...)
  .map(...);
```

For normal calculations, just calculate it during rendering.

If a calculation is genuinely expensive and profiling shows it matters, `useMemo` can be considered:

```jsx
const filteredProducts = useMemo(() => {
  return products.filter(
    product => product.price > 10000
  );
}, [products]);
```

Important:

> **Don't use `useMemo` simply because something is derived.**

Derived data does not automatically require `useMemo`.

---

# Practical Example — Shopping Cart

```jsx
import { useState } from "react";

function Cart() {
  const [cart, setCart] = useState([
    {
      id: 1,
      name: "Laptop",
      price: 50000,
      quantity: 1
    },
    {
      id: 2,
      name: "Mouse",
      price: 1000,
      quantity: 2
    }
  ]);

  const itemCount = cart.reduce(
    (count, item) => count + item.quantity,
    0
  );

  const totalPrice = cart.reduce(
    (total, item) =>
      total + item.price * item.quantity,
    0
  );

  return (
    <div>
      <h2>Cart Items: {itemCount}</h2>

      <h2>Total: ₹{totalPrice}</h2>

      {cart.map(item => (
        <p key={item.id}>
          {item.name} × {item.quantity}
        </p>
      ))}
    </div>
  );
}
```

Here only:

```jsx
const [cart, setCart] = useState(...)
```

is state.

These are derived:

```jsx
itemCount
totalPrice
```

---

# How to Identify Derived State

Ask:

### Question 1

> Can I calculate this value from existing state or props?

If yes:

```text
Probably derived data
```

### Question 2

> Does this value need to be independently changed by the user/application?

If no:

```text
Probably don't store it in state
```

### Question 3

> If the source data changes, should this value automatically change?

If yes:

```text
Derive it from the source
```

---

# Common Mistakes

## ❌ Mistake 1 — Duplicating state

```jsx
const [items, setItems] = useState([]);
const [itemCount, setItemCount] = useState(0);
```

Instead:

```jsx
const itemCount = items.length;
```

---

## ❌ Mistake 2 — Synchronizing derived state manually

```jsx
setItems(newItems);
setItemCount(newItems.length);
```

This creates unnecessary synchronization.

Better:

```jsx
setItems(newItems);

const itemCount = items.length;
```

---

## ❌ Mistake 3 — Using `useEffect` for simple calculations

Avoid:

```jsx
useEffect(() => {
  setTotal(price * quantity);
}, [price, quantity]);
```

Prefer:

```jsx
const total = price * quantity;
```

---

## ❌ Mistake 4 — Storing filtered data

Avoid:

```jsx
const [filteredUsers, setFilteredUsers] = useState([]);
```

when it can be derived:

```jsx
const filteredUsers = users.filter(
  user => user.active
);
```

---

# WHEN?

Use **state** when the value itself needs to be independently remembered and changed:

```jsx
const [quantity, setQuantity] = useState(1);
```

Use **derived data** when the value can be calculated:

```jsx
const total = price * quantity;
```

### Quick decision

```text
Does it change independently?
       │
       ├── YES → State
       │
       └── NO
            ↓
Can it be calculated?
            ↓
          YES
            ↓
      Derived value
```

---

# Interview Questions

### 1. What is derived state?

> Derived state is data that can be calculated from existing props or state instead of being stored separately.

---

### 2. Why should we avoid unnecessary derived state?

Because storing derived values creates duplicate sources of truth and requires synchronization, which can lead to bugs.

---

### 3. Give an example of derived data.

```jsx
const [price, setPrice] = useState(100);
const [quantity, setQuantity] = useState(2);

const total = price * quantity;
```

`total` is derived from `price` and `quantity`.

---

### 4. Should filtered lists be stored in state?

Usually no.

Instead:

```jsx
const filteredUsers = users.filter(
  user => user.active
);
```

---

### 5. Should we use `useEffect` to calculate derived values?

Usually no.

If the value can be calculated directly from current props/state during rendering, calculate it directly.

---

### 6. What is the single source of truth?

> The single source of truth means keeping the authoritative version of a piece of data in one place and deriving other values from it rather than duplicating it.

---

# ⭐ Remember

The golden rule:

```text
           MINIMUM STATE
                ↓
       ┌────────┴────────┐
       ↓                 ↓
   State A            State B
       │                 │
       └────────┬────────┘
                ↓
         Derived Data
                ↓
               UI
```

### Don't do:

```jsx
const [price, setPrice] = useState(100);
const [quantity, setQuantity] = useState(2);
const [total, setTotal] = useState(200);
```

### Prefer:

```jsx
const [price, setPrice] = useState(100);
const [quantity, setQuantity] = useState(2);

const total = price * quantity;
```

### One-line interview answer

> **Derived state is a value calculated from existing props or state; whenever possible, it should be calculated during rendering instead of being stored as separate state.**
