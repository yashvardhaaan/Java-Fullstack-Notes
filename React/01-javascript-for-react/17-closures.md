# 16 — Closures

A **closure** is one of the most important JavaScript concepts to understand because it explains how functions can **remember variables from the place where they were created**, even after that outer function has finished executing.

Closures become especially important in:

* React state and event handlers
* callbacks
* timers
* event listeners
* private data
* function factories
* custom hooks
* memoization
* asynchronous JavaScript

> **A closure is a function together with the variables from its surrounding lexical scope that it remembers and can still access later.**

---

# 1. Start with the basic example

```js
function outer() {
  const name = "Yash";

  function inner() {
    console.log(name);
  }

  inner();
}

outer();
```

`inner()` can access:

```js
name
```

because `name` exists in the surrounding scope.

But this becomes interesting when we **return `inner`**.

---

# 2. The important example

```js
function outer() {
  const name = "Yash";

  function inner() {
    console.log(name);
  }

  return inner;
}

const fn = outer();

fn();
```

Result:

```text
Yash
```

At first this looks strange.

`outer()` has already finished.

So why can `fn()` still access:

```js
name
```

?

Because `inner()` formed a **closure** over `name`.

---

# 3. What actually happened?

When:

```js
const fn = outer();
```

runs:

```text
outer()
   ↓
name = "Yash"
   ↓
inner function created
   ↓
inner remembers its surrounding environment
   ↓
inner returned
   ↓
outer finishes
```

But:

```js
fn();
```

still has access to:

```text
name
```

because the closure preserves access to the required outer variable.

---

# 4. The mental model

Think:

```text
outer scope
┌─────────────────────┐
│ name = "Yash"       │
│                     │
│  inner() ───────────┼── remembers name
└─────────────────────┘
          │
          ↓
       returned
          │
          ↓
        fn()
```

The function carries access to its lexical environment.

---

# 5. Closure is about scope

Consider:

```js
function outer() {
  const message = "Hello";

  return function () {
    console.log(message);
  };
}
```

The returned function can access:

```js
message
```

because it was **defined inside** `outer()`.

This is important:

> Closures are determined by **where a function is created**, not where it is called.

---

# 6. A common misunderstanding

People sometimes think:

> "The function remembers the value."

More accurately:

> **The function retains access to variables in its lexical environment.**

This distinction becomes important when the variable changes.

---

# 7. Closure with changing variables

```js
function counter() {
  let count = 0;

  return function () {
    count++;

    return count;
  };
}

const increment = counter();

console.log(increment());
console.log(increment());
console.log(increment());
```

Output:

```text
1
2
3
```

Why?

Because the returned function still has access to:

```js
count
```

The value isn't recreated each time.

---

# 8. Visualizing the counter

```text
counter()
   ↓
count = 0
   ↓
returns function
   ↓
closure remembers count
   ↓
increment()
   ↓
count = 1
   ↓
increment()
   ↓
count = 2
   ↓
increment()
   ↓
count = 3
```

This is one of the classic closure examples.

---

# 9. Why is this useful?

Closures allow you to create **private state**.

For example:

```js
function createCounter() {
  let count = 0;

  return {
    increment() {
      count++;
    },

    getCount() {
      return count;
    }
  };
}
```

Use:

```js
const counter = createCounter();

counter.increment();
counter.increment();

console.log(counter.getCount());
```

Result:

```text
2
```

But:

```js
counter.count
```

doesn't exist publicly.

The `count` variable is hidden inside the closure.

---

# 10. Closures as private variables

```js
function createBankAccount() {
  let balance = 0;

  return {
    deposit(amount) {
      balance += amount;
    },

    getBalance() {
      return balance;
    }
  };
}
```

Use:

```js
const account = createBankAccount();

account.deposit(1000);
account.deposit(500);

console.log(account.getBalance());
```

Result:

```text
1500
```

You cannot directly do:

```js
account.balance = 999999;
```

because `balance` isn't a property of the returned object.

The methods have access to it through their closure.

---

# 11. Function factory

Closures are extremely useful for creating customized functions.

```js
function multiplyBy(number) {
  return function (value) {
    return value * number;
  };
}
```

Create functions:

```js
const multiplyBy2 = multiplyBy(2);
const multiplyBy10 = multiplyBy(10);
```

Then:

```js
console.log(multiplyBy2(5));
console.log(multiplyBy10(5));
```

Output:

```text
10
50
```

Each function remembers its own `number`.

---

# 12. Multiple closures can have separate state

```js
function counter() {
  let count = 0;

  return function () {
    count++;

    return count;
  };
}

const counterA = counter();
const counterB = counter();

console.log(counterA());
console.log(counterA());

console.log(counterB());
console.log(counterB());
```

Result:

```text
1
2
1
2
```

Why?

Each call to:

```js
counter()
```

creates a new lexical environment.

So:

```text
counterA
   ↓
count = 0


counterB
   ↓
count = 0
```

They don't share the same `count`.

---

# 13. Closures and callbacks

Closures appear constantly in callback functions.

```js
function greet(name) {
  setTimeout(() => {
    console.log(`Hello ${name}`);
  }, 2000);
}

greet("Yash");
```

The callback:

```js
() => {
  console.log(`Hello ${name}`);
}
```

can access:

```js
name
```

even though `greet()` has already returned by the time the timer callback executes.

That's a closure.

---

# 14. Closures and event listeners

Consider:

```js
function setupButton(buttonId) {
  const message = "Button clicked";

  const button =
    document.getElementById(buttonId);

  button.addEventListener("click", () => {
    console.log(message);
  });
}
```

The event callback remembers:

```js
message
```

from `setupButton()`.

Again:

```text
setupButton()
     ↓
message
     ↓
callback created
     ↓
event listener stores callback
     ↓
setupButton finishes
     ↓
button clicked later
     ↓
callback accesses message
```

Closure.

---

# 15. Closures and React

Closures are extremely important in React because **functions created during rendering capture values from that render**.

Example:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  function handleClick() {
    console.log(count);
  }

  return (
    <button onClick={handleClick}>
      {count}
    </button>
  );
}
```

`handleClick` has access to:

```js
count
```

because it was created inside the component's scope.

This is closure behavior.

---

# 16. React event handler example

```jsx
function User({ name }) {
  function handleClick() {
    console.log(name);
  }

  return (
    <button onClick={handleClick}>
      Show User
    </button>
  );
}
```

If:

```jsx
<User name="Yash" />
```

then `handleClick` can access:

```text
name = "Yash"
```

because it closes over the component's variables.

---

# 17. Closure and React state

Consider:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  function handleClick() {
    console.log(count);

    setCount(count + 1);
  }

  return (
    <button onClick={handleClick}>
      {count}
    </button>
  );
}
```

The handler created during a render closes over that render's `count`.

This is extremely important when debugging React state.

---

# 18. The stale closure problem

Consider:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  function handleClick() {
    setTimeout(() => {
      console.log(count);
    }, 3000);
  }

  return (
    <button onClick={handleClick}>
      {count}
    </button>
  );
}
```

Suppose you click the button when:

```text
count = 0
```

Then increase the counter to:

```text
count = 5
```

Three seconds later, the callback may print:

```text
0
```

Why?

Because the callback closed over the `count` from the render in which that callback was created.

This is called a **stale closure**.

---

# 19. Why stale closures matter

You'll encounter them with:

```text
setTimeout()
setInterval()
useEffect()
event listeners
async callbacks
subscriptions
```

Example:

```jsx
useEffect(() => {
  const timer = setInterval(() => {
    console.log(count);
  }, 1000);

  return () => clearInterval(timer);
}, []);
```

This can capture an old value of `count`.

Understanding closures makes these bugs much easier to understand.

---

# 20. Closure + `useEffect`

Consider:

```jsx
useEffect(() => {
  console.log(count);
}, []);
```

The effect function closes over the values available when that effect was created.

The dependency array tells React when the effect should be recreated.

For example:

```jsx
useEffect(() => {
  console.log(count);
}, [count]);
```

Now the effect is recreated when `count` changes.

This is one reason understanding closures is essential before going deep into `useEffect`.

---

# 21. Closure and `setInterval`

Consider:

```js
function startCounter() {
  let count = 0;

  setInterval(() => {
    count++;

    console.log(count);
  }, 1000);
}

startCounter();
```

The interval callback keeps access to:

```js
count
```

even after `startCounter()` has finished.

That is a closure.

---

# 22. Closures and loops

This is a famous JavaScript interview topic.

Consider:

```js
for (var i = 0; i < 3; i++) {
  setTimeout(() => {
    console.log(i);
  }, 1000);
}
```

You might expect:

```text
0
1
2
```

but get:

```text
3
3
3
```

Why?

Because `var` creates one shared binding for `i`.

All callbacks close over that same binding.

By the time they execute:

```text
i = 3
```

---

# 23. `let` changes the behavior

```js
for (let i = 0; i < 3; i++) {
  setTimeout(() => {
    console.log(i);
  }, 1000);
}
```

Now:

```text
0
1
2
```

`let` creates a separate binding for each loop iteration.

This is an excellent example of why **scope + closures** matter together.

---

# 24. Closure is not the same as scope

These concepts are related but different.

### Scope

Determines:

> Where can this variable be accessed?

### Closure

Describes:

> How a function retains access to variables from its surrounding lexical scope after that outer execution context has finished.

Think:

```text
Scope
→ determines visibility

Closure
→ preserves access for a function
```

---

# 25. Lexical scope

Closures are based on **lexical scope**.

Example:

```js
const x = "global";

function outer() {
  const y = "outer";

  function inner() {
    const z = "inner";

    console.log(x);
    console.log(y);
    console.log(z);
  }

  inner();
}
```

`inner()` can access:

```text
z → own scope
y → outer scope
x → global scope
```

This is determined by where the function is written.

---

# 26. Closures and modules

Closures are also related to the idea of keeping implementation details private.

For example:

```js
function createLogger(prefix) {
  return function log(message) {
    console.log(`[${prefix}] ${message}`);
  };
}
```

Create:

```js
const apiLog = createLogger("API");
const dbLog = createLogger("DB");
```

Then:

```js
apiLog("Request started");
dbLog("Connection established");
```

Output:

```text
[API] Request started
[DB] Connection established
```

Each function remembers its own `prefix`.

---

# 27. Closures and memoization

Closures can preserve cached values.

```js
function createMemoizedFunction() {
  let cache = {};

  return function (number) {
    if (cache[number]) {
      return cache[number];
    }

    const result = number * number;

    cache[number] = result;

    return result;
  };
}
```

Use:

```js
const square = createMemoizedFunction();

console.log(square(5));
console.log(square(5));
```

The second call can reuse the cached result.

The `cache` variable is private and persistent because of the closure.

---

# 28. Practical example — Authentication

A simplified example:

```js
function createAuthManager() {
  let token = null;

  return {
    login(newToken) {
      token = newToken;
    },

    logout() {
      token = null;
    },

    getToken() {
      return token;
    }
  };
}
```

Use:

```js
const auth = createAuthManager();

auth.login("abc123");

console.log(auth.getToken());
```

Result:

```text
abc123
```

The methods share access to the same private `token`.

This pattern demonstrates how closures can encapsulate state.

---

# 29. Practical example — Configuration

```js
function createApiClient(baseUrl) {
  return {
    get(endpoint) {
      return fetch(
        `${baseUrl}${endpoint}`
      );
    }
  };
}
```

Create:

```js
const api = createApiClient(
  "http://localhost:8080/api"
);
```

Then:

```js
api.get("/users");
api.get("/products");
```

The `get()` function remembers:

```text
baseUrl
```

through its closure.

---

# 30. Common mistake — thinking closure copies variables

Consider:

```js
function createCounter() {
  let count = 0;

  return {
    increment() {
      count++;
    },

    getCount() {
      return count;
    }
  };
}
```

The functions don't receive a separate copy of `count` each time.

They share access to the same lexical environment.

```text
        closure environment
        ┌───────────────┐
        │ count = 2     │
        └───────┬───────┘
                │
        ┌───────┴───────┐
        ↓               ↓
   increment()      getCount()
```

---

# 31. Common mistake — stale closure in React

When debugging:

```jsx
setTimeout(() => {
  console.log(count);
}, 3000);
```

don't immediately think:

> "React changed the value incorrectly."

Ask:

> **Which render did this callback close over?**

That question is extremely useful.

---

# 32. Common mistake — closure doesn't mean asynchronous

Closures work even without asynchronous code.

This is a closure:

```js
function outer() {
  const name = "Yash";

  return function () {
    console.log(name);
  };
}
```

No:

```text
setTimeout
Promise
fetch
React
```

is required.

Async code simply makes closure behavior more noticeable.

---

# 33. Interview Questions

### Q1. What is a closure?

A closure is a function together with access to variables from its surrounding lexical environment.

### Q2. Why do closures exist?

They allow functions to retain access to variables from the scope where they were created.

### Q3. Give a simple example.

```js
function outer() {
  let count = 0;

  return function () {
    count++;
    return count;
  };
}
```

### Q4. What is a practical use of closures?

* private state
* function factories
* callbacks
* event handlers
* timers
* memoization
* React event handlers/hooks

### Q5. What is a stale closure?

A callback uses values captured from an older render or lexical environment instead of the value you expected at the later execution time.

### Q6. Does a closure copy variables?

No. It retains access to the lexical environment containing those variables.

### Q7. Are closures only used with asynchronous code?

No. Closures exist independently of asynchronous programming.

---

# 34. Practice

Create `closure-practice.js`:

```js
// 1. Create a function that returns another
//    function which remembers a name.

// 2. Create a counter using closure.

// 3. Create two independent counters.

// 4. Create a function factory:
//    multiplyBy(2)
//    multiplyBy(5)

// 5. Create a private bank balance.

// 6. Create a logger factory:
//    createLogger("API")
//    createLogger("DATABASE")

// 7. Create a function that remembers
//    an API base URL.

// 8. Use a closure with setTimeout().

// 9. Explain why the callback can still
//    access a variable after the outer
//    function has finished.

// 10. Solve the classic var loop problem.

// 11. Explain why let produces different
//     results in the loop.

// 12. Create a React example where an event
//     handler closes over a prop.

// 13. Create a React stale-closure example.

// 14. Explain which render's value the
//     callback has captured.
```

---

# Quick Revision

```text
CLOSURE
│
├── Function created inside another scope
│
├── Inner function accesses outer variables
│
├── Inner function survives after outer
│
└── It retains access to that lexical environment
```

### Classic example

```js
function counter() {
  let count = 0;

  return function () {
    count++;
    return count;
  };
}

const increment = counter();

increment(); // 1
increment(); // 2
increment(); // 3
```

Mental model:

```text
counter()
   ↓
creates lexical environment
   ↓
count = 0
   ↓
returns function
   ↓
function closes over count
   ↓
counter() finishes
   ↓
increment() called later
   ↓
still accesses count
```

### In React

When you see:

```jsx
function Component() {
  const [count, setCount] = useState(0);

  function handleClick() {
    console.log(count);
  }

  return (
    <button onClick={handleClick}>
      Click
    </button>
  );
}
```

think:

```text
Component render
      ↓
count exists
      ↓
handleClick created
      ↓
handleClick closes over count
      ↓
button clicked later
      ↓
handleClick accesses captured scope
```

> **The most important thing to understand about closures is not the definition. Understand the mechanism: a function remembers the lexical environment in which it was created.**

That understanding will make **callbacks, `setTimeout`, event handlers, `useEffect`, custom hooks, stale state, and many React bugs** much easier to reason about.
