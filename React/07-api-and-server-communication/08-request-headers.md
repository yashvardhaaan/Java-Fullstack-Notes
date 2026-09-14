# 08 — DELETE Request

A **DELETE request** is an HTTP request used to ask a server to **delete a resource**.

If you remember CRUD:

```text
CREATE → POST
READ   → GET
UPDATE → PUT / PATCH
DELETE → DELETE
```

---

## WHY?

Suppose an admin wants to remove a product:

```text
Product #25
       ↓
    Delete
       ↓
React
       ↓
DELETE /api/products/25
       ↓
Backend
       ↓
Database
       ↓
Product removed
```

React should not directly manipulate the database.

Instead, it asks the backend to perform the deletion.

---

# WHAT?

## What is a DELETE request?

A DELETE request tells the server:

> **"Delete this resource."**

Example:

```http
DELETE /api/products/25
```

The `25` identifies the resource to delete.

The server might respond:

```http
204 No Content
```

or:

```http
200 OK
```

depending on the API design.

---

# WHERE?

DELETE is commonly used for:

### Delete user

```text
DELETE /api/users/10
```

### Delete product

```text
DELETE /api/products/25
```

### Delete post

```text
DELETE /api/posts/100
```

### Remove an item

```text
DELETE /api/cart/items/5
```

### Admin dashboard

```text
React
 ↓
Delete button
 ↓
DELETE API
 ↓
Backend
```

---

# HOW?

## 1. DELETE Using Fetch

Basic example:

```js
async function deleteUser(userId) {
  const response = await fetch(
    `/api/users/${userId}`,
    {
      method: "DELETE"
    }
  );

  if (!response.ok) {
    throw new Error("Failed to delete user");
  }
}
```

Usage:

```js
await deleteUser(25);
```

Request:

```http
DELETE /api/users/25
```

---

# 2. DELETE Using Axios

With Axios:

```js
async function deleteUser(userId) {
  await axios.delete(
    `/api/users/${userId}`
  );
}
```

Very simple:

```js
axios.delete("/api/users/25");
```

---

# 3. DELETE from a React Component

Suppose we have a product list:

```jsx
import { useState } from "react";

function Products() {
  const [products, setProducts] = useState([
    { id: 1, name: "Laptop" },
    { id: 2, name: "Phone" },
    { id: 3, name: "Keyboard" }
  ]);

  async function handleDelete(id) {
    const response = await fetch(
      `/api/products/${id}`,
      {
        method: "DELETE"
      }
    );

    if (!response.ok) {
      throw new Error("Delete failed");
    }

    setProducts((prev) =>
      prev.filter((product) => product.id !== id)
    );
  }

  return (
    <div>
      {products.map((product) => (
        <div key={product.id}>
          <span>{product.name}</span>

          <button
            type="button"
            onClick={() => handleDelete(product.id)}
          >
            Delete
          </button>
        </div>
      ))}
    </div>
  );
}
```

The important part:

```js
setProducts((prev) =>
  prev.filter(
    (product) => product.id !== id
  )
);
```

After the server successfully deletes the resource, we remove it from the React UI.

---

# Complete Flow

```text
User clicks Delete
       ↓
handleDelete(id)
       ↓
DELETE /api/products/25
       ↓
Backend
       ↓
Database deletion
       ↓
Response
       ↓
Success?
       ↓
setProducts()
       ↓
React re-renders
       ↓
Product disappears
```

---

# ⭐ Important: Delete From UI Only After Success

Suppose you do this:

```js
setProducts((prev) =>
  prev.filter((p) => p.id !== id)
);

await fetch(`/api/products/${id}`, {
  method: "DELETE"
});
```

The UI removes the product **before the server confirms deletion**.

What if the request fails?

```text
UI
 ↓
Product disappears ❌

API
 ↓
Delete failed ❌
```

Now the UI and server can be inconsistent.

A safer basic pattern is:

```js
const response = await fetch(
  `/api/products/${id}`,
  {
    method: "DELETE"
  }
);

if (!response.ok) {
  throw new Error("Delete failed");
}

setProducts((prev) =>
  prev.filter((product) => product.id !== id)
);
```

---

# 4. DELETE with Loading State

For individual delete buttons, you might track which item is being deleted.

```jsx
const [deletingId, setDeletingId] = useState(null);

async function handleDelete(id) {
  setDeletingId(id);

  try {
    const response = await fetch(
      `/api/products/${id}`,
      {
        method: "DELETE"
      }
    );

    if (!response.ok) {
      throw new Error("Delete failed");
    }

    setProducts((prev) =>
      prev.filter((product) => product.id !== id)
    );

  } catch (error) {
    console.error(error);

  } finally {
    setDeletingId(null);
  }
}
```

Button:

```jsx
<button
  type="button"
  disabled={deletingId === product.id}
  onClick={() => handleDelete(product.id)}
>
  {deletingId === product.id
    ? "Deleting..."
    : "Delete"}
</button>
```

This prevents repeated clicks while that particular deletion is in progress.

---

# 5. DELETE with Axios

```jsx
async function handleDelete(id) {
  try {
    await axios.delete(
      `/api/products/${id}`
    );

    setProducts((prev) =>
      prev.filter(
        (product) => product.id !== id
      )
    );

  } catch (error) {
    console.error(
      "Delete failed:",
      error
    );
  }
}
```

Axios generally rejects for non-2xx HTTP responses, so the error goes to `catch`.

---

# 6. DELETE Response

A DELETE request can return different successful responses depending on the API.

### 204 No Content

```http
HTTP/1.1 204 No Content
```

This means:

> The operation succeeded and there is no response body.

In this case, don't blindly do:

```js
await response.json();
```

because there may be nothing to parse.

---

### 200 OK

The server might instead return:

```http
HTTP/1.1 200 OK
```

with information about the operation.

For example:

```json
{
  "message": "Product deleted"
}
```

---

# 7. DELETE Error Handling

Possible responses:

```text
404 → Resource doesn't exist
401 → Authentication problem
403 → Not allowed to delete
409 → Conflict
500 → Server error
```

Example:

```js
try {
  const response = await fetch(
    `/api/products/${id}`,
    {
      method: "DELETE"
    }
  );

  if (!response.ok) {
    if (response.status === 404) {
      throw new Error("Product not found");
    }

    if (response.status === 403) {
      throw new Error(
        "You don't have permission"
      );
    }

    throw new Error("Delete failed");
  }

} catch (error) {
  setError(error.message);
}
```

---

# 8. DELETE with Authentication

Protected APIs commonly require authentication.

With Axios:

```js
await axios.delete(
  `/api/products/${id}`,
  {
    headers: {
      Authorization: `Bearer ${token}`
    }
  }
);
```

Request:

```http
DELETE /api/products/25
Authorization: Bearer <token>
```

The backend should determine whether the authenticated user is actually authorized to delete that resource.

---

# 9. Should DELETE Have a Body?

HTTP does not universally forbid a DELETE request body, but many APIs don't use one.

Common pattern:

```text
DELETE /api/products/25
```

instead of:

```text
DELETE /api/products
```

with:

```json
{
  "id": 25
}
```

Follow the API's contract.

---

# 10. DELETE and Confirmation

For destructive actions, you often shouldn't immediately delete when the user clicks.

Instead:

```text
Delete
  ↓
Are you sure?
  ↓
Cancel / Confirm
  ↓
DELETE API
```

Example:

```jsx
function handleDelete(id) {
  const confirmed = window.confirm(
    "Are you sure you want to delete this product?"
  );

  if (!confirmed) {
    return;
  }

  deleteProduct(id);
}
```

For a production application, a custom accessible confirmation dialog is often preferable to `window.confirm()`.

---

# 11. DELETE and Optimistic UI

There's another advanced approach.

You can remove the item immediately:

```text
Click Delete
    ↓
Remove from UI immediately
    ↓
DELETE API
```

If the API fails:

```text
API fails
   ↓
Restore item
   ↓
Show error
```

This is called **optimistic UI**.

It can make applications feel faster, but it requires careful rollback/error handling.

For beginners, the simpler pattern is:

```text
API success
   ↓
Update UI
```

---

# DELETE vs POST for Deletion

Some APIs may use:

```text
DELETE /products/25
```

which is the conventional REST-style approach.

But some legacy or action-oriented APIs may use something like:

```text
POST /products/25/delete
```

The frontend should follow the API contract.

REST-style resource operations generally prefer the appropriate HTTP method rather than encoding the action into the URL.

---

# DELETE and Idempotency

DELETE is defined as **idempotent**.

Example:

```text
DELETE /users/25
```

First request:

```text
User 25 exists
     ↓
Delete
     ↓
User 25 removed
```

Second identical request:

```text
User 25 already gone
     ↓
Final state remains "not present"
```

The response can differ—for example, the first might return `204` and the second `404`—while the intended final state remains the same.

That's an important distinction:

> **Idempotent does not mean every response must be identical.**

---

# CRUD Complete

You now have the complete basic CRUD mapping:

```text
             CRUD
              │
    ┌─────────┼─────────┐
    ↓         ↓         ↓
 CREATE      READ      UPDATE      DELETE
    ↓         ↓         ↓            ↓
   POST      GET     PUT/PATCH      DELETE
```

Example for products:

```text
POST   /api/products
GET    /api/products
GET    /api/products/25
PUT    /api/products/25
PATCH  /api/products/25
DELETE /api/products/25
```

---

# 🎯 Interview Questions

### Q1. What is a DELETE request?

> DELETE is an HTTP method used to request deletion of a resource identified by the target URI.

---

### Q2. How do you make a DELETE request with Fetch?

```js
await fetch("/api/users/10", {
  method: "DELETE"
});
```

---

### Q3. How do you make a DELETE request with Axios?

```js
await axios.delete("/api/users/10");
```

---

### Q4. What status code can a successful DELETE return?

Common examples:

```text
204 No Content
200 OK
```

---

### Q5. Is DELETE idempotent?

> Yes. DELETE is defined as idempotent, although repeated requests can still receive different status codes.

---

### Q6. Should you update the React UI before the DELETE request succeeds?

Usually, for a simple implementation:

> No. Wait for successful deletion before removing the item from UI.

For advanced applications, optimistic updates can be used with rollback handling.

---

### Q7. How do you prevent multiple delete requests?

Use a loading/deleting state:

```jsx
<button disabled={deletingId === id}>
```

---

### Q8. Can DELETE have a request body?

> HTTP doesn't universally prohibit a DELETE body, but its semantics are not generally defined by the protocol, and many APIs don't use one. Follow the API contract.

---

# ⭐ Remember

```text
DELETE
   ↓
Identify resource
   ↓
DELETE /api/products/25
   ↓
Backend
   ↓
Delete resource
   ↓
Response
   ↓
Success?
   ↓
Update React state
   ↓
UI updates
```

### 🎯 One-line interview answer

> **DELETE is an HTTP method used to request removal of a resource, typically identified by its URL, such as `DELETE /api/products/25`.**

**Next → `09 — Loading State`**
