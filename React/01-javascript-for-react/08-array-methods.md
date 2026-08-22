# 08 — Array Methods

Arrays are **everywhere in React**.

Your backend might return:

```js
const products = [
  { id: 1, name: "Laptop", price: 65000 },
  { id: 2, name: "Mouse", price: 1200 },
  { id: 3, name: "Keyboard", price: 2500 }
];
```

React then needs to:

* display these products
* filter them
* search them
* transform their data
* find a particular product
* calculate totals
* remove items
* check conditions

That's why array methods are one of the **highest-value JavaScript topics for React**.

---

# 1. What is an Array?

An array stores multiple values in an ordered collection.

```js
const skills = [
  "Java",
  "Spring Boot",
  "React"
];
```

Each item has an index:

```text
index
  ↓

[ "Java", "Spring Boot", "React" ]
    0          1           2
```

Access:

```js
skills[0]; // Java
skills[1]; // Spring Boot
```

---

# 2. Why Array Methods?

Instead of manually writing loops:

```js
for (let i = 0; i < users.length; i++) {
  console.log(users[i]);
}
```

JavaScript gives us methods that express **what we want to do**:

```js
users.map(...)
users.filter(...)
users.find(...)
users.some(...)
users.every(...)
users.reduce(...)
```

This makes code easier to understand and is particularly useful in React.

---

# 3. The Most Important Array Methods

For React, prioritize these:

```text
map()
filter()
find()
findIndex()
some()
every()
reduce()
includes()
forEach()
sort()
```

The most important ones to master first are:

> **map → filter → find → some → reduce**

---

# 4. `map()`

`map()` creates a **new array by transforming every element**.

Example:

```js
const numbers = [1, 2, 3, 4];

const doubled = numbers.map(number => number * 2);

console.log(doubled);
```

Result:

```text
[2, 4, 6, 8]
```

Think:

```text
1 → 2
2 → 4
3 → 6
4 → 8
```

---

# 5. Why `map()` is extremely important in React

React uses `map()` to render lists.

Suppose:

```js
const users = [
  { id: 1, name: "Yash" },
  { id: 2, name: "Rahul" },
  { id: 3, name: "Amit" }
];
```

You can render them:

```jsx
function UserList() {
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

This is one of the **most important React patterns** you'll learn.

Conceptually:

```text
users
  ↓
map()
  ↓
User 1 → JSX
User 2 → JSX
User 3 → JSX
  ↓
React renders list
```

---

# 6. Why does React need `key`?

Notice:

```jsx
<p key={user.id}>
```

React uses `key` to identify elements in a list.

Prefer:

```jsx
key={user.id}
```

Avoid:

```jsx
key={Math.random()}
```

And don't use array indexes as keys when list items can be reordered, inserted, or deleted:

```jsx
key={index}
```

Use a stable unique identifier whenever possible.

---

# 7. `filter()`

`filter()` creates a new array containing only elements that satisfy a condition.

```js
const numbers = [1, 2, 3, 4, 5];

const evenNumbers = numbers.filter(
  number => number % 2 === 0
);
```

Result:

```text
[2, 4]
```

Think:

```text
1 → ❌
2 → ✅
3 → ❌
4 → ✅
5 → ❌
```

---

# 8. Practical React Example — Search/Filtering

Suppose:

```js
const products = [
  { id: 1, name: "Laptop", category: "Electronics" },
  { id: 2, name: "Shirt", category: "Clothing" },
  { id: 3, name: "Phone", category: "Electronics" }
];
```

Get only electronics:

```js
const electronics = products.filter(
  product => product.category === "Electronics"
);
```

Result:

```text
Laptop
Phone
```

In a React application, this could power a category filter.

---

# 9. `find()`

`find()` returns the **first element** that satisfies a condition.

```js
const users = [
  { id: 1, name: "Yash" },
  { id: 2, name: "Rahul" },
  { id: 3, name: "Amit" }
];

const user = users.find(
  user => user.id === 2
);
```

Result:

```js
{
  id: 2,
  name: "Rahul"
}
```

If nothing is found:

```js
const user = users.find(
  user => user.id === 99
);

console.log(user);
```

Result:

```text
undefined
```

---

# 10. `find()` vs `filter()`

This is a common interview question.

### `find()`

Returns one matching element:

```js
users.find(user => user.id === 2);
```

Result:

```text
{ id: 2, name: "Rahul" }
```

### `filter()`

Returns an array containing all matching elements:

```js
users.filter(user => user.role === "admin");
```

Result:

```text
[
  {...},
  {...}
]
```

Remember:

```text
find
→ one item

filter
→ multiple items
```

---

# 11. `findIndex()`

Returns the index of the first matching element.

```js
const users = [
  { id: 10, name: "Yash" },
  { id: 20, name: "Rahul" }
];

const index = users.findIndex(
  user => user.id === 20
);
```

Result:

```text
1
```

If nothing matches:

```text
-1
```

Useful when you need to locate an item before replacing it.

---

# 12. `some()`

`some()` checks whether **at least one** element satisfies a condition.

```js
const numbers = [1, 3, 5, 8];

const hasEvenNumber = numbers.some(
  number => number % 2 === 0
);
```

Result:

```text
true
```

Because `8` is even.

---

# 13. Practical React Example — Permissions

Suppose:

```js
const permissions = [
  "READ",
  "WRITE",
  "DELETE"
];
```

Check whether the user can delete:

```js
const canDelete = permissions.some(
  permission => permission === "DELETE"
);
```

Then:

```jsx
{canDelete && (
  <button>Delete</button>
)}
```

This is a realistic authorization/UI pattern.

---

# 14. `every()`

`every()` checks whether **all** elements satisfy a condition.

```js
const numbers = [2, 4, 6, 8];

const allEven = numbers.every(
  number => number % 2 === 0
);
```

Result:

```text
true
```

If one is odd:

```js
const numbers = [2, 4, 5, 8];
```

then:

```text
false
```

---

# 15. Practical use — Form validation

Suppose:

```js
const fields = [
  "Yash",
  "yash@example.com",
  "password123"
];
```

You could check:

```js
const allFilled = fields.every(
  field => field.trim() !== ""
);
```

This can be useful when validating forms.

---

# 16. `includes()`

Checks whether an array contains a value.

```js
const skills = [
  "Java",
  "React",
  "Spring Boot"
];

skills.includes("React");
```

Result:

```text
true
```

Example:

```js
const roles = ["USER", "ADMIN"];

const isAdmin = roles.includes("ADMIN");
```

Then:

```jsx
{isAdmin && <AdminPanel />}
```

---

# 17. `forEach()`

`forEach()` executes a function for every element.

```js
const users = ["Yash", "Rahul", "Amit"];

users.forEach(user => {
  console.log(user);
});
```

Output:

```text
Yash
Rahul
Amit
```

### Important difference

`forEach()` does **not** create a new transformed array.

So:

```js
const result = users.forEach(...);
```

does not give you the transformed array you might expect.

For transformations, use:

```js
map()
```

---

# 18. `map()` vs `forEach()`

This is important.

### `map()`

Use when you want a **new array**:

```js
const names = users.map(
  user => user.name
);
```

### `forEach()`

Use when you simply want to **perform an action**:

```js
users.forEach(user => {
  console.log(user.name);
});
```

Remember:

```text
map
→ transform → new array

forEach
→ perform action
```

---

# 19. `reduce()`

`reduce()` is used to combine an array into **one final value**.

This can be:

* number
* string
* object
* array
* anything you define

Example:

```js
const numbers = [10, 20, 30];

const total = numbers.reduce(
  (sum, number) => sum + number,
  0
);
```

Result:

```text
60
```

Think:

```text
0 + 10 = 10
10 + 20 = 30
30 + 30 = 60
```

---

# 20. Practical React Example — Cart Total

This is a very realistic example.

```js
const cart = [
  { name: "Laptop", price: 65000, quantity: 1 },
  { name: "Mouse", price: 1200, quantity: 2 },
  { name: "Keyboard", price: 2500, quantity: 1 }
];
```

Calculate total:

```js
const total = cart.reduce(
  (sum, item) =>
    sum + item.price * item.quantity,
  0
);
```

Result:

```text
69900
```

This pattern is extremely common in e-commerce applications.

---

# 21. `sort()`

`sort()` sorts an array.

For strings:

```js
const names = [
  "Yash",
  "Amit",
  "Rahul"
];

names.sort();
```

Result:

```text
["Amit", "Rahul", "Yash"]
```

For numbers, be careful.

This:

```js
[10, 2, 30].sort();
```

doesn't numerically sort the way beginners often expect.

Use:

```js
const numbers = [10, 2, 30];

numbers.sort((a, b) => a - b);
```

Ascending:

```text
[2, 10, 30]
```

Descending:

```js
numbers.sort((a, b) => b - a);
```

---

# 22. Important React warning — `sort()` mutates

Unlike `map()` and `filter()`, `sort()` **mutates the array**.

So if `products` is React state, don't blindly do:

```js
products.sort(...)
```

Instead:

```js
const sortedProducts = [...products].sort(
  (a, b) => a.price - b.price
);
```

Now you're sorting a copy.

This connects directly to what you learned about **spread + immutability**.

---

# 23. Chaining Array Methods

One of the most useful patterns in real React code is **method chaining**.

Suppose:

```js
const products = [
  { name: "Laptop", price: 65000 },
  { name: "Mouse", price: 1200 },
  { name: "Keyboard", price: 2500 }
];
```

Find products above ₹2000 and get their names:

```js
const result = products
  .filter(product => product.price > 2000)
  .map(product => product.name);
```

Result:

```text
["Laptop", "Keyboard"]
```

Conceptually:

```text
products
   ↓
filter()
   ↓
expensive products
   ↓
map()
   ↓
product names
```

This is very common in React.

---

# 24. Real React Example — Product List

```jsx
function ProductList({ products }) {
  const availableProducts = products.filter(
    product => product.stock > 0
  );

  return (
    <div>
      {availableProducts.map(product => (
        <div key={product.id}>
          <h2>{product.name}</h2>
          <p>₹{product.price}</p>
        </div>
      ))}
    </div>
  );
}
```

You've now combined:

```text
filter()
+
map()
+
objects
+
props
+
JSX
+
React keys
```

This is exactly the kind of connection your notes should emphasize.

---

# 25. Another Real Example — Search

Suppose:

```js
const products = [
  { id: 1, name: "Laptop" },
  { id: 2, name: "Mouse" },
  { id: 3, name: "Keyboard" }
];
```

Search for `"lap"`:

```js
const searchTerm = "lap";

const results = products.filter(product =>
  product.name
    .toLowerCase()
    .includes(searchTerm.toLowerCase())
);
```

Result:

```text
Laptop
```

This pattern can power a search box in a React application.

---

# 26. Don't use array methods blindly

Choose the method based on the goal:

```text
Want to transform every item?
→ map()

Want only matching items?
→ filter()

Want one matching item?
→ find()

Want its position?
→ findIndex()

Want to know if at least one matches?
→ some()

Want to know if all match?
→ every()

Want one final result?
→ reduce()

Want to check for a simple value?
→ includes()

Want to perform an action for each item?
→ forEach()
```

This decision table is worth memorizing.

---

# 27. Common Mistakes

### Mistake 1 — Using `map()` without returning

Wrong:

```js
const names = users.map(user => {
  user.name;
});
```

This produces:

```text
[undefined, undefined, undefined]
```

Correct:

```js
const names = users.map(user => {
  return user.name;
});
```

Or:

```js
const names = users.map(user => user.name);
```

---

### Mistake 2 — Using `map()` when you want filtering

Wrong:

```js
const activeUsers = users.map(
  user => user.active
);
```

That produces booleans.

Use:

```js
const activeUsers = users.filter(
  user => user.active
);
```

---

### Mistake 3 — Mutating state with `sort()`

Avoid:

```js
products.sort(...)
```

Prefer:

```js
[...products].sort(...)
```

---

### Mistake 4 — Using `find()` when multiple results are needed

```js
users.find(user => user.role === "ADMIN");
```

returns only the first matching user.

If you need all admins:

```js
users.filter(user => user.role === "ADMIN");
```

---

# 28. Interview Questions

### Q1. Difference between `map()` and `filter()`?

`map()` transforms every element and returns a new array.

`filter()` returns a new array containing only elements that satisfy a condition.

---

### Q2. Difference between `find()` and `filter()`?

```text
find()
→ first matching element

filter()
→ all matching elements in an array
```

---

### Q3. Does `map()` mutate the original array?

No. It returns a new array.

---

### Q4. Does `filter()` mutate the original array?

No. It returns a new array.

---

### Q5. Does `sort()` mutate the original array?

Yes.

---

### Q6. What does `reduce()` do?

It processes an array and accumulates its elements into a single result.

---

### Q7. Why is `map()` important in React?

Because React commonly uses it to transform arrays of data into arrays of JSX elements for rendering lists.

---

### Q8. Why do React lists need keys?

Keys help React identify which list items correspond to which elements when the list changes.

---

# 29. Practice

Create `practice.js`:

```js
// 1. Double every number using map().

// 2. Get only even numbers using filter().

// 3. Find a user by ID.

// 4. Find the index of a user.

// 5. Check whether at least one user is an admin.

// 6. Check whether all products are in stock.

// 7. Check whether an array contains "React".

// 8. Calculate the sum of an array using reduce().

// 9. Calculate an e-commerce cart total.

// 10. Sort products by price.

// 11. Create a new sorted array without
//     modifying the original.

// 12. Chain filter() and map().

// 13. Render an array of users in React.

// 14. Create a search function for products.

// 15. Explain when you would use:
//     map
//     filter
//     find
//     some
//     every
//     reduce
```

---

# Quick Revision

```text
ARRAY METHODS
│
├── map()
│   └── Transform every item
│
├── filter()
│   └── Keep matching items
│
├── find()
│   └── Find one item
│
├── findIndex()
│   └── Find item's index
│
├── some()
│   └── At least one?
│
├── every()
│   └── All?
│
├── reduce()
│   └── Produce one result
│
├── includes()
│   └── Does value exist?
│
├── forEach()
│   └── Perform an action
│
└── sort()
    └── Sort items
```

### The most important React connection

Remember this pattern:

```jsx
{products
  .filter(product => product.stock > 0)
  .map(product => (
    <ProductCard
      key={product.id}
      product={product}
    />
  ))}
```

Read it from top to bottom:

```text
products
   ↓
filter unavailable products
   ↓
map remaining products
   ↓
convert them into JSX
   ↓
React renders them
```

That is **real React thinking**: you're not just learning `map()`—you're learning how JavaScript data becomes UI.

**Next: `09-optional-chaining.md`** — particularly useful when working with API responses and nested objects that may not exist yet.
