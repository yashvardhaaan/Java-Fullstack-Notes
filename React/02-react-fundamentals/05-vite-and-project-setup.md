# 05 — Vite & React Project Setup

## WHY?

### Why do we use Vite with React?

React helps us **build the UI**, but we also need tools to:

* Start a development server
* Bundle application code
* Process modules
* Handle JSX
* Optimize the application for production
* Provide fast development feedback

**Vite** provides this development and build tooling.

Instead of manually configuring everything, Vite gives us a ready-to-use React project.

---

# WHAT?

## What is Vite?

Vite is a **frontend build tool** used to develop and build modern web applications.

It can be used with React and other frontend frameworks.

A React + Vite application typically contains:

```text
React
  ↓
UI / Components

Vite
  ↓
Development + Build Tool
```

### Important distinction

```text
React → UI library

Vite → Development/build tool
```

Vite is **not React**.

---

# WHERE?

## Where is Vite used?

Vite is used during the development and build process of frontend applications.

For example:

```text
Your Code
   ↓
React + JSX
   ↓
Vite
   ↓
Development Server
   ↓
Browser
```

For production:

```text
React Application
       ↓
Vite Build
       ↓
Production Assets
       ↓
Web Server / Hosting
```

---

# HOW?

## How do we create a React project using Vite?

First, make sure Node.js and npm are installed.

Check:

```bash
node -v
```

```bash
npm -v
```

Then create the project:

```bash
npm create vite@latest my-react-app
```

Vite asks you to select a framework.

Choose:

```text
React
```

Then choose a variant, for example:

```text
JavaScript
```

---

## Install Dependencies

Move into the project:

```bash
cd my-react-app
```

Install dependencies:

```bash
npm install
```

Then start the development server:

```bash
npm run dev
```

You will get a local development URL.

Open that URL in your browser.

---

# COMPLETE SETUP FLOW

```text
npm create vite@latest my-react-app
              ↓
        Select React
              ↓
       Select JavaScript
              ↓
        cd my-react-app
              ↓
         npm install
              ↓
        npm run dev
              ↓
          Browser
```

---

# What Does `npm install` Do?

## WHY?

The project needs external packages to run.

## WHAT?

`npm install` installs the dependencies defined in `package.json`.

Example:

```bash
npm install
```

Conceptually:

```text
package.json
     ↓
npm install
     ↓
node_modules/
```

---

# What is `package.json`?

`package.json` contains information about the project and its dependencies/scripts.

Example:

```json
{
  "name": "my-react-app",
  "scripts": {
    "dev": "vite",
    "build": "vite build"
  }
}
```

It can contain:

* Project name
* Dependencies
* Development dependencies
* Scripts
* Version information

---

# What is `node_modules`?

When you run:

```bash
npm install
```

npm downloads the project's required packages into:

```text
node_modules/
```

Example:

```text
my-react-app/
│
├── node_modules/
├── package.json
└── src/
```

### Important

You generally **do not manually edit `node_modules`**.

It is generated from your package configuration and lockfile.

---

# HOW DOES `npm run dev` WORK?

When you execute:

```bash
npm run dev
```

npm looks at the `scripts` section in `package.json`.

For example:

```json
{
  "scripts": {
    "dev": "vite"
  }
}
```

So:

```text
npm run dev
      ↓
package.json
      ↓
"dev": "vite"
      ↓
Vite starts
      ↓
Development server
```

---

# WHEN?

## When should I use Vite?

Use Vite when you want to create a modern frontend project and need a fast development/build workflow.

For a new React project, a common setup is:

```text
React + Vite
```

---

# Practical Example

Create a project:

```bash
npm create vite@latest student-dashboard
```

Select:

```text
Framework: React
Variant: JavaScript
```

Then:

```bash
cd student-dashboard
npm install
npm run dev
```

Now modify:

```text
src/App.jsx
```

For example:

```jsx
function App() {
  return (
    <div>
      <h1>Student Dashboard</h1>
      <button>Login</button>
    </div>
  );
}

export default App;
```

Save the file.

The development environment detects the change and updates the application in the browser.

---

# Vite Development vs Production

## Development

```bash
npm run dev
```

Used while developing.

```text
Developer
   ↓
Code changes
   ↓
Vite dev server
   ↓
Browser
```

---

## Production

When your application is ready:

```bash
npm run build
```

Vite creates an optimized production build.

Conceptually:

```text
Source Code
    ↓
npm run build
    ↓
Vite
    ↓
Production assets
    ↓
Deploy
```

---

# Common Commands

| Command                  | Purpose                              |
| ------------------------ | ------------------------------------ |
| `npm create vite@latest` | Create a Vite project                |
| `cd project-name`        | Enter project directory              |
| `npm install`            | Install dependencies                 |
| `npm run dev`            | Start development server             |
| `npm run build`          | Create production build              |
| `npm run preview`        | Preview the production build locally |

---

# Interview Questions

### Q1. What is Vite?

> Vite is a frontend build tool that provides a fast development server and production build workflow for modern web applications.

### Q2. Is Vite a React framework?

**No.**

Vite is a build/development tool. React is the UI library.

### Q3. Why do we use `npm install`?

> To install the dependencies specified by the project.

### Q4. What does `npm run dev` do?

> It runs the project's `dev` script, which in a typical Vite project starts the Vite development server.

### Q5. What does `npm run build` do?

> It creates a production-ready build of the application.

### Q6. What is `package.json`?

> It is the project's configuration/metadata file containing information such as dependencies and npm scripts.

---

# Remember

```text
React
 ↓
Build UI

Vite
 ↓
Develop + Build

npm
 ↓
Manage packages/scripts
```

### One-line interview answer

> **Vite is a modern frontend build tool commonly used with React to provide a fast development server and an optimized production build workflow.**
