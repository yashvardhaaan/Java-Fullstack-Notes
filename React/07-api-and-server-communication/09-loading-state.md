# 09 — Loading State

A **loading state** tells the user that an asynchronous operation is currently in progress.

In React applications, you'll use loading states constantly when working with APIs.

---

## WHY?

Consider this:

```text id="x8m2q1"
User opens Products page
        ↓
API request starts
        ↓
          ?
        ↓
API response arrives
```

The request may take:

* 100 ms
* 1 second
* 5 seconds
* longer because of a slow network

Without a loading state, the user may see:

```text
Products: []
```

and think:

> "Is the application broken?"

Instead, show:

```text
Loading products...
```

So the user understands what is happening.

---

# WHAT?

A loading state is simply a piece of React state representing whether an asynchronous operation is currently running.

Basic example:

```jsx id="v6j9ak"
const [loading, setLoading] = useState(false);
```

When the request starts:

```js id="c9b1s4"
setLoading(true);
```

When it finishes:

```js id="q7p2mx"
setLoading(false);
```

Conceptually:

```text id="8n5j4f"
loading = false
      ↓
Request starts
      ↓
loading = true
      ↓
Request finishes
      ↓
loading = false
```

---

# WHERE?

Loading states are used for:

### GET requests

```text id="1y3w7p"
Loading users...
```

### POST requests

```text id="5v8k2q"
Creating account...
```

### PUT/PATCH

```text id="7j2m6a"
Saving changes...
```

### DELETE

```text id="3f6q9r"
Deleting...
```

### Search

```text id="2p7x4m"
Searching...
```

### File uploads

```text id="6n8b1c"
Uploading...
```

---

# HOW?

## 1. Basic Loading State

```jsx id="7k4m2n"
import { useState } from "react";

function Users() {
  const [loading, setLoading] = useState(false);

  return (
    <div>
      {loading && <p>Loading...</p>}
    </div>
  );
}
```

The `&&` operator conditionally renders the message.

If:

```js id="b5q7x1"
loading === true
```

React renders:

```text
Loading...
```

If:

```js id="m8c3v6"
loading === false
```

nothing is rendered.

---

# 2. Loading During GET

A common pattern:

```jsx id="f8w2j5"
import { useEffect, useState } from "react";

function Users() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function loadUsers() {
      try {
        const response = await fetch("/api/users");

        if (!response.ok) {
          throw new Error("Failed to fetch users");
        }

        const data = await response.json();

        setUsers(data);
      } finally {
        setLoading(false);
      }
    }

    loadUsers();
  }, []);

  if (loading) {
    return <p>Loading users...</p>;
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

Notice:

```js id="i8z5y3"
setLoading(false);
```

is inside `finally`.

That means loading stops whether the request:

```text
succeeds
```

or:

```text
fails
```

---

# WHY `finally`?

Suppose:

```js id="g7m2q9"
try {
  // API
} catch (error) {
  // error
} finally {
  setLoading(false);
}
```

`finally` runs after the operation completes regardless of whether an exception occurred.

This makes it a good place for cleanup such as:

```js id="3a8k5d"
setLoading(false);
```

---

# 3. Loading + Error + Data

A realistic API component often has three states:

```text id="j4c8v2"
Loading
Error
Success
```

Example:

```jsx id="m7q1x9"
function Users() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  async function loadUsers() {
    setLoading(true);
    setError("");

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
}
```

UI:

```jsx id="v3h8s1"
if (loading) {
  return <p>Loading...</p>;
}

if (error) {
  return <p>Error: {error}</p>;
}

return <UsersList users={users} />;
```

---

# State Flow

Think of it as:

```text id="8y4r2p"
        Start
          ↓
      Loading=true
          ↓
      API request
       /       \
      ↓         ↓
  Success      Error
      ↓         ↓
   Data        Error
      \         /
       ↓       ↓
      Loading=false
```

---

# 4. Loading State for POST

Loading isn't only for GET requests.

Suppose you're creating a user:

```jsx id="w5x8c2"
const [isSubmitting, setIsSubmitting] = useState(false);

async function handleSubmit(event) {
  event.preventDefault();

  setIsSubmitting(true);

  try {
    await axios.post("/api/users", form);
  } catch (error) {
    console.error(error);
  } finally {
    setIsSubmitting(false);
  }
}
```

Button:

```jsx id="p4n7y9"
<button
  type="submit"
  disabled={isSubmitting}
>
  {isSubmitting
    ? "Creating..."
    : "Create User"}
</button>
```

This is often called:

```text id="w9m4j6"
isSubmitting
```

rather than simply `loading`, because it describes the operation more specifically.

---

# 5. Loading State for DELETE

```jsx id="s3f7n2"
const [deletingId, setDeletingId] = useState(null);

async function handleDelete(id) {
  setDeletingId(id);

  try {
    await axios.delete(`/api/users/${id}`);

    setUsers((prev) =>
      prev.filter((user) => user.id !== id)
    );
  } finally {
    setDeletingId(null);
  }
}
```

Button:

```jsx id="a8m2k5"
<button
  disabled={deletingId === user.id}
  onClick={() => handleDelete(user.id)}
>
  {deletingId === user.id
    ? "Deleting..."
    : "Delete"}
</button>
```

Why use an ID instead of:

```js id="z5q7v3"
const [loading, setLoading]
```

Because you may have many users:

```text
User 1 → Delete
User 2 → Delete
User 3 → Delete
```

You usually want only the affected button to show:

```text
Deleting...
```

---

# 6. Global Loading vs Local Loading

This is important when designing applications.

## Local loading

Only one component/operation is loading.

Example:

```text id="g5j9s2"
Product list
   ↓
Loading products...
```

Use local state when only that part of the UI needs to respond.

---

## Global loading

The whole application may need to know about an operation.

For example:

```text id="k2v8p4"
Application
     ↓
Global authentication refresh
     ↓
Several components depend on it
```

For complex applications, global server-state libraries or shared application state may be appropriate.

Don't automatically make every loading state global.

---

# 7. Loading Spinner

Instead of:

```jsx id="j3r7w8"
<p>Loading...</p>
```

you can use a spinner:

```jsx id="u5k9q2"
function Spinner() {
  return <div role="status">Loading...</div>;
}
```

Then:

```jsx id="m6f2p8"
{loading && <Spinner />}
```

Accessibility is important.

For example:

```jsx id="c7x4n1"
<div role="status">
  Loading users...
</div>
```

A screen reader can communicate the status appropriately.

---

# 8. Skeleton Loading

A modern UI often uses a **skeleton** instead of a spinner.

Instead of:

```text
Loading...
```

you might show:

```text
┌────────────────────┐
│ ████████████████   │
│ ██████████         │
│ ██████████████     │
└────────────────────┘
```

This is called:

> **Skeleton loading**

It's particularly useful when you know approximately what the final content will look like.

---

# 9. Button Loading

For actions such as:

```text
Save
Delete
Login
Submit
```

a button-level loading indicator is often better than blocking the entire page.

Example:

```jsx id="b6y2w9"
<button
  disabled={isSubmitting}
>
  {isSubmitting ? "Saving..." : "Save"}
</button>
```

This tells the user:

> The click worked; we're processing it.

---

# 10. Don't Hide Existing Data Unnecessarily

Suppose a user already has product data:

```text
Laptop
Phone
Keyboard
```

Then they refresh the data.

You could replace everything with:

```text
Loading...
```

But this can create a poor experience.

A better pattern can be:

```text
Existing data
     +
small loading indicator
     ↓
Fresh data
```

For example:

```jsx id="x9v3r2"
<div>
  {isRefreshing && (
    <span>Refreshing...</span>
  )}

  <ProductList products={products} />
</div>
```

This distinction becomes important when you later work with **server-state/data-fetching libraries**.

---

# 11. Loading vs Fetching

These terms can mean slightly different things.

### Initial loading

No data exists yet:

```text id="b7k4m2"
Page opens
 ↓
No products
 ↓
Loading...
 ↓
Products arrive
```

### Refetching

Data already exists:

```text id="c8p5x1"
Products displayed
 ↓
Refresh request
 ↓
Products remain visible
 +
Refreshing...
 ↓
New data
```

This distinction leads to better UX.

---

# 12. Avoid Infinite Loading

A common mistake:

```jsx id="x4j8m3"
setLoading(true);

try {
  await fetch(...);
} catch (error) {
  console.log(error);
}

// ❌ forgot setLoading(false)
```

Now:

```text
loading = true
```

forever.

Better:

```jsx id="j9q2v5"
try {
  await fetch(...);
} finally {
  setLoading(false);
}
```

---

# 13. Loading with Axios

```jsx id="k6m8q1"
async function loadProducts() {
  setLoading(true);
  setError("");

  try {
    const response = await axios.get(
      "/api/products"
    );

    setProducts(response.data);
  } catch (error) {
    setError("Failed to load products");
  } finally {
    setLoading(false);
  }
}
```

---

# 14. React Hook Form

You already learned React Hook Form.

It provides:

```js id="f8q2m7"
formState.isSubmitting
```

Example:

```jsx id="z3w6p9"
const {
  register,
  handleSubmit,
  formState: {
    isSubmitting
  }
} = useForm();

async function onSubmit(data) {
  await axios.post(
    "/api/users",
    data
  );
}
```

Button:

```jsx id="x7k4b2"
<button
  type="submit"
  disabled={isSubmitting}
>
  {isSubmitting
    ? "Submitting..."
    : "Submit"}
</button>
```

So you don't always need to manually create:

```js id="m2v8c6"
const [isSubmitting, setIsSubmitting]
```

when the library already provides the state you need.

---

# Common Mistakes

## ❌ 1. Loading never becomes false

```js id="p6h3n9"
setLoading(true);

// request

// ❌ forgot false
```

Use:

```js id="r4k7x2"
finally {
  setLoading(false);
}
```

---

## ❌ 2. Disabling the entire application unnecessarily

Don't do:

```text id="v8m2j4"
API request
 ↓
Entire application disabled
```

if only one button needs to be disabled.

Prefer localized loading where appropriate.

---

## ❌ 3. Using one loading state for unrelated requests

For example:

```js id="e3q7w9"
const [loading, setLoading] = useState(false);
```

for:

```text
User request
Product request
Order request
```

can create confusing behavior.

Use more specific states when operations are independent:

```js id="r2n6p8"
usersLoading
productsLoading
ordersLoading
```

or use an appropriate data-fetching abstraction.

---

## ❌ 4. Showing only a blank screen

Avoid:

```text id="m9c3x5"
[ blank page ]
```

during an API request.

Give the user feedback:

```text
Loading...
```

or a skeleton.

---

# 🎯 Interview Questions

### Q1. What is loading state?

> Loading state represents whether an asynchronous operation, such as an API request, is currently in progress.

---

### Q2. Why do we need loading states?

> To provide feedback to users while asynchronous operations are running and prevent confusion or repeated actions.

---

### Q3. Why use `finally`?

> `finally` executes after the operation completes whether it succeeds or fails, making it useful for cleanup such as turning off a loading indicator.

---

### Q4. How do you prevent duplicate form submissions?

```jsx id="t8k3m6"
<button disabled={isSubmitting}>
```

---

### Q5. What is the difference between loading and refreshing?

> Initial loading usually means there is no data yet, while refreshing/refetching means existing data is being requested again.

---

### Q6. Should you always hide existing data during loading?

> No. For refetching, keeping existing data visible while showing a smaller refresh indicator can provide a better user experience.

---

### Q7. What is skeleton loading?

> Skeleton loading displays placeholder UI that approximates the final content while actual data is being fetched.

---

# ⭐ Remember

The basic pattern is:

```text id="n7v3c9"
          API Request
               ↓
         loading = true
               ↓
          Show loading
               ↓
             Fetch
          /         \
         ↓           ↓
     Success       Error
         ↓           ↓
        Data        Error
         \           /
          ↓         ↓
         finally
             ↓
       loading = false
```

### Basic code pattern

```js id="x4m8q2"
setLoading(true);

try {
  const response = await fetch("/api/users");

  if (!response.ok) {
    throw new Error("Request failed");
  }

  const data = await response.json();

  setUsers(data);
} catch (error) {
  setError(error.message);
} finally {
  setLoading(false);
}
```

### 🎯 One-line interview answer

> **A loading state represents an ongoing asynchronous operation and provides feedback to the user while the application waits for an API response or other asynchronous work to finish.**

**Next → `10 — Error State`**
