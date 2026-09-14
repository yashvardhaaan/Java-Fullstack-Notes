# 03 — Fetch API

The **Fetch API** is the browser's built-in JavaScript API for making HTTP requests.

It is one of the most important things to know when connecting a React frontend to a backend.

---

## WHY?

Your React application needs to communicate with APIs.

For example:

```text
React
  ↓
"I need all products"
  ↓
fetch()
  ↓
GET /api/products
  ↓
Backend
  ↓
JSON response
  ↓
React
```

Without something like `fetch()`, your React application wouldn't have a straightforward browser-native way to make HTTP requests.

---

# WHAT?

## What is Fetch API?

`fetch()` is a browser API that allows JavaScript to make network requests.

Basic syntax:

```js
fetch(url);
```

Example:

```js
fetch("/api/users");
```

By default, this makes a:

```text
GET request
```

---

# Basic Fetch Flow

```js
const response = await fetch("/api/users");

const data = await response.json();

console.log(data);
```

There are two important operations here:

```text
fetch()
  ↓
HTTP Response
  ↓
response.json()
  ↓
JavaScript data
```

---

# WHERE?

Fetch is commonly used in:

* React applications
* JavaScript applications
* browser applications
* frontend API communication
* sending form data
* authentication requests
* CRUD applications

Example:

```text
React
 ↓
fetch()
 ↓
REST API
 ↓
Backend
```

---

# HOW?

## 1. Simple GET Request

```js
fetch("/api/products");
```

To actually process the response:

```js
async function getProducts() {
  const response = await fetch("/api/products");

  const data = await response.json();

  console.log(data);
}
```

---

# 2. Using `.then()`

You can also use Promises directly:

```js
fetch("/api/products")
  .then((response) => response.json())
  .then((data) => {
    console.log(data);
  })
  .catch((error) => {
    console.error(error);
  });
```

Both approaches are valid:

### Promise style

```js
fetch(...)
  .then(...)
  .catch(...);
```

### Async/await

```js
const response = await fetch(...);
```

For most application code, `async/await` is often easier to read.

---

# 3. Understanding the Response

When you write:

```js
const response = await fetch("/api/users");
```

`response` is **not the actual JSON data**.

It is a `Response` object.

It contains information such as:

```text
Response
├── status
├── ok
├── headers
├── json()
├── text()
└── ...
```

For example:

```js
console.log(response.status);
```

might produce:

```text
200
```

And:

```js
console.log(response.ok);
```

might produce:

```text
true
```

---

# 4. Convert JSON Response

The response body needs to be read.

```js
const data = await response.json();
```

For example, the server sends:

```json
{
  "id": 1,
  "name": "Laptop"
}
```

Then:

```js
const data = await response.json();
```

gives JavaScript data:

```js
{
  id: 1,
  name: "Laptop"
}
```

---

# ⭐ Important: `response.json()` is asynchronous

This is wrong:

```js
const data = response.json();

console.log(data);
```

`data` is a Promise.

Use:

```js
const data = await response.json();
```

or:

```js
response.json().then((data) => {
  console.log(data);
});
```

---

# 5. Check `response.ok`

This is one of the most important Fetch concepts.

You might write:

```js
const response = await fetch("/api/users");

if (!response.ok) {
  throw new Error("Request failed");
}
```

Why?

Because `fetch()` does **not normally reject just because the server returns an HTTP error status such as 404 or 500**.

For example:

```text
GET /api/users
       ↓
404 Not Found
```

The fetch Promise can still resolve with a `Response`.

Therefore:

```js
if (!response.ok) {
  ...
}
```

is important.

---

# 6. POST Request

To send data:

```js
const response = await fetch("/api/users", {
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

Let's understand it.

### Method

```js
method: "POST"
```

### Header

```js
"Content-Type": "application/json"
```

This tells the server that the body contains JSON.

### Body

```js
body: JSON.stringify({
  name: "Yash",
  email: "yash@example.com"
})
```

`JSON.stringify()` converts the JavaScript object into a JSON string suitable for the HTTP request body.

---

# 7. Complete POST Example

```js
async function createUser() {
  const response = await fetch("/api/users", {
    method: "POST",

    headers: {
      "Content-Type": "application/json"
    },

    body: JSON.stringify({
      name: "Yash",
      email: "yash@example.com"
    })
  });

  if (!response.ok) {
    throw new Error("Failed to create user");
  }

  const data = await response.json();

  console.log(data);
}
```

Flow:

```text
JavaScript object
      ↓
JSON.stringify()
      ↓
HTTP POST
      ↓
Backend
      ↓
Response
      ↓
response.json()
      ↓
JavaScript object
```

---

# 8. GET with Query Parameters

Suppose you want products from page 2.

```js
const response = await fetch(
  "/api/products?page=2&limit=20"
);
```

Better when building URLs dynamically:

```js
const params = new URLSearchParams({
  page: "2",
  limit: "20"
});

const response = await fetch(
  `/api/products?${params}`
);
```

This avoids manually constructing and encoding complex query strings.

---

# 9. Dynamic URL

Suppose:

```js
const userId = 25;
```

You can write:

```js
const response = await fetch(
  `/api/users/${userId}`
);
```

Result:

```text
GET /api/users/25
```

---

# 10. PUT Request

```js
const response = await fetch("/api/users/25", {
  method: "PUT",

  headers: {
    "Content-Type": "application/json"
  },

  body: JSON.stringify({
    name: "Yash",
    email: "new@example.com"
  })
});
```

---

# 11. PATCH Request

```js
const response = await fetch("/api/users/25", {
  method: "PATCH",

  headers: {
    "Content-Type": "application/json"
  },

  body: JSON.stringify({
    name: "Yashvardhan"
  })
});
```

Typically:

```text
PUT
 ↓
Replace/update the resource representation

PATCH
 ↓
Partially modify the resource
```

---

# 12. DELETE Request

```js
const response = await fetch("/api/users/25", {
  method: "DELETE"
});

if (!response.ok) {
  throw new Error("Failed to delete user");
}
```

If the server returns:

```text
204 No Content
```

don't automatically do:

```js
await response.json();
```

because there may be no response body to parse.

---

# 13. Fetch in React

A common pattern for loading data:

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

The important architecture is:

```text
useEffect
    ↓
fetch()
    ↓
API
    ↓
response.json()
    ↓
setUsers()
    ↓
React re-render
    ↓
UI
```

---

# 14. Loading + Error + Success

A production application shouldn't only have:

```text
Data
```

It should generally handle:

```text
Loading
Error
Success
```

Example:

```jsx
import { useEffect, useState } from "react";

function Users() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadUsers() {
      try {
        const response = await fetch("/api/users");

        if (!response.ok) {
          throw new Error("Failed to load users");
        }

        const data = await response.json();

        setUsers(data);
      } catch (error) {
        setError(error.message);
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
    return <p>Error: {error}</p>;
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

This pattern will become especially important in the upcoming topics:

```text
09 — Loading State
10 — Error State
```

---

# 15. Request Headers

You can send headers using:

```js
fetch("/api/profile", {
  headers: {
    "Content-Type": "application/json",
    "Authorization": `Bearer ${token}`
  }
});
```

For example:

```text
Authorization
      ↓
Bearer eyJhbGci...
```

The backend can use the credential to authenticate the request.

---

# 16. Sending FormData

Fetch can also send `FormData`.

Useful for:

* file uploads
* multipart forms
* forms containing files

Example:

```js
const formData = new FormData();

formData.append("name", "Yash");
formData.append("profile", file);

const response = await fetch("/api/profile", {
  method: "POST",
  body: formData
});
```

### Important

When sending `FormData`, generally **don't manually set**:

```js
"Content-Type": "multipart/form-data"
```

The browser needs to add the appropriate `boundary` automatically.

---

# 17. Abort a Fetch Request

Sometimes a request should be cancelled.

For example, a component starts a request and then unmounts.

Use `AbortController`:

```js
const controller = new AbortController();

fetch("/api/users", {
  signal: controller.signal
});
```

To cancel:

```js
controller.abort();
```

Example with React:

```jsx
useEffect(() => {
  const controller = new AbortController();

  async function loadUsers() {
    try {
      const response = await fetch("/api/users", {
        signal: controller.signal
      });

      const data = await response.json();

      setUsers(data);
    } catch (error) {
      if (error.name !== "AbortError") {
        setError(error.message);
      }
    }
  }

  loadUsers();

  return () => {
    controller.abort();
  };
}, []);
```

This is useful for avoiding unnecessary work when the request is no longer relevant.

---

# Fetch Request Structure

Remember this structure:

```js
fetch(url, {
  method: "POST",

  headers: {
    "Content-Type": "application/json"
  },

  body: JSON.stringify(data),

  signal: controller.signal
});
```

Not every request needs every option.

For example, a simple GET can be:

```js
fetch("/api/users");
```

---

# Fetch vs Axios

You will often hear:

```text
Fetch
Axios
```

Both can make HTTP requests.

| Feature                            | Fetch                    | Axios                        |
| ---------------------------------- | ------------------------ | ---------------------------- |
| Built into modern browsers         | ✅                        | ❌                            |
| External dependency                | ❌                        | ✅                            |
| JSON response parsing              | Manual `response.json()` | Convenient response handling |
| HTTP errors automatically rejected | ❌                        | Generally yes                |
| Interceptors                       | Not built-in             | ✅                            |
| Request cancellation               | `AbortController`        | Supported                    |
| Lightweight/native                 | ✅                        | Library                      |

### Important

You don't need Axios just to make HTTP requests.

Fetch is already available in modern browsers.

---

# Common Mistakes

## ❌ Mistake 1 — Forgetting `await response.json()`

Wrong:

```js
const data = response.json();

console.log(data);
```

Correct:

```js
const data = await response.json();
```

---

## ❌ Mistake 2 — Assuming `fetch()` rejects for 404

Wrong assumption:

```text
404 → fetch automatically throws
```

Instead:

```js
const response = await fetch(url);

if (!response.ok) {
  throw new Error("Request failed");
}
```

---

## ❌ Mistake 3 — Forgetting `JSON.stringify()`

Wrong:

```js
body: {
  name: "Yash"
}
```

For a JSON request, use:

```js
body: JSON.stringify({
  name: "Yash"
})
```

---

## ❌ Mistake 4 — Parsing an empty response as JSON

If the API returns:

```text
204 No Content
```

don't blindly do:

```js
await response.json();
```

There may be no body.

---

## ❌ Mistake 5 — Hardcoding URLs everywhere

Instead of scattering:

```js
fetch("https://api.example.com/users");
fetch("https://api.example.com/products");
fetch("https://api.example.com/orders");
```

throughout the application, later you'll learn how to centralize API configuration.

That connects directly to:

```text
13 — Environment Variables
14 — API Folder Structure
```

---

# 🎯 Interview Questions

### Q1. What is Fetch API?

> Fetch is a browser-provided JavaScript API used to make HTTP requests and handle network responses.

---

### Q2. What does `fetch()` return?

> `fetch()` returns a Promise that resolves to a `Response` object.

---

### Q3. How do you get JSON from a response?

```js
const data = await response.json();
```

---

### Q4. Does fetch reject on HTTP 404 or 500?

> No. HTTP error status codes normally still produce a resolved `Response`; you should check `response.ok` or `response.status`.

---

### Q5. How do you send JSON using Fetch?

```js
fetch("/api/users", {
  method: "POST",
  headers: {
    "Content-Type": "application/json"
  },
  body: JSON.stringify(data)
});
```

---

### Q6. What is `JSON.stringify()` used for?

> It converts a JavaScript value, such as an object, into a JSON string that can be sent as an HTTP request body.

---

### Q7. How do you cancel a fetch request?

Using:

```js
AbortController
```

Example:

```js
controller.abort();
```

---

### Q8. What is the difference between Fetch and Axios?

> Fetch is a browser-native API, while Axios is an external HTTP client library that provides additional conveniences such as interceptors and automatic rejection for non-2xx responses.

---

# ⭐ Remember

The most important Fetch flow is:

```text
fetch()
   ↓
Promise
   ↓
Response
   ↓
Check response.ok
   ↓
response.json()
   ↓
JavaScript data
   ↓
setState()
   ↓
React UI
```

For a POST:

```text
JavaScript Object
       ↓
JSON.stringify()
       ↓
fetch()
       ↓
POST Request
       ↓
Backend
       ↓
Response
       ↓
response.json()
```

### 🎯 One-line interview answer

> **Fetch API is a browser-native API for making HTTP requests; it returns a Promise containing a Response object, which you can inspect and then parse using methods such as `json()`.**

**Next → `04 — Axios`**
