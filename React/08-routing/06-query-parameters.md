# 06 — Query Parameters

## WHY?

Sometimes we don't want the URL to identify **one specific resource**.

Instead, we want to send additional information such as:

* search text
* filters
* sorting
* pagination
* category
* price range

For example:

```text id="m0v1c8"
/products?category=laptop
```

or:

```text id="p8r3k2"
/products?search=iphone&page=2
```

The route is still:

```text id="3wq5xj"
/products
```

but the query parameters tell the application **how the products should be displayed or filtered**.

---

# WHAT?

A **query parameter** is a key-value pair added to a URL after `?`.

Example:

```text id="8y0q2n"
/products?category=laptop
          ↑
      query string
```

Here:

```text id="6j7k2m"
category = laptop
```

Multiple parameters are separated using `&`:

```text id="4y8f1v"
/products?category=laptop&page=2&sort=price
```

Meaning:

```text id="8x3k5d"
category = laptop
page     = 2
sort     = price
```

---

# WHERE?

Query parameters are commonly used for:

### Search

```text id="3v2f7n"
/products?search=laptop
```

### Filtering

```text id="a8j2x0"
/products?category=mobile
```

### Sorting

```text id="r6m3z1"
/products?sort=price
```

### Pagination

```text id="q5f8v2"
/products?page=3
```

### Multiple filters

```text id="w4n8s6"
/products?category=laptop&brand=dell&ram=16
```

---

# HOW?

## Step 1 — Define Normal Route

You generally don't put the query string in the route definition.

Use:

```jsx id="k7y2j9"
<Route
  path="/products"
  element={<Products />}
/>
```

Not:

```jsx id="8s5c2q"
<Route
  path="/products?category=laptop"
  element={<Products />}
/>
```

The query parameters are handled separately.

---

# Step 2 — Create a URL

Example:

```text id="9m4c7a"
/products?category=laptop
```

Break it down:

```text id="n4f1z8"
Path:
 /products

Query parameter:
 category=laptop
```

---

# Step 3 — Read Query Parameters

React Router provides:

```jsx id="w1v6q8"
useSearchParams()
```

Example:

```jsx id="7f9k2m"
import { useSearchParams } from "react-router-dom";

function Products() {
  const [searchParams] = useSearchParams();

  const category = searchParams.get("category");

  return (
    <h1>
      Category: {category}
    </h1>
  );
}
```

For:

```text id="y8f2x6"
/products?category=laptop
```

we get:

```text id="8c3k1v"
category = "laptop"
```

---

# Understanding `useSearchParams()`

```jsx id="n4v7c2"
const [searchParams, setSearchParams] =
  useSearchParams();
```

It returns two things:

```text id="0p6j8s"
searchParams
     ↓
Read query parameters

setSearchParams
     ↓
Change query parameters
```

---

# Reading a Parameter

```jsx id="w7r3p9"
const category = searchParams.get("category");
```

For:

```text id="h3m8x1"
/products?category=laptop
```

result:

```js id="p9x6v2"
"laptop"
```

---

# Reading Multiple Parameters

URL:

```text id="z7m2q4"
/products?category=laptop&page=2&sort=price
```

Code:

```jsx id="s4x8v1"
const category = searchParams.get("category");
const page = searchParams.get("page");
const sort = searchParams.get("sort");
```

Result:

```text id="d9p5k3"
category = "laptop"
page     = "2"
sort     = "price"
```

Again, URL query values are strings.

If you need a number:

```jsx id="q3v8m1"
const page = Number(searchParams.get("page"));
```

---

# Practical Search Example

Suppose we have:

```text id="8z2k5w"
/products?search=laptop
```

Component:

```jsx id="w5j1s4"
import { useSearchParams } from "react-router-dom";

function Products() {
  const [searchParams] = useSearchParams();

  const search = searchParams.get("search") || "";

  return (
    <div>
      <h1>Products</h1>

      <p>
        Searching for: {search}
      </p>
    </div>
  );
}
```

Result:

```text id="k7c3m0"
Products

Searching for: laptop
```

---

# Changing Query Parameters

Suppose the user selects:

```text id="0x6m2v"
Category → Laptop
```

We can update the URL.

```jsx id="x2p8k5"
const [searchParams, setSearchParams] =
  useSearchParams();

function selectCategory(category) {
  setSearchParams({
    category
  });
}
```

Calling:

```jsx id="q7m4s1"
selectCategory("laptop");
```

can update the URL to:

```text id="f2x9c7"
/products?category=laptop
```

---

# Search Box Example

```jsx id="v8n2q6"
import {
  useSearchParams
} from "react-router-dom";

function Products() {
  const [searchParams, setSearchParams] =
    useSearchParams();

  const search =
    searchParams.get("search") || "";

  function handleSearch(event) {
    const value = event.target.value;

    setSearchParams({
      search: value
    });
  }

  return (
    <div>
      <input
        value={search}
        onChange={handleSearch}
        placeholder="Search products"
      />

      <p>
        Search: {search}
      </p>
    </div>
  );
}
```

Now the URL can reflect the search:

```text id="9r5m2v"
/products?search=laptop
```

This is useful because the URL can be:

* bookmarked
* shared
* refreshed
* used with browser back/forward navigation

---

# Query Parameters + API

This is extremely common.

Suppose the URL is:

```text id="j3f6m2"
/products?category=laptop
```

Read it:

```jsx id="8v4x1m"
const category =
  searchParams.get("category");
```

Then send it to the API:

```jsx id="q9c2w5"
const response = await fetch(
  `/api/products?category=${encodeURIComponent(category)}`
);
```

Flow:

```text id="3r7p2k"
/products?category=laptop
          ↓
useSearchParams()
          ↓
category = laptop
          ↓
GET /api/products?category=laptop
          ↓
Backend
          ↓
Filtered products
```

---

# Query Parameters + Pagination

URL:

```text id="c8v4m7"
/products?page=3
```

Read:

```jsx id="x1q6z8"
const page =
  Number(searchParams.get("page") || 1);
```

API:

```jsx id="n7m3p2"
fetch(`/api/products?page=${page}`);
```

Now browser navigation can preserve the current page.

---

# Query Parameters + Multiple Filters

URL:

```text id="v6y2p8"
/products?category=laptop&brand=dell&sort=price
```

Read:

```jsx id="f3m7q1"
const category = searchParams.get("category");
const brand = searchParams.get("brand");
const sort = searchParams.get("sort");
```

Then:

```text id="j2k8w4"
React
 ↓
Read URL
 ↓
Build API request
 ↓
Backend filtering
 ↓
Display results
```

---

# Route Parameter vs Query Parameter

This is one of the **most important interview concepts**.

## Route Parameter

```text id="n6x4c9"
/products/101
```

Route:

```jsx id="h5p2w8"
<Route
  path="/products/:id"
  element={<Product />}
/>
```

Meaning:

> Give me product **101**.

---

## Query Parameter

```text id="u3m8q5"
/products?category=laptop
```

Route:

```jsx id="y7k2v9"
<Route
  path="/products"
  element={<Products />}
/>
```

Meaning:

> Give me products filtered by **laptop**.

---

# Easy Way to Remember

```text id="4k7m1p"
Route Parameter
→ WHO / WHICH ONE?

/products/101
        ↑
    specific product
```

```text id="9v2x6q"
Query Parameter
→ HOW / WHICH FILTER?

/products?category=laptop
          ↑
       filtering
```

---

# Multiple Values

Sometimes you may have:

```text id="5q8m2z"
/products?brand=dell&brand=hp
```

You can retrieve all values:

```jsx id="t7x3p1"
const brands =
  searchParams.getAll("brand");
```

Result:

```js id="y6v2m9"
["dell", "hp"]
```

---

# Query Parameters Are Strings

For:

```text id="m3p7q1"
/products?page=5
```

this:

```jsx id="4x9v2k"
const page = searchParams.get("page");
```

gives:

```js id="r7c2m8"
"5"
```

If you need a number:

```jsx id="h6p3x9"
const page = Number(
  searchParams.get("page") || 1
);
```

---

# URL Encoding

Query values can contain spaces and special characters.

For example:

```text id="7m2k8v"
search = gaming laptop
```

Use URL encoding when constructing URLs manually:

```jsx id="p4x9c2"
const url =
  `/api/products?search=${
    encodeURIComponent("gaming laptop")
  }`;
```

Result:

```text id="d5v8m1"
search=gaming%20laptop
```

When using `URLSearchParams`, encoding is handled for you:

```jsx id="q2n7x4"
const params = new URLSearchParams({
  search: "gaming laptop"
});

const url = `/api/products?${params}`;
```

---

# Practical Project Example

Imagine an e-commerce page:

```text id="a7m2k9"
/products?category=shoes&page=2&sort=price
```

The React component reads:

```jsx id="f5x8q2"
const category =
  searchParams.get("category");

const page =
  Number(searchParams.get("page") || 1);

const sort =
  searchParams.get("sort");
```

Then:

```text id="p3v7m1"
category = shoes
page     = 2
sort     = price
```

API:

```text id="z8q4n6"
/api/products
?category=shoes
&page=2
&sort=price
```

This is a very realistic application pattern.

---

# ⚠️ Common Mistakes

## 1. Putting query parameters in `path`

Don't:

```jsx id="r6v3m9"
<Route
  path="/products?category=laptop"
  element={<Products />}
/>
```

Use:

```jsx id="q2k7x5"
<Route
  path="/products"
  element={<Products />}
/>
```

and read the query using:

```jsx id="m8p4z1"
useSearchParams()
```

---

## 2. Expecting a number

```jsx id="f3q9x7"
const page = searchParams.get("page");
```

gives:

```js id="t7m2k8"
"2"
```

not:

```js id="x4p6n1"
2
```

---

## 3. Forgetting missing values

This:

```jsx id="z5k8m2"
searchParams.get("category")
```

can return:

```js id="n3q7x9"
null
```

So often use:

```jsx id="v8m4p2"
const category =
  searchParams.get("category") || "";
```

---

## 4. Putting sensitive information in query strings

Avoid putting sensitive information such as passwords or secrets in URLs.

URLs can appear in:

* browser history
* logs
* analytics systems
* copied/shared links

---

# WHEN?

Use query parameters when the URL needs to represent:

```text id="w2x7m4"
Search
Filtering
Sorting
Pagination
Optional configuration
```

Examples:

```text id="z6q1p8"
/products?search=phone
```

```text id="r4m8k2"
/products?category=laptop
```

```text id="n9v3x6"
/products?page=2
```

```text id="c5q7m1"
/products?sort=price
```

---

# ⭐ Interview Questions

### Q1. What is a query parameter?

**Answer:**

A query parameter is a key-value pair in the URL after `?`, commonly used for filtering, searching, sorting, pagination, or other optional request information.

---

### Q2. How do you read query parameters in React Router?

Using:

```jsx id="s7x2m5"
const [searchParams] = useSearchParams();

const category =
  searchParams.get("category");
```

---

### Q3. What is the difference between route and query parameters?

```text id="4v8m2q"
Route:
 /products/101

Query:
 /products?category=laptop
```

A route parameter is part of the URL path, while a query parameter is part of the URL's query string.

---

### Q4. How do you update query parameters?

```jsx id="y5p8x2"
const [searchParams, setSearchParams] =
  useSearchParams();

setSearchParams({
  category: "laptop"
});
```

---

### Q5. Are query parameters strings?

Yes. Values obtained from `URLSearchParams` are strings unless you explicitly convert them.

---

### Q6. When would you use query parameters instead of route parameters?

Use query parameters for optional filtering, searching, sorting, or pagination.

Use route parameters when the URL identifies a particular resource.

---

# ⭐ Remember

```text id="r8m3q5"
ROUTE PARAMETER

/products/101
        ↓
     Which one?
        ↓
    Product 101
```

```text id="x6v2k9"
QUERY PARAMETER

/products?category=laptop
          ↓
       How/filter?
          ↓
   Laptop products
```

And the React Router API:

```jsx id="q4n7m1"
const [searchParams, setSearchParams] =
  useSearchParams();
```

### One-line interview answer:

> **Query parameters are optional key-value pairs in the URL after `?`, commonly used for searching, filtering, sorting, and pagination, and React Router provides `useSearchParams()` to read and update them.**
