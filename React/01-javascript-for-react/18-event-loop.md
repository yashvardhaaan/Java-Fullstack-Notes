# 18 — Event Loop

The **Event Loop** explains how JavaScript can handle asynchronous operations like:

* `setTimeout()`
* `fetch()`
* Promises
* `async/await`
* DOM events
* React event handlers

while JavaScript itself executes JavaScript code on a single main thread.

> **The Event Loop coordinates when asynchronous callbacks are allowed to run after the current JavaScript work has finished.**

---

# 1. Why do we need the Event Loop?

JavaScript executes code synchronously:

```js
console.log("A");
console.log("B");
console.log("C");
```

Output:

```text
A
B
C
```

It executes one piece of JavaScript at a time.

But applications need to do things that take time:

```text
API request
Timer
User click
File operation
Database request
```

JavaScript cannot simply stop the entire application while waiting.

So the runtime provides mechanisms around JavaScript to handle asynchronous work.

---

# 2. The basic architecture

Think of it like this:

```text
                JavaScript Runtime
┌───────────────────────────────────────────┐
│                                           │
│   Call Stack                              │
│      ↓                                    │
│   Executes JavaScript                     │
│                                           │
│   Web APIs / Runtime APIs                 │
│      ↓                                    │
│   Timers / Network / DOM events           │
│                                           │
│   Task Queues                             │
│      ↓                                    │
│   Microtask Queue                         │
│   Task Queue                              │
│                                           │
│   Event Loop                              │
│      ↓                                    │
│   Decides what runs next                  │
│                                           │
└───────────────────────────────────────────┘
```

The exact implementation differs between browsers and Node.js, but this mental model is extremely useful.

---

# 3. Call Stack

The **Call Stack** keeps track of currently executing JavaScript functions.

Example:

```js
function one() {
  two();
}

function two() {
  console.log("Hello");
}

one();
```

Conceptually:

```text
one()
 ↓
two()
 ↓
console.log()
```

The stack behaves roughly like:

```text
        ┌──────────────┐
        │ console.log  │
        ├──────────────┤
        │ two          │
        ├──────────────┤
        │ one          │
        └──────────────┘
```

The last function added is executed first.

---

# 4. Stack after execution

When:

```js
console.log("Hello");
```

finishes:

```text
console.log
   ↓
removed

two()
   ↓
removed

one()
   ↓
removed
```

Eventually:

```text
Call Stack
──────────
empty
```

---

# 5. Synchronous code

Consider:

```js
console.log("A");

function test() {
  console.log("B");
}

test();

console.log("C");
```

Execution:

```text
console.log("A")
      ↓
      A

test()
  ↓
console.log("B")
  ↓
  B

console.log("C")
  ↓
  C
```

Output:

```text
A
B
C
```

Everything happens through the call stack.

---

# 6. Now introduce `setTimeout()`

```js
console.log("A");

setTimeout(() => {
  console.log("B");
}, 1000);

console.log("C");
```

Many beginners think:

```text
A
wait 1 second
B
C
```

That's not what happens.

Output:

```text
A
C
B
```

Why?

Because `setTimeout()` doesn't simply block the JavaScript thread.

---

# 7. What happens internally?

Conceptually:

```text
console.log("A")
       ↓
      "A"

setTimeout(...)
       ↓
  timer registered
       ↓
JavaScript continues

console.log("C")
       ↓
      "C"

timer finishes
       ↓
callback becomes eligible
       ↓
Event Loop
       ↓
Call Stack is empty
       ↓
callback executes
       ↓
"B"
```

---

# 8. Important: `setTimeout(0)` doesn't mean immediately

Consider:

```js
console.log("A");

setTimeout(() => {
  console.log("B");
}, 0);

console.log("C");
```

Output:

```text
A
C
B
```

Even with:

```js
setTimeout(..., 0)
```

the callback doesn't execute immediately.

It must wait until the current synchronous JavaScript work finishes and the runtime schedules the callback.

---

# 9. The Event Loop's basic job

A simplified mental model:

```text
          Is Call Stack empty?
                  │
            ┌─────┴─────┐
            │           │
           No          Yes
            │           │
            ↓           ↓
        Keep doing   Check queues
        current work     │
                         ↓
                    Take eligible
                    callback
                         │
                         ↓
                    Call Stack
```

This is why asynchronous callbacks don't interrupt currently executing JavaScript.

---

# 10. Promise callbacks are special

Now consider:

```js
console.log("A");

Promise.resolve().then(() => {
  console.log("B");
});

console.log("C");
```

Output:

```text
A
C
B
```

The Promise callback doesn't run immediately.

But it goes into the **microtask queue**.

---

# 11. Microtask Queue

Common microtasks include Promise reactions:

```js
Promise.then()
Promise.catch()
Promise.finally()
```

and continuations associated with:

```js
await
```

The microtask queue has high priority relative to the normal task queue.

A simplified order is:

```text
1. Execute current synchronous code
2. Drain microtasks
3. Process a task
4. Drain microtasks again
5. Continue
```

---

# 12. Task Queue

Timer and event callbacks are commonly associated with tasks.

For example:

```js
setTimeout(...)
```

and browser events such as:

```text
click
keydown
```

are scheduled through the browser's event/task mechanisms.

For learning purposes, think:

```text
Microtask Queue
→ Promise callbacks

Task Queue
→ timers/events
```

There are more details in the actual browser event loop model, but this distinction is the important foundation.

---

# 13. The classic interview example

Consider:

```js
console.log("1");

setTimeout(() => {
  console.log("2");
}, 0);

Promise.resolve().then(() => {
  console.log("3");
});

console.log("4");
```

What happens?

First synchronous code:

```text
1
4
```

Then microtasks:

```text
3
```

Then the timer task:

```text
2
```

Final output:

```text
1
4
3
2
```

---

# 14. Why does `3` happen before `2`?

Because:

```js
Promise.resolve().then(...)
```

queues a **microtask**.

While:

```js
setTimeout(...)
```

queues a **task**.

After the current synchronous code finishes, microtasks are processed before moving on to the next task.

Therefore:

```text
Synchronous
    ↓
1
4
    ↓
Microtask
    ↓
3
    ↓
Timer task
    ↓
2
```

---

# 15. `async/await` and the Event Loop

This is where your previous topics connect.

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

Output:

```text
C
A
D
B
```

Why?

Execution:

```text
console.log("C")
      ↓
C

test()
      ↓
console.log("A")
      ↓
A

await Promise.resolve()
      ↓
pause async function
      ↓
continuation becomes microtask

console.log("D")
      ↓
D

microtask runs
      ↓
console.log("B")
      ↓
B
```

So:

```text
async/await
      ↓
Promises
      ↓
Microtask Queue
      ↓
Event Loop
```

---

# 16. `await` doesn't block JavaScript

This is an important correction to a common misunderstanding.

```js
await fetch(...)
```

doesn't mean:

> "Freeze JavaScript until the server responds."

It means approximately:

> "Pause this async function's continuation and resume it later when the awaited Promise settles."

Other JavaScript can execute.

---

# 17. API request example

Consider:

```js
async function loadUsers() {
  console.log("Start");

  const response = await fetch("/api/users");

  console.log("Users received");
}
```

When:

```js
await fetch(...)
```

is reached:

```text
loadUsers()
    ↓
Start
    ↓
fetch request
    ↓
async function pauses
    ↓
browser handles network operation
    ↓
other JavaScript can execute
    ↓
server responds
    ↓
Promise settles
    ↓
continuation is scheduled
    ↓
"Users received"
```

This is how your React frontend can remain responsive while waiting for Spring Boot.

---

# 18. Event Loop and React

Suppose:

```jsx
<button onClick={handleClick}>
  Load Users
</button>
```

The browser detects the click.

Then:

```text
User clicks
    ↓
Browser event system
    ↓
React event handling
    ↓
handleClick()
    ↓
fetch()
    ↓
API request
    ↓
JavaScript continues
    ↓
Server response
    ↓
Promise continuation
    ↓
setUsers(data)
    ↓
React schedules update
    ↓
React renders
```

Understanding this flow will help you later understand React's rendering and asynchronous state behavior.

---

# 19. A very important example

```js
console.log("Start");

setTimeout(() => {
  console.log("Timeout");
}, 0);

Promise.resolve().then(() => {
  console.log("Promise");
});

console.log("End");
```

Don't memorize the output blindly.

Reason through it:

### Step 1 — synchronous

```text
Start
End
```

### Step 2 — microtasks

```text
Promise
```

### Step 3 — task

```text
Timeout
```

Final:

```text
Start
End
Promise
Timeout
```

The important skill is understanding **why**.

---

# 20. Multiple microtasks

Consider:

```js
Promise.resolve().then(() => {
  console.log("A");
});

Promise.resolve().then(() => {
  console.log("B");
});

console.log("C");
```

Output:

```text
C
A
B
```

Both Promise callbacks are microtasks.

They are processed in queue order.

---

# 21. Microtasks can delay tasks

Consider:

```js
setTimeout(() => {
  console.log("Timer");
}, 0);

Promise.resolve().then(() => {
  console.log("Microtask 1");
});

Promise.resolve().then(() => {
  console.log("Microtask 2");
});
```

Output:

```text
Microtask 1
Microtask 2
Timer
```

The runtime drains the microtask queue before proceeding to the timer task.

---

# 22. Why this matters in real applications

Suppose you create too much synchronous work:

```js
for (let i = 0; i < 10_000_000_000; i++) {
  // expensive work
}
```

The call stack remains busy.

The browser cannot get a chance to process other work normally.

The UI can become:

```text
Frozen
```

This is why JavaScript being asynchronous does **not** mean every operation is non-blocking.

---

# 23. CPU-heavy JavaScript still blocks

Consider:

```js
function expensiveCalculation() {
  for (let i = 0; i < 5_000_000_000; i++) {
    // expensive
  }
}
```

Calling:

```js
expensiveCalculation();
```

blocks the main JavaScript thread.

Even if you have:

```js
setTimeout(() => {
  console.log("Hello");
}, 0);
```

the timer callback cannot execute until the current JavaScript work gives the runtime an opportunity to continue.

---

# 24. This explains UI freezing

In React:

```js
function handleClick() {
  // huge synchronous calculation
}
```

If it takes several seconds:

```text
User clicks
   ↓
handleClick()
   ↓
CPU-heavy JavaScript
   ↓
Call Stack remains busy
   ↓
Browser can't smoothly process UI work
   ↓
UI appears frozen
```

This is why performance optimization matters.

---

# 25. Event Loop and `console.log`

Consider:

```js
console.log("A");

setTimeout(() => {
  console.log("B");
}, 0);

console.log("C");
```

You should reason:

```text
A
↓
synchronous

C
↓
synchronous

B
↓
timer callback after current work
```

Never think:

```text
setTimeout(0)
→ immediately execute
```

Think:

```text
setTimeout(0)
→ schedule callback
→ execute when eligible
```

---

# 26. Event Loop and closures

Now connect this with your previous topic.

```js
function createMessage() {
  const message = "Hello";

  setTimeout(() => {
    console.log(message);
  }, 1000);
}

createMessage();
```

Two concepts are working together:

```text
Closure
   ↓
callback remembers message

Event Loop
   ↓
callback executes later
```

This is a very important connection.

---

# 27. Event Loop + Promise + Closure

Consider:

```js
function processUser(name) {
  Promise.resolve().then(() => {
    console.log(name);
  });
}

processUser("Yash");
```

Three concepts:

```text
Higher-order function
        ↓
then() receives callback

Closure
        ↓
callback remembers name

Event Loop
        ↓
Promise callback runs as microtask
```

This is exactly how your JavaScript knowledge starts connecting together.

---

# 28. Common misconception

### Wrong:

> JavaScript is asynchronous.

More accurate:

> **JavaScript execution itself is synchronous and single-threaded in the usual browser main-thread model, while the runtime provides asynchronous APIs and the event loop coordinates callbacks.**

This distinction is important.

---

# 29. Common misconception

### Wrong:

```text
setTimeout(5000)
→ exactly after 5 seconds
```

More accurate:

```text
setTimeout(5000)
→ callback becomes eligible after at least the
   specified delay, subject to runtime scheduling
```

If the call stack is busy:

```js
setTimeout(callback, 0);
```

the callback still has to wait.

---

# 30. Common misconception

### Wrong:

> `await` blocks the browser.

Correct:

> `await` pauses the current async function's continuation; it doesn't block the entire JavaScript runtime.

---

# 31. Practical debugging with the Event Loop

When you see surprising execution order, ask:

```text
1. Is this synchronous?
        ↓
2. Is it a Promise/microtask?
        ↓
3. Is it a timer/event task?
        ↓
4. Is the call stack currently busy?
        ↓
5. Is there a closure capturing an old value?
```

This is an excellent debugging framework.

---

# 32. Practice — predict the output

Before running this, predict:

```js
console.log("1");

setTimeout(() => {
  console.log("2");
}, 0);

Promise.resolve().then(() => {
  console.log("3");
});

console.log("4");
```

Expected:

```text
1
4
3
2
```

Now try:

```js
console.log("A");

Promise.resolve()
  .then(() => {
    console.log("B");
  })
  .then(() => {
    console.log("C");
  });

setTimeout(() => {
  console.log("D");
}, 0);

console.log("E");
```

Expected:

```text
A
E
B
C
D
```

---

# 33. Another practice

Predict:

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

Expected:

```text
C
A
D
B
```

Explain it yourself before checking the answer.

---

# 34. Practice — real API scenario

Imagine:

```js
async function loadData() {
  console.log("1");

  const response = await fetch("/api/users");

  console.log("2");

  return response.json();
}

console.log("3");

loadData();

console.log("4");
```

The important point is:

```text
3
1
4
...
2
```

The exact timing of `2` depends on when the network Promise settles.

The event loop does **not** know that your API "should take 100 ms". It resumes the async function when the awaited Promise settles and its continuation gets scheduled.

---

# 35. Interview Questions

### Q1. What is the Event Loop?

A mechanism in the JavaScript runtime that coordinates execution of synchronous code and queued asynchronous callbacks/tasks.

### Q2. What is the Call Stack?

The structure used to track currently executing JavaScript function calls.

### Q3. What is a microtask?

A high-priority queued continuation, commonly created by Promise reactions and `await`.

### Q4. What is a task?

A unit of work such as a timer or certain browser event callbacks that can be processed by the runtime.

### Q5. Which runs first: Promise or `setTimeout(..., 0)`?

After the current synchronous execution finishes, a pending Promise reaction normally runs before the timer task.

### Q6. Does `setTimeout(fn, 0)` execute immediately?

No. It schedules the callback; it doesn't bypass the current call stack.

### Q7. Does `await` block the entire JavaScript thread?

No.

### Q8. Why can JavaScript handle API requests without freezing?

The runtime handles the asynchronous operation while JavaScript can continue executing other work; when the Promise settles, its continuation is scheduled.

---

# 36. Practice

Create:

```text
event-loop-practice.js
```

Practice:

```js
// 1. Predict the output:

console.log("A");

setTimeout(() => {
  console.log("B");
}, 0);

console.log("C");


// 2. Add a Promise and predict again.


// 3. Add multiple Promise callbacks.


// 4. Add multiple setTimeout callbacks.


// 5. Create an async function using await
//    and predict the execution order.


// 6. Explain why await doesn't block
//    the entire application.


// 7. Create an example where a long-running
//    synchronous loop delays a timer.


// 8. Create a closure + setTimeout example.


// 9. Create a closure + Promise example.


// 10. Explain the complete execution order
//     of your example.
```

---

# Quick Revision

```text
EVENT LOOP
│
├── Call Stack
│   └── Executes JavaScript
│
├── Runtime APIs
│   ├── Timers
│   ├── Network
│   └── DOM events
│
├── Microtask Queue
│   ├── Promise.then()
│   ├── Promise.catch()
│   ├── Promise.finally()
│   └── await continuations
│
├── Task Queue
│   ├── Timers
│   └── Browser events
│
└── Event Loop
    └── Coordinates what gets executed next
```

### The mental model

```text
Synchronous JavaScript
        ↓
   Call Stack
        ↓
current work finishes
        ↓
  Microtasks
        ↓
   Tasks / events
        ↓
  Call Stack again
```

### The most important execution rule

```text
┌───────────────────────────┐
│ 1. Synchronous JavaScript │
└─────────────┬─────────────┘
              ↓
┌───────────────────────────┐
│ 2. Drain microtasks       │
│    Promise / await        │
└─────────────┬─────────────┘
              ↓
┌───────────────────────────┐
│ 3. Process eligible task  │
│    timer / event          │
└─────────────┬─────────────┘
              ↓
       Drain microtasks
              ↓
           Repeat
```

And connect your previous topics:

```text
Closures
    ↓
Callbacks
    ↓
Promises
    ↓
async / await
    ↓
Microtask Queue
    ↓
Event Loop
    ↓
React event handlers
    ↓
API calls
    ↓
React state updates
```

> **Don't memorize the Event Loop as a diagram. Learn to trace code: identify synchronous work → identify Promise/microtask work → identify timer/event tasks → determine when each callback gets a chance to execute.**

That ability is what lets you debug confusing asynchronous JavaScript and React behavior.
