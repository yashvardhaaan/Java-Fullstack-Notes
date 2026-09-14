# 10 — Props

## WHY?

### Why do we need Props?

In React, components are designed to be **independent and reusable**.

But a reusable component often needs different data each time it is used.

For example, we may have one `StudentCard` component, but different students:

```text
StudentCard
   ↓
Yash
Rahul
Amit
```

Instead of creating three different components, we pass the required data using **props**.

---

# WHAT?

## What are Props?

**Props** stands for **Properties**.

Props are data passed from a **parent component to a child component**.

Example:

```jsx
<Student name="Yash" />
```

Here:

```text
name = "Yash"
```

is a prop.

The child receives it:

```jsx
function Student({ name }) {
  return <h2>{name}</h2>;
}
```

Output:

```text
Yash
```

---

# Basic Props Flow

```text
Parent Component
       │
       │ props
       ↓
Child Component
       │
       ↓
      JSX
       │
       ↓
      UI
```

Example:

```jsx
function App() {
  return <Student name="Yash" />;
}
```

```jsx
function Student({ name }) {
  return <h1>{name}</h1>;
}
```

---

# WHERE?

Props are used whenever one component needs to provide data or configuration to another component.

Common examples:

```text
Parent
  ↓
ProductCard
  ↓
Product information

Parent
  ↓
UserProfile
  ↓
User information

Parent
  ↓
Button
  ↓
Button text / behavior
```

---

# HOW?

## Step 1 — Parent sends props

```jsx
function App() {
  return (
    <Student
      name="Yash"
      age={22}
    />
  );
}
```

The parent sends two props:

```text
name → "Yash"
age  → 22
```

---

## Step 2 — Child receives props

```jsx
function Student({ name, age }) {
  return (
    <div>
      <h2>{name}</h2>
      <p>Age: {age}</p>
    </div>
  );
}
```

Output:

```text
Yash
Age: 22
```

---

# Props Can Have Different Data Types

Props are not limited to strings.

## String

```jsx
<User name="Yash" />
```

---

## Number

Use `{}`:

```jsx
<User age={22} />
```

---

## Boolean

```jsx
<User isAdmin={true} />
```

or:

```jsx
<User isAdmin />
```

The second form means:

```text
isAdmin = true
```

---

## Array

```jsx
<User
  skills={["JavaScript", "React", "Python"]}
/>
```

Receive:

```jsx
function User({ skills }) {
  return (
    <p>
      {skills.join(", ")}
    </p>
  );
}
```

---

## Object

```jsx
<User
  user={{
    name: "Yash",
    age: 22
  }}
/>
```

Receive:

```jsx
function User({ user }) {
  return <h2>{user.name}</h2>;
}
```

---

## Function

A function can also be passed as a prop.

```jsx
function App() {
  function handleClick() {
    console.log("Clicked");
  }

  return <Button onClick={handleClick} />;
}
```

Child:

```jsx
function Button({ onClick }) {
  return (
    <button onClick={onClick}>
      Click
    </button>
  );
}
```

This is extremely important because it allows a child component to **notify or trigger behavior in the parent**.

---

# Props Are Read-Only

## WHY?

Props represent data provided by the parent.

The child should not directly modify the props it receives.

Example:

```jsx
function User({ name }) {
  // Don't modify name
}
```

❌ Don't do:

```jsx
name = "Rahul";
```

Instead, if the value needs to change, the appropriate state should generally be owned by the component responsible for changing it and passed down as needed.

---

# Props vs State

This is one of the most important React concepts.

| Props                            | State                              |
| -------------------------------- | ---------------------------------- |
| Passed into component            | Managed by component               |
| Comes from parent                | Usually created/managed internally |
| Read-only to receiving component | Can be updated using state setter  |
| Used to configure component      | Used for changing data/UI          |
| Parent → Child                   | Component-controlled               |

Example:

```jsx
function App() {
  const [count, setCount] = useState(0);

  return <Counter count={count} />;
}
```

Here:

```text
count
 ↓
State in App
 ↓
Prop to Counter
```

---

# Props and Reusability

Consider:

```jsx
function ProductCard({ name, price }) {
  return (
    <div>
      <h2>{name}</h2>
      <p>₹{price}</p>
    </div>
  );
}
```

We can reuse it:

```jsx
<ProductCard
  name="Laptop"
  price={50000}
/>

<ProductCard
  name="Phone"
  price={30000}
/>

<ProductCard
  name="Headphones"
  price={5000}
/>
```

Same component.

Different data.

```text
              ProductCard
                  │
       ┌──────────┼──────────┐
       ↓          ↓          ↓
    Laptop      Phone    Headphones
    ₹50,000     ₹30,000    ₹5,000
```

---

# HOW TO PASS PROPS THROUGH MULTIPLE COMPONENTS?

Suppose:

```text
App
 ↓
Dashboard
 ↓
UserCard
```

`App` has the user:

```jsx
function App() {
  const user = {
    name: "Yash",
    role: "Developer"
  };

  return <Dashboard user={user} />;
}
```

`Dashboard` receives it:

```jsx
function Dashboard({ user }) {
  return <UserCard user={user} />;
}
```

`UserCard` receives it:

```jsx
function UserCard({ user }) {
  return (
    <div>
      <h2>{user.name}</h2>
      <p>{user.role}</p>
    </div>
  );
}
```

Flow:

```text
App
 │
 │ user
 ↓
Dashboard
 │
 │ user
 ↓
UserCard
```

This is called **prop drilling** when data is passed through intermediate components that don't themselves need the data, especially across many levels.

Later, React applications may use Context or other state-management approaches when appropriate.

---

# Props with `children`

`children` is a special prop.

Example:

```jsx
<Card>
  <h2>Product</h2>
  <p>₹999</p>
</Card>
```

The `Card` component receives the content through `children`:

```jsx
function Card({ children }) {
  return (
    <div className="card">
      {children}
    </div>
  );
}
```

So:

```text
<Card>
   ↓
children prop
   ↓
<h2>Product</h2>
<p>₹999</p>
```

---

# Practical Example — Student Management

### Parent

```jsx
function App() {
  const students = [
    {
      id: 1,
      name: "Yash",
      course: "Computer Science"
    },
    {
      id: 2,
      name: "Rahul",
      course: "Data Science"
    }
  ];

  return (
    <div>
      {students.map(student => (
        <StudentCard
          key={student.id}
          name={student.name}
          course={student.course}
        />
      ))}
    </div>
  );
}
```

### Child

```jsx
function StudentCard({ name, course }) {
  return (
    <div className="student-card">
      <h2>{name}</h2>
      <p>{course}</p>
    </div>
  );
}
```

Here:

```text
students array
      ↓
App
      ↓
Props
      ↓
StudentCard
      ↓
UI
```

---

# WHEN?

## When should I use Props?

Use props when:

### 1. Parent needs to pass data to child

```jsx
<User name="Yash" />
```

### 2. You want to make a component reusable

```jsx
<Button text="Login" />
<Button text="Register" />
```

### 3. Component behavior depends on external data

```jsx
<Product
  name="Laptop"
  price={50000}
/>
```

### 4. Parent needs to provide a callback

```jsx
<Button onClick={handleLogin} />
```

---

# Practical Interview Scenario

### Question:

> You have a reusable `Button` component. How would you make its text configurable?

Answer:

```jsx
function Button({ children }) {
  return (
    <button>
      {children}
    </button>
  );
}
```

Then:

```jsx
<Button>Login</Button>

<Button>Register</Button>

<Button>Submit</Button>
```

---

# Interview Questions

### Q1. What are props?

> Props are inputs passed from a parent component to a child component to provide data or behavior.

### Q2. Are props mutable?

> Props should be treated as read-only by the receiving component.

### Q3. Can we pass a function as a prop?

**Yes.**

```jsx
<Button onClick={handleClick} />
```

### Q4. Can we pass objects and arrays as props?

**Yes.**

```jsx
<User data={user} />

<List items={items} />
```

### Q5. What is `children`?

> `children` is a special prop containing the content placed between a component's opening and closing tags.

### Q6. What is prop drilling?

> Prop drilling is passing data through multiple intermediate components to reach a deeply nested child, even when those intermediate components don't need the data themselves.

### Q7. Props vs State?

> Props are inputs received from a parent, while state is data managed by a component that can change over time.

---

# Remember

```text
Props
  ↓
Parent
  ↓
Child
  ↓
Read-only data
```

```jsx
<User
  name="Yash"
  age={22}
  isAdmin={true}
/>
```

### One-line interview answer

> **Props are read-only inputs passed from a parent component to a child component, allowing components to receive data, configuration, and callback functions while remaining reusable.**
