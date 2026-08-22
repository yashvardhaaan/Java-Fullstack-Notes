# 03 — Arrow Functions

Arrow functions are one of the **most frequently used JavaScript features in React**. Don't learn them only as a shorter syntax for functions. Understand **how they behave differently**, especially `this`.

---

## 1. What is an arrow function?

An arrow function is an alternative syntax for writing a function.

Normal function:

```js
function add(a, b) {
  return a + b;
}
```

Arrow function:

```js
const add = (a, b) => {
  return a + b;
};
```

Shorter version:

```js
const add = (a, b) => a + b;
```

The basic idea:

```text
Normal function
      ↓
function add(a, b) {
    return a + b;
}

Arrow function
      ↓
const add = (a, b) => a + b;
```

---

## 2. Why do we use arrow functions?

Arrow functions are useful because they provide:

* shorter syntax
* convenient callbacks
* lexical `this`
* cleaner React event handlers
* cleaner array operations
* concise functions for transformations

In modern React code, you'll see them constantly.

For example:

```jsx
const handleClick = () => {
  console.log("Clicked");
};
```

---

## 3. Basic syntax

Multiple parameters:

```js
const add = (a, b) => {
  return a + b;
};
```

One parameter:

```js
const square = number => {
  return number * number;
};
```

No parameters:

```js
const greet = () => {
  console.log("Hello");
};
```

You can omit parentheses only when there is exactly **one parameter**.

---

## 4. Explicit return

You can write:

```js
const add = (a, b) => {
  return a + b;
};
```

Here the `return` is explicit.

---

## 5. Implicit return

If the function contains a single expression, you can omit `{}` and `return`.

```js
const add = (a, b) => a + b;
```

This:

```js
const square = number => number * number;
```

is equivalent to:

```js
const square = function (number) {
  return number * number;
};
```

This is especially useful with array methods.

---

## 6. Arrow functions with objects

This is a common mistake.

You might want:

```js
const createUser = () => {
  return {
    name: "Yash",
    age: 21
  };
};
```

With implicit return, you need parentheses:

```js
const createUser = () => ({
  name: "Yash",
  age: 21
});
```

Why?

Because:

```js
() => {}
```

is interpreted as a function body, not an object being returned.

---

## 7. Arrow functions as callbacks

This is where you'll use them heavily.

Without arrow function:

```js
const numbers = [1, 2, 3];

const doubled = numbers.map(function (number) {
  return number * 2;
});
```

With arrow function:

```js
const numbers = [1, 2, 3];

const doubled = numbers.map(number => number * 2);
```

This is much cleaner.

---

## 8. Why this matters in React

React frequently works with arrays.

Suppose an API gives you:

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
        <p key={user.id}>{user.name}</p>
      ))}
    </div>
  );
}
```

The arrow function:

```js
user => (...)
```

is a callback passed to `map()`.

This pattern will become extremely common in your React projects.

---

## 9. Arrow functions for event handlers

You can write:

```jsx
function LoginButton() {

  const handleLogin = () => {
    console.log("Logging in...");
  };

  return (
    <button onClick={handleLogin}>
      Login
    </button>
  );
}
```

Or inline:

```jsx
<button onClick={() => console.log("Clicked")}>
  Click
</button>
```

The second approach is useful when the handler contains very small logic.

---

## 10. Passing arguments to event handlers

Suppose you need to pass an ID.

Don't do this:

```jsx
<button onClick={deleteUser(10)}>
  Delete
</button>
```

That executes the function during rendering.

Instead:

```jsx
<button onClick={() => deleteUser(10)}>
  Delete
</button>
```

Now React receives a function:

```text
Render
  ↓
Creates callback
  ↓
User clicks button
  ↓
Callback executes
  ↓
deleteUser(10)
```

This is a pattern you'll use frequently.

---

# 11. The most important difference: `this`

This is the part you should understand for interviews.

Normal functions have their own `this` depending on **how they are called**.

Arrow functions do **not** have their own `this`.

They inherit `this` from the surrounding scope.

This is called:

> **Lexical `this`**

Example:

```js
const user = {
  name: "Yash",

  greet() {
    console.log(this.name);
  }
};

user.greet();
```

Output:

```text
Yash
```

Here `this` refers to the `user` object because the method is called as:

```js
user.greet()
```

---

## 12. Arrow function and `this`

Consider:

```js
const user = {
  name: "Yash",

  greet: () => {
    console.log(this.name);
  }
};

user.greet();
```

Don't expect this to behave like the previous example.

The arrow function doesn't create its own `this`.

It takes `this` from its surrounding lexical scope.

### Important rule

> **Arrow functions don't bind their own `this`.**

This is one reason arrow functions became particularly useful in JavaScript callbacks and class-based code.

---

## 13. Arrow functions and React

Modern React uses **function components**, so you generally don't deal with the old class-component `this` patterns.

For example:

```jsx
const UserCard = ({ user }) => {
  return (
    <div>
      <h2>{user.name}</h2>
    </div>
  );
};
```

This is a function component written using an arrow function.

You will see both:

```jsx
function UserCard() {
  return <div>Hello</div>;
}
```

and:

```jsx
const UserCard = () => {
  return <div>Hello</div>;
};
```

Both are valid React components.

---

# 14. Arrow functions with array methods

This is extremely important for practical React development.

### `map()`

```js
const numbers = [1, 2, 3];

const doubled = numbers.map(number => number * 2);
```

### `filter()`

```js
const numbers = [1, 2, 3, 4, 5];

const evenNumbers = numbers.filter(number => number % 2 === 0);
```

### `find()`

```js
const users = [
  { id: 1, name: "Yash" },
  { id: 2, name: "Rahul" }
];

const user = users.find(user => user.id === 2);
```

These patterns are everywhere in React applications.

---

# 15. Arrow functions and state updates

Later, when you learn React state, you'll encounter:

```jsx
setCount(count => count + 1);
```

Notice:

```js
count => count + 1
```

That's an arrow function.

It tells React:

> Take the previous state value and calculate the next value from it.

This is particularly useful when the new state depends on the previous state.

---

# 16. Arrow functions don't automatically make code better

Don't use an arrow function just because it's shorter.

For example:

```js
const calculateTotal = (price, tax) => price + tax;
```

Great.

But if the logic is complex:

```js
const calculateTotal = (items, discount, tax, user, shipping) => {
  // 50 lines...
};
```

The main concern should be **readability and responsibility**, not whether the function is an arrow function.

---

# 17. Common mistakes

### Mistake 1 — Forgetting implicit return

Wrong:

```js
const square = number => {
  number * number;
};
```

This returns:

```js
undefined
```

Correct:

```js
const square = number => number * number;
```

Or:

```js
const square = number => {
  return number * number;
};
```

---

### Mistake 2 — Incorrect object return

Wrong:

```js
const createUser = () => {
  name: "Yash";
};
```

Correct:

```js
const createUser = () => ({
  name: "Yash"
});
```

---

### Mistake 3 — Executing the event handler immediately

Wrong:

```jsx
<button onClick={handleDelete(5)}>
```

Correct:

```jsx
<button onClick={() => handleDelete(5)}>
```

---

### Mistake 4 — Assuming arrow functions have their own `this`

They don't.

```text
Normal function
→ has its own `this`

Arrow function
→ inherits `this`
```

---

# 18. When should I use arrow functions?

A practical rule:

### Good use cases

```text
Array callbacks
Event handlers
Small utility functions
React components
Inline callbacks
Promise callbacks
Array transformations
```

Example:

```jsx
const handleSubmit = () => {
  // ...
};

const users = data.map(user => ({
  id: user.id,
  name: user.name
}));
```

---

# 19. When might a normal function be better?

Arrow functions aren't mandatory everywhere.

For example, when you specifically need a function's own `this`, `arguments`, or certain function semantics, a regular function may be more appropriate.

Also, don't blindly convert every existing function to an arrow function without understanding its behavior.

---

# 20. Interview questions

### Q1. What is an arrow function?

A concise syntax for defining functions introduced in ES6.

### Q2. What is the main difference between arrow functions and regular functions?

Arrow functions have lexical `this`, while regular functions determine `this` based on how they are called.

### Q3. Can an arrow function have parameters?

Yes.

```js
const add = (a, b) => a + b;
```

### Q4. What is implicit return?

When an arrow function contains a single expression without `{}`, the expression's result is automatically returned.

```js
const square = n => n * n;
```

### Q5. Why are arrow functions common in React?

They provide concise syntax and are particularly convenient for callbacks, event handlers, array methods, and function components.

### Q6. Why use this?

```jsx
onClick={() => deleteUser(id)}
```

instead of:

```jsx
onClick={deleteUser(id)}
```

Because the first passes a function to React, while the second calls `deleteUser` immediately during rendering.

---

# 21. Practice

Create `practice.js` and solve these without copying the answers:

```js
// 1. Convert a normal function into an arrow function.

// 2. Create an arrow function that multiplies two numbers.

// 3. Create an arrow function that checks whether a number is even.

// 4. Use map() to double every number.

// 5. Use filter() to get numbers greater than 10.

// 6. Use find() to find a user by ID.

// 7. Create an arrow function that returns an object.

// 8. Create a React button using an arrow-function event handler.

// 9. Pass an ID to an event handler.

// 10. Create a React component using an arrow function.
```

---

## Quick revision

```text
Arrow Function
      ↓
Shorter function syntax
      ↓
Very common in React
      ↓
Callbacks
      ↓
map / filter / find
      ↓
Event handlers
      ↓
Components
      ↓
Important difference
      ↓
Lexical `this`
```

### The one thing to remember

Don't memorize:

> "Arrow functions are shorter."

Remember:

> **Arrow functions are concise functions with lexical `this`, and React uses them heavily for components, callbacks, event handlers, and array operations.**

**Next: `04-destructuring.md`** — this is another **high-priority React concept**, because you'll constantly destructure props, API responses, objects, and arrays.
