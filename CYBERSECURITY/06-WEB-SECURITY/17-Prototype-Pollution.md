# `17-Prototype-Pollution.md`

# Prototype Pollution

## 1. First Principle

**Prototype Pollution** is a JavaScript vulnerability where attacker-controlled input modifies an object's prototype, potentially changing the behavior of many other objects in the application.

The core problem:

> **Untrusted data must not be allowed to modify JavaScript object prototypes.**

This is primarily relevant to **JavaScript/Node.js applications**.

---

# 2. JavaScript Prototypes

JavaScript objects can inherit properties from another object called a **prototype**.

Example:

```javascript
const user = {};

console.log(user.toString);
```

`toString` doesn't necessarily exist directly on `user`; it is inherited through the prototype chain.

Conceptually:

```text
user
  ↓
Object.prototype
  ↓
null
```

This is called the **prototype chain**.

---

# 3. What Is Prototype Pollution?

Normally:

```javascript
const user = {};
user.name = "Yash";
```

Only `user` is modified.

A dangerous operation may allow an attacker to manipulate:

```text
Object.prototype
```

If that happens:

```text
Object.prototype
       ↓
many JavaScript objects
```

can inherit the malicious property.

Conceptually:

```text
Object.prototype.isAdmin = true

        ↓

Object A → isAdmin = true
Object B → isAdmin = true
Object C → isAdmin = true
```

This is why prototype pollution can have application-wide consequences.

---

# 4. How It Happens

A common source is unsafe recursive object merging.

Example:

```javascript
function merge(target, source) {
    for (const key in source) {
        target[key] = source[key];
    }
}
```

If untrusted input controls property names, special JavaScript properties may cause unexpected prototype behavior.

Commonly relevant properties include:

```text
__proto__
constructor
prototype
```

The exact exploitability depends on the vulnerable code/library and JavaScript runtime behavior.

---

# 5. Industry-Level Example

Imagine a Node.js application processes user preferences:

```json
{
  "theme": "dark",
  "language": "en"
}
```

The application merges the user data into a configuration object:

```javascript
merge(config, userInput);
```

If the merge implementation is unsafe, specially crafted property names may modify inherited object behavior.

Potential flow:

```text
Attacker input
      ↓
Unsafe object merge
      ↓
Prototype modification
      ↓
Application objects inherit unexpected properties
      ↓
Security-sensitive behavior changes
```

---

# 6. Why It Can Become a Security Issue

Prototype pollution alone does not automatically mean account takeover or RCE.

Impact depends on **how polluted properties are later used**.

For example:

```javascript
if (options.isAdmin) {
    grantAdminAccess();
}
```

If `isAdmin` is inherited from a polluted prototype, the application may make an unsafe authorization decision.

Another application may use polluted properties to influence:

```text
Command execution
Template configuration
Access control
Object merging
Application settings
```

Therefore:

> **Prototype pollution becomes dangerous when polluted properties reach security-sensitive code.**

---

# 7. Prototype Pollution vs XSS

| Prototype Pollution | XSS |
|---|---|
| JavaScript object/prototype problem | Browser code-injection problem |
| Often involves object merging | Usually involves unsafe HTML/JS handling |
| Common in JS/Node.js ecosystems | Affects many web stacks |
| Can alter application logic | Can execute attacker-controlled browser code |

---

# 8. Common Vulnerable Pattern

Dangerous generic merging:

```javascript
function merge(target, source) {
    for (const key in source) {
        if (typeof source[key] === "object") {
            merge(target[key], source[key]);
        } else {
            target[key] = source[key];
        }
    }
}
```

The security problem is allowing attacker-controlled keys to recursively modify objects without restricting dangerous property names.

---

# 9. Safer Approach

### Validate property names

Reject unexpected special keys:

```javascript
const blocked = new Set([
    "__proto__",
    "prototype",
    "constructor"
]);
```

Then:

```javascript
if (blocked.has(key)) {
    continue;
}
```

But don't rely only on a blacklist when a safer data model is possible.

---

# 10. Prefer Explicit Schemas

Instead of accepting arbitrary objects:

```json
{
  "anything": "anything"
}
```

define what is actually allowed:

```json
{
  "theme": "dark",
  "language": "en"
}
```

Then validate against a schema.

For example:

```text
Input
 ↓
Schema validation
 ↓
Allowed fields only
 ↓
Application object
```

This is much safer than blindly merging arbitrary user-controlled objects.

---

# 11. Use Safer Object Construction

For data dictionaries, applications can use appropriate structures such as:

```javascript
const data = Object.create(null);
```

This creates an object without the normal `Object.prototype` inheritance.

However, this is **not a universal fix**. The application's libraries and logic still need to handle such objects correctly.

---

# 12. Dependency Risk

Prototype pollution has historically affected JavaScript libraries that perform operations such as:

```text
Deep merge
Object cloning
Configuration merging
Query-string parsing
Object path manipulation
```

Therefore:

```text
npm audit
```

and dependency updates are useful defensive measures.

For production:

```text
Keep dependencies patched
+
Remove unused packages
+
Pin/lock dependency versions
+
Review security advisories
```

---

# 13. Small Hands-On Lab

Create a local Node.js application.

Start with:

```javascript
const user = {};

console.log(user.isAdmin);
```

Normally:

```text
undefined
```

Then study how prototype inheritance works:

```javascript
const prototype = Object.getPrototypeOf(user);

console.log(prototype === Object.prototype);
```

Result:

```text
true
```

Now inspect your application's object-merging code.

Look for:

```text
Object.assign()
Deep merge utilities
Recursive merge functions
Query parsers
Configuration merging
```

Your goal is to identify whether untrusted keys can reach:

```text
__proto__
constructor
prototype
```

without modifying or attacking external systems.

---

# 14. SOC Relevance

Prototype pollution may be difficult to detect directly from HTTP logs.

Look for:

```text
Unexpected special JavaScript property names
Unusual nested JSON objects
Requests containing suspicious object structures
Application errors after configuration changes
Unexpected process behavior
Unexpected command execution
```

Potential investigation flow:

```text
Suspicious JSON request
        ↓
Node.js application
        ↓
Prototype-related error/behavior
        ↓
Unexpected application behavior
        ↓
Check process/network activity
```

If prototype pollution is followed by unexpected server-side command execution, investigate as a potentially serious compromise.

---

# 15. Common Developer Mistakes

### ❌ Blind object merging

```javascript
merge(config, req.body);
```

### ❌ Trusting arbitrary JSON structures

JSON syntax being valid does not mean the data is safe.

### ❌ Ignoring dependency vulnerabilities

A vulnerable merge/parser library can introduce prototype pollution.

### ❌ Using inherited properties for authorization

Prefer explicit, validated values.

### ❌ Assuming every prototype pollution equals RCE

Impact depends on the application's **pollution-to-sink** path.

---

# 16. Interview Questions

### Q1. What is Prototype Pollution?

A JavaScript vulnerability where attacker-controlled properties modify an object's prototype or prototype chain.

### Q2. Which properties are commonly associated with it?

```text
__proto__
constructor
prototype
```

### Q3. Why is it dangerous?

Polluted properties may influence many objects and potentially alter security-sensitive application behavior.

### Q4. Is Prototype Pollution automatically RCE?

No. RCE requires a suitable vulnerable execution path or "sink."

### Q5. How do you prevent it?

- Validate object schemas
- Allow only expected properties
- Avoid unsafe deep merges
- Block dangerous property names where appropriate
- Use safe data structures
- Keep dependencies patched

---

# 17. Quick Cheat Sheet

| Concept | Meaning |
|---|---|
| Prototype | Object from which properties can be inherited |
| Prototype chain | Chain used for property lookup |
| Prototype Pollution | Attacker modifies inherited object behavior |
| `__proto__` | Special prototype-related property |
| `constructor` | Constructor reference |
| `prototype` | Constructor's prototype object |
| Sink | Code where polluted data causes impact |
| Deep merge | Common source of risk |
| Main defense | Strict schemas + safe object handling |

---

# 18. Core Mental Model

```text
Untrusted JSON
      ↓
Object merge
      ↓
Dangerous property
      ↓
Prototype modified
      ↓
Many objects inherit property
      ↓
Security-sensitive code
      ↓
Potential impact
```

The key question is:

> **"Can attacker-controlled object properties modify something that other application objects trust?"**

### Next

`18-Clickjacking.md`