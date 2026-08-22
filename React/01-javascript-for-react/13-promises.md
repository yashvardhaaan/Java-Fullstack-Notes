# 12 — Promises

Promises are one of the most important JavaScript concepts for React because **real applications constantly perform asynchronous work**:

```text
React UI
   ↓
API request
   ↓
Backend
   ↓
Database
   ↓
Response
   ↓
Update UI
```

The response doesn't arrive immediately.

A **Promise represents the eventual result of an asynchronous operation**.

---

# 1. The problem: asynchronous operations take time

Consider:

```js
const result = fetch("/api/users");

console.log(result);
```

The request doesn't immediately give you the user data.

Why?

Because JavaScript starts the operation and continues executing other code while the network request is happening.

Conceptually:

```text
Start request
     ↓
Request is travelling
     ↓
JavaScript continues
     ↓
Server responds
     ↓
Result becomes available
```

A Promise gives JavaScript a way to represent:

> "The result isn't available yet, but I'll give you the result when it becomes available."

---

# 2. What is a Promise?

A Promise is an object representing the eventual completion or failure of an asynchronous operation.

A Promise has three main states:

```text
             Promise
                │
       ┌────────┼────────┐
       ↓        ↓        ↓
   Pending   Fulfilled  Rejected
       │        │        │
    Waiting   Success    Failure
```

### Pending

The operation hasn't finished.

```text
Request in progress...
```

### Fulfilled

The operation succeeded.

```text
Data received
```

### Rejected

The operation failed.

```text
Network error
Server error
```

---

# 3. Real-world analogy

Imagine ordering food.

```text
You place order
      ↓
     Pending
      ↓
Restaurant prepares food
      ↓
     Fulfilled
      ↓
Food arrives
```

If the restaurant cancels the order:

```text
     Rejected
```

A Promise represents this process.

---

# 4. Creating a Promise

You can manually create one:

```js id="3a3f1f"
const promise = new Promise((resolve, reject) => {

  // asynchronous operation

});
```

A Promise receives a function containing:

```js id="u5c1xr"
(resolve, reject) => {}
```

You use:

```text id="1y29jv"
resolve()
→ success

reject()
→ failure
```

---

# 5. Resolving a Promise

```js id="y5qqdi"
const promise = new Promise((resolve, reject) => {
  resolve("Success");
});
```

The Promise is now fulfilled.

You can consume it using `.then()`.

```js id="jmw7iq"
promise.then(result => {
  console.log(result);
});
```

Output:

```text id="k11j6e"
Success
```

---

# 6. Rejecting a Promise

```js id="4pfkjt"
const promise = new Promise((resolve, reject) => {
  reject("Something went wrong");
});
```

Handle the rejection:

```js id="4drjig"
promise.catch(error => {
  console.log(error);
});
```

Output:

```text id="u0s0s7"
Something went wrong
```

---

# 7. `then()`

`.then()` runs when the Promise succeeds.

```js id="b7z6ck"
promise.then(result => {
  console.log(result);
});
```

Think:

```text id="w3fl04"
Promise
   ↓
Successful?
   ↓ yes
.then()
   ↓
Use result
```

---

# 8. `catch()`

`.catch()` handles failures.

```js id="x8e4m4"
promise
  .then(result => {
    console.log(result);
  })
  .catch(error => {
    console.error(error);
  });
```

Think:

```text id="9f5m3x"
Promise
   │
   ├── success → then()
   │
   └── failure → catch()
```

---

# 9. `finally()`

`.finally()` executes regardless of success or failure.

```js id="l3j50b"
promise
  .then(result => {
    console.log(result);
  })
  .catch(error => {
    console.error(error);
  })
  .finally(() => {
    console.log("Request finished");
  });
```

Useful for things like:

```text id="8n9f5r"
Loading finished
Cleanup
Reset temporary state
Hide spinner
```

---

# 10. Real API example

The most important Promise example is `fetch()`.

```js id="7z4h8g"
const promise = fetch(
  "https://example.com/api/users"
);
```

`fetch()` returns a Promise.

Conceptually:

```text id="6i2f1m"
fetch()
  ↓
Promise
  ↓
HTTP request
  ↓
Response
```

You can use:

```js id="u7m9d1"
fetch("/api/users")
  .then(response => response.json())
  .then(data => {
    console.log(data);
  })
  .catch(error => {
    console.error(error);
  });
```

---

# 11. Why is `response.json()` also a Promise?

This is important.

You might think:

```js
response.json()
```

immediately gives you the JavaScript object.

It doesn't.

It returns another Promise.

So:

```js id="8c9v6p"
fetch("/api/users")
```

returns:

```text id="t1w4z0"
Promise<Response>
```

Then:

```js id="e8zq27"
response.json()
```

returns:

```text id="w9n6cx"
Promise<Data>
```

That's why we chain `.then()`.

---

# 12. Promise chaining

Consider:

```js id="x0h2s4"
fetch("/api/users")
  .then(response => response.json())
  .then(data => {
    console.log(data);
  });
```

The flow is:

```text id="2q0ybf"
fetch()
  ↓
Promise<Response>
  ↓
.then()
  ↓
response.json()
  ↓
Promise<Data>
  ↓
.then()
  ↓
data
```

Each `.then()` receives the result of the previous operation.

---

# 13. Why do we need chaining?

Imagine your application needs to:

```text
1. Login
2. Get authentication information
3. Get user profile
4. Get user's orders
```

These operations may depend on each other.

Promises allow you to represent that sequence.

```js id="uk4fd7"
login()
  .then(user => getProfile(user.id))
  .then(profile => getOrders(profile.id))
  .then(orders => {
    console.log(orders);
  })
  .catch(error => {
    console.error(error);
  });
```

This is called **Promise chaining**.

---

# 14. Promise values

A `.then()` callback can return a value.

```js id="yn0j8u"
Promise.resolve(10)
  .then(value => {
    return value * 2;
  })
  .then(value => {
    console.log(value);
  });
```

Result:

```text id="9qcd3q"
20
```

The returned value becomes the input for the next `.then()`.

---

# 15. Returning another Promise

This is where chaining becomes powerful.

```js id="0sl6ph"
getUser()
  .then(user => {
    return getOrders(user.id);
  })
  .then(orders => {
    console.log(orders);
  });
```

The second `.then()` waits for the Promise returned by `getOrders()`.

Conceptually:

```text id="72z8r1"
getUser()
   ↓
user
   ↓
getOrders(user.id)
   ↓
Promise
   ↓
orders
```

---

# 16. Promise example without an API

You can simulate an asynchronous operation:

```js id="wz3qk1"
function wait() {
  return new Promise(resolve => {
    setTimeout(() => {
      resolve("Done!");
    }, 2000);
  });
}

wait().then(result => {
  console.log(result);
});
```

After approximately two seconds:

```text id="8r0xq8"
Done!
```

This helps you understand that a Promise represents something that finishes later.

---

# 17. Promise and `setTimeout`

Important distinction:

`setTimeout()` itself does not return a Promise.

```js id="c8e3t7"
setTimeout(() => {
  console.log("Done");
}, 2000);
```

If you want Promise-based behavior:

```js id="o3g2m4"
function wait(ms) {
  return new Promise(resolve => {
    setTimeout(resolve, ms);
  });
}
```

Then:

```js id="4n6x6h"
wait(2000).then(() => {
  console.log("Done");
});
```

---

# 18. React example — Loading API data

Imagine a React component:

```jsx id="w4ez90"
function Users() {
  const [users, setUsers] = useState([]);

  function loadUsers() {
    fetch("/api/users")
      .then(response => response.json())
      .then(data => {
        setUsers(data);
      })
      .catch(error => {
        console.error(error);
      });
  }

  return (
    <button onClick={loadUsers}>
      Load Users
    </button>
  );
}
```

The flow is:

```text id="lhnd2k"
Button clicked
      ↓
fetch()
      ↓
Promise pending
      ↓
Backend responds
      ↓
response.json()
      ↓
Data
      ↓
setUsers(data)
      ↓
React re-renders
```

This is one of the most important connections between **JavaScript Promises and React**.

---

# 19. Promise + Spring Boot

Suppose your Spring Boot backend exposes:

```text id="1cjqcs"
GET /api/products
```

React:

```js id="6f4yeg"
fetch("http://localhost:8080/api/products")
  .then(response => response.json())
  .then(products => {
    console.log(products);
  })
  .catch(error => {
    console.error("Failed to load products", error);
  });
```

Your frontend is dealing with a Promise because the backend response takes time.

This is exactly the kind of interaction you'll implement in your projects.

---

# 20. Promise error handling

There are several ways a request can fail:

```text id="0d7m5k"
Network failure
      ↓
Server unavailable
      ↓
Invalid response
      ↓
JSON parsing failure
      ↓
Application error
```

You need to handle failures.

```js id="3i1zjo"
fetch("/api/users")
  .then(response => {
    if (!response.ok) {
      throw new Error("Request failed");
    }

    return response.json();
  })
  .then(data => {
    console.log(data);
  })
  .catch(error => {
    console.error(error);
  });
```

Notice:

```js id="7g2t3h"
response.ok
```

A `fetch()` Promise doesn't automatically reject just because the HTTP status is `404` or `500`.

This is an important practical detail.

---

# 21. Promise states in a React application

When fetching data, you often need three UI states:

```text id="2c4s2m"
Loading
   ↓
Success
   ↓
Display data
```

or:

```text id="cx4wzq"
Loading
   ↓
Error
   ↓
Display error
```

You can model this with state:

```jsx id="3n8m5k"
const [loading, setLoading] = useState(false);
const [error, setError] = useState(null);
const [users, setUsers] = useState([]);
```

Then the Promise lifecycle maps naturally to the UI.

This becomes much easier once you understand Promises.

---

# 22. Promise methods

JavaScript provides useful Promise utilities.

### `Promise.all()`

Run multiple independent Promises together.

```js id="3w6xzr"
const usersPromise = fetch("/api/users");
const productsPromise = fetch("/api/products");

Promise.all([
  usersPromise,
  productsPromise
])
  .then(results => {
    console.log(results);
  });
```

Conceptually:

```text id="f5f5s4"
users ───────┐
             ├──→ Promise.all()
products ────┘
                  ↓
             All completed
```

Useful when multiple requests are independent and you need all their results.

---

# 23. `Promise.all()` failure behavior

If one Promise rejects:

```js id="r4j3c1"
Promise.all([
  promise1,
  promise2,
  promise3
])
```

the combined Promise rejects.

This is useful when **all results are required**.

---

# 24. `Promise.allSettled()`

Sometimes you want every operation to finish even if some fail.

```js id="h3s9yc"
Promise.allSettled([
  promise1,
  promise2,
  promise3
])
  .then(results => {
    console.log(results);
  });
```

This gives you the result of every Promise.

Useful when:

```text id="pj4pwy"
Request A → success
Request B → failure
Request C → success
```

and you still want to know all three outcomes.

---

# 25. `Promise.race()`

Returns the result of the first Promise that settles.

```js id="n1j8pr"
Promise.race([
  promise1,
  promise2
])
  .then(result => {
    console.log(result);
  });
```

Useful when you care about whichever operation finishes first.

---

# 26. `Promise.any()`

Returns the first Promise that **successfully fulfills**.

```js id="f2aq7y"
Promise.any([
  server1Request,
  server2Request,
  server3Request
])
  .then(result => {
    console.log(result);
  });
```

Unlike `race()`:

```text id="race"
race()
→ first settled

any()
→ first successful
```

This distinction matters in interviews and real systems.

---

# 27. Promise vs callback

Before Promises, asynchronous code often used callbacks.

```js id="fcz2g6"
getUser(function(user) {
  getOrders(user.id, function(orders) {
    // ...
  });
});
```

As operations increase, nesting becomes difficult.

Promises:

```js id="9i8fr7"
getUser()
  .then(user => getOrders(user.id))
  .then(orders => {
    // ...
  });
```

Promises help make asynchronous flows easier to compose.

---

# 28. Promise vs `async/await`

Promises are the underlying concept.

`async/await` provides cleaner syntax for working with Promises.

Promise style:

```js id="4yps8q"
getUser()
  .then(user => {
    return getOrders(user.id);
  })
  .then(orders => {
    console.log(orders);
  });
```

Later you'll learn:

```js id="n4eq1y"
async function loadData() {
  const user = await getUser();
  const orders = await getOrders(user.id);

  console.log(orders);
}
```

`async/await` doesn't replace Promises.

It works **on top of Promises**.

---

# 29. Common mistakes

### Mistake 1 — Treating a Promise as the actual data

Wrong:

```js id="j5zzr7"
const users = fetch("/api/users");

console.log(users.name);
```

`users` is a Promise, not the final data.

You need:

```js id="1f8gwp"
fetch("/api/users")
  .then(response => response.json())
  .then(users => {
    console.log(users);
  });
```

---

### Mistake 2 — Forgetting to return in a chain

Be careful:

```js id="e4zy6b"
getUser()
  .then(user => {
    getOrders(user.id);
  })
  .then(orders => {
    console.log(orders);
  });
```

If you want the next `.then()` to wait for `getOrders()`, return it:

```js id="8yd5ju"
getUser()
  .then(user => {
    return getOrders(user.id);
  })
  .then(orders => {
    console.log(orders);
  });
```

---

### Mistake 3 — Assuming `fetch()` rejects on HTTP 404/500

It generally rejects for network-level failures, not simply because the server returned an HTTP error status.

Check:

```js id="d2zqmx"
if (!response.ok) {
  throw new Error("Request failed");
}
```

---

# 30. When will I use Promises?

You'll encounter them whenever an operation takes time:

```text id="4d9b8e"
HTTP requests
    ↓
Database/API communication
    ↓
Authentication
    ↓
File operations
    ↓
Timers
    ↓
Browser APIs
    ↓
Third-party services
```

In React, the most important use is:

```text id="d2u8gr"
Component
   ↓
API request
   ↓
Promise
   ↓
Response
   ↓
State update
   ↓
Re-render
```

---

# 31. Interview Questions

### Q1. What is a Promise?

An object representing the eventual success or failure of an asynchronous operation.

### Q2. What are the states of a Promise?

```text id="v2i4ad"
Pending
Fulfilled
Rejected
```

### Q3. What does `.then()` do?

Handles a successfully fulfilled Promise.

### Q4. What does `.catch()` do?

Handles a rejected Promise.

### Q5. What does `.finally()` do?

Runs after the Promise settles, regardless of success or failure.

### Q6. Does `fetch()` return a Promise?

Yes.

### Q7. Does `response.json()` return a Promise?

Yes.

### Q8. What is Promise chaining?

Passing the result of one asynchronous operation into the next `.then()`.

### Q9. Difference between `Promise.all()` and `Promise.allSettled()`?

```text id="5w7g6z"
Promise.all()
→ rejects if one rejects

Promise.allSettled()
→ waits for all and reports every result
```

### Q10. Is `async/await` different from Promises?

`async/await` is syntax built around Promises that makes asynchronous code easier to read.

---

# 32. Practice

Create `practice.js`:

```js id="jv6q0m"
// 1. Create a Promise that resolves with "Success".

// 2. Create a Promise that rejects with an Error.

// 3. Handle both using then() and catch().

// 4. Create a Promise that resolves after 2 seconds.

// 5. Use fetch() to call a public API.

// 6. Convert the response using response.json().

// 7. Handle HTTP errors using response.ok.

// 8. Chain two Promises.

// 9. Create three Promises and use Promise.all().

// 10. Use Promise.allSettled().

// 11. Explain the difference between:
//     Promise.all()
//     Promise.allSettled()
//     Promise.race()
//     Promise.any()

// 12. Create a React example where:
//     button → API request → Promise → state update.
```

---

# Quick Revision

```text id="f0l2xj"
PROMISE
│
├── Pending
│     ↓
│   Waiting
│
├── Fulfilled
│     ↓
│   Success
│
└── Rejected
      ↓
    Failure


Consume Promise:

promise
  ↓
.then()
  ↓
Success

.catch()
  ↓
Error

.finally()
  ↓
Cleanup
```

### The most important React connection

When you see:

```js id="e2j7xq"
fetch("/api/users")
```

immediately think:

```text id="7b9h9x"
fetch()
   ↓
Promise
   ↓
HTTP response
   ↓
response.json()
   ↓
Promise
   ↓
data
   ↓
setState()
   ↓
React re-render
```

That mental model will become extremely important when you start learning `async/await`, `useEffect`, API integration, loading states, and error handling.

> **A Promise doesn't contain the final data immediately. It represents the future result of an asynchronous operation.**

**Next: `13-async-await.md`** — we'll take the exact Promise concepts you've learned here and turn them into the syntax you'll use most often in real React applications.
