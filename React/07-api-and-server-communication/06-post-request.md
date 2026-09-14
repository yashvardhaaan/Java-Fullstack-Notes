# 06 — POST Request

A **POST request** is an HTTP request commonly used to **send data to a server to create a resource or trigger an operation**.

If GET means:

> **"Give me data."**

POST commonly means:

> **"Here is some data; process it."**

---

## WHY?

Imagine a React registration form:

```text id="q7zq7b"
User enters:

Name: Yash
Email: yash@example.com
Password: ******

        ↓

React

        ↓ POST

/api/users

        ↓

Backend

        ↓

Database
```

GET is mainly for **reading**.

POST is commonly used when the frontend needs to **send data to the backend**.

---

# WHAT?

## What is a POST request?

POST is an HTTP method used to submit data to a server.

Example:

```http id="b6s9b5"
POST /api/users
Content-Type: application/json

{
  "name": "Yash",
  "email": "yash@example.com"
}
```

The server processes the request and might respond:

```http id="0b1z6d"
201 Created
```

with:

```json id="p9t4y2"
{
  "id": 101,
  "name": "Yash",
  "email": "yash@example.com"
}
```

---

# WHERE?

POST is commonly used for:

### Registration

```text id="9b1y8h"
POST /api/users
```

### Login

```text id="a8i5j2"
POST /api/login
```

### Create product

```text id="w8k9s1"
POST /api/products
```

### Create order

```text id="v2z8p3"
POST /api/orders
```

### Submit contact form

```text id="u4s7y6"
POST /api/contact
```

### Upload files

```text id="n3d6q1"
POST /api/upload
```

The exact API design determines whether POST is appropriate.

---

# HOW?

## 1. POST using Fetch

Basic example:

```js id="qv6h3e"
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

Then:

```js id="7u5j3w"
if (!response.ok) {
  throw new Error("Failed to create user");
}

const data = await response.json();

console.log(data);
```

---

# Understand Each Part

## `method`

```js id="2o3q89"
method: "POST"
```

Tells the browser to make a POST request.

---

## `headers`

```js id="w0wq9g"
headers: {
  "Content-Type": "application/json"
}
```

Tells the server:

> The request body is JSON.

---

## `body`

```js id="6s5s2c"
body: JSON.stringify({
  name: "Yash",
  email: "yash@example.com"
})
```

The JavaScript object:

```js id="s8j4a7"
{
  name: "Yash",
  email: "yash@example.com"
}
```

is converted into a JSON string.

---

# 2. POST using Axios

Axios makes this simpler:

```js id="n0k6g4"
const response = await axios.post(
  "/api/users",
  {
    name: "Yash",
    email: "yash@example.com"
  }
);

console.log(response.data);
```

Compare:

### Fetch

```js id="d3k6k1"
fetch("/api/users", {
  method: "POST",
  headers: {
    "Content-Type": "application/json"
  },
  body: JSON.stringify(data)
});
```

### Axios

```js id="y4r5v8"
axios.post("/api/users", data);
```

---

# 3. POST from a React Form

Suppose:

```jsx id="k2s4f7"
import { useState } from "react";

function UserForm() {
  const [form, setForm] = useState({
    name: "",
    email: ""
  });

  async function handleSubmit(event) {
    event.preventDefault();

    const response = await fetch("/api/users", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(form)
    });

    if (!response.ok) {
      throw new Error("Failed to create user");
    }

    const data = await response.json();

    console.log("Created:", data);
  }

  return (
    <form onSubmit={handleSubmit}>
      <input
        name="name"
        value={form.name}
        onChange={(e) =>
          setForm({
            ...form,
            name: e.target.value
          })
        }
      />

      <input
        name="email"
        value={form.email}
        onChange={(e) =>
          setForm({
            ...form,
            email: e.target.value
          })
        }
      />

      <button type="submit">
        Create User
      </button>
    </form>
  );
}
```

Flow:

```text id="o2c6j8"
User fills form
      ↓
Submit
      ↓
onSubmit
      ↓
preventDefault()
      ↓
Validate
      ↓
POST /api/users
      ↓
Backend
      ↓
Database
      ↓
Response
      ↓
Update UI
```

---

# 4. POST with Axios in React

```jsx id="f4c5q1"
async function handleSubmit(event) {
  event.preventDefault();

  try {
    const response = await axios.post(
      "/api/users",
      form
    );

    console.log(response.data);
  } catch (error) {
    console.error(error);
  }
}
```

Axios automatically handles the JSON request transformation in the common case.

---

# POST Request Body

The body contains the data you're sending.

Example:

```json id="m3y6h8"
{
  "name": "Yash",
  "email": "yash@example.com",
  "age": 21
}
```

The server might use this information to create:

```text id="y6c2n9"
User
├── id
├── name
├── email
└── age
```

---

# POST Response

After processing the request, the server sends a response.

Example:

```http id="p6g8m2"
HTTP/1.1 201 Created
Content-Type: application/json
```

```json id="b9s1x7"
{
  "id": 101,
  "name": "Yash",
  "email": "yash@example.com"
}
```

The frontend can then use the returned object.

```js id="e7j2w3"
const newUser = await response.json();

setUsers((prev) => [
  ...prev,
  newUser
]);
```

---

# ⭐ 201 Created

When a POST successfully creates a resource, a common response is:

```text id="z4v7j2"
201 Created
```

For example:

```text id="4k7p1q"
POST /api/products
        ↓
Product created
        ↓
201 Created
```

But the exact status code depends on the API contract.

---

# POST vs GET

This is very important.

| GET                     | POST                          |
| ----------------------- | ----------------------------- |
| Retrieve data           | Send/process data             |
| Usually no request body | Commonly has a request body   |
| `/users`                | `/users`                      |
| Read users              | Create users                  |
| Usually safe            | Can change server state       |
| Often cacheable         | Generally not cached like GET |

Notice something interesting:

```text id="k7f5a1"
GET  /api/users
POST /api/users
```

The **URL can be the same**.

The HTTP method tells the server what operation is being requested.

---

# POST vs PUT

Another common interview question.

### POST

```text id="8a5j2k"
POST /api/users
```

Commonly means:

> Create/process something within this collection.

The server may generate the new ID:

```text id="p1r9c3"
POST /users
      ↓
Server generates ID
      ↓
/users/101
```

### PUT

```text id="w6x8k4"
PUT /api/users/101
```

Generally means:

> Replace the representation of resource 101.

---

# POST vs PATCH

### POST

```text id="c5f7m1"
POST /users
```

Commonly creates a new resource or triggers an operation.

### PATCH

```text id="j3v9n2"
PATCH /users/101
```

Typically partially modifies an existing resource.

---

# POST with Authentication

A protected API may require authentication information.

Example:

```js id="w8g5r2"
await axios.post(
  "/api/orders",
  orderData,
  {
    headers: {
      Authorization: `Bearer ${token}`
    }
  }
);
```

The request contains:

```text id="x3d7q9"
POST /api/orders

Authorization: Bearer <token>

{
   order data...
}
```

The backend can authenticate and authorize the request.

---

# POST with FormData

POST can also be used for file uploads.

```js id="e5h7p2"
const formData = new FormData();

formData.append("name", "Yash");
formData.append("profile", file);

const response = await fetch("/api/profile", {
  method: "POST",
  body: formData
});
```

Here the request uses `multipart/form-data`.

Again, don't manually set the `Content-Type` header when using browser `FormData`; the browser needs to generate the multipart boundary.

---

# POST and Validation

Never rely only on frontend validation.

Frontend:

```js id="a3k7m9"
if (!form.email) {
  setError("Email required");
  return;
}
```

Then send:

```text id="q4n8r1"
POST /api/users
```

But the backend should **also validate**.

Why?

Because users can bypass the React UI and directly send HTTP requests.

Therefore:

```text id="2h6v9c"
Frontend validation
       ↓
Better UX

Backend validation
       ↓
Security + data integrity
```

---

# POST and Loading State

A user may click:

```text id="k2v7b4"
Create Account
```

multiple times.

Use a submitting state:

```jsx id="p9m4s6"
const [isSubmitting, setIsSubmitting] = useState(false);

async function handleSubmit(event) {
  event.preventDefault();

  if (isSubmitting) {
    return;
  }

  setIsSubmitting(true);

  try {
    await axios.post("/api/users", form);
  } finally {
    setIsSubmitting(false);
  }
}
```

Button:

```jsx id="w5n8q2"
<button
  type="submit"
  disabled={isSubmitting}
>
  {isSubmitting ? "Creating..." : "Create User"}
</button>
```

This improves the user experience and helps prevent accidental duplicate submissions.

However, **server-side idempotency/business rules may still be needed** when duplicate operations would be harmful.

---

# POST Error Handling

With Axios:

```jsx id="s7x2p5"
try {
  const response = await axios.post(
    "/api/users",
    form
  );

  console.log(response.data);
} catch (error) {
  if (error.response?.status === 400) {
    setError("Invalid data");
  } else if (error.response?.status === 409) {
    setError("User already exists");
  } else {
    setError("Something went wrong");
  }
}
```

Possible API responses:

```text id="j4m8n1"
400 → Invalid request
401 → Authentication problem
403 → Not permitted
409 → Conflict
422 → Validation problem
500 → Server error
```

---

# Practical Full Example

```jsx id="v6c2m8"
import { useState } from "react";
import axios from "axios";

function CreateUser() {
  const [form, setForm] = useState({
    name: "",
    email: ""
  });

  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [success, setSuccess] = useState("");

  function handleChange(event) {
    const { name, value } = event.target;

    setForm((prev) => ({
      ...prev,
      [name]: value
    }));
  }

  async function handleSubmit(event) {
    event.preventDefault();

    setError("");
    setSuccess("");

    if (!form.name || !form.email) {
      setError("All fields are required");
      return;
    }

    setLoading(true);

    try {
      const response = await axios.post(
        "/api/users",
        form
      );

      console.log("Created user:", response.data);

      setSuccess("User created successfully!");

      setForm({
        name: "",
        email: ""
      });

    } catch (error) {
      setError(
        error.response?.data?.message ||
        "Failed to create user"
      );

    } finally {
      setLoading(false);
    }
  }

  return (
    <form onSubmit={handleSubmit}>
      <input
        name="name"
        value={form.name}
        onChange={handleChange}
        placeholder="Name"
      />

      <input
        name="email"
        type="email"
        value={form.email}
        onChange={handleChange}
        placeholder="Email"
      />

      {error && <p>{error}</p>}
      {success && <p>{success}</p>}

      <button
        type="submit"
        disabled={loading}
      >
        {loading ? "Creating..." : "Create User"}
      </button>
    </form>
  );
}
```

---

# POST Mental Model

Remember this:

```text id="f8s2k4"
              POST
                ↓
         Send some data
                ↓
           API Server
                ↓
       Validate/process
                ↓
        Database/business logic
                ↓
           Response
                ↓
      ┌─────────┴─────────┐
      ↓                   ↓
   Success               Error
      ↓                   ↓
201 Created          4xx / 5xx
      ↓                   ↓
Update UI            Show error
```

---

# 🎯 Interview Questions

### Q1. What is a POST request?

> POST is an HTTP method commonly used to submit data to a server, often to create a resource or trigger a server-side operation.

---

### Q2. How do you send JSON using Fetch?

```js
await fetch("/api/users", {
  method: "POST",
  headers: {
    "Content-Type": "application/json"
  },
  body: JSON.stringify(data)
});
```

---

### Q3. How do you send JSON using Axios?

```js
await axios.post("/api/users", data);
```

---

### Q4. What is the difference between GET and POST?

> GET is primarily used to retrieve data, while POST is commonly used to submit data for processing or creation.

---

### Q5. Why is `JSON.stringify()` used with Fetch?

> Because a JavaScript object needs to be serialized into a JSON string when sending it as a JSON request body.

---

### Q6. What status code commonly indicates successful creation?

```text
201 Created
```

---

### Q7. Can POST have a request body?

**Yes.** In fact, POST commonly carries data in the request body.

---

### Q8. Should frontend validation be enough before POST?

**No.**

```text
Frontend validation
→ UX

Backend validation
→ Security + data integrity
```

---

### Q9. How do you prevent accidental duplicate POST submissions?

Use a loading/submitting state to disable the submit control, and where necessary use server-side mechanisms such as idempotency keys or unique constraints.

---

# ⭐ Remember

The core POST pattern is:

### Fetch

```js
const response = await fetch("/api/users", {
  method: "POST",
  headers: {
    "Content-Type": "application/json"
  },
  body: JSON.stringify(data)
});

if (!response.ok) {
  throw new Error("Request failed");
}

const result = await response.json();
```

### Axios

```js
const response = await axios.post(
  "/api/users",
  data
);

const result = response.data;
```

### The complete concept

```text id="y6m4p8"
POST
 ↓
SEND DATA
 ↓
SERVER
 ↓
PROCESS / CREATE
 ↓
RESPONSE
 ↓
SUCCESS or ERROR
 ↓
UPDATE REACT UI
```

### 🎯 One-line interview answer

> **A POST request is used to send data to a server, commonly to create a resource or trigger an operation, with the submitted data usually placed in the request body.**

**Next → `07 — PUT & PATCH Requests`**
