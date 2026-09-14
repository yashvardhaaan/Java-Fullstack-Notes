# 13 — Environment Variables in React

## WHY?

Your React application often needs values that **change between environments**.

For example:

```text
Development
→ http://localhost:5000

Testing
→ https://test-api.example.com

Production
→ https://api.example.com
```

You don't want to hard-code these values throughout your code.

Instead, use **environment variables**.

---

# WHAT?

An **environment variable** is a configuration value provided to your application through the environment/build system rather than hard-coded directly into source code.

For example:

```text
API_BASE_URL=https://api.example.com
```

Your application can then use that value.

Common examples:

```text
API URL
Feature flags
Environment name
Public configuration
Analytics configuration
```

---

# WHERE?

Environment variables are commonly used for:

### Development

```text
.env
```

### Production

```text
Hosting platform
CI/CD system
Docker
Cloud environment
```

For modern React projects using **Vite**, client-exposed variables commonly use:

```text
VITE_
```

Example:

```text
VITE_API_URL=https://api.example.com
```

---

# HOW?

## 1. Create `.env`

For a Vite React application:

```text
.env
```

Add:

```env
VITE_API_URL=https://api.example.com
```

---

## 2. Access it in React

With Vite:

```jsx
const apiUrl = import.meta.env.VITE_API_URL;

console.log(apiUrl);
```

Then:

```jsx
const response = await fetch(`${apiUrl}/users`);
```

---

# Example

`.env`:

```env
VITE_API_URL=https://api.example.com
```

React:

```jsx
const API_URL = import.meta.env.VITE_API_URL;

async function getUsers() {
  const response = await fetch(`${API_URL}/users`);

  if (!response.ok) {
    throw new Error("Failed to fetch users");
  }

  return response.json();
}
```

Now if the API changes, you don't need to change every API call.

---

# Development vs Production

You might have:

```text
.env.development
.env.production
```

For example:

### `.env.development`

```env
VITE_API_URL=http://localhost:5000
```

### `.env.production`

```env
VITE_API_URL=https://api.myapp.com
```

Then your application can use:

```jsx
const API_URL = import.meta.env.VITE_API_URL;
```

The build environment determines which configuration is used.

---

# Axios Example

Environment variables are particularly useful with Axios.

```jsx
import axios from "axios";

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL
});

export default api;
```

Then:

```jsx
const response = await api.get("/users");
```

Instead of repeatedly writing:

```jsx
fetch("https://api.example.com/users");
fetch("https://api.example.com/products");
fetch("https://api.example.com/orders");
```

you have one central configuration.

---

# ⚠️ VERY IMPORTANT: Environment Variables Are NOT Automatically Secret

This is one of the most important concepts.

If a variable is exposed to browser-side React code:

```env
VITE_API_KEY=abc123
```

you should assume that users can potentially inspect the value in the built application.

Therefore:

### ❌ Don't put secrets in frontend environment variables

Examples:

```text
Database password
Private API key
JWT signing secret
AWS secret access key
Payment provider secret key
```

These belong on the **backend/server**, not in browser code.

---

# Public vs Secret Configuration

Think of it like this:

```text
React Browser
     ↓
PUBLIC CONFIGURATION
     ↓
Can be exposed
```

Whereas:

```text
Backend Server
     ↓
PRIVATE SECRETS
     ↓
Must remain protected
```

For example:

### Usually okay for frontend

```env
VITE_API_URL=https://api.example.com
```

### ❌ Not okay

```env
VITE_DATABASE_PASSWORD=123456
```

The `VITE_` prefix does **not** make a variable secret. In fact, it is commonly the mechanism that makes it available to browser code.

---

# `.env` and `.gitignore`

A common practice is to avoid committing local `.env` files containing sensitive configuration.

Example:

```gitignore
.env
.env.local
```

However, remember:

> **Putting a secret in `.gitignore` does not make it safe if the secret has already been exposed to frontend code.**

The important issue is **where the secret is used**, not just whether the file is committed.

---

# Environment Variables + API Architecture

A common project structure:

```text
src/
├── components/
├── pages/
├── hooks/
├── services/
│   ├── api.js
│   └── userService.js
└── App.jsx

.env
```

### `api.js`

```jsx
import axios from "axios";

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL
});

export default api;
```

### `userService.js`

```jsx
import api from "./api";

export async function getUsers() {
  const response = await api.get("/users");

  return response.data;
}
```

Now the component doesn't need to know the actual API domain.

---

# Environment Variables vs Hard-Coding

### ❌ Hard-coded

```jsx
const API_URL = "https://api.example.com";
```

Problems:

* difficult to change
* repeated across code
* different environments become harder to manage

### ✅ Environment variable

```jsx
const API_URL = import.meta.env.VITE_API_URL;
```

Better separation:

```text
Code
 ↓
Configuration
```

---

# WHEN?

Use environment variables when a value depends on the deployment environment or should be configurable without changing application source code.

Examples:

```text
Development API URL
Production API URL
Application configuration
Public analytics configuration
Feature configuration
```

But **do not use frontend environment variables as a security mechanism for secrets**.

---

# ⚠️ Common Mistakes

### 1. Forgetting the Vite prefix

This may not work as expected:

```env
API_URL=https://api.example.com
```

For Vite client-side exposure, use:

```env
VITE_API_URL=https://api.example.com
```

Then:

```jsx
import.meta.env.VITE_API_URL
```

---

### 2. Using `process.env` blindly

In a Vite React application, the usual syntax is:

```jsx
import.meta.env.VITE_API_URL
```

rather than assuming the older Create React App pattern:

```jsx
process.env.REACT_APP_API_URL
```

The syntax depends on your build tool.

---

### 3. Putting secrets in frontend variables

❌

```env
VITE_STRIPE_SECRET_KEY=...
```

or:

```env
VITE_DATABASE_PASSWORD=...
```

A browser application cannot securely hide values it needs to execute client-side.

---

### 4. Forgetting to restart the development server

After changing environment configuration, you may need to restart the dev server so the new build-time configuration is picked up.

---

# ⭐ Interview Questions

### Q1. What is an environment variable?

**Answer:**

An environment variable is a configuration value supplied outside the application's hard-coded source, allowing different environments such as development and production to use different settings.

---

### Q2. Why use environment variables in React?

To keep environment-specific configuration separate from application code.

For example:

```text
Development → localhost API
Production → production API
```

---

### Q3. Are React frontend environment variables secret?

**Answer:**

No. Values exposed to browser-side code should be treated as public because users can potentially inspect the application's built assets.

---

### Q4. How do you access environment variables in Vite?

```jsx
import.meta.env.VITE_API_URL
```

---

### Q5. Why does Vite use `VITE_`?

Vite uses the prefix to identify variables that are intended to be exposed to client-side application code.

---

### Q6. Where should database passwords and private API keys be stored?

**Answer:**

On the backend/server or in secure server-side secret/configuration management, never in browser-exposed React environment variables.

---

### Q7. Why is an API URL okay in a frontend environment variable?

Because an API URL generally isn't a secret. It tells the browser where to send requests.

---

# ⭐ Remember

```text
.env
   ↓
Environment Configuration
   ↓
React Build
   ↓
Browser

PUBLIC CONFIG → Can be exposed
SECRET         → Keep on backend
```

### One-line interview answer:

> **Environment variables allow React applications to use environment-specific configuration such as API URLs without hard-coding those values into the application, but browser-exposed variables must never be treated as secrets.**
