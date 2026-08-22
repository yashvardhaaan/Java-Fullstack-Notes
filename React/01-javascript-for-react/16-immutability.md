# 14 — Immutability

Immutability is one of the **most important JavaScript concepts for React**.

You have already seen it indirectly in:

```js
{ ...user }
```

and:

```js
[...products]
```

Now understand **why** we do that.

> **Immutability means: instead of changing existing data directly, create a new version of that data with the required change.**

---

# 1. The basic idea

Suppose:

```js
const user = {
  name: "Yash",
  age: 21
};
```

Directly changing it:

```js
user.age = 22;
```

means:

```text
Old object
   ↓
same object modified
```

With immutability:

```js
const updatedUser = {
  ...user,
  age: 22
};
```

Now:

```text
Old object              New object
     ↓                       ↓
{name:"Yash",age:21}   {name:"Yash",age:22}
```

The original object wasn't changed.

---

# 2. Why does React care about immutability?

React needs to know:

> **Did the state change?**

React commonly relies on **reference identity** when determining whether values have changed.

Suppose:

```js
const user = {
  name: "Yash"
};
```

You mutate it:

```js
user.name = "Rahul";
```

The object is still the **same object reference**.

```text
user
 ↓
Object A
```

You changed the contents, but not the reference.

With:

```js
const updatedUser = {
  ...user,
  name: "Rahul"
};
```

you get:

```text
user         updatedUser
 ↓               ↓
Object A       Object B
```

Now the reference is different.

This is one reason immutable updates work so well with React.

---

# 3. The React state example

Suppose:

```jsx
const [user, setUser] = useState({
  name: "Yash",
  age: 21
});
```

### Don't do this:

```js
user.age = 22;
```

and then:

```js
setUser(user);
```

You're modifying the existing state object and passing the same reference back.

### Prefer:

```js
setUser({
  ...user,
  age: 22
});
```

You're creating a new object.

---

# 4. Why reference matters

Consider:

```js
const user1 = {
  name: "Yash"
};

const user2 = user1;
```

Both point to the same object:

```text
user1 ─────┐
           ↓
        Object A
           ↑
user2 ─────┘
```

If:

```js
user2.name = "Rahul";
```

then:

```js
user1.name
```

is also:

```text
Rahul
```

because there is only one object.

---

# 5. Creating a new object

Using spread:

```js
const user2 = {
  ...user1
};
```

Now:

```text
user1 ──→ Object A

user2 ──→ Object B
```

Therefore:

```js
user1 === user2;
```

returns:

```text
false
```

This is the foundation of immutable updates.

---

# 6. Updating an object immutably

Original:

```js
const user = {
  name: "Yash",
  age: 21,
  city: "Pune"
};
```

Update age:

```js
const updatedUser = {
  ...user,
  age: 22
};
```

Update city:

```js
const updatedUser = {
  ...user,
  city: "Mumbai"
};
```

Add a property:

```js
const updatedUser = {
  ...user,
  role: "Developer"
};
```

The original remains unchanged.

---

# 7. Updating nested objects

This is where immutability becomes important.

Suppose:

```js
const user = {
  name: "Yash",
  address: {
    city: "Pune",
    country: "India"
  }
};
```

You want to change the city.

Don't do:

```js
user.address.city = "Mumbai";
```

Instead:

```js
const updatedUser = {
  ...user,
  address: {
    ...user.address,
    city: "Mumbai"
  }
};
```

Now:

```text
Old user
   │
   └── address
         │
         └── Pune

New user
   │
   └── address
         │
         └── Mumbai
```

---

# 8. Why do we need two spreads?

Look at:

```js
const updatedUser = {
  ...user,
  address: {
    ...user.address,
    city: "Mumbai"
  }
};
```

First:

```js
...user
```

creates a new **user object**.

Second:

```js
...user.address
```

creates a new **address object**.

So both levels that you're changing get new references.

---

# 9. React nested state example

```jsx
const [user, setUser] = useState({
  name: "Yash",
  address: {
    city: "Pune",
    country: "India"
  }
});
```

Update city:

```js
setUser({
  ...user,
  address: {
    ...user.address,
    city: "Mumbai"
  }
});
```

This is a very common React pattern.

---

# 10. Arrays are also mutable

Arrays can be modified directly.

For example:

```js
const skills = [
  "Java",
  "React"
];

skills.push("Spring Boot");
```

`push()` changes the original array.

That's called **mutation**.

In React state, avoid doing:

```js
skills.push("Spring Boot");
setSkills(skills);
```

Instead:

```js
setSkills([
  ...skills,
  "Spring Boot"
]);
```

Now a new array is created.

---

# 11. Adding an item to an array

Original:

```js
const users = [
  "Yash",
  "Rahul"
];
```

Immutable update:

```js
const updatedUsers = [
  ...users,
  "Amit"
];
```

Result:

```text
["Yash", "Rahul", "Amit"]
```

---

# 12. Removing an item

Don't do:

```js
users.splice(1, 1);
```

because `splice()` mutates the original array.

Use:

```js
const updatedUsers = users.filter(
  user => user !== "Rahul"
);
```

This creates a new array.

---

# 13. Updating an item in an array

Suppose:

```js
const users = [
  { id: 1, name: "Yash" },
  { id: 2, name: "Rahul" }
];
```

You want to change Rahul's name.

Use:

```js
const updatedUsers = users.map(user =>
  user.id === 2
    ? { ...user, name: "Amit" }
    : user
);
```

Result:

```js
[
  { id: 1, name: "Yash" },
  { id: 2, name: "Amit" }
]
```

This pattern is **extremely important in React**.

---

# 14. React state example — updating an array

```jsx
const [users, setUsers] = useState([
  { id: 1, name: "Yash" },
  { id: 2, name: "Rahul" }
]);
```

Update user:

```js
setUsers(users =>
  users.map(user =>
    user.id === 2
      ? { ...user, name: "Amit" }
      : user
  )
);
```

Notice the functional state update:

```js
setUsers(users => ...)
```

This is useful because the update is based on the previous state.

---

# 15. Removing an object from React state

```js
setUsers(users =>
  users.filter(user => user.id !== 2)
);
```

This means:

```text
Keep every user
except user with id 2
```

No mutation occurs.

---

# 16. Adding an object to React state

```js
setUsers(users => [
  ...users,
  {
    id: 3,
    name: "Amit"
  }
]);
```

Again:

```text
old array
   ↓
spread
   ↓
new array
   ↓
new user
```

---

# 17. Why `map()` and `filter()` are important for immutability

You've already learned:

```js
map()
filter()
```

Now understand why they're so useful in React.

### `map()`

Useful for **updating items**:

```js
users.map(user =>
  user.id === id
    ? { ...user, name: "New Name" }
    : user
);
```

### `filter()`

Useful for **removing items**:

```js
users.filter(user => user.id !== id);
```

### Spread

Useful for **adding items**:

```js
[
  ...users,
  newUser
]
```

So:

```text
Add
→ spread

Update
→ map

Remove
→ filter
```

This is worth memorizing.

---

# 18. What about `sort()`?

This is where you need to be careful.

`sort()` mutates the array.

Don't:

```js
products.sort(
  (a, b) => a.price - b.price
);
```

if `products` is React state.

Instead:

```js
const sortedProducts = [...products].sort(
  (a, b) => a.price - b.price
);
```

The spread creates a copy first.

Then `sort()` mutates the copy instead of your original state.

---

# 19. What about `reverse()`?

Same problem.

`reverse()` mutates the array.

Avoid:

```js
items.reverse();
```

Instead:

```js
const reversedItems = [...items].reverse();
```

---

# 20. What about `splice()`?

`splice()` mutates.

Avoid:

```js
items.splice(index, 1);
```

For React state, use:

```js
setItems(items =>
  items.filter((_, i) => i !== index)
);
```

---

# 21. Mutable vs immutable methods

### Common mutating methods

Be careful with:

```text
push()
pop()
shift()
unshift()
splice()
sort()
reverse()
```

These modify the original array.

### Common non-mutating approaches

```text
map()
filter()
slice()
concat()
[...array]
```

These can produce new arrays.

---

# 22. `slice()` vs `splice()`

Very important:

### `slice()`

Doesn't mutate.

```js
const copy = items.slice();
```

### `splice()`

Mutates.

```js
items.splice(1, 1);
```

Remember:

```text
slice
→ copy/extract
→ doesn't mutate

splice
→ modify/remove
→ mutates
```

---

# 23. Immutability does NOT mean data can never change

This is a common misunderstanding.

Immutability doesn't mean:

> "The data must never change."

It means:

> **Don't modify the existing object/array. Create a new version instead.**

Example:

```js
const user = {
  name: "Yash",
  age: 21
};
```

You can have:

```js
const updatedUser = {
  ...user,
  age: 22
};
```

The **application state changed**, but the old object wasn't mutated.

---

# 24. Shallow copy vs deep copy

This is extremely important.

Consider:

```js
const user = {
  name: "Yash",
  address: {
    city: "Pune"
  }
};
```

If you do:

```js
const copy = {
  ...user
};
```

you created a **shallow copy**.

The outer object is new:

```text
user ──→ Object A
copy ──→ Object B
```

But:

```text
Object A
   │
   └── address ──→ Object C
                       ↑
Object B               │
   │                   │
   └── address ─────────┘
```

Both still reference the same nested address object.

Therefore:

```js
user.address === copy.address;
```

is:

```text
true
```

---

# 25. Deep copying

A deep copy creates independent nested structures.

Modern JavaScript provides:

```js
const copy = structuredClone(user);
```

This can be useful when you genuinely need a deep clone.

But don't automatically deep clone everything in React.

Usually, you should create new references only along the part of the state tree you're changing.

For example:

```js
setUser({
  ...user,
  address: {
    ...user.address,
    city: "Mumbai"
  }
});
```

is usually preferable to cloning the entire state tree.

---

# 26. Practical React form example

Suppose:

```jsx
const [form, setForm] = useState({
  name: "",
  email: "",
  password: ""
});
```

Updating email:

```js
setForm(form => ({
  ...form,
  email: "yash@example.com"
}));
```

The old object remains unchanged.

---

# 27. Dynamic form update

From your earlier object notes:

```js
function handleChange(event) {
  const { name, value } = event.target;

  setForm(form => ({
    ...form,
    [name]: value
  }));
}
```

This is a perfect example of immutability.

Suppose:

```text
name = "email"
value = "yash@example.com"
```

Then:

```js
{
  ...form,
  [name]: value
}
```

creates:

```js
{
  name: "",
  email: "yash@example.com",
  password: ""
}
```

without modifying the previous state object.

---

# 28. Practical React cart example

Suppose:

```jsx
const [cart, setCart] = useState([
  {
    id: 1,
    name: "Laptop",
    quantity: 1
  },
  {
    id: 2,
    name: "Mouse",
    quantity: 1
  }
]);
```

Increase Laptop quantity:

```js
setCart(cart =>
  cart.map(item =>
    item.id === 1
      ? {
          ...item,
          quantity: item.quantity + 1
        }
      : item
  )
);
```

Flow:

```text
cart
 ↓
map()
 ↓
find id === 1
 ↓
create new item
 ↓
keep other items unchanged
 ↓
new array
 ↓
setCart()
 ↓
React re-renders
```

This is a **real-world React state update**.

---

# 29. Practical React todo example

Add:

```js
setTodos(todos => [
  ...todos,
  newTodo
]);
```

Update:

```js
setTodos(todos =>
  todos.map(todo =>
    todo.id === id
      ? { ...todo, completed: true }
      : todo
  )
);
```

Delete:

```js
setTodos(todos =>
  todos.filter(todo => todo.id !== id)
);
```

You can remember the entire pattern:

```text
CREATE
   ↓
[...old, new]

UPDATE
   ↓
map()

DELETE
   ↓
filter()
```

---

# 30. Why immutability helps debugging

Suppose you mutate objects everywhere:

```js
user.name = "Rahul";
cart.push(product);
items.sort();
```

Now the original data keeps changing.

When something goes wrong, it becomes difficult to answer:

> "When did this data change?"

With immutable updates:

```js
const updatedUser = {
  ...user,
  name: "Rahul"
};
```

you can reason about:

```text
old state
    ↓
operation
    ↓
new state
```

This makes state transitions easier to understand and debug.

---

# 31. Immutability and React rendering

React can use reference changes as an efficient signal that something may have changed.

For example:

```js
setUser({
  ...user,
  name: "Rahul"
});
```

creates a new reference.

React can see that the state value is different.

But if you do:

```js
user.name = "Rahul";
setUser(user);
```

you're passing the same object reference back.

This can lead to confusing behavior and breaks the assumptions behind React's state model.

---

# 32. Common mistake — mutating nested state

Bad:

```js
user.address.city = "Mumbai";

setUser(user);
```

Better:

```js
setUser(user => ({
  ...user,
  address: {
    ...user.address,
    city: "Mumbai"
  }
}));
```

---

# 33. Common mistake — mutating arrays

Bad:

```js
setItems(items => {
  items.push(newItem);
  return items;
});
```

Better:

```js
setItems(items => [
  ...items,
  newItem
]);
```

---

# 34. Common mistake — sorting state directly

Bad:

```js
setProducts(
  products.sort((a, b) => a.price - b.price)
);
```

Better:

```js
setProducts(products =>
  [...products].sort(
    (a, b) => a.price - b.price
  )
);
```

---

# 35. Immutability is not only a React concept

It is a broader programming principle.

You will encounter it in:

```text
React
Redux
State management
Functional programming
Concurrency
Caching
Memoization
Change detection
Debugging
```

React simply makes the concept especially important because state updates are expected to follow immutable patterns.

---

# 36. Interview Questions

### Q1. What is immutability?

The practice of not modifying an existing object or array directly, but creating a new value representing the updated state.

### Q2. Why is immutability important in React?

It makes state updates predictable and allows React and related tooling to efficiently detect changes through reference comparisons.

### Q3. How do you update an object immutably?

```js
setUser(user => ({
  ...user,
  name: "Rahul"
}));
```

### Q4. How do you add an item to an array?

```js
setItems(items => [
  ...items,
  newItem
]);
```

### Q5. How do you remove an item?

```js
setItems(items =>
  items.filter(item => item.id !== id)
);
```

### Q6. How do you update an item?

```js
setItems(items =>
  items.map(item =>
    item.id === id
      ? { ...item, completed: true }
      : item
  )
);
```

### Q7. Does spread create a deep copy?

No. Spread creates a **shallow copy**.

### Q8. Does `sort()` mutate?

Yes.

### Q9. Does `map()` mutate the original array?

No. It returns a new array.

---

# 37. Practice

Create `practice.js`:

```js
// 1. Create a user object.

// 2. Update the user's name without mutation.

// 3. Add a new property without mutation.

// 4. Create a nested user object.

// 5. Update the nested city immutably.

// 6. Create an array of products.

// 7. Add a product without mutation.

// 8. Remove a product without mutation.

// 9. Update a product's price without mutation.

// 10. Sort products without mutating the
//     original array.

// 11. Reverse an array without mutating it.

// 12. Create a React todo state.

// 13. Add a todo.

// 14. Complete a todo.

// 15. Delete a todo.

// 16. Explain why this is problematic:
//
//     items.push(newItem);
//     setItems(items);

// 17. Explain shallow copy vs deep copy.

// 18. Explain why this works:
//
//     setUser(user => ({
//       ...user,
//       address: {
//         ...user.address,
//         city: "Mumbai"
//       }
//     }));
```

---

# Quick Revision

```text
IMMUTABILITY
│
├── Don't directly modify existing state
│
├── Objects
│   └── { ...object, changedProperty: value }
│
├── Nested objects
│   └── spread each changed level
│
├── Arrays
│   ├── Add    → [...items, newItem]
│   ├── Update → map()
│   └── Delete → filter()
│
├── Avoid mutation
│   ├── push()
│   ├── pop()
│   ├── splice()
│   ├── sort()
│   └── reverse()
│
└── Spread
    └── shallow copy
```

### The pattern you should memorize

```text
ADD
→ spread

UPDATE
→ map + spread

DELETE
→ filter

SORT
→ [...items].sort()

NESTED UPDATE
→ spread every changed level
```

The most important React example:

```js
setTodos(todos =>
  todos.map(todo =>
    todo.id === id
      ? {
          ...todo,
          completed: !todo.completed
        }
      : todo
  )
);
```

Read it as:

```text
Previous todos
      ↓
Create a new array
      ↓
Find the todo
      ↓
Create a new todo object
      ↓
Change only completed
      ↓
Keep everything else unchanged
      ↓
React receives new state
```

> **Immutability is not "never change data." It is "don't mutate the existing value; create a new value that represents the change."**
