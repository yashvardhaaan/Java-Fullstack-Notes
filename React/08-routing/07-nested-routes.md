# 07 — Nested Routes

## WHY?

Real applications often have a **hierarchy of pages**.

For example, an admin dashboard might have:

```text id="m9x4k2"
/dashboard
/dashboard/profile
/dashboard/settings
/dashboard/users
```

All of these pages belong to the **Dashboard** section.

Instead of defining every route completely independently, we can create **nested routes**.

The idea is:

```text id="p7v2q8"
Dashboard
   │
   ├── Profile
   ├── Settings
   └── Users
```

This makes the routing structure match the application's UI structure.

---

# WHAT?

A **nested route** is a route defined inside another route.

Example:

```jsx id="x5m8q1"
<Route path="dashboard" element={<Dashboard />}>
  <Route path="profile" element={<Profile />} />
  <Route path="settings" element={<Settings />} />
</Route>
```

The resulting URLs are:

```text id="j3k7p9"
/dashboard
/dashboard/profile
/dashboard/settings
```

Here:

```text id="q8v2m4"
dashboard
   ↓
Parent route

profile
settings
   ↓
Child routes
```

---

# WHERE?

Nested routes are especially useful for:

### Admin dashboards

```text id="g4m8x2"
/admin
/admin/users
/admin/products
/admin/settings
```

### User accounts

```text id="w7q2n5"
/account
/account/profile
/account/security
/account/orders
```

### E-learning platforms

```text id="c5v9k3"
/courses
/courses/react
/courses/react/lessons
/courses/react/projects
```

### Settings

```text id="r2m6x8"
/settings
/settings/profile
/settings/security
/settings/notifications
```

---

# HOW?

There are **two important parts** to nested routing:

```text id="v8k3q1"
1. Parent + child <Route>
2. <Outlet />
```

You need to understand both.

---

# Step 1 — Create Parent Route

Suppose we have:

```jsx id="h4p7m2"
<Route
  path="/dashboard"
  element={<Dashboard />}
/>
```

Now let's add children:

```jsx id="q9x5n3"
<Route
  path="/dashboard"
  element={<Dashboard />}
>
  <Route
    path="profile"
    element={<Profile />}
  />

  <Route
    path="settings"
    element={<Settings />}
  />

</Route>
```

Notice:

```jsx id="r5m8k2"
path="profile"
```

not:

```jsx id="v3q7x1"
path="/dashboard/profile"
```

The child route is **relative to the parent**.

---

# Resulting URLs

This:

```jsx id="j8m2p6"
<Route path="dashboard" element={<Dashboard />}>
  <Route path="profile" element={<Profile />} />
  <Route path="settings" element={<Settings />} />
</Route>
```

produces:

```text id="n4v7x2"
/dashboard
/dashboard/profile
/dashboard/settings
```

Think:

```text id="c9k3m7"
Parent:
 /dashboard

Child:
 profile

Combined:
 /dashboard/profile
```

---

# Step 2 — Use `<Outlet />`

This is the most important part.

The parent component needs to tell React Router:

> **"Render my child route here."**

That's what `Outlet` does.

### `Dashboard.jsx`

```jsx id="p6x9m2"
import { Outlet } from "react-router-dom";

function Dashboard() {
  return (
    <div>
      <h1>Dashboard</h1>

      <nav>
        {/* navigation */}
      </nav>

      <Outlet />
    </div>
  );
}

export default Dashboard;
```

Now the child component is rendered where:

```jsx id="t3k7q1"
<Outlet />
```

appears.

---

# Visual Understanding

Suppose:

```jsx id="f8m2x5"
function Dashboard() {
  return (
    <>
      <h1>Dashboard</h1>

      <nav>Dashboard Navigation</nav>

      <Outlet />
    </>
  );
}
```

For:

```text id="y7q3m1"
/dashboard/profile
```

React renders approximately:

```text id="w4n8k2"
Dashboard
────────────────────
Dashboard Navigation

Profile
────────────────────
```

The structure is:

```text id="s5v9x2"
Dashboard
   │
   └── Outlet
         │
         └── Profile
```

---

# Complete Example

## `App.jsx`

```jsx id="c8m4q7"
import {
  BrowserRouter,
  Routes,
  Route
} from "react-router-dom";

import Dashboard from "./pages/Dashboard";
import Profile from "./pages/Profile";
import Settings from "./pages/Settings";

function App() {
  return (
    <BrowserRouter>

      <Routes>

        <Route
          path="/dashboard"
          element={<Dashboard />}
        >

          <Route
            path="profile"
            element={<Profile />}
          />

          <Route
            path="settings"
            element={<Settings />}
          />

        </Route>

      </Routes>

    </BrowserRouter>
  );
}
```

---

## `Dashboard.jsx`

```jsx id="j7p2x9"
import { Outlet } from "react-router-dom";

function Dashboard() {
  return (
    <div>
      <h1>Dashboard</h1>

      <nav>
        Dashboard Navigation
      </nav>

      <Outlet />
    </div>
  );
}

export default Dashboard;
```

---

## `Profile.jsx`

```jsx id="k4m8q1"
function Profile() {
  return <h2>Profile</h2>;
}

export default Profile;
```

---

## `Settings.jsx`

```jsx id="n6x3p7"
function Settings() {
  return <h2>Settings</h2>;
}

export default Settings;
```

---

# What Happens at `/dashboard/profile`?

React Router sees:

```text id="v2q8m5"
/dashboard/profile
```

It matches:

```text id="x5n7k3"
dashboard
   ↓
profile
```

Then:

```text id="p8m4q2"
Dashboard
    +
Profile
```

The final UI becomes:

```text id="j9x3k7"
Dashboard
Dashboard Navigation

Profile
```

because:

```text id="z4m8p1"
<Dashboard />
    ↓
<Outlet />
    ↓
<Profile />
```

---

# Parent Route + Child Route

Think of it like folders:

```text id="k7q2m5"
dashboard/
│
├── profile
└── settings
```

The URL structure becomes:

```text id="p3x8n6"
/dashboard
/dashboard/profile
/dashboard/settings
```

This is why nested routes are intuitive for hierarchical applications.

---

# Nested Routes Can Have More Levels

You can nest routes more deeply.

```jsx id="y6m2q8"
<Route
  path="dashboard"
  element={<Dashboard />}
>
  <Route
    path="settings"
    element={<Settings />}
  >
    <Route
      path="security"
      element={<Security />}
    />
  </Route>
</Route>
```

URLs:

```text id="v9k3x5"
/dashboard
/dashboard/settings
/dashboard/settings/security
```

Structure:

```text id="a7m2q9"
Dashboard
   │
   └── Settings
          │
          └── Security
```

Each parent that needs to display its child route uses:

```jsx id="x4p8n1"
<Outlet />
```

---

# Index Routes

What should happen when the user visits:

```text id="c8m4v2"
/dashboard
```

but we have:

```text id="n5x7q3"
/dashboard/profile
/dashboard/settings
```

We can create an **index route**.

```jsx id="r2m8k6"
<Route
  path="dashboard"
  element={<Dashboard />}
>
  <Route
    index
    element={<DashboardHome />}
  />

  <Route
    path="profile"
    element={<Profile />}
  />

  <Route
    path="settings"
    element={<Settings />}
  />
</Route>
```

Now:

```text id="f6p3x9"
/dashboard
```

renders:

```text id="m8q2v5"
DashboardHome
```

while:

```text id="z3k7n1"
/dashboard/profile
```

renders:

```text id="h4x8m2"
Profile
```

The index route is essentially the **default child route**.

---

# Navigation Inside Nested Routes

You can use relative links.

For example, inside Dashboard:

```jsx id="v5m2q8"
import { Link } from "react-router-dom";

function Dashboard() {
  return (
    <>
      <h1>Dashboard</h1>

      <nav>
        <Link to="profile">
          Profile
        </Link>

        <Link to="settings">
          Settings
        </Link>
      </nav>

      <Outlet />
    </>
  );
}
```

From `/dashboard`, these become:

```text id="k8x4m1"
profile
   ↓
/dashboard/profile

settings
   ↓
/dashboard/settings
```

---

# Relative vs Absolute Paths

This is important.

### Relative

```jsx id="j3p7x9"
<Link to="profile">
```

If current route is:

```text id="m5q8v2"
/dashboard
```

it navigates to:

```text id="n6x3k7"
/dashboard/profile
```

---

### Absolute

```jsx id="x8m2q5"
<Link to="/profile">
```

This points to:

```text id="f7k3v1"
/profile
```

The leading `/` matters.

Think:

```text id="a9q4m6"
"profile"
   ↓
relative

"/profile"
   ↓
absolute from application root
```

---

# Nested Routes vs Normal Routes

### Normal

```jsx id="u5m8q2"
<Route
  path="/dashboard"
  element={<Dashboard />}
/>

<Route
  path="/profile"
  element={<Profile />}
/>
```

These are independent routes.

---

### Nested

```jsx id="k3x7m1"
<Route
  path="/dashboard"
  element={<Dashboard />}
>
  <Route
    path="profile"
    element={<Profile />}
  />
</Route>
```

Here:

```text id="v8q2n5"
Dashboard
    ↓
Profile
```

has a parent-child relationship.

---

# Why `<Outlet />` Is Necessary

Consider:

```jsx id="w4m7x2"
function Dashboard() {
  return (
    <div>
      <h1>Dashboard</h1>
    </div>
  );
}
```

You have:

```jsx id="q8n3k5"
<Route path="profile" element={<Profile />} />
```

But there's no:

```jsx id="p6m2x9"
<Outlet />
```

So where should React Router put `Profile` inside `Dashboard`?

There is no designated location.

Add:

```jsx id="z7k4m1"
<Outlet />
```

and the child route gets rendered there.

---

# Real-World Dashboard Example

Imagine:

```text id="n8q3m5"
Dashboard
│
├── Overview
├── Users
├── Products
├── Orders
└── Settings
```

Routes:

```jsx id="m5x7p2"
<Route
  path="/dashboard"
  element={<Dashboard />}
/>
```

with children:

```jsx id="q8v3k1"
<Route
  path="overview"
  element={<Overview />}
/>

<Route
  path="users"
  element={<Users />}
/>

<Route
  path="products"
  element={<Products />}
/>

<Route
  path="orders"
  element={<Orders />}
/>

<Route
  path="settings"
  element={<Settings />}
/>
```

Result:

```text id="x4m9p2"
/dashboard/overview
/dashboard/users
/dashboard/products
/dashboard/orders
/dashboard/settings
```

The Dashboard layout can remain visible while only the content inside `<Outlet />` changes.

---

# ⚠️ Common Mistakes

## 1. Forgetting `<Outlet />`

This is the biggest mistake.

Parent:

```jsx id="j7x2m4"
function Dashboard() {
  return <h1>Dashboard</h1>;
}
```

Child route exists, but there is no:

```jsx id="r5q8n1"
<Outlet />
```

So the child UI won't appear where expected.

---

## 2. Using `/` unnecessarily in child paths

Prefer:

```jsx id="p2m7x4"
<Route
  path="profile"
  element={<Profile />}
/>
```

inside:

```jsx id="x8q3n5"
<Route path="dashboard" ...>
```

rather than:

```jsx id="k6v9m2"
<Route
  path="/dashboard/profile"
  element={<Profile />}
/>
```

when you're expressing a nested route.

---

## 3. Confusing nested routes with nested components

These are related but different concepts.

### Nested components

```jsx id="c4x8m1"
<Dashboard>
  <Profile />
</Dashboard>
```

### Nested routes

```jsx id="p7q2n5"
<Route path="dashboard">
  <Route path="profile" />
</Route>
```

Nested routes describe a **URL/UI hierarchy**.

---

## 4. Forgetting index routes

If `/dashboard` should have default content, consider:

```jsx id="y8m3q6"
<Route
  index
  element={<DashboardHome />}
/>
```

---

# WHEN?

Use nested routes when:

* multiple pages belong to a parent section
* a common layout should remain visible
* a dashboard has multiple subsections
* settings have multiple sections
* user accounts have tabs/pages
* URL hierarchy represents UI hierarchy

For example:

```text id="s7m2x9"
/admin
/admin/users
/admin/settings
```

is a strong candidate for nested routing.

---

# ⭐ Interview Questions

### Q1. What are nested routes?

**Answer:**

Nested routes are routes defined inside a parent route, allowing the URL and UI to represent a hierarchical structure.

---

### Q2. What is `<Outlet />`?

**Answer:**

`Outlet` is the placeholder where the element of a matching child route is rendered inside the parent route's UI.

---

### Q3. Why is `<Outlet />` needed?

Because it tells React Router **where the child route's UI should appear** inside the parent component.

---

### Q4. What is an index route?

An index route is the default child route rendered when the parent route's path matches exactly.

```jsx id="g5x8m2"
<Route
  index
  element={<DashboardHome />}
/>
```

---

### Q5. What is the advantage of nested routing?

It allows you to model hierarchical URLs and share parent UI/layout while rendering different child content.

---

### Q6. What is the difference between:

```jsx id="j8m2q5"
path="profile"
```

and:

```jsx id="v6x3n9"
path="/profile"
```

The first is a **relative child path** when used inside a parent route; the second represents an absolute path from the application's root.

---

### Q7. Can nested routes have more nested routes?

Yes.

```text id="p4m8x2"
Dashboard
   ↓
Settings
   ↓
Security
```

Each level can have its own child routes and corresponding `<Outlet />`.

---

# ⭐ Remember

The most important pattern:

```jsx id="a6q3m9"
<Route
  path="dashboard"
  element={<Dashboard />}
>
  <Route
    path="profile"
    element={<Profile />}
  />

  <Route
    path="settings"
    element={<Settings />}
  />
</Route>
```

Parent:

```jsx id="f8m2x4"
function Dashboard() {
  return (
    <>
      <h1>Dashboard</h1>

      <Outlet />
    </>
  );
}
```

Think:

```text id="v7q3n8"
/dashboard
     ↓
 Dashboard
     ↓
  <Outlet />
     ↓
 ┌───────┴────────┐
 ↓                ↓
Profile         Settings
```

### One-line interview answer:

> **Nested routes allow routes to be organized hierarchically, where child routes inherit the parent route's path and can render their UI inside the parent's `<Outlet />`.**
