# 09 — `useCallback` Hook in React

## WHY?

In JavaScript, a function created inside a component is a **new function object on every render**.

For example:

```jsx
function App() {
  const handleClick = () => {
    console.log("Clicked");
  };

  return <button onClick={handleClick}>Click</button>;
}
```

Every time `App` renders:

```text
Render 1 → handleClick₁
Render 2 → handleClick₂
Render 3 → handleClick₃
```

Even though the function does the same thing, its **reference is different**.

This can matter when passing callbacks to optimized child components such as those wrapped with `React.memo`.

`useCallback` lets React reuse the same function reference until its dependencies change.

---

# WHAT?

### Definition

> **`useCallback` is a React Hook that caches a function definition between re-renders until its dependencies change.**

Basic syntax:

```jsx
const handleClick = useCallback(() => {
  // function logic
}, [dependencies]);
```

Import:

```jsx
import { useCallback } from "react";
```

---

# WHERE?

`useCallback` is mainly useful when:

* Passing a function to a memoized child
* A function is used as a dependency of another Hook
* Creating a function is part of a performance optimization
* You need a stable function reference for some integration

It is **not necessary for every function** you create.

---

# HOW?

## Basic Example

```jsx
import { useCallback } from "react";

function App() {
  const handleClick = useCallback(() => {
    console.log("Clicked");
  }, []);

  return (
    <button onClick={handleClick}>
      Click
    </button>
  );
}
```

Because the dependency array is empty:

```jsx
[]
```

the callback has no reactive dependencies.

---

# Understanding Function Identity

Consider:

```jsx
function App() {
  const handleClick = () => {
    console.log("Clicked");
  };

  return <Child onClick={handleClick} />;
}
```

When `App` renders again:

```text
Old render:
handleClick → Function A

New render:
handleClick → Function B
```

They may contain identical code, but:

```jsx
FunctionA !== FunctionB
```

because they are different function objects.

---

# `useCallback` Stabilizes the Reference

```jsx
const handleClick = useCallback(() => {
  console.log("Clicked");
}, []);
```

Conceptually:

```text
First render
     ↓
Create function
     ↓
Store callback
     ↓
Next render
     ↓
Dependencies unchanged
     ↓
Reuse same function reference
```

---

# Practical Example With `React.memo`

This is one of the most important use cases.

### Child

```jsx
const Button = React.memo(function Button({ onClick }) {
  console.log("Button rendered");

  return (
    <button onClick={onClick}>
      Click
    </button>
  );
});
```

### Parent

```jsx
function App() {
  const [count, setCount] = useState(0);

  const handleClick = useCallback(() => {
    console.log("Button clicked");
  }, []);

  return (
    <>
      <p>{count}</p>

      <button onClick={() => setCount(c => c + 1)}>
        Increase
      </button>

      <Button onClick={handleClick} />
    </>
  );
}
```

Now when `count` changes:

```text
App re-renders
     ↓
handleClick reference remains stable
     ↓
Button receives same onClick reference
     ↓
React.memo can skip Button's render
```

This can be useful when the child is expensive to render.

---

# What If We Don't Use `useCallback`?

```jsx
function App() {
  const [count, setCount] = useState(0);

  const handleClick = () => {
    console.log("Clicked");
  };

  return (
    <>
      <button onClick={() => setCount(c => c + 1)}>
        {count}
      </button>

      <Button onClick={handleClick} />
    </>
  );
}
```

When `App` re-renders:

```text
New render
   ↓
New handleClick function
   ↓
New function reference
   ↓
Button receives different prop
```

If `Button` is memoized, that changed function reference can prevent `React.memo` from skipping the child render.

---

# `useCallback` vs `useMemo`

Very important interview question.

## `useMemo`

Caches a **calculated value**.

```jsx
const result = useMemo(() => {
  return calculate(data);
}, [data]);
```

Think:

```text
Calculation → Value
```

---

## `useCallback`

Caches a **function**.

```jsx
const handleClick = useCallback(() => {
  doSomething();
}, []);
```

Think:

```text
Function → Function reference
```

### Easy Trick

```text
useMemo
→ Memoize VALUE

useCallback
→ Memoize CALLBACK
```

---

# `useCallback` With Dependencies

Suppose the function uses `count`:

```jsx
const handleClick = useCallback(() => {
  console.log(count);
}, [count]);
```

Why?

Because the callback depends on:

```text
count
```

When `count` changes:

```text
count changes
     ↓
Dependency changes
     ↓
New callback function is created
```

When `count` doesn't change:

```text
Dependency unchanged
     ↓
Same callback reference can be reused
```

---

# Example With Props

```jsx
function Product({ productId }) {
  const handleDelete = useCallback(() => {
    deleteProduct(productId);
  }, [productId]);

  return (
    <button onClick={handleDelete}>
      Delete
    </button>
  );
}
```

Because:

```jsx
deleteProduct(productId)
```

uses `productId`, it belongs in the dependency list.

---

# `useCallback` Does NOT Prevent Parent Re-renders

Another important interview point.

```jsx
const handleClick = useCallback(() => {
  console.log("Clicked");
}, []);
```

This does **not** mean:

```text
Parent won't re-render
```

The parent can still render normally.

`useCallback` only helps maintain a stable function reference.

---

# `useCallback` + `React.memo`

These often work together.

```text
             Parent
               |
          useCallback
               |
        stable function
               |
          React.memo
               |
             Child
```

Example:

```jsx
const Child = React.memo(function Child({ onClick }) {
  return <button onClick={onClick}>Click</button>;
});
```

Parent:

```jsx
const handleClick = useCallback(() => {
  console.log("Clicked");
}, []);
```

The purpose is:

```text
Stable callback
      +
Memoized child
      ↓
Potentially fewer child renders
```

---

# Important: `useCallback` Isn't Automatically Better

Don't write:

```jsx
const add = useCallback(() => {
  return a + b;
}, [a, b]);
```

just because you can.

For a simple function, this can add unnecessary complexity.

Use it when there is a **real reason for function-reference stability or a measured/likely performance benefit**.

---

# Common Example — Search

```jsx
function Search({ onSearch }) {
  return (
    <input
      onChange={e =>
        onSearch(e.target.value)
      }
    />
  );
}
```

Parent:

```jsx
function App() {
  const [query, setQuery] = useState("");

  const handleSearch = useCallback((value) => {
    setQuery(value);
  }, []);

  return (
    <Search onSearch={handleSearch} />
  );
}
```

The callback has a stable reference while its dependencies remain unchanged.

---

# `useCallback` and Effects

Sometimes a function is used inside an Effect.

For example:

```jsx
function Chat({ roomId }) {
  const createOptions = useCallback(() => {
    return {
      roomId
    };
  }, [roomId]);

  useEffect(() => {
    const options = createOptions();

    // synchronize with chat system
  }, [createOptions]);

  return <div>Chat</div>;
}
```

But don't automatically solve every Effect dependency problem with `useCallback`.

Often, the simpler solution is to define the function **inside the Effect** if it is only needed there:

```jsx
function Chat({ roomId }) {
  useEffect(() => {
    const options = {
      roomId
    };

    // synchronize
  }, [roomId]);

  return <div>Chat</div>;
}
```

This is often easier to understand.

---

# Function Reference vs Function Result

This is critical.

### Function

```jsx
const handleClick = () => {
  console.log("Hello");
};
```

### Calling function

```jsx
handleClick();
```

### `useCallback`

```jsx
const handleClick = useCallback(() => {
  console.log("Hello");
}, []);
```

It gives you a **function reference**, not the result of executing the function.

---

# Practical Example — Todo App

```jsx
function TodoApp() {
  const [todos, setTodos] = useState([]);

  const deleteTodo = useCallback((id) => {
    setTodos(prev =>
      prev.filter(todo => todo.id !== id)
    );
  }, []);

  return (
    <>
      {todos.map(todo => (
        <Todo
          key={todo.id}
          todo={todo}
          onDelete={deleteTodo}
        />
      ))}
    </>
  );
}
```

If `Todo` is memoized:

```jsx
const Todo = React.memo(function Todo({
  todo,
  onDelete
}) {
  return (
    <div>
      {todo.text}

      <button onClick={() => onDelete(todo.id)}>
        Delete
      </button>
    </div>
  );
});
```

The stable `deleteTodo` reference can help avoid unnecessary child renders when the relevant props haven't changed.

---

# WHEN?

Use `useCallback` when:

### 1. Passing callbacks to memoized children

```text
Parent
 ↓
useCallback
 ↓
React.memo Child
```

### 2. Function identity matters

Some APIs or integrations care about whether the exact same function reference is retained.

### 3. A function is a dependency

When appropriate, a stable callback can prevent unnecessary Effect re-synchronization.

---

# When NOT to Use `useCallback`

Don't use it for every function:

```jsx
const handleClick = useCallback(() => {
  console.log("Hello");
}, []);
```

If:

* The child isn't memoized
* Function identity doesn't matter
* The function is cheap
* There is no performance issue

then ordinary functions are often simpler.

---

# Common Mistakes

### ❌ Mistake 1 — Thinking `useCallback` caches the result

Wrong:

```text
useCallback → caches result
```

Correct:

```text
useCallback → caches function reference
```

---

### ❌ Mistake 2 — Missing dependencies

```jsx
const handleClick = useCallback(() => {
  console.log(userId);
}, []);
```

If the callback needs the current `userId`, it should generally be:

```jsx
const handleClick = useCallback(() => {
  console.log(userId);
}, [userId]);
```

---

### ❌ Mistake 3 — Using it everywhere

Memoization isn't free.

---

### ❌ Mistake 4 — Thinking it prevents parent renders

It doesn't.

```text
useCallback
≠
prevent re-render
```

---

### ❌ Mistake 5 — Using `useCallback` without a reason

Ask:

> **Does the function's reference need to remain stable?**

If not, you probably don't need it.

---

# 🎯 Interview Questions

### 1. What is `useCallback`?

> `useCallback` is a React Hook that caches a function definition between re-renders until its dependencies change.

---

### 2. Why is `useCallback` used?

> It is primarily used when function-reference stability matters, especially when passing callbacks to memoized children or when a callback participates in another Hook's dependencies.

---

### 3. What is the difference between `useMemo` and `useCallback`?

```text
useMemo
→ caches a calculated value

useCallback
→ caches a function
```

---

### 4. Does `useCallback` prevent re-rendering?

No.

It only provides a stable function reference when dependencies haven't changed.

---

### 5. When does `useCallback` create a new function?

When one or more dependencies change.

```jsx
useCallback(
  () => doSomething(id),
  [id]
);
```

If `id` changes, the callback can be recreated.

---

### 6. Why is `useCallback` often used with `React.memo`?

Because `React.memo` compares props, and a newly created function has a new reference.

```text
New function reference
        ↓
Prop changed
        ↓
memoized child may render again
```

`useCallback` can keep that reference stable when appropriate.

---

### 7. Should every event handler use `useCallback`?

No.

Only use it when stable function identity provides a meaningful benefit.

---

### 8. Can `useCallback` have dependencies?

Yes.

```jsx
const handleClick = useCallback(() => {
  console.log(user.name);
}, [user]);
```

Dependencies should include the reactive values used by the callback.

---

# ⭐ Remember

```text
useCallback(() => {
   // function
}, [dependencies])
        ↓
Cached function reference
        ↓
Dependencies unchanged?
       /       \
     YES        NO
      ↓          ↓
Reuse       New function
reference    reference
```

### Golden Rule

> **`useCallback` is about stabilizing a function reference, not making the function itself magically faster.**

### One-line interview answer

> **`useCallback` is a React Hook that caches a function reference between renders and updates that reference when its dependencies change, mainly to support performance optimizations involving function identity.**
