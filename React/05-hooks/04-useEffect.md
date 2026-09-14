# 04 — `useEffect` Hook in React

## WHY?

React components are mainly responsible for **rendering UI**.

But applications often need to interact with things **outside React**, such as:

* APIs
* Browser APIs
* Timers
* Event listeners
* WebSocket connections
* Third-party libraries
* Subscriptions

These are called **side effects** or, more precisely in modern React terminology, **synchronization with external systems**.

`useEffect` lets you perform that synchronization after React commits a render.

---

# WHAT?

### Definition

> **`useEffect` is a React Hook used to synchronize a component with an external system.**

Basic syntax:

```jsx
useEffect(() => {
  // Effect logic
}, [dependencies]);
```

Import:

```jsx
import { useEffect } from "react";
```

---

# WHERE?

`useEffect` is used inside:

* Function components
* Custom Hooks

Example:

```jsx
function App() {
  useEffect(() => {
    console.log("Effect ran");
  }, []);

  return <h1>Hello</h1>;
}
```

It follows the **Rules of Hooks**, so it must be called at the top level.

---

# HOW?

The basic flow is:

```text
Component renders
       ↓
React commits changes
       ↓
Effect runs
       ↓
External system is synchronized
```

For example:

```jsx
useEffect(() => {
  document.title = "Dashboard";
}, []);
```

After the component commits, the browser tab title is synchronized with `"Dashboard"`.

---

# 1. `useEffect` With No Dependency Array

```jsx
useEffect(() => {
  console.log("Effect ran");
});
```

The effect runs after **every committed render**.

Example:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    console.log("Render happened");
  });

  return (
    <button onClick={() => setCount(count + 1)}>
      {count}
    </button>
  );
}
```

Every state update causes another render, so the effect runs again.

---

# 2. `useEffect` With an Empty Dependency Array

```jsx
useEffect(() => {
  console.log("Effect ran");
}, []);
```

This means the effect has **no reactive dependencies**.

It generally runs after the component is mounted/committed, and React's development Strict Mode can intentionally run setup/cleanup an extra time to help find bugs.

Don't memorize this simply as:

> "`[]` means exactly once."

The more accurate idea is:

> **The effect doesn't depend on changing reactive values.**

---

# 3. `useEffect` With Dependencies

```jsx
useEffect(() => {
  console.log("Count changed:", count);
}, [count]);
```

Now React re-runs the effect when `count` changes.

Example:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    document.title = `Count: ${count}`;
  }, [count]);

  return (
    <button onClick={() => setCount(c => c + 1)}>
      {count}
    </button>
  );
}
```

Flow:

```text
count = 0
   ↓
Render
   ↓
Effect → title = Count: 0

Click
   ↓
count = 1
   ↓
Render
   ↓
Effect → title = Count: 1
```

---

# Dependency Array

The dependency array tells React:

> **Which reactive values does this effect depend on?**

Example:

```jsx
useEffect(() => {
  console.log(userId);
}, [userId]);
```

When `userId` changes, React re-synchronizes the effect.

---

# Practical Example — API Synchronization

Suppose you need to fetch user information when a `userId` changes.

```jsx
function UserProfile({ userId }) {
  const [user, setUser] = useState(null);

  useEffect(() => {
    fetch(`/api/users/${userId}`)
      .then(response => response.json())
      .then(data => {
        setUser(data);
      });
  }, [userId]);

  if (!user) {
    return <p>Loading...</p>;
  }

  return <h1>{user.name}</h1>;
}
```

The important part is:

```jsx
}, [userId]);
```

When:

```text
userId changes
      ↓
Component renders
      ↓
Effect re-runs
      ↓
New user is fetched
```

---

# Cleanup Function

Some effects create something that needs to be **stopped, disconnected, or removed**.

Examples:

* Event listeners
* Timers
* Subscriptions
* WebSocket connections

You can return a cleanup function:

```jsx
useEffect(() => {
  // Setup

  return () => {
    // Cleanup
  };
}, []);
```

---

# Example — Event Listener

```jsx
function WindowWidth() {
  const [width, setWidth] = useState(window.innerWidth);

  useEffect(() => {
    function handleResize() {
      setWidth(window.innerWidth);
    }

    window.addEventListener("resize", handleResize);

    return () => {
      window.removeEventListener("resize", handleResize);
    };
  }, []);

  return <p>Width: {width}px</p>;
}
```

Flow:

```text
Component commits
       ↓
Add resize listener
       ↓
Window resizes
       ↓
State updates
       ↓
Component re-renders
```

When the component is removed:

```text
Component unmounts
       ↓
Cleanup runs
       ↓
Event listener removed
```

This prevents the component from leaving unnecessary subscriptions behind.

---

# Example — Timer

```jsx
function Timer() {
  const [seconds, setSeconds] = useState(0);

  useEffect(() => {
    const id = setInterval(() => {
      setSeconds(prev => prev + 1);
    }, 1000);

    return () => {
      clearInterval(id);
    };
  }, []);

  return <h1>{seconds}</h1>;
}
```

Here:

```jsx
setInterval(...)
```

creates an external timer.

Cleanup:

```jsx
clearInterval(id);
```

stops it.

---

# Effect Setup → Cleanup → Setup

An important mental model is:

```text
Setup
  ↓
Effect is active
  ↓
Dependencies change
  ↓
Cleanup old effect
  ↓
Setup new effect
```

For example:

```jsx
useEffect(() => {
  const connection = connect(roomId);

  return () => {
    connection.disconnect();
  };
}, [roomId]);
```

If `roomId` changes:

```text
Old room
   ↓
disconnect()
   ↓
New room
   ↓
connect()
```

This is why cleanup should correctly **undo whatever setup did**.

---

# `useEffect` Is NOT a General "Run Code After Render" Tool

This is a very important modern React concept.

Beginners often think:

> "Whenever I want to run some code after rendering, I'll use `useEffect`."

That's not the best rule.

The better question is:

> **Am I synchronizing React with something outside React?**

If yes, `useEffect` may be appropriate.

---

# ❌ Don't Use Effect for Simple Calculations

Suppose:

```jsx
function Product({ price }) {
  const [tax, setTax] = useState(0);

  useEffect(() => {
    setTax(price * 0.18);
  }, [price]);

  return <p>{tax}</p>;
}
```

This is unnecessary.

`tax` is derived from `price`.

### ✅ Better

```jsx
function Product({ price }) {
  const tax = price * 0.18;

  return <p>{tax}</p>;
}
```

No effect is needed.

---

# ❌ Don't Use Effect for Event Handling

Suppose a button should submit a form.

### ❌ Unnecessary

```jsx
useEffect(() => {
  if (submitted) {
    submitForm();
  }
}, [submitted]);
```

If the action happens because the user clicked a button, handle it directly:

### ✅

```jsx
function handleSubmit() {
  submitForm();
}
```

```jsx
<button onClick={handleSubmit}>
  Submit
</button>
```

### Remember

```text
User event → Event handler

External synchronization → useEffect
```

---

# `useEffect` and Infinite Loops

Consider:

```jsx
useEffect(() => {
  setCount(count + 1);
}, [count]);
```

What happens?

```text
count changes
   ↓
effect runs
   ↓
setCount()
   ↓
count changes
   ↓
effect runs
   ↓
setCount()
   ↓
...
```

This can create an infinite update loop.

Be careful when an effect updates a state variable that is also one of its dependencies.

---

# Multiple Effects

You can have multiple effects.

```jsx
function App() {
  useEffect(() => {
    document.title = "My App";
  }, []);

  useEffect(() => {
    console.log("Component synchronized");
  }, []);

  return <h1>Hello</h1>;
}
```

It's often better to have **separate effects for unrelated synchronization processes** rather than one huge effect.

---

# Effect Dependencies and Stale Values

Consider:

```jsx
function App({ userId }) {
  useEffect(() => {
    console.log(userId);
  }, []);
}
```

The effect uses `userId`, but `userId` isn't listed as a dependency.

That can cause the effect to work with a value from an older render rather than re-synchronizing when the value changes.

Usually:

```jsx
useEffect(() => {
  console.log(userId);
}, [userId]);
```

is the correct model.

---

# Practical Example — Chat Connection

Imagine a chat application.

```jsx
function ChatRoom({ roomId }) {
  useEffect(() => {
    const connection = createConnection(roomId);

    connection.connect();

    return () => {
      connection.disconnect();
    };
  }, [roomId]);

  return <h1>Chat Room: {roomId}</h1>;
}
```

This is a classic use case.

```text
roomId
  ↓
Effect
  ↓
Connect to room
  ↓
roomId changes
  ↓
Disconnect old room
  ↓
Connect new room
```

This is exactly the type of **external synchronization** `useEffect` is designed for.

---

# WHEN?

Use `useEffect` when your component needs to synchronize with something outside React.

### Examples

```text
Browser API
    ↓
document.title

Event system
    ↓
addEventListener

Timer
    ↓
setInterval / setTimeout

Subscription
    ↓
subscribe / unsubscribe

WebSocket
    ↓
connect / disconnect

Third-party library
    ↓
initialize / cleanup

External data synchronization
    ↓
fetch / synchronize
```

---

# When NOT to Use `useEffect`

Don't automatically use it for:

```text
❌ Calculating a value
❌ Transforming data
❌ Handling a click
❌ Updating derived state
❌ Code that can run directly during rendering
```

Ask first:

> **"What external system am I synchronizing with?"**

If the answer is **nothing**, you may not need an Effect.

---

# Common Mistakes

## ❌ Missing dependencies

```jsx
useEffect(() => {
  console.log(userId);
}, []);
```

If the effect should respond to `userId`, use:

```jsx
useEffect(() => {
  console.log(userId);
}, [userId]);
```

---

## ❌ Forgetting cleanup

```jsx
useEffect(() => {
  window.addEventListener("resize", handleResize);
}, []);
```

Better:

```jsx
useEffect(() => {
  window.addEventListener("resize", handleResize);

  return () => {
    window.removeEventListener("resize", handleResize);
  };
}, []);
```

---

## ❌ Using Effect for derived values

```jsx
useEffect(() => {
  setFullName(`${firstName} ${lastName}`);
}, [firstName, lastName]);
```

Better:

```jsx
const fullName = `${firstName} ${lastName}`;
```

---

## ❌ Creating an infinite loop

```jsx
useEffect(() => {
  setCount(count + 1);
}, [count]);
```

---

## ❌ Putting unrelated logic into one huge Effect

Instead of:

```jsx
useEffect(() => {
  // API
  // timer
  // event listener
  // document title
  // analytics
}, []);
```

Prefer separate effects when they represent separate synchronization processes.

---

# 🎯 Interview Questions

### 1. What is `useEffect`?

> `useEffect` is a React Hook used to synchronize a component with external systems such as APIs, subscriptions, timers, browser APIs, and third-party libraries.

---

### 2. What is the purpose of the dependency array?

It specifies the reactive values that the Effect depends on.

```jsx
useEffect(() => {
  // logic
}, [userId]);
```

When `userId` changes, React re-runs the synchronization.

---

### 3. What does an empty dependency array mean?

```jsx
useEffect(() => {
  // ...
}, []);
```

It means the Effect has no reactive dependencies. It doesn't re-run because of changes to component reactive values.

In development Strict Mode, you may observe an extra setup/cleanup cycle.

---

### 4. What is the cleanup function?

The function returned from an Effect:

```jsx
useEffect(() => {
  // setup

  return () => {
    // cleanup
  };
}, []);
```

It is used to undo or stop the external synchronization established by the Effect.

---

### 5. When does cleanup run?

Cleanup can run:

```text
Before the Effect is re-synchronized
when dependencies change

AND

When the component is removed
```

React Strict Mode may also run setup → cleanup → setup in development to help detect incorrect Effect logic.

---

### 6. Can `useEffect` cause an infinite loop?

Yes.

For example:

```jsx
useEffect(() => {
  setCount(count + 1);
}, [count]);
```

The Effect changes a dependency that causes the Effect to run again.

---

### 7. Should API calls always be inside `useEffect`?

Not necessarily.

If you're responding to a user action such as submitting a form, the request can often be made directly inside the event handler.

For synchronization that depends on rendered state/props, an Effect can be appropriate.

---

### 8. What is the difference between `useEffect` and an event handler?

**Event handler:**

```text
User action
   ↓
onClick / onSubmit
```

**Effect:**

```text
React render/commit
   ↓
Synchronize with external system
```

---

# ⭐ Remember

```text
useEffect
    ↓
Synchronize with external system
    ↓
Setup
    ↓
External system active
    ↓
Dependency changes?
    ↓
Cleanup
    ↓
Setup again
```

### Golden Rule

> **Don't use `useEffect` just because you want to run code after rendering. Use it when you need to synchronize React with something outside React.**

### One-line interview answer

> **`useEffect` is a React Hook that lets a component synchronize with external systems and provides cleanup logic for undoing that synchronization.**
