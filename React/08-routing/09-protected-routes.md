# 09 — Protected Routes

## WHY?

In real React applications, **not every page should be accessible to everyone**.

For example:

* `/dashboard` → only logged-in users
* `/profile` → only logged-in users
* `/admin` → only admin users
* `/login` → users who are not logged in
* `/public` → everyone

If an unauthenticated user directly enters:

```text
http://localhost:5173/dashboard
```

the application should check:

> **"Is this user authenticated?"**

If **yes** → show Dashboard
If **no** → redirect to Login.

This is called a **Protected Route**.

---

# WHAT?

A **Protected Route** is a route that checks some condition—usually authentication or authorization—before allowing the user to access a page.

Conceptually:

```text
User requests /dashboard
          ↓
   Is user logged in?
      ↙       ↘
    YES        NO
     ↓          ↓
 Dashboard    Login
```

A protected route is commonly implemented using:

* `Outlet`
* `Navigate`
* authentication state
* nested routes

---

# WHERE?

Protected routes are commonly used for:

### User pages

```text
/profile
/settings
/orders
/cart
```

### Application pages

```text
/dashboard
/projects
/reports
```

### Admin pages

```text
/admin
/admin/users
/admin/settings
```

### Authentication-based applications

```text
Banking
E-commerce
SaaS
Social Media
Admin Panels
College Portals
```

---

# HOW?

## Step 1 — Create authentication state

For a simple example:

```jsx
const isAuthenticated = true;
```

In a real application, this might come from:

```jsx
Context
Redux
Zustand
Server session
JWT
Auth provider
```

---

## Step 2 — Create `ProtectedRoute`

```jsx
import { Navigate, Outlet } from "react-router-dom";

function ProtectedRoute() {
  const isAuthenticated = true;

  if (!isAuthenticated) {
    return <Navigate to="/login" replace />;
  }

  return <Outlet />;
}

export default ProtectedRoute;
```

### What is happening?

```jsx
if (!isAuthenticated) {
  return <Navigate to="/login" replace />;
}
```

If the user isn't logged in:

```text
/dashboard
     ↓
 /login
```

Otherwise:

```jsx
return <Outlet />;
```

The requested child route is displayed.

---

# Step 3 — Protect routes

```jsx
import { Routes, Route } from "react-router-dom";

<Routes>

  <Route element={<ProtectedRoute />}>

    <Route path="/dashboard" element={<Dashboard />} />

    <Route path="/profile" element={<Profile />} />

    <Route path="/settings" element={<Settings />} />

  </Route>

  <Route path="/login" element={<Login />} />

</Routes>
```

Now:

```text
ProtectedRoute
      │
      ├── /dashboard
      ├── /profile
      └── /settings
```

All three routes use the same authentication check.

---

# HOW `<Outlet />` HELPS

Remember nested routes.

```jsx
<Route element={<ProtectedRoute />}>

  <Route path="/dashboard" element={<Dashboard />} />

  <Route path="/profile" element={<Profile />} />

</Route>
```

Inside `ProtectedRoute`:

```jsx
return <Outlet />;
```

`Outlet` means:

> "Render whichever protected child route matched."

For example:

```text
/dashboard
```

becomes:

```text
ProtectedRoute
      ↓
   Outlet
      ↓
 Dashboard
```

---

# COMPLETE PRACTICAL EXAMPLE

## `ProtectedRoute.jsx`

```jsx
import { Navigate, Outlet, useLocation } from "react-router-dom";

function ProtectedRoute() {
  const isAuthenticated = false;
  const location = useLocation();

  if (!isAuthenticated) {
    return (
      <Navigate
        to="/login"
        state={{ from: location }}
        replace
      />
    );
  }

  return <Outlet />;
}

export default ProtectedRoute;
```

---

## `App.jsx`

```jsx
import { BrowserRouter, Routes, Route } from "react-router-dom";

function App() {
  return (
    <BrowserRouter>
      <Routes>

        <Route path="/login" element={<Login />} />

        <Route element={<ProtectedRoute />}>

          <Route
            path="/dashboard"
            element={<Dashboard />}
          />

          <Route
            path="/profile"
            element={<Profile />}
          />

          <Route
            path="/settings"
            element={<Settings />}
          />

        </Route>

      </Routes>
    </BrowserRouter>
  );
}
```

---

# REDIRECTING BACK AFTER LOGIN

Suppose the user tries:

```text
/dashboard
```

but isn't logged in.

We redirect:

```text
/dashboard
     ↓
 /login
```

After successful login, we may want to return them to:

```text
/dashboard
```

That's why we can store the original location:

```jsx
state={{ from: location }}
```

Then in Login:

```jsx
const location = useLocation();
const navigate = useNavigate();

function handleLogin() {
  const destination = location.state?.from?.pathname || "/";

  navigate(destination, { replace: true });
}
```

This creates a better user experience.

---

# AUTHENTICATION vs AUTHORIZATION

These are **not the same thing**.

## Authentication

Answers:

> **Who are you?**

Example:

```text
Is the user logged in?
```

---

## Authorization

Answers:

> **What are you allowed to access?**

Example:

```text
Is this user an admin?
```

So:

```text
Authentication
      ↓
Are you logged in?
      ↓
Authorization
      ↓
Are you allowed to access this page?
```

---

# ADMIN PROTECTED ROUTE

Suppose only admins can access:

```text
/admin
```

We can create:

```jsx
function AdminRoute() {
  const user = {
    isAuthenticated: true,
    role: "user"
  };

  if (!user.isAuthenticated) {
    return <Navigate to="/login" replace />;
  }

  if (user.role !== "admin") {
    return <Navigate to="/unauthorized" replace />;
  }

  return <Outlet />;
}
```

Routes:

```jsx
<Route element={<AdminRoute />}>

  <Route
    path="/admin"
    element={<AdminDashboard />}
  />

</Route>
```

Now:

```text
Not logged in
      ↓
    /login


Logged in but not admin
      ↓
 /unauthorized


Logged in + admin
      ↓
 /admin
```

---

# PROJECT STRUCTURE

A practical project can look like:

```text
src/
│
├── components/
│   ├── Navbar.jsx
│   └── ProtectedRoute.jsx
│
├── pages/
│   ├── Home.jsx
│   ├── Login.jsx
│   ├── Dashboard.jsx
│   ├── Profile.jsx
│   └── Unauthorized.jsx
│
├── context/
│   └── AuthContext.jsx
│
└── App.jsx
```

For a larger application:

```text
src/
├── auth/
│   ├── AuthContext.jsx
│   ├── ProtectedRoute.jsx
│   └── authService.js
│
├── layouts/
├── pages/
├── components/
└── App.jsx
```

---

# WHEN?

Use protected routes when:

### 1. Login is required

```text
/dashboard
```

### 2. User-specific information exists

```text
/profile
/orders
/account
```

### 3. Admin access is required

```text
/admin
```

### 4. Different roles have different permissions

```text
Admin
Manager
Employee
Customer
```

---

# ❌ COMMON MISTAKES

## Mistake 1 — Forgetting `<Outlet />`

Wrong:

```jsx
function ProtectedRoute() {
  if (!isAuthenticated) {
    return <Navigate to="/login" />;
  }
}
```

The child route has nowhere to render.

Correct:

```jsx
return <Outlet />;
```

---

## Mistake 2 — Only hiding links

This is **not security**:

```jsx
{isAuthenticated && (
  <Link to="/dashboard">Dashboard</Link>
)}
```

A user can still manually enter:

```text
/dashboard
```

You need route-level protection as well.

---

## Mistake 3 — Storing sensitive authorization only in frontend

Frontend protection improves the UI and navigation, but **does not secure your backend**.

For example:

```text
React
  ↓
ProtectedRoute
  ↓
Dashboard
```

is not enough to protect sensitive data.

The backend/API must independently verify:

```text
Authentication
Authorization
Permissions
```

---

## Mistake 4 — Confusing authentication with authorization

```text
Logged in ≠ Admin
```

A logged-in normal user shouldn't automatically get admin access.

---

# ⭐ INTERVIEW QUESTIONS

### Q1. What is a protected route?

A protected route is a route that checks authentication or authorization before rendering its content.

---

### Q2. How do you implement protected routes in React Router?

Usually by creating a wrapper route that checks authentication and either:

```jsx
return <Outlet />;
```

or:

```jsx
return <Navigate to="/login" />;
```

---

### Q3. Why is `<Outlet />` used?

`Outlet` renders the child route matched inside a parent route.

---

### Q4. What is `<Navigate />`?

`Navigate` is a React Router component used to perform declarative navigation/redirects.

Example:

```jsx
<Navigate to="/login" replace />
```

---

### Q5. Authentication vs authorization?

**Authentication** determines whether the user is logged in/identified.

**Authorization** determines what that user is allowed to access.

---

### Q6. Can protected routes alone secure an application?

**No.**

Frontend route protection is not a replacement for backend authorization.

---

### Q7. Why use `replace` during login redirects?

```jsx
<Navigate to="/login" replace />
```

`replace` replaces the current history entry instead of adding another one, helping prevent awkward back-navigation to the protected URL.

---

# ⭐ REMEMBER

```text
Protected Route
      ↓
Check authentication
      ↓
 ┌───────────────┐
 │               │
 YES             NO
 │               │
Outlet         Navigate
 │               │
Page            Login
```

### One-line interview answer:

> **A protected route is a route that conditionally renders its child route through `<Outlet />` when the user is authorized, otherwise it redirects using `<Navigate />`.**
