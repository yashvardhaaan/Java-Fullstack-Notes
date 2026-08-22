# 06 — Template Literals

Template literals are used to create **dynamic strings** more cleanly.

They are especially useful in React when you need to combine:

* variables with text
* API URLs
* dynamic messages
* CSS class names
* dynamic paths
* user information

---

## 1. What are Template Literals?

Traditional JavaScript strings use:

```js
const name = "Yash";

const message = "Hello " + name;
```

Template literals use **backticks**:

```js
const name = "Yash";

const message = `Hello ${name}`;
```

Result:

```text
Hello Yash
```

The syntax is:

```js
`text ${expression} text`
```

---

# 2. Why do we need them?

Without template literals:

```js
const name = "Yash";
const age = 21;

const message =
  "My name is " + name + " and I am " + age + " years old.";
```

This quickly becomes difficult to read.

With template literals:

```js
const message = `My name is ${name} and I am ${age} years old.`;
```

Much cleaner.

### Practical rule

> Whenever you need to insert JavaScript values inside a string, template literals are usually the cleanest approach.

---

# 3. `${}` — Expression interpolation

The `${}` syntax allows you to insert a JavaScript expression.

```js
const price = 500;
const quantity = 2;

const total = `Total: ₹${price * quantity}`;

console.log(total);
```

Result:

```text
Total: ₹1000
```

It's not limited to variables.

You can use:

```js
`${10 + 20}`
```

```js
`${user.name}`
```

```js
`${isLoggedIn ? "Logout" : "Login"}`
```

---

# 4. Using object properties

```js
const user = {
  name: "Yash",
  role: "Developer"
};

const message = `${user.name} is a ${user.role}`;
```

Result:

```text
Yash is a Developer
```

This is very common when displaying dynamic data.

---

# 5. Using functions

Expressions inside `${}` can call functions.

```js
function getGreeting() {
  return "Hello";
}

const name = "Yash";

const message = `${getGreeting()}, ${name}!`;
```

Result:

```text
Hello, Yash!
```

---

# 6. Multiline strings

Before template literals, multiline strings were inconvenient.

```js
const message =
  "Hello Yash\n" +
  "Welcome to React\n" +
  "Keep learning!";
```

Template literals:

```js
const message = `
Hello Yash
Welcome to React
Keep learning!
`;
```

The line breaks are preserved.

This can be useful for:

* generated text
* SQL/query strings
* long messages
* templates
* debugging output

---

# 7. Template literals in React

React frequently displays dynamic values.

For example:

```jsx
function Welcome({ name }) {
  return (
    <h1>{`Welcome, ${name}!`}</h1>
  );
}
```

If:

```text
name = "Yash"
```

the result is:

```text
Welcome, Yash!
```

However, notice that React already lets you write:

```jsx
<h1>Welcome, {name}!</h1>
```

So you don't always need a template literal inside JSX.

### Practical rule

Use normal JSX interpolation when the text is simple:

```jsx
<h1>Welcome, {name}</h1>
```

Use a template literal when you're actually constructing a JavaScript string:

```js
const message = `Welcome, ${name}!`;
```

---

# 8. Dynamic API URLs

This is a very practical use.

Suppose your backend endpoint is:

```text
/api/users/{id}
```

Instead of:

```js
const url = "/api/users/" + userId;
```

use:

```js
const url = `/api/users/${userId}`;
```

For example:

```js
const userId = 101;

const url = `/api/users/${userId}`;

console.log(url);
```

Result:

```text
/api/users/101
```

This becomes particularly useful when connecting your React frontend to a Spring Boot backend.

---

# 9. Dynamic search URLs

Suppose your application searches products:

```js
const searchTerm = "laptop";

const url = `/api/products?search=${searchTerm}`;
```

Result:

```text
/api/products?search=laptop
```

For more complex URLs, you'll later learn about URL encoding and `URLSearchParams`.

---

# 10. Dynamic CSS classes

Template literals can be useful when constructing class names.

```jsx
const isActive = true;

const className = `button ${isActive ? "active" : "inactive"}`;
```

Result:

```text
button active
```

Then:

```jsx
<button className={className}>
  Submit
</button>
```

You'll see this pattern in React applications.

For more complex conditional classes, libraries such as `clsx` are often used, but understanding template literals first is important.

---

# 11. Dynamic messages

Suppose you're building an e-commerce application.

```js
const product = "Laptop";
const quantity = 2;

const message =
  `${quantity} ${product}s added to your cart.`;
```

Result:

```text
2 Laptops added to your cart.
```

Or:

```js
const total = 2499;

const message = `Your total is ₹${total}`;
```

---

# 12. Template literals with conditions

You can use the ternary operator inside `${}`:

```js
const isLoggedIn = true;

const message = `Status: ${
  isLoggedIn ? "Logged In" : "Logged Out"
}`;
```

Result:

```text
Status: Logged In
```

This is useful for dynamic UI messages.

---

# 13. Template literals with calculations

```js
const price = 1000;
const discount = 100;

const finalPrice = `Final price: ₹${price - discount}`;
```

Result:

```text
Final price: ₹900
```

The expression inside `${}` is evaluated first.

---

# 14. React example — User profile

```jsx
function Profile({ user }) {
  const message =
    `${user.name} is from ${user.city}`;

  return (
    <div>
      <h2>{user.name}</h2>
      <p>{message}</p>
    </div>
  );
}
```

Given:

```js
const user = {
  name: "Yash",
  city: "Pune"
};
```

the UI displays:

```text
Yash
Yash is from Pune
```

---

# 15. React example — API call

Suppose your Spring Boot backend exposes:

```text
GET /api/users/{id}
```

You could write:

```js
async function getUser(userId) {
  const response = await fetch(
    `http://localhost:8080/api/users/${userId}`
  );

  return response.json();
}
```

If:

```js
getUser(101);
```

the request becomes:

```text
http://localhost:8080/api/users/101
```

This is a **real-world use case** you'll encounter when connecting React with Spring Boot.

---

# 16. Template literals vs string concatenation

### Concatenation

```js
const name = "Yash";
const age = 21;

const message =
  "My name is " + name + " and I am " + age;
```

### Template literal

```js
const message =
  `My name is ${name} and I am ${age}`;
```

Prefer template literals when constructing strings with multiple dynamic values.

---

# 17. Important: Backticks are not quotes

These are different:

```js
"Hello"
```

```js
'Hello'
```

```js
`Hello`
```

Only template literals use:

```text
`
```

which is the **backtick**, usually found near the `Esc` key on a standard keyboard.

---

# 18. Common mistakes

### Mistake 1 — Using quotes instead of backticks

Wrong:

```js
const message = "Hello ${name}";
```

Result:

```text
Hello ${name}
```

Correct:

```js
const message = `Hello ${name}`;
```

Result:

```text
Hello Yash
```

---

### Mistake 2 — Forgetting `${}`

Wrong:

```js
const message = `Hello name`;
```

Correct:

```js
const message = `Hello ${name}`;
```

---

### Mistake 3 — Overusing template literals in JSX

This:

```jsx
<h1>{`Hello ${name}`}</h1>
```

works, but this is simpler:

```jsx
<h1>Hello {name}</h1>
```

Don't use template literals just because you can.

---

# 19. When should I use them?

Use template literals when you're constructing dynamic strings.

Common situations:

```text
Dynamic messages
       ↓
API URLs
       ↓
Query strings
       ↓
File paths
       ↓
CSS class names
       ↓
Logging/debugging
       ↓
Generated text
```

In your React + Spring Boot projects, one particularly useful pattern will be:

```js
const API_URL = "http://localhost:8080/api";

const endpoint = `${API_URL}/users/${userId}`;
```

Later, you'll learn how to move the base URL into environment variables so you don't hard-code it.

---

# 20. Interview Questions

### Q1. What are template literals?

A JavaScript string syntax using backticks that supports interpolation and multiline strings.

### Q2. How do you insert a variable?

```js
`Hello ${name}`
```

### Q3. Can expressions be used inside `${}`?

Yes.

```js
`${price * quantity}`
```

### Q4. What is the difference between template literals and string concatenation?

Template literals provide a cleaner syntax for embedding expressions and creating multiline strings.

### Q5. Why are template literals useful in React?

They are useful for constructing dynamic strings such as API URLs, messages, class names, and other values generated from application data.

---

# 21. Practice

Create `practice.js`:

```js
// 1. Create a message using your name and age.

// 2. Create a string using two object properties.

// 3. Calculate a product's total price inside ${}.

// 4. Create a dynamic API URL using an ID.

// 5. Create a dynamic search URL.

// 6. Create a message based on a boolean value.

// 7. Create a dynamic CSS class.

// 8. Create a React component that displays:
//    "Welcome, <name>!"

// 9. Create a function that generates:
//    "/api/products/<id>"

// 10. Rewrite 3 string-concatenation examples
//     using template literals.
```

---

# Quick Revision

```text
TEMPLATE LITERALS
        │
        ├── Backticks `
        │
        ├── ${expression}
        │
        ├── Dynamic strings
        │
        ├── Multiline strings
        │
        ├── API URLs
        │
        ├── Dynamic messages
        │
        └── CSS class names
```

### The one thing to remember

> **Template literals let you embed JavaScript expressions directly inside strings using backticks and `${}`.**

For React, remember this practical example:

```js
const endpoint = `/api/users/${userId}`;
```

**Next: `07-objects.md`** — we'll go deeper into objects because objects are the foundation for **props, API data, state, configuration, and most real-world React data**.
