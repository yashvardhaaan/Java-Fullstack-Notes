# 05 — Keys in React Lists

## WHY?

### Why do we need keys?

When React renders a list, it needs to know **which item is which** when the list changes.

For example, suppose the UI initially contains:

```text
Yash
Rahul
Amit
```

Then Rahul is removed:

```text
Yash
Amit
```

React needs a stable way to identify:

```text
Yash  → same item
Rahul → removed
Amit  → same item
```

This is what **keys** help React do.

---

# WHAT?

## What is a Key?

A `key` is a special value used by React to identify an element among its siblings in a list.

Example:

```jsx
function Users() {
  const users = [
    { id: 1, name: "Yash" },
    { id: 2, name: "Rahul" },
    { id: 3, name: "Amit" }
  ];

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

Here:

```jsx
key={user.id}
```

provides each item with a stable identity.

---

# WHERE?

Keys are mainly used when rendering **lists of elements or components**.

### HTML elements

```jsx
{users.map(user => (
  <li key={user.id}>
    {user.name}
  </li>
))}
```

### React components

```jsx
{users.map(user => (
  <UserCard
    key={user.id}
    user={user}
  />
))}
```

---

# HOW?

## How does React use keys?

Suppose the initial list is:

```text
A
B
C
```

with:

```text
id=1 → A
id=2 → B
id=3 → C
```

Then the data changes to:

```text
A
C
D
```

with:

```text
id=1 → A
id=3 → C
id=4 → D
```

React can use the keys to understand:

```text
1 → A → existing
2 → B → removed
3 → C → existing
4 → D → new
```

Conceptually:

```text
Previous                New

key 1 → A       →       key 1 → A
key 2 → B       →       removed
key 3 → C       →       key 3 → C
                       key 4 → D
```

This helps React reconcile the list correctly.

---

# WHY NOT JUST USE POSITION?

Consider:

```text
Position 0 → A
Position 1 → B
Position 2 → C
```

Now remove `A`:

```text
Position 0 → B
Position 1 → C
```

The positions changed even though `B` and `C` are the same logical items.

A stable ID gives React a better identity:

```text
id 2 → B
id 3 → C
```

Their identity remains the same even if their position changes.

---

# BEST KEY

The best key is usually a **stable, unique ID associated with the data item**.

Example:

```jsx
{products.map(product => (
  <ProductCard
    key={product.id}
    product={product}
  />
))}
```

Good:

```text
product.id
user.id
order.id
database ID
```

---

# HOW TO CHOOSE A KEY?

A good key should generally be:

```text
Stable
Unique among siblings
Associated with the item
```

Example:

```jsx
const products = [
  {
    id: "prod_101",
    name: "Laptop"
  },
  {
    id: "prod_102",
    name: "Phone"
  }
];
```

Use:

```jsx
key={product.id}
```

---

# INDEX AS KEY

You may see:

```jsx
{users.map((user, index) => (
  <li key={index}>
    {user.name}
  </li>
))}
```

This works technically, but it can cause problems when the list changes.

---

## WHY can index be problematic?

Suppose:

```text
Initial:

Index 0 → Yash
Index 1 → Rahul
Index 2 → Amit
```

Remove Yash:

```text
Index 0 → Rahul
Index 1 → Amit
```

The keys have changed:

```text
Before:
0 → Yash
1 → Rahul
2 → Amit

After:
0 → Rahul
1 → Amit
```

The key `0` used to represent Yash but now represents Rahul.

That can cause incorrect component identity and, especially with stateful list items, unexpected behavior.

---

# WHEN IS INDEX ACCEPTABLE?

Using the index can be reasonable when the list is effectively **static** and items will not be:

* Reordered
* Inserted
* Removed
* Filtered

Example:

```jsx
const days = [
  "Monday",
  "Tuesday",
  "Wednesday"
];

return (
  <ul>
    {days.map((day, index) => (
      <li key={index}>
        {day}
      </li>
    ))}
  </ul>
);
```

But if you already have a stable ID, prefer the ID.

---

# NEVER USE RANDOM KEYS

Avoid:

```jsx
key={Math.random()}
```

### WHY?

A random value can change every time the component renders.

For example:

```text
Render 1:
key = 483

Render 2:
key = 921
```

React may interpret this as completely different elements.

This defeats stable identity.

---

# KEY MUST BE UNIQUE AMONG SIBLINGS

Consider:

```jsx
[
  { id: 1, name: "Yash" },
  { id: 2, name: "Rahul" }
]
```

Good:

```jsx
key={user.id}
```

The keys are:

```text
1
2
```

They are unique among the siblings.

---

# KEY DOES NOT HAVE TO BE GLOBALLY UNIQUE

Keys only need to identify items **among their siblings in the relevant list**.

For example, separate lists can use the same IDs:

```text
List A:
1
2
3

List B:
1
2
3
```

That's not inherently a problem because they are separate sibling sets.

---

# KEY IS NOT A NORMAL PROP

This is very important.

Consider:

```jsx
<UserCard key={user.id} user={user} />
```

The child component does **not** receive `key` as a normal prop.

This will not work:

```jsx
function UserCard(props) {
  console.log(props.key);
}
```

If the component needs the ID itself, pass it separately:

```jsx
<UserCard
  key={user.id}
  userId={user.id}
  user={user}
/>
```

Then:

```jsx
function UserCard({ userId, user }) {
  console.log(userId);
}
```

So:

```text
key
 ↓
React's reconciliation identity
```

while:

```text
userId
 ↓
Normal component prop
```

---

# Practical Example — Product List

```jsx
function ProductList() {
  const products = [
    {
      id: 101,
      name: "Laptop",
      price: 50000
    },
    {
      id: 102,
      name: "Phone",
      price: 30000
    },
    {
      id: 103,
      name: "Headphones",
      price: 5000
    }
  ];

  return (
    <div>
      {products.map(product => (
        <ProductCard
          key={product.id}
          product={product}
        />
      ))}
    </div>
  );
}
```

Here:

```text
101 → Laptop
102 → Phone
103 → Headphones
```

The IDs provide stable identity.

---

# Practical Example — Stateful List Item

Keys become especially important when list items have their own state.

```jsx
function UserCard({ user }) {
  const [expanded, setExpanded] = useState(false);

  return (
    <div>
      <h2>{user.name}</h2>

      <button
        onClick={() => setExpanded(!expanded)}
      >
        Toggle
      </button>

      {expanded && <p>User details...</p>}
    </div>
  );
}
```

Render:

```jsx
{users.map(user => (
  <UserCard
    key={user.id}
    user={user}
  />
))}
```

If the list is reordered, stable keys help React associate the correct component instance with the correct user.

---

# WHEN?

## When should I use keys?

Whenever you render a collection of sibling elements dynamically.

Example:

```jsx
{items.map(item => (
  <Item
    key={item.id}
    item={item}
  />
))}
```

---

## When should I avoid index keys?

Avoid them when the list can:

```text
Change order
Insert items
Delete items
Filter items
```

For example:

```text
Todo list
Shopping cart
Search results
Editable table
Dynamic form fields
```

Use stable IDs whenever possible.

---

# Practical Todo Example

### Data

```jsx
const todos = [
  {
    id: 1,
    text: "Learn React"
  },
  {
    id: 2,
    text: "Practice JavaScript"
  }
];
```

### Rendering

```jsx
function TodoList() {
  return (
    <ul>
      {todos.map(todo => (
        <li key={todo.id}>
          {todo.text}
        </li>
      ))}
    </ul>
  );
}
```

Flow:

```text
todos
  ↓
map()
  ↓
todo.id
  ↓
key
  ↓
React identifies item
  ↓
UI
```

---

# Common Mistakes

## ❌ Mistake 1 — No key

```jsx
{users.map(user => (
  <User user={user} />
))}
```

Better:

```jsx
{users.map(user => (
  <User
    key={user.id}
    user={user}
  />
))}
```

---

## ❌ Mistake 2 — Random key

```jsx
key={Math.random()}
```

Avoid it.

---

## ❌ Mistake 3 — Unstable generated key

Avoid generating a new key during every render.

The key should remain stable for the same logical item.

---

## ❌ Mistake 4 — Assuming key is available in props

```jsx
function User({ key }) {
  // Don't rely on key this way
}
```

Pass the required ID separately:

```jsx
<User
  key={user.id}
  userId={user.id}
/>
```

---

# Interview Questions

### Q1. What is a key in React?

> A key is a special identifier used by React to distinguish elements in a list among their siblings during reconciliation.

---

### Q2. Why are keys important?

> They help React maintain the identity of list items when the list changes.

---

### Q3. What makes a good key?

> A good key is stable and unique among the item's siblings, and is usually derived from the item's data.

---

### Q4. Why should we avoid array indexes as keys?

> Because indexes can change when items are inserted, removed, or reordered, causing React to associate component identity with the wrong item.

---

### Q5. Can I use `Math.random()` as a key?

**No, generally not.**

It produces unstable keys and can cause React to recreate list elements unnecessarily.

---

### Q6. Is `key` available as a prop?

**No.**

`key` is a special React value used internally for reconciliation. If the component needs the same ID, pass it as another prop.

---

### Q7. Do keys have to be globally unique?

**No.**

They only need to be unique among the relevant siblings.

---

# Remember

```text
List Data
    ↓
map()
    ↓
Each Item
    ↓
Stable Key
    ↓
React identifies item
    ↓
Reconciliation
    ↓
Correct UI
```

### Best pattern

```jsx
{items.map(item => (
  <Component
    key={item.id}
    item={item}
  />
))}
```

### Golden Rule

> **Use a stable ID from your data as the key whenever possible.**

### One-line interview answer

> **Keys provide stable identity to items in a React list, allowing React to correctly reconcile insertions, deletions, and reordering without confusing one item or component instance with another.**
