# 04 — Navigation

## WHY?

Routes define **which UI should appear for a URL**, but we also need a way for users to **move from one route to another**.

For example:

```text
Home
  ↓
Products
  ↓
Product Details
  ↓
Cart
  ↓
Checkout
```

We don't want the user to manually type:

```text
/products
/products/101
/cart
```

We need navigation controls.

React Router provides:

```text
Link
NavLink
useNavigate
```

---

# WHAT?

**Navigation** means changing the current URL and moving the user from one route to another.

For example:

```text
Current:
/

User clicks Products

        ↓

New:
/products
```

React Router can perform this navigation without requiring a traditional full-page reload for internal application routes.

---

# WHERE?

Navigation is commonly used in:

* Navbar
* Sidebar
* Buttons
* Menus
* Login/logout flows
* After form submission
* After creating/updating data
* Back buttons

Example:

```text
Navbar
├── Home
├── Products
├── About
└── Contact
```

---

# HOW?

There are three important ways to navigate.

```text
1. Link
2. NavLink
3. useNavigate()
```

---

# 1. `<Link>`

`Link` is the most common way to create navigation links.

```jsx
import { Link } from "react-router-dom";

function Navbar() {
  return (
    <nav>
      <Link to="/">Home</Link>
      <Link to="/about">About</Link>
      <Link to="/products">Products</Link>
    </nav>
  );
}
```

Clicking:

```jsx
<Link to="/products">
  Products
</Link>
```

changes the URL to:

```text
/products
```

and React Router renders the matching route.

---

# Why Use `<Link>` Instead of `<a>`?

You might write:

```html
<a href="/products">Products</a>
```

This is a normal HTML link.

For internal React Router navigation, generally use:

```jsx
<Link to="/products">
  Products
</Link>
```

The important difference is that `Link` integrates with React Router's client-side navigation.

---

# `<Link>` Flow

```text
User clicks Link
       ↓
React Router navigation
       ↓
URL changes
       ↓
Matching Route
       ↓
Component renders
```

---

# 2. `<NavLink>`

`NavLink` is similar to `Link`, but it gives you information about whether the link is **currently active**.

This makes it particularly useful for:

* navigation bars
* sidebars
* menus
* dashboards

Example:

```jsx
import { NavLink } from "react-router-dom";

function Navbar() {
  return (
    <nav>
      <NavLink to="/">Home</NavLink>

      <NavLink to="/products">
        Products
      </NavLink>

      <NavLink to="/about">
        About
      </NavLink>
    </nav>
  );
}
```

---

# Active Navigation

Suppose the current URL is:

```text
/products
```

React Router knows:

```text
Home      → inactive
Products  → active
About     → inactive
```

You can use this to style the active link.

Example:

```jsx
<NavLink
  to="/products"
  className={({ isActive }) =>
    isActive ? "active" : ""
  }
>
  Products
</NavLink>
```

Now:

```text
/products
    ↓
isActive = true
```

---

# Link vs NavLink

| Feature                  | Link | NavLink  |
| ------------------------ | ---- | -------- |
| Navigation               | ✅    | ✅        |
| Changes URL              | ✅    | ✅        |
| Active-state information | ❌    | ✅        |
| Good for navbar          | ✅    | ⭐ Better |
| Good for normal links    | ⭐    | ✅        |

Think:

```text
Link
→ "Go there"

NavLink
→ "Go there + tell me if I'm currently there"
```

---

# 3. `useNavigate()`

Sometimes navigation needs to happen **programmatically**.

For example:

```text
Login successful
      ↓
Go to dashboard
```

There isn't necessarily a link the user clicked.

That's where `useNavigate()` is useful.

```jsx
import { useNavigate } from "react-router-dom";

function Login() {
  const navigate = useNavigate();

  function handleLogin() {
    // Login logic...

    navigate("/dashboard");
  }

  return (
    <button onClick={handleLogin}>
      Login
    </button>
  );
}
```

After successful login:

```text
Login successful
       ↓
navigate("/dashboard")
       ↓
/dashboard
```

---

# `useNavigate()` Syntax

```jsx
const navigate = useNavigate();
```

Then:

```jsx
navigate("/products");
```

or:

```jsx
navigate("/profile");
```

---

# Navigate After Form Submission

A very common real-world example:

```jsx
function Register() {
  const navigate = useNavigate();

  async function handleSubmit(event) {
    event.preventDefault();

    // Send registration request
    await registerUser();

    navigate("/login");
  }

  return (
    <form onSubmit={handleSubmit}>
      <button type="submit">
        Register
      </button>
    </form>
  );
}
```

Flow:

```text
Submit form
    ↓
POST /api/register
    ↓
Success
    ↓
navigate("/login")
    ↓
Login page
```

---

# Navigate After API Request

Another common example:

```jsx
async function handleCreateProduct() {
  const product = await createProduct();

  navigate(`/products/${product.id}`);
}
```

Flow:

```text
Create product
      ↓
API returns product
      ↓
Get product ID
      ↓
Navigate to details
```

For example:

```text
/products/101
```

---

# Navigate Back

`useNavigate()` can also navigate through browser history.

```jsx
navigate(-1);
```

This means:

> Go back one history entry.

Example:

```jsx
function BackButton() {
  const navigate = useNavigate();

  return (
    <button onClick={() => navigate(-1)}>
      Go Back
    </button>
  );
}
```

You can also move forward:

```jsx
navigate(1);
```

---

# Replace Current History Entry

You can also replace the current history entry:

```jsx
navigate("/dashboard", {
  replace: true
});
```

Normally:

```text
/login
   ↓
/dashboard
```

The history contains both.

With:

```jsx
replace: true
```

the current entry is replaced.

This can be useful in flows where you don't want the user to return to a previous route using the Back button.

---

# Passing State During Navigation

You can pass temporary navigation state:

```jsx
navigate("/profile", {
  state: {
    from: "login"
  }
});
```

Then the destination can read it using `useLocation()`:

```jsx
import { useLocation } from "react-router-dom";

function Profile() {
  const location = useLocation();

  console.log(location.state);

  return <h1>Profile</h1>;
}
```

This is useful for navigation-related information, but it should **not** be treated as a secure storage mechanism.

---

# Link with State

You can also pass state through `Link`:

```jsx
<Link
  to="/profile"
  state={{ from: "dashboard" }}
>
  Profile
</Link>
```

---

# Dynamic Navigation

Suppose we have:

```jsx
<Route
  path="/products/:id"
  element={<ProductDetails />}
/>
```

We can navigate dynamically:

```jsx
function ProductCard({ product }) {
  const navigate = useNavigate();

  return (
    <button
      onClick={() =>
        navigate(`/products/${product.id}`)
      }
    >
      View Product
    </button>
  );
}
```

If:

```text
product.id = 101
```

the navigation becomes:

```text
/products/101
```

---

# `Link` vs `useNavigate`

This is an important interview question.

### Use `Link` when:

The user should **click something to navigate**.

```jsx
<Link to="/products">
  Products
</Link>
```

### Use `useNavigate` when:

Navigation should happen because of **logic or an event**.

```jsx
if (loginSuccessful) {
  navigate("/dashboard");
}
```

Think:

```text
User-driven navigation
→ Link / NavLink

Programmatic navigation
→ useNavigate
```

---

# Complete Navbar Example

```jsx
import {
  NavLink
} from "react-router-dom";

function Navbar() {
  return (
    <nav>
      <NavLink to="/">
        Home
      </NavLink>

      <NavLink to="/products">
        Products
      </NavLink>

      <NavLink to="/about">
        About
      </NavLink>

      <NavLink to="/contact">
        Contact
      </NavLink>
    </nav>
  );
}

export default Navbar;
```

---

# Complete Application

```jsx
import {
  BrowserRouter,
  Routes,
  Route,
  NavLink
} from "react-router-dom";

function Home() {
  return <h1>Home</h1>;
}

function Products() {
  return <h1>Products</h1>;
}

function About() {
  return <h1>About</h1>;
}

function App() {
  return (
    <BrowserRouter>

      <nav>
        <NavLink to="/">Home</NavLink>
        <NavLink to="/products">Products</NavLink>
        <NavLink to="/about">About</NavLink>
      </nav>

      <Routes>
        <Route
          path="/"
          element={<Home />}
        />

        <Route
          path="/products"
          element={<Products />}
        />

        <Route
          path="/about"
          element={<About />}
        />
      </Routes>

    </BrowserRouter>
  );
}

export default App;
```

---

# Navigation Flow

```text
                BrowserRouter
                      ↓
                    Routes
                      ↓
             ┌────────┴────────┐
             ↓                 ↓
          Link              navigate()
             ↓                 ↓
        User click         Application logic
             ↓                 ↓
             └────────┬────────┘
                      ↓
                  URL changes
                      ↓
                Route matching
                      ↓
                 UI renders
```

---

# ⚠️ Common Mistakes

## 1. Using `<a>` for every internal route

Instead of:

```jsx
<a href="/products">
  Products
</a>
```

prefer:

```jsx
<Link to="/products">
  Products
</Link>
```

for internal React Router navigation.

---

## 2. Calling `useNavigate()` outside a Router

This won't work correctly:

```jsx
function App() {
  const navigate = useNavigate();

  // ...
}
```

if `App` itself isn't inside an appropriate router context.

---

## 3. Using `useNavigate()` for simple links

This:

```jsx
<button onClick={() => navigate("/about")}>
  About
</button>
```

works, but if your requirement is simply a normal navigation link, this is usually cleaner:

```jsx
<Link to="/about">
  About
</Link>
```

Use programmatic navigation when you actually have logic driving the navigation.

---

## 4. Using navigation state for important persistent data

Don't treat:

```jsx
state={{ userId: 101 }}
```

as a replacement for proper application/server state.

Navigation state is primarily useful for information associated with a navigation.

---

# WHEN?

### Use `Link`

When the user needs to click a link:

```jsx
<Link to="/products">
  Products
</Link>
```

### Use `NavLink`

When the link is part of navigation and you need an active state:

```jsx
<NavLink to="/products">
  Products
</NavLink>
```

### Use `useNavigate`

When navigation should happen programmatically:

```text
Login success
     ↓
navigate("/dashboard")
```

```text
Form submitted
     ↓
API success
     ↓
navigate("/success")
```

```text
Logout
     ↓
navigate("/login")
```

---

# ⭐ Interview Questions

### Q1. How do you navigate between routes in React Router?

You can use `Link`, `NavLink`, or `useNavigate()`.

---

### Q2. Difference between `Link` and `NavLink`?

`NavLink` provides information about whether the current route is active, while `Link` is a basic navigation component.

---

### Q3. When would you use `useNavigate()`?

When navigation needs to happen programmatically as a result of application logic, such as after login, form submission, or an API operation.

---

### Q4. How do you navigate back?

```jsx
navigate(-1);
```

---

### Q5. What does `replace: true` do?

```jsx
navigate("/dashboard", {
  replace: true
});
```

It replaces the current history entry instead of adding a new one.

---

### Q6. Can you navigate dynamically?

Yes.

```jsx
navigate(`/products/${product.id}`);
```

---

### Q7. Should you use `<a>` or `<Link>` for internal React Router navigation?

Generally, use `Link` or `NavLink` for internal application routes so navigation integrates with the client-side router.

---

# ⭐ Remember

```text
LINK
 ↓
Normal user navigation

NAVLINK
 ↓
Navigation + active state

useNavigate()
 ↓
Programmatic navigation
```

The easiest rule to remember:

```text
User clicks a link
      ↓
<Link />

Need active styling
      ↓
<NavLink />

Code decides where to go
      ↓
useNavigate()
```

### One-line interview answer:

> **React Router provides `Link` and `NavLink` for declarative navigation and `useNavigate` for programmatic navigation when application logic needs to change the current route.**
