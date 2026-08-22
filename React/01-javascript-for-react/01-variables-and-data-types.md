Next, I’d do **`01-variables-and-data-types.md`** first because it establishes the foundation for everything else.

For your documentation, use this style:

# `01-variables-and-data-types.md`

### 1. What is a variable?

A variable is a named reference used to store a value so that the program can use that value later.

```js
const name = "Yash";
let age = 21;
```

### 2. `let` vs `const` vs `var`

```js
const name = "Yash";
let age = 21;

age = 22;
```

* `const` → use when the variable should not be reassigned.
* `let` → use when the variable needs to be reassigned.
* `var` → old JavaScript; generally avoid it in modern React applications.

**Practical React rule:**

```js
const user = {
  name: "Yash"
};

let count = 0;
```

Prefer `const` by default. Use `let` only when reassignment is actually required.

---

### 3. JavaScript data types

#### Primitive types

```js
const name = "Yash";       // String
const age = 21;            // Number
const isLoggedIn = true;   // Boolean
const value = null;        // Null
let result;                // Undefined
const id = 123456789n;     // BigInt
const symbol = Symbol();   // Symbol
```

The main ones you'll use constantly in React are:

```text
String
Number
Boolean
null
undefined
Object
Array
```

---

### 4. Objects

Objects represent structured data.

```js
const user = {
  name: "Yash",
  age: 21,
  role: "Developer"
};
```

Access values:

```js
user.name;
user.age;
```

This becomes extremely important in React because **props, API responses, configuration, and application data are commonly represented as objects.**

---

### 5. Arrays

Arrays store multiple values.

```js
const fruits = ["Apple", "Mango", "Banana"];
```

Access:

```js
fruits[0]; // Apple
```

In React, arrays are particularly important because you frequently render them using `.map()`:

```jsx
const users = ["Yash", "Rahul", "Amit"];

function UserList() {
  return (
    <ul>
      {users.map((user) => (
        <li key={user}>{user}</li>
      ))}
    </ul>
  );
}
```

---

### 6. `typeof`

Use `typeof` to determine the type of a value.

```js
typeof "hello";    // "string"
typeof 10;         // "number"
typeof true;       // "boolean"
typeof undefined;  // "undefined"
typeof {};         // "object"
typeof [];         // "object"
```

Important JavaScript oddity:

```js
typeof null; // "object"
```

This is a historical JavaScript behavior.

---

### 7. Truthy and Falsy values

JavaScript converts values to `true` or `false` in conditions.

Falsy values include:

```js
false
0
""
null
undefined
NaN
```

Example:

```js
const username = "";

if (username) {
  console.log("User exists");
}
```

In React this is commonly encountered with conditional rendering:

```jsx
{isLoggedIn && <Dashboard />}
```

If `isLoggedIn` is `true`, the dashboard is rendered.

---

### 8. `==` vs `===`

Prefer:

```js
5 === 5; // true
```

Avoid relying on:

```js
5 == "5"; // true
```

`===` checks both **value and type**.

```js
5 === "5"; // false
```

For modern React/JavaScript development:

> **Use `===` and `!==` by default.**

---

### 9. Why this matters in React

React applications constantly work with JavaScript values:

```js
const user = {
  name: "Yash",
  loggedIn: true,
  skills: ["Java", "React", "Spring Boot"]
};
```

React then uses these values to determine what appears on the screen:

```jsx
function Profile() {
  return (
    <div>
      <h2>{user.name}</h2>

      {user.loggedIn && <p>Online</p>}

      {user.skills.map((skill) => (
        <span key={skill}>{skill}</span>
      ))}
    </div>
  );
}
```

So learning variables and data types isn't separate from React. **React is heavily dependent on your ability to manipulate JavaScript data correctly.**

---

### 10. Common mistakes

**Mistake 1 — Using `var` unnecessarily**

```js
var name = "Yash";
```

Prefer:

```js
const name = "Yash";
```

**Mistake 2 — Reassigning a `const`**

```js
const count = 10;
count = 20; // Error
```

**Mistake 3 — Confusing `null` and `undefined**

```js
let user;        // undefined
let user = null; // intentionally empty
```

**Mistake 4 — Using `==` when you expect strict comparison**

```js
0 == false;  // true
0 === false; // false
```

---

### 11. Interview questions

**Q: Difference between `let`, `const`, and `var`?**

Know these concepts:

* Scope
* Reassignment
* Redeclaration
* Hoisting
* Temporal Dead Zone

**Q: Is an array an object in JavaScript?**

Yes.

```js
typeof []; // "object"
```

Arrays are specialized objects.

**Q: What is the difference between `null` and `undefined`?**

`undefined` generally means a value hasn't been assigned, while `null` is commonly used to explicitly represent "no value."

---

### 12. Practice

Don't just read this file. Create a small `practice.js` and do:

```js
const user = {
  name: "Yash",
  age: 21,
  isLoggedIn: true,
  skills: ["Java", "Spring Boot", "React"]
};
```

Then practice:

```js
// 1. Print the user's name

// 2. Print the user's age

// 3. Check whether the user is logged in

// 4. Print all skills

// 5. Add another skill

// 6. Create another user

// 7. Compare two values using ==

// 8. Compare the same values using ===

// 9. Check the type of each property
```

The important part is that your documentation should contain **both the explanation and the reason you'd use the concept in real React code**.
