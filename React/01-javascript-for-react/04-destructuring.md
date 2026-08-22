# 04 — Destructuring

Destructuring is one of the **most important JavaScript features for React** because you'll constantly use it with **props, API responses, objects, arrays, and state**.

The key idea is:

> **Destructuring lets you extract values from objects or arrays into variables in a clean way.**

---

## 1. Why do we need destructuring?

Suppose you have:

```js
const user = {
  name: "Yash",
  age: 21,
  email: "yash@example.com"
};
```

Without destructuring:

```js
console.log(user.name);
console.log(user.age);
console.log(user.email);
```

With destructuring:

```js
const { name, age, email } = user;

console.log(name);
console.log(age);
console.log(email);
```

Instead of repeatedly writing:

```js
user.name
user.age
user.email
```

you extract the values once.

---

# 2. Object destructuring

Basic syntax:

```js
const user = {
  name: "Yash",
  age: 21
};

const { name, age } = user;
```

Now:

```js
console.log(name); // Yash
console.log(age);  // 21
```

Think of it as:

```text
user
 ├── name ──→ name
 └── age  ──→ age
```

---

# 3. Destructuring with different variable names

Suppose you don't want the variable to be called `name`.

```js
const user = {
  name: "Yash",
  age: 21
};

const { name: userName, age: userAge } = user;

console.log(userName);
console.log(userAge);
```

Syntax:

```js
const { propertyName: newVariableName } = object;
```

This is useful when two objects have properties with the same name.

---

# 4. Default values

You can provide a fallback.

```js
const user = {
  name: "Yash"
};

const { name, role = "User" } = user;

console.log(name); // Yash
console.log(role); // User
```

This is particularly useful when working with optional API data.

---

# 5. Nested destructuring

Objects can contain other objects.

```js
const user = {
  name: "Yash",
  address: {
    city: "Pune",
    country: "India"
  }
};
```

You can destructure:

```js
const {
  name,
  address: { city, country }
} = user;
```

Now:

```js
console.log(name);
console.log(city);
console.log(country);
```

---

# 6. Array destructuring

Destructuring isn't limited to objects.

Consider:

```js
const colors = ["red", "green", "blue"];
```

Without destructuring:

```js
const first = colors[0];
const second = colors[1];
```

With destructuring:

```js
const [first, second, third] = colors;
```

Now:

```js
console.log(first);  // red
console.log(second); // green
console.log(third);  // blue
```

### Important difference

Objects use **property names**:

```js
const { name } = user;
```

Arrays use **position**:

```js
const [first, second] = colors;
```

---

# 7. Skipping array values

You can skip values using commas.

```js
const numbers = [10, 20, 30];

const [first, , third] = numbers;

console.log(first); // 10
console.log(third); // 30
```

The second value is ignored.

---

# 8. Rest with destructuring

You can collect remaining values.

```js
const numbers = [10, 20, 30, 40];

const [first, ...remaining] = numbers;

console.log(first);
console.log(remaining);
```

Result:

```js
first
// 10

remaining
// [20, 30, 40]
```

You'll learn the broader `...rest` concept in the next topic.

---

# 9. Destructuring function parameters

This is **extremely important in React**.

Suppose:

```js
function printUser(user) {
  console.log(user.name);
  console.log(user.email);
}
```

You can destructure the parameter:

```js
function printUser({ name, email }) {
  console.log(name);
  console.log(email);
}
```

Calling it:

```js
printUser({
  name: "Yash",
  email: "yash@example.com"
});
```

This is cleaner when a function only needs certain properties.

---

# 10. The most important React example — props

Suppose you have:

```jsx
function UserCard(props) {
  return (
    <div>
      <h2>{props.name}</h2>
      <p>{props.email}</p>
    </div>
  );
}
```

You can destructure the props:

```jsx
function UserCard({ name, email }) {
  return (
    <div>
      <h2>{name}</h2>
      <p>{email}</p>
    </div>
  );
}
```

This is one of the most common patterns you'll see in React.

### What's actually happening?

When React calls the component, conceptually it gives it an object:

```js
{
  name: "Yash",
  email: "yash@example.com"
}
```

You are extracting those properties directly:

```js
function UserCard({ name, email }) {
```

So:

```text
Props object
     ↓
{ name, email }
     ↓
Local variables
     ↓
JSX
```

---

# 11. Destructuring props with more properties

```jsx
function ProductCard({
  name,
  price,
  image,
  category
}) {
  return (
    <div>
      <img src={image} alt={name} />
      <h2>{name}</h2>
      <p>{category}</p>
      <strong>₹{price}</strong>
    </div>
  );
}
```

This is much easier to read than:

```jsx
function ProductCard(props) {
  return (
    <div>
      <img src={props.image} alt={props.name} />
      <h2>{props.name}</h2>
      <p>{props.category}</p>
      <strong>₹{props.price}</strong>
    </div>
  );
}
```

Both are correct.

The destructured version is often preferred when you use several props.

---

# 12. Destructuring API responses

Suppose your backend returns:

```js
const response = {
  data: {
    id: 101,
    name: "Pizza",
    price: 299
  },
  status: 200
};
```

You can do:

```js
const { data, status } = response;
```

Then:

```js
const { id, name, price } = data;
```

This pattern becomes very useful when working with:

* REST APIs
* Axios
* Fetch
* Spring Boot APIs
* JSON responses

For your React + Spring Boot projects, you'll encounter this constantly.

---

# 13. Destructuring with `useState`

You'll eventually see:

```jsx
const [count, setCount] = useState(0);
```

This is **array destructuring**.

`useState()` returns an array conceptually like:

```js
[
  currentValue,
  functionToUpdateValue
]
```

So:

```js
const [count, setCount] = useState(0);
```

means:

```text
First value
    ↓
count

Second value
    ↓
setCount
```

This is a major example of JavaScript destructuring directly appearing in React.

---

# 14. Destructuring `useContext`

Later, you'll also see patterns such as:

```jsx
const { user, logout } = useContext(AuthContext);
```

The hook returns an object:

```js
{
  user: ...,
  logout: ...
}
```

You extract the values you need.

Again:

**JavaScript destructuring → React code.**

---

# 15. Renaming props

Suppose your prop is:

```jsx
<UserCard name="Yash" />
```

You can rename it:

```jsx
function UserCard({ name: userName }) {
  return <h2>{userName}</h2>;
}
```

Here:

```text
name
 ↓
userName
```

This is useful when the local variable name needs to be more specific.

---

# 16. Default props using destructuring

You can combine destructuring with defaults:

```jsx
function Button({
  text = "Submit",
  type = "button"
}) {
  return (
    <button type={type}>
      {text}
    </button>
  );
}
```

Now:

```jsx
<Button />
```

produces a button with:

```text
Submit
```

while:

```jsx
<Button text="Login" />
```

produces:

```text
Login
```

---

# 17. Common mistake — destructuring a missing object

This can cause an error:

```js
const user = undefined;

const { name } = user;
```

You'll get an error because you can't destructure `undefined`.

This is where other JavaScript features you'll learn later become useful:

```js
user?.name
```

or appropriate default values.

---

# 18. Common mistake — confusing object and array destructuring

Object:

```js
const { name } = user;
```

Array:

```js
const [first] = users;
```

Remember:

```text
{} → object → property names

[] → array → positions
```

This is worth memorizing.

---

# 19. When should I use destructuring?

Use it when you need specific values from an object or array.

Very common situations:

```text
React props
API responses
useState
useContext
Function parameters
Configuration objects
Array results
Nested data
```

For example:

```jsx
function Profile({ user, onLogout }) {
  const { name, email } = user;

  return (
    <div>
      <h2>{name}</h2>
      <p>{email}</p>

      <button onClick={onLogout}>
        Logout
      </button>
    </div>
  );
}
```

This is **real-world React code**, not just JavaScript practice.

---

# 20. Interview questions

### Q1. What is destructuring?

A JavaScript syntax that allows values to be extracted from objects or arrays into variables.

### Q2. Difference between object and array destructuring?

```js
const { name } = user;
```

uses object properties.

```js
const [first, second] = users;
```

uses array positions.

### Q3. Can you rename a destructured property?

Yes.

```js
const { name: userName } = user;
```

### Q4. Can destructuring have default values?

Yes.

```js
const { role = "User" } = user;
```

### Q5. Why is destructuring common in React?

Because React frequently works with objects and arrays, especially props, state, context values, and API responses.

### Q6. What is this?

```jsx
const [count, setCount] = useState(0);
```

It is array destructuring of the value returned by `useState()`.

---

# 21. Practice

Create `practice.js` and solve these yourself:

```js
// 1. Create a user object and destructure name and email.

// 2. Rename name to userName.

// 3. Give role a default value.

// 4. Destructure a nested address object.

// 5. Destructure the first and third values
//    from an array.

// 6. Use rest syntax to collect remaining array values.

// 7. Create a function that destructures its parameter.

// 8. Create a React component that destructures props.

// 9. Create a ProductCard component using destructured props.

// 10. Write:
//     const [count, setCount] = useState(0)
//     and explain exactly what is being destructured.
```

---

# Quick revision

```text
DESTRUCTURING
│
├── Object
│   └── const { name } = user
│
├── Array
│   └── const [first, second] = users
│
├── Rename
│   └── const { name: userName } = user
│
├── Default value
│   └── const { role = "User" } = user
│
├── Function parameters
│   └── function User({ name }) {}
│
└── React
    ├── Props
    ├── useState
    ├── useContext
    └── API responses
```

### The one thing to remember

> **Destructuring is mainly about extracting the data you need from objects and arrays. In React, you'll use it constantly with props, hooks, and API data.**

**Next: `05-spread-and-rest.md`** — this is especially important for React because the **spread operator is heavily used when updating state immutably**.
