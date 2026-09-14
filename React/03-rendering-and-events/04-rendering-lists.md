# 04 — Rendering Lists

## WHY?

### Why do we need list rendering?

Real applications usually have collections of data.

For example:

```text
Students
Products
Users
Orders
Messages
Notifications
```

Instead of manually writing UI for every item:

```jsx
<p>Yash</p>
<p>Rahul</p>
<p>Amit</p>
```

we can store the data in an array and generate the UI dynamically.

```text
Array
  ↓
map()
  ↓
JSX elements
  ↓
React renders list
```

This makes the UI:

* Dynamic
* Reusable
* Easier to maintain
* Suitable for API data

---

# WHAT?

## What is List Rendering?

List rendering means **generating multiple React elements from a collection of data**.

Example:

```jsx
const users = ["Yash", "Rahul", "Amit"];
```

We can render them using:

```jsx
function Users() {
  return (
    <ul>
      {users.map(user => (
        <li key={user}>
          {user}
        </li>
      ))}
    </ul>
  );
}
```

Output:

```text
• Yash
• Rahul
• Amit
```

---

# WHERE?

List rendering is used whenever the UI contains repeated items.

### E-commerce

```text
Products
 ├── Laptop
 ├── Phone
 ├── Headphones
 └── Keyboard
```

### Social media

```text
Posts
 ├── Post 1
 ├── Post 2
 └── Post 3
```

### Dashboard

```text
Users
 ├── User 1
 ├── User 2
 └── User 3
```

### API data

```text
Backend
   ↓
JSON array
   ↓
React
   ↓
map()
   ↓
UI list
```

---

# HOW?

## 1. Create an Array

```jsx
const users = [
  "Yash",
  "Rahul",
  "Amit"
];
```

---

## 2. Use `map()`

```jsx
function Users() {
  const users = [
    "Yash",
    "Rahul",
    "Amit"
  ];

  return (
    <ul>
      {users.map(user => (
        <li>{user}</li>
      ))}
    </ul>
  );
}
```

The `map()` function creates a new JSX element for every array item.

Conceptually:

```text
users
 ↓
map()
 ↓
┌─────────────┐
│ Yash        │ → <li>Yash</li>
│ Rahul       │ → <li>Rahul</li>
│ Amit        │ → <li>Amit</li>
└─────────────┘
```

---

# WHY DO WE NEED `key`?

You will notice React commonly expects a `key` when rendering lists.

Correct:

```jsx
function Users() {
  const users = ["Yash", "Rahul", "Amit"];

  return (
    <ul>
      {users.map(user => (
        <li key={user}>
          {user}
        </li>
      ))}
    </ul>
  );
}
```

The `key` helps React identify which list item corresponds to which item between renders.

We will study keys in detail in the next file.

---

# Practical Example — Objects

Most real applications don't have arrays of simple strings.

Usually we have objects:

```jsx
const students = [
  {
    id: 1,
    name: "Yash",
    course: "Computer Science"
  },
  {
    id: 2,
    name: "Rahul",
    course: "Data Science"
  },
  {
    id: 3,
    name: "Amit",
    course: "AI"
  }
];
```

Render them:

```jsx
function Students() {
  return (
    <div>
      {students.map(student => (
        <div key={student.id}>
          <h2>{student.name}</h2>
          <p>{student.course}</p>
        </div>
      ))}
    </div>
  );
}
```

Output:

```text
Yash
Computer Science

Rahul
Data Science

Amit
AI
```

---

# HOW DOES `map()` WORK?

Consider:

```jsx
const numbers = [10, 20, 30];
```

Then:

```jsx
numbers.map(number => (
  <p>{number}</p>
));
```

Conceptually:

```text
10 → <p>10</p>
20 → <p>20</p>
30 → <p>30</p>
```

So the result is effectively a collection of React elements.

---

# Rendering Components in a List

A very common pattern is to use `map()` with a component.

### StudentCard

```jsx
function StudentCard({ name, course }) {
  return (
    <div>
      <h2>{name}</h2>
      <p>{course}</p>
    </div>
  );
}
```

### Students

```jsx
function Students() {
  const students = [
    {
      id: 1,
      name: "Yash",
      course: "Computer Science"
    },
    {
      id: 2,
      name: "Rahul",
      course: "Data Science"
    }
  ];

  return (
    <div>
      {students.map(student => (
        <StudentCard
          key={student.id}
          name={student.name}
          course={student.course}
        />
      ))}
    </div>
  );
}
```

This is one of the most important practical patterns in React.

```text
Array
  ↓
map()
  ↓
Reusable Component
  ↓
Props
  ↓
UI
```

---

# WHERE SHOULD THE `key` GO?

The `key` should be placed on the **element/component directly returned from the `map()`**.

Correct:

```jsx
{students.map(student => (
  <StudentCard
    key={student.id}
    name={student.name}
  />
))}
```

Not:

```jsx
{students.map(student => (
  <div>
    <StudentCard
      key={student.id}
      name={student.name}
    />
  </div>
))}
```

In the second example, the `key` should be on the outer element:

```jsx
{students.map(student => (
  <div key={student.id}>
    <StudentCard
      name={student.name}
    />
  </div>
))}
```

---

# Rendering Lists from API Data

Imagine an API returns:

```json
[
  {
    "id": 101,
    "name": "Yash"
  },
  {
    "id": 102,
    "name": "Rahul"
  }
]
```

You can render it:

```jsx
function Users({ users }) {
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
API
 ↓
JSON
 ↓
Array of objects
 ↓
map()
 ↓
React elements
 ↓
UI
```

---

# Conditional List Rendering

Sometimes the array can be empty.

```jsx
function Users({ users }) {
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
users.length
     ↓
 ┌───┴────┐
 ↓        ↓
 0       >0
 ↓        ↓
Empty    List
```

---

# Filtering Before Rendering

You can use JavaScript methods before `map()`.

For example, show only active users:

```jsx
function Users({ users }) {
  return (
    <ul>
      {users
        .filter(user => user.active)
        .map(user => (
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
users
 ↓
filter()
 ↓
active users
 ↓
map()
 ↓
JSX
 ↓
UI
```

---

# Sorting Before Rendering

You can also sort data before mapping it.

```jsx
const sortedUsers = [...users].sort(
  (a, b) => a.name.localeCompare(b.name)
);

return (
  <ul>
    {sortedUsers.map(user => (
      <li key={user.id}>
        {user.name}
      </li>
    ))}
  </ul>
);
```

The spread:

```jsx
[...users]
```

creates a new array so that the original array isn't mutated by `sort()`.

---

# WHEN?

## When should I use list rendering?

Use list rendering when you have repeated UI generated from data.

Examples:

### Product list

```jsx
{products.map(product => (
  <ProductCard
    key={product.id}
    product={product}
  />
))}
```

### User list

```jsx
{users.map(user => (
  <User
    key={user.id}
    user={user}
  />
))}
```

### Navigation menu

```jsx
{links.map(link => (
  <a
    key={link.id}
    href={link.url}
  >
    {link.label}
  </a>
))}
```

---

# WHEN SHOULD YOU NOT MANUALLY WRITE EVERY ITEM?

Avoid:

```jsx
<ul>
  <li>Yash</li>
  <li>Rahul</li>
  <li>Amit</li>
  <li>Priya</li>
  <li>Neha</li>
</ul>
```

if those values come from data.

Instead:

```jsx
const users = [
  "Yash",
  "Rahul",
  "Amit",
  "Priya",
  "Neha"
];

return (
  <ul>
    {users.map(user => (
      <li key={user}>{user}</li>
    ))}
  </ul>
);
```

Now the UI automatically adapts if the data changes.

---

# Practical Example — Shopping Cart

```jsx
function Cart({ products }) {
  return (
    <div>
      <h1>Shopping Cart</h1>

      {products.map(product => (
        <div key={product.id}>
          <h2>{product.name}</h2>
          <p>₹{product.price}</p>
          <p>Quantity: {product.quantity}</p>
        </div>
      ))}
    </div>
  );
}
```

Example data:

```jsx
const products = [
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
];
```

UI:

```text
Shopping Cart

Laptop
₹50,000
Quantity: 1

Mouse
₹1,000
Quantity: 2
```

---

# Common Mistakes

## Mistake 1 — Forgetting `key`

❌

```jsx
{users.map(user => (
  <li>{user.name}</li>
))}
```

Better:

```jsx
{users.map(user => (
  <li key={user.id}>
    {user.name}
  </li>
))}
```

---

## Mistake 2 — Using array index as key unnecessarily

You might see:

```jsx
{users.map((user, index) => (
  <li key={index}>
    {user.name}
  </li>
))}
```

This can be problematic when list items can be reordered, inserted, or deleted because the index may no longer represent the same item.

Prefer a stable ID:

```jsx
{users.map(user => (
  <li key={user.id}>
    {user.name}
  </li>
))}
```

---

## Mistake 3 — Using random values as keys

❌

```jsx
<li key={Math.random()}>
```

This creates a new key on each render and defeats the purpose of stable identity.

Use a stable identifier from the data.

---

# Interview Questions

### Q1. How do you render a list in React?

> Usually by using JavaScript's `map()` method to transform an array of data into React elements.

Example:

```jsx
users.map(user => (
  <li key={user.id}>
    {user.name}
  </li>
))
```

---

### Q2. Why do we need keys?

> Keys help React identify list items between renders so it can correctly reconcile changes.

---

### Q3. What should a key represent?

> A key should be a stable, unique identifier for that item among its siblings.

---

### Q4. Can we use array index as a key?

**Yes, technically**, but it should generally be avoided when the list can be reordered, inserted into, or deleted from. A stable item ID is usually better.

---

### Q5. Can we render components using `map()`?

Yes.

```jsx
{users.map(user => (
  <User
    key={user.id}
    user={user}
  />
))}
```

---

### Q6. Can we filter before rendering?

Yes.

```jsx
{users
  .filter(user => user.active)
  .map(user => (
    <User
      key={user.id}
      user={user}
    />
  ))}
```

---

# Remember

```text
Data Array
    ↓
filter()  ← optional
    ↓
sort()    ← optional
    ↓
map()
    ↓
JSX / Components
    ↓
key
    ↓
React
    ↓
UI
```

### Most important pattern

```jsx
{items.map(item => (
  <Component
    key={item.id}
    data={item}
  />
))}
```

### One-line interview answer

> **List rendering in React uses JavaScript methods such as `map()` to generate UI from arrays of data, with stable keys helping React identify individual list items during reconciliation.**
