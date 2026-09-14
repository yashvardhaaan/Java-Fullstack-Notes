# 05 — GET Request

A **GET request** is used to retrieve data from a server/API.

It is the most common HTTP request you'll make when displaying data in a React application.

---

## WHY?

Suppose your React application needs to display:

* users
* products
* orders
* courses
* posts
* weather data
* dashboard statistics

The frontend needs to **ask the backend for data**.

That's where GET comes in:

```text
React
  ↓
GET /api/products
  ↓
Backend
  ↓
Database
  ↓
Products
  ↓
React
  ↓
UI
```

---

# WHAT?

## What is a GET request?

A GET request tells a server:

> **"Give me this resource/data."**

Example:

```http
GET /api/users
```

The server might respond:

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

GET is primarily used for **retrieving resources**, not creating or modifying them.

---

# GET Request Structure

A GET request can contain:

```text
GET Request
├── URL
├── Query Parameters
├── Headers
└── No request body in typical usage
```

Example:

```text
GET /api/products?page=2&limit=10
```

Here:

```text
/api/products
      ↓
Endpoint

page=2
limit=10
      ↓
Query parameters
```

---

# WHERE?

GET requests are used whenever you need to **read data**.

### Product page

```text
GET /api/products
```

### Single product

```text
GET /api/products/25
```

### User profile

```text
GET /api/users/10
```

### Search

```text
GET /api/products?search=laptop
```

### Pagination

```text
GET /api/products?page=2&limit=20
```

---

# HOW?

## 1. GET using Fetch

The simplest version:

```js
const response = await fetch("/api/users");
```

Then check the response:

```js
if (!response.ok) {
  throw new Error("Failed to fetch users");
}
```

Then read the data:

```js
const users = await response.json();
```

Complete:

```js
async function getUsers() {
  const response = await fetch("/api/users");

  if (!response.ok) {
    throw new Error("Failed to fetch users");
  }

  const users = await response.json();

  return users;
}
```

---

# 2. GET using Axios

With Axios:

```js
import axios from "axios";

async function getUsers() {
  const response = await axios.get("/api/users");

  return response.data;
}
```

Notice the difference:

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

---

# 3. GET a Single Resource

Suppose:

```js
const userId = 25;
```

Fetch:

```js
const response = await fetch(
  `/api/users/${userId}`
);

const user = await response.json();
```

Request:

```text
GET /api/users/25
```

Axios:

```js
const response = await axios.get(
  `/api/users/${userId}`
);

const user = response.data;
```

---

# 4. GET with Query Parameters

Suppose you want:

```text
category = laptop
page = 2
limit = 20
```

You could write:

```js
const response = await fetch(
  "/api/products?category=laptop&page=2&limit=20"
);
```

But dynamically constructing query strings is safer with `URLSearchParams`:

```js
const params = new URLSearchParams({
  category: "laptop",
  page: "2",
  limit: "20"
});

const response = await fetch(
  `/api/products?${params}`
);
```

The resulting request is approximately:

```text
GET /api/products?category=laptop&page=2&limit=20
```

---

# Axios `params`

Axios makes this particularly convenient:

```js
const response = await axios.get("/api/products", {
  params: {
    category: "laptop",
    page: 2,
    limit: 20
  }
});
```

Axios constructs the query string for you.

---

# 5. GET Request in React

A very common React pattern is:

```jsx
import { useEffect, useState } from "react";

function Users() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    async function loadUsers() {
      const response = await fetch("/api/users");

      if (!response.ok) {
        throw new Error("Failed to fetch users");
      }

      const data = await response.json();

      setUsers(data);
    }

    loadUsers();
  }, []);

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

Flow:

```text
Component renders
      ↓
useEffect()
      ↓
GET /api/users
      ↓
Server
      ↓
JSON response
      ↓
setUsers()
      ↓
React re-renders
      ↓
Users appear
```

---

# 6. GET with Loading State

Real applications need to show the user that data is being loaded.

```jsx
import { useEffect, useState } from "react";

function Products() {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadProducts() {
      try {
        const response = await fetch("/api/products");

        if (!response.ok) {
          throw new Error("Failed to load products");
        }

        const data = await response.json();

        setProducts(data);
      } catch (error) {
        setError(error.message);
      } finally {
        setLoading(false);
      }
    }

    loadProducts();
  }, []);

  if (loading) {
    return <p>Loading products...</p>;
  }

  if (error) {
    return <p>Error: {error}</p>;
  }

  return (
    <div>
      {products.map((product) => (
        <div key={product.id}>
          <h3>{product.name}</h3>
          <p>₹{product.price}</p>
        </div>
      ))}
    </div>
  );
}
```

The state machine is essentially:

```text
          Request starts
               ↓
            Loading
           /       \
          ↓         ↓
      Success      Error
          ↓         ↓
        Data       Error
```

---

# 7. GET with Axios Instance

If your application has a shared Axios client:

```js
// api/client.js

import axios from "axios";

const api = axios.create({
  baseURL: "/api"
});

export default api;
```

Then:

```js
import api from "./client";

export async function getUsers() {
  const response = await api.get("/users");

  return response.data;
}
```

Your component:

```jsx
import { useEffect, useState } from "react";
import { getUsers } from "./api/users";

function Users() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    getUsers().then(setUsers);
  }, []);

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

This keeps API communication separate from UI code.

---

# 8. GET Request with Headers

Sometimes the API requires authentication.

Using Fetch:

```js
const response = await fetch("/api/profile", {
  headers: {
    Authorization: `Bearer ${token}`
  }
});
```

Using Axios:

```js
const response = await axios.get("/api/profile", {
  headers: {
    Authorization: `Bearer ${token}`
  }
});
```

The request might look like:

```http
GET /api/profile
Authorization: Bearer <token>
```

---

# 9. GET and HTTP Status Codes

Suppose you request:

```text
GET /api/users/25
```

Possible responses:

```text
200 OK
→ User found

404 Not Found
→ User doesn't exist

401 Unauthorized
→ Authentication required/failed

403 Forbidden
→ Access isn't permitted

500 Internal Server Error
→ Server-side failure
```

Your frontend should respond appropriately.

---

# 10. GET and Caching

GET requests are generally considered **safe** because they are intended to retrieve data rather than modify server state.

They are also commonly cacheable when HTTP caching rules allow it.

For example:

```text
GET /api/products
```

may potentially be cached.

This can improve performance by reducing unnecessary network requests.

Caching behavior depends on the HTTP headers and application architecture.

---

# 11. GET Is Not for Passwords

Avoid:

```text
GET /api/login?email=yash@example.com&password=123456
```

Sensitive information should not be placed in URLs.

URLs can appear in places such as:

* browser history
* logs
* analytics
* proxy/server logs
* copied/shared links

Use an appropriate request body and secure transport for sensitive operations.

---

# 12. GET Request and Search

Suppose you have a product search:

```jsx
const [search, setSearch] = useState("");

async function searchProducts() {
  const params = new URLSearchParams({
    search
  });

  const response = await fetch(
    `/api/products?${params}`
  );

  if (!response.ok) {
    throw new Error("Search failed");
  }

  const data = await response.json();

  return data;
}
```

Request:

```text
GET /api/products?search=laptop
```

The backend can use:

```text
search=laptop
```

to filter results.

---

# 13. GET and Pagination

Suppose the backend supports:

```text
page
limit
```

Request:

```text
GET /api/products?page=3&limit=20
```

This means:

```text
Page → 3
Items per page → 20
```

React:

```js
const response = await axios.get("/api/products", {
  params: {
    page: 3,
    limit: 20
  }
});

const products = response.data;
```

---

# 14. GET and Sorting

Example:

```text
GET /api/products?sort=price&order=asc
```

Potential meaning:

```text
sort  → price
order → ascending
```

Again, the exact parameter names are defined by the API.

---

# GET Request Mental Model

Remember:

```text
              GET REQUEST
                   │
                   ↓
           "Give me data"
                   │
                   ↓
              API Server
                   │
                   ↓
               Database
                   │
                   ↓
             HTTP Response
                   │
             ┌─────┴─────┐
             ↓           ↓
           200           Error
             ↓
            JSON
             ↓
         React State
             ↓
             UI
```

---

# Common Mistakes

## ❌ 1. Forgetting to parse Fetch response

Wrong:

```js
const response = await fetch("/users");

setUsers(response);
```

`response` is a `Response` object, not your JSON array.

Correct:

```js
const response = await fetch("/users");

const data = await response.json();

setUsers(data);
```

---

## ❌ 2. Forgetting `response.ok`

```js
const response = await fetch("/users");

const data = await response.json();
```

Better:

```js
if (!response.ok) {
  throw new Error("Failed to fetch users");
}
```

---

## ❌ 3. Making unnecessary GET requests

For example, if an effect runs repeatedly because its dependencies are incorrect:

```text
Render
 ↓
GET
 ↓
setState
 ↓
Render
 ↓
GET
 ↓
...
```

This can create excessive requests or even an infinite loop.

---

## ❌ 4. Ignoring loading/error states

Don't assume:

```text
API → always succeeds
```

Real networks fail.

Always consider:

```text
Loading
Success
Error
```

---

# 🎯 Interview Questions

### Q1. What is a GET request?

> A GET request is an HTTP request used primarily to retrieve a resource or data from a server.

---

### Q2. Can GET have query parameters?

Yes.

Example:

```text
GET /products?page=2&limit=20
```

---

### Q3. What is the difference between a path parameter and query parameter?

```text
/api/users/25
           ↑
     Path parameter
```

identifies a specific resource.

```text
/api/users?page=2
            ↑
      Query parameter
```

usually modifies/filter/sorts the requested collection.

---

### Q4. How do you make a GET request using Fetch?

```js
const response = await fetch("/api/users");

if (!response.ok) {
  throw new Error("Request failed");
}

const data = await response.json();
```

---

### Q5. How do you make a GET request using Axios?

```js
const response = await axios.get("/api/users");

const data = response.data;
```

---

### Q6. Is GET supposed to modify server data?

> GET is intended to be safe and retrieve data, not perform application state changes on the server.

---

### Q7. What status code usually indicates a successful GET?

```text
200 OK
```

---

### Q8. What happens if a requested resource doesn't exist?

Typically:

```text
404 Not Found
```

assuming the API uses conventional HTTP semantics.

---

# ⭐ Remember

```text
GET
 ↓
READ DATA
 ↓
/api/users
/api/products
/api/orders
```

With Fetch:

```js
const response = await fetch("/api/users");

if (!response.ok) {
  throw new Error("Request failed");
}

const data = await response.json();
```

With Axios:

```js
const response = await axios.get("/api/users");

const data = response.data;
```

### 🎯 One-line interview answer

> **A GET request is used to retrieve data from a server, commonly through a REST endpoint, and the response can then be stored in React state and rendered in the UI.**

**Next → `06 — POST Request`**
