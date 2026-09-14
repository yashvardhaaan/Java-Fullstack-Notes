# 11 — API Data Fetching in React

## WHY?

In a real React application, the UI usually needs data from a **backend/server**.

For example:

* Login → send credentials to backend
* Dashboard → fetch user information
* E-commerce → fetch products
* Banking app → fetch transactions
* Social media → fetch posts
* Weather app → fetch weather data

React itself does **not** provide the backend data.

So we need a way to:

```text
React UI
   ↓
API Request
   ↓
Backend Server
   ↓
Database
   ↓
API Response
   ↓
React UI
```

---

# WHAT?

**API data fetching** means making an HTTP request from a React application to retrieve or send data to a backend API.

Common tools:

```text
fetch()
Axios
React Query / TanStack Query
SWR
```

The simplest approach is `fetch()`.

Example:

```jsx
const response = await fetch("/api/products");
const products = await response.json();
```

---

# WHERE?

API fetching is commonly used in:

### 1. Dashboard

```text
/dashboard
     ↓
GET /api/dashboard
```

### 2. Product page

```text
/products/101
       ↓
GET /api/products/101
```

### 3. User profile

```text
/profile
   ↓
GET /api/user
```

### 4. Search

```text
Search: laptop
     ↓
GET /api/products?search=laptop
```

### 5. Forms

```text
Register form
     ↓
POST /api/users
```

---

# HOW?

A typical API-fetching flow looks like this:

```text
1. Component renders
       ↓
2. Start API request
       ↓
3. Show loading
       ↓
4. API responds
       ↓
5. Success → store data
       ↓
6. Error → store error
       ↓
7. Render appropriate UI
```

---

# ⭐ Basic Example

Suppose our backend provides:

```text
GET /api/users
```

and returns:

```json
[
  {
    "id": 1,
    "name": "Yash"
  },
  {
    "id": 2,
    "name": "Rahul"
  }
]
```

React component:

```jsx
import { useEffect, useState } from "react";

function Users() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function fetchUsers() {
      try {
        setLoading(true);
        setError(null);

        const response = await fetch("/api/users");

        if (!response.ok) {
          throw new Error("Failed to fetch users");
        }

        const data = await response.json();

        setUsers(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }

    fetchUsers();
  }, []);

  if (loading) {
    return <p>Loading users...</p>;
  }

  if (error) {
    return <p>Error: {error}</p>;
  }

  return (
    <div>
      <h2>Users</h2>

      {users.map((user) => (
        <p key={user.id}>{user.name}</p>
      ))}
    </div>
  );
}

export default Users;
```

---

# Understanding the Code

### Step 1 — Store API data

```jsx
const [users, setUsers] = useState([]);
```

Initially:

```text
users = []
```

After successful API response:

```text
users = [
  { id: 1, name: "Yash" },
  { id: 2, name: "Rahul" }
]
```

---

### Step 2 — Store loading state

```jsx
const [loading, setLoading] = useState(true);
```

This tells the UI:

```text
API request running → Loading
API request finished → Not loading
```

---

### Step 3 — Store error

```jsx
const [error, setError] = useState(null);
```

If the request fails:

```jsx
setError("Failed to fetch users");
```

---

### Step 4 — Make request

```jsx
const response = await fetch("/api/users");
```

---

### Step 5 — Check response

With `fetch()`, a `404` or `500` does **not automatically throw an exception**.

Therefore:

```jsx
if (!response.ok) {
  throw new Error("Failed to fetch users");
}
```

This is very important for interviews.

---

### Step 6 — Convert response to JSON

```jsx
const data = await response.json();
```

Then:

```jsx
setUsers(data);
```

Updating state causes React to render the new data.

---

# Loading → Success → Error

A good mental model is:

```text
              API Request
                  ↓
             ┌──────────┐
             │ Loading  │
             └────┬─────┘
                  ↓
          ┌───────┴────────┐
          ↓                ↓
       Success            Error
          ↓                ↓
      Show data        Show message
```

For example:

```jsx
if (loading) {
  return <Loading />;
}

if (error) {
  return <ErrorMessage />;
}

return <UserList users={users} />;
```

---

# Fetching Data with Axios

Using Axios:

```jsx
import axios from "axios";
import { useEffect, useState } from "react";

function Users() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function fetchUsers() {
      try {
        setLoading(true);
        setError(null);

        const response = await axios.get("/api/users");

        setUsers(response.data);
      } catch (err) {
        setError("Failed to fetch users");
      } finally {
        setLoading(false);
      }
    }

    fetchUsers();
  }, []);

  if (loading) return <p>Loading...</p>;

  if (error) return <p>{error}</p>;

  return (
    <ul>
      {users.map((user) => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}
```

Notice the difference:

### Fetch

```jsx
const response = await fetch("/api/users");
const data = await response.json();
```

### Axios

```jsx
const response = await axios.get("/api/users");
const data = response.data;
```

---

# Fetching Data Based on ID

Suppose:

```text
GET /api/users/25
```

React:

```jsx
function User({ userId }) {
  const [user, setUser] = useState(null);

  useEffect(() => {
    async function loadUser() {
      const response = await fetch(`/api/users/${userId}`);
      const data = await response.json();

      setUser(data);
    }

    loadUser();
  }, [userId]);

  if (!user) {
    return <p>Loading...</p>;
  }

  return <h2>{user.name}</h2>;
}
```

The important part:

```jsx
}, [userId]);
```

When `userId` changes, the effect runs again.

---

# Search API Example

Suppose the user searches:

```text
laptop
```

We can make:

```text
GET /api/products?search=laptop
```

Using `URLSearchParams`:

```jsx
const params = new URLSearchParams({
  search: "laptop"
});

const response = await fetch(`/api/products?${params}`);
```

Result:

```text
/api/products?search=laptop
```

---

# POST API Example

Fetching isn't only about GET.

You can send data too:

```jsx
async function createUser(user) {
  const response = await fetch("/api/users", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify(user)
  });

  if (!response.ok) {
    throw new Error("Failed to create user");
  }

  return response.json();
}
```

Usage:

```jsx
await createUser({
  name: "Yash",
  email: "yash@example.com"
});
```

---

# API Data Fetching Architecture

In a small application:

```text
Component
   ↓
fetch()
   ↓
API
```

In a larger application, you generally don't want API calls scattered everywhere.

A better structure:

```text
src/
├── components/
├── pages/
├── services/
│   └── userService.js
├── hooks/
│   └── useUsers.js
└── App.jsx
```

For example:

### `userService.js`

```jsx
export async function getUsers() {
  const response = await fetch("/api/users");

  if (!response.ok) {
    throw new Error("Failed to fetch users");
  }

  return response.json();
}
```

Component:

```jsx
import { useEffect, useState } from "react";
import { getUsers } from "./services/userService";

function Users() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    getUsers()
      .then(setUsers)
      .catch(console.error);
  }, []);

  return (
    <div>
      {users.map(user => (
        <p key={user.id}>{user.name}</p>
      ))}
    </div>
  );
}
```

This separates:

```text
UI logic
   ↓
Service/API logic
```

---

# Custom Hook Approach

For reusable API logic:

```jsx
function useUsers() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function loadUsers() {
      try {
        const response = await fetch("/api/users");

        if (!response.ok) {
          throw new Error("Failed to fetch users");
        }

        const data = await response.json();
        setUsers(data);
      } catch (err) {
        setError(err);
      } finally {
        setLoading(false);
      }
    }

    loadUsers();
  }, []);

  return { users, loading, error };
}
```

Then:

```jsx
function Users() {
  const { users, loading, error } = useUsers();

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error occurred</p>;

  return (
    <>
      {users.map(user => (
        <p key={user.id}>{user.name}</p>
      ))}
    </>
  );
}
```

This makes the component much cleaner.

---

# WHEN?

Use API data fetching whenever your React UI needs to communicate with a backend.

Examples:

| Requirement     | Method             |
| --------------- | ------------------ |
| Get products    | GET                |
| Get one user    | GET                |
| Create account  | POST               |
| Login           | POST               |
| Update profile  | PUT/PATCH          |
| Delete account  | DELETE             |
| Search products | GET + query params |
| Upload file     | POST + FormData    |

---

# ⚠️ Common Mistakes

### 1. Forgetting `response.json()`

Wrong:

```jsx
const data = await fetch("/api/users");
console.log(data);
```

Correct:

```jsx
const response = await fetch("/api/users");
const data = await response.json();
```

---

### 2. Not checking `response.ok`

Wrong:

```jsx
const response = await fetch("/api/users");
const data = await response.json();
```

Better:

```jsx
if (!response.ok) {
  throw new Error("Request failed");
}
```

---

### 3. Forgetting loading state

Without loading state, users may see:

```text
No users found
```

while the API is still loading.

---

### 4. Forgetting error handling

Never assume:

```text
API always works
```

Real applications experience:

```text
Network failure
401
403
404
500
Timeout
Server unavailable
```

---

### 5. Making API calls directly during render

Avoid:

```jsx
function Users() {
  fetch("/api/users"); // ❌
  
  return <div>Users</div>;
}
```

This can cause repeated requests because rendering can happen multiple times.

Use an appropriate effect or data-fetching library instead.

---

# API Fetching vs React Query

For simple applications:

```text
fetch + useEffect + useState
```

can be enough.

For larger applications:

```text
TanStack Query
SWR
```

can manage things such as:

```text
Caching
Loading
Errors
Refetching
Retries
Request deduplication
Stale data
Background updates
```

So you don't have to manually build all of this.

---

# ⭐ Interview Questions

### Q1. How do you fetch API data in React?

**Answer:**

I can use the Fetch API or Axios, usually inside an effect or through a dedicated data-fetching library. I maintain loading, success/data, and error states and update the UI based on the request state.

---

### Q2. Does `fetch()` throw an error for a 404?

**Answer:**

No. `fetch()` rejects mainly for network-level failures. For HTTP errors such as 404 or 500, I need to check:

```jsx
response.ok
```

---

### Q3. Why use `useEffect` for API fetching?

**Answer:**

API calls are side effects. `useEffect` allows the request to happen after rendering and lets us control when it runs using dependencies.

---

### Q4. What happens after `setUsers(data)`?

**Answer:**

React schedules a state update, and the component renders again with the new `users` state.

---

### Q5. Why separate API services from components?

**Answer:**

It separates UI logic from network logic, making the code easier to test, reuse, maintain, and modify.

---

### Q6. Fetch vs Axios?

**Answer:**

`fetch` is built into the browser, while Axios is a third-party HTTP client with conveniences such as automatic JSON handling, interceptors, and a different error-handling model.

---

### Q7. What are the three common API UI states?

```text
Loading
Success
Error
```

---

# ⭐ Remember

```text
API Data Fetching
       ↓
Request
       ↓
Loading
       ↓
 ┌─────┴─────┐
 ↓           ↓
Success     Error
 ↓           ↓
Data        Message
```

**One-line interview answer:**

> **API data fetching in React is the process of communicating with a backend service to retrieve or send data and managing the loading, success, and error states required to display that data correctly in the UI.**
