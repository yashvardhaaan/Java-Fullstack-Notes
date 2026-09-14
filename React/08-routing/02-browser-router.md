# 02 — BrowserRouter

## WHY?

React needs a way to understand the browser's URL and handle navigation **without reloading the entire page**.

For example:

```text id="j5x5f7"
/home
/about
/products
/profile
```

When the URL changes, we want React Router to decide:

```text id="n2a4xw"
Current URL
    ↓
Find matching route
    ↓
Render component
```

`BrowserRouter` provides the routing context that makes this possible.

---

# WHAT?

`BrowserRouter` is a React Router component that enables **client-side routing for web applications** using the browser's History API.

Example:

```jsx id="u4zjlf"
import { BrowserRouter } from "react-router-dom";

function App() {
  return (
    <BrowserRouter>
      {/* Your routes and components */}
    </BrowserRouter>
  );
}
```

Usually, your routing components such as:

```jsx id="a9m4q7"
Routes
Route
Link
NavLink
```

are placed inside the `BrowserRouter`.

---

# WHERE?

`BrowserRouter` is generally placed near the **root of the React application**.

For example:

```text id="j7d7pu"
src/
├── main.jsx
├── App.jsx
├── pages/
└── components/
```

### `main.jsx`

```jsx id="p9e8kh"
import ReactDOM from "react-dom/client";
import { BrowserRouter } from "react-router-dom";
import App from "./App";

ReactDOM.createRoot(
  document.getElementById("root")
).render(
  <BrowserRouter>
    <App />
  </BrowserRouter>
);
```

Then `App.jsx` can contain:

```jsx id="f9q1dx"
import { Routes, Route } from "react-router-dom";

function App() {
  return (
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/about" element={<About />} />
    </Routes>
  );
}
```

This is a very common structure.

---

# HOW?

## Step 1 — Wrap Your Application

```jsx id="8p9qk7"
<BrowserRouter>
  <App />
</BrowserRouter>
```

This provides routing context to everything inside it.

Think:

```text id="h9m5h2"
BrowserRouter
      │
      └── App
           │
           ├── Routes
           ├── Route
           ├── Link
           └── Other Components
```

---

## Step 2 — Define Routes

Inside the router:

```jsx id="8ppjha"
<Routes>
  <Route path="/" element={<Home />} />
  <Route path="/about" element={<About />} />
</Routes>
```

Now:

```text id="u5gdqu"
/       → Home
/about  → About
```

---

# How Does BrowserRouter Work?

At a high level:

```text id="wcxzvf"
User clicks a link
       ↓
URL changes
       ↓
Browser history is updated
       ↓
React Router detects the location
       ↓
Matching route is found
       ↓
React renders the route's element
```

The browser doesn't necessarily need to request a completely new HTML document for every internal navigation.

---

# Browser History API

`BrowserRouter` relies on browser history mechanisms such as:

```text id="6grvzo"
history.pushState()
history.replaceState()
popstate
```

You don't normally need to call these yourself when using React Router.

React Router provides higher-level APIs such as:

```jsx id="yup0xz"
<Link to="/about">About</Link>
```

and:

```jsx id="3w1b0f"
navigate("/about");
```

These interact with the browser's history/navigation system.

---

# BrowserRouter Example

```jsx id="2d2qzj"
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

      </Routes>
    </BrowserRouter>
  );
}

export default App;
```

---

# BrowserRouter and URL

Suppose the user visits:

```text id="q9u1bn"
https://myapp.com/about
```

The browser's current location contains:

```text id="m5sv5x"
/about
```

React Router sees:

```text id="2q7e5c"
/about
```

and finds:

```jsx id="0hkm9a"
<Route
  path="/about"
  element={<About />}
/>
```

Therefore:

```text id="b2z9p6"
/about
   ↓
<About />
```

---

# BrowserRouter vs HashRouter

This is an important interview topic.

## BrowserRouter

URLs look like:

```text id="5cw1u7"
https://example.com/products
```

It uses normal browser paths.

---

## HashRouter

URLs look like:

```text id="6rj5ha"
https://example.com/#/products
```

The route is represented after `#`.

Comparison:

| Feature                | BrowserRouter  | HashRouter        |
| ---------------------- | -------------- | ----------------- |
| URL                    | `/products`    | `/#/products`     |
| Uses History API       | Yes            | No, uses URL hash |
| Clean URLs             | ✅              | ❌                 |
| Server configuration   | Usually needed | Often simpler     |
| Common for modern apps | ✅              | Less common       |

---

# Why Does BrowserRouter Need Server Configuration?

This is a **very important real-world concept**.

Suppose your React app works at:

```text id="3yn6kn"
https://example.com/
```

You navigate to:

```text id="8f8x0h"
https://example.com/products
```

Client-side routing works.

But then you directly refresh the page.

The browser sends a request to the server:

```text id="wspv5e"
GET /products
```

The server must know that `/products` belongs to your React SPA and return the application's entry HTML.

If the server instead says:

```text id="t3o3v1"
404 Not Found
```

your route won't load on refresh.

So production deployments often need **SPA fallback configuration**.

---

# Example of the Problem

Client-side navigation:

```text id="j1a2cz"
Home
 ↓
Click Products
 ↓
React Router
 ↓
/products
 ↓
Products component
```

Works.

But refresh:

```text id="w5p2tw"
Refresh /products
       ↓
Browser requests /products
       ↓
Server
       ↓
404 ❌
```

The solution is server configuration that serves the SPA entry point for routes that aren't actual server files/resources.

---

# BrowserRouter `basename`

Sometimes your application is hosted inside a subdirectory.

For example:

```text id="i2oz9d"
https://example.com/my-app/
```

Instead of:

```text id="6as3se"
https://example.com/
```

You can configure:

```jsx id="7b4z9e"
<BrowserRouter basename="/my-app">
  <App />
</BrowserRouter>
```

Then:

```jsx id="9g8r8p"
<Route
  path="/products"
  element={<Products />}
/>
```

can correspond to:

```text id="0z5q1c"
/my-app/products
```

---

# Important: BrowserRouter Does NOT Render Pages

A common beginner misconception:

> "BrowserRouter displays the page."

Not exactly.

`BrowserRouter` provides the **routing context and location/history integration**.

`Routes` and `Route` determine what UI should render.

Think:

```text id="y8z0uo"
BrowserRouter
     ↓
Provides routing environment

Routes
     ↓
Matches routes

Route
     ↓
Chooses UI

Element
     ↓
Actually renders component
```

---

# BrowserRouter vs Browser

Don't confuse:

```text id="3d9s5z"
BrowserRouter
```

with:

```text id="r0n5eg"
Web Browser
```

The browser is:

```text id="b9n4fd"
Chrome
Firefox
Edge
Safari
```

`BrowserRouter` is a React Router component running **inside your React application**.

---

# WHEN?

Use `BrowserRouter` when:

* you're building a React web application
* you need client-side routing
* you want clean URLs
* you want navigation without full document reloads
* your deployment can be configured for SPA routes

Typical application:

```text id="b4b5v5"
BrowserRouter
      ↓
Routes
      ↓
Pages
```

---

# ⚠️ Common Mistakes

## 1. Forgetting to provide router context

For example:

```jsx id="f7xgkp"
<Link to="/about">
  About
</Link>
```

If the component isn't inside a router context, React Router will throw an error.

---

## 2. Nesting routers unnecessarily

Avoid randomly doing:

```jsx id="2a0b0j"
<BrowserRouter>
  <BrowserRouter>
    <App />
  </BrowserRouter>
</BrowserRouter>
```

Normally, you establish one appropriate router context for the application.

---

## 3. Forgetting SPA server fallback

Your application may work when clicking links but fail when refreshing a nested URL such as:

```text id="7m0l8h"
/products/101
```

That's often a **deployment/server configuration issue**, not a React component issue.

---

## 4. Using HashRouter without understanding the trade-off

Hash routing can be useful in certain hosting environments, but it produces URLs such as:

```text id="n9x0v2"
/#/products
```

For many modern web applications, `BrowserRouter` is preferred when proper server configuration is available.

---

# ⭐ Interview Questions

### Q1. What is BrowserRouter?

**Answer:**

`BrowserRouter` is a React Router component that provides routing context and uses the browser's history and location APIs to enable client-side routing for web applications.

---

### Q2. Why do we use BrowserRouter?

To enable React Router features such as:

```text id="avl6od"
Routes
Route
Link
NavLink
useNavigate
useLocation
```

within the application.

---

### Q3. What happens when the URL changes?

React Router detects the location change, matches the URL against the configured routes, and renders the corresponding route element.

---

### Q4. BrowserRouter vs HashRouter?

**BrowserRouter:**

```text id="f5b8je"
/products
```

**HashRouter:**

```text id="44k8tp"
/#/products
```

BrowserRouter provides cleaner URLs but typically requires appropriate server fallback configuration.

---

### Q5. Why can refreshing `/products` cause a 404?

Because a refresh makes the browser request `/products` from the server. If the server isn't configured to serve the React application's entry point for that route, it may return 404.

---

### Q6. What is `basename`?

`basename` defines the base URL path under which the application is hosted.

Example:

```jsx id="19jz1u"
<BrowserRouter basename="/admin">
```

A route:

```jsx id="7z9r42"
<Route path="/users" element={<Users />} />
```

can correspond to:

```text id="5a9z83"
/admin/users
```

---

# ⭐ Remember

```text id="7gk7zn"
Browser
   ↓
Current URL
   ↓
BrowserRouter
   ↓
Routes
   ↓
Route matching
   ↓
React Component
```

### One-line interview answer:

> **BrowserRouter provides the routing context for a React web application and uses the browser's History API to support clean, client-side URL navigation without full page reloads.**
