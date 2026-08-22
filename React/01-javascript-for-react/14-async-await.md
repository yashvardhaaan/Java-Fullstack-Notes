# 13 — `async` / `await`

`async/await` is the syntax you'll use constantly when working with **APIs in React**.

It doesn't replace Promises.

> **`async/await` is a cleaner way to work with Promises.**

---

## 1. The problem with Promise chains

You learned this:

```js
fetch("/api/users")
  .then(response => response.json())
  .then(data => {
    console.log(data);
  })
  .catch(error => {
    console.error(error);
  });
```

This works.

But when several asynchronous operations depend on each other, chaining can become harder to read:

```js
login()
  .then(user => getProfile(user.id))
  .then(profile => getOrders(profile.id))
  .then(orders => getPayments(orders[0].id))
  .then(payment => {
    console.log(payment);
  })
  .catch(error => {
    console.error(error);
  });
```

`async/await` lets you write this in a more sequential-looking way.

---

# 2. Basic `async`

An `async` function always returns a Promise.

```js
async function greet() {
  return "Hello";
}
```

Even though you returned a string:

```js
greet();
```

the result is actually:

```text
Promise
```

You can consume it:

```js
greet().then(result => {
  console.log(result);
});
```

Output:

```text
Hello
```

### Important rule

> **Every `async` function returns a Promise.**

---

# 3. Basic `await`

`await` waits for a Promise to settle and gives you its fulfilled value.

```js
async function loadData() {
  const result = await getData();

  console.log(result);
}
```

Conceptually:

```text
getData()
   ↓
Promise
   ↓
await
   ↓
wait for result
   ↓
result
```

---

# 4. The most important example — `fetch()`

Promise version:

```js
fetch("/api/users")
  .then(response => response.json())
  .then(data => {
    console.log(data);
  });
```

`async/await` version:

```js
async function getUsers() {
  const response = await fetch("/api/users");

  const data = await response.json();

  console.log(data);
}
```

Compare:

```text
Promise style
→ .then()
→ .then()

async/await
→ await
→ await
```

The second often reads more like normal sequential code.

---

# 5. `async` and `await` work together

You generally use `await` inside an `async` function:

```js
async function loadUsers() {
  const response = await fetch("/api/users");

  const users = await response.json();

  return users;
}
```

Then:

```js
loadUsers().then(users => {
  console.log(users);
});
```

Notice something important:

Even though you used `await` internally:

```js
loadUsers()
```

still returns a Promise.

---

# 6. Why does `await` not block the whole application?

This is a very important concept.

Consider:

```js
async function loadUsers() {
  const response = await fetch("/api/users");
}
```

`await` pauses the execution of **that async function** until the Promise settles.

It does **not freeze the browser or block the entire JavaScript application**.

Conceptually:

```text
React application
       │
       ├── loadUsers()
       │      ↓
       │    await fetch()
       │      ↓
       │    paused
       │
       ├── User can interact
       ├── Browser can render
       └── Other JavaScript can execute
```

This is why asynchronous programming is possible in browser applications.

---

# 7. Handling errors with `try/catch`

This is one of the biggest advantages of `async/await`.

Promise style:

```js
fetch("/api/users")
  .then(response => response.json())
  .catch(error => {
    console.error(error);
  });
```

With `async/await`:

```js
async function loadUsers() {
  try {
    const response = await fetch("/api/users");

    const data = await response.json();

    console.log(data);
  } catch (error) {
    console.error(error);
  }
}
```

The structure becomes:

```text
try
 ↓
attempt asynchronous operation
 ↓
success → continue

catch
 ↓
handle error
```

---

# 8. `fetch()` and HTTP errors

Remember from the Promise topic:

`fetch()` doesn't normally reject merely because the server returns `404` or `500`.

So this isn't enough:

```js
async function loadUsers() {
  const response = await fetch("/api/users");

  const data = await response.json();

  return data;
}
```

A better production pattern is:

```js
async function loadUsers() {
  const response = await fetch("/api/users");

  if (!response.ok) {
    throw new Error(
      `Request failed: ${response.status}`
    );
  }

  return response.json();
}
```

Now HTTP errors become rejected Promises.

---

# 9. Complete API function

A practical service function:

```js
async function getUsers() {
  try {
    const response = await fetch(
      "http://localhost:8080/api/users"
    );

    if (!response.ok) {
      throw new Error(
        `Failed to fetch users: ${response.status}`
      );
    }

    return await response.json();

  } catch (error) {
    console.error("getUsers failed:", error);
    throw error;
  }
}
```

This is the kind of function you might put inside:

```text
src/
└── services/
    └── userService.js
```

---

# 10. Why `throw` matters

Consider:

```js
if (!response.ok) {
  throw new Error("Request failed");
}
```

`throw` causes the async function's Promise to reject.

So:

```text
throw Error
    ↓
async function rejects
    ↓
caller can catch it
```

For example:

```js
try {
  const users = await getUsers();
} catch (error) {
  console.error(error);
}
```

---

# 11. Returning values from `async`

Consider:

```js
async function getNumber() {
  return 10;
}
```

This does **not** mean:

```js
const number = getNumber();
```

gives `10`.

It gives a Promise.

You need:

```js
const number = await getNumber();
```

inside another async function.

Or:

```js
getNumber().then(number => {
  console.log(number);
});
```

Remember:

> **`async` automatically wraps the returned value in a Promise.**

---

# 12. Sequential `await`

Suppose you have:

```js
async function loadData() {
  const user = await getUser();

  const orders = await getOrders(user.id);

  const payments = await getPayments(user.id);

  return payments;
}
```

The operations happen in sequence:

```text
getUser()
   ↓
user
   ↓
getOrders()
   ↓
orders
   ↓
getPayments()
   ↓
payments
```

This is correct when each operation depends on the previous result.

---

# 13. Don't unnecessarily await independent operations

Suppose:

```js
const users = await getUsers();
const products = await getProducts();
```

If these requests don't depend on each other, this can be slower because you're waiting for one before starting the other.

Instead:

```js
const [users, products] = await Promise.all([
  getUsers(),
  getProducts()
]);
```

Now they can run concurrently.

Conceptually:

```text
          ┌── getUsers()
          │
Promise.all
          │
          └── getProducts()
                 ↓
          wait for both
                 ↓
             results
```

This is an important practical performance pattern.

---

# 14. React example — Loading users

```jsx
function Users() {
  const [users, setUsers] = useState([]);

  async function loadUsers() {
    try {
      const response = await fetch("/api/users");

      if (!response.ok) {
        throw new Error("Failed to load users");
      }

      const data = await response.json();

      setUsers(data);

    } catch (error) {
      console.error(error);
    }
  }

  return (
    <button onClick={loadUsers}>
      Load Users
    </button>
  );
}
```

The flow is:

```text
Button click
    ↓
loadUsers()
    ↓
await fetch()
    ↓
Backend response
    ↓
await response.json()
    ↓
setUsers(data)
    ↓
React re-renders
```

---

# 15. React example — Loading, success and error

A more realistic component:

```jsx
function Users() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  async function loadUsers() {
    setLoading(true);
    setError(null);

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

  return (
    <div>
      <button
        onClick={loadUsers}
        disabled={loading}
      >
        {loading ? "Loading..." : "Load Users"}
      </button>

      {error && <p>{error}</p>}

      {users.map(user => (
        <p key={user.id}>
          {user.name}
        </p>
      ))}
    </div>
  );
}
```

Notice how several concepts now work together:

```text
async/await
    +
try/catch
    +
finally
    +
Promise
    +
fetch
    +
React state
    +
map()
```

This is the kind of integration your notes should teach you to recognize.

---

# 16. `async` event handlers

You can make an event handler asynchronous:

```jsx
async function handleSubmit() {
  try {
    const response = await fetch("/api/login", {
      method: "POST"
    });

    // ...
  } catch (error) {
    console.error(error);
  }
}
```

Then:

```jsx
<form onSubmit={handleSubmit}>
```

The handler can perform asynchronous work.

---

# 17. Async functions and return values

Consider:

```js
async function getUser() {
  return {
    id: 1,
    name: "Yash"
  };
}
```

You can use:

```js
const user = await getUser();
```

The returned object is automatically wrapped in a Promise by the `async` function and then unwrapped by `await`.

Conceptually:

```text
return object
     ↓
Promise<object>
     ↓
await
     ↓
object
```

---

# 18. `await` can work with normal values

Technically:

```js
async function test() {
  const value = await 10;

  console.log(value);
}
```

works.

It gives:

```text
10
```

JavaScript effectively treats the value as an already-resolved Promise.

But in real applications, `await` is mainly useful for asynchronous operations.

---

# 19. Async functions and errors

An error inside an async function causes the returned Promise to reject.

```js
async function test() {
  throw new Error("Something failed");
}
```

Then:

```js
test().catch(error => {
  console.error(error);
});
```

Or:

```js
async function run() {
  try {
    await test();
  } catch (error) {
    console.error(error);
  }
}
```

This is why `try/catch` is so important with `async/await`.

---

# 20. A very important mistake — forgetting `await`

Suppose:

```js
async function getUsers() {
  return fetch("/api/users");
}
```

Then:

```js
const users = getUsers();
```

`users` is still a Promise.

You need:

```js
const response = await getUsers();
```

And if the response is JSON:

```js
const data = await response.json();
```

---

# 21. Another mistake — forgetting `await response.json()`

This:

```js
const data = response.json();

console.log(data);
```

gives you:

```text
Promise
```

not the parsed data.

Correct:

```js
const data = await response.json();
```

---

# 22. Another mistake — sequential requests unnecessarily

Avoid:

```js
const users = await getUsers();
const products = await getProducts();
const categories = await getCategories();
```

if they are independent.

Prefer:

```js
const [
  users,
  products,
  categories
] = await Promise.all([
  getUsers(),
  getProducts(),
  getCategories()
]);
```

This can reduce total waiting time.

---

# 23. `await` and the Event Loop

This is an important connection to your future JavaScript knowledge.

Consider:

```js
async function test() {
  console.log("A");

  await Promise.resolve();

  console.log("B");
}

console.log("C");

test();

console.log("D");
```

The important output order is:

```text
C
A
D
B
```

Why?

`await` pauses the async function's continuation and allows the current synchronous work to finish before continuing.

You'll understand this much more deeply when you study the **event loop** later.

---

# 24. Where will I use `async/await`?

In React applications:

```text
API requests
      ↓
Login
      ↓
Registration
      ↓
Fetching products
      ↓
Submitting forms
      ↓
Uploading files
      ↓
Deleting records
      ↓
Updating backend data
      ↓
Third-party APIs
```

For your React + Spring Boot projects, you'll probably write patterns like:

```js
async function createTask(task) {
  const response = await fetch(
    "http://localhost:8080/api/tasks",
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(task)
    }
  );

  if (!response.ok) {
    throw new Error("Failed to create task");
  }

  return response.json();
}
```

This is a real-world frontend → backend interaction.

---

# 25. When NOT to use `async/await`

Don't make a function `async` just because you can.

This:

```js
async function add(a, b) {
  return a + b;
}
```

returns a Promise unnecessarily if the operation is completely synchronous.

Prefer:

```js
function add(a, b) {
  return a + b;
}
```

Use `async` when the function actually deals with asynchronous work or when returning a Promise is intentional.

---

# 26. Interview Questions

### Q1. What does `async` do?

It makes a function return a Promise.

### Q2. What does `await` do?

It pauses the execution of the surrounding async function until the awaited Promise settles, then provides its fulfilled value or throws its rejection.

### Q3. Can `await` be used outside an async function?

In modern JavaScript, `await` can also be used with **top-level await** in supported ES modules. In typical React component code, you generally use it inside an `async` function.

### Q4. Does `await` block the entire JavaScript application?

No. It pauses the current async function's continuation; it doesn't freeze the whole browser/application.

### Q5. How do you handle errors with async/await?

Use:

```js
try {
  // async operation
} catch (error) {
  // handle error
}
```

### Q6. What does this return?

```js
async function test() {
  return 10;
}
```

A Promise that fulfills with `10`.

### Q7. When should you use `Promise.all()` with `await`?

When multiple asynchronous operations are independent and you need their results together.

---

# 27. Practice

Create `practice.js`:

```js
// 1. Create an async function that returns "Hello".

// 2. Call it using await.

// 3. Create a Promise that resolves after 2 seconds.

// 4. Use async/await to consume it.

// 5. Create an async function that calls fetch().

// 6. Convert the response using await response.json().

// 7. Handle errors using try/catch.

// 8. Check response.ok and throw an Error
//    for an unsuccessful HTTP response.

// 9. Create two independent async operations
//    and run them using Promise.all().

// 10. Create a React event handler that:
//     - starts loading
//     - sends an API request
//     - updates state
//     - handles errors
//     - stops loading in finally.

// 11. Explain why this:
//     const data = response.json();
//     doesn't give you the actual JSON data.

// 12. Explain why async/await does not replace Promises.
```

---

# Quick Revision

```text
ASYNC / AWAIT
│
├── async
│   └── function returns Promise
│
├── await
│   └── wait for Promise result
│
├── try
│   └── attempt operation
│
├── catch
│   └── handle failure
│
└── finally
    └── cleanup
```

### The mental model you should remember

```text
async function
      ↓
starts asynchronous operation
      ↓
await Promise
      ↓
function pauses here
      ↓
other JavaScript can continue
      ↓
Promise settles
      ↓
function continues
      ↓
result
      ↓
React state update
      ↓
React re-renders
```

And the most important practical pattern:

```js
async function loadUsers() {
  try {
    const response = await fetch("/api/users");

    if (!response.ok) {
      throw new Error("Failed to fetch users");
    }

    const data = await response.json();

    return data;

  } catch (error) {
    console.error(error);
    throw error;
  }
}
```

> **Promises are the underlying asynchronous mechanism; `async/await` is the cleaner syntax you use to work with those Promises.**

**Next: `14-error-handling.md`** — this will build on `Promise`, `async/await`, `try/catch`, HTTP errors, and React UI error states.
