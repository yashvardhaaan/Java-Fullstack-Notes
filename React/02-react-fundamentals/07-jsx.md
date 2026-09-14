# 07 — JSX

## WHY?

### Why do we use JSX in React?

Without JSX, React UI can be written using JavaScript function calls, which can become difficult to read.

For example, without JSX:

```javascript
const element = React.createElement(
  "h1",
  null,
  "Hello World"
);
```

With JSX:

```jsx
const element = <h1>Hello World</h1>;
```

JSX makes the UI structure much easier to understand.

### Main reasons for JSX

* Makes UI code readable
* Allows HTML-like syntax inside JavaScript
* Makes components easier to write
* Allows JavaScript expressions directly inside UI
* Helps keep UI and its related logic together

---

# WHAT?

## What is JSX?

**JSX stands for JavaScript XML.**

It is a **syntax extension for JavaScript** commonly used with React to describe UI.

Example:

```jsx
function App() {
  return <h1>Hello React</h1>;
}
```

The important point is:

> JSX is not HTML and it is not a separate programming language.

It is syntax that is transformed into JavaScript that React can use.

---

# WHERE?

## Where do we use JSX?

JSX is commonly used inside React component files:

```text
src/
│
├── App.jsx
├── main.jsx
└── components/
    └── Navbar.jsx
```

Example:

```jsx
function Navbar() {
  return (
    <nav>
      <h1>My Website</h1>
    </nav>
  );
}

export default Navbar;
```

---

# HOW?

## How does JSX work?

Consider:

```jsx
const element = <h1>Hello</h1>;
```

Conceptually, JSX is transformed into JavaScript that creates a React element.

You can think of it as:

```text
JSX
 ↓
Transformation
 ↓
JavaScript
 ↓
React element
 ↓
React rendering
 ↓
DOM
```

You generally write JSX rather than manually writing the equivalent React function calls.

---

# JavaScript Inside JSX

One of the most important features of JSX is that JavaScript **expressions** can be written inside `{}`.

Example:

```jsx
function App() {
  const name = "Yash";

  return <h1>Hello {name}</h1>;
}
```

Output:

```text
Hello Yash
```

---

## Variables

```jsx
function App() {
  const age = 22;

  return <p>Age: {age}</p>;
}
```

---

## Expressions

You can use expressions:

```jsx
function App() {
  const a = 10;
  const b = 20;

  return <p>Total: {a + b}</p>;
}
```

Output:

```text
Total: 30
```

---

## Conditional Expression

```jsx
function App() {
  const isLoggedIn = true;

  return (
    <h1>
      {isLoggedIn ? "Dashboard" : "Login"}
    </h1>
  );
}
```

If:

```text
isLoggedIn = true
```

Output:

```text
Dashboard
```

If:

```text
isLoggedIn = false
```

Output:

```text
Login
```

---

# HOW TO RENDER ARRAYS?

JSX works very well with JavaScript array methods such as `map()`.

```jsx
function Users() {
  const users = ["Yash", "Rahul", "Amit"];

  return (
    <ul>
      {users.map(user => (
        <li key={user}>{user}</li>
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

Here:

```text
JavaScript
    ↓
users.map()
    ↓
JSX elements
    ↓
React UI
```

---

# JSX ATTRIBUTE SYNTAX

JSX uses attribute-like syntax.

HTML:

```html
<button class="btn">
  Login
</button>
```

JSX:

```jsx
<button className="btn">
  Login
</button>
```

### Important difference

In JSX, some HTML attributes use JavaScript-style names.

For example:

```text
HTML       → JSX

class      → className
for        → htmlFor
onclick    → onClick
tabindex   → tabIndex
```

---

# HOW TO ADD JAVASCRIPT VALUES TO ATTRIBUTES?

Use `{}`.

```jsx
function App() {
  const imageUrl = "/logo.png";

  return (
    <img
      src={imageUrl}
      alt="Logo"
    />
  );
}
```

Here:

```text
src={imageUrl}
```

means the value of the JavaScript variable `imageUrl` is used.

---

# JSX MUST HAVE ONE PARENT

## WHY?

A component returns a React element tree.

You cannot normally return multiple sibling JSX elements without wrapping them.

❌ Incorrect:

```jsx
function App() {
  return (
    <h1>Hello</h1>
    <p>Welcome</p>
  );
}
```

✅ Correct:

```jsx
function App() {
  return (
    <div>
      <h1>Hello</h1>
      <p>Welcome</p>
    </div>
  );
}
```

Or use a Fragment:

```jsx
function App() {
  return (
    <>
      <h1>Hello</h1>
      <p>Welcome</p>
    </>
  );
}
```

---

# WHAT IS A FRAGMENT?

## WHY?

Sometimes you need a parent wrapper but don't want an additional HTML element in the DOM.

Instead of:

```jsx
<div>
  <h1>Hello</h1>
  <p>World</p>
</div>
```

you can use:

```jsx
<>
  <h1>Hello</h1>
  <p>World</p>
</>
```

This is a React Fragment.

---

# JSX COMMENTS

JSX comments are written inside JavaScript comment syntax:

```jsx
function App() {
  return (
    <div>
      {/* This is a JSX comment */}
      <h1>Hello</h1>
    </div>
  );
}
```

---

# JSX vs HTML

| HTML                               | JSX                                 |
| ---------------------------------- | ----------------------------------- |
| Used to describe web documents     | Used to describe React UI           |
| `class`                            | `className`                         |
| `for`                              | `htmlFor`                           |
| Event names are commonly lowercase | React events use camelCase          |
| Static markup                      | Can contain JavaScript expressions  |
| Browser parses it directly         | JSX is transformed before execution |

---

# Practical Example

Let's create a student card.

```jsx
function StudentCard() {
  const student = {
    name: "Yash",
    age: 22,
    course: "Computer Science"
  };

  return (
    <div className="card">
      <h2>{student.name}</h2>

      <p>Age: {student.age}</p>

      <p>Course: {student.course}</p>

      <button>
        View Profile
      </button>
    </div>
  );
}

export default StudentCard;
```

Here we are combining:

```text
JavaScript object
       ↓
JavaScript expressions
       ↓
JSX
       ↓
React component
       ↓
UI
```

---

# WHEN?

## When should I use JSX?

Use JSX when creating React components and describing their UI.

For example:

```jsx
function Login() {
  return (
    <form>
      <input type="email" />
      <input type="password" />
      <button>Login</button>
    </form>
  );
}
```

---

# When should I use `{}` in JSX?

Use `{}` when you need to insert a JavaScript **expression**.

### Variable

```jsx
<h1>{name}</h1>
```

### Calculation

```jsx
<p>{price * quantity}</p>
```

### Ternary

```jsx
<p>{isLoggedIn ? "Logout" : "Login"}</p>
```

### Array mapping

```jsx
{users.map(user => (
  <p key={user.id}>{user.name}</p>
))}
```

---

# What Cannot Directly Go Inside `{}`?

JSX expects an **expression**, not a statement.

❌ You cannot directly write:

```jsx
{
  if (isLoggedIn) {
    return "Welcome";
  }
}
```

Instead use a ternary:

```jsx
{
  isLoggedIn
    ? "Welcome"
    : "Please Login"
}
```

Or calculate the value before the `return`.

```jsx
let message;

if (isLoggedIn) {
  message = "Welcome";
} else {
  message = "Please Login";
}

return <h1>{message}</h1>;
```

---

# Interview Questions

### Q1. What is JSX?

> JSX is a JavaScript syntax extension commonly used with React to describe UI using HTML-like syntax.

### Q2. Is JSX HTML?

**No.**

JSX looks similar to HTML, but it is JavaScript syntax that gets transformed into JavaScript/React elements.

### Q3. Can we use JavaScript inside JSX?

**Yes.**

Use `{}` for JavaScript expressions.

```jsx
<h1>{name}</h1>
```

### Q4. What is the difference between `class` and `className`?

In JSX, the HTML `class` attribute is generally written as:

```jsx
className="container"
```

### Q5. Why do we use `key` when rendering lists?

React uses keys to identify list items across renders and correctly reconcile changes.

```jsx
users.map(user => (
  <p key={user.id}>{user.name}</p>
))
```

### Q6. What is a Fragment?

> A Fragment lets you group multiple JSX elements without adding an extra DOM element.

```jsx
<>
  <h1>Hello</h1>
  <p>World</p>
</>
```

---

# Remember

```text
JSX
 ↓
JavaScript syntax extension
 ↓
HTML-like UI syntax
 ↓
JavaScript expressions using {}
 ↓
React elements
 ↓
React renders UI
```

### One-line interview answer

> **JSX is a JavaScript syntax extension used in React to describe UI with HTML-like syntax while allowing JavaScript expressions to be embedded directly into the UI.**
