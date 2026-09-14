# 07 — PUT & PATCH Requests

**PUT** and **PATCH** are HTTP methods used to update existing resources.

If:

```text
GET    → Read
POST   → Create
PUT    → Replace
PATCH  → Partially update
DELETE → Delete
```

then PUT and PATCH are the main methods you need to understand for **updating data**.

---

## WHY?

Suppose your React application displays a user:

```json
{
  "id": 10,
  "name": "Yash",
  "email": "yash@example.com",
  "age": 21
}
```

The user changes only their name:

```text
Yash
 ↓
Yashvardhan
```

React needs to tell the backend:

```text
"Update user 10"
```

That's where PUT/PATCH come in.

---

# WHAT?

## PUT

PUT is generally used to **replace the representation of an existing resource**.

Example:

```http
PUT /api/users/10
```

Body:

```json
{
  "name": "Yashvardhan",
  "email": "yash@example.com",
  "age": 21
}
```

Think:

```text
PUT
 ↓
"Here is the new representation of this resource."
```

---

# PATCH

PATCH is generally used to **partially modify an existing resource**.

Example:

```http
PATCH /api/users/10
```

Body:

```json
{
  "name": "Yashvardhan"
}
```

Only the name needs to be changed.

Think:

```text
PATCH
 ↓
"Change this part of the resource."
```

---

# WHERE?

PUT/PATCH are commonly used for:

### Profile editing

```text
PATCH /api/users/10
```

### Product editing

```text
PATCH /api/products/25
```

### Updating an order

```text
PATCH /api/orders/100
```

### Admin dashboards

```text
PUT /api/users/10
```

### Settings

```text
PATCH /api/settings
```

---

# HOW?

## 1. PUT with Fetch

```js
const response = await fetch("/api/users/10", {
  method: "PUT",

  headers: {
    "Content-Type": "application/json"
  },

  body: JSON.stringify({
    name: "Yashvardhan",
    email: "yash@example.com",
    age: 21
  })
});

if (!response.ok) {
  throw new Error("Failed to update user");
}
```

---

# 2. PATCH with Fetch

```js
const response = await fetch("/api/users/10", {
  method: "PATCH",

  headers: {
    "Content-Type": "application/json"
  },

  body: JSON.stringify({
    name: "Yashvardhan"
  })
});

if (!response.ok) {
  throw new Error("Failed to update user");
}
```

---

# 3. PUT with Axios

Axios is simpler:

```js
const response = await axios.put(
  "/api/users/10",
  {
    name: "Yashvardhan",
    email: "yash@example.com",
    age: 21
  }
);
```

---

# 4. PATCH with Axios

```js
const response = await axios.patch(
  "/api/users/10",
  {
    name: "Yashvardhan"
  }
);
```

---

# PUT vs PATCH — Main Difference

Suppose the current user is:

```json
{
  "id": 10,
  "name": "Yash",
  "email": "yash@example.com",
  "age": 21
}
```

## PUT

You generally send the complete replacement representation:

```json
{
  "name": "Yashvardhan",
  "email": "yash@example.com",
  "age": 21
}
```

Conceptually:

```text
OLD RESOURCE
     ↓
   PUT
     ↓
REPLACE WITH NEW REPRESENTATION
```

---

## PATCH

You can send only what changed:

```json
{
  "name": "Yashvardhan"
}
```

Conceptually:

```text
OLD RESOURCE
     ↓
  PATCH
     ↓
CHANGE SPECIFIC FIELD
```

---

# ⭐ Important Interview Point

Don't say:

> PUT always requires every field.

A more accurate statement is:

> **PUT is generally defined as replacing the target resource's representation, while PATCH is designed for partial modifications. The exact API contract determines which fields are required and how missing fields are handled.**

This distinction matters because real-world APIs don't always implement textbook REST semantics perfectly.

---

# PUT Example — React Form

Suppose you have an edit profile form:

```jsx
import { useState } from "react";

function EditProfile({ user }) {
  const [form, setForm] = useState({
    name: user.name,
    email: user.email,
    age: user.age
  });

  async function handleSubmit(event) {
    event.preventDefault();

    const response = await fetch(
      `/api/users/${user.id}`,
      {
        method: "PUT",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify(form)
      }
    );

    if (!response.ok) {
      throw new Error("Update failed");
    }

    const updatedUser = await response.json();

    console.log(updatedUser);
  }

  return (
    <form onSubmit={handleSubmit}>
      <input
        value={form.name}
        onChange={(e) =>
          setForm({
            ...form,
            name: e.target.value
          })
        }
      />

      <input
        value={form.email}
        onChange={(e) =>
          setForm({
            ...form,
            email: e.target.value
          })
        }
      />

      <button type="submit">
        Save
      </button>
    </form>
  );
}
```

Flow:

```text
Edit Form
   ↓
User changes data
   ↓
Submit
   ↓
PUT /api/users/10
   ↓
Backend
   ↓
Update resource
   ↓
Response
   ↓
React UI
```

---

# PATCH Example — React

Suppose the user only changes their name.

```jsx
async function updateName(userId, name) {
  const response = await fetch(
    `/api/users/${userId}`,
    {
      method: "PATCH",

      headers: {
        "Content-Type": "application/json"
      },

      body: JSON.stringify({
        name
      })
    }
  );

  if (!response.ok) {
    throw new Error("Failed to update name");
  }

  return response.json();
}
```

Request:

```http
PATCH /api/users/10
```

```json
{
  "name": "Yashvardhan"
}
```

---

# PUT vs PATCH in CRUD

Your CRUD mapping becomes:

```text
CREATE
  ↓
POST

READ
  ↓
GET

UPDATE
  ↓
PUT / PATCH

DELETE
  ↓
DELETE
```

---

# PUT and Idempotency

This is a very common interview topic.

## What does idempotent mean?

An operation is idempotent when making the **same request multiple times has the same intended final effect as making it once**.

For example:

```http
PUT /api/users/10
```

with:

```json
{
  "name": "Yashvardhan"
}
```

Sending that same PUT repeatedly should leave the resource in the same intended state.

```text
PUT
 ↓
name = Yashvardhan

PUT again
 ↓
name = Yashvardhan

PUT again
 ↓
name = Yashvardhan
```

The result is still:

```text
name = Yashvardhan
```

---

# Is PATCH Idempotent?

**PATCH can be idempotent, but it is not inherently required to be.**

It depends on what the particular PATCH operation does.

For example:

```json
{
  "name": "Yashvardhan"
}
```

could be idempotent.

But a PATCH operation such as:

```json
{
  "operation": "increment",
  "amount": 1
}
```

could produce a different result each time.

Therefore:

```text
PUT   → defined as idempotent
PATCH → may or may not be idempotent
```

---

# PUT vs PATCH vs POST

This is a very important comparison.

| Method | Common purpose       | Example           |
| ------ | -------------------- | ----------------- |
| POST   | Create/process       | `POST /users`     |
| PUT    | Replace resource     | `PUT /users/10`   |
| PATCH  | Partial modification | `PATCH /users/10` |

Think:

```text
POST
 ↓
Create something

PUT
 ↓
Replace something

PATCH
 ↓
Change part of something
```

---

# Status Codes

After an update, the server might return:

```text
200 OK
```

if it returns the updated resource.

Or:

```text
204 No Content
```

if the update succeeded and there's no response body.

The exact response depends on the API.

---

# Error Handling

With Fetch:

```js
try {
  const response = await fetch("/api/users/10", {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      name: "Yashvardhan"
    })
  });

  if (!response.ok) {
    throw new Error(
      `Update failed: ${response.status}`
    );
  }

  const data = await response.json();

  console.log(data);

} catch (error) {
  console.error(error);
}
```

With Axios:

```js
try {
  const response = await axios.patch(
    "/api/users/10",
    {
      name: "Yashvardhan"
    }
  );

  console.log(response.data);

} catch (error) {
  console.error(error);
}
```

---

# Common Mistakes

## ❌ Mistake 1 — Thinking PUT and PATCH are identical

They're not.

```text
PUT
→ generally replacement

PATCH
→ partial modification
```

---

## ❌ Mistake 2 — Saying PATCH is always idempotent

Incorrect.

```text
PATCH → can be idempotent or non-idempotent
```

It depends on the operation.

---

## ❌ Mistake 3 — Assuming the frontend decides the API semantics

The backend/API contract decides how the endpoint behaves.

Your frontend must follow that contract.

---

## ❌ Mistake 4 — Sending incomplete data to a PUT endpoint

If the API defines PUT as a complete replacement, sending:

```json
{
  "name": "Yashvardhan"
}
```

could cause other fields to be removed/reset.

Always understand the API contract.

---

# 🎯 Interview Questions

### Q1. What is PUT?

> PUT is an HTTP method generally used to replace the representation of an existing resource.

---

### Q2. What is PATCH?

> PATCH is an HTTP method designed for partial modifications to an existing resource.

---

### Q3. Difference between PUT and PATCH?

```text
PUT
→ Replace

PATCH
→ Partial modification
```

---

### Q4. Is PUT idempotent?

**Yes, PUT is defined as idempotent.**

Repeated identical PUT requests should have the same intended final state.

---

### Q5. Is PATCH idempotent?

> PATCH is not inherently required to be idempotent; it depends on the specific patch operation.

---

### Q6. Can PUT create a resource?

It **can**, depending on the API design, particularly when the client knows the target resource URI. But in many REST APIs, POST is used for creation within a collection.

---

### Q7. Which method should you use to update only one field?

Usually:

```text
PATCH
```

if the API supports partial updates.

---

### Q8. What status codes can an update return?

Common examples:

```text
200 OK
204 No Content
```

---

# ⭐ Remember

```text
             UPDATE
                │
        ┌───────┴───────┐
        ↓               ↓
       PUT            PATCH
        ↓               ↓
   Replace          Partial
   resource         update
```

Example:

```text
PUT /users/10

{
  name,
  email,
  age
}
```

vs.

```text
PATCH /users/10

{
  name
}
```

### 🎯 One-line interview answer

> **PUT is generally used to replace an existing resource representation, while PATCH is used to partially modify an existing resource.**

**Next → `08 — DELETE Request`**
