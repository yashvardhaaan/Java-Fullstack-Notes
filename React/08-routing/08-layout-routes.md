# 08 — Layout Routes

## WHY?

In a real React application, many pages share the **same UI structure**.

For example:

```text
Navbar
   ↓
Page Content
   ↓
Footer
```

If you have:

```text
Home
About
Products
Contact
```

you don't want to write this in every page:

```jsx
<Navbar />

<Home />

<Footer />
```

Instead, create a **Layout Route** that contains the common UI once.

```text
              Layout
                │
       ┌────────┼────────┐
       ↓        ↓        ↓
      Home     About   Products
```

This makes the application:

* cleaner
* reusable
* easier to maintain
* easier to scale

---

# WHAT?

A **Layout Route** is a parent route that provides a common UI structure for multiple child routes.

The most important part is:

```jsx
<Outlet />
```

`Outlet` is the place where the currently matched child route is rendered.

For example:

```jsx
function MainLayout() {
  return (
    <>
      <Navbar />

      <main>
        <Outlet />
      </main>

      <Footer />
    </>
  );
}
```

Here:

```text
Navbar
   ↓
Outlet → Current Page
   ↓
Footer
```

---

# WHERE?

Layout routes are commonly used for:

### Main website

```text
Navbar
Footer
```

### Dashboard

```text
Sidebar
Topbar
Dashboard content
```

### Admin panel

```text
Admin Navbar
Admin Sidebar
Admin content
```

### Account section

```text
Account Sidebar
Profile
Settings
Orders
```

---

# HOW?

## Step 1 — Create a Layout

Create:

```text
MainLayout.jsx
```

```jsx
import { Outlet } from "react-router-dom";

function MainLayout() {
  return (
    <>
      <Navbar />

      <main>
        <Outlet />
      </main>

      <Footer />
    </>
  );
}

export default MainLayout;
```

The important part is:

```jsx
<Outlet />
```

---

# Step 2 — Create Routes

```jsx
import { Routes, Route } from "react-router-dom";

<Routes>

  <Route element={<MainLayout />}>

    <Route path="/" element={<Home />} />

    <Route path="/about" element={<About />} />

    <Route path="/products" element={<Products />} />

    <Route path="/contact" element={<Contact />} />

  </Route>

</Routes>
```

Notice this:

```jsx
<Route element={<MainLayout />}>
```

There is **no `path`**.

This is called a **pathless layout route**.

It doesn't add anything to the URL.

---

# HOW DOES IT WORK?

Suppose the user visits:

```text
/products
```

React Router matches:

```text
MainLayout
    ↓
Products
```

Then:

```jsx
<MainLayout>
```

renders:

```text
Navbar
   ↓
Outlet
   ↓
Products
   ↓
Footer
```

So the final UI becomes:

```text
┌──────────────────────┐
│       Navbar         │
├──────────────────────┤
│                      │
│      Products        │
│                      │
├──────────────────────┤
│       Footer         │
└──────────────────────┘
```

---

# PATHLESS LAYOUT ROUTE

This is very important.

You can write:

```jsx
<Route element={<MainLayout />}>
  <Route path="/" element={<Home />} />
  <Route path="/about" element={<About />} />
  <Route path="/products" element={<Products />} />
</Route>
```

The layout itself doesn't create a URL.

URLs remain:

```text
/
 /about
 /products
```

The layout simply provides shared UI.

---

# DASHBOARD LAYOUT

A more practical example is a dashboard.

Suppose you have:

```text
/dashboard
/dashboard/users
/dashboard/settings
/dashboard/reports
```

Create:

```jsx
function DashboardLayout() {
  return (
    <div className="dashboard">

      <Sidebar />

      <div className="content">
        <Header />

        <Outlet />
      </div>

    </div>
  );
}
```

Routes:

```jsx
<Route path="/dashboard" element={<DashboardLayout />}>

  <Route index element={<DashboardHome />} />

  <Route path="users" element={<Users />} />

  <Route path="settings" element={<Settings />} />

  <Route path="reports" element={<Reports />} />

</Route>
```

Notice the child paths:

```jsx
path="users"
path="settings"
path="reports"
```

They are **relative paths**.

Therefore:

```text
/dashboard
/dashboard/users
/dashboard/settings
/dashboard/reports
```

---

# WHAT IS `index`?

This:

```jsx
<Route index element={<DashboardHome />} />
```

means:

> Render `DashboardHome` when `/dashboard` itself is visited.

So:

```text
/dashboard
     ↓
DashboardHome
```

while:

```text
/dashboard/users
     ↓
Users
```

---

# LAYOUT ROUTE HIERARCHY

Think of it like this:

```text
DashboardLayout
│
├── DashboardHome
├── Users
├── Settings
└── Reports
```

`DashboardLayout` contains:

```jsx
<Sidebar />
<Header />
<Outlet />
```

The child page appears inside:

```jsx
<Outlet />
```

---

# MAIN LAYOUT + DASHBOARD LAYOUT

Large applications can have multiple layouts.

For example:

```text
MainLayout
│
├── Home
├── About
└── Products


DashboardLayout
│
├── Dashboard
├── Users
├── Reports
└── Settings
```

Routes:

```jsx
<Routes>

  <Route element={<MainLayout />}>

    <Route path="/" element={<Home />} />

    <Route path="/about" element={<About />} />

    <Route path="/products" element={<Products />} />

  </Route>


  <Route path="/dashboard" element={<DashboardLayout />}>

    <Route index element={<DashboardHome />} />

    <Route path="users" element={<Users />} />

    <Route path="reports" element={<Reports />} />

    <Route path="settings" element={<Settings />} />

  </Route>

</Routes>
```

---

# PATHLESS vs PATH-BASED LAYOUT

## Pathless Layout

```jsx
<Route element={<MainLayout />}>
```

Used when the layout should apply to routes without adding a URL segment.

Example:

```text
/
 /about
 /products
```

---

## Path-Based Layout

```jsx
<Route path="/dashboard" element={<DashboardLayout />}>
```

Used when the layout represents a specific section.

Example:

```text
/dashboard
/dashboard/users
/dashboard/settings
```

---

# WHERE SHOULD LAYOUTS BE STORED?

A practical project:

```text
src/
│
├── layouts/
│   ├── MainLayout.jsx
│   └── DashboardLayout.jsx
│
├── components/
│   ├── Navbar.jsx
│   ├── Sidebar.jsx
│   └── Footer.jsx
│
├── pages/
│   ├── Home.jsx
│   ├── About.jsx
│   ├── Products.jsx
│   ├── DashboardHome.jsx
│   ├── Users.jsx
│   └── Settings.jsx
│
└── App.jsx
```

This separation becomes very useful as the application grows.

---

# WHEN?

Use a layout route when multiple pages share common UI.

### Example 1

```text
Home
About
Products
Contact
```

All share:

```text
Navbar + Footer
```

Use:

```text
MainLayout
```

---

### Example 2

```text
Dashboard
Users
Reports
Settings
```

All share:

```text
Sidebar + Header
```

Use:

```text
DashboardLayout
```

---

### Example 3

```text
Profile
Security
Orders
Payments
```

All share:

```text
Account Sidebar
```

Use:

```text
AccountLayout
```

---

# ❌ COMMON MISTAKES

### 1. Forgetting `<Outlet />`

Wrong:

```jsx
function Layout() {
  return (
    <>
      <Navbar />
      <Footer />
    </>
  );
}
```

The child page has nowhere to render.

Correct:

```jsx
function Layout() {
  return (
    <>
      <Navbar />
      <Outlet />
      <Footer />
    </>
  );
}
```

---

### 2. Confusing Layout Route with CSS Layout

These are different.

**CSS layout:**

```text
Flexbox
Grid
Position
```

**React Router Layout Route:**

```text
Parent Route
     ↓
Shared UI
     ↓
Outlet
     ↓
Child Route
```

---

### 3. Repeating Navbar on every page

Avoid:

```jsx
function Home() {
  return (
    <>
      <Navbar />
      <HomeContent />
      <Footer />
    </>
  );
}
```

and:

```jsx
function About() {
  return (
    <>
      <Navbar />
      <AboutContent />
      <Footer />
    </>
  );
}
```

Instead:

```text
MainLayout
 ├── Navbar
 ├── Outlet
 └── Footer
```

---

# ⭐ INTERVIEW QUESTIONS

### Q1. What is a Layout Route?

A Layout Route is a parent route that provides shared UI for multiple child routes using `<Outlet />`.

---

### Q2. Why do we use `<Outlet />`?

`<Outlet />` defines where the matched child route should be rendered inside the parent layout.

---

### Q3. What is a pathless layout route?

A route with an element but no `path`:

```jsx
<Route element={<MainLayout />}>
```

It provides shared UI without adding a URL segment.

---

### Q4. What is the difference between a nested route and a layout route?

A **nested route** describes a parent-child route relationship.

A **layout route** uses that relationship specifically to provide shared UI around child routes.

They are often used together.

---

### Q5. Can an application have multiple layouts?

**Yes.**

For example:

```text
MainLayout
DashboardLayout
AdminLayout
AccountLayout
```

---

### Q6. Does a pathless layout change the URL?

**No.**

```jsx
<Route element={<MainLayout />}>
```

doesn't add a URL segment.

---

### Q7. Why are layouts useful in large applications?

They prevent duplication and allow multiple pages to share consistent UI and structure.

---

# ⭐ REMEMBER

```text
              Layout Route
                   │
       ┌───────────┼───────────┐
       ↓           ↓           ↓
     Page 1      Page 2      Page 3
       │           │           │
       └──────── Outlet ───────┘
```

The key idea:

```jsx
<Layout>
   <Outlet />
</Layout>
```

### One-line interview answer:

> **A Layout Route is a parent route that renders shared UI such as a Navbar, Sidebar, or Footer and uses `<Outlet />` to render the matched child route inside that layout.**
