# 06 — React Project Structure

## WHY?

### Why do we need a proper React project structure?

As a React application grows, putting everything inside `App.jsx` becomes difficult to manage.

For example, a large application may contain:

```text
Navbar
Sidebar
Login
Dashboard
Products
Users
Forms
API calls
Custom hooks
Images
CSS
```

If everything is kept in one file, the code becomes:

* Difficult to understand
* Difficult to debug
* Difficult to reuse
* Difficult for multiple developers to work on

A proper folder structure separates responsibilities.

---

# WHAT?

## What is React project structure?

A React project is divided into folders and files based on their purpose.

A common structure is:

```text
my-react-app/
│
├── public/
│
├── src/
│   ├── assets/
│   ├── components/
│   ├── pages/
│   ├── hooks/
│   ├── services/
│   ├── App.jsx
│   └── main.jsx
│
├── package.json
├── package-lock.json
└── vite.config.js
```

The exact structure can change depending on the project.

---

# WHERE?

## Where does the React code live?

Most application code lives inside:

```text
src/
```

For example:

```text
src/
│
├── App.jsx
├── main.jsx
└── components/
```

---

# `src/`

### WHAT?

`src` stands for **source**.

It contains the application's source code.

Example:

```text
src/
├── App.jsx
├── main.jsx
├── components/
└── pages/
```

### WHY?

It keeps your actual application code separate from generated/build files.

---

# `main.jsx`

## WHAT?

`main.jsx` is commonly the entry point where the React application is mounted into the HTML page.

Example:

```jsx
import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import App from "./App.jsx";

createRoot(document.getElementById("root")).render(
  <StrictMode>
    <App />
  </StrictMode>
);
```

### HOW?

The flow is approximately:

```text
index.html
    ↓
<div id="root"></div>
    ↓
main.jsx
    ↓
<App />
    ↓
React application
```

### WHEN?

You usually don't put your application's entire UI inside `main.jsx`.

Its main responsibility is to **start/mount the React application**.

---

# `App.jsx`

## WHAT?

`App.jsx` commonly contains the root component of the application.

Example:

```jsx
function App() {
  return (
    <div>
      <h1>My Application</h1>
    </div>
  );
}

export default App;
```

### HOW?

`main.jsx` renders:

```jsx
<App />
```

which means React renders the `App` component.

Conceptually:

```text
main.jsx
   ↓
App.jsx
   ↓
Components
   ↓
UI
```

---

# `components/`

## WHY?

To store reusable UI components.

## WHAT?

Example:

```text
components/
├── Navbar.jsx
├── Button.jsx
├── Card.jsx
└── Modal.jsx
```

### HOW?

Create:

```jsx
function Button({ children }) {
  return (
    <button>
      {children}
    </button>
  );
}

export default Button;
```

Use it:

```jsx
import Button from "./components/Button";

function App() {
  return (
    <Button>
      Login
    </Button>
  );
}
```

### WHEN?

Create a component when:

* It is reused.
* It has its own UI responsibility.
* A component is becoming too large.

---

# `pages/`

## WHY?

To organize larger screen-level components.

## WHAT?

For example:

```text
pages/
├── Home.jsx
├── Login.jsx
├── Dashboard.jsx
└── Profile.jsx
```

A page usually represents a complete screen or route.

Example:

```jsx
function Login() {
  return (
    <div>
      <h1>Login</h1>
      <input type="email" />
      <input type="password" />
      <button>Login</button>
    </div>
  );
}

export default Login;
```

### WHEN?

Use a `pages` folder when your application contains multiple screens/routes.

---

# `assets/`

## WHAT?

Used for static assets that are imported into the application.

Examples:

```text
assets/
├── logo.png
├── profile.jpg
├── icons/
└── fonts/
```

Example:

```jsx
import logo from "./assets/logo.png";

function Navbar() {
  return (
    <img src={logo} alt="Logo" />
  );
}
```

---

# `hooks/`

## WHAT?

Used for custom React Hooks.

Example:

```text
hooks/
└── useAuth.js
```

A custom hook might look like:

```jsx
function useAuth() {
  // authentication logic

  return {
    isLoggedIn: true
  };
}

export default useAuth;
```

### WHY?

It allows reusable logic to be separated from UI components.

### WHEN?

Create custom hooks when the same stateful logic is needed in multiple components.

---

# `services/`

## WHAT?

Usually contains code responsible for communicating with external services such as APIs.

Example:

```text
services/
├── userService.js
├── productService.js
└── authService.js
```

Example:

```javascript
export async function getUsers() {
  const response = await fetch("/api/users");

  return response.json();
}
```

Then a component can use that function rather than putting all API code directly inside the UI.

---

# `public/`

## WHAT?

The `public` folder is commonly used for files that should be served as static assets without going through the normal source-code import process.

Example:

```text
public/
├── favicon.ico
└── robots.txt
```

A public asset can typically be referenced by its URL path.

---

# `package.json`

## WHAT?

Contains project metadata, dependencies and scripts.

Example:

```json
{
  "scripts": {
    "dev": "vite",
    "build": "vite build"
  },
  "dependencies": {
    "react": "...",
    "react-dom": "..."
  }
}
```

### WHY?

It tells npm:

* Which packages the project needs
* Which commands/scripts are available
* Project metadata

---

# `vite.config.js`

## WHAT?

This file contains configuration for Vite.

Example:

```javascript
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()]
});
```

### WHY?

To customize Vite's behavior for the project.

---

# HOW DO THESE FILES CONNECT?

The important flow is:

```text
index.html
     ↓
main.jsx
     ↓
App.jsx
     ↓
Pages
     ↓
Components
     ↓
Hooks / Services
     ↓
API / External services
```

For example:

```text
main.jsx
   ↓
App.jsx
   ↓
Dashboard.jsx
   ↓
Navbar.jsx
   ↓
Button.jsx
```

---

# Practical Project

Suppose we're building a student management system.

```text
student-management/
│
├── public/
│
├── src/
│   │
│   ├── assets/
│   │   └── logo.png
│   │
│   ├── components/
│   │   ├── Navbar.jsx
│   │   ├── StudentCard.jsx
│   │   └── Button.jsx
│   │
│   ├── pages/
│   │   ├── Home.jsx
│   │   ├── Students.jsx
│   │   └── Login.jsx
│   │
│   ├── hooks/
│   │   └── useStudents.js
│   │
│   ├── services/
│   │   └── studentService.js
│   │
│   ├── App.jsx
│   └── main.jsx
│
├── package.json
└── vite.config.js
```

This gives every part of the application a clear responsibility.

---

# WHEN?

## When should I create separate folders?

For a small project:

```text
src/
├── App.jsx
└── main.jsx
```

may be enough initially.

As the project grows:

```text
src/
├── components/
├── pages/
├── hooks/
├── services/
└── assets/
```

becomes useful.

**Don't create dozens of folders just for the sake of structure.** Structure should make the project easier to understand.

---

# Interview Questions

### Q1. What is `src`?

> `src` is commonly the directory containing the application's source code.

### Q2. What is `main.jsx`?

> It is commonly the entry point where the React application is mounted into the DOM.

### Q3. What is `App.jsx`?

> It commonly contains the root React component from which the application's UI is composed.

### Q4. What is the purpose of `components/`?

> To organize reusable UI components.

### Q5. What is the purpose of `pages/`?

> To organize screen-level or route-level components.

### Q6. Why use a `services/` folder?

> To separate external-service/API communication from UI components.

### Q7. Why use custom hooks?

> To extract and reuse stateful React logic between components.

---

# Remember

```text
src/
│
├── components/ → Reusable UI
├── pages/      → Screens
├── hooks/      → Reusable React logic
├── services/   → API/external services
├── assets/     → Images/static assets
├── App.jsx     → Root component
└── main.jsx    → React entry/mount point
```

### One-line interview answer

> **A React project structure organizes UI, pages, reusable logic, services, assets, and application entry points into separate responsibilities, making the application easier to maintain and scale.**
