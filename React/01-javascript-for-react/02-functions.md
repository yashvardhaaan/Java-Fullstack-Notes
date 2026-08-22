## 02 — Functions

This is the next file. The goal is not just to learn function syntax, but to understand **why functions are everywhere in React**.

### 1. What is a function?

A function is a reusable block of code that performs a particular task.

```js
function greet() {
  console.log("Hello");
}

greet();
```

Instead of writing the same logic repeatedly, put it inside a function and call it whenever needed.

---

### 2. Why do we need functions?

Without functions:

```js
console.log("Hello Yash");
console.log("Hello Rahul");
console.log("Hello Amit");
```

With a function:

```js
function greet(name) {
  console.log(`Hello ${name}`);
}

greet("Yash");
greet("Rahul");
greet("Amit");
```

**Main purpose:**

> Functions let you package logic into reusable units.

This becomes extremely important in React because components, event handlers, API calls, validation logic, utility functions, etc. are all built around functions.

---

### 3. Function declaration

```js
function add(a, b) {
  return a + b;
}

const result = add(10, 20);

console.log(result); // 30
```

Here:

```text
function       → keyword
add            → function name
(a, b)         → parameters
return a + b   → returned value
10, 20         → arguments
```

---

### 4. Parameters vs arguments

```js
function greet(name) {
  console.log(`Hello ${name}`);
}

greet("Yash");
```

`name` is a **parameter**.

`"Yash"` is an **argument**.

Think:

```text
Parameter = placeholder
Argument  = actual value
```

---

### 5. Returning values

A function can return a value.

```js
function multiply(a, b) {
  return a * b;
}

const result = multiply(5, 4);

console.log(result); // 20
```

The `return` statement sends the result back to the caller.

This is different from:

```js
function multiply(a, b) {
  console.log(a * b);
}
```

Here you're displaying the result rather than returning it.

---

### 6. Why `return` matters in React

Consider a React component:

```jsx
function UserCard() {
  return (
    <div>
      <h2>Yash</h2>
      <p>Developer</p>
    </div>
  );
}
```

A React component is fundamentally a function that **returns UI**.

Conceptually:

```text
Function
   ↓
Receives data
   ↓
Processes data
   ↓
Returns JSX
   ↓
React renders it
```

This is one of the most important connections between JavaScript and React.

---

### 7. Functions can receive objects

Very common in real applications:

```js
function printUser(user) {
  console.log(user.name);
  console.log(user.email);
}

const user = {
  name: "Yash",
  email: "yash@example.com"
};

printUser(user);
```

This pattern becomes even more important when working with API responses.

---

### 8. Functions can return objects

```js
function createUser(name, age) {
  return {
    name: name,
    age: age
  };
}

const user = createUser("Yash", 21);

console.log(user);
```

Modern JavaScript allows shorthand:

```js
function createUser(name, age) {
  return {
    name,
    age
  };
}
```

You'll see this constantly in React applications.

---

### 9. Default parameters

You can provide a default value.

```js
function greet(name = "Guest") {
  console.log(`Hello ${name}`);
}

greet("Yash");
greet();
```

Output:

```text
Hello Yash
Hello Guest
```

Useful when a value may not be provided.

---

### 10. Functions as values

JavaScript treats functions as **first-class values**.

You can store a function inside a variable:

```js
const greet = function () {
  console.log("Hello");
};

greet();
```

You can also pass a function to another function:

```js
function executeTask(task) {
  task();
}

function sayHello() {
  console.log("Hello");
}

executeTask(sayHello);
```

This idea is **extremely important for React**.

---

### 11. Functions as callbacks

A callback is a function passed to another function so that it can be executed later.

```js
function processUser(callback) {
  callback();
}

processUser(() => {
  console.log("User processed");
});
```

You'll encounter callbacks constantly in React:

```jsx
<button onClick={handleClick}>
  Save
</button>
```

Here React receives a function:

```js
handleClick
```

React can call it when the button is clicked.

---

### 12. React event handlers

Example:

```jsx
function LoginButton() {

  function handleLogin() {
    console.log("User logged in");
  }

  return (
    <button onClick={handleLogin}>
      Login
    </button>
  );
}
```

Notice:

```jsx
onClick={handleLogin}
```

not:

```jsx
onClick={handleLogin()}
```

Why?

Because:

```jsx
handleLogin
```

means:

> "Give React this function."

Whereas:

```jsx
handleLogin()
```

means:

> "Execute this function right now."

This distinction is **very important in React**.

---

### 13. Functions can be passed as props

Parent:

```jsx
function App() {

  function handleDelete() {
    console.log("Delete user");
  }

  return (
    <UserCard onDelete={handleDelete} />
  );
}
```

Child:

```jsx
function UserCard({ onDelete }) {
  return (
    <button onClick={onDelete}>
      Delete
    </button>
  );
}
```

This is a fundamental React pattern:

```text
Parent
  │
  │ function
  ▼
Child
  │
  │ calls function
  ▼
Parent logic executes
```

You'll use this frequently when building real applications.

---

### 14. Function declaration vs function expression

Declaration:

```js
function add(a, b) {
  return a + b;
}
```

Expression:

```js
const add = function (a, b) {
  return a + b;
};
```

Both create functions.

In modern React code, you'll commonly encounter:

```js
const handleSubmit = function () {
  // ...
};
```

and especially:

```js
const handleSubmit = () => {
  // ...
};
```

The second one is an **arrow function**, which is your next topic.

---

### 15. Pure vs impure functions

A pure function:

```js
function add(a, b) {
  return a + b;
}
```

Same inputs → same output.

An impure function may depend on or modify external state:

```js
let count = 0;

function increment() {
  count++;
}
```

Why should you care about this in React?

Because React strongly benefits from **predictable data flow and avoiding unintended mutations**.

You'll see this become especially important when learning:

* State
* Immutability
* Hooks
* Reducers
* Component rendering

---

### 16. Common mistakes

#### Calling a function when React expects a function

Wrong:

```jsx
<button onClick={handleSubmit()}>
  Submit
</button>
```

Usually correct:

```jsx
<button onClick={handleSubmit}>
  Submit
</button>
```

---

#### Forgetting `return`

```js
function add(a, b) {
  a + b;
}
```

This returns:

```js
undefined
```

Correct:

```js
function add(a, b) {
  return a + b;
}
```

---

#### Doing too much inside one function

Avoid giant functions like:

```js
function processEverything() {
  // validation
  // database logic
  // formatting
  // authentication
  // API request
  // UI logic
  // 200 more lines...
}
```

Prefer small functions with clear responsibilities.

---

## 17. Where you'll use functions in React

You'll encounter functions in:

```text
React Components
      ↓
Event Handlers
      ↓
Props
      ↓
Callbacks
      ↓
API Functions
      ↓
Utility Functions
      ↓
Array Methods
      ↓
Hooks
      ↓
State Updates
```

For example, a real application might have:

```text
LoginForm
 ├── handleSubmit()
 ├── validateEmail()
 ├── validatePassword()
 ├── loginUser()
 └── handleError()
```

Each function has a specific responsibility.

---

## 18. Interview questions

### Q1. What is a function?

A reusable block of code designed to perform a specific task.

### Q2. What is the difference between a parameter and an argument?

A parameter is the variable defined by the function. An argument is the actual value passed when calling it.

### Q3. What does `return` do?

It sends a value back to the code that called the function and terminates that function's execution.

### Q4. What is a callback?

A function passed to another function so it can be invoked later.

### Q5. Why do we pass `handleClick` rather than `handleClick()` to React's `onClick`?

Because React expects a function reference that it can invoke when the event occurs. `handleClick()` executes immediately.

### Q6. Are functions first-class citizens in JavaScript?

Yes. Functions can be stored in variables, passed as arguments, returned from functions, and stored in objects or arrays.

---

## 19. Practice

Create a `practice.js` and implement:

```js
// 1. Create a function that adds two numbers.

// 2. Create a function that checks whether a number is even.

// 3. Create a function that accepts a user object
//    and returns the user's name.

// 4. Create a function that creates a user object.

// 5. Create a function that accepts another function
//    and executes it.

// 6. Create a function that returns another function.

// 7. Create a React button with a handleClick function.

// 8. Pass a function from a parent component to a child component.
```

### Quick revision

Remember these six ideas:

```text
Function
   ↓
Reusable logic

Parameter
   ↓
Input placeholder

Argument
   ↓
Actual input

Return
   ↓
Output

Callback
   ↓
Function passed to another function

React
   ↓
Components + handlers + props + callbacks
```

**Next: `03-arrow-functions.md`** — this one is particularly important for React because you'll see arrow functions everywhere.
