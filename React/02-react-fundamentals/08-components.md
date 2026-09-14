# 08 — React Components

## WHY?

### Why do we use Components?

A large application cannot be efficiently maintained as one huge block of UI code.

For example, an e-commerce application may contain:

```text
Navbar
SearchBar
ProductCard
Cart
LoginForm
Footer
```

Instead of writing everything inside one component, we divide the application into smaller pieces.

```text
Application
    │
    ├── Navbar
    ├── SearchBar
    ├── ProductList
    │      └── ProductCard
    ├── Cart
    └── Footer
```

This gives us:

* **Reusability**
* **Maintainability**
* **Separation of responsibilities**
* **Easier debugging**
* **Easier testing**

---

# WHAT?

## What is a React Component?

A React component is a **reusable piece of UI**.

A simple component:

```jsx
function Welcome() {
  return <h1>Welcome to React</h1>;
}
```

Here:

```text
Welcome
   ↓
React Component
   ↓
Returns UI
```

A component can contain:

* JSX
* JavaScript logic
* Props
* State
* Event handlers
* Other components

---

# WHERE?

Components can represent almost any part of an application's UI.

### Small components

```text
Button
Input
Card
Icon
```

### Medium components

```text
Navbar
LoginForm
ProductCard
SearchBar
```

### Large components

```text
Dashboard
ProductPage
UserProfile
CheckoutPage
```

---

# HOW?

## How do we create a component?

Create a JavaScript function:

```jsx
function Button() {
  return <button>Click Me</button>;
}
```

Then export it:

```jsx
export default Button;
```

---

## How do we use a component?

Import it:

```jsx
import Button from "./Button";
```

Then use it like an HTML element:

```jsx
function App() {
  return (
    <div>
      <Button />
    </div>
  );
}
```

The complete flow is:

```text
Button.jsx
    ↓
export Button
    ↓
import Button
    ↓
<App />
    ↓
<Button />
    ↓
React renders Button UI
```

---

# Component Naming

React component names should normally start with an **uppercase letter**.

✅ Correct:

```jsx
function UserProfile() {
  return <h1>User Profile</h1>;
}
```

❌ Avoid:

```jsx
function userProfile() {
  return <h1>User Profile</h1>;
}
```

Why?

Because React uses capitalization to distinguish user-defined components from built-in HTML elements.

```jsx
<UserProfile />
```

means a React component.

```jsx
<div />
```

means an HTML element.

---

# Component Reusability

## WHY is reusability important?

Suppose we need three buttons:

```text
Login
Register
Buy Now
```

Instead of creating three separate button implementations, create one reusable component.

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

One component → multiple uses.

---

# Components with Props

Components can receive data using props.

```jsx
function User({ name }) {
  return <h2>Hello {name}</h2>;
}
```

Use it:

```jsx
<User name="Yash" />
```

React passes:

```text
name = "Yash"
```

to the component.

Output:

```text
Hello Yash
```

---

# Components with Multiple Props

```jsx
function Student({ name, age, course }) {
  return (
    <div>
      <h2>{name}</h2>
      <p>Age: {age}</p>
      <p>Course: {course}</p>
    </div>
  );
}
```

Use:

```jsx
<Student
  name="Yash"
  age={22}
  course="Computer Science"
/>
```

---

# Components Can Contain Components

A component can render another component.

```jsx
function Header() {
  return <header>My Website</header>;
}

function Content() {
  return <main>Welcome</main>;
}

function App() {
  return (
    <>
      <Header />
      <Content />
    </>
  );
}
```

The relationship is:

```text
App
│
├── Header
│
└── Content
```

This is one of the fundamental ideas behind React's component-based architecture.

---

# Parent and Child Components

Consider:

```jsx
function Parent() {
  return <Child />;
}

function Child() {
  return <h2>Hello</h2>;
}
```

Here:

```text
Parent
  ↓
Child
```

`Parent` is the **parent component**.

`Child` is the **child component**.

---

# Practical Example — Product Card

Instead of writing a product UI repeatedly:

```jsx
function ProductCard({ name, price, image }) {
  return (
    <div className="product-card">
      <img src={image} alt={name} />

      <h2>{name}</h2>

      <p>₹{price}</p>

      <button>
        Add to Cart
      </button>
    </div>
  );
}
```

Now reuse it:

```jsx
function App() {
  return (
    <div>
      <ProductCard
        name="Laptop"
        price={50000}
        image="/laptop.png"
      />

      <ProductCard
        name="Phone"
        price={30000}
        image="/phone.png"
      />
    </div>
  );
}
```

Conceptually:

```text
App
│
├── ProductCard
│     ├── Laptop
│     └── ₹50,000
│
└── ProductCard
      ├── Phone
      └── ₹30,000
```

The structure is reused; the data changes.

---

# HOW SHOULD WE DECIDE COMPONENTS?

A good rule is:

> **If a piece of UI has a clear responsibility or needs to be reused, it is a candidate for a component.**

For example:

```text
Dashboard
│
├── Navbar
├── Sidebar
├── StatisticsCard
├── SalesChart
├── RecentOrders
└── Footer
```

Instead of:

```jsx
function Dashboard() {
  // 1000 lines of UI
}
```

we can create:

```jsx
function Dashboard() {
  return (
    <>
      <Navbar />
      <Sidebar />
      <StatisticsCard />
      <SalesChart />
      <RecentOrders />
      <Footer />
    </>
  );
}
```

---

# WHEN?

## When should I create a component?

Create a component when:

### 1. UI is reused

```jsx
<Button />
<Button />
<Button />
```

### 2. UI has a clear responsibility

```text
LoginForm
Navbar
ProductCard
```

### 3. A component becomes too large

If `App.jsx` contains hundreds of lines, some sections can be extracted.

### 4. A section has its own logic

For example:

```text
SearchBar
```

can manage search-related UI and behavior.

### 5. Multiple developers need to work independently

Separating components makes large projects easier to work on.

---

# When NOT to Create a Component

Don't split every single HTML element into its own component.

This:

```jsx
<Title />
<Text />
<SmallText />
<Div />
```

may create unnecessary complexity.

Instead, group related UI logically.

---

# Component Tree

React applications can be visualized as a component tree.

Example:

```text
                    App
                     │
          ┌──────────┼──────────┐
          ↓          ↓          ↓
       Navbar     Sidebar    Footer
                     │
                     ↓
                 Dashboard
                     │
            ┌────────┼────────┐
            ↓        ↓        ↓
          Card     Chart     Table
```

This tree helps us understand how UI is composed.

---

# Practical Mini Project

Let's create a simple profile page.

### `Profile.jsx`

```jsx
function Profile({ name, role }) {
  return (
    <div>
      <h1>{name}</h1>
      <p>{role}</p>
    </div>
  );
}

export default Profile;
```

### `App.jsx`

```jsx
import Profile from "./Profile";

function App() {
  return (
    <div>
      <Profile
        name="Yash"
        role="Software Developer"
      />

      <Profile
        name="Rahul"
        role="Data Analyst"
      />
    </div>
  );
}

export default App;
```

One component is reused for multiple users.

---

# Interview Questions

### Q1. What is a React component?

> A React component is a reusable piece of UI that is typically represented by a JavaScript function returning React elements.

### Q2. Why are components used?

> To divide an application into reusable, maintainable and logically separated UI pieces.

### Q3. Can a component render another component?

**Yes.**

```jsx
function App() {
  return <Navbar />;
}
```

### Q4. Why should component names start with uppercase?

> React uses capitalization to distinguish custom components from built-in HTML elements.

### Q5. Can components receive data?

**Yes, through props.**

```jsx
<User name="Yash" />
```

### Q6. Can components have their own state?

**Yes.**

```jsx
const [count, setCount] = useState(0);
```

### Q7. What is a component tree?

> A component tree represents the hierarchical relationship between React components in an application.

---

# Remember

```text
Component
    ↓
Reusable UI
    ↓
Can receive Props
    ↓
Can have State
    ↓
Can contain other Components
    ↓
Forms Component Tree
```

### One-line interview answer

> **A React component is a reusable and composable UI building block that can receive data through props, maintain state when needed, and render other components.**
