# 08 — Common Rendering Mistakes in React

## WHY?

React automatically re-renders components when their **state or props change**.

But incorrect code can cause:

* Unnecessary re-renders
* Incorrect UI
* Lost state
* Infinite render loops
* Performance problems
* Incorrect list behavior

Understanding common rendering mistakes helps you write React applications that are **correct and efficient**.

---

# WHAT?

A **rendering mistake** is an incorrect pattern that causes React to render the UI incorrectly, unnecessarily, or repeatedly.

The most common mistakes are:

1. Updating state during rendering
2. Calling functions instead of passing them as event handlers
3. Using incorrect keys in lists
4. Mutating state directly
5. Creating unnecessary state
6. Incorrect conditional rendering
7. Doing expensive work on every render

---

# WHERE?

These mistakes commonly appear in:

* Components
* JSX
* Lists
* Event handlers
* State management
* Conditional rendering
* API/data rendering

---

# HOW?

## 1. ❌ Updating State During Render

Consider:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  setCount(count + 1);

  return <h1>{count}</h1>;
}
```

This is a serious mistake.

### Why?

Rendering causes:

```text
render
 ↓
setCount()
 ↓
state changes
 ↓
render
 ↓
setCount()
 ↓
state changes
 ↓
render
 ↓
...
```

This can create an **infinite render loop**.

### ✅ Correct

Update state in response to an event:

```jsx
function Counter() {
  const [count, setCount] = useState(0);

  function handleClick() {
    setCount(count + 1);
  }

  return (
    <>
      <h1>{count}</h1>

      <button onClick={handleClick}>
        Increase
      </button>
    </>
  );
}
```

---

# 2. ❌ Calling Event Handler During Rendering

Wrong:

```jsx
<button onClick={handleClick()}>
  Click
</button>
```

The function executes while React is rendering.

### ✅ Correct

```jsx
<button onClick={handleClick}>
  Click
</button>
```

If arguments are required:

```jsx
<button onClick={() => handleClick(10)}>
  Click
</button>
```

---

# 3. ❌ Using Array Index as Key

Suppose:

```jsx
const users = [
  { id: 1, name: "A" },
  { id: 2, name: "B" }
];
```

Avoid:

```jsx
users.map((user, index) => (
  <li key={index}>
    {user.name}
  </li>
));
```

It can cause problems when items are:

* Added
* Removed
* Reordered

### ✅ Better

Use a stable unique ID:

```jsx
users.map(user => (
  <li key={user.id}>
    {user.name}
  </li>
));
```

Remember:

```text
Stable ID → Good key
Array index → Usually avoid
```

---

# 4. ❌ Mutating State Directly

Suppose:

```jsx
const [user, setUser] = useState({
  name: "Yash",
  age: 21
});
```

Don't do:

```jsx
user.age = 22;
```

You're directly changing the existing state object.

### ✅ Correct

Create a new object:

```jsx
setUser({
  ...user,
  age: 22
});
```

React state should generally be treated as **immutable**.

---

# 5. ❌ Mutating Arrays

Wrong:

```jsx
const [items, setItems] = useState([]);

items.push("Apple");
```

### ✅ Correct

```jsx
setItems([
  ...items,
  "Apple"
]);
```

For removing:

```jsx
setItems(
  items.filter(item => item !== "Apple")
);
```

For updating:

```jsx
setItems(
  items.map(item =>
    item.id === 1
      ? { ...item, completed: true }
      : item
  )
);
```

---

# 6. ❌ Creating Unnecessary State

Suppose you have:

```jsx
const [firstName, setFirstName] = useState("Yash");
const [lastName, setLastName] = useState("Mahamuni");

const [fullName, setFullName] = useState("");
```

`fullName` doesn't need to be state.

It can be calculated:

```jsx
const fullName = `${firstName} ${lastName}`;
```

### Why?

If something can be **calculated from existing state or props**, you usually don't need separate state for it.

```text
Existing state
      ↓
Calculated value
      ↓
No extra state required
```

---

# 7. ❌ Incorrect Conditional Rendering

Suppose:

```jsx
const [count, setCount] = useState(0);
```

You write:

```jsx
{count && <h1>Hello</h1>}
```

When `count` is `0`, React may render:

```text
0
```

instead of nothing.

### Better

```jsx
{count > 0 && <h1>Hello</h1>}
```

This explicitly checks the condition.

---

# 8. ❌ Using Random Values During Rendering

Avoid:

```jsx
function App() {
  const id = Math.random();

  return <div>{id}</div>;
}
```

Every render can generate a new value.

This can make rendering unpredictable.

For IDs, use appropriate React mechanisms such as:

```jsx
useId()
```

when you need an ID associated with accessibility or DOM relationships.

---

# 9. ❌ Expensive Calculations on Every Render

Example:

```jsx
function ProductList({ products }) {
  const filteredProducts = products.filter(
    product => product.price > 1000
  );

  return (...);
}
```

For a small list, this is usually fine.

But if an expensive calculation happens on every render:

```jsx
const result = veryExpensiveCalculation(products);
```

it may hurt performance.

For genuinely expensive calculations, React provides:

```jsx
useMemo()
```

Example:

```jsx
const result = useMemo(() => {
  return veryExpensiveCalculation(products);
}, [products]);
```

Don't use `useMemo` everywhere. Use it when there is a real performance reason.

---

# 10. ❌ Changing Props

Props should be treated as **read-only**.

Suppose:

```jsx
function User({ user }) {
  user.name = "Rahul";

  return <h1>{user.name}</h1>;
}
```

Avoid directly modifying the prop.

Instead, the component that owns the state should update it.

```text
Parent
  ↓ props
Child
```

If the child needs to change the data, the parent can pass a callback:

```jsx
function Parent() {
  const [name, setName] = useState("Yash");

  return (
    <Child
      name={name}
      onChangeName={setName}
    />
  );
}
```

---

# Practical Example — Correct Rendering

```jsx
import { useState } from "react";

function TodoApp() {
  const [todos, setTodos] = useState([]);

  function addTodo() {
    const newTodo = {
      id: Date.now(),
      text: "Learn React"
    };

    setTodos(prevTodos => [
      ...prevTodos,
      newTodo
    ]);
  }

  return (
    <div>
      <button onClick={addTodo}>
        Add Todo
      </button>

      <ul>
        {todos.map(todo => (
          <li key={todo.id}>
            {todo.text}
          </li>
        ))}
      </ul>
    </div>
  );
}
```

This example follows several good practices:

```text
✅ State updated through setter
✅ Array not mutated directly
✅ Stable key used
✅ Event handler passed correctly
✅ UI derived from state
```

---

# React Rendering Mental Model

The most important concept is:

```text
State / Props change
        ↓
React renders component
        ↓
React calculates what UI should look like
        ↓
React commits necessary DOM changes
        ↓
Browser displays updated UI
```

You should **not manually manipulate the DOM** for normal React UI updates.

Avoid:

```jsx
document.getElementById("count").innerText = count;
```

Prefer:

```jsx
<h1>{count}</h1>
```

React manages the DOM based on your component's state and props.

---

# Common Mistakes Summary

| Mistake                            | Problem                     | Better approach                         |
| ---------------------------------- | --------------------------- | --------------------------------------- |
| `setState()` during render         | Infinite render loop        | Update in event/effect when appropriate |
| `onClick={fn()}`                   | Executes immediately        | `onClick={fn}`                          |
| `key={index}`                      | Can cause list/state issues | Stable unique ID                        |
| `array.push()`                     | Mutates state               | Create new array                        |
| `object.name = ...`                | Mutates state/props         | Create new object                       |
| Duplicate derived state            | Synchronization problems    | Calculate from existing data            |
| `count && ...`                     | May render `0`              | Use explicit condition                  |
| Random values during render        | Unstable output             | Stable IDs/mechanisms                   |
| Expensive calculation every render | Performance cost            | Optimize only when needed               |
| Direct DOM manipulation            | Conflicts with React        | Render from state/props                 |

---

# WHEN?

Think about rendering mistakes whenever:

### Your component renders repeatedly

Check whether you're accidentally updating state during render.

### Your list behaves strangely

Check your:

```jsx
key
```

### State changes aren't reflected correctly

Check whether you're mutating the state directly.

### UI contains duplicated state

Ask:

> Can I calculate this value from existing props/state?

### Performance is poor

Look for unnecessarily expensive work during rendering.

---

# Interview Questions

### 1. What happens if you update state during rendering?

It can trigger another render immediately and potentially create an **infinite render loop**.

---

### 2. Why shouldn't we mutate React state directly?

React state should be treated as immutable. Creating a new value makes state updates predictable and allows React to properly detect changes.

---

### 3. Why are keys important in React?

Keys help React identify which list items have changed, been added, removed, or reordered.

---

### 4. Why should we avoid array indexes as keys?

Indexes can change when items are inserted, removed, or reordered, which can cause React to associate the wrong component/state with an item.

---

### 5. Should every value be stored in state?

No.

If a value can be calculated from existing props or state, it generally doesn't need its own state.

---

### 6. What is the biggest rendering mistake beginners make?

A common mistake is thinking:

> "Whenever I want to change something, I'll call `setState`."

Instead, state should represent information that actually needs to persist between renders and affect the UI.

---

# ⭐ Remember

The golden rules:

```text
Don't update state while rendering
             ↓
Update state through setters
             ↓
Don't mutate state directly
             ↓
Use stable keys for lists
             ↓
Don't store unnecessary derived state
             ↓
Let React control the UI
```

### One-line interview answer

> **Common React rendering mistakes include updating state during render, mutating state directly, using unstable list keys, unnecessarily duplicating derived state, and performing expensive work on every render.**
