# 11 — Modules: `import` and `export`

Modules are how you **split a large JavaScript/React application into multiple files**.

Instead of putting everything into one file:

```text
App.jsx
 ├── Button
 ├── UserCard
 ├── API calls
 ├── validation
 ├── utilities
 └── authentication
```

you separate responsibilities:

```text
src/
├── components/
│   ├── Button.jsx
│   └── UserCard.jsx
│
├── services/
│   └── userService.js
│
├── utils/
│   └── validation.js
│
└── App.jsx
```

Then `import` and `export` allow these files to communicate.

---

## 1. What is a module?

A JavaScript file can act as a **module**.

For example:

```js
// math.js

export function add(a, b) {
  return a + b;
}
```

Another file can use it:

```js
// app.js

import { add } from "./math.js";

console.log(add(10, 20));
```

Think:

```text
math.js
   │
   │ export
   ▼
add()
   │
   │ import
   ▼
app.js
```

---

# 2. Why do we need modules?

Imagine a real React application with 100 components and thousands of lines of code.

Without modules, everything becomes difficult to:

* understand
* test
* debug
* maintain
* reuse

Modules allow you to separate code based on responsibility.

For example:

```text
components/
    UI

services/
    API communication

utils/
    reusable logic

hooks/
    custom React hooks

pages/
    application screens
```

This is one of the foundations of **professional React project structure**.

---

# 3. Named Export

You can export something by name:

```js
// math.js

export function add(a, b) {
  return a + b;
}

export function subtract(a, b) {
  return a - b;
}
```

Then import them:

```js
import { add, subtract } from "./math.js";
```

Use:

```js
console.log(add(10, 5));
console.log(subtract(10, 5));
```

The names must match.

---

# 4. Exporting after declaration

You don't have to put `export` directly before the declaration.

You can write:

```js
function add(a, b) {
  return a + b;
}

function subtract(a, b) {
  return a - b;
}

export {
  add,
  subtract
};
```

Same idea.

---

# 5. Importing only what you need

Suppose:

```js
// math.js

export function add() {}
export function subtract() {}
export function multiply() {}
```

You only need `add`:

```js
import { add } from "./math.js";
```

You don't have to import everything.

This helps keep dependencies clear.

---

# 6. Importing multiple named exports

```js
import {
  add,
  subtract,
  multiply
} from "./math.js";
```

You can then use:

```js
add(10, 5);
subtract(10, 5);
multiply(10, 5);
```

---

# 7. Renaming an import

Suppose:

```js
export function calculateTotal() {}
```

You can import it under another name:

```js
import {
  calculateTotal as calculate
} from "./cart.js";
```

Now:

```js
calculate();
```

This can be useful when there is a naming conflict.

---

# 8. Default Export

A module can have one **default export**.

```js
// UserCard.jsx

function UserCard() {
  return <h2>User</h2>;
}

export default UserCard;
```

Then:

```js
import UserCard from "./UserCard";
```

Notice something important:

```js
export default UserCard;
```

but:

```js
import UserCard from "./UserCard";
```

There are **no `{}`**.

---

# 9. Named vs Default Export

### Named

```js
export function add() {}
```

Import:

```js
import { add } from "./math.js";
```

### Default

```js
export default function UserCard() {}
```

Import:

```js
import UserCard from "./UserCard";
```

Remember:

```text
Named export
→ { }

Default export
→ no { }
```

---

# 10. Why React uses default exports so often

A component file often represents one main component:

```text
UserCard.jsx
```

So you might have:

```jsx
function UserCard({ user }) {
  return (
    <div>
      {user.name}
    </div>
  );
}

export default UserCard;
```

Then:

```jsx
import UserCard from "./components/UserCard";
```

This is a very common React pattern.

---

# 11. A component can use named exports too

This is also valid:

```jsx
export function UserCard() {
  return <div>User</div>;
}
```

Then:

```jsx
import { UserCard } from "./UserCard";
```

Both approaches work.

The important thing is to understand the difference rather than treating one as magic.

---

# 12. Practical React Example

Suppose you have:

```text
src/
├── components/
│   ├── Header.jsx
│   └── UserCard.jsx
│
└── App.jsx
```

### `Header.jsx`

```jsx
function Header() {
  return <header>My Application</header>;
}

export default Header;
```

### `UserCard.jsx`

```jsx
function UserCard({ name }) {
  return <h2>{name}</h2>;
}

export default UserCard;
```

### `App.jsx`

```jsx
import Header from "./components/Header";
import UserCard from "./components/UserCard";

function App() {
  return (
    <>
      <Header />
      <UserCard name="Yash" />
    </>
  );
}

export default App;
```

Now each file has a clear responsibility.

---

# 13. Importing utilities

Suppose:

```text
src/
└── utils/
    └── formatCurrency.js
```

File:

```js
export function formatCurrency(amount) {
  return `₹${amount.toLocaleString()}`;
}
```

Component:

```jsx
import { formatCurrency }
  from "../utils/formatCurrency";

function ProductCard({ product }) {
  return (
    <p>
      {formatCurrency(product.price)}
    </p>
  );
}
```

This is much better than putting formatting logic directly into every component.

---

# 14. Importing API services

This becomes particularly important when connecting React to Spring Boot.

Structure:

```text
src/
├── components/
├── pages/
├── services/
│   └── userService.js
└── App.jsx
```

`userService.js`:

```js
const API_URL = "http://localhost:8080/api/users";

export async function getUsers() {
  const response = await fetch(API_URL);

  return response.json();
}
```

Then:

```jsx
import { getUsers } from "../services/userService";
```

Your component can call:

```js
const users = await getUsers();
```

Now your component doesn't need to know the details of the API request.

This is an important step toward **separation of concerns**.

---

# 15. Importing React libraries

You'll frequently see:

```jsx
import { useState } from "react";
```

This is a named import.

You're importing `useState` from the React package.

Later you'll see:

```jsx
import {
  useState,
  useEffect,
  useContext
} from "react";
```

Again, these are named exports being imported.

---

# 16. Importing CSS

React projects also use imports for CSS:

```jsx
import "./App.css";
```

This isn't importing a JavaScript function.

Your build tool processes the CSS import and includes it in the application.

This demonstrates that modern React tooling treats imports as part of the overall **module/build system**.

---

# 17. Relative paths

Suppose:

```text
src/
├── App.jsx
└── components/
    └── UserCard.jsx
```

From `App.jsx`:

```js
import UserCard from "./components/UserCard";
```

`./` means:

> Start from the current directory.

---

If you need to move up one directory:

```js
import something from "../utils/something";
```

`../` means:

> Go up one directory.

Think:

```text
./
→ current directory

../
→ parent directory
```

---

# 18. File extensions

You might write:

```js
import UserCard from "./UserCard.jsx";
```

or:

```js
import UserCard from "./UserCard";
```

Modern React tooling such as Vite can resolve common extensions automatically.

You'll commonly see the shorter version.

---

# 19. Module scope

Variables inside a module aren't automatically available everywhere.

For example:

```js
// user.js

const username = "Yash";
```

Another file cannot simply do:

```js
console.log(username);
```

You need to explicitly export it:

```js
export const username = "Yash";
```

and import it:

```js
import { username } from "./user.js";
```

This makes dependencies explicit.

---

# 20. Why this is useful for debugging

Modules make debugging easier because you can ask:

```text
Where is this logic?

        ↓

Component?
        ↓
components/

API request?
        ↓
services/

Validation?
        ↓
utils/

State logic?
        ↓
hooks/
```

Instead of searching through one massive file.

This directly connects with your goal of learning **debugging as a transferable skill**.

---

# 21. Barrel exports

You may eventually see:

```text
components/
├── Button.jsx
├── Header.jsx
├── UserCard.jsx
└── index.js
```

`index.js`:

```js
export { default as Button } from "./Button";
export { default as Header } from "./Header";
export { default as UserCard } from "./UserCard";
```

Then instead of:

```js
import Button from "./components/Button";
import Header from "./components/Header";
import UserCard from "./components/UserCard";
```

you can write:

```js
import {
  Button,
  Header,
  UserCard
} from "./components";
```

This pattern is called a **barrel export**.

It can make imports cleaner, although you shouldn't introduce barrel files everywhere without a reason.

---

# 22. Common mistakes

### Mistake 1 — Mixing named and default syntax

If you have:

```js
export function add() {}
```

this is wrong:

```js
import add from "./math";
```

Correct:

```js
import { add } from "./math";
```

---

### Mistake 2 — Forgetting the export

You write:

```js
function UserCard() {}
```

and then:

```js
import UserCard from "./UserCard";
```

This won't work unless `UserCard` is exported.

Correct:

```js
export default UserCard;
```

---

### Mistake 3 — Incorrect path

```js
import UserCard from "./UserCard";
```

only works if the file is actually in the expected location.

If it is inside `components`:

```js
import UserCard from "./components/UserCard";
```

---

### Mistake 4 — Huge files despite using modules

Modules aren't useful if you create:

```text
utils.js
```

with 2,000 unrelated functions.

Modules should represent meaningful responsibilities.

---

# 23. Practical React architecture

A small application could look like:

```text
src/
│
├── components/
│   ├── Button.jsx
│   ├── Header.jsx
│   └── ProductCard.jsx
│
├── pages/
│   ├── Home.jsx
│   ├── Login.jsx
│   └── Products.jsx
│
├── services/
│   ├── authService.js
│   └── productService.js
│
├── utils/
│   ├── formatCurrency.js
│   └── validation.js
│
├── hooks/
│   └── useAuth.js
│
├── App.jsx
└── main.jsx
```

Then modules connect everything:

```text
main.jsx
   ↓
App.jsx
   ↓
Pages
   ↓
Components
   ↓
Services / Hooks / Utils
```

This is the practical reason you need `import` and `export`.

---

# 24. Interview Questions

### Q1. What is a JavaScript module?

A JavaScript file whose code can be explicitly exposed and consumed using `export` and `import`.

### Q2. Difference between named and default exports?

Named exports are imported using `{}` and a module can have multiple named exports.

A module can have one default export, which is imported without `{}`.

### Q3. What does this mean?

```js
import { useState } from "react";
```

`useState` is being imported as a named export from the React package.

### Q4. Why are modules important in React?

They allow components, services, utilities, hooks, and other logic to be separated into maintainable and reusable files.

### Q5. What does `../` mean?

Move one directory upward relative to the current file.

### Q6. What is a barrel export?

A module, often `index.js`, that re-exports functionality from multiple modules to provide a centralized import location.

---

# 25. Practice

Create this structure:

```text
practice/
├── math.js
├── user.js
└── app.js
```

### `math.js`

```js
// Export add()
// Export multiply()
// Export subtract()
```

### `user.js`

```js
// Export a user object
// Export a function that prints the user
```

### `app.js`

```js
// Import the math functions
// Import the user
// Use everything
```

Then create a small React structure:

```text
src/
├── components/
│   ├── UserCard.jsx
│   └── Button.jsx
│
├── utils/
│   └── formatCurrency.js
│
├── services/
│   └── productService.js
│
└── App.jsx
```

Practice connecting them using `import` and `export`.

---

# Quick Revision

```text
MODULES
│
├── export
│   ├── Named export
│   │   └── export { add }
│   │
│   └── Default export
│       └── export default UserCard
│
└── import
    ├── Named
    │   └── import { add }
    │
    └── Default
        └── import UserCard
```

### The practical React connection

Think of a React application as a collection of modules:

```text
Component
    ↓
imports
    ↓
Service
    ↓
imports
    ↓
Utility
```

For example:

```jsx
import { getProducts } from "./services/productService";
import ProductCard from "./components/ProductCard";
import { formatCurrency } from "./utils/formatCurrency";
```

Each file has a **job**, and `import`/`export` connects those jobs together.

> **Modules aren't just JavaScript syntax. They're the mechanism that lets you turn a large React application into small, understandable, reusable pieces.**

**Next: `12-promises.md`** — this is where you'll start understanding how JavaScript handles asynchronous operations such as API calls.
