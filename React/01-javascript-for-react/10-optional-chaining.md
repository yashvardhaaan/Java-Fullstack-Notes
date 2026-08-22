# 09 — Optional Chaining `?.`

Optional chaining is a **very practical JavaScript feature for React**, especially when you're working with **API data, nested objects, authentication data, and data that hasn't loaded yet**.

The core problem it solves is:

> **How do I safely access a property when some part of the object might be `null` or `undefined`?**

---

## 1. The problem

Suppose your React application receives this data:

```js
const user = {
  name: "Yash",
  address: {
    city: "Pune"
  }
};
```

You can access:

```js
console.log(user.address.city);
```

But what if the API hasn't returned the address yet?

```js
const user = {
  name: "Yash",
  address: null
};
```

Then:

```js
user.address.city;
```

causes an error.

Something like:

```text
Cannot read properties of null
```

This can break your application.

---

# 2. Optional chaining solves this

Instead of:

```js
user.address.city
```

write:

```js
user.address?.city
```

If `address` exists:

```js
user.address?.city
```

returns:

```text
Pune
```

If `address` is `null` or `undefined`:

```js
user.address?.city
```

returns:

```text
undefined
```

instead of throwing an error.

---

# 3. Basic syntax

```js
object?.property
```

Example:

```js
user?.name
```

For nested objects:

```js
user?.address?.city
```

Think:

```text
user
 ↓
Does it exist?
 ↓
address
 ↓
Does it exist?
 ↓
city
 ↓
Return value
```

If something in the chain is `null` or `undefined`, JavaScript stops safely.

---

# 4. Why is this important in React?

React applications frequently deal with **data that arrives asynchronously**.

For example:

```jsx
function Profile({ user }) {
  return (
    <h2>{user.name}</h2>
  );
}
```

What happens if `user` is initially `null`?

Your application can crash.

Instead:

```jsx
function Profile({ user }) {
  return (
    <h2>{user?.name}</h2>
  );
}
```

Now:

```text
user = null
     ↓
user?.name
     ↓
undefined
```

React can continue rendering.

---

# 5. API example

Imagine your Spring Boot backend eventually returns:

```json
{
  "id": 101,
  "name": "Yash",
  "profile": {
    "city": "Pune"
  }
}
```

But initially:

```js
const user = null;
```

You could safely write:

```jsx
<p>{user?.profile?.city}</p>
```

When the data isn't available:

```text
undefined
```

When it arrives:

```text
Pune
```

This is a very common pattern when building React frontends that consume REST APIs.

---

# 6. Multiple levels

Consider:

```js
const response = {
  data: {
    user: {
      profile: {
        address: {
          city: "Pune"
        }
      }
    }
  }
};
```

Without optional chaining:

```js
response.data.user.profile.address.city;
```

If any intermediate property doesn't exist, you'll get an error.

With optional chaining:

```js
response?.data?.user?.profile?.address?.city;
```

Much safer.

---

# 7. Optional chaining with arrays

You can also safely access an array element.

```js
const users = [
  { name: "Yash" }
];

console.log(users?.[0]?.name);
```

Result:

```text
Yash
```

If the array doesn't exist:

```js
const users = null;

console.log(users?.[0]?.name);
```

Result:

```text
undefined
```

---

# 8. Optional chaining with function calls

You can also safely call a function that might not exist.

```js
const user = {
  greet() {
    console.log("Hello");
  }
};

user.greet?.();
```

If `greet` exists, it executes.

If it doesn't exist:

```js
user.greet?.();
```

doesn't throw an error.

This is useful when working with optional callbacks.

---

# 9. React callback example

Suppose a component receives an optional callback:

```jsx
function UserCard({ onDelete }) {
  return (
    <button onClick={() => onDelete?.()}>
      Delete
    </button>
  );
}
```

If the parent provides:

```jsx
<UserCard onDelete={handleDelete} />
```

then it executes.

If the parent doesn't provide `onDelete`, the optional call:

```js
onDelete?.()
```

doesn't crash.

---

# 10. Optional chaining vs normal access

### Normal

```js
user.profile.name;
```

If `profile` is `undefined`:

```text
❌ Error
```

### Optional chaining

```js
user?.profile?.name;
```

If `profile` is `undefined`:

```text
✅ undefined
```

---

# 11. Optional chaining does NOT mean "ignore every error"

This is important.

Consider:

```js
const user = {
  age: "twenty"
};

user?.age.toFixed(2);
```

Optional chaining doesn't magically validate the type of `age`.

The problem here is that `"twenty"` doesn't have the expected numeric behavior.

Optional chaining mainly protects against:

```text
null
undefined
```

It isn't a replacement for proper validation.

---

# 12. Optional chaining + nullish coalescing

This combination is extremely useful.

Suppose:

```js
const user = null;
```

You can safely access:

```js
user?.name
```

but that gives:

```text
undefined
```

If you want a default:

```js
const name = user?.name ?? "Guest";
```

Result:

```text
Guest
```

This introduces the next concept you'll document:

> **Optional chaining → safely access**
>
> **Nullish coalescing → provide a fallback**

---

# 13. React UI example

```jsx
function Profile({ user }) {
  return (
    <div>
      <h2>{user?.name ?? "Guest"}</h2>
      <p>{user?.profile?.city ?? "Location unavailable"}</p>
    </div>
  );
}
```

If the API hasn't loaded:

```text
Guest
Location unavailable
```

If the API returns data:

```text
Yash
Pune
```

This is a very practical React pattern.

---

# 14. Optional chaining with API loading

A typical React application might start with:

```jsx
const [user, setUser] = useState(null);
```

Then later:

```text
Component renders
       ↓
user = null
       ↓
API request
       ↓
API responds
       ↓
setUser(data)
       ↓
user now contains data
       ↓
React re-renders
```

During the first render:

```jsx
user?.name
```

prevents your component from trying to access properties on `null`.

---

# 15. Example with your React + Spring Boot architecture

Imagine your backend returns:

```json
{
  "id": 101,
  "username": "yash",
  "restaurant": {
    "name": "Foodify",
    "address": {
      "city": "Pune"
    }
  }
}
```

React:

```jsx
function UserProfile({ user }) {
  return (
    <div>
      <h2>{user?.username}</h2>

      <p>
        Restaurant: {user?.restaurant?.name}
      </p>

      <p>
        City: {user?.restaurant?.address?.city}
      </p>
    </div>
  );
}
```

This is much safer than assuming every nested property will always exist.

---

# 16. Optional chaining with array methods

Suppose an API may or may not return a list:

```js
const users = undefined;
```

You could use:

```js
users?.map(user => (
  <p key={user.id}>{user.name}</p>
));
```

If `users` is undefined, the expression evaluates safely.

However, in real React applications, another common approach is to initialize the state properly:

```jsx
const [users, setUsers] = useState([]);
```

Then:

```jsx
users.map(...)
```

works without optional chaining.

### Important lesson

Don't automatically add `?.` everywhere.

Prefer a sensible data structure when you control the state.

---

# 17. When should you use it?

Good use cases:

```text
API data
     ↓
Optional nested fields
     ↓
User authentication data
     ↓
Optional props
     ↓
Optional callbacks
     ↓
Data that may initially be null
     ↓
Third-party API responses
```

---

# 18. When should you NOT use it?

Don't use optional chaining to hide a programming error.

For example:

```js
config?.database?.url
```

might silently produce `undefined` when your application actually **requires** that configuration.

In such a situation, failing loudly can be better.

### Practical rule

> Use `?.` when a value is legitimately optional.

Don't use it to avoid understanding why a required value is missing.

---

# 19. Common mistakes

### Mistake 1 — Forgetting the second `?`

Wrong:

```js
user?.address.city
```

This only protects access to `user`.

If `address` is undefined, `.city` can still fail.

Safer:

```js
user?.address?.city
```

---

### Mistake 2 — Thinking it handles every error

It mainly protects against:

```text
null
undefined
```

It doesn't validate whether the value has the correct type.

---

### Mistake 3 — Using it everywhere

This:

```js
user?.name
```

is useful if `user` can genuinely be absent.

But if your code guarantees `user` exists, unnecessary optional chaining can hide bugs.

---

# 20. Interview Questions

### Q1. What is optional chaining?

A JavaScript feature that safely accesses properties, methods, or array elements when an intermediate value may be `null` or `undefined`.

### Q2. What does this return?

```js
const user = null;

user?.name;
```

```text
undefined
```

### Q3. What is the difference?

```js
user.name
```

can throw an error if `user` is null/undefined.

```js
user?.name
```

returns `undefined` instead.

### Q4. Can optional chaining be used with functions?

Yes:

```js
onDelete?.();
```

### Q5. Can it be used with arrays?

Yes:

```js
users?.[0]?.name;
```

### Q6. Does optional chaining provide a default value?

No.

For a default value, combine it with `??`:

```js
user?.name ?? "Guest";
```

---

# 21. Practice

Create `practice.js`:

```js
// 1. Safely access user.name.

// 2. Safely access user.address.city.

// 3. Safely access deeply nested API data.

// 4. Safely access the first element of an array.

// 5. Safely call an optional function.

// 6. Create a React component that receives
//    an optional user.

// 7. Display "Guest" when the user doesn't exist.

// 8. Display "Location unavailable" when
//    the city doesn't exist.

// 9. Create a component with an optional
//    onDelete callback.

// 10. Explain the difference between:
//
//     user?.name
//
//     user?.name ?? "Guest"
```

---

# Quick Revision

```text
OPTIONAL CHAINING
       │
       └── ?.
            │
            ├── object?.property
            │
            ├── object?.nested?.property
            │
            ├── array?.[0]
            │
            └── function?.()
```

### Remember this

```js
user?.profile?.address?.city
```

means:

> "Try to access `city`, but if something before it is `null` or `undefined`, safely return `undefined` instead of throwing an error."

And the practical React combination:

```jsx
<h2>{user?.name ?? "Guest"}</h2>
```

means:

```text
Safely get user.name
        ↓
If null/undefined
        ↓
Use "Guest"
```

**Next: `10-nullish-coalescing.md`** — this will complete the `?.` + `??` pattern you'll frequently use when handling API data and React state.
