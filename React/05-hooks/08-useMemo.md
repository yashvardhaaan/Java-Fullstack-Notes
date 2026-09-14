# 08 — `useMemo` Hook in React

## WHY?

React components can re-render many times.

Sometimes a component performs an **expensive calculation** during rendering:

```jsx
const result = expensiveCalculation(data);
```

If unrelated state changes, the component renders again and the calculation may run again even though `data` hasn't changed.

`useMemo` can cache the result of a calculation and reuse it until its dependencies change.

---

# WHAT?

### Definition

> **`useMemo` is a React Hook that lets you cache the result of a calculation between re-renders.**

Basic syntax:

```jsx
const cachedValue = useMemo(
  () => calculateValue(data),
  [data]
);
```

Think of it as:

```text
Calculation
     ↓
useMemo
     ↓
Cached result
     ↓
Reuse until dependency changes
```

---

# WHERE?

`useMemo` is used inside:

* Function components
* Custom Hooks

It is useful when:

* A calculation is expensive
* The calculation doesn't need to run on every render
* You have measured or reasonably identified a performance problem

---

# HOW?

## Basic Example

```jsx
import { useMemo } from "react";

function ProductList({ products }) {
  const expensiveResult = useMemo(() => {
    return calculateSomething(products);
  }, [products]);

  return <div>{expensiveResult}</div>;
}
```

The calculation:

```jsx
calculateSomething(products)
```

is recomputed when `products` changes.

If the component re-renders for another reason, React can reuse the cached result.

---

# Simple Example

Suppose:

```jsx
function App() {
  const [count, setCount] = useState(0);

  const result = useMemo(() => {
    console.log("Calculating...");

    return 100 * 100;
  }, []);

  return (
    <>
      <h1>{result}</h1>

      <button onClick={() => setCount(c => c + 1)}>
        Count: {count}
      </button>
    </>
  );
}
```

When `count` changes:

```text
count changes
    ↓
Component re-renders
    ↓
result can be reused
    ↓
expensive calculation doesn't need to run again
```

---

# Dependency Array

The dependency array is extremely important.

```jsx
const filteredProducts = useMemo(
  () => filterProducts(products, search),
  [products, search]
);
```

The calculation depends on:

```text
products
search
```

Therefore both should be dependencies.

---

# Practical Example — Filtering Products

Suppose you have thousands of products:

```jsx
function ProductList({ products, search }) {

  const filteredProducts = useMemo(() => {
    return products.filter(product =>
      product.name
        .toLowerCase()
        .includes(search.toLowerCase())
    );
  }, [products, search]);

  return (
    <ul>
      {filteredProducts.map(product => (
        <li key={product.id}>
          {product.name}
        </li>
      ))}
    </ul>
  );
}
```

Now:

```text
products changes
      ↓
Recalculate

search changes
      ↓
Recalculate

Other state changes
      ↓
Reuse cached result
```

---

# `useMemo` Does NOT Mean "No Re-render"

This is a common interview trap.

Suppose:

```jsx
const result = useMemo(
  () => expensiveCalculation(data),
  [data]
);
```

If some unrelated state changes:

```jsx
setCount(...)
```

the **component can still re-render**.

`useMemo` only caches the **calculation result**.

It does not prevent the component itself from rendering.

---

# `useMemo` vs `useCallback`

Very important.

## `useMemo`

Caches a **value**.

```jsx
const filtered = useMemo(
  () => filterProducts(products),
  [products]
);
```

Conceptually:

```text
function → result
           ↑
        useMemo
```

---

## `useCallback`

Caches a **function reference**.

```jsx
const handleClick = useCallback(() => {
  console.log("Clicked");
}, []);
```

Conceptually:

```text
function → function reference
             ↑
        useCallback
```

### Easy memory trick

```text
useMemo
→ Memoize a VALUE

useCallback
→ Memoize a FUNCTION
```

---

# Practical Comparison

### Without `useMemo`

```jsx
function App({ products }) {
  const filtered = products.filter(
    product => product.price > 1000
  );

  return <ProductList products={filtered} />;
}
```

The filtering calculation runs whenever `App` renders.

---

### With `useMemo`

```jsx
function App({ products }) {
  const filtered = useMemo(() => {
    return products.filter(
      product => product.price > 1000
    );
  }, [products]);

  return <ProductList products={filtered} />;
}
```

Now the filtered result is reused while `products` remains the same dependency value.

---

# When `useMemo` Is Useful

Imagine:

```jsx
const sortedProducts = products
  .sort(...)
```

or:

```jsx
const filteredProducts = hugeArray.filter(...)
```

or:

```jsx
const statistics = calculateStatistics(data);
```

If these calculations are genuinely expensive and the component re-renders frequently, memoization may help.

---

# When NOT to Use `useMemo`

Don't do this everywhere:

```jsx
const name = useMemo(
  () => firstName + " " + lastName,
  [firstName, lastName]
);
```

This calculation is trivial.

Simply write:

```jsx
const name = `${firstName} ${lastName}`;
```

### Why?

`useMemo` itself has complexity and isn't automatically a performance improvement.

The goal isn't:

> "Use `useMemo` everywhere."

The goal is:

> **Use memoization when it provides a meaningful benefit.**

---

# `useMemo` Is a Performance Optimization

This is important.

You shouldn't use `useMemo` because your code **needs it to be logically correct**.

Your component should conceptually work without it:

```jsx
const result = calculate(data);
```

Then, if calculation cost becomes significant:

```jsx
const result = useMemo(
  () => calculate(data),
  [data]
);
```

Think:

```text
Correctness
    ↓
First

Performance optimization
    ↓
Then use memoization when justified
```

---

# Object Example

Suppose:

```jsx
const options = {
  sortBy: "price",
  direction: "ascending"
};
```

Every render creates a new object.

You might memoize it when its stable identity matters to a downstream optimization:

```jsx
const options = useMemo(() => ({
  sortBy: "price",
  direction: "ascending"
}), []);
```

But don't automatically memoize every object.

You need a reason, such as passing it to a memoized child or using it as a dependency.

---

# Array Example

```jsx
const visibleItems = useMemo(() => {
  return items.filter(item => item.visible);
}, [items]);
```

Now `visibleItems` keeps the same cached result until `items` changes.

---

# `useMemo` With `React.memo`

These two can work together.

Suppose:

```jsx
const List = memo(function List({ items }) {
  // ...
});
```

Parent:

```jsx
function App({ products }) {
  const visibleProducts = useMemo(() => {
    return products.filter(
      product => product.inStock
    );
  }, [products]);

  return (
    <List items={visibleProducts} />
  );
}
```

Why can this help?

Without `useMemo`:

```text
Parent renders
    ↓
new array created
    ↓
List receives new reference
    ↓
memoized List may render again
```

With `useMemo`:

```text
Parent renders
    ↓
same cached array if products unchanged
    ↓
List receives same reference
    ↓
React.memo can potentially skip the child render
```

This is an **optimization**, not something you should add automatically.

---

# Dependency Mistake

### ❌ Incorrect

```jsx
const result = useMemo(() => {
  return calculate(price, taxRate);
}, [price]);
```

The calculation also depends on:

```text
taxRate
```

So:

### ✅

```jsx
const result = useMemo(() => {
  return calculate(price, taxRate);
}, [price, taxRate]);
```

Missing dependencies can cause the memoized calculation to use stale values.

---

# `useMemo` and State

You can derive values from state:

```jsx
const [price, setPrice] = useState(100);

const finalPrice = useMemo(() => {
  return price * 1.18;
}, [price]);
```

But if the calculation is cheap:

```jsx
const finalPrice = price * 1.18;
```

is usually better.

Remember:

> **Derived data doesn't automatically need `useMemo`.**

---

# Practical Example — Expensive Calculation

```jsx
function Dashboard({ numbers }) {
  const [theme, setTheme] = useState("light");

  const statistics = useMemo(() => {
    console.log("Calculating statistics...");

    return calculateStatistics(numbers);
  }, [numbers]);

  return (
    <div>
      <p>Average: {statistics.average}</p>

      <button
        onClick={() =>
          setTheme(
            theme === "light"
              ? "dark"
              : "light"
          )
        }
      >
        Theme: {theme}
      </button>
    </div>
  );
}
```

Changing `theme` causes a re-render.

But:

```text
numbers unchanged
      ↓
statistics can be reused
```

---

# WHEN?

Use `useMemo` when:

### 1. A calculation is expensive

```text
Large array
     ↓
filter
sort
reduce
complex calculation
```

### 2. The component renders frequently

### 3. The dependencies often remain unchanged

### 4. Stable derived values help another optimization

For example:

```text
useMemo
   ↓
stable object/array
   ↓
memoized child
```

---

# When Should You Avoid It?

Avoid unnecessary memoization for:

```jsx
const sum = a + b;
```

```jsx
const fullName = `${first} ${last}`;
```

```jsx
const isAdult = age >= 18;
```

These are cheap calculations.

---

# Common Mistakes

### ❌ Mistake 1 — Using `useMemo` everywhere

Memoization has a cost. It isn't automatically faster.

---

### ❌ Mistake 2 — Thinking it prevents re-renders

```text
useMemo ≠ prevent component rendering
```

It caches a calculation.

---

### ❌ Mistake 3 — Missing dependencies

```jsx
useMemo(() => calculate(a, b), [a]);
```

If `b` affects the calculation, it belongs in the dependency list.

---

### ❌ Mistake 4 — Using `useMemo` for side effects

Don't do:

```jsx
useMemo(() => {
  fetch("/api");
}, []);
```

`useMemo` is for **calculating/caching a value**, not performing side effects.

---

### ❌ Mistake 5 — Confusing `useMemo` and `useCallback`

```text
useMemo     → caches result/value
useCallback → caches function
```

---

# 🎯 Interview Questions

### 1. What is `useMemo`?

> `useMemo` is a React Hook that caches the result of a calculation between renders and recomputes it when its dependencies change.

---

### 2. Does `useMemo` prevent re-renders?

No.

> `useMemo` caches a calculated value; it does not prevent the component from rendering.

---

### 3. What is the difference between `useMemo` and `useCallback`?

> `useMemo` caches a value, while `useCallback` caches a function reference.

```jsx
useMemo(() => calculate(), []);
```

```jsx
useCallback(() => doSomething(), []);
```

---

### 4. Should you use `useMemo` for every calculation?

No.

> It should be used when memoization provides a meaningful performance benefit, such as avoiding expensive calculations or helping an existing memoization strategy.

---

### 5. What happens when a dependency changes?

React recalculates the memoized value.

```jsx
useMemo(
  () => calculate(data),
  [data]
);
```

When `data` changes, the calculation is performed again.

---

### 6. Can `useMemo` perform side effects?

No.

`useMemo` should be used for calculations. Side effects belong in appropriate places such as event handlers or `useEffect` when synchronization is required.

---

### 7. Is `useMemo` guaranteed to preserve the value forever?

No.

It is a **performance optimization**, not a semantic guarantee that the value will never be recalculated.

---

# ⭐ Remember

```text
useMemo(() => calculate(), [dependencies])
              ↓
          Calculation
              ↓
         Cached value
              ↓
Dependencies unchanged?
      ↓                ↓
     YES              NO
      ↓                ↓
Reuse value       Recalculate
```

### Golden Rule

> **Don't use `useMemo` simply because a value is calculated during render. Use it when avoiding the calculation or stabilizing a value provides a meaningful performance benefit.**

### One-line interview answer

> **`useMemo` is a React Hook that caches the result of a calculation and recomputes it when its dependencies change, primarily as a performance optimization.**
