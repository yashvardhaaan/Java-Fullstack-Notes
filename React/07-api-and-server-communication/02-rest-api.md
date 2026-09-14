# 02 — REST API

REST API is one of the most important concepts when building React applications that communicate with a backend.

---

## WHY?

A React frontend needs a standard way to communicate with a backend.

For example, suppose you have an e-commerce application:

```text
React
  ↓
"I need all products"
  ↓
Backend API
  ↓
Database
  ↓
Products
  ↓
React
```

Instead of React directly accessing the database, it communicates through an **API**.

REST provides a commonly used architectural style for designing these APIs.

---

# WHAT?

## What is an API?

**API = Application Programming Interface**

An API provides a defined way for one piece of software to communicate with another.

For example:

```text
React Application
       ↓
     API
       ↓
Backend
       ↓
Database
```

The React application doesn't need to know how the database works.

It only needs to know:

```text
Which URL?
Which HTTP method?
What data?
What response?
```

---

# What is REST?

**REST = Representational State Transfer**

REST is an **architectural style** for designing network APIs.

A REST-style API generally represents application data as **resources**.

For example:

```text
Users
Products
Orders
Courses
Students
```

Each resource can have a URL.

```text
/api/users
/api/products
/api/orders
```

HTTP methods describe what you want to do with those resources.

---

# REST API Example

Suppose we have:

```text
/api/products
```

We can perform different operations:

```text
GET
/api/products
       ↓
Get products

POST
/api/products
       ↓
Create product

GET
/api/products/10
       ↓
Get product 10

PUT
/api/products/10
       ↓
Replace product 10

PATCH
/api/products/10
       ↓
Partially update product 10

DELETE
/api/products/10
       ↓
Delete product 10
```

This is the basic idea behind REST-style APIs.

---

# WHY REST?

REST became popular because it provides a simple and standardized way to design web APIs around resources and HTTP.

Instead of creating URLs like:

```text
/api/getAllProducts
/api/createProduct
/api/deleteProduct
```

a REST-style API can use:

```text
GET    /api/products
POST   /api/products
DELETE /api/products/10
```

The **HTTP method** communicates the intended operation.

---

# WHERE?

REST APIs are commonly used in:

### E-commerce

```text
/products
/orders
/carts
```

### Banking

```text
/accounts
/transactions
/payments
```

### Social media

```text
/users
/posts
/comments
```

### Education

```text
/students
/courses
/assignments
```

### React applications

```text
React
 ↓
REST API
 ↓
Node / Java / Python / .NET
 ↓
Database
```

---

# HOW?

Let's build the mental model step by step.

## Step 1 — Identify a resource

Suppose your application manages students.

Resource:

```text
Student
```

Collection endpoint:

```text
/api/students
```

Individual student:

```text
/api/students/101
```

---

## Step 2 — Use HTTP methods

### Get all students

```http
GET /api/students
```

Response:

```json
[
  {
    "id": 101,
    "name": "Yash"
  },
  {
    "id": 102,
    "name": "Rahul"
  }
]
```

---

### Get one student

```http
GET /api/students/101
```

Response:

```json
{
  "id": 101,
  "name": "Yash"
}
```

---

### Create a student

```http
POST /api/students
```

Body:

```json
{
  "name": "Amit",
  "email": "amit@example.com"
}
```

Response might be:

```http
201 Created
```

```json
{
  "id": 103,
  "name": "Amit",
  "email": "amit@example.com"
}
```

---

### Update a student

Using PUT:

```http
PUT /api/students/101
```

Body:

```json
{
  "name": "Yashvardhan",
  "email": "yash@example.com"
}
```

---

### Partially update

Using PATCH:

```http
PATCH /api/students/101
```

Body:

```json
{
  "name": "Yashvardhan"
}
```

Only the specified field needs to be changed.

---

### Delete

```http
DELETE /api/students/101
```

Possible response:

```http
204 No Content
```

---

# REST CRUD

You will hear **CRUD** constantly in development interviews.

CRUD means:

```text
C → Create
R → Read
U → Update
D → Delete
```

Mapping to HTTP:

| CRUD   | HTTP      | Example            |
| ------ | --------- | ------------------ |
| Create | POST      | `POST /users`      |
| Read   | GET       | `GET /users`       |
| Update | PUT/PATCH | `PATCH /users/10`  |
| Delete | DELETE    | `DELETE /users/10` |

Remember:

```text
POST   → Create
GET    → Read
PUT    → Replace
PATCH  → Partial update
DELETE → Delete
```

---

# REST API in React

Now connect this with what you learned in HTTP.

```jsx
import { useEffect, useState } from "react";

function Products() {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    async function fetchProducts() {
      const response = await fetch("/api/products");

      if (!response.ok) {
        throw new Error("Failed to load products");
      }

      const data = await response.json();

      setProducts(data);
    }

    fetchProducts();
  }, []);

  return (
    <div>
      {products.map((product) => (
        <p key={product.id}>
          {product.name}
        </p>
      ))}
    </div>
  );
}
```

The important line is:

```js
fetch("/api/products");
```

By default, `fetch()` makes a:

```text
GET
```

request.

So:

```text
React
 ↓
GET /api/products
 ↓
REST API
 ↓
Backend
 ↓
Database
 ↓
JSON
 ↓
React
```

---

# POST from React

Suppose we want to create a product.

```jsx
async function createProduct() {
  const response = await fetch("/api/products", {
    method: "POST",

    headers: {
      "Content-Type": "application/json"
    },

    body: JSON.stringify({
      name: "Laptop",
      price: 75000
    })
  });

  if (!response.ok) {
    throw new Error("Failed to create product");
  }

  const product = await response.json();

  console.log(product);
}
```

The request looks like:

```http
POST /api/products
Content-Type: application/json

{
  "name": "Laptop",
  "price": 75000
}
```

---

# REST Resource vs Endpoint

These terms are sometimes confused.

### Resource

The conceptual thing you're working with:

```text
Product
```

### Endpoint

A specific API URL through which you access it:

```text
/api/products
```

Example:

```text
Resource → Product
Endpoint → /api/products
```

---

# Path Parameters

REST APIs frequently use path parameters.

```text
/api/products/25
```

Here:

```text
25
```

identifies a particular product.

React:

```jsx
const productId = 25;

fetch(`/api/products/${productId}`);
```

produces:

```text
GET /api/products/25
```

---

# Query Parameters

Query parameters are commonly used for filtering, searching, sorting and pagination.

Example:

```text
/api/products?category=laptop&page=2
```

React:

```jsx
fetch(
  "/api/products?category=laptop&page=2"
);
```

The resource remains:

```text
/products
```

while the query parameters modify the requested result.

---

# REST and JSON

REST APIs commonly exchange data using **JSON**.

Example response:

```json
{
  "id": 10,
  "name": "Laptop",
  "price": 75000
}
```

React can convert the JSON response into a JavaScript object using:

```js
const data = await response.json();
```

---

# REST API Architecture

A typical application:

```text
┌──────────────────────┐
│      React UI        │
└──────────┬───────────┘
           │
           │ HTTP
           ↓
┌──────────────────────┐
│      REST API        │
│                      │
│ /users               │
│ /products            │
│ /orders              │
└──────────┬───────────┘
           │
           ↓
┌──────────────────────┐
│      Backend         │
│ Node / Java / Python │
└──────────┬───────────┘
           │
           ↓
┌──────────────────────┐
│      Database        │
└──────────────────────┘
```

---

# Important REST Principles

You don't need to memorize every academic detail initially, but understand these.

## 1. Client-Server

Frontend and backend have separate responsibilities.

```text
Client
 ↓
UI

Server
 ↓
Business logic + data
```

---

## 2. Stateless

Each request should contain the information needed by the server to process it.

The server should not depend on hidden client-side session state being carried implicitly between requests.

For example, authentication information may be sent using a token:

```http
Authorization: Bearer <token>
```

---

## 3. Uniform Interface

Resources are accessed using consistent conventions.

Example:

```text
GET    /products
POST   /products
GET    /products/10
PATCH  /products/10
DELETE /products/10
```

---

## 4. Cacheability

Responses can indicate whether they may be cached.

This can improve performance when appropriate.

---

# RESTful URL Design

### ❌ Less REST-like

```text
/getAllUsers
/createNewUser
/deleteUser?id=10
```

### ✅ Resource-oriented

```text
GET    /users
POST   /users
DELETE /users/10
```

The HTTP method tells us the operation.

---

# Nested Resources

Sometimes resources have relationships.

For example:

```text
/users/10/orders
```

can represent:

> Orders belonging to user 10.

Another example:

```text
/courses/5/students
```

could represent:

> Students enrolled in course 5.

Don't over-nest URLs unnecessarily, though. API design should remain easy to understand.

---

# REST vs React

A very important interview point:

**React is not REST.**

They are different things.

```text
React
 ↓
Frontend UI library

REST
 ↓
Architectural style for APIs
```

They can work together:

```text
React → REST API → Backend → Database
```

---

# Common Mistakes

### ❌ Thinking REST is a programming language

REST is an **architectural style**.

---

### ❌ Thinking REST API means only JSON

REST does not require JSON specifically.

JSON is simply a very common representation used by modern web APIs.

---

### ❌ Thinking every API is REST

An API can use other architectural styles or protocols.

Examples include:

```text
REST
GraphQL
gRPC
SOAP
WebSocket
```

---

### ❌ Confusing PUT and PATCH

```text
PUT
→ generally replaces the representation/resource

PATCH
→ partially modifies it
```

The exact behavior depends on the API contract.

---

# 🎯 Interview Questions

### Q1. What is REST API?

> REST API is an API designed according to REST architectural principles, commonly using HTTP methods to operate on resources.

---

### Q2. What is a resource in REST?

> A resource is a conceptual entity exposed by an API, such as a user, product, order, or student.

---

### Q3. What is CRUD?

> CRUD stands for Create, Read, Update, and Delete.

---

### Q4. How does CRUD map to HTTP?

```text
Create → POST
Read   → GET
Update → PUT/PATCH
Delete → DELETE
```

---

### Q5. Difference between PUT and PATCH?

> PUT is generally used to replace a resource representation, while PATCH is used for partial modifications.

---

### Q6. What is a REST endpoint?

> An endpoint is a specific API URL through which a client accesses or operates on a resource.

Example:

```text
GET /api/products/10
```

---

### Q7. What does stateless mean in REST?

> Each request should contain the information necessary for the server to process it, rather than relying on hidden conversational state from previous requests.

---

### Q8. Is React a REST API?

**No.**

```text
React → Frontend library
REST  → API architectural style
```

---

# ⭐ Remember

Think about a REST API like a **resource-based system**:

```text
RESOURCE
   ↓
/products
   │
   ├── GET       → Read
   ├── POST      → Create
   │
   └── /10
        │
        ├── GET    → Read product 10
        ├── PUT    → Replace product 10
        ├── PATCH  → Modify product 10
        └── DELETE → Delete product 10
```

### One-line interview answer

> **REST is an architectural style for designing APIs around resources, typically using HTTP methods such as GET, POST, PUT, PATCH, and DELETE to perform operations on those resources.**

**Next → `03 — Fetch API`**
