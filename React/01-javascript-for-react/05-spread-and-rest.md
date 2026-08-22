# 05 — Spread and Rest Operators

This is a **very important React topic**, especially for **state updates, objects, arrays, props, and function parameters**.

The same `...` syntax is used for two related but different purposes:

```text
... → Spread → expands/unpacks values
... → Rest   → collects values
```

---

## 1. What is the Spread Operator?

The spread operator `...` takes values from an existing object or array and **expands them into another object or array**.

### Array example

```js
const numbers = [1, 2, 3];

const copy = [...numbers];

console.log(copy);
```

Result:

```text
[1, 2, 3]
```

Think:

```text
numbers
[1, 2, 3]
     ↓
   spread
     ↓
1, 2, 3
```

---

# 2. Why do we need Spread?

One major reason is to create a **new array or object without modifying the original**.

This becomes extremely important in React because **you generally should not directly mutate state**.

Instead of:

```js
const numbers = [1, 2, 3];

numbers.push(4);
```

you can create a new array:

```js
const newNumbers = [...numbers, 4];
```

Now:

```js
numbers;
```

is still:

```text
[1, 2, 3]
```

and:

```js
newNumbers;
```

is:

```text
[1, 2, 3, 4]
```

---

# 3. Copying an Array

```js
const users = ["Yash", "Rahul", "Amit"];

const copiedUsers = [...users];
```

Now `copiedUsers` is a new array.

This is important because:

```js
users === copiedUsers
```

is:

```text
false
```

They contain the same values but are different array references.

---

# 4. Adding values to an array

Suppose:

```js
const users = ["Yash", "Rahul"];
```

Add a user:

```js
const updatedUsers = [...users, "Amit"];
```

Result:

```text
["Yash", "Rahul", "Amit"]
```

Add at the beginning:

```js
const updatedUsers = ["Amit", ...users];
```

Result:

```text
["Amit", "Yash", "Rahul"]
```

---

# 5. Combining arrays

```js
const frontend = ["React", "JavaScript"];
const backend = ["Java", "Spring Boot"];

const skills = [...frontend, ...backend];
```

Result:

```text
[
  "React",
  "JavaScript",
  "Java",
  "Spring Boot"
]
```

This is cleaner than manually adding every value.

---

# 6. Spread with Objects

This is where you'll use it **a lot in React**.

```js
const user = {
  name: "Yash",
  age: 21
};

const copiedUser = {
  ...user
};
```

Result:

```js
{
  name: "Yash",
  age: 21
}
```

You can add properties:

```js
const updatedUser = {
  ...user,
  role: "Developer"
};
```

Result:

```js
{
  name: "Yash",
  age: 21,
  role: "Developer"
}
```

---

# 7. Updating an Object

Suppose:

```js
const user = {
  name: "Yash",
  age: 21,
  city: "Pune"
};
```

You want to change the city.

Instead of modifying the original:

```js
user.city = "Mumbai";
```

you can create a new object:

```js
const updatedUser = {
  ...user,
  city: "Mumbai"
};
```

Result:

```js
{
  name: "Yash",
  age: 21,
  city: "Mumbai"
}
```

This pattern is **fundamental to React state management**.

---

# 8. Property Overriding

This is extremely important.

Consider:

```js
const user = {
  name: "Yash",
  age: 21
};

const updatedUser = {
  ...user,
  age: 22
};
```

What happens?

The later property wins.

```text
...user
 ↓
age: 21

age: 22
 ↓
overwrites previous age
```

Therefore:

```js
updatedUser.age;
```

is:

```text
22
```

---

# 9. Order Matters

Compare:

```js
const updatedUser = {
  ...user,
  age: 22
};
```

with:

```js
const updatedUser = {
  age: 22,
  ...user
};
```

The first gives:

```text
age → 22
```

The second can give:

```text
age → 21
```

because `...user` comes later.

### Rule

> **When spreading objects, later properties override earlier properties.**

---

# 10. The Most Important React Example — Updating State

Suppose you have:

```jsx
const [user, setUser] = useState({
  name: "Yash",
  age: 21,
  city: "Pune"
});
```

You want to change only the city.

Use:

```jsx
setUser({
  ...user,
  city: "Mumbai"
});
```

What happens?

```text
Previous state

{
  name: "Yash",
  age: 21,
  city: "Pune"
}

        ↓

...user

        ↓

{
  name: "Yash",
  age: 21,
  city: "Pune"
}

        ↓

city: "Mumbai"

        ↓

New state

{
  name: "Yash",
  age: 21,
  city: "Mumbai"
}
```

You didn't have to manually recreate every property.

---

# 11. Why is this important in React?

React state should generally be treated as **immutable**.

Avoid:

```jsx
user.city = "Mumbai";
```

Instead:

```jsx
setUser({
  ...user,
  city: "Mumbai"
});
```

You're creating a **new object reference**.

This makes state changes predictable and works properly with React's rendering model.

---

# 12. Updating Arrays in React

Suppose:

```jsx
const [skills, setSkills] = useState([
  "Java",
  "React"
]);
```

Add a skill:

```jsx
setSkills([
  ...skills,
  "Spring Boot"
]);
```

Result:

```text
["Java", "React", "Spring Boot"]
```

You're creating a new array rather than modifying the existing state array.

---

# 13. Removing items

Suppose:

```js
const users = [
  { id: 1, name: "Yash" },
  { id: 2, name: "Rahul" },
  { id: 3, name: "Amit" }
];
```

Remove user `2`:

```js
const updatedUsers = users.filter(
  user => user.id !== 2
);
```

Notice that you don't need spread here because `filter()` already returns a new array.

This is a useful distinction:

```text
Add item
→ [...array, newItem]

Remove item
→ array.filter(...)

Transform item
→ array.map(...)
```

You'll use this pattern constantly in React.

---

# 14. Spread with Props

Suppose:

```jsx
const user = {
  name: "Yash",
  age: 21,
  role: "Developer"
};
```

You can pass the properties individually:

```jsx
<UserCard
  name={user.name}
  age={user.age}
  role={user.role}
/>
```

Or use object spread:

```jsx
<UserCard {...user} />
```

React effectively receives:

```jsx
<UserCard
  name="Yash"
  age={21}
  role="Developer"
/>
```

This is useful when an object already contains the props you want to pass.

---

# 15. But don't overuse prop spreading

This:

```jsx
<UserCard {...user} />
```

can be convenient.

But if you have:

```js
const user = {
  id: 101,
  name: "Yash",
  password: "secret",
  internalFlag: true
};
```

blindly doing:

```jsx
<UserCard {...user} />
```

could pass unnecessary data.

Sometimes explicit props are clearer:

```jsx
<UserCard
  name={user.name}
  id={user.id}
/>
```

### Practical rule

> Use spread when it improves clarity, not simply because it saves typing.

---

# 16. What is the Rest Operator?

Now the same `...` syntax has another job.

**Rest collects multiple values into a single variable.**

Example:

```js
const numbers = [1, 2, 3, 4];

const [first, ...remaining] = numbers;
```

Result:

```text
first
→ 1

remaining
→ [2, 3, 4]
```

Here `...remaining` is **rest**, not spread.

---

# 17. Spread vs Rest

This is extremely important.

### Spread

```js
const numbers = [1, 2, 3];

const newNumbers = [...numbers];
```

**Expands** values.

```text
[1, 2, 3]
 ↓
1, 2, 3
```

### Rest

```js
const [first, ...remaining] = numbers;
```

**Collects** values.

```text
1, 2, 3
 ↓
first = 1
remaining = [2, 3]
```

### Remember

> **Spread = unpack**
>
> **Rest = collect**

The syntax is the same; the **context determines what it means**.

---

# 18. Rest in Function Parameters

You can collect function arguments:

```js
function sum(...numbers) {
  console.log(numbers);
}

sum(10, 20, 30);
```

Inside the function:

```text
numbers
→ [10, 20, 30]
```

You can then:

```js
function sum(...numbers) {
  return numbers.reduce(
    (total, number) => total + number,
    0
  );
}
```

---

# 19. Rest with React Props

This is another practical React pattern.

Suppose:

```jsx
function Button({ children, ...props }) {
  return (
    <button {...props}>
      {children}
    </button>
  );
}
```

Now:

```jsx
<Button
  className="primary"
  disabled={false}
  onClick={handleClick}
>
  Save
</Button>
```

The destructuring:

```js
{ children, ...props }
```

means:

```text
children
→ "Save"

props
→ {
    className: "primary",
    disabled: false,
    onClick: handleClick
  }
```

Then:

```jsx
<button {...props}>
```

passes those remaining properties to the actual button.

This pattern is very common in reusable React components.

---

# 20. Shallow Copy — Important Concept

Spread creates a **shallow copy**.

Consider:

```js
const user = {
  name: "Yash",
  address: {
    city: "Pune"
  }
};

const copy = {
  ...user
};
```

The outer object is copied, but the nested `address` object is still referenced.

Conceptually:

```text
user
 ├── name
 └── address ─────┐
                  │
copy              │
 ├── name         │
 └── address ─────┘
```

So:

```js
copy.address === user.address
```

is:

```text
true
```

This becomes important when working with nested React state.

---

# 21. Updating Nested State

Suppose:

```jsx
const [user, setUser] = useState({
  name: "Yash",
  address: {
    city: "Pune",
    country: "India"
  }
});
```

To update only the city:

```jsx
setUser({
  ...user,
  address: {
    ...user.address,
    city: "Mumbai"
  }
});
```

Notice that we spread **both levels**.

```text
user
 ↓
spread user
 ↓
address
 ↓
spread address
 ↓
change city
```

This is a pattern you'll need when building real React forms and applications.

---

# 22. Common mistakes

### Mistake 1 — Mutating state

Avoid:

```js
user.name = "Rahul";
```

Prefer:

```js
setUser({
  ...user,
  name: "Rahul"
});
```

---

### Mistake 2 — Putting the override before the spread

Potentially wrong:

```js
{
  name: "Rahul",
  ...user
}
```

If `user.name` is `"Yash"`, the final value will be `"Yash"`.

Usually you want:

```js
{
  ...user,
  name: "Rahul"
}
```

---

### Mistake 3 — Thinking spread performs a deep copy

It doesn't.

```js
const copy = { ...user };
```

is a **shallow copy**.

---

### Mistake 4 — Confusing spread and rest

```js
const newArray = [...array];
```

→ Spread

```js
const [first, ...rest] = array;
```

→ Rest

---

# 23. When will I use this in React?

You'll see spread/rest in:

```text
State updates
     ↓
Form handling
     ↓
Adding/removing array items
     ↓
Updating objects
     ↓
Updating nested state
     ↓
Passing props
     ↓
Reusable components
     ↓
Component wrappers
     ↓
API data manipulation
```

A realistic example:

```jsx
function UserForm() {
  const [user, setUser] = useState({
    name: "",
    email: "",
    city: ""
  });

  function handleNameChange(event) {
    setUser({
      ...user,
      name: event.target.value
    });
  }

  return (
    <input
      value={user.name}
      onChange={handleNameChange}
    />
  );
}
```

This is exactly the kind of code you should recognize when working on a real React project.

---

# 24. Interview Questions

### Q1. What is the spread operator?

It expands elements of an iterable or properties of an object into another structure.

### Q2. What is the rest operator?

It collects remaining values into an array or object.

### Q3. What's the difference?

```text
Spread → expands
Rest   → collects
```

### Q4. Why is spread commonly used with React state?

It allows us to create a new object/array while preserving existing values rather than directly mutating the state.

### Q5. Does spread create a deep copy?

No. It creates a **shallow copy**.

### Q6. What happens here?

```js
const updated = {
  ...user,
  age: 25
};
```

Existing properties are copied from `user`, and `age` is overwritten with `25`.

### Q7. What does this mean?

```jsx
function Button({ children, ...props }) {}
```

`children` is extracted separately, while all remaining props are collected into `props`.

---

# 25. Practice

Create `practice.js` and solve these without looking at the answers:

```js
// 1. Copy an array using spread.

// 2. Add an item to an existing array without mutating it.

// 3. Combine two arrays.

// 4. Copy an object.

// 5. Update one property of an object.

// 6. Explain why the order of spread matters.

// 7. Remove an item from an array.

// 8. Create a function using rest parameters.

// 9. Create a React state object and update one property
//    using spread.

// 10. Update a nested object using spread.

// 11. Create a Button component using:
//     { children, ...props }

// 12. Explain the difference between:
//     [...users]
//     and
//     [...users, newUser]
```

---

# Quick Revision

```text
                 ...
                  │
          ┌───────┴───────┐
          │               │
       SPREAD            REST
          │               │
       Expand           Collect
          │               │
   [...users]       [...remaining]
          │               │
   Copy / combine     Function args
   State updates      Destructuring
   Props              Remaining props
```

### The most important React pattern

Remember this:

```jsx
setUser({
  ...user,
  name: "Rahul"
});
```

It means:

> **Take the existing user object, create a new object containing all its properties, and replace only `name`.**

And for arrays:

```jsx
setUsers([
  ...users,
  newUser
]);
```

means:

> **Create a new array containing all existing users plus the new user.**

**Next: `06-template-literals.md`** — smaller topic, but useful for strings, dynamic messages, URLs, API endpoints, and JSX-related JavaScript.
