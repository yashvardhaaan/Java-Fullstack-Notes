# 10 — Nullish Coalescing Operator `??`

The **nullish coalescing operator** is used when you want to provide a **fallback value only when something is `null` or `undefined`**.

This is especially useful in React when dealing with:

* API responses
* optional props
* missing database fields
* user profile data
* default UI values
* configuration values

The core idea is:

> **`??` means: "Use the left value if it exists; otherwise use the fallback."**

---

## 1. The basic problem

Suppose:

```js
const username = null;
```

You want a default:

```js
const name = username ?? "Guest";

console.log(name);
```

Result:

```text
Guest
```

Because `username` is `null`.

---

## 2. Basic syntax

```js
const result = value ?? fallback;
```

Think:

```text
value
  ↓
Is it null or undefined?
  │
  ├── No → use value
  │
  └── Yes → use fallback
```

Example:

```js
const name = null;

const displayName = name ?? "Guest";
```

Result:

```text
Guest
```

---

# 3. When the value exists

```js
const name = "Yash";

const displayName = name ?? "Guest";

console.log(displayName);
```

Result:

```text
Yash
```

The fallback is ignored because `name` already contains a value.

---

# 4. `null` vs `undefined`

Both trigger the fallback.

```js
const a = null;
const b = undefined;

console.log(a ?? "Default");
console.log(b ?? "Default");
```

Result:

```text
Default
Default
```

So:

```text
null       → fallback
undefined  → fallback
```

---

# 5. The important difference from `||`

This is the most important part of this topic.

You may already know:

```js
const value = something || "Default";
```

But `||` treats **all falsy values** as false.

Falsy values include:

```text
false
0
""
null
undefined
NaN
```

`??` only treats these two as missing:

```text
null
undefined
```

---

# 6. Example with `0`

Consider:

```js
const age = 0;

const result = age || 18;
```

Result:

```text
18
```

That's because `0` is falsy.

But:

```js
const result = age ?? 18;
```

Result:

```text
0
```

This is often what you actually want.

### Why?

Because `0` is a legitimate value.

---

# 7. Example with empty string

Consider:

```js
const username = "";

const result = username || "Guest";
```

Result:

```text
Guest
```

But:

```js
const result = username ?? "Guest";
```

Result:

```text
""
```

Because an empty string is **not nullish**.

---

# 8. Example with `false`

```js
const isAvailable = false;

const result = isAvailable ?? true;
```

Result:

```text
false
```

That's correct because `false` is an actual value.

Using:

```js
const result = isAvailable || true;
```

would incorrectly produce:

```text
true
```

This is one reason `??` is useful for boolean configuration values.

---

# 9. Quick comparison

| Value | `value || "Default"` | `value ?? "Default"` |
|---|---|---|
| `null` | `"Default"` | `"Default"` |
| `undefined` | `"Default"` | `"Default"` |
| `0` | `"Default"` | `0` |
| `""` | `"Default"` | `""` |
| `false` | `"Default"` | `false` |
| `"Yash"` | `"Yash"` | `"Yash"` |

### Remember

```text
|| → checks truthiness

?? → checks null/undefined
```

---

# 10. Why is `??` useful in React?

Suppose your backend returns:

```js
const user = {
  name: "Yash",
  bio: null
};
```

You want to display a default bio:

```jsx
<p>{user.bio ?? "No bio available"}</p>
```

Result:

```text
No bio available
```

If the backend returns:

```js
bio: "Java developer"
```

then:

```jsx
<p>{user.bio ?? "No bio available"}</p>
```

displays:

```text
Java developer
```

---

# 11. Combining `?.` and `??`

This is one of the most useful React patterns.

Suppose:

```js
const user = null;
```

You can write:

```js
const name = user?.name ?? "Guest";
```

Break it down:

```text
user?.name
     ↓
Safely access name
     ↓
undefined
     ↓
??
     ↓
"Guest"
```

So:

```js
user?.name ?? "Guest"
```

means:

> Safely get `user.name`; if it's `null` or `undefined`, use `"Guest"`.

---

# 12. Real React example

```jsx
function Profile({ user }) {
  return (
    <div>
      <h2>{user?.name ?? "Guest"}</h2>

      <p>
        {user?.bio ?? "No bio available"}
      </p>

      <p>
        {user?.address?.city ?? "Location unavailable"}
      </p>
    </div>
  );
}
```

This handles missing data gracefully.

---

# 13. API response example

Imagine your Spring Boot backend returns:

```json
{
  "name": "Yash",
  "email": "yash@example.com",
  "phone": null,
  "profile": {
    "bio": null
  }
}
```

React:

```jsx
function UserProfile({ user }) {
  return (
    <div>
      <p>Name: {user?.name ?? "Unknown"}</p>

      <p>Email: {user?.email ?? "No email"}</p>

      <p>Phone: {user?.phone ?? "No phone number"}</p>

      <p>
        Bio: {user?.profile?.bio ?? "No bio"}
      </p>
    </div>
  );
}
```

This is a very realistic use case when your frontend consumes backend APIs.

---

# 14. Default values in configuration

Suppose:

```js
const config = {
  pageSize: null
};
```

You want:

```js
const pageSize = config.pageSize ?? 10;
```

Result:

```text
10
```

But if:

```js
const config = {
  pageSize: 20
};
```

then:

```js
const pageSize = config.pageSize ?? 10;
```

gives:

```text
20
```

---

# 15. Important difference: `??` does not return the fallback for `0`

This is a practical example.

Suppose an e-commerce cart has:

```js
const cartItems = 0;
```

You might write:

```js
const count = cartItems ?? 1;
```

Result:

```text
0
```

That's correct.

There are zero items.

Using:

```js
const count = cartItems || 1;
```

would produce:

```text
1
```

which is logically wrong.

---

# 16. Practical example — Product price

Suppose:

```js
const product = {
  price: 0
};
```

Maybe `0` means "Free."

Using:

```js
const price = product.price ?? 100;
```

gives:

```text
0
```

Correct.

Using:

```js
const price = product.price || 100;
```

would give:

```text
100
```

which changes the meaning of the data.

---

# 17. `??` vs ternary operator

You could write:

```js
const name =
  user.name !== null && user.name !== undefined
    ? user.name
    : "Guest";
```

That's unnecessarily verbose.

Instead:

```js
const name = user.name ?? "Guest";
```

Much clearer.

---

# 18. Chaining multiple fallbacks

You can chain `??`.

```js
const displayName =
  user?.nickname ??
  user?.name ??
  "Guest";
```

The logic is:

```text
nickname exists?
     ↓ no
name exists?
     ↓ no
"Guest"
```

Example:

```js
const user = {
  name: "Yash"
};
```

Result:

```text
Yash
```

If both are missing:

```text
Guest
```

This can be useful when dealing with different possible sources of data.

---

# 19. Important syntax restriction

You should be aware of this JavaScript rule:

Don't mix `??` directly with `||` or `&&` without parentheses.

Avoid:

```js
const result = a ?? b || c;
```

Instead use explicit grouping:

```js
const result = (a ?? b) || c;
```

or:

```js
const result = a ?? (b || c);
```

The parentheses make your intention clear.

---

# 20. Common mistake — confusing `??` and `||`

Suppose:

```js
const quantity = 0;
```

If `0` is valid:

```js
const value = quantity ?? 1;
```

Correct:

```text
0
```

But:

```js
const value = quantity || 1;
```

gives:

```text
1
```

### Practical rule

Ask yourself:

> **Do I want a fallback only when the value is missing?**

If yes:

```js
??
```

If you genuinely want a fallback for **any falsy value**, then:

```js
||
```

may be appropriate.

---

# 21. When should I use `??`?

Common React situations:

```text
API response
     ↓
Missing database fields
     ↓
Optional props
     ↓
User profile information
     ↓
Configuration
     ↓
Counts
     ↓
Prices
     ↓
Boolean settings
     ↓
Fallback UI values
```

---

# 22. When should I NOT use it?

Don't automatically replace every `||` with `??`.

For example:

```js
const username = "";

const displayName =
  username || "Guest";
```

Maybe you actually **want** an empty username to be treated as missing.

In that case `||` is appropriate.

The choice depends on the meaning of the data.

---

# 23. Real-world React example

Imagine an e-commerce product:

```js
const product = {
  name: "Laptop",
  price: 65000,
  discount: null,
  stock: 0
};
```

React:

```jsx
function ProductCard({ product }) {
  const discount = product?.discount ?? 0;

  return (
    <div>
      <h2>{product?.name ?? "Unknown Product"}</h2>

      <p>Price: ₹{product?.price ?? 0}</p>

      <p>Discount: ₹{discount}</p>

      <p>
        Stock: {product?.stock ?? 0}
      </p>
    </div>
  );
}
```

Notice:

```js
product?.stock ?? 0
```

If stock is actually `0`, it stays `0`.

That's exactly what we want.

---

# 24. Interview Questions

### Q1. What is the nullish coalescing operator?

`??` provides a fallback value when the left-hand value is `null` or `undefined`.

### Q2. Difference between `??` and `||`?

```text
?? → null / undefined

|| → any falsy value
```

### Q3. What does this return?

```js
0 ?? 10
```

Answer:

```text
0
```

### Q4. What does this return?

```js
0 || 10
```

Answer:

```text
10
```

### Q5. Why is `??` useful in React?

It lets you provide sensible fallback values without incorrectly replacing valid values such as `0`, `false`, or `""`.

### Q6. What does this mean?

```js
user?.name ?? "Guest"
```

Answer:

> Safely access `user.name`; if the result is `null` or `undefined`, use `"Guest"`.

---

# 25. Practice

Create `practice.js`:

```js
// 1. Create a variable containing null
//    and provide a default value.

// 2. Create an undefined variable
//    and provide a default value.

// 3. Test 0 with ??.

// 4. Test 0 with ||.

// 5. Test "" with ??.

// 6. Test "" with ||.

// 7. Test false with ??.

// 8. Test false with ||.

// 9. Create a React component that displays
//    "Guest" when user.name is missing.

// 10. Safely display a user's city
//     with "Unknown location" as fallback.

// 11. Create an e-commerce example where
//     stock = 0 must remain 0.

// 12. Combine ?. and ??.

// 13. Explain why ?? is better than ||
//     when 0 is a valid value.
```

---

# Quick Revision

```text
NULLISH COALESCING
        │
        └── ??
             │
             ├── null       → fallback
             ├── undefined  → fallback
             │
             ├── 0          → keep 0
             ├── false      → keep false
             └── ""         → keep ""
```

### The pattern you should remember

```jsx
{user?.name ?? "Guest"}
```

Break it down:

```text
?. 
↓
Safely access the value

??

↓
Use fallback if null/undefined
```

So:

> **`?.` protects you from missing data. `??` gives you a sensible default when that data is missing.**

These two operators together are extremely common when building React applications that consume REST APIs.

**Next: `11-modules-import-export.md`** — this is where you'll understand how React applications split components, utilities, services, hooks, and other code into separate files.
