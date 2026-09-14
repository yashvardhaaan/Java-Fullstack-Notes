# 03 — Routes

## WHY?

In a React application, different URLs usually need to display different UI.

For example:

```text
/                  → Home
/about             → About
/products          → Products
/contact           → Contact
/login             → Login
```

We need a way to tell React Router:

> **"When the URL matches this path, render this component."**

That's what a **Route** does.

---

# WHAT?

A `Route` defines a relationship between a **URL pattern** and the **UI that should be rendered**.

Basic syntax:

```jsx
<Route
  path="/about"
  element={<About />}
/>
```

It means:

```text
URL: /about
      ↓
Route matches
      ↓
<About /> renders
```

Routes are normally placed inside:

```jsx
<Routes>
  ...
</Routes>
```

and `Routes` must be inside a router such as `BrowserRouter`.

---

# WHERE?

A typical React application might define routes in `App.jsx`:

```jsx
import {
  BrowserRouter,
  Routes,
  Route
} from "react-router-dom";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
        <Route path="/products" element={<Products />} />
      </Routes>
    </BrowserRouter>
  );
}
```

For larger applications, routes can also be organized in a dedicated file:

```text
src/
├── pages/
├── components/
├── routes/
│   └── AppRoutes.jsx
└── App.jsx
```

---

# HOW?

## 1. Basic Route

```jsx
<Route
  path="/"
  element={<Home />}
/>
```

Two important properties:

### `path`

Defines the URL pattern.

```jsx
path="/about"
```

### `element`

Defines what React should render.

```jsx
element={<About />}
```

So:

```text
path
 ↓
WHERE?

element
 ↓
WHAT UI?
```

---

# Multiple Routes

```jsx
<Routes>

  <Route
    path="/"
    element={<Home />}
  />

  <Route
    path="/about"
    element={<About />}
  />

  <Route
    path="/products"
    element={<Products />}
  />

  <Route
    path="/contact"
    element={<Contact />}
  />

</Routes>
```

Result:

```text
URL                  Component
──────────────────────────────────
/                    Home
/about               About
/products            Products
/contact             Contact
```

---

# Route Matching

Suppose the browser URL is:

```text
/products
```

React Router checks the configured routes.

```text
/
 /about
 /products  ← MATCH
 /contact
```

Then:

```jsx
<Route
  path="/products"
  element={<Products />}
/>
```

is rendered.

---

# Exact Matching Is Not Usually Needed

If you've used older React Router versions, you may remember:

```jsx
<Route
  exact
  path="/"
  component={Home}
/>
```

Modern React Router uses a different API.

You typically write:

```jsx
<Route
  path="/"
  element={<Home />}
/>
```

The route matching behavior is handled by the current router.

---

# Route Elements

The `element` prop receives a **React element**:

```jsx
element={<Home />}
```

Not the component function itself:

```jsx
element={Home} // ❌
```

Correct:

```jsx
element={<Home />} // ✅
```

This distinction is commonly asked in interviews.

---

# Route with a Layout

A route doesn't always need to render a normal page directly.

You can also create route hierarchies.

For example:

```jsx
<Route
  path="/dashboard"
  element={<Dashboard />}
/>
```

Later, you can create:

```text
/dashboard
/dashboard/profile
/dashboard/settings
```

using nested routes.

We'll cover this in:

```text
07 — Nested Routes
08 — Layout Routes
```

---

# Dynamic Routes

Routes can contain dynamic values.

Example:

```jsx
<Route
  path="/products/:id"
  element={<Product />}
/>
```

Now:

```text
/products/101
/products/102
/products/500
```

can all match the same route.

Here:

```text
:id
```

is a **route parameter**.

For:

```text
/products/101
```

we get:

```text
id = 101
```

We'll study this in detail in:

**05 — Route Parameters**

---

# Route Parameters vs Normal Routes

### Normal route

```jsx
<Route
  path="/products"
  element={<Products />}
/>
```

Matches:

```text
/products
```

### Dynamic route

```jsx
<Route
  path="/products/:id"
  element={<Product />}
/>
```

Matches:

```text
/products/101
/products/200
/products/999
```

---

# Route with Query Parameters

You don't normally define the query string directly in the route.

For example:

```text
/products?category=laptop
```

The route can simply be:

```jsx
<Route
  path="/products"
  element={<Products />}
/>
```

The query parameter:

```text
?category=laptop
```

is read separately using React Router APIs such as `useSearchParams`.

We'll cover this in:

**06 — Query Parameters**

---

# Catch-All Route

You can create a route that matches paths that haven't matched another route:

```jsx
<Route
  path="*"
  element={<NotFound />}
/>
```

For example:

```text
/random-page
/abc
/does-not-exist
```

could display:

```text
404 — Page Not Found
```

We'll cover this properly in:

**10 — Not Found Route**

---

# Route Navigation Example

Consider:

```jsx
<Routes>
  <Route path="/" element={<Home />} />
  <Route path="/about" element={<About />} />
</Routes>
```

Navigation:

```text
User visits /
     ↓
Home rendered

User navigates to /about
     ↓
About rendered
```

The route itself doesn't necessarily create the navigation control.

Navigation is handled using things such as:

```jsx
<Link />
<NavLink />
useNavigate()
```

We'll study those in **04 — Navigation**.

---

# Complete Example

```jsx
import {
  BrowserRouter,
  Routes,
  Route
} from "react-router-dom";

function Home() {
  return <h1>Home</h1>;
}

function About() {
  return <h1>About</h1>;
}

function Products() {
  return <h1>Products</h1>;
}

function App() {
  return (
    <BrowserRouter>

      <Routes>

        <Route
          path="/"
          element={<Home />}
        />

        <Route
          path="/about"
          element={<About />}
        />

        <Route
          path="/products"
          element={<Products />}
        />

      </Routes>

    </BrowserRouter>
  );
}

export default App;
```

---

# Route Configuration Table

You can think of your routes as a table:

| URL         | Route       | UI             |
| ----------- | ----------- | -------------- |
| `/`         | `/`         | `<Home />`     |
| `/about`    | `/about`    | `<About />`    |
| `/products` | `/products` | `<Products />` |
| `/login`    | `/login`    | `<Login />`    |
| `/contact`  | `/contact`  | `<Contact />`  |

React Router performs the matching.

---

# Route vs Component

These are different concepts.

### Component

```jsx
function About() {
  return <h1>About</h1>;
}
```

This defines **UI**.

### Route

```jsx
<Route
  path="/about"
  element={<About />}
/>
```

This defines:

> **When should that UI be displayed based on the URL?**

Therefore:

```text
Component
→ Defines UI

Route
→ Connects URL to UI
```

---

# ⚠️ Common Mistakes

## 1. Forgetting `<Routes>`

Wrong:

```jsx
<BrowserRouter>
  <Route
    path="/about"
    element={<About />}
  />
</BrowserRouter>
```

Normally:

```jsx
<BrowserRouter>
  <Routes>
    <Route
      path="/about"
      element={<About />}
    />
  </Routes>
</BrowserRouter>
```

---

## 2. Passing the component instead of an element

Wrong:

```jsx
<Route
  path="/about"
  element={About}
/>
```

Correct:

```jsx
<Route
  path="/about"
  element={<About />}
/>
```

---

## 3. Putting query parameters into the path unnecessarily

Don't define:

```jsx
<Route
  path="/products?category=laptop"
  element={<Products />}
/>
```

Instead:

```jsx
<Route
  path="/products"
  element={<Products />}
/>
```

Then read:

```text
?category=laptop
```

as a query parameter.

---

## 4. Confusing route parameters and query parameters

### Route parameter

```text
/products/101
```

```jsx
path="/products/:id"
```

### Query parameter

```text
/products?id=101
```

```jsx
path="/products"
```

These are different concepts.

---

# WHEN?

Use routes whenever different URLs should correspond to different parts of your application.

For example:

```text
E-commerce
/products
/products/:id
/cart
/checkout
```

```text
Admin
/admin
/admin/users
/admin/settings
```

```text
Portfolio
/
/projects
/about
/contact
```

---

# ⭐ Interview Questions

### Q1. What is a Route in React Router?

**Answer:**

A Route maps a URL pattern to a React element that should be rendered when that pattern matches the current location.

---

### Q2. What is the difference between `path` and `element`?

```text
path
→ URL pattern

element
→ React UI to render
```

Example:

```jsx
<Route
  path="/users"
  element={<Users />}
/>
```

---

### Q3. What is the purpose of `<Routes>`?

`Routes` contains route definitions and renders the appropriate matching route.

---

### Q4. Can multiple URLs match the same route?

Yes. Dynamic route parameters allow multiple URL values to match one route.

Example:

```jsx
<Route
  path="/users/:id"
  element={<User />}
/>
```

matches:

```text
/users/1
/users/2
/users/100
```

---

### Q5. What is a dynamic route?

A route containing a parameter whose value can change.

```jsx
<Route
  path="/users/:id"
  element={<User />}
/>
```

---

### Q6. How do you create a 404 route?

Use a catch-all route:

```jsx
<Route
  path="*"
  element={<NotFound />}
/>
```

---

### Q7. Does a Route navigate the user?

Not by itself.

A `Route` defines **what to render for a URL**. Navigation is handled using tools such as:

```text
Link
NavLink
useNavigate
```

---

# ⭐ Remember

The most important concept:

```text
<Route
  path="/about"
  element={<About />}
/>
```

means:

```text
URL
 ↓
/about
 ↓
Route matches
 ↓
<About />
 ↓
About UI
```

And the overall structure:

```text
BrowserRouter
      ↓
    Routes
      ↓
     Route
      ↓
   Component
```

### One-line interview answer:

> **A Route in React Router maps a URL pattern defined by `path` to a React element defined by `element`, allowing the application to render the appropriate UI for the current URL.**
