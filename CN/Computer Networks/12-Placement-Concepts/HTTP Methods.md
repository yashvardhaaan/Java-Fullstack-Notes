````md id="http-methods"
# HTTP Methods

## 1. What is an HTTP Method?

An **HTTP method** tells the server **what action the client wants to perform on a resource**.

```text
Client
  ↓
HTTP Request
  ↓
METHOD + URL + Headers + Body
  ↓
Server
````

Example:

```http
GET /users/10
```

Means: **retrieve user 10**.

---

# 2. Important HTTP Methods ⭐⭐⭐⭐⭐

| Method  | Main Purpose              | Safe | Idempotent |
| ------- | ------------------------- | ---: | ---------: |
| GET     | Read/retrieve             |    ✅ |          ✅ |
| POST    | Create/submit             |    ❌ |          ❌ |
| PUT     | Replace/update            |    ❌ |          ✅ |
| PATCH   | Partial update            |    ❌ |         ❌* |
| DELETE  | Delete                    |    ❌ |          ✅ |
| HEAD    | Headers only              |    ✅ |          ✅ |
| OPTIONS | Supported operations/info |    ✅ |          ✅ |

* PATCH **can** be idempotent depending on how the operation is designed; it is not inherently idempotent.

---

# 3. GET ⭐⭐⭐⭐⭐

Used to **retrieve data**.

```http
GET /users/10
```

```text
Client → "Give me user 10"
Server → User data
```

### Characteristics

* Usually no request body required
* Should not modify server state
* Can be cached
* Safe
* Idempotent

### Safe

A **safe** method is intended not to change server state.

> GET = **Read**

---

# 4. POST ⭐⭐⭐⭐⭐

Used to **submit data** or commonly create a new resource.

```http
POST /users
```

Body:

```json
{
  "name": "Yash"
}
```

Server:

```text
Create user
   ↓
Return response
```

### Characteristics

* Usually changes server state
* Not safe
* Generally not idempotent

Example:

```text
POST /orders
```

Sending it twice may create **two orders**.

> POST = **Create/Submit**

---

# 5. PUT ⭐⭐⭐⭐⭐

Used to **replace the representation of a resource**.

```http
PUT /users/10
```

Body:

```json
{
  "name": "Yash",
  "age": 25
}
```

Think:

```text
Existing Resource
       ↓
   Replace it
       ↓
New Representation
```

### Idempotent

Sending the same PUT request multiple times should have the same intended final state.

```text
PUT X
PUT X
PUT X
 ↓
Final state = X
```

> **PUT = Replace**

---

# 6. PATCH ⭐⭐⭐⭐⭐

Used for a **partial modification**.

```http
PATCH /users/10
```

Body:

```json
{
  "age": 26
}
```

Only the specified field is changed.

```text
User:
Name = Yash
Age  = 25

PATCH age → 26

Result:
Name = Yash
Age  = 26
```

> **PATCH = Partial update**

---

# 7. DELETE ⭐⭐⭐⭐⭐

Used to delete a resource.

```http
DELETE /users/10
```

```text
User 10
   ↓
DELETE
   ↓
Removed
```

DELETE is **idempotent in the HTTP semantics sense**: repeating the same delete request should leave the resource in the same final state, even if later responses differ.

> **DELETE = Remove**

---

# 8. HEAD ⭐⭐⭐⭐

Same idea as GET, but the server returns **headers without the response body**.

```http
HEAD /image.jpg
```

Useful for checking:

* Whether resource exists
* Content-Length
* Last-Modified
* Cache information

```text
GET
 ↓
Headers + Body

HEAD
 ↓
Headers only
```

---

# 9. OPTIONS ⭐⭐⭐⭐⭐

Used to discover **communication options supported by a resource/server**.

Example:

```http
OPTIONS /users
```

May return:

```http
Allow: GET, POST, OPTIONS
```

### CORS connection

Browsers can send an **OPTIONS preflight request** before certain cross-origin requests.

```text
Browser
   ↓
OPTIONS (preflight)
   ↓
Server
   ↓
Permission / CORS headers
   ↓
Actual request
```

🔥 Very important for interviews.

---

# 10. Safe vs Idempotent ⭐⭐⭐⭐⭐

### Safe

Does not intentionally modify server state.

Safe methods:

```text
GET
HEAD
OPTIONS
```

### Idempotent

Making the same request multiple times has the **same intended effect on server state** as making it once.

Common idempotent methods:

```text
GET
HEAD
OPTIONS
PUT
DELETE
```

### Important

**Idempotent ≠ response will always be identical.**

Example:

```text
DELETE /user/10
```

First request → 200 OK

Second request → 404 Not Found

The responses differ, but the intended server-state effect is still idempotent.

---

# 11. PUT vs PATCH ⭐⭐⭐⭐⭐

| PUT                               | PATCH                     |
| --------------------------------- | ------------------------- |
| Replace resource representation   | Partial modification      |
| Usually sends full representation | Sends only changes        |
| Idempotent                        | Not inherently idempotent |
| `/users/10`                       | `/users/10`               |

🔥 Interview question:

> **PUT = replace**
> **PATCH = modify part**

---

# 12. POST vs PUT ⭐⭐⭐⭐⭐

### POST

```http
POST /users
```

Server decides the new resource URI.

### PUT

```http
PUT /users/10
```

Client specifies the target URI.

Also:

* POST → generally non-idempotent
* PUT → idempotent

---

# 🔥 Interview / GATE Traps

1. **GET → retrieve**
2. **POST → submit/create**
3. **PUT → replace**
4. **PATCH → partial update**
5. **DELETE → delete**
6. **HEAD → headers without response body**
7. **OPTIONS → supported methods/options**
8. GET is **safe + idempotent**.
9. POST is generally **not idempotent**.
10. PUT is **idempotent**.
11. DELETE is **idempotent** in HTTP semantics.
12. PATCH is **not inherently idempotent**.
13. **Safe ≠ Idempotent.**
14. OPTIONS is important in **CORS preflight**.
15. Idempotent does **not** mean every response is identical.

---

# ⚡ 30-Second Revision

```text
GET     → READ
POST    → CREATE / SUBMIT
PUT     → REPLACE
PATCH   → PARTIAL UPDATE
DELETE  → DELETE
HEAD    → HEADERS ONLY
OPTIONS → OPTIONS / CORS PREFLIGHT
```

```text
Safe:
GET + HEAD + OPTIONS

Idempotent:
GET + HEAD + OPTIONS
+ PUT + DELETE
```

### 🎯 Priority

**Placement:** ⭐⭐⭐⭐⭐
**GATE:** ⭐⭐⭐⭐

```
```
