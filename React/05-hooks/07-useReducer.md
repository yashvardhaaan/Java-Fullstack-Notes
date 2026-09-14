# 07 — `useReducer` Hook in React

## WHY?

`useState` is excellent for simple state:

```jsx
const [count, setCount] = useState(0);
```

But as state logic becomes more complex, you may have:

* Many state variables
* Many ways to update state
* Conditional state transitions
* Related state values
* Complex event handling

For example:

```jsx
const [name, setName] = useState("");
const [email, setEmail] = useState("");
const [loading, setLoading] = useState(false);
const [error, setError] = useState(null);
```

Managing all these updates can become difficult.

`useReducer` lets you move the **state transition logic into one reducer function**.

---

# WHAT?

### Definition

> **`useReducer` is a React Hook used to manage state with a reducer function that determines how state changes in response to dispatched actions.**

Basic syntax:

```jsx
const [state, dispatch] = useReducer(
  reducer,
  initialState
);
```

There are three important concepts:

```text
state
  ↓
Current state

dispatch
  ↓
Sends an action

reducer
  ↓
Determines the next state
```

---

# WHERE?

`useReducer` is useful inside:

* Function components
* Custom Hooks

It is particularly useful when **state transitions are complex or closely related**.

Common examples:

```text
Forms
Shopping carts
Multi-step workflows
Authentication state
Complex UI state
Data fetching state
```

---

# HOW?

## Step 1 — Create Initial State

```jsx
const initialState = {
  count: 0
};
```

---

## Step 2 — Create Reducer

A reducer receives:

```text
current state
+
action
```

and returns:

```text
new state
```

Example:

```jsx
function reducer(state, action) {
  if (action.type === "increment") {
    return {
      ...state,
      count: state.count + 1
    };
  }

  if (action.type === "decrement") {
    return {
      ...state,
      count: state.count - 1
    };
  }

  return state;
}
```

---

## Step 3 — Use `useReducer`

```jsx
const [state, dispatch] = useReducer(
  reducer,
  initialState
);
```

---

## Step 4 — Dispatch Actions

```jsx
dispatch({
  type: "increment"
});
```

or:

```jsx
dispatch({
  type: "decrement"
});
```

Complete example:

```jsx
import { useReducer } from "react";

const initialState = {
  count: 0
};

function reducer(state, action) {
  switch (action.type) {
    case "increment":
      return {
        ...state,
        count: state.count + 1
      };

    case "decrement":
      return {
        ...state,
        count: state.count - 1
      };

    default:
      return state;
  }
}

function Counter() {
  const [state, dispatch] = useReducer(
    reducer,
    initialState
  );

  return (
    <div>
      <h1>{state.count}</h1>

      <button
        onClick={() =>
          dispatch({ type: "increment" })
        }
      >
        +
      </button>

      <button
        onClick={() =>
          dispatch({ type: "decrement" })
        }
      >
        -
      </button>
    </div>
  );
}
```

---

# Understand the Flow

This is the most important part.

```text
User clicks +
      ↓
dispatch({ type: "increment" })
      ↓
Reducer receives:
state + action
      ↓
Reducer calculates next state
      ↓
React stores new state
      ↓
Component renders again
```

More formally:

```text
dispatch(action)
       ↓
reducer(currentState, action)
       ↓
nextState
       ↓
React re-renders
```

---

# What Is an Action?

An action is an object describing **what happened**.

Example:

```jsx
{
  type: "increment"
}
```

Another:

```jsx
{
  type: "delete",
  id: 10
}
```

Another:

```jsx
{
  type: "setName",
  name: "Yash"
}
```

Usually the action has:

```text
type
payload/data
```

Example:

```jsx
dispatch({
  type: "addItem",
  payload: {
    id: 1,
    name: "Laptop"
  }
});
```

---

# Reducer With Payload

```jsx
function reducer(state, action) {
  switch (action.type) {
    case "add":
      return {
        ...state,
        count: state.count + action.payload
      };

    default:
      return state;
  }
}
```

Dispatch:

```jsx
dispatch({
  type: "add",
  payload: 5
});
```

The reducer receives:

```text
state
+
{
  type: "add",
  payload: 5
}
```

and returns the new state.

---

# `useReducer` vs `useState`

## `useState`

For simple state:

```jsx
const [count, setCount] = useState(0);

setCount(count + 1);
```

## `useReducer`

For more complex transitions:

```jsx
const [state, dispatch] = useReducer(
  reducer,
  initialState
);

dispatch({
  type: "increment"
});
```

### Simple comparison

| `useState`                  | `useReducer`                        |
| --------------------------- | ----------------------------------- |
| Simple state                | Complex state logic                 |
| Direct setter               | Dispatch actions                    |
| Update logic near component | Update logic centralized in reducer |
| Easy for small components   | Useful for complex components       |

---

# Practical Example — Form

Suppose you have:

```text
name
email
password
loading
error
```

With many independent `useState` calls:

```jsx
const [name, setName] = useState("");
const [email, setEmail] = useState("");
const [password, setPassword] = useState("");
const [loading, setLoading] = useState(false);
const [error, setError] = useState(null);
```

You can instead use:

```jsx
const initialState = {
  name: "",
  email: "",
  password: "",
  loading: false,
  error: null
};
```

Reducer:

```jsx
function reducer(state, action) {
  switch (action.type) {
    case "setName":
      return {
        ...state,
        name: action.payload
      };

    case "setEmail":
      return {
        ...state,
        email: action.payload
      };

    case "setPassword":
      return {
        ...state,
        password: action.payload
      };

    case "submit":
      return {
        ...state,
        loading: true,
        error: null
      };

    case "success":
      return {
        ...state,
        loading: false
      };

    case "error":
      return {
        ...state,
        loading: false,
        error: action.payload
      };

    default:
      return state;
  }
}
```

Then:

```jsx
const [state, dispatch] = useReducer(
  reducer,
  initialState
);
```

Update email:

```jsx
dispatch({
  type: "setEmail",
  payload: "yash@example.com"
});
```

---

# Reducers Should Be Pure

A reducer should generally be a **pure function**.

That means:

```text
Same state + same action
        ↓
Same result
```

Example:

```jsx
function reducer(state, action) {
  switch (action.type) {
    case "increment":
      return {
        ...state,
        count: state.count + 1
      };

    default:
      return state;
  }
}
```

A reducer should not perform side effects such as:

```text
❌ API calls
❌ setTimeout
❌ modifying the DOM
❌ random side effects
```

Keep side effects outside the reducer.

---

# Don't Mutate State

### ❌ Wrong

```jsx
function reducer(state, action) {
  state.count++;

  return state;
}
```

You're modifying the existing state object.

### ✅ Correct

```jsx
function reducer(state, action) {
  return {
    ...state,
    count: state.count + 1
  };
}
```

For arrays:

### ❌

```jsx
state.items.push(action.payload);

return state;
```

### ✅

```jsx
return {
  ...state,
  items: [
    ...state.items,
    action.payload
  ]
};
```

---

# Reducer With `switch`

A common pattern is:

```jsx
function reducer(state, action) {
  switch (action.type) {
    case "increment":
      return {
        ...state,
        count: state.count + 1
      };

    case "decrement":
      return {
        ...state,
        count: state.count - 1
      };

    case "reset":
      return initialState;

    default:
      return state;
  }
}
```

The `default` case is important so unexpected actions don't accidentally produce an invalid state.

---

# `useReducer` for Shopping Cart

This is a good real-world example.

```jsx
const initialState = {
  items: []
};
```

Reducer:

```jsx
function cartReducer(state, action) {
  switch (action.type) {
    case "add":
      return {
        ...state,
        items: [
          ...state.items,
          action.payload
        ]
      };

    case "remove":
      return {
        ...state,
        items: state.items.filter(
          item => item.id !== action.payload
        )
      };

    case "clear":
      return {
        ...state,
        items: []
      };

    default:
      return state;
  }
}
```

Use it:

```jsx
function Cart() {
  const [state, dispatch] = useReducer(
    cartReducer,
    initialState
  );

  function addItem(item) {
    dispatch({
      type: "add",
      payload: item
    });
  }

  function removeItem(id) {
    dispatch({
      type: "remove",
      payload: id
    });
  }

  return (
    <div>
      <p>
        Items: {state.items.length}
      </p>
    </div>
  );
}
```

Now all cart transitions are centralized in:

```text
cartReducer
```

---

# `useReducer` + Context

A very common React architecture is:

```text
useReducer
     ↓
State + dispatch
     ↓
Context
     ↓
Multiple components
```

For example:

```jsx
const [state, dispatch] = useReducer(
  cartReducer,
  initialState
);
```

Then:

```jsx
<CartContext.Provider
  value={{ state, dispatch }}
>
  <App />
</CartContext.Provider>
```

Components can consume:

```jsx
const { state, dispatch } =
  useContext(CartContext);
```

This can provide a lightweight shared-state architecture without automatically needing a dedicated state-management library.

---

# `useState` → `useReducer` Refactoring

### Before

```jsx
const [count, setCount] = useState(0);

function increment() {
  setCount(count + 1);
}

function decrement() {
  setCount(count - 1);
}
```

### After

```jsx
const [state, dispatch] = useReducer(
  reducer,
  { count: 0 }
);

function increment() {
  dispatch({ type: "increment" });
}

function decrement() {
  dispatch({ type: "decrement" });
}
```

The UI becomes focused on **what happened**, while the reducer defines **how state changes**.

---

# WHEN?

Use `useReducer` when:

### 1. State logic is complex

```text
Many possible transitions
        ↓
useReducer
```

### 2. Multiple state values are related

```text
loading
data
error
```

These often form one state machine-like flow.

### 3. Many events update the same state

```text
add
remove
update
reset
submit
success
error
```

### 4. You want centralized state-transition logic

```text
Component
    ↓
dispatch(action)
    ↓
Reducer
    ↓
new state
```

---

# When NOT to Use `useReducer`

Don't use it for every tiny piece of state.

For:

```jsx
const [isOpen, setIsOpen] = useState(false);
```

`useState` is usually clearer.

You don't need:

```jsx
dispatch({ type: "OPEN_MODAL" });
```

for a simple boolean unless there is a real reason.

---

# `useReducer` vs Redux

They are **not the same thing**.

### `useReducer`

```text
React Hook
     ↓
Component-local state logic
```

### Redux

```text
Dedicated state-management library
     ↓
Store
     ↓
Actions
     ↓
Reducers
     ↓
Multiple parts of application
```

The concepts are related, but `useReducer` itself is not Redux.

---

# Common Mistakes

### ❌ Mutating state

```jsx
state.items.push(item);
return state;
```

### ✅

```jsx
return {
  ...state,
  items: [...state.items, item]
};
```

---

### ❌ Putting API calls inside reducer

```jsx
function reducer(state, action) {
  fetch("/api"); // ❌
}
```

Keep side effects outside the reducer.

---

### ❌ Using `useReducer` for everything

Simple state is often clearer with:

```jsx
useState()
```

---

### ❌ Forgetting `return`

A reducer must return the next state.

```jsx
function reducer(state, action) {
  switch (action.type) {
    case "increment":
      return {
        ...state,
        count: state.count + 1
      };

    default:
      return state;
  }
}
```

---

# 🎯 Interview Questions

### 1. What is `useReducer`?

> `useReducer` is a React Hook for managing state using a reducer function that receives the current state and an action and returns the next state.

---

### 2. What does `useReducer` return?

```jsx
const [state, dispatch] = useReducer(
  reducer,
  initialState
);
```

It returns:

```text
state
dispatch function
```

---

### 3. What is a reducer?

A reducer is a function that determines the next state from the current state and an action.

```jsx
function reducer(state, action) {
  // return next state
}
```

---

### 4. What is an action?

An action describes what happened.

```jsx
{
  type: "increment"
}
```

or:

```jsx
{
  type: "addItem",
  payload: item
}
```

---

### 5. When should you use `useReducer` instead of `useState`?

> Use `useReducer` when state transitions become complex, multiple actions affect related state, or centralizing update logic makes the component easier to understand.

---

### 6. Should reducers perform side effects?

No.

Reducers should be pure and should only calculate the next state.

---

### 7. Can `useReducer` manage objects and arrays?

Yes.

```jsx
const [state, dispatch] = useReducer(
  reducer,
  {
    user: null,
    items: [],
    loading: false
  }
);
```

---

### 8. Is `useReducer` Redux?

No.

> `useReducer` is a built-in React Hook, while Redux is a separate state-management library.

---

# ⭐ Remember

```text
useReducer
    ↓
Current State
    +
Action
    ↓
Reducer
    ↓
Next State
    ↓
React Re-render
```

### Golden Rule

> **Use `useState` for simple state and consider `useReducer` when the logic for transitioning between states becomes complex.**

### One-line interview answer

> **`useReducer` is a React Hook that centralizes complex state-transition logic by taking the current state and a dispatched action and returning the next state.**
