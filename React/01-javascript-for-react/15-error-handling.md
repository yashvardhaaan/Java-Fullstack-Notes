# 14 — Error Handling

Error handling is not just about writing:

```js
try {
  // code
} catch (error) {
  // error
}
```

In real applications, errors happen everywhere:

```text
Frontend
   ↓
API request
   ↓
Backend
   ↓
Database
   ↓
External service
```

Something can fail at any layer.

Your goal as a developer is to learn to answer:

> **What failed, where did it fail, why did it fail, and what should the application do about it?**

---

# 1. What is an error?

An error means something went wrong while the program was executing.

Example:

```js
const user = null;

console.log(user.name);
```

JavaScript cannot access `name` from `null`.

So it throws an error.

---

# 2. Why do we need error handling?

Without handling:

```js
const data = await fetchData();

console.log(data);
```

If `fetchData()` fails, the failure may propagate and cause unexpected behavior.

With handling:

```js
try {
  const data = await fetchData();

  console.log(data);
} catch (error) {
  console.error(error);
}
```

you explicitly decide what happens when something fails.

---

# 3. `try / catch`

Basic syntax:

```js
try {
  // code that might fail
} catch (error) {
  // handle error
}
```

Example:

```js
try {
  const result = JSON.parse("invalid json");

  console.log(result);
} catch (error) {
  console.error("Something went wrong");
}
```

The program doesn't simply crash at that point.

---

# 4. Understanding the `error` object

Inside:

```js
catch (error) {
}
```

`error` contains information about the failure.

For example:

```js
try {
  throw new Error("Database connection failed");
} catch (error) {
  console.log(error.message);
}
```

Result:

```text
Database connection failed
```

You can also inspect:

```js
console.log(error.name);
console.log(error.stack);
```

Typical properties:

```text
error.name
error.message
error.stack
```

---

# 5. `throw`

You can create your own error:

```js
throw new Error("Something went wrong");
```

Example:

```js
function withdraw(balance, amount) {
  if (amount > balance) {
    throw new Error("Insufficient balance");
  }

  return balance - amount;
}
```

Then:

```js
try {
  const remaining = withdraw(1000, 2000);
} catch (error) {
  console.error(error.message);
}
```

This is useful when **your code detects an invalid situation**.

---

# 6. Why `throw` is important with APIs

Remember:

```js
const response = await fetch("/api/users");
```

A `404` or `500` HTTP response doesn't automatically mean `fetch()` rejects.

So you can explicitly convert an HTTP failure into a JavaScript error:

```js
const response = await fetch("/api/users");

if (!response.ok) {
  throw new Error(
    `Request failed: ${response.status}`
  );
}
```

Then:

```js
try {
  const response = await fetch("/api/users");

  if (!response.ok) {
    throw new Error("Failed to fetch users");
  }

  const users = await response.json();

} catch (error) {
  console.error(error);
}
```

This is a **very important production pattern**.

---

# 7. `try/catch` with `async/await`

Typical API function:

```js
async function getUsers() {
  try {
    const response = await fetch("/api/users");

    if (!response.ok) {
      throw new Error(
        `HTTP Error: ${response.status}`
      );
    }

    return await response.json();

  } catch (error) {
    console.error("getUsers failed:", error);

    throw error;
  }
}
```

Notice the final:

```js
throw error;
```

Why?

Because the service logged the error, but the caller may also need to handle it.

---

# 8. Why re-throw an error?

Suppose:

```text
React Component
       ↓
userService.js
       ↓
fetch()
```

The service detects the failure:

```js
catch (error) {
  console.error(error);
  throw error;
}
```

Now the component can decide what the user should see:

```js
try {
  const users = await getUsers();
  setUsers(users);
} catch (error) {
  setError("Unable to load users");
}
```

This separates:

```text
Technical error
      ↓
Service layer

User-friendly message
      ↓
UI layer
```

That's much better architecture.

---

# 9. Don't show technical errors directly to users

Avoid:

```jsx
<p>{error.stack}</p>
```

or:

```jsx
<p>{error.message}</p>
```

in many production UIs.

The technical error might say:

```text
TypeError: Cannot read properties of undefined...
```

A user doesn't need that.

Instead:

```jsx
<p>Unable to load your profile. Please try again.</p>
```

Meanwhile, developers can log the technical error.

---

# 10. Error handling has multiple layers

A useful mental model:

```text
             ERROR
               │
      ┌────────┼─────────┐
      ↓        ↓         ↓
Network     HTTP       Data
 failure    error      error
      │        │         │
      └────────┼─────────┘
               ↓
          Error handling
               ↓
      ┌────────┴────────┐
      ↓                 ↓
Developer            User
logging              message
```

For example:

```text
Network unavailable
        ↓
Developer:
"Failed to fetch /api/users"

User:
"Unable to load users. Check your connection."
```

---

# 11. Common types of frontend errors

### 1. JavaScript errors

Example:

```js
user.name
```

when `user` is `undefined`.

---

### 2. Network errors

For example:

```text
Internet disconnected
Server unreachable
DNS failure
Request blocked
```

---

### 3. HTTP errors

Examples:

```text
400 Bad Request
401 Unauthorized
403 Forbidden
404 Not Found
500 Internal Server Error
```

---

### 4. Data errors

The backend may return something unexpected.

Expected:

```js
{
  name: "Yash"
}
```

Received:

```js
{
  username: 123
}
```

Your frontend might fail if it assumes the wrong structure.

---

# 12. HTTP errors are not all the same

When working with your Spring Boot backend, understand the meaning:

```text
400
↓
Client sent invalid request

401
↓
Authentication required/failed

403
↓
Authenticated but not allowed

404
↓
Resource not found

500
↓
Server-side failure
```

This distinction becomes extremely useful when debugging frontend ↔ backend problems.

---

# 13. Practical React API example

```jsx
async function loadUsers() {
  setLoading(true);
  setError(null);

  try {
    const response = await fetch(
      "http://localhost:8080/api/users"
    );

    if (!response.ok) {
      throw new Error(
        `HTTP ${response.status}`
      );
    }

    const data = await response.json();

    setUsers(data);

  } catch (error) {
    console.error("API Error:", error);

    setError(
      "Unable to load users. Please try again."
    );

  } finally {
    setLoading(false);
  }
}
```

The important flow:

```text
Start
 ↓
loading = true
 ↓
API request
 ↓
 ┌───────────────┐
 │               │
Success         Failure
 │               │
 ↓               ↓
data          catch
 │               │
 ↓               ↓
setUsers       setError
 │               │
 └───────┬───────┘
         ↓
      finally
         ↓
loading = false
```

---

# 14. `finally`

`finally` executes whether the operation succeeds or fails.

```js
try {
  await fetchData();
} catch (error) {
  console.error(error);
} finally {
  setLoading(false);
}
```

This is perfect for loading states.

Without `finally`, you might accidentally leave:

```text
Loading...
```

on the screen forever after an error.

---

# 15. Nested `try/catch`

You can technically have:

```js
try {
  try {
    riskyOperation();
  } catch (error) {
    console.log("Inner error");
  }
} catch (error) {
  console.log("Outer error");
}
```

But don't use nested `try/catch` unnecessarily.

Prefer clear error boundaries between meaningful layers.

---

# 16. Custom Errors

You can create custom error classes.

```js
class ApiError extends Error {
  constructor(message, status) {
    super(message);

    this.name = "ApiError";
    this.status = status;
  }
}
```

Then:

```js
throw new ApiError(
  "User not found",
  404
);
```

Handle it:

```js
try {
  await getUser();
} catch (error) {
  if (error instanceof ApiError) {
    console.log(error.status);
  }
}
```

This becomes useful in larger applications where different errors need different handling.

---

# 17. `instanceof`

You can check what kind of error you received:

```js
if (error instanceof TypeError) {
  console.log("Type error");
}
```

Or your custom error:

```js
if (error instanceof ApiError) {
  console.log("API error");
}
```

This lets your application distinguish between error types.

---

# 18. Validation errors

Suppose your form requires an email.

```js
function validateEmail(email) {
  if (!email.includes("@")) {
    throw new Error("Invalid email");
  }
}
```

Then:

```js
try {
  validateEmail("hello");
} catch (error) {
  console.log(error.message);
}
```

But in a real React form, you often don't want to use exceptions for ordinary user input validation.

For example:

```text
User forgot email
      ↓
Normal validation state

Backend/database failure
      ↓
Error handling
```

This distinction is important.

> **Not every invalid input is an exceptional application failure.**

---

# 19. Don't swallow errors

A common bad pattern:

```js
try {
  await saveUser();
} catch (error) {
  console.log(error);
}
```

and then continue as if everything succeeded.

This can make debugging very difficult.

If the caller needs to know:

```js
catch (error) {
  console.error(error);
  throw error;
}
```

Or handle it appropriately.

---

# 20. Error handling in service architecture

For a React + Spring Boot application:

```text
React Component
       ↓
Service
       ↓
HTTP request
       ↓
Spring Boot Controller
       ↓
Service
       ↓
Database
```

Errors can travel back:

```text
Database failure
      ↓
Spring Boot
      ↓
HTTP 500
      ↓
React service
      ↓
throw Error
      ↓
React component
      ↓
User-friendly message
```

This is a very useful mental model for debugging full-stack applications.

---

# 21. Practical example — Login

Suppose:

```js
async function login(credentials) {
  const response = await fetch(
    "http://localhost:8080/api/auth/login",
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(credentials)
    }
  );

  if (!response.ok) {
    if (response.status === 401) {
      throw new Error("Invalid credentials");
    }

    throw new Error("Login failed");
  }

  return response.json();
}
```

Component:

```js
async function handleLogin() {
  try {
    const data = await login({
      email,
      password
    });

    console.log("Logged in:", data);

  } catch (error) {
    setError(error.message);
  }
}
```

Flow:

```text
User submits login
       ↓
React
       ↓
POST /api/auth/login
       ↓
Spring Boot
       ↓
Authentication
       ↓
Success / 401 / 500
       ↓
React handles result
```

This is directly applicable to applications using JWT authentication.

---

# 22. Error handling while parsing JSON

Sometimes the server may return an unexpected response.

```js
try {
  const response = await fetch("/api/users");

  if (!response.ok) {
    throw new Error("Request failed");
  }

  const data = await response.json();

  return data;

} catch (error) {
  console.error(error);
}
```

If parsing fails, `response.json()` can throw/reject and the `catch` handles it.

---

# 23. Debugging errors

When something fails, don't immediately change random code.

Use this process:

```text
1. Read the error
       ↓
2. Find the exact line
       ↓
3. Identify the layer
       ↓
4. Inspect the input
       ↓
5. Reproduce the problem
       ↓
6. Determine expected vs actual
       ↓
7. Fix the root cause
       ↓
8. Test again
```

For example:

```text
React shows "Failed to fetch"
          ↓
Open DevTools
          ↓
Network tab
          ↓
Request = 403
          ↓
Backend/security issue
          ↓
Check Authorization header
          ↓
Check JWT
```

This is much more valuable than memorizing error messages.

---

# 24. Don't confuse errors with expected states

For example:

```text
User hasn't logged in
```

might be an expected application state.

Whereas:

```text
JWT validation crashed unexpectedly
```

is an error.

Similarly:

```text
Search returned zero products
```

isn't necessarily an error.

It's a valid result:

```js
[]
```

This distinction helps you design better UI and error handling.

---

# 25. Common mistakes

### Mistake 1 — No `response.ok` check

```js
const response = await fetch("/api/users");

const data = await response.json();
```

Better:

```js
if (!response.ok) {
  throw new Error("Request failed");
}
```

---

### Mistake 2 — Showing technical errors to users

Avoid:

```jsx
<p>{error.stack}</p>
```

Prefer a user-friendly message.

---

### Mistake 3 — Catching and ignoring

Bad:

```js
catch (error) {
  // nothing
}
```

This hides failures.

---

### Mistake 4 — Using exceptions for normal control flow

Don't throw errors for every ordinary validation condition.

---

### Mistake 5 — Fixing symptoms instead of the root cause

If you receive:

```text
403 Forbidden
```

don't immediately change random frontend code.

Ask:

```text
Who returned 403?
       ↓
Backend?
       ↓
Why?
       ↓
Authentication?
Authorization?
JWT?
CORS?
Endpoint permissions?
```

That's debugging thinking.

---

# 26. Interview Questions

### Q1. What is error handling?

The process of detecting, propagating, logging, and responding to failures without causing uncontrolled application behavior.

### Q2. What does `try/catch` do?

It allows potentially throwing code to be executed and handles errors that propagate to the corresponding `catch`.

### Q3. What does `throw` do?

It explicitly creates/propagates an exception.

### Q4. Why check `response.ok` with `fetch()`?

Because `fetch()` doesn't normally reject solely because the HTTP response status is 4xx or 5xx.

### Q5. Why use `finally`?

For cleanup that should happen regardless of success or failure, such as stopping a loading indicator.

### Q6. Why re-throw errors?

So a lower-level function can log or enrich an error while allowing the caller to decide how to handle it.

### Q7. Difference between 401 and 403?

```text
401
→ authentication is missing/invalid

403
→ request is understood/authenticated but access is not allowed
```

---

# 27. Practice

Create `practice.js`:

```js
// 1. Create a try/catch example.

// 2. Create and throw a custom Error.

// 3. Access error.message.

// 4. Access error.stack.

// 5. Create an async function with try/catch.

// 6. Fetch an API and check response.ok.

// 7. Throw an Error when response.ok is false.

// 8. Use finally to stop a loading state.

// 9. Create a custom ApiError class.

// 10. Handle 401 differently from 500.

// 11. Create a React API function that:
//     - sends request
//     - handles HTTP errors
//     - returns data
//     - rethrows errors

// 12. Create a React component that:
//     - displays loading
//     - displays data on success
//     - displays a friendly error on failure.

// 13. Explain why an empty search result
//     isn't necessarily an error.

// 14. Take a fake 403 error and explain
//     how you would debug it step by step.
```

---

# Quick Revision

```text
ERROR HANDLING
│
├── try
│   └── risky operation
│
├── catch
│   └── handle failure
│
├── throw
│   └── create/propagate error
│
├── finally
│   └── cleanup
│
├── Error
│   ├── message
│   ├── name
│   └── stack
│
└── API errors
    ├── Network failure
    ├── 400
    ├── 401
    ├── 403
    ├── 404
    └── 500
```

### The practical mental model

When your React application fails:

```text
Something went wrong
        ↓
Where?
        ↓
Browser / React?
        ↓
Network?
        ↓
Backend?
        ↓
Database?
        ↓
What exactly happened?
        ↓
Expected vs actual
        ↓
Handle at the correct layer
```

The most important production pattern to remember:

```js
async function getUsers() {
  try {
    const response = await fetch("/api/users");

    if (!response.ok) {
      throw new Error(
        `HTTP ${response.status}`
      );
    }

    return await response.json();

  } catch (error) {
    console.error("getUsers failed:", error);
    throw error;
  }
}
```

Then the UI decides what the user should see:

```js
try {
  const users = await getUsers();
  setUsers(users);
} catch (error) {
  setError("Unable to load users.");
} finally {
  setLoading(false);
}
```

> **Good error handling doesn't mean hiding errors. It means detecting failures, preserving useful information, handling them at the right layer, and giving the user an appropriate response.**

**Next: `15-fetch-api-http.md`** — we'll go deeper into the practical HTTP/API knowledge you need to connect React with a Spring Boot backend.
