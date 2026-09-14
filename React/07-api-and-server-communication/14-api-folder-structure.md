# 14 — API Folder Structure

## WHY?

As your React application grows, putting every API call directly inside components becomes difficult to maintain.

For example, this becomes messy:

```jsx
function Dashboard() {
  useEffect(() => {
    fetch("https://api.example.com/users");
    fetch("https://api.example.com/products");
    fetch("https://api.example.com/orders");
  }, []);

  // ...
}
```

Imagine having **50 components and 100 API calls**.

You would have:

* duplicated URLs
* duplicated error handling
* difficult maintenance
* difficult testing
* tightly coupled UI and API logic

A better approach is to separate:

```text
UI
 ↓
Hooks / State Logic
 ↓
Services
 ↓
API Client
 ↓
Backend
```

---

# WHAT?

**API folder structure** means organizing your application's API-related code into dedicated files/folders instead of putting network logic everywhere.

A common structure is:

```text
src/
├── components/
├── pages/
├── hooks/
├── services/
│   ├── api.js
│   ├── userService.js
│   ├── productService.js
│   └── orderService.js
├── utils/
├── App.jsx
└── main.jsx
```

The exact structure can vary depending on project size and team conventions.

---

# WHERE?

API-related code generally belongs in places such as:

```text
src/services/
src/api/
src/lib/
```

There is **no single mandatory React folder structure**.

For example:

```text
src/
└── api/
```

is perfectly valid.

Another project might use:

```text
src/
└── services/
```

The important idea is **separation of responsibilities**, not the folder name.

---

# HOW?

Let's build a practical structure.

## Step 1 — API Client

Create:

```text
src/services/api.js
```

Using Axios:

```jsx
import axios from "axios";

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL,
  headers: {
    "Content-Type": "application/json"
  }
});

export default api;
```

Now the base URL is defined in **one place**.

---

# Step 2 — User Service

Create:

```text
src/services/userService.js
```

```jsx
import api from "./api";

export async function getUsers() {
  const response = await api.get("/users");

  return response.data;
}

export async function getUserById(id) {
  const response = await api.get(`/users/${id}`);

  return response.data;
}

export async function createUser(user) {
  const response = await api.post("/users", user);

  return response.data;
}

export async function updateUser(id, user) {
  const response = await api.patch(`/users/${id}`, user);

  return response.data;
}

export async function deleteUser(id) {
  await api.delete(`/users/${id}`);
}
```

Now all user-related API operations are together.

---

# Step 3 — Product Service

```text
src/services/productService.js
```

```jsx
import api from "./api";

export async function getProducts() {
  const response = await api.get("/products");

  return response.data;
}

export async function getProductById(id) {
  const response = await api.get(`/products/${id}`);

  return response.data;
}
```

---

# Step 4 — Use Service in Component

Instead of:

```jsx
useEffect(() => {
  fetch("https://api.example.com/users");
}, []);
```

you can do:

```jsx
import { useEffect, useState } from "react";
import { getUsers } from "../services/userService";

function Users() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    async function loadUsers() {
      const data = await getUsers();
      setUsers(data);
    }

    loadUsers();
  }, []);

  return (
    <ul>
      {users.map(user => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}

export default Users;
```

Now the component primarily focuses on **UI and component behavior**.

---

# Complete Architecture

The flow becomes:

```text
                 React Component
                       ↓
                 Custom Hook
                       ↓
                  Service
                       ↓
                  API Client
                       ↓
                 HTTP Request
                       ↓
                    Backend
```

For example:

```text
Users.jsx
   ↓
useUsers()
   ↓
getUsers()
   ↓
api.get("/users")
   ↓
GET /users
   ↓
Backend
```

---

# Larger Project Structure

For a medium-sized application:

```text
src/
│
├── components/
│   ├── Button.jsx
│   ├── Navbar.jsx
│   └── UserCard.jsx
│
├── pages/
│   ├── Home.jsx
│   ├── Users.jsx
│   └── Products.jsx
│
├── hooks/
│   ├── useUsers.js
│   └── useProducts.js
│
├── services/
│   ├── api.js
│   ├── userService.js
│   ├── productService.js
│   └── orderService.js
│
├── utils/
│   └── formatDate.js
│
├── App.jsx
└── main.jsx
```

---

# Feature-Based Structure

For a large application, another good approach is to organize by **feature**.

```text
src/
├── features/
│   ├── users/
│   │   ├── UserList.jsx
│   │   ├── userService.js
│   │   └── useUsers.js
│   │
│   ├── products/
│   │   ├── ProductList.jsx
│   │   ├── productService.js
│   │   └── useProducts.js
│   │
│   └── orders/
│       ├── OrderList.jsx
│       ├── orderService.js
│       └── useOrders.js
│
├── components/
├── App.jsx
└── main.jsx
```

This can scale well because everything related to a particular feature stays together.

---

# API Client vs Service

This is an important distinction.

## API Client

Responsible for **how requests are configured**.

Example:

```jsx
const api = axios.create({
  baseURL: API_URL
});
```

It can also handle common configuration such as:

```text
Base URL
Headers
Authentication
Interceptors
Timeouts
```

---

## Service

Responsible for **which API endpoint is being called**.

Example:

```jsx
export async function getUsers() {
  const response = await api.get("/users");

  return response.data;
}
```

Think:

```text
API Client
→ HOW do we communicate with the server?

Service
→ WHICH backend operation do we need?
```

---

# Custom Hook vs Service

Another important distinction:

### Service

Deals with the API:

```jsx
async function getUsers() {
  // API request
}
```

### Custom Hook

Deals with React state/lifecycle:

```jsx
function useUsers() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);

  // React logic

  return {
    users,
    loading
  };
}
```

So:

```text
Service
   ↓
API logic

Hook
   ↓
React state + lifecycle

Component
   ↓
UI
```

---

# Example: Complete Flow

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

### `useUsers.js`

```jsx
import { useEffect, useState } from "react";
import { getUsers } from "../services/userService";

export function useUsers() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function loadUsers() {
      try {
        setLoading(true);
        setError(null);

        const data = await getUsers();

        setUsers(data);
      } catch (err) {
        setError(err);
      } finally {
        setLoading(false);
      }
    }

    loadUsers();
  }, []);

  return {
    users,
    loading,
    error
  };
}
```

### `Users.jsx`

```jsx
import { useUsers } from "../hooks/useUsers";

function Users() {
  const { users, loading, error } = useUsers();

  if (loading) {
    return <p>Loading...</p>;
  }

  if (error) {
    return <p>Failed to load users.</p>;
  }

  return (
    <ul>
      {users.map(user => (
        <li key={user.id}>
          {user.name}
        </li>
      ))}
    </ul>
  );
}

export default Users;
```

Now each layer has a clear responsibility.

---

# ⭐ Separation of Responsibilities

```text
┌──────────────────────────┐
│ Component                │
│ UI                       │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ Custom Hook              │
│ State + React lifecycle  │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ Service                  │
│ API operations           │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ API Client               │
│ Axios/fetch configuration│
└────────────┬─────────────┘
             ↓
          Backend
```

This separation makes the application easier to maintain.

---

# WHEN?

Use a dedicated API structure when:

* your application has multiple API endpoints
* multiple components use the same endpoint
* you need common Axios configuration
* authentication headers are required
* API error handling needs consistency
* the project is growing
* multiple developers are working on the project

For a tiny project, you don't need to create 20 layers just for the sake of architecture.

**Start simple and introduce structure when complexity justifies it.**

---

# ⚠️ Common Mistakes

### 1. Putting all API calls in components

```jsx
function Dashboard() {
  // 500 lines of API logic ❌
}
```

Separate API responsibilities when the project grows.

---

### 2. Duplicating the base URL

Bad:

```jsx
fetch("https://api.example.com/users");
fetch("https://api.example.com/products");
fetch("https://api.example.com/orders");
```

Better:

```jsx
const api = axios.create({
  baseURL: API_URL
});
```

---

### 3. Mixing UI and API logic

Avoid making a component responsible for:

```text
UI
API requests
authentication configuration
data transformation
caching
error handling
```

all at once.

---

### 4. Over-engineering

Don't create:

```text
api/
services/
repositories/
controllers/
adapters/
factories/
managers/
```

for a small React project.

Architecture should solve a problem, not create unnecessary complexity.

---

# ⭐ Interview Questions

### Q1. Why separate API calls from React components?

**Answer:**

To separate network logic from UI logic, improve reusability and maintainability, and make API operations easier to test and modify.

---

### Q2. What is an API service?

An API service is a module containing functions responsible for communicating with specific backend endpoints.

Example:

```jsx
getUsers()
createUser()
updateUser()
deleteUser()
```

---

### Q3. What is an API client?

An API client centralizes common HTTP configuration such as:

```text
Base URL
Headers
Authentication
Interceptors
Timeouts
```

---

### Q4. What's the difference between a service and a custom hook?

**Service:**

```text
API/network logic
```

**Custom Hook:**

```text
React state + lifecycle + reusable UI logic
```

---

### Q5. Is there one official React API folder structure?

**Answer:**

No. React doesn't mandate a particular project structure. Teams choose structures based on application size, architecture, and maintainability requirements.

---

### Q6. What structure would you use for a large React application?

One possible approach is:

```text
features/
services/
hooks/
components/
pages/
utils/
```

or a feature-based architecture where API logic, hooks, and components are grouped by domain.

---

# ⭐ Final API Section Summary

You've now covered the core API/data-fetching concepts:

```text
01  HTTP Basics
02  REST API
03  Fetch API
04  Axios
05  GET Request
06  POST Request
07  PUT & PATCH
08  DELETE Request
09  Loading State
10  Error State
11  API Data Fetching
12  Caching
13  Environment Variables
14  API Folder Structure
```

### One-line interview answer:

> **A good API folder structure separates API configuration, endpoint services, React hooks, and UI components so that network logic remains reusable, maintainable, and independent from presentation logic.**
