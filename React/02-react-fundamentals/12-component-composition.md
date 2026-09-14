# 12 — Component Composition

## WHY?

### Why do we use Component Composition?

A real React application can contain hundreds of UI elements.

If we create one huge component for everything, it becomes difficult to:

* Understand
* Reuse
* Maintain
* Test
* Modify

Instead, we create **small components** and combine them to build larger UI.

This process is called **Component Composition**.

### Basic idea

```text
Small Components
      ↓
Combine
      ↓
Larger Component
      ↓
Complete Application
```

---

# WHAT?

## What is Component Composition?

Component composition means **building a larger component or UI by combining smaller components**.

For example:

```text
Application
│
├── Navbar
├── Sidebar
├── MainContent
│   ├── ProductCard
│   ├── ProductCard
│   └── ProductCard
└── Footer
```

Instead of implementing everything inside `Application`, we compose it from smaller components.

---

# WHERE?

Composition is used everywhere in React.

### Website layout

```text
Layout
├── Header
├── Sidebar
├── Content
└── Footer
```

### E-commerce

```text
ProductPage
├── ProductImage
├── ProductDetails
├── Price
├── AddToCart
└── Reviews
```

### Dashboard

```text
Dashboard
├── Navbar
├── Statistics
├── Chart
├── RecentOrders
└── UserList
```

---

# HOW?

## Basic Component Composition

Create small components:

```jsx
function Header() {
  return <header>Header</header>;
}
```

```jsx
function Content() {
  return <main>Content</main>;
}
```

```jsx
function Footer() {
  return <footer>Footer</footer>;
}
```

Now combine them:

```jsx
function App() {
  return (
    <>
      <Header />
      <Content />
      <Footer />
    </>
  );
}
```

Here:

```text
App
│
├── Header
├── Content
└── Footer
```

This is component composition.

---

# Composition Using `children`

One of the most useful patterns is using `children`.

Create a reusable layout:

```jsx
function Layout({ children }) {
  return (
    <div>
      <Header />

      <main>
        {children}
      </main>

      <Footer />
    </div>
  );
}
```

Now different pages can be placed inside it.

```jsx
function Home() {
  return <h1>Home Page</h1>;
}
```

Use:

```jsx
function App() {
  return (
    <Layout>
      <Home />
    </Layout>
  );
}
```

The structure becomes:

```text
Layout
│
├── Header
├── Home ← children
└── Footer
```

---

# WHY IS `children` IMPORTANT FOR COMPOSITION?

Suppose we have:

```jsx
<Layout>
  <Dashboard />
</Layout>
```

The `Layout` doesn't need to know what is inside.

It simply renders:

```jsx
{children}
```

Therefore, the same layout can be reused:

```jsx
<Layout>
  <Home />
</Layout>
```

```jsx
<Layout>
  <Dashboard />
</Layout>
```

```jsx
<Layout>
  <Profile />
</Layout>
```

One layout → many pages.

---

# Composition vs Creating One Huge Component

## ❌ Poor approach

```jsx
function Dashboard() {
  return (
    <div>
      {/* Navbar code */}

      {/* Sidebar code */}

      {/* Statistics code */}

      {/* Chart code */}

      {/* Table code */}

      {/* Notifications code */}

      {/* Footer code */}
    </div>
  );
}
```

As the application grows, this can become difficult to manage.

---

## ✅ Composition

```jsx
function Dashboard() {
  return (
    <Layout>
      <Statistics />
      <SalesChart />
      <RecentOrders />
      <Notifications />
    </Layout>
  );
}
```

Now each component has a clear responsibility.

---

# HOW TO COMPOSE COMPONENTS?

There are several common approaches.

## 1. Nesting Components

```jsx
function App() {
  return (
    <Dashboard>
      <UserList />
    </Dashboard>
  );
}
```

---

## 2. Using `children`

```jsx
function Card({ children }) {
  return (
    <div className="card">
      {children}
    </div>
  );
}
```

Use:

```jsx
<Card>
  <h2>Product</h2>
  <p>₹50,000</p>
</Card>
```

---

## 3. Passing Components as Props

A component can also be passed through a prop.

```jsx
function Layout({ sidebar }) {
  return (
    <div>
      {sidebar}

      <main>
        Content
      </main>
    </div>
  );
}
```

Use:

```jsx
<Layout
  sidebar={<Sidebar />}
/>
```

Conceptually:

```text
Layout
│
├── sidebar prop → Sidebar
└── Content
```

This gives the parent more control over what gets rendered.

---

# Practical Example — E-commerce

Suppose we need a product page.

Create:

```jsx
function ProductImage() {
  return <img src="/laptop.png" alt="Laptop" />;
}
```

```jsx
function ProductDetails() {
  return (
    <div>
      <h1>Laptop</h1>
      <p>₹50,000</p>
    </div>
  );
}
```

```jsx
function AddToCart() {
  return (
    <button>
      Add to Cart
    </button>
  );
}
```

Compose them:

```jsx
function ProductPage() {
  return (
    <div>
      <ProductImage />
      <ProductDetails />
      <AddToCart />
    </div>
  );
}
```

Component tree:

```text
ProductPage
│
├── ProductImage
├── ProductDetails
└── AddToCart
```

---

# Practical Example — Reusable Layout

### `Layout.jsx`

```jsx
function Layout({ children }) {
  return (
    <>
      <Navbar />

      <div className="layout">
        <Sidebar />

        <main>
          {children}
        </main>
      </div>

      <Footer />
    </>
  );
}

export default Layout;
```

### `Dashboard.jsx`

```jsx
function Dashboard() {
  return (
    <Layout>
      <h1>Dashboard</h1>

      <Statistics />

      <SalesChart />

      <RecentOrders />
    </Layout>
  );
}
```

### `Profile.jsx`

```jsx
function Profile() {
  return (
    <Layout>
      <h1>Profile</h1>

      <UserDetails />
    </Layout>
  );
}
```

Now:

```text
                 Layout
                   │
          ┌────────┴────────┐
          ↓                 ↓
     Dashboard            Profile
          │                 │
          ↓                 ↓
    Dashboard UI       Profile UI
```

The layout is reused.

---

# WHEN?

## When should I use Component Composition?

Use composition when:

### 1. You have reusable layouts

```jsx
<Layout>
  <Dashboard />
</Layout>
```

### 2. You have multiple related UI components

```jsx
<ProductPage>
  <ProductImage />
  <ProductDetails />
  <AddToCart />
</ProductPage>
```

### 3. You want flexible containers

```jsx
<Card>
  <Product />
</Card>
```

### 4. You want to avoid large components

Instead of:

```text
1000-line Dashboard
```

use:

```text
Dashboard
├── Header
├── Stats
├── Chart
└── Orders
```

### 5. Different pages share the same structure

```text
Layout
├── Header
├── Sidebar
├── children
└── Footer
```

---

# Composition vs Props

These concepts are related but different.

### Props

Used to pass data:

```jsx
<User
  name="Yash"
  age={22}
/>
```

### Composition

Used to combine components:

```jsx
<Layout>
  <Dashboard />
</Layout>
```

### Together

You can use both:

```jsx
<Card title="Laptop">
  <ProductDetails
    price={50000}
  />
</Card>
```

Here:

```text
title
 ↓
Normal prop

ProductDetails
 ↓
children
```

---

# Composition vs Inheritance

React generally favors **composition over inheritance** for sharing UI structure and behavior.

Instead of creating:

```text
BaseComponent
      ↓
ChildComponent
      ↓
AnotherChildComponent
```

React encourages composing components:

```text
Layout
  +
Navbar
  +
Sidebar
  +
Content
```

This often makes UI relationships easier to understand.

---

# Real-World Example

Consider a banking dashboard:

```text
BankingApp
│
└── DashboardLayout
    │
    ├── Navbar
    │
    ├── Sidebar
    │
    └── Content
        │
        ├── AccountSummary
        ├── TransactionList
        │   ├── Transaction
        │   ├── Transaction
        │   └── Transaction
        │
        └── PaymentForm
```

Each component handles a specific part.

The entire application is built through **composition**.

---

# Interview Questions

### Q1. What is component composition?

> Component composition is the practice of combining smaller React components to build larger and more complex UI.

---

### Q2. Why is composition useful?

> It improves reusability, flexibility, maintainability, and separation of responsibilities.

---

### Q3. How does `children` help with composition?

> `children` allows a component to provide a reusable structure while allowing the parent to control what content is rendered inside that structure.

---

### Q4. Can components be passed as props?

**Yes.**

```jsx
<Layout
  sidebar={<Sidebar />}
/>
```

---

### Q5. What is composition over inheritance?

> React generally encourages building reusable UI by combining components rather than creating deep inheritance hierarchies.

---

### Q6. Give a real-world example of composition.

```jsx
<Layout>
  <Navbar />
  <Dashboard />
  <Footer />
</Layout>
```

A larger UI is created by combining smaller components.

---

# Remember

```text
Component Composition
        ↓
Small Components
        ↓
Combine
        ↓
Larger Components
        ↓
Complete Application
```

### Most important pattern

```jsx
function Layout({ children }) {
  return (
    <>
      <Navbar />

      <main>
        {children}
      </main>

      <Footer />
    </>
  );
}
```

Usage:

```jsx
<Layout>
  <Dashboard />
</Layout>
```

### One-line interview answer

> **Component composition is the React pattern of combining small, reusable components—often using `children` or component props—to build flexible and maintainable larger UI structures.**
