# 07 — Objects

Objects are one of the **most important JavaScript concepts for React**.

In real React applications, a huge amount of data is represented as objects:

```text
API response
    ↓
Object

React props
    ↓
Object

User/Product data
    ↓
Object

Configuration
    ↓
Object

State
    ↓
Object
```

So don't learn objects as just `{ key: value }`. Learn **how you manipulate objects in real applications**.

---

## 1. What is an object?

An object stores related data as **key-value pairs**.

```js
const user = {
  name: "Yash",
  age: 21,
  role: "Developer"
};
```

Think of it as:

```text
user
 │
 ├── name → "Yash"
 ├── age  → 21
 └── role → "Developer"
```

Each property has:

```text
key → value
```

---

# 2. Why do we need objects?

Imagine storing a user without an object:

```js
const name = "Yash";
const age = 21;
const role = "Developer";
const city = "Pune";
```

This works, but these values aren't grouped together.

With an object:

```js
const user = {
  name: "Yash",
  age: 21,
  role: "Developer",
  city: "Pune"
};
```

Now you can pass the entire user around:

```js
sendUser(user);
```

This is much easier to manage.

---

# 3. Creating objects

Basic object:

```js
const user = {
  name: "Yash",
  age: 21
};
```

Empty object:

```js
const user = {};
```

Object with multiple data types:

```js
const product = {
  id: 101,
  name: "Laptop",
  price: 65000,
  available: true,
  tags: ["electronics", "computer"]
};
```

Objects can contain:

* strings
* numbers
* booleans
* arrays
* other objects
* functions

---

# 4. Accessing properties

### Dot notation

```js
const user = {
  name: "Yash",
  age: 21
};

console.log(user.name);
console.log(user.age);
```

This is the most common approach.

---

### Bracket notation

```js
console.log(user["name"]);
console.log(user["age"]);
```

Both produce the same result.

---

# 5. When is bracket notation useful?

Bracket notation becomes useful when the property name is dynamic.

```js
const user = {
  name: "Yash",
  age: 21
};

const property = "name";

console.log(user[property]);
```

Result:

```text
Yash
```

This is different from:

```js
user.property
```

which looks for a property literally called `"property"`.

---

# 6. Adding properties

You can add a property after creating an object:

```js
const user = {
  name: "Yash"
};

user.age = 21;
user.role = "Developer";
```

Now:

```js
console.log(user);
```

contains:

```js
{
  name: "Yash",
  age: 21,
  role: "Developer"
}
```

---

# 7. Updating properties

```js
const user = {
  name: "Yash",
  age: 21
};

user.age = 22;
```

Now:

```js
user.age;
```

is:

```text
22
```

But remember:

> Direct mutation is usually something you should avoid when dealing with React state.

For React state, you'll generally create a new object using spread:

```js
setUser({
  ...user,
  age: 22
});
```

---

# 8. Deleting properties

JavaScript provides `delete`:

```js
const user = {
  name: "Yash",
  age: 21,
  role: "Developer"
};

delete user.role;
```

Now:

```js
{
  name: "Yash",
  age: 21
}
```

However, don't use direct deletion on React state.

Instead, create a new object containing the properties you want to keep.

---

# 9. Nested objects

Objects can contain objects.

```js
const user = {
  name: "Yash",
  age: 21,

  address: {
    city: "Pune",
    country: "India"
  }
};
```

Access nested properties:

```js
user.address.city;
```

Result:

```text
Pune
```

Real-world API responses frequently look like this.

---

# 10. Objects containing arrays

Very common in applications:

```js
const user = {
  name: "Yash",

  skills: [
    "Java",
    "Spring Boot",
    "React"
  ]
};
```

Access:

```js
user.skills[0];
```

Result:

```text
Java
```

---

# 11. Objects containing functions

Objects can also contain functions.

```js
const user = {
  name: "Yash",

  greet() {
    console.log("Hello");
  }
};

user.greet();
```

The function is called a **method** when it is a property of an object.

---

# 12. Shorthand property syntax

Suppose:

```js
const name = "Yash";
const age = 21;
```

You could write:

```js
const user = {
  name: name,
  age: age
};
```

But JavaScript provides shorthand:

```js
const user = {
  name,
  age
};
```

This is extremely common in modern React code.

---

# 13. Computed property names

You can dynamically create property names.

```js
const field = "email";

const user = {
  [field]: "yash@example.com"
};
```

Result:

```js
{
  email: "yash@example.com"
}
```

This becomes useful when building dynamic forms.

For example:

```js
const fieldName = "username";
const value = "Yash";

const updatedUser = {
  ...user,
  [fieldName]: value
};
```

Now the property being updated depends on a variable.

This pattern is **very important for React forms**.

---

# 14. Objects and React props

React props are commonly represented as an object.

When you write:

```jsx
<UserCard
  name="Yash"
  age={21}
/>
```

Conceptually the component receives something similar to:

```js
{
  name: "Yash",
  age: 21
}
```

So:

```jsx
function UserCard(props) {
  return (
    <h2>{props.name}</h2>
  );
}
```

is accessing properties from an object.

And this:

```jsx
function UserCard({ name, age }) {
  return (
    <h2>{name}</h2>
  );
}
```

uses object destructuring.

That's why understanding objects is essential before going deeper into React.

---

# 15. Objects and API responses

Suppose your Spring Boot backend returns:

```json
{
  "id": 101,
  "name": "Pizza",
  "price": 299,
  "category": {
    "id": 5,
    "name": "Food"
  }
}
```

When React receives this JSON, it becomes JavaScript data that you commonly access as:

```js
product.name;
product.price;
product.category.name;
```

For example:

```jsx
function ProductCard({ product }) {
  return (
    <div>
      <h2>{product.name}</h2>
      <p>₹{product.price}</p>
      <span>{product.category.name}</span>
    </div>
  );
}
```

This is exactly the kind of object manipulation you'll perform when connecting your React frontend to your Spring Boot REST APIs.

---

# 16. Object destructuring

You already learned this, but now see why it matters.

Instead of:

```js
function ProductCard(product) {
  console.log(product.name);
  console.log(product.price);
}
```

you can write:

```js
function ProductCard({ name, price }) {
  console.log(name);
  console.log(price);
}
```

This is simply **object destructuring applied to React data**.

---

# 17. Spread and objects

You already learned:

```js
const updatedUser = {
  ...user,
  age: 22
};
```

This is one of the most important object patterns in React.

It creates a new object while preserving existing properties.

---

# 18. Object equality

This is an important JavaScript concept.

Consider:

```js
const user1 = {
  name: "Yash"
};

const user2 = {
  name: "Yash"
};

console.log(user1 === user2);
```

Result:

```text
false
```

Why?

Because objects are compared by **reference**, not by their contents.

They are two different objects in memory.

```text
user1 → Object A

user2 → Object B
```

Even though:

```text
Object A
{name: "Yash"}

Object B
{name: "Yash"}
```

they are different references.

---

# 19. Reference behavior

Consider:

```js
const user1 = {
  name: "Yash"
};

const user2 = user1;

user2.name = "Rahul";

console.log(user1.name);
```

Result:

```text
Rahul
```

Why?

Because both variables point to the same object.

```text
user1 ─────┐
           ↓
        Object
           ↑
user2 ─────┘
```

This is why accidental object mutation can cause bugs.

---

# 20. Shallow copying

Using spread:

```js
const user2 = {
  ...user1
};
```

Now:

```js
user1 === user2;
```

is:

```text
false
```

You have created a new outer object.

But nested objects are still shared.

```js
const user1 = {
  name: "Yash",
  address: {
    city: "Pune"
  }
};

const user2 = {
  ...user1
};
```

Then:

```js
user1.address === user2.address;
```

is:

```text
true
```

This is the reason nested React state requires careful updates.

---

# 21. Useful Object Methods

JavaScript provides several methods for working with objects.

### `Object.keys()`

Returns property names:

```js
const user = {
  name: "Yash",
  age: 21
};

Object.keys(user);
```

Result:

```text
["name", "age"]
```

---

### `Object.values()`

Returns property values:

```js
Object.values(user);
```

Result:

```text
["Yash", 21]
```

---

### `Object.entries()`

Returns key-value pairs:

```js
Object.entries(user);
```

Result:

```text
[
  ["name", "Yash"],
  ["age", 21]
]
```

These methods become useful when you need to dynamically process object data.

---

# 22. Practical React example — Form state

Suppose you're creating a registration form:

```jsx
const [form, setForm] = useState({
  name: "",
  email: "",
  password: ""
});
```

The form state is an object.

When the user enters their name:

```jsx
setForm({
  ...form,
  name: event.target.value
});
```

When they enter email:

```jsx
setForm({
  ...form,
  email: event.target.value
});
```

This is a very common real-world React pattern.

---

# 23. Better dynamic form update

Instead of creating separate handlers:

```jsx
function handleChange(event) {
  const { name, value } = event.target;

  setForm({
    ...form,
    [name]: value
  });
}
```

Now:

```jsx
<input
  name="email"
  value={form.email}
  onChange={handleChange}
/>
```

and:

```jsx
<input
  name="name"
  value={form.name}
  onChange={handleChange}
/>
```

can use the **same handler**.

This combines several concepts you've learned:

```text
Object
   ↓
Destructuring
   ↓
Spread
   ↓
Computed property
   ↓
React state
```

This is exactly how you should connect your notes to practical development.

---

# 24. Common mistakes

### Mistake 1 — Comparing objects with `===`

```js
{} === {};
```

Result:

```text
false
```

Because they are different references.

---

### Mistake 2 — Accidentally mutating objects

```js
user.name = "Rahul";
```

Fine for normal JavaScript in many situations, but don't directly mutate React state.

Use:

```js
setUser({
  ...user,
  name: "Rahul"
});
```

---

### Mistake 3 — Forgetting nested data

This:

```js
user.city
```

won't work if the structure is:

```js
user.address.city
```

Understand the actual object structure returned by your API.

---

# 25. When will I use objects in React?

Almost everywhere:

```text
Props
  ↓
State
  ↓
API responses
  ↓
Forms
  ↓
Authentication data
  ↓
Configuration
  ↓
Products
  ↓
Users
  ↓
Orders
  ↓
Cart
```

For example, an e-commerce product:

```js
const product = {
  id: 101,
  name: "Laptop",
  price: 65000,
  category: "Electronics",
  stock: 12,
  reviews: [
    {
      user: "Yash",
      rating: 5
    }
  ]
};
```

A real React application will constantly read, transform, update, and render data like this.

---

# 26. Interview Questions

### Q1. What is an object?

A collection of key-value pairs used to represent structured data.

### Q2. How do you access an object property?

```js
user.name;
```

or:

```js
user["name"];
```

### Q3. When would you use bracket notation?

When the property name is dynamic.

```js
const key = "name";

user[key];
```

### Q4. Are objects compared by value?

No. Objects are compared by reference.

### Q5. What does this do?

```js
const updatedUser = {
  ...user,
  name: "Rahul"
};
```

It creates a new object containing the existing properties of `user` and replaces `name`.

### Q6. What is a shallow copy?

A copy where the top-level structure is copied, but nested objects/arrays may still reference the originals.

### Q7. Why are objects important in React?

React uses objects extensively for props, state, API data, forms, configuration, and application models.

---

# 27. Practice

Create `practice.js` and solve these:

```js
// 1. Create a user object with:
//    name, age, email, city.

// 2. Access each property using dot notation.

// 3. Access a property using bracket notation.

// 4. Store "email" in a variable and use it
//    to access the email dynamically.

// 5. Add a new property.

// 6. Update a property.

// 7. Create a nested address object.

// 8. Create an array of three user objects.

// 9. Use Object.keys().

// 10. Use Object.values().

// 11. Use Object.entries().

// 12. Create a React product object.

// 13. Create a React form state object.

// 14. Write a handleChange() function that
//     dynamically updates the form.

// 15. Explain why this is false:
//
//     { name: "Yash" } === { name: "Yash" }
```

---

# Quick Revision

```text
OBJECT
│
├── key → value
│
├── Access
│   ├── user.name
│   └── user["name"]
│
├── Nested objects
│   └── user.address.city
│
├── Methods
│   ├── Object.keys()
│   ├── Object.values()
│   └── Object.entries()
│
├── Spread
│   └── { ...user }
│
├── Destructuring
│   └── const { name } = user
│
└── React
    ├── Props
    ├── State
    ├── Forms
    ├── API responses
    └── Application data
```

### The one thing to remember

> **Objects are the primary way JavaScript represents structured application data. In React, props, state, API responses, forms, users, products, and configuration are very often objects.**

And this is a particularly important pattern to recognize:

```jsx
function handleChange(event) {
  const { name, value } = event.target;

  setForm({
    ...form,
    [name]: value
  });
}
```

You've now seen **destructuring + spread + computed properties + React state** working together in one real-world pattern.

**Next: `08-array-methods.md`** — this is a major practical topic because React uses arrays constantly, especially for rendering lists and transforming API data.
