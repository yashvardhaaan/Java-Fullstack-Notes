# 04 — SPA and Component-Based UI

## WHY?

### Why do we use a Single Page Application (SPA)?

In a traditional website, navigating to another page can cause the browser to request and load a new HTML document.

For a modern application, this can make navigation feel slower and can require repeating common UI rendering.

An SPA allows the application to load the main application once and then update the required UI as the user interacts with it.

### Traditional Website

```text
User clicks Login
       ↓
Browser requests new HTML
       ↓
Server sends HTML
       ↓
Browser loads new page
```

### SPA

```text
User opens application
       ↓
React application loads
       ↓
User clicks Login
       ↓
React changes required UI
       ↓
No full-page reload
```

---

# WHAT?

## What is SPA?

SPA stands for **Single Page Application**.

It is a web application where the browser generally loads the application's main document once, while JavaScript changes the displayed content as the user navigates and interacts.

Examples of applications that can use SPA architecture:

```text
Dashboard
Admin Panel
E-commerce
Social Media
Banking Application
SaaS Application
```

---

# What is Component-Based UI?

Component-based UI means dividing an application's interface into **small, reusable components**.

For example:

```text
                Application
                    │
        ┌───────────┼───────────┐
        ↓           ↓           ↓
      Navbar      Sidebar     Footer
                    │
                    ↓
                Dashboard
                    │
          ┌─────────┼─────────┐
          ↓         ↓         ↓
       Card      Chart      Table
```

Each part can be implemented as a React component.

---

# WHERE?

## Where is SPA architecture useful?

SPAs are particularly useful for applications where users interact with the application continuously.

For example, an admin dashboard:

```text
Dashboard
   ↓
Users
   ↓
Products
   ↓
Orders
   ↓
Reports
```

The common application shell can remain while the relevant content changes.

---

## Where are components used?

Almost everywhere in a React application.

For example:

```text
src/
│
├── components/
│   ├── Navbar.jsx
│   ├── Button.jsx
│   ├── Card.jsx
│   └── Modal.jsx
│
├── pages/
│   ├── Home.jsx
│   ├── Login.jsx
│   └── Dashboard.jsx
│
└── App.jsx
```

---

# HOW?

## How does an SPA work?

A simplified flow:

```text
Browser
   ↓
index.html
   ↓
React application
   ↓
Components
   ↓
User interaction
   ↓
State / routing changes
   ↓
React updates UI
```

For example:

```text
User
 ↓
Clicks "Dashboard"
 ↓
Application determines dashboard view
 ↓
Dashboard component renders
 ↓
User sees Dashboard
```

The exact behavior depends on the routing and application architecture.

---

# Practical React Example

Suppose we have three components:

```jsx
function Navbar() {
  return <nav>My App</nav>;
}
```

```jsx
function Sidebar() {
  return (
    <aside>
      <p>Home</p>
      <p>Users</p>
      <p>Settings</p>
    </aside>
  );
}
```

```jsx
function Dashboard() {
  return <main>Dashboard Content</main>;
}
```

Now compose them:

```jsx
function App() {
  return (
    <>
      <Navbar />

      <div>
        <Sidebar />
        <Dashboard />
      </div>
    </>
  );
}

export default App;
```

The application is built by combining smaller components.

---

# Component Reusability

## WHY is reusability important?

Suppose your application needs 20 buttons.

Instead of writing the complete button UI 20 times, create one reusable component.

```jsx
function Button({ children }) {
  return (
    <button>
      {children}
    </button>
  );
}
```

Now:

```jsx
<Button>Login</Button>

<Button>Register</Button>

<Button>Buy Now</Button>
```

One component can be reused with different content.

---

# Component Composition

Components can also contain other components.

```jsx
function App() {
  return (
    <Layout>
      <Dashboard />
    </Layout>
  );
}
```

Conceptually:

```text
App
 │
 └── Layout
      │
      ├── Navbar
      │
      └── Dashboard
            │
            ├── Card
            ├── Chart
            └── Table
```

This is called **component composition**.

---

# SPA + Components Together

These two concepts work together.

Imagine an e-commerce application:

```text
                    React SPA
                       │
          ┌────────────┼────────────┐
          ↓            ↓            ↓
       Navbar       Sidebar       Footer
                       │
                       ↓
                   Products
                       │
             ┌─────────┼─────────┐
             ↓         ↓         ↓
           Card       Card       Card
             │
             ↓
       Product Details
             │
             ↓
            Cart
```

The SPA provides the overall application experience.

Components divide the UI into manageable pieces.

---

# WHEN?

## When should I use an SPA?

Consider SPA architecture when:

* The application has many interactive screens.
* Users frequently navigate between application sections.
* The application has significant client-side state.
* You want an app-like user experience.

Examples:

```text
✓ Admin dashboard
✓ Project management application
✓ SaaS application
✓ Webmail
✓ Interactive analytics application
```

---

## When might an SPA NOT be necessary?

For a very simple website:

```text
Home
About
Contact
```

A traditional multi-page website may be simpler and more appropriate.

You don't need React or an SPA architecture just because a website exists.

---

# Practical Example — Dashboard

Suppose you're building a company dashboard.

### Without components

You might end up with one huge file:

```jsx
function App() {
  // navbar code

  // sidebar code

  // user table code

  // chart code

  // notifications code

  // footer code
}
```

This becomes difficult to maintain.

### With components

```jsx
function App() {
  return (
    <>
      <Navbar />
      <Sidebar />
      <Dashboard />
      <Notifications />
      <Footer />
    </>
  );
}
```

Much easier to understand.

---

# Interview Questions

### Q1. What is SPA?

> SPA stands for Single Page Application. It is a web application where the main document is generally loaded once and the displayed UI is updated dynamically as the user interacts with the application.

---

### Q2. What is component-based architecture?

> It is an approach where an application's UI is divided into small, independent and reusable components.

---

### Q3. Why are components useful?

They provide:

* Reusability
* Maintainability
* Separation of responsibility
* Easier testing
* Easier development

---

### Q4. Is every React application an SPA?

**No.**

React can be used in different architectures, including applications that are not traditional SPAs.

---

### Q5. What is component composition?

> Component composition means combining smaller components to build larger and more complex UI.

Example:

```jsx
<Layout>
  <Navbar />
  <Dashboard />
</Layout>
```

---

# Remember

```text
SPA
 ↓
Application-level architecture
 ↓
One main application experience
 ↓
UI changes dynamically
```

```text
Components
 ↓
UI-level architecture
 ↓
Small reusable pieces
 ↓
Combined to build application
```

### One-line interview answer

> **SPA defines how the web application behaves as a single interactive application, while component-based architecture defines how its UI is divided into reusable building blocks.**
