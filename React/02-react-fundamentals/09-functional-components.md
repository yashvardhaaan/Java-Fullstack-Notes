# 09 — Functional Components

## WHY?

### Why do we use Functional Components?

Functional components allow us to build React UI using normal JavaScript functions.

They are:

* Simple to write
* Easy to understand
* Reusable
* Compatible with React Hooks
* The standard approach for modern React development

Instead of creating UI with complex class syntax, we can use a function:

```jsx
function Welcome() {
  return <h1>Welcome to React</h1>;
}
```

---

# WHAT?

## What is a Functional Component?

A functional component is a **JavaScript function that returns React UI**.

Example:

```jsx
function Greeting() {
  return <h1>Hello Yash</h1>;
}

export default Greeting;
```

The function:

```text
Greeting()
    ↓
returns JSX
    ↓
React renders UI
```

---

# WHERE?

Functional components are used throughout modern React applications.

For example:

```text
src/
│
├── components/
│   ├── Navbar.jsx
│   ├── Button.jsx
│   └── ProductCard.jsx
│
├── pages/
│   ├── Home.jsx
│   └── Dashboard.jsx
│
└── App.jsx
```

Almost every UI section can be represented as a functional component.

---

# HOW?

## How do we create a Functional Component?

### Step 1 — Create a function

```jsx
function Welcome() {
}
```

### Step 2 — Return JSX

```jsx
function Welcome() {
  return <h1>Welcome</h1>;
}
```

### Step 3 — Export it

```jsx
function Welcome() {
  return <h1>Welcome</h1>;
}

export default Welcome;
```

### Step 4 — Import and use it

```jsx
import Welcome from "./Welcome";

function App() {
  return (
    <div>
      <Welcome />
    </div>
  );
}

export default App;
```

---

# Functional Component with Props

A functional component can receive props.

```jsx
function User({ name }) {
  return <h2>Hello {name}</h2>;
}
```

Use:

```jsx
<User name="Yash" />
```

Flow:

```text
Parent
   ↓
props
   ↓
User component
   ↓
JSX
   ↓
UI
```

---

# Functional Component with Multiple Props

```jsx
function Student({ name, age, course }) {
  return (
    <div>
      <h2>{name}</h2>
      <p>Age: {age}</p>
      <p>Course: {course}</p>
    </div>
  );
}
```

Use:

```jsx
<Student
  name="Yash"
  age={22}
  course="Computer Science"
/>
```

---

# Functional Component with State

This is one of the biggest advantages of modern functional components.

```jsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <h1>{count}</h1>

      <button onClick={() => setCount(count + 1)}>
        Increase
      </button>
    </div>
  );
}
```

Here:

```text
useState
   ↓
creates state
   ↓
setCount()
   ↓
state changes
   ↓
component renders again
   ↓
updated UI
```

---

# Functional Components with Events

Components can handle user interactions.

```jsx
function Button() {
  function handleClick() {
    console.log("Button clicked");
  }

  return (
    <button onClick={handleClick}>
      Click Me
    </button>
  );
}
```

When the user clicks:

```text
Click
 ↓
handleClick()
 ↓
JavaScript logic
```

---

# Functional Components with Other Components

A functional component can render other components.

```jsx
function Header() {
  return <header>My Website</header>;
}

function Content() {
  return <main>Welcome</main>;
}

function App() {
  return (
    <>
      <Header />
      <Content />
    </>
  );
}
```

Component tree:

```text
App
│
├── Header
│
└── Content
```

---

# WHY NOT CLASS COMPONENTS?

React historically supported class components:

```jsx
class Welcome extends React.Component {
  render() {
    return <h1>Welcome</h1>;
  }
}
```

Modern React development generally favors **function components with Hooks**.

The same basic UI can be written as:

```jsx
function Welcome() {
  return <h1>Welcome</h1>;
}
```

Functional components are usually simpler and are the approach you should learn first.

---

# Functional vs Class Components

| Functional Component  | Class Component                   |
| --------------------- | --------------------------------- |
| JavaScript function   | JavaScript class                  |
| Uses Hooks            | Uses lifecycle methods/state APIs |
| Simpler syntax        | More verbose                      |
| Modern React approach | Mainly legacy/older code          |
| Easy to compose       | More complex syntax               |

---

# WHEN?

## When should I use a Functional Component?

Use functional components when:

* Creating a new React component
* Building reusable UI
* Creating pages
* Managing state with Hooks
* Handling events
* Using effects or other Hooks

Example:

```jsx
function LoginForm() {
  return (
    <form>
      <input type="email" />
      <input type="password" />

      <button>
        Login
      </button>
    </form>
  );
}
```

---

# Important Rules

## 1. Component must return React-renderable content

```jsx
function App() {
  return <h1>Hello</h1>;
}
```

---

## 2. Component name should start with uppercase

✅

```jsx
function UserProfile() {
  return <h1>Profile</h1>;
}
```

❌

```jsx
function userProfile() {
  return <h1>Profile</h1>;
}
```

---

## 3. Hooks must follow the Rules of Hooks

For example:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  return <h1>{count}</h1>;
}
```

Don't conditionally call a Hook like:

```jsx
if (loggedIn) {
  useState(0);
}
```

Hooks should be called at the top level of the component or from another custom Hook.

---

# Practical Example — User Profile

```jsx
function UserProfile({ name, role, age }) {
  return (
    <div className="profile">
      <h1>{name}</h1>

      <p>Role: {role}</p>

      <p>Age: {age}</p>

      <button>
        View Profile
      </button>
    </div>
  );
}

export default UserProfile;
```

Use:

```jsx
function App() {
  return (
    <div>
      <UserProfile
        name="Yash"
        role="Software Developer"
        age={22}
      />

      <UserProfile
        name="Rahul"
        role="Data Analyst"
        age={23}
      />
    </div>
  );
}
```

One component:

```text
UserProfile
```

is reused for different users.

---

# Practical Example — Counter

```jsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);

  function increase() {
    setCount(count + 1);
  }

  return (
    <div>
      <h1>Count: {count}</h1>

      <button onClick={increase}>
        Increase
      </button>
    </div>
  );
}

export default Counter;
```

### Execution flow

```text
Initial render
     ↓
count = 0
     ↓
User clicks button
     ↓
increase()
     ↓
setCount(1)
     ↓
React renders component again
     ↓
count = 1
     ↓
UI shows 1
```

---

# Interview Questions

### Q1. What is a functional component?

> A functional component is a JavaScript function that returns React UI and can use React Hooks to manage state and other component behavior.

### Q2. Why are functional components preferred in modern React?

> They provide a simpler syntax and work naturally with Hooks, making stateful and reusable logic easier to write.

### Q3. Can a functional component have state?

**Yes.**

```jsx
const [count, setCount] = useState(0);
```

### Q4. Can a functional component receive props?

**Yes.**

```jsx
function User({ name }) {
  return <h1>{name}</h1>;
}
```

### Q5. Can one functional component render another?

**Yes.**

```jsx
function App() {
  return <Navbar />;
}
```

### Q6. Are class components completely invalid?

**No.** React still supports them, and you may encounter them in older codebases. But for new development, function components with Hooks are the standard approach.

---

# Remember

```text
Functional Component
        ↓
JavaScript Function
        ↓
Returns JSX
        ↓
Can receive Props
        ↓
Can use State
        ↓
Can use Hooks
        ↓
Can render other Components
```

### One-line interview answer

> **A functional component is a JavaScript function that returns React UI and can use Hooks such as `useState` and `useEffect` to manage state and component behavior.**
