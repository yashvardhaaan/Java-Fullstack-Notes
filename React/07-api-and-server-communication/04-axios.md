# 04 — Axios

**Axios** is a popular JavaScript HTTP client used to communicate with APIs from React applications.

If `fetch()` is the browser's built-in way of making HTTP requests, **Axios is a separate library that provides a more convenient API and additional features.**

---

## WHY?

You can absolutely build a React application using `fetch()`.

But in a larger application, you may have many API calls:

```text
GET    /users
GET    /products
POST   /login
POST   /orders
PATCH  /users/10
DELETE /products/20
```

You may repeatedly need to handle:

* Base URLs
* Authentication headers
* JSON requests/responses
* Errors
* Request configuration
* Interceptors
* Timeouts
* Common API behavior

Axios helps centralize and simplify this.

---

# WHAT?

## What is Axios?

Axios is a **Promise-based HTTP client library**.

Install it:

```bash
npm install axios
```

Then:

```jsx
import axios from "axios";
```

Basic request:

```js
const response = await axios.get("/api/users");

console.log(response.data);
```

Notice something important:

### Fetch

```js
const response = await fetch("/api/users");

const data = await response.json();
```

### Axios

```js
const response = await axios.get("/api/users");

const data = response.data;
```

Axios handles response transformation more conveniently.

---

# WHERE?

Axios is commonly used in:

* React applications
* Next.js applications
* Node.js applications
* frontend/backend API communication
* authentication
* CRUD applications
* applications with many API endpoints

Example architecture:

```text
React
  ↓
Axios
  ↓
REST API
  ↓
Backend
  ↓
Database
```

---

# HOW?

## 1. GET Request

```js
import axios from "axios";

async function getUsers() {
  const response = await axios.get("/api/users");

  console.log(response.data);
}
```

The server might return:

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

Then:

```js
response.data
```

contains the parsed response data.

---

# 2. POST Request

```js
const response = await axios.post(
  "/api/users",
  {
    name: "Yash",
    email: "yash@example.com"
  }
);

console.log(response.data);
```

The second argument is the request body.

Compare with Fetch:

```js
fetch("/api/users", {
  method: "POST",
  headers: {
    "Content-Type": "application/json"
  },
  body: JSON.stringify({
    name: "Yash",
    email: "yash@example.com"
  })
});
```

Axios:

```js
axios.post("/api/users", {
  name: "Yash",
  email: "yash@example.com"
});
```

Much less boilerplate.

---

# 3. PUT Request

```js
await axios.put("/api/users/10", {
  name: "Yashvardhan",
  email: "yash@example.com"
});
```

---

# 4. PATCH Request

```js
await axios.patch("/api/users/10", {
  name: "Yashvardhan"
});
```

---

# 5. DELETE Request

```js
await axios.delete("/api/users/10");
```

---

# Axios CRUD

You can remember it like this:

```text
GET
 ↓
Read

POST
 ↓
Create

PUT
 ↓
Replace

PATCH
 ↓
Partial update

DELETE
 ↓
Delete
```

---

# Axios Response

An Axios response contains useful information.

For example:

```js
const response = await axios.get("/api/users");
```

You can access:

```js
response.data
response.status
response.headers
```

Conceptually:

```text
response
├── data
├── status
├── headers
├── config
└── ...
```

Most of the time:

```js
response.data
```

is what you need.

---

# ⭐ Axios Error Handling

This is an important difference from Fetch.

Axios generally **rejects the Promise for HTTP responses outside the 2xx range**.

Example:

```js
try {
  const response = await axios.get("/api/users");

  console.log(response.data);
} catch (error) {
  console.log("Request failed");
}
```

If the server returns:

```text
404
```

or:

```text
500
```

Axios normally sends execution to:

```js
catch
```

This differs from the normal Fetch behavior.

---

# Axios Error Object

You can inspect:

```js
try {
  await axios.get("/api/users");
} catch (error) {
  console.log(error.response);
}
```

Commonly useful:

```js
error.response.status
error.response.data
error.response.headers
```

For example:

```js
try {
  await axios.post("/api/login", credentials);
} catch (error) {
  if (error.response?.status === 401) {
    console.log("Invalid credentials");
  }
}
```

---

# Axios Instance

This is one of the **most important real-world Axios concepts**.

Instead of repeatedly writing:

```js
axios.get("https://api.example.com/users");

axios.get("https://api.example.com/products");

axios.post("https://api.example.com/orders");
```

create a reusable Axios instance.

```js
import axios from "axios";

const api = axios.create({
  baseURL: "https://api.example.com"
});

export default api;
```

Now:

```js
api.get("/users");
api.get("/products");
api.post("/orders");
```

The final URLs become:

```text
https://api.example.com/users
https://api.example.com/products
https://api.example.com/orders
```

---

# WHY Axios Instance?

Because you can centralize common configuration.

For example:

```js
const api = axios.create({
  baseURL: "https://api.example.com",
  timeout: 10000
});
```

Now every request made through `api` uses that configuration unless overridden.

---

# React Project Structure

A common structure is:

```text
src/
├── api/
│   ├── client.js
│   ├── users.js
│   └── products.js
│
├── components/
├── pages/
├── hooks/
└── App.jsx
```

`client.js`:

```js
import axios from "axios";

const api = axios.create({
  baseURL: "/api"
});

export default api;
```

`users.js`:

```js
import api from "./client";

export function getUsers() {
  return api.get("/users");
}

export function getUser(id) {
  return api.get(`/users/${id}`);
}

export function createUser(user) {
  return api.post("/users", user);
}
```

Now your React components don't need to know all the HTTP configuration.

---

# Axios in React

Example:

```jsx
import { useEffect, useState } from "react";
import axios from "axios";

function Users() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadUsers() {
      try {
        const response = await axios.get("/api/users");

        setUsers(response.data);
      } catch (error) {
        setError("Failed to load users");
      } finally {
        setLoading(false);
      }
    }

    loadUsers();
  }, []);

  if (loading) {
    return <p>Loading...</p>;
  }

  if (error) {
    return <p>{error}</p>;
  }

  return (
    <div>
      {users.map((user) => (
        <p key={user.id}>
          {user.name}
        </p>
      ))}
    </div>
  );
}
```

The flow is:

```text
Component
    ↓
axios.get()
    ↓
API
    ↓
Response
    ↓
response.data
    ↓
setUsers()
    ↓
React UI
```

---

# Request Headers

You can specify headers:

```js
axios.get("/api/profile", {
  headers: {
    Authorization: `Bearer ${token}`
  }
});
```

For POST:

```js
axios.post(
  "/api/users",
  userData,
  {
    headers: {
      Authorization: `Bearer ${token}`
    }
  }
);
```

---

# Query Parameters

Axios provides a convenient `params` option.

```js
axios.get("/api/products", {
  params: {
    category: "laptop",
    page: 2
  }
});
```

This produces a URL similar to:

```text
/api/products?category=laptop&page=2
```

This is cleaner than manually constructing the query string.

---

# Request Configuration

Axios requests can have configuration such as:

```js
axios.get("/api/users", {
  params: {
    page: 2
  },

  headers: {
    Authorization: `Bearer ${token}`
  },

  timeout: 10000
});
```

---

# Axios Interceptors

Interceptors are one of the major reasons developers choose Axios.

They allow you to run logic **before a request is sent or after a response is received**.

For example:

```text
React
 ↓
Axios
 ↓
Request Interceptor
 ↓
API
```

And:

```text
API
 ↓
Response
 ↓
Response Interceptor
 ↓
React
```

---

# Request Interceptor

Example:

```js
api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem("token");

    if (token) {
      config.headers.Authorization =
        `Bearer ${token}`;
    }

    return config;
  }
);
```

Now you don't have to manually add the token to every request.

Instead:

```js
api.get("/profile");
api.get("/orders");
api.get("/products");
```

can all use the interceptor's common logic.

---

# Response Interceptor

```js
api.interceptors.response.use(
  (response) => {
    return response;
  },
  (error) => {
    if (error.response?.status === 401) {
      console.log("Authentication expired");
    }

    return Promise.reject(error);
  }
);
```

This can be useful for centralized handling of things like:

```text
401
authentication problems

403
permission problems

500
server errors
```

Be careful with automatic redirects, token refresh, and global error handling; those behaviors should match your application's authentication architecture.

---

# Axios + Environment Variables

You usually don't want to hardcode:

```js
baseURL: "https://production-api.example.com"
```

because development and production may use different API URLs.

Instead:

```text
Development
→ http://localhost:3000

Production
→ https://api.example.com
```

Environment variables can provide configuration.

For example, depending on your build tool:

```js
const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL
});
```

The exact environment-variable syntax depends on whether you're using Vite, Next.js, Create React App, etc.

This connects directly to your upcoming topic:

```text
13 — Environment Variables
```

---

# Axios vs Fetch

This is a very common interview question.

| Feature               | Fetch                    | Axios                         |
| --------------------- | ------------------------ | ----------------------------- |
| Built into browser    | ✅                        | ❌                             |
| External package      | ❌                        | ✅                             |
| JSON parsing          | `response.json()`        | `response.data`               |
| 4xx/5xx handling      | Must check `response.ok` | Usually rejects automatically |
| Interceptors          | ❌ built-in               | ✅                             |
| Request instances     | ❌ built-in               | ✅                             |
| Query params          | Manual/`URLSearchParams` | `params` option               |
| Timeout configuration | More manual              | Built-in option               |
| Request cancellation  | `AbortController`        | Supported                     |

---

# Important Interview Trap

Don't say:

> "Axios is better than Fetch."

That's not universally true.

A better answer:

> **Fetch is a native browser API and is sufficient for many applications. Axios provides additional conveniences such as instances, interceptors, and automatic handling of non-2xx responses, which can be useful in larger applications.**

---

# When Should You Use Axios?

## Small application

Fetch may be perfectly sufficient:

```js
fetch("/api/users");
```

## Larger application

Axios can be useful when you have:

```text
Many API calls
     ↓
Common base URL
     ↓
Authentication
     ↓
Interceptors
     ↓
Centralized API configuration
```

The choice depends on the application's requirements and team conventions.

---

# Common Mistakes

### ❌ 1. Forgetting `response.data`

With Axios:

```js
const response = await axios.get("/users");
```

The actual response payload is generally:

```js
response.data
```

---

### ❌ 2. Creating Axios configuration everywhere

Avoid repeatedly doing:

```js
axios.get("https://api.example.com/users");

axios.get("https://api.example.com/products");
```

Prefer a shared instance when the application benefits from centralized configuration.

---

### ❌ 3. Putting tokens manually in every request

Instead of:

```js
axios.get("/users", {
  headers: {
    Authorization: `Bearer ${token}`
  }
});
```

for every API call, an interceptor or another centralized authenticated-client mechanism may be appropriate.

---

### ❌ 4. Hiding all errors

Don't do:

```js
catch (error) {
  console.log(error);
}
```

and then provide no useful UI feedback.

A real application should decide whether to show:

```text
Validation error
Authentication error
Network error
Server error
```

appropriately.

---

# 🎯 Interview Questions

### Q1. What is Axios?

> Axios is a Promise-based HTTP client library used to make HTTP requests and communicate with APIs.

---

### Q2. Why use Axios instead of Fetch?

> Axios provides conveniences such as automatic response transformation, request/response interceptors, reusable instances, convenient configuration, and automatic rejection for non-2xx responses.

---

### Q3. How do you make a GET request?

```js
const response = await axios.get("/api/users");
```

---

### Q4. How do you make a POST request?

```js
await axios.post("/api/users", {
  name: "Yash"
});
```

---

### Q5. What is an Axios instance?

> An Axios instance is a customized Axios client created with shared configuration such as a base URL, timeout, or headers.

Example:

```js
const api = axios.create({
  baseURL: "/api"
});
```

---

### Q6. What are Axios interceptors?

> Interceptors allow you to execute common logic before requests are sent or when responses/errors are received.

---

### Q7. Where would you use a request interceptor?

Common examples:

```text
Add authentication token
Add common headers
Log requests
Attach request IDs
```

---

### Q8. Where would you use a response interceptor?

Common examples:

```text
Centralized error handling
Handle authentication failures
Logging
Normalize responses
```

---

### Q9. What is `params` in Axios?

```js
axios.get("/products", {
  params: {
    page: 2,
    category: "laptop"
  }
});
```

`params` is used to construct query parameters.

---

# ⭐ Remember

Think of Axios as a reusable HTTP client:

```text
                 Axios
                   │
        ┌──────────┼──────────┐
        ↓          ↓          ↓
      GET        POST       DELETE
        │          │          │
        └──────────┼──────────┘
                   ↓
                  API
                   ↓
                Backend
```

For larger applications:

```text
              Axios Instance
                    ↓
             Request Interceptor
                    ↓
                  API
                    ↓
             Response Interceptor
                    ↓
               React UI
```

### 🎯 One-line interview answer

> **Axios is a Promise-based HTTP client that simplifies API communication and provides features such as reusable instances, interceptors, convenient request configuration, and automatic handling of non-2xx responses.**

**Next → `05 — GET Request`**
