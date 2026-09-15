````md id="cdn"
# CDN

## 1. What is a CDN?

**CDN = Content Delivery Network**

A CDN is a distributed network of servers that delivers content from a location **closer to the user**.

> **CDN = bring content closer to users → lower latency + reduced origin load.**

```text
                Origin Server
                     │
          ┌──────────┼──────────┐
          ↓          ↓          ↓
       CDN PoP     CDN PoP    CDN PoP
       Mumbai       Delhi      Singapore
          ↓          ↓          ↓
        Users      Users       Users
````

---

# 2. Why CDN? ⭐⭐⭐⭐⭐

Without CDN:

```text
User → Internet → Origin Server
```

With CDN:

```text
User → Nearby CDN Edge → Content
```

Benefits:

* Lower latency
* Faster content delivery
* Reduced origin-server load
* Better scalability
* Improved availability

---

# 3. Edge Server / PoP ⭐⭐⭐⭐⭐

### Edge Server

A CDN server located closer to users.

### PoP — Point of Presence

A physical/network location where CDN infrastructure is deployed.

```text
User in Pune
     ↓
Nearby CDN Edge
     ↓
Content
```

🔥 The edge server may serve cached content without contacting the origin.

---

# 4. CDN Cache ⭐⭐⭐⭐⭐

The CDN stores frequently requested content in its cache.

```text id="5z5y7x"
User
 ↓
CDN Edge
 ↓
Cache HIT?
 ├── YES → Return content
 └── NO
       ↓
    Origin
       ↓
    Cache content
       ↓
    Return to user
```

### Cache Hit

Content exists at CDN.

```text
User → CDN → Content
```

### Cache Miss

Content isn't available at CDN.

```text
User → CDN → Origin → CDN → User
```

---

# 5. What Does a CDN Cache?

Commonly cacheable content:

* Images
* CSS
* JavaScript
* Videos
* Fonts
* Static HTML
* Other static assets

Dynamic/personalized content may require different caching strategies.

🔥 **Not everything should be cached.**

---

# 6. CDN vs Origin Server ⭐⭐⭐⭐⭐

| CDN                      | Origin                                  |
| ------------------------ | --------------------------------------- |
| Distributed edge servers | Source/backend server                   |
| Close to users           | Usually centralized/primary             |
| Serves cached content    | Generates/provides original content     |
| Reduces origin load      | Handles cache misses/dynamic processing |

```text
User
 ↓
CDN
 ↓ cache miss
Origin
```

---

# 7. CDN and DNS ⭐⭐⭐⭐⭐

DNS is often used to direct users toward an appropriate CDN endpoint.

Simplified:

```text
User
 ↓
DNS
 ↓
CDN Edge IP
 ↓
CDN
 ↓
Content
```

CDNs can use DNS-based routing and other mechanisms to direct users to suitable locations.

🔥 **DNS itself is not the CDN.**

---

# 8. CDN vs Load Balancer ⭐⭐⭐⭐⭐

### Load Balancer

Usually distributes requests among backend servers.

```text
Client
   ↓
Load Balancer
   ↓
S1 S2 S3
```

### CDN

Distributes/caches content geographically.

```text
Users
 ↓
Nearby CDN Edge
 ↓
Cached Content
```

| Load Balancer                  | CDN                                       |
| ------------------------------ | ----------------------------------------- |
| Distributes traffic            | Distributes content geographically        |
| Usually backend/server focused | Edge/cache focused                        |
| Improves server scalability    | Improves delivery performance/scalability |

They can be used **together**.

---

# 9. CDN + Reverse Proxy ⭐⭐⭐⭐

A CDN edge server often behaves like a reverse proxy:

```text
User
 ↓
CDN Edge / Reverse Proxy
 ↓
Origin
```

It can:

* Cache responses
* Forward requests
* Terminate TLS
* Apply security policies

---

# 10. Cache-Control ⭐⭐⭐⭐⭐

HTTP provides caching headers.

Example:

```http
Cache-Control: max-age=3600
```

Means the response can generally be considered fresh for the specified lifetime, subject to caching rules.

Other important directives:

```text
public
private
no-cache
no-store
max-age
```

### Important distinction

**`no-cache` ≠ `no-store`**

* `no-cache` → may store, but must revalidate before reuse when required.
* `no-store` → don't store the response.

🔥 Very common interview trap.

---

# 11. CDN Invalidation / Purging ⭐⭐⭐⭐

Suppose a website updates:

```text
logo.png → new version
```

Old version may still exist in CDN caches.

The CDN can perform:

**Cache invalidation/purge**

```text
Old cached content
       ↓
   Invalidate
       ↓
Next request → Fresh content
```

Another common technique is **cache busting**:

```text
app.v1.js
app.v2.js
```

Different URL → different cache key.

---

# 12. CDN and Availability

Because content is distributed across multiple edge locations:

```text
Edge A ❌
   ↓
Edge B ✅
   ↓
User
```

A CDN can improve resilience.

🔥 But a CDN does **not automatically guarantee** high availability for every origin/application component.

---

# 🔥 Interview / GATE Traps

1. **CDN = Content Delivery Network.**
2. Main idea → content closer to users.
3. CDN edge servers cache content.
4. **Cache hit → served from cache.**
5. **Cache miss → fetch from origin** (or another configured source).
6. CDN reduces origin load.
7. CDN can reduce latency.
8. CDN ≠ DNS.
9. CDN ≠ load balancer.
10. CDN and load balancer can work together.
11. Static assets are commonly cached.
12. Personalized/dynamic responses require careful caching.
13. `no-cache` ≠ `no-store`.
14. Cache invalidation removes/invalidates stale cached content.
15. CDN edge locations are often called **PoPs (Points of Presence)**.

---

# ⚡ 30-Second Revision

```text id="l3lq88"
User
 ↓
Nearest CDN Edge
 ↓
Cache Hit?
 ├── YES → Return
 └── NO
      ↓
    Origin
      ↓
   Cache + Return
```

### Remember

```text
CDN
 ↓
Geographically distributed
 ↓
Edge caching
 ↓
Lower latency
 ↓
Less origin load
```

```text
Load Balancer → distributes requests
CDN           → distributes/caches content
DNS           → resolves names
Reverse Proxy → represents/forwards to backend
```

### 🎯 Priority

**Placement:** ⭐⭐⭐⭐⭐
**GATE:** ⭐⭐⭐⭐

```

**Next: `WebSocket.md`**.
```
