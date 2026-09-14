# 11 — `children` Prop

## WHY?

### Why do we use `children`?

Sometimes we want to create a reusable component that controls the **structure or styling**, while allowing the parent component to decide **what content goes inside it**.

For example, instead of creating separate components for:

```text
Product Card
Profile Card
Message Card
Notification Card
```

we can create one reusable `Card` component.

```jsx
<Card>
  <h2>Laptop</h2>
  <p>₹50,000</p>
</Card>
```

The `Card` controls the container, while the parent controls the content.

---

# WHAT?

## What is `children`?

`children` is a **special React prop** that represents whatever is placed between a component's opening and closing tags.

Example:

```jsx
<Card>
  <h2>Hello</h2>
</Card>
```

The content:

```jsx
<h2>Hello</h2>
```

is available inside `Card` as:

```jsx
children
```

---

# Basic Example

### Parent

```jsx
function App() {
  return (
    <Card>
      <h2>Hello Yash</h2>
      <p>Welcome to React</p>
    </Card>
  );
}
```

### Child

```jsx
function Card({ children }) {
  return (
    <div className="card">
      {children}
    </div>
  );
}
```

The result is conceptually:

```text
App
 ↓
Card
 ↓
children
 ├── <h2>Hello Yash</h2>
 └── <p>Welcome to React</p>
```

---

# WHERE?

`children` is especially useful for **wrapper/container components**.

Common examples:

```text
Card
Modal
Layout
Panel
Dialog
Container
Navbar
Sidebar
Form
```

For example:

```jsx
<Modal>
  <LoginForm />
</Modal>
```

The `Modal` controls the modal structure, while `LoginForm` becomes its children.

---

# HOW?

## How does `children` work?

Consider:

```jsx
<Card>
  <h1>Product</h1>
</Card>
```

React passes the content inside `Card` through the `children` prop.

Conceptually:

```text
<Card>
   │
   └── children
        │
        └── <h1>Product</h1>
```

The component receives it:

```jsx
function Card({ children }) {
  return (
    <div>
      {children}
    </div>
  );
}
```

---

# Children Can Contain Multiple Elements

```jsx
<Card>
  <h2>Laptop</h2>
  <p>₹50,000</p>
  <button>Buy Now</button>
</Card>
```

Component:

```jsx
function Card({ children }) {
  return (
    <div className="card">
      {children}
    </div>
  );
}
```

All three elements are passed as children.

```text
children
 ├── h2
 ├── p
 └── button
```

---

# Children Can Be Text

It doesn't have to be JSX elements.

```jsx
<Button>
  Login
</Button>
```

Component:

```jsx
function Button({ children }) {
  return (
    <button>
      {children}
    </button>
  );
}
```

Output:

```text
[ Login ]
```

---

# Children Can Be Another Component

```jsx
<Layout>
  <Dashboard />
</Layout>
```

Here:

```text
Layout
  ↓
children
  ↓
Dashboard
```

Component:

```jsx
function Layout({ children }) {
  return (
    <div>
      <Navbar />

      <main>
        {children}
      </main>

      <Footer />
    </div>
  );
}
```

Now:

```jsx
function App() {
  return (
    <Layout>
      <Dashboard />
    </Layout>
  );
}
```

The final structure is:

```text
Layout
│
├── Navbar
├── Dashboard ← children
└── Footer
```

---

# WHY IS THIS POWERFUL?

Suppose we have five pages:

```text
Home
Products
Orders
Profile
Settings
```

All pages need the same layout:

```text
Navbar
Sidebar
Content
Footer
```

Instead of repeating the layout:

```jsx
function Home() {
  // Navbar
  // Sidebar
  // Footer
}

function Products() {
  // Navbar
  // Sidebar
  // Footer
}
```

Create one layout:

```jsx
function Layout({ children }) {
  return (
    <>
      <Navbar />

      <div className="content">
        <Sidebar />

        <main>
          {children}
        </main>
      </div>

      <Footer />
    </>
  );
}
```

Now:

```jsx
<Layout>
  <Home />
</Layout>
```

and:

```jsx
<Layout>
  <Products />
</Layout>
```

The layout is reused.

---

# Children vs Normal Props

This distinction is important.

## Normal Props

```jsx
<User
  name="Yash"
  age={22}
/>
```

Component:

```jsx
function User({ name, age }) {
  return (
    <div>
      <h2>{name}</h2>
      <p>{age}</p>
    </div>
  );
}
```

Data is explicitly named:

```text
name
age
```

---

## Children

```jsx
<Card>
  <h2>Product</h2>
</Card>
```

The content is automatically available as:

```text
children
```

---

# Practical Example — Reusable Card

### `Card.jsx`

```jsx
function Card({ children }) {
  return (
    <div className="card">
      {children}
    </div>
  );
}

export default Card;
```

### `App.jsx`

```jsx
import Card from "./Card";

function App() {
  return (
    <div>
      <Card>
        <h2>Laptop</h2>
        <p>₹50,000</p>
      </Card>

      <Card>
        <h2>Phone</h2>
        <p>₹30,000</p>
      </Card>

      <Card>
        <h2>Headphones</h2>
        <p>₹5,000</p>
      </Card>
    </div>
  );
}
```

One component:

```text
Card
```

is used for multiple types of content.

---

# HOW TO COMBINE `children` WITH OTHER PROPS?

You can use both.

```jsx
<Card title="Laptop">
  <p>₹50,000</p>
</Card>
```

Component:

```jsx
function Card({ title, children }) {
  return (
    <div className="card">
      <h2>{title}</h2>

      <div>
        {children}
      </div>
    </div>
  );
}
```

Here:

```text
title
  ↓
Normal prop

children
  ↓
Nested content
```

---

# WHEN?

## When should I use `children`?

Use `children` when:

### 1. A component acts as a wrapper

```jsx
<Card>
  ...
</Card>
```

### 2. The component controls layout

```jsx
<Layout>
  <Dashboard />
</Layout>
```

### 3. The content needs to be flexible

```jsx
<Modal>
  <LoginForm />
</Modal>
```

### 4. You want to avoid creating many similar wrapper components

```jsx
<Panel>
  <UserList />
</Panel>

<Panel>
  <OrderList />
</Panel>
```

---

# When NOT to Use `children`

If the component needs specific, named data, normal props are often clearer.

For example:

```jsx
<User
  name="Yash"
  age={22}
  role="Developer"
/>
```

is clearer than trying to put all of that into `children`.

---

# Practical Real-World Example — Modal

```jsx
function Modal({ children }) {
  return (
    <div className="modal">
      <div className="modal-content">
        {children}
      </div>
    </div>
  );
}
```

Use:

```jsx
<Modal>
  <h2>Login</h2>

  <input type="email" />

  <input type="password" />

  <button>
    Login
  </button>
</Modal>
```

The modal doesn't need to know what content it contains.

It only provides the structure.

```text
Modal
│
└── children
    ├── Login heading
    ├── Email input
    ├── Password input
    └── Login button
```

---

# Interview Questions

### Q1. What is `children` in React?

> `children` is a special prop containing the content placed between a component's opening and closing tags.

---

### Q2. Is `children` a normal prop?

Technically, yes—it is passed as a prop, but React automatically provides it based on nested JSX.

---

### Q3. What is the benefit of `children`?

> It allows a component to control its structure or layout while allowing the parent to provide flexible content.

---

### Q4. Can `children` contain another component?

Yes.

```jsx
<Layout>
  <Dashboard />
</Layout>
```

---

### Q5. Can `children` contain multiple elements?

Yes.

```jsx
<Card>
  <h2>Product</h2>
  <p>Price</p>
  <button>Buy</button>
</Card>
```

---

### Q6. What is the difference between props and children?

> Props are named inputs passed to a component, while `children` specifically represents the nested content placed inside the component.

---

# Remember

```text
<Card>
   ↓
children
   ↓
Everything inside Card
```

```jsx
function Card({ children }) {
  return (
    <div className="card">
      {children}
    </div>
  );
}
```

### One-line interview answer

> **`children` is a special React prop that allows a component to receive and render arbitrary nested content, making wrapper, layout, and container components highly reusable.**
