# 05 — Route Parameters

## WHY?

Sometimes a route needs to display **different data depending on a value in the URL**.

For example, an e-commerce application may have:

```text id="g1c6d4"
/products/101
/products/102
/products/103
```

We don't want to create three separate routes:

```jsx
<Route path="/products/101" ... />
<Route path="/products/102" ... />
<Route path="/products/103" ... />
```

Instead, we create **one dynamic route**:

```jsx
<Route
  path="/products/:id"
  element={<ProductDetails />}
/>
```

Now `:id` can represent different values.

---

# WHAT?

A **route parameter** is a dynamic value included in the URL path.

Example:

```jsx
<Route
  path="/products/:id"
  element={<ProductDetails />}
/>
```

Here:

```text id="l5l0zv"
:id
```

is a route parameter.

These URLs can all match:

```text id="6xx8g2"
/products/101
/products/102
/products/500
```

The value can then be accessed inside the component.

---

# Route Parameter Structure

Think:

```text id="8n1tjp"
/products/:id
         ↑
      parameter
```

For:

```text id="0z0o9s"
/products/101
```

we get:

```text id="9y8qv4"
id = 101
```

For:

```text id="xgqf9h"
/products/500
```

we get:

```text id = 500
```

---

# WHERE?

Route parameters are useful whenever a URL identifies a **specific resource**.

### E-commerce

```text id="oz9j5s"
/products/101
```

### User profile

```text id="p3m8t7"
/users/25
```

### Blog

```text id="w5r8x2"
/posts/hello-react
```

### Orders

```text id="4x8m9v"
/orders/5001
```

### Courses

```text id="l1j5km"
/courses/react
```

---

# HOW?

## Step 1 — Create a Dynamic Route

```jsx
import { Routes, Route } from "react-router-dom";

<Routes>
  <Route
    path="/products/:id"
    element={<ProductDetails />}
  />
</Routes>
```

The important part is:

```jsx
:id
```

---

# Step 2 — Access the Parameter

React Router provides the `useParams()` hook.

```jsx
import { useParams } from "react-router-dom";

function ProductDetails() {
  const params = useParams();

  console.log(params);

  return <h1>Product Details</h1>;
}
```

If the URL is:

```text id="zj4l1s"
/products/101
```

then:

```jsx
params
```

will contain:

```js
{
  id: "101"
}
```

Notice something important:

> **Route parameters are strings.**

Even if the URL contains:

```text
101
```

you receive:

```js
"101"
```

not:

```js
101
```

If you need a number:

```jsx
const id = Number(params.id);
```

---

# Practical Example

### Route

```jsx
<Route
  path="/products/:id"
  element={<ProductDetails />}
/>
```

### Component

```jsx
import { useParams } from "react-router-dom";

function ProductDetails() {
  const { id } = useParams();

  return (
    <div>
      <h1>Product Details</h1>
      <p>Product ID: {id}</p>
    </div>
  );
}
```

If the URL is:

```text id="2w3z0b"
/products/101
```

the UI shows:

```text id="r7j7k1"
Product Details
Product ID: 101
```

---

# Route Parameter + API

This is where route parameters become extremely useful.

Suppose:

```text id="5k2qce"
/products/101
```

We get:

```jsx
const { id } = useParams();
```

Then use that ID to fetch the product:

```jsx
useEffect(() => {
  async function loadProduct() {
    const response = await fetch(`/api/products/${id}`);

    if (!response.ok) {
      throw new Error("Failed to fetch product");
    }

    const data = await response.json();

    setProduct(data);
  }

  loadProduct();
}, [id]);
```

The complete flow:

```text id="7w4s1h"
/products/101
      ↓
useParams()
      ↓
id = "101"
      ↓
GET /api/products/101
      ↓
Backend
      ↓
Product data
      ↓
UI
```

---

# Why Include `id` in `useEffect` Dependencies?

Suppose the user navigates:

```text id="m1b1yq"
/products/101
```

to:

```text id="k6m0i3"
/products/102
```

The same component may remain mounted while the parameter changes.

Therefore:

```jsx
useEffect(() => {
  loadProduct();
}, [id]);
```

means:

> Run the effect again whenever the product ID changes.

This is an important practical detail.

---

# Multiple Route Parameters

You can have more than one parameter.

Example:

```jsx
<Route
  path="/users/:userId/posts/:postId"
  element={<Post />}
/>
```

URL:

```text id="m4f5e7"
/users/25/posts/100
```

Then:

```jsx
const { userId, postId } = useParams();
```

gives:

```js
{
  userId: "25",
  postId: "100"
}
```

---

# Another Example

```jsx
<Route
  path="/courses/:courseId/lessons/:lessonId"
  element={<Lesson />}
/>
```

URL:

```text id="0pk6i6"
/courses/react/lessons/5
```

Parameters:

```js
{
  courseId: "react",
  lessonId: "5"
}
```

---

# Parameter Names Matter

Consider:

```jsx
<Route
  path="/users/:userId"
  element={<User />}
/>
```

Then:

```jsx
const { userId } = useParams();
```

Correct.

If you instead write:

```jsx
const { id } = useParams();
```

you won't get the value because the parameter is named:

```text
:userId
```

not:

```text
:id
```

So:

```text id="8m2l7x"
Route:
:userId

        ↓

useParams():
userId
```

---

# Route Parameter vs Query Parameter

This is **very important**.

## Route Parameter

```text id="q9y7tg"
/products/101
```

Route:

```jsx
<Route
  path="/products/:id"
  element={<Product />}
/>
```

Access:

```jsx
const { id } = useParams();
```

Used when the value is part of identifying the resource.

---

## Query Parameter

```text id="v4d5q9"
/products?category=laptop
```

Route:

```jsx
<Route
  path="/products"
  element={<Products />}
/>
```

The query string is handled separately.

We'll cover query parameters in the **next topic**.

---

# Route Parameter vs Query Parameter

| Route Parameter           | Query Parameter                  |
| ------------------------- | -------------------------------- |
| `/products/101`           | `/products?id=101`               |
| Part of path              | After `?`                        |
| Often identifies resource | Often filters/configures request |
| `useParams()`             | `useSearchParams()`              |
| `/users/:id`              | `/users?role=admin`              |

Example:

```text id="z8e0st"
/products/101?color=black
     ↑             ↑
 route param    query param
```

---

# Navigation with Route Parameters

Suppose we have a product list:

```jsx
import { Link } from "react-router-dom";

function ProductList({ products }) {
  return (
    <div>
      {products.map(product => (
        <Link
          key={product.id}
          to={`/products/${product.id}`}
        >
          {product.name}
        </Link>
      ))}
    </div>
  );
}
```

If:

```js
product.id = 101
```

the generated URL is:

```text id="j8x2ck"
/products/101
```

If:

```js
product.id = 102
```

the URL becomes:

```text id="8xw5hz"
/products/102
```

One route handles all of them:

```jsx
<Route
  path="/products/:id"
  element={<ProductDetails />}
/>
```

---

# Full Product Example

## `App.jsx`

```jsx
import {
  BrowserRouter,
  Routes,
  Route
} from "react-router-dom";

function ProductDetails() {
  const { id } = useParams();

  return <h1>Product {id}</h1>;
}

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route
          path="/products/:id"
          element={<ProductDetails />}
        />
      </Routes>
    </BrowserRouter>
  );
}
```

A cleaner version would import `useParams`:

```jsx
import {
  BrowserRouter,
  Routes,
  Route,
  useParams
} from "react-router-dom";
```

Then:

```text id="j6s3b2"
/products/10
       ↓
id = "10"

Products/20
       ↓
id = "20"
```

---

# Optional Parameters

Modern React Router also supports route patterns with optional segments in appropriate configurations.

For example, optional route parameters can be represented using:

```text
:id?
```

However, don't use optional parameters just because you can.

For many applications, explicitly defining routes is clearer:

```jsx
<Route path="/products" ... />
<Route path="/products/:id" ... />
```

Choose the route structure that best represents your application's URLs.

---

# ⚠️ Common Mistakes

## 1. Forgetting `useParams`

This:

```jsx
function Product() {
  return <h1>Product</h1>;
}
```

doesn't automatically give you the URL parameter.

Use:

```jsx
const { id } = useParams();
```

---

## 2. Expecting a number

If URL is:

```text id="r0k6lm"
/products/101
```

then:

```jsx
const { id } = useParams();
```

gives:

```js
"101"
```

not:

```js
101
```

Convert when needed:

```jsx
const productId = Number(id);
```

---

## 3. Wrong parameter name

Route:

```jsx
<Route path="/users/:userId" ... />
```

Correct:

```jsx
const { userId } = useParams();
```

Not:

```jsx
const { id } = useParams();
```

---

## 4. Forgetting the dependency

If the component can remain mounted while the parameter changes:

```jsx
useEffect(() => {
  loadProduct();
}, [id]);
```

is important.

---

## 5. Putting everything into route parameters

Don't turn every piece of filtering into:

```text id="3w5q8p"
/products/laptop/black/16gb/cheap
```

Sometimes query parameters are more appropriate:

```text id="v7r2zz"
/products?category=laptop&color=black&ram=16gb
```

---

# WHEN?

Use route parameters when the URL needs to identify a **specific resource or dynamic route**.

Examples:

```text id="4g3g1f"
/users/25
```

```text id="w4z5j2"
/products/101
```

```text id="7p3y5k"
/posts/my-first-react-post
```

```text id="x4z8q0"
/orders/5001
```

---

# ⭐ Real-World Flow

Consider Amazon-like product navigation:

```text id="u4u9f3"
Product List
     ↓
Click iPhone
     ↓
/products/101
     ↓
Route matches
     ↓
useParams()
     ↓
id = "101"
     ↓
GET /api/products/101
     ↓
Product data
     ↓
Product Details UI
```

This is one of the most common uses of route parameters in real React applications.

---

# ⭐ Interview Questions

### Q1. What is a route parameter?

**Answer:**

A route parameter is a dynamic value embedded in a URL path that allows one route to handle different resource identifiers.

Example:

```jsx
<Route
  path="/users/:id"
  element={<User />}
/>
```

---

### Q2. How do you access route parameters?

Using `useParams()`:

```jsx
const { id } = useParams();
```

---

### Q3. What does `useParams()` return?

It returns an object containing the values of the dynamic route parameters.

For:

```text
/users/25
```

with:

```jsx
path="/users/:id"
```

you get:

```js
{
  id: "25"
}
```

---

### Q4. Are route parameters strings or numbers?

They are received as strings.

```js
"25"
```

Convert them if your application requires a number:

```js
Number(id)
```

---

### Q5. Why put `id` in the `useEffect` dependency array?

Because when the route parameter changes, the component may need to fetch data for the new resource.

```jsx
useEffect(() => {
  loadUser();
}, [id]);
```

---

### Q6. Route parameter vs query parameter?

Route parameter:

```text
/products/101
```

Query parameter:

```text
/products?category=laptop
```

Route parameters are part of the route path; query parameters are part of the URL's query string.

---

### Q7. Can a route have multiple parameters?

Yes:

```jsx
<Route
  path="/users/:userId/posts/:postId"
  element={<Post />}
/>
```

Then:

```jsx
const { userId, postId } = useParams();
```

---

# ⭐ Remember

The key syntax:

```jsx
<Route
  path="/products/:id"
  element={<Product />}
/>
```

Then:

```jsx
const { id } = useParams();
```

Think:

```text id="d7tqg6"
/products/101
      ↓
     :id
      ↓
useParams()
      ↓
id = "101"
      ↓
GET /api/products/101
```

### One-line interview answer:

> **Route parameters are dynamic values embedded in a URL path, such as `/products/:id`, which can be accessed using `useParams()` to identify and fetch a specific resource.**
