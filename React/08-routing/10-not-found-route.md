# 10 — Not Found Route

## WHY?

In a React application, users can enter **any URL manually**.

For example, suppose your application only has:

```text
/
 /about
 /products
 /contact
```

But someone visits:

```text
/hello
```

or:

```text
/productss
```

There is no matching route.

Instead of showing a blank screen, we should display a useful page such as:

```text
404 — Page Not Found

The page you're looking for doesn't exist.

[ Go Home ]
```

This is called a **Not Found Route** or **404 Route**.

---

# WHAT?

A **Not Found Route** is a route that matches when none of the application's defined routes match the current URL.

In React Router, we commonly use:

```jsx
path="*"
```

Example:

```jsx
<Route path="*" element={<NotFound />} />
```

The `*` acts as a **catch-all route**.

---

# WHERE?

A Not Found Route is normally placed at the end of your route configuration:

```jsx
<Routes>

  <Route path="/" element={<Home />} />
  <Route path="/about" element={<About />} />
  <Route path="/products" element={<Products />} />

  <Route path="*" element={<NotFound />} />

</Routes>
```

It handles URLs such as:

```text
/random
/abc
/hello/world
/product/999/extra
```

when none of your defined routes match them.

---

# HOW?

## Step 1 — Create a `NotFound` component

```jsx
function NotFound() {
  return (
    <div>
      <h1>404</h1>

      <h2>Page Not Found</h2>

      <p>
        Sorry, the page you are looking for does not exist.
      </p>
    </div>
  );
}

export default NotFound;
```

---

# Step 2 — Add the catch-all route

```jsx
<Routes>

  <Route path="/" element={<Home />} />

  <Route path="/about" element={<About />} />

  <Route path="/products" element={<Products />} />

  <Route path="*" element={<NotFound />} />

</Routes>
```

Now:

```text
/              → Home
/about         → About
/products      → Products
/anything      → NotFound
```

---

# HOW `*` WORKS

Suppose the user visits:

```text
/xyz
```

React Router checks the available routes.

```text
/xyz
 ↓
Does "/" match?       ❌
Does "/about" match?  ❌
Does "/products" match? ❌
Does "*" match?       ✅
 ↓
NotFound
```

So:

```jsx
<Route path="*" element={<NotFound />} />
```

acts as the fallback.

---

# PRACTICAL 404 PAGE

A useful 404 page should provide navigation back to a valid page.

```jsx
import { Link } from "react-router-dom";

function NotFound() {
  return (
    <div>
      <h1>404</h1>

      <h2>Page Not Found</h2>

      <p>
        The page you requested does not exist.
      </p>

      <Link to="/">
        Go to Home
      </Link>
    </div>
  );
}

export default NotFound;
```

Now the user can click:

```text
Go to Home
```

instead of manually typing a URL.

---

# NOT FOUND WITH A LAYOUT

You can also place the 404 page inside your main layout.

```jsx
<Routes>

  <Route element={<MainLayout />}>

    <Route path="/" element={<Home />} />

    <Route path="/about" element={<About />} />

    <Route path="/products" element={<Products />} />

    <Route path="*" element={<NotFound />} />

  </Route>

</Routes>
```

Then the 404 page gets the same:

```text
Navbar
   ↓
404 Page
   ↓
Footer
```

because:

```jsx
<Outlet />
```

inside `MainLayout` renders `NotFound`.

---

# NESTED 404 ROUTES

Not Found routes can also be useful inside a specific section.

For example:

```text
/dashboard
/dashboard/users
/dashboard/settings
```

Routes:

```jsx
<Route path="/dashboard" element={<DashboardLayout />}>

  <Route index element={<DashboardHome />} />

  <Route path="users" element={<Users />} />

  <Route path="settings" element={<Settings />} />

  <Route path="*" element={<DashboardNotFound />} />

</Route>
```

Now:

```text
/dashboard/users
       ↓
Users
```

but:

```text
/dashboard/abc
       ↓
DashboardNotFound
```

This allows different sections to have different fallback pages.

---

# WHEN?

Use a Not Found Route whenever your application has multiple routes and you want to properly handle invalid URLs.

Typical applications:

```text
E-commerce
Admin dashboards
Banking applications
Social media
SaaS applications
Blogs
College portals
```

---

# 404 vs SERVER ERROR

Don't confuse these.

### 404 — Not Found

Means:

> The requested resource/page doesn't exist.

Example:

```text
/products/999999
```

when that page doesn't exist.

---

### 500 — Server Error

Means:

> Something went wrong on the server.

These are completely different concepts.

---

# 404 PAGE vs ERROR BOUNDARY

A Not Found Route handles an **unknown URL**:

```jsx
<Route path="*" element={<NotFound />} />
```

An error boundary / route error handling mechanism handles **errors during route loading/rendering/data operations**, depending on how your router is configured.

So:

```text
Unknown URL
     ↓
404 Not Found


Application/route error
     ↓
Error handling UI
```

---

# ❌ COMMON MISTAKES

## 1. Forgetting the `*`

Wrong:

```jsx
<Route element={<NotFound />} />
```

Use:

```jsx
<Route path="*" element={<NotFound />} />
```

---

## 2. Not providing a way back

A 404 page should normally provide:

```jsx
<Link to="/">
  Go Home
</Link>
```

---

## 3. Confusing 404 with authentication

If the user isn't logged in:

```text
/dashboard
      ↓
/login
```

That's an **authentication redirect**, not a 404.

If the URL doesn't exist:

```text
/xyz
 ↓
404
```

---

## 4. Thinking `*` means "all valid routes"

It is better to think of it as a **fallback/catch-all for unmatched paths**, not as a replacement for defining your actual routes.

---

# ⭐ INTERVIEW QUESTIONS

### Q1. What is a Not Found Route?

A Not Found Route handles URLs that don't match any defined application route.

---

### Q2. How do you create a 404 route in React Router?

```jsx
<Route path="*" element={<NotFound />} />
```

---

### Q3. What does `*` mean?

It acts as a catch-all pattern for paths that aren't matched by the other applicable routes.

---

### Q4. Where should a 404 route be placed?

Usually as the fallback route within the relevant `<Routes>` tree.

---

### Q5. Can a 404 route be nested?

**Yes.**

For example:

```jsx
<Route path="/dashboard" element={<DashboardLayout />}>

  <Route path="users" element={<Users />} />

  <Route path="*" element={<DashboardNotFound />} />

</Route>
```

---

### Q6. What is the difference between 404 and redirecting to `/login`?

```text
404
→ URL doesn't exist


/login redirect
→ URL exists but user isn't authenticated
```

---

### Q7. Should a 404 page have navigation?

Usually **yes**. Providing a Home link, back action, or search/navigation option gives the user a way to recover.

---

# ⭐ REMEMBER

```text
User enters URL
      ↓
Does route exist?
   ↙       ↘
 YES        NO
  ↓          ↓
 Page       404
```

The key code:

```jsx
<Route path="*" element={<NotFound />} />
```

### One-line interview answer:

> **A Not Found Route is a catch-all route such as `path="*"` that renders a 404 page when no other route matches the requested URL.**
