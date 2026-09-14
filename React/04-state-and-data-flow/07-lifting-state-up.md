# 07 — Lifting State Up

## WHY?

Sometimes **two or more components need to use the same changing data**.

For example:

```text
App
├── TemperatureInput
└── TemperatureDisplay
```

Suppose `TemperatureInput` has the temperature:

```text
25°C
```

and `TemperatureDisplay` also needs to know that temperature.

If the state exists only inside `TemperatureInput`, the sibling component cannot directly access it.

The solution is:

> **Move the shared state to their closest common parent.**

This is called **lifting state up**.

---

# WHAT?

**Lifting state up** means moving state from a child component to a common parent so that multiple components can share and coordinate that state.

Example:

```text
Before:

Parent
 ├── Child A
 │     └── state
 │
 └── Child B
```

If Child B also needs that state:

```text
After:

          Parent
        ┌───────┐
        │ state │
        └───┬───┘
          /   \
         ↓     ↓
     Child A Child B
```

The parent becomes the **source of truth**.

---

# WHERE?

Lifting state up is commonly used when:

* Sibling components need the same state
* Multiple components need to stay synchronized
* One component changes data that another component displays
* A parent needs control over child data
* Forms have multiple related inputs
* Tabs, filters, and selections affect multiple components

---

# HOW?

## Step 1 — Identify the shared state

Suppose we have:

```jsx id="f4u5bp"
TemperatureInput
TemperatureDisplay
```

Both need:

```text
temperature
```

---

## Step 2 — Find the common parent

Suppose:

```text id="2ydgmi"
App
├── TemperatureInput
└── TemperatureDisplay
```

The common parent is:

```text id="7x3s0a"
App
```

---

## Step 3 — Move the state to the parent

```jsx id="d1oq8h"
function App() {
  const [temperature, setTemperature] = useState("");

  return (
    <>
      <TemperatureInput
        temperature={temperature}
        onTemperatureChange={setTemperature}
      />

      <TemperatureDisplay
        temperature={temperature}
      />
    </>
  );
}
```

Now:

```text id="v2t9fo"
App
 │
 ├── temperature
 ├── setTemperature
 │
 ├── TemperatureInput
 │
 └── TemperatureDisplay
```

---

# Step 4 — Pass State as Props

Input receives:

```jsx id="v1dr25"
<TemperatureInput
  temperature={temperature}
  onTemperatureChange={setTemperature}
/>
```

Display receives:

```jsx id="lq5vvp"
<TemperatureDisplay
  temperature={temperature}
/>
```

So the parent owns the state.

---

# Step 5 — Child Requests an Update

The child doesn't directly modify the parent's state.

Instead, the parent passes a callback:

```jsx id="s2jyh9"
onTemperatureChange={setTemperature}
```

The child calls it:

```jsx id="x8cuw8"
function TemperatureInput({
  temperature,
  onTemperatureChange
}) {
  return (
    <input
      value={temperature}
      onChange={event =>
        onTemperatureChange(event.target.value)
      }
    />
  );
}
```

Flow:

```text id="g4qk22"
User types
    ↓
TemperatureInput
    ↓
onTemperatureChange(value)
    ↓
Parent updates state
    ↓
App re-renders
    ↓
New props sent to children
    ↓
TemperatureDisplay updates
```

---

# Complete Example

```jsx id="c4b7bf"
import { useState } from "react";

function App() {
  const [temperature, setTemperature] = useState("");

  return (
    <div>
      <TemperatureInput
        temperature={temperature}
        onTemperatureChange={setTemperature}
      />

      <TemperatureDisplay
        temperature={temperature}
      />
    </div>
  );
}

function TemperatureInput({
  temperature,
  onTemperatureChange
}) {
  function handleChange(event) {
    onTemperatureChange(event.target.value);
  }

  return (
    <input
      value={temperature}
      onChange={handleChange}
      placeholder="Enter temperature"
    />
  );
}

function TemperatureDisplay({ temperature }) {
  return (
    <h2>
      Temperature: {temperature}°C
    </h2>
  );
}

export default App;
```

Now both components stay synchronized.

---

# Why Does the Parent Own the State?

Because the parent is the common ancestor.

```text id="ly4d5f"
             App
              │
       temperature state
          /          \
         ↓            ↓
    Input          Display
```

The parent controls the data.

The children:

* **receive data**
* **display data**
* **request changes**

---

# Important Pattern

This pattern appears everywhere in React:

```text id="3b7f4k"
Parent
   │
   ├── state
   │
   ├── ↓ props
   │
   └── Child
          │
          └── callback()
                 ↓
              Parent
                 ↓
            state update
```

This is often described as:

> **Data flows down, events flow up.**

### Data flows down

```jsx id="9e1a0j"
<Child value={value} />
```

### Events/actions flow up

```jsx id="a7z9j8"
<Child onChange={handleChange} />
```

---

# Practical Example — Synchronized Inputs

Suppose you have:

```text id="p1k1e3"
App
├── FirstNameInput
├── LastNameInput
└── Preview
```

All three need related information.

Keep the state in `App`:

```jsx id="6z1x3g"
function App() {
  const [firstName, setFirstName] = useState("");
  const [lastName, setLastName] = useState("");

  return (
    <>
      <FirstNameInput
        value={firstName}
        onChange={setFirstName}
      />

      <LastNameInput
        value={lastName}
        onChange={setLastName}
      />

      <Preview
        firstName={firstName}
        lastName={lastName}
      />
    </>
  );
}
```

Now:

```text id="y8b6jq"
firstName ──────┐
                ↓
             Preview

lastName ───────┘
```

---

# Practical Example — Tabs

Suppose:

```text id="3e9y9x"
App
├── TabButtons
└── TabContent
```

Both need to know which tab is selected.

Keep:

```jsx id="mb1e0u"
const [activeTab, setActiveTab] = useState("home");
```

in the parent.

```jsx id="d7eml2"
function App() {
  const [activeTab, setActiveTab] = useState("home");

  return (
    <>
      <TabButtons
        activeTab={activeTab}
        onTabChange={setActiveTab}
      />

      <TabContent
        activeTab={activeTab}
      />
    </>
  );
}
```

Now:

```text id="q0r9xj"
              App
               │
          activeTab
          /       \
         ↓         ↓
 TabButtons     TabContent
    │
    └── onTabChange()
             ↓
            App
```

---

# Practical Example — Accordion

Suppose you have:

```text id="l9c7td"
Accordion
├── Panel 1
├── Panel 2
└── Panel 3
```

If only one panel should be open at a time, the state should generally be controlled at the accordion level:

```jsx id="s6bq7s"
const [openPanel, setOpenPanel] = useState(null);
```

Then:

```jsx id="i0rc7h"
<Panel
  isOpen={openPanel === 1}
  onOpen={() => setOpenPanel(1)}
/>
```

Another:

```jsx id="9z5b0b"
<Panel
  isOpen={openPanel === 2}
  onOpen={() => setOpenPanel(2)}
/>
```

The parent can enforce the rule:

```text
Only one panel → one shared state
```

---

# Lifting State vs Prop Drilling

These concepts are related but **not identical**.

### Lifting state up

Means:

> Move state to a common parent so multiple components can share it.

### Prop drilling

Means:

> Passing props through components that don't actually need the data, just so a deeper component can receive it.

Example:

```text id="d3i5uc"
App
 ↓
A
 ↓
B
 ↓
C
 ↓
D
```

If `D` needs the state from `App`:

```text id="fzuyh7"
App
 ↓ props
A
 ↓ props
B
 ↓ props
C
 ↓ props
D
```

That's prop drilling.

We'll cover it in the next relevant topic.

---

# Don't Lift State Too High

Lifting state up is useful, but **don't automatically move every piece of state to the top of the application**.

For example:

```jsx id="9b1k0s"
function SearchBox() {
  const [text, setText] = useState("");
}
```

If only `SearchBox` needs `text`, keep it there.

Don't unnecessarily move it to:

```text id="e4h4o9"
App
```

The general principle is:

> **Keep state as close as possible to the components that need it, while keeping it high enough for all required consumers to access it.**

---

# Example — Good State Placement

Suppose:

```text id="k3n5l2"
App
├── Navbar
├── ProductList
│    ├── Product
│    └── Product
└── Footer
```

If only `ProductList` needs:

```jsx id="0ycm66"
const [selectedProduct, setSelectedProduct] = useState(null);
```

keep it in `ProductList`.

Don't put it in `App` unless another part of the application also needs it.

---

# WHEN?

Lift state up when:

### 1. Sibling components need the same state

```text
A ← shared state → B
```

Move it to their parent.

---

### 2. One component changes data another displays

```text
Input → Parent State → Display
```

---

### 3. Components need to stay synchronized

For example:

```text
Tab buttons
      ↕
Tab content
```

---

### 4. A parent needs to control a child

Keep the state in the parent and pass:

```jsx id="0v5clb"
value
```

and:

```jsx id="zlf3d6"
onChange
```

to the child.

---

# Common Mistakes

## ❌ Mistake 1 — Keeping duplicate state in siblings

```text id="glf9a5"
Child A
  state = 10

Child B
  state = 10
```

Now you have two sources of truth.

### ✅ Better

```text id="1y5p3e"
Parent
  state = 10
   /   \
  ↓     ↓
 A       B
```

---

## ❌ Mistake 2 — Updating parent state directly from child

A child should not directly access the parent's state setter unless the parent explicitly passes the setter/callback.

### ✅

Parent:

```jsx id="pm3p5t"
<Child onChange={setValue} />
```

Child:

```jsx id="4h1y9u"
onChange(newValue);
```

---

## ❌ Mistake 3 — Lifting everything to `App`

Don't do this:

```text id="n4slz3"
App
├── modal state
├── input state
├── dropdown state
├── local animation state
├── tooltip state
├── ...
```

if these values are only needed locally.

Keep state close to where it's used.

---

## ❌ Mistake 4 — Creating two sources of truth

Avoid:

```jsx id="c6q7y1"
Parent: selectedTab
Child: selectedTab
```

Instead, generally have one authoritative state value and pass it down.

---

# Interview Questions

### 1. What is lifting state up?

> Lifting state up means moving shared state to the closest common parent of the components that need to access or modify it.

---

### 2. Why do we lift state up?

To allow multiple components to share the same state and maintain a **single source of truth**.

---

### 3. How does data flow after lifting state?

Typically:

```text id="8d1j8p"
Parent State
     ↓
Props
     ↓
Child
     ↓
Callback
     ↑
Parent
```

In simple terms:

> **Data flows down; events/actions flow up.**

---

### 4. Should all state be lifted to the top-level component?

No.

State should generally be kept at the **lowest common ancestor that needs to coordinate it**.

---

### 5. What is the difference between lifting state and prop drilling?

**Lifting state** determines *where the state should live*.

**Prop drilling** describes *passing props through intermediate components* to reach a deeply nested component.

---

### 6. How can a child update state owned by its parent?

The parent can pass a callback:

```jsx id="7f7ph0"
<Child onChange={setValue} />
```

The child calls:

```jsx id="lq9j6c"
onChange(newValue);
```

---

# ⭐ Remember

The most important diagram:

```text id="zzd4r5"
              Parent
           ┌────┴────┐
           │  State  │
           └────┬────┘
              /   \
             ↓     ↓
          Child A Child B
             │
             │ callback
             └──────────→ Parent
```

### Golden rule

> **If multiple components need the same changing data, keep that data in their closest common parent.**

And remember:

```text id="x4ud5j"
DATA
 ↓
Parent → Child

EVENT / ACTION
 ↑
Child → Parent
```

### One-line interview answer

> **Lifting state up is the React pattern of moving shared state to the closest common parent so multiple components can use the same source of truth through props and callbacks.**
