# 05 — State Immutability in React

## WHY?

React state should be treated as **immutable**.

That means:

> **Don't directly modify the existing state. Create a new value and give it to the state setter.**

This is especially important for:

* Objects
* Arrays
* Nested data
* Lists
* Forms
* Complex application state

Incorrect mutation can cause React to miss changes or make your application difficult to reason about.

---

# WHAT?

**Immutability** means that instead of changing an existing state object/array, you create a **new object/array** containing the updated data.

### ❌ Mutation

```jsx
user.age = 22;
```

You're changing the existing object.

### ✅ Immutable update

```jsx
setUser(prev => ({
  ...prev,
  age: 22
}));
```

You're creating a new object.

Think:

```text
❌ Modify existing state

Old Object
    ↓
Change it directly


✅ Create new state

Old Object
    ↓
Copy
    ↓
Modify copy
    ↓
New Object
```

---

# WHERE?

Immutability is especially important when your state contains:

```jsx
Object
Array
Nested Object
Array of Objects
```

For example:

```jsx
const [user, setUser] = useState({
  name: "Yash",
  age: 21
});
```

or:

```jsx
const [items, setItems] = useState([]);
```

---

# HOW?

## 1. Updating an Object

Suppose:

```jsx
const [user, setUser] = useState({
  name: "Yash",
  age: 21
});
```

### ❌ Wrong

```jsx
user.age = 22;
```

You're directly modifying the existing state object.

### ❌ Also problematic

```jsx
setUser(user);
```

If you've mutated `user` and then pass that same object back, you're still reusing the same object reference.

---

### ✅ Correct

```jsx
setUser({
  ...user,
  age: 22
});
```

Even better when depending on previous state:

```jsx
setUser(prev => ({
  ...prev,
  age: 22
}));
```

The spread operator copies the existing properties and then replaces `age`.

---

# 2. Adding a Property

```jsx
const [user, setUser] = useState({
  name: "Yash"
});
```

Add age:

```jsx
setUser(prev => ({
  ...prev,
  age: 21
}));
```

Result:

```js
{
  name: "Yash",
  age: 21
}
```

---

# 3. Updating an Array

Suppose:

```jsx
const [items, setItems] = useState([
  "Apple",
  "Mango"
]);
```

### ❌ Don't use

```jsx
items.push("Banana");
```

This mutates the existing array.

### ✅ Use

```jsx
setItems(prev => [
  ...prev,
  "Banana"
]);
```

Result:

```text
["Apple", "Mango", "Banana"]
```

A **new array** is created.

---

# 4. Removing From an Array

Suppose:

```jsx
const [items, setItems] = useState([
  "Apple",
  "Mango",
  "Banana"
]);
```

### ❌ Don't use

```jsx
items.splice(1, 1);
```

This mutates the original array.

### ✅ Use `filter()`

```jsx
setItems(prev =>
  prev.filter(item => item !== "Mango")
);
```

Result:

```text
["Apple", "Banana"]
```

---

# 5. Updating an Array Item

Suppose:

```jsx
const [todos, setTodos] = useState([
  {
    id: 1,
    text: "Learn React",
    completed: false
  },
  {
    id: 2,
    text: "Learn JavaScript",
    completed: false
  }
]);
```

You want to mark Todo `1` as completed.

### ❌ Don't do

```jsx
todos[0].completed = true;
```

This mutates the existing object inside the array.

### ✅ Do this

```jsx
setTodos(prevTodos =>
  prevTodos.map(todo =>
    todo.id === 1
      ? { ...todo, completed: true }
      : todo
  )
);
```

Result:

```js
[
  {
    id: 1,
    text: "Learn React",
    completed: true
  },
  {
    id: 2,
    text: "Learn JavaScript",
    completed: false
  }
]
```

---

# 6. Why the Spread Operator Is Important

The spread operator:

```jsx
...
```

helps create a new object or array.

### Object

```jsx
const newUser = {
  ...user,
  age: 22
};
```

### Array

```jsx
const newItems = [
  ...items,
  "Apple"
];
```

Think:

```text
...oldData
     ↓
Copy old data
     ↓
Modify/add required data
     ↓
New value
```

---

# 7. Nested Objects

Suppose:

```jsx
const [user, setUser] = useState({
  name: "Yash",
  address: {
    city: "Pune",
    pin: 411001
  }
});
```

You want to change the city.

### ❌ Wrong

```jsx
user.address.city = "Mumbai";
```

This directly mutates the nested object.

### ✅ Correct

```jsx
setUser(prev => ({
  ...prev,
  address: {
    ...prev.address,
    city: "Mumbai"
  }
}));
```

Notice that we copy **each level that we're changing**.

```text
user
 ↓
copy user
 ↓
address
 ↓
copy address
 ↓
change city
```

---

# 8. Nested Arrays of Objects

Real applications often have structures like:

```jsx
const [users, setUsers] = useState([
  {
    id: 1,
    name: "Yash",
    address: {
      city: "Pune"
    }
  },
  {
    id: 2,
    name: "Rahul",
    address: {
      city: "Mumbai"
    }
  }
]);
```

To change Yash's city:

```jsx
setUsers(prevUsers =>
  prevUsers.map(user =>
    user.id === 1
      ? {
          ...user,
          address: {
            ...user.address,
            city: "Delhi"
          }
        }
      : user
  )
);
```

This may look complicated, but the principle is simple:

> **Create new references for the parts of the state you're changing.**

---

# 9. Why Does React Care About Immutability?

JavaScript objects and arrays are **reference values**.

For example:

```jsx
const user1 = {
  name: "Yash"
};

const user2 = user1;
```

Now:

```text
user1 ─────┐
           ↓
        Same Object
           ↑
user2 ─────┘
```

If you do:

```jsx
user2.name = "Rahul";
```

then `user1.name` also becomes:

```text
Rahul
```

because both variables refer to the same object.

Creating a new object avoids this problem:

```jsx
const user2 = {
  ...user1,
  name: "Rahul"
};
```

Now:

```text
user1 → Old Object

user2 → New Object
```

---

# 10. Referential Equality

This is an important React/interview concept.

Consider:

```jsx
const user = {
  name: "Yash"
};

const sameUser = user;
```

Then:

```jsx
sameUser === user
```

is:

```text
true
```

They reference the same object.

But:

```jsx
const newUser = {
  ...user
};
```

Then:

```jsx
newUser === user
```

is:

```text
false
```

because a new object was created.

React and React-related optimizations can use these reference changes to determine whether values have changed.

---

# Practical Example — Todo App

```jsx
import { useState } from "react";

function TodoApp() {
  const [todos, setTodos] = useState([
    {
      id: 1,
      text: "Learn React",
      completed: false
    }
  ]);

  function completeTodo(id) {
    setTodos(prevTodos =>
      prevTodos.map(todo =>
        todo.id === id
          ? { ...todo, completed: true }
          : todo
      )
    );
  }

  return (
    <div>
      {todos.map(todo => (
        <div key={todo.id}>
          <span>
            {todo.text}
          </span>

          <button onClick={() => completeTodo(todo.id)}>
            Complete
          </button>
        </div>
      ))}
    </div>
  );
}

export default TodoApp;
```

Notice:

```jsx
{ ...todo, completed: true }
```

creates a new object instead of modifying the old todo.

---

# Common Array Operations

| Operation | ❌ Avoid mutation     | ✅ Prefer                 |
| --------- | -------------------- | ------------------------ |
| Add       | `push()`             | `[...arr, item]`         |
| Remove    | `splice()`           | `filter()`               |
| Replace   | Direct assignment    | `map()`                  |
| Sort      | `sort()` directly    | Copy first, then sort    |
| Reverse   | `reverse()` directly | Copy first, then reverse |

---

# Example — Sorting

### ❌ Wrong

```jsx
items.sort();
```

`sort()` mutates the array.

### ✅ Better

```jsx
setItems(prev =>
  [...prev].sort()
);
```

A copy is created first.

---

# Example — Reverse

### ❌ Wrong

```jsx
items.reverse();
```

### ✅ Correct

```jsx
setItems(prev =>
  [...prev].reverse()
);
```

---

# State Immutability Mental Model

Always think:

```text
OLD STATE
    ↓
Don't modify it
    ↓
Create a copy
    ↓
Modify the copy
    ↓
Pass new value to setter
    ↓
React renders with new state
```

---

# WHEN?

Use immutable updates whenever you modify:

### Object

```jsx
setUser(prev => ({
  ...prev,
  name: "Rahul"
}));
```

### Array

```jsx
setItems(prev => [
  ...prev,
  newItem
]);
```

### Remove

```jsx
setItems(prev =>
  prev.filter(item => item.id !== id)
);
```

### Update array item

```jsx
setItems(prev =>
  prev.map(item =>
    item.id === id
      ? { ...item, completed: true }
      : item
  )
);
```

### Nested object

```jsx
setUser(prev => ({
  ...prev,
  address: {
    ...prev.address,
    city: "Mumbai"
  }
}));
```

---

# Common Mistakes

## ❌ Direct object mutation

```jsx
user.name = "Rahul";
```

### ✅

```jsx
setUser(prev => ({
  ...prev,
  name: "Rahul"
}));
```

---

## ❌ Array mutation

```jsx
items.push(newItem);
```

### ✅

```jsx
setItems(prev => [
  ...prev,
  newItem
]);
```

---

## ❌ `splice()`

```jsx
items.splice(index, 1);
```

### ✅

```jsx
setItems(prev =>
  prev.filter((_, i) => i !== index)
);
```

---

## ❌ Mutating nested data

```jsx
user.address.city = "Delhi";
```

### ✅

```jsx
setUser(prev => ({
  ...prev,
  address: {
    ...prev.address,
    city: "Delhi"
  }
}));
```

---

# Interview Questions

### 1. What does immutability mean in React?

> Immutability means treating state as read-only and creating a new object or array when updating state instead of modifying the existing value.

---

### 2. Why shouldn't we mutate React state directly?

Direct mutation can make state changes harder for React and developers to reason about and can lead to incorrect rendering behavior and stale references.

---

### 3. How do you add an item to an array state?

```jsx
setItems(prev => [
  ...prev,
  newItem
]);
```

---

### 4. How do you remove an item?

```jsx
setItems(prev =>
  prev.filter(item => item.id !== id)
);
```

---

### 5. How do you update an object state?

```jsx
setUser(prev => ({
  ...prev,
  name: "Rahul"
}));
```

---

### 6. How do you update an object inside an array?

```jsx
setUsers(prev =>
  prev.map(user =>
    user.id === id
      ? { ...user, name: "Rahul" }
      : user
  )
);
```

---

### 7. What is referential equality?

It checks whether two variables refer to the **same object or array in memory**.

```jsx
const a = {};
const b = a;

console.log(a === b); // true
```

But:

```jsx
const a = {};
const b = { ...a };

console.log(a === b); // false
```

---

# ⭐ Remember

The most important rule:

```text
NEVER directly modify state
            ↓
Create a new value
            ↓
Pass it to setState
```

### Object

```jsx
setUser(prev => ({
  ...prev,
  age: 22
}));
```

### Array

```jsx
setItems(prev => [
  ...prev,
  item
]);
```

### Remove

```jsx
setItems(prev =>
  prev.filter(item => item.id !== id)
);
```

### Update

```jsx
setItems(prev =>
  prev.map(item =>
    item.id === id
      ? { ...item, completed: true }
      : item
  )
);
```

### One-line interview answer

> **React state should be treated as immutable: instead of modifying an existing object or array, create a new value and pass it to the state setter so state updates remain predictable.**
