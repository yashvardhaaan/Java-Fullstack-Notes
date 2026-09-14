# 12 — Caching API Data

## WHY?

Imagine your React app requests the same data repeatedly:

```text
User opens Dashboard
      ↓
GET /api/products
      ↓
100 products returned

User goes to another page
      ↓
Comes back to Dashboard
      ↓
GET /api/products again
```

The server has to send the same data again.

This can cause:

* unnecessary API requests
* slower UI
* more server load
* more network usage
* poor user experience

**Caching** helps us reuse data that we already fetched.

---

# WHAT?

**Caching** means temporarily storing API data so that it can be reused instead of making the same request again.

Without caching:

```text
Component
   ↓
API
   ↓
Data
```

Every time the component needs the data, another request may happen.

With caching:

```text
Component
   ↓
Cache
   ↓
Data already available
```

If the data isn't available in the cache:

```text
Component
   ↓
Cache ❌
   ↓
API
   ↓
Cache ✅
   ↓
Component
```

---

# WHERE?

Caching can happen at different levels:

```text
Browser Cache
     ↓
Application Cache
     ↓
Data-fetching Library Cache
     ↓
CDN Cache
     ↓
Server Cache
     ↓
Database Cache
```

In React applications, you'll commonly encounter **client-side API caching**.

Libraries such as:

```text
TanStack Query
SWR
```

provide sophisticated API caching.

---

# HOW?

## 1. Simple React Example

Suppose we fetch products:

```jsx
const [products, setProducts] = useState([]);
```

After fetching:

```jsx
const data = await response.json();

setProducts(data);
```

The data is now stored in React state.

However, this is **not necessarily a persistent cache**.

If the component unmounts, the state can disappear.

---

# 2. Basic Cache Using JavaScript

You can create a simple cache:

```jsx
const cache = new Map();

async function getUsers() {
  if (cache.has("users")) {
    return cache.get("users");
  }

  const response = await fetch("/api/users");

  if (!response.ok) {
    throw new Error("Failed to fetch users");
  }

  const data = await response.json();

  cache.set("users", data);

  return data;
}
```

Now:

```text
First request
    ↓
Cache ❌
    ↓
API
    ↓
Store in cache
    ↓
Return data
```

Next request:

```text
Second request
    ↓
Cache ✅
    ↓
Return cached data
```

No API request is needed.

---

# 3. Cache with Expiration

Cached data can become outdated.

For example:

```text
Product price = ₹100
```

You cache it.

Later:

```text
Actual price = ₹120
```

Your application could still show:

```text
₹100
```

Therefore, caches often use a **time limit**.

Example:

```jsx
const cache = new Map();

async function getUsers() {
  const cached = cache.get("users");

  if (cached && Date.now() - cached.timestamp < 60000) {
    return cached.data;
  }

  const response = await fetch("/api/users");

  if (!response.ok) {
    throw new Error("Failed to fetch users");
  }

  const data = await response.json();

  cache.set("users", {
    data,
    timestamp: Date.now()
  });

  return data;
}
```

Here:

```text
60000 ms = 60 seconds
```

So the cached data is considered valid for one minute.

---

# 4. TanStack Query

In real-world React applications, manually implementing caching can become complicated.

A library such as **TanStack Query** can handle it.

Example:

```jsx
import { useQuery } from "@tanstack/react-query";

function Users() {
  const {
    data,
    isPending,
    isError
  } = useQuery({
    queryKey: ["users"],
    queryFn: async () => {
      const response = await fetch("/api/users");

      if (!response.ok) {
        throw new Error("Failed to fetch users");
      }

      return response.json();
    }
  });

  if (isPending) {
    return <p>Loading...</p>;
  }

  if (isError) {
    return <p>Something went wrong</p>;
  }

  return (
    <ul>
      {data.map(user => (
        <li key={user.id}>
          {user.name}
        </li>
      ))}
    </ul>
  );
}
```

TanStack Query can maintain a cache based on the:

```jsx
queryKey
```

Here:

```jsx
queryKey: ["users"]
```

identifies the cached data.

---

# Query Keys

Suppose we have:

```text
/api/products
```

We might use:

```jsx
queryKey: ["products"]
```

For a particular product:

```text
/api/products/101
```

we could use:

```jsx
queryKey: ["products", 101]
```

For a category:

```text
/api/products?category=laptop
```

we could use:

```jsx
queryKey: ["products", { category: "laptop" }]
```

The key tells the library **which data is being cached**.

---

# Stale Data

One important caching concept is **stale data**.

Suppose:

```text
Cache:
User name = Yash
```

But the server may have changed it.

The cached value is now potentially outdated.

We call this:

```text
STALE
```

Fresh:

```text
Cache data
    ↓
Still considered current
```

Stale:

```text
Cache data
    ↓
May no longer match server
```

Caching libraries allow you to control how long data is considered fresh.

---

# Cache vs State

This is an important interview distinction.

### State

Usually represents data needed by the UI/component:

```jsx
const [isModalOpen, setIsModalOpen] = useState(false);
```

### Cache

Stores data that can be reused, often from an external source:

```text
GET /api/users
        ↓
Cached server data
```

Think:

```text
UI State
→ "Is the modal open?"

Server/Query Cache
→ "What users did the server return?"
```

---

# Cache Invalidation

One of the hardest caching problems is:

> **When should cached data be considered outdated?**

Suppose:

```text
Cache:
Products = [Laptop, Phone]
```

Then the user creates:

```text
Tablet
```

The server now has:

```text
[Laptop, Phone, Tablet]
```

But your cache might still contain:

```text
[Laptop, Phone]
```

So we need to **invalidate or update the cache**.

---

# Example: Mutation + Cache

Suppose we create a user:

```jsx
await createUser(user);
```

After successfully creating the user, we may need to:

```text
Invalidate users cache
        ↓
Fetch fresh users
```

With TanStack Query, for example:

```jsx
queryClient.invalidateQueries({
  queryKey: ["users"]
});
```

This tells the query system that the cached users data should be refreshed according to its query behavior.

---

# Cache Strategies

Common strategies include:

### Cache-first

```text
Cache?
 ↓
YES → Use cache
 ↓
NO
 ↓
API
```

Fast, but data may be stale.

---

### Network-first

```text
Try API
   ↓
Success → Use fresh data
   ↓
Failure → Maybe use cache
```

Better when freshness is important.

---

### Stale-while-revalidate

```text
Cached data available
       ↓
Show cached data immediately
       ↓
Fetch fresh data in background
       ↓
Update UI
```

This can provide a very fast user experience while keeping data reasonably fresh.

---

# WHEN?

Caching is especially useful when:

* the same data is requested repeatedly
* data doesn't change frequently
* users navigate between pages
* API requests are expensive
* network performance matters
* dashboards reuse the same server data
* search/filter results can be reused
* you need background refetching

Examples:

| Data                    | Caching usefulness |
| ----------------------- | ------------------ |
| Product catalog         | ⭐⭐⭐⭐⭐              |
| User profile            | ⭐⭐⭐⭐               |
| Country list            | ⭐⭐⭐⭐⭐              |
| Dashboard statistics    | ⭐⭐⭐⭐               |
| Live stock price        | ⭐                  |
| Real-time chat messages | Usually low        |

The more frequently data changes, the more carefully caching must be designed.

---

# ⚠️ Common Mistakes

### 1. Caching everything forever

Bad:

```text
Cache → never refresh
```

Data can become stale.

---

### 2. Ignoring cache invalidation

After:

```text
POST /api/users
```

you might still display an old cached user list.

---

### 3. Confusing React state with API cache

```jsx
useState()
```

is not automatically a full server-state caching solution.

---

### 4. Caching sensitive data carelessly

Don't assume sensitive information should always be stored in browser-accessible caches.

Consider:

* authentication
* authorization
* privacy
* expiration
* logout behavior

---

# ⭐ Interview Questions

### Q1. What is caching?

**Answer:**

Caching is storing previously retrieved data temporarily so it can be reused without making the same network request again.

---

### Q2. Why is caching useful in React?

It reduces unnecessary API calls, improves response time, reduces network usage, and can improve the user experience.

---

### Q3. What is stale data?

Data in the cache that may no longer represent the latest data on the server is called **stale data**.

---

### Q4. What is cache invalidation?

Cache invalidation means marking cached data as no longer valid so it can be refreshed or replaced with newer data.

---

### Q5. Is `useState` a cache?

Not necessarily. `useState` stores component state. It can temporarily hold fetched data, but it does not provide the full behavior expected from a server-state cache.

---

### Q6. Why use TanStack Query instead of manually caching?

Because it provides features such as:

```text
Caching
Query lifecycle
Retries
Refetching
Stale-data management
Request deduplication
Cache invalidation
```

without requiring us to implement all of these mechanisms ourselves.

---

# ⭐ Remember

```text
              API
               ↓
         Fetch Data
               ↓
             Cache
               ↓
        ┌──────┴──────┐
        ↓             ↓
   Cache Hit      Cache Miss
        ↓             ↓
   Use Cache         API
                      ↓
                  Update Cache
```

**One-line interview answer:**

> **Caching in React means storing previously fetched server data so it can be reused efficiently, reducing unnecessary API requests while using freshness and invalidation strategies to prevent stale data.**
