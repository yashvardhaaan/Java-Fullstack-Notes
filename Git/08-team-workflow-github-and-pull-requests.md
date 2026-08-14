# 08 — Team Workflow, GitHub and Pull Requests

> **Goal:** Learn how Git is actually used when multiple developers work on the same project.

---

## 1. Git vs GitHub

### Git

Git is a **distributed version control system**.

It runs locally on your machine and manages:

* commits
* branches
* history
* merges
* conflicts
* tags
* repository objects

### GitHub

GitHub is a **remote hosting and collaboration platform**.

It provides:

* remote repositories
* Pull Requests
* code reviews
* issues
* Actions/CI
* permissions
* releases

Think:

```text
Git
 ↓
Version control system

GitHub
 ↓
Collaboration + remote hosting
```

---

# 2. Typical Team Workflow

Suppose four developers work on a project:

```text
main
 │
 ├── feature/login
 ├── feature/payment
 ├── feature/orders
 └── bugfix/cart
```

Developers normally don't directly modify `main`.

A typical workflow is:

```text
Clone
  ↓
Create branch
  ↓
Write code
  ↓
git add
  ↓
git commit
  ↓
git push
  ↓
Create Pull Request
  ↓
Code Review
  ↓
CI Tests
  ↓
Merge
  ↓
Delete branch
```

---

# 3. Clone the Repository

```bash
git clone https://github.com/company/project.git
```

This:

1. Downloads repository data.
2. Creates a local `.git` directory.
3. Creates a working directory.
4. Configures the remote as `origin`.
5. Checks out the default branch.

Check:

```bash
git remote -v
```

Example:

```text
origin  https://github.com/company/project.git (fetch)
origin  https://github.com/company/project.git (push)
```

---

# 4. Create a Feature Branch

Never start feature development directly on `main`.

```bash
git switch main
git pull origin main
git switch -c feature/user-login
```

Older syntax:

```bash
git checkout -b feature/user-login
```

Recommended modern command:

```bash
git switch -c feature/user-login
```

---

# 5. Why Branches?

Suppose:

```text
main
 |
 A---B---C
```

You create:

```text
feature/login
 |
 A---B---C---D---E
```

Meanwhile another developer works on:

```text
feature/payment
 |
 A---B---C---F---G
```

The developers can work independently.

---

# 6. Make Changes

Check the current state:

```bash
git status
```

Inspect changes:

```bash
git diff
```

Stage:

```bash
git add .
```

Commit:

```bash
git commit -m "Add user login"
```

---

# 7. Push a New Branch

```bash
git push -u origin feature/user-login
```

`-u` establishes the upstream relationship.

After that:

```bash
git push
```

is enough.

You can check it using:

```bash
git branch -vv
```

---

# 8. Pull Request

A Pull Request asks:

> "Can the changes from my branch be reviewed and merged into another branch?"

Usually:

```text
feature/user-login
        ↓
      Pull Request
        ↓
       main
```

A Pull Request normally contains:

* description
* changed files
* commits
* reviewers
* CI results
* comments
* approval status

---

# 9. Pull Request Is Not a Git Command

Important interview point:

**Pull Request is a GitHub/GitLab/Bitbucket concept, not a native Git command.**

Git provides:

```bash
git merge
git rebase
git push
git fetch
```

GitHub provides:

```text
Pull Request
Code Review
CI Checks
Branch Protection
```

---

# 10. Code Review

A reviewer checks:

### Correctness

Does the code work?

### Design

Is the implementation appropriate?

### Maintainability

Can another developer understand it?

### Security

Are credentials or vulnerabilities introduced?

### Testing

Are important cases covered?

### Performance

Does the implementation create unnecessary overhead?

---

# 11. Keeping Your Branch Updated

Suppose:

```text
main:
A---B---C---D

feature:
A---B---C---E---F
```

Someone added `D` to `main`.

Before creating the PR, update your branch.

### Option 1 — Merge

```bash
git fetch origin
git merge origin/main
```

Result:

```text
A---B---C---D
         \   \
          E---F---M
```

### Option 2 — Rebase

```bash
git fetch origin
git rebase origin/main
```

Result:

```text
A---B---C---D---E'---F'
```

Rebase creates new commit IDs.

---

# 12. Fetch Before Pull

A useful workflow:

```bash
git fetch origin
```

Then inspect:

```bash
git log --oneline main..origin/main
```

Then decide whether to:

```bash
git merge origin/main
```

or:

```bash
git rebase origin/main
```

---

# 13. `git pull`

`git pull` is essentially:

```bash
git fetch
+
git merge
```

Depending on configuration, pull may also use rebase.

Explicit:

```bash
git pull --rebase origin main
```

---

# 14. Branch Naming

Good:

```text
feature/user-authentication
feature/payment-integration
bugfix/login-timeout
hotfix/payment-crash
refactor/order-service
docs/api-documentation
```

Bad:

```text
test
new
changes
abc
final
final2
newbranch
```

---

# 15. Commit Message Convention

Good:

```bash
git commit -m "Add JWT authentication"
```

Better:

```text
feat: add JWT authentication
fix: resolve duplicate order creation
refactor: simplify payment service
docs: update API documentation
test: add order service tests
chore: update dependencies
```

Common categories:

```text
feat
fix
refactor
test
docs
chore
perf
build
ci
```

---

# 16. Small Commits

Avoid:

```text
commit: completed entire application
```

Prefer:

```text
feat: add user entity
feat: add user repository
feat: add authentication service
test: add authentication tests
```

Small commits are easier to:

* review
* debug
* revert
* cherry-pick
* understand

---

# 17. What Happens Internally During Push?

When you run:

```bash
git push origin feature/login
```

Git roughly performs:

```text
Local repository
      ↓
Find commits remote doesn't have
      ↓
Compress objects
      ↓
Send objects to server
      ↓
Remote updates branch reference
```

Git transfers objects such as:

```text
commit
tree
blob
```

The remote branch is essentially a reference:

```text
refs/heads/feature/login
```

pointing to a commit.

---

# 18. Fork vs Clone

### Clone

You have permission to access the repository.

```bash
git clone <repository>
```

### Fork

You create your own GitHub copy of another repository.

```text
Original Repository
        ↓
      Fork
        ↓
Your Repository
```

Common in open-source projects.

---

# 19. Upstream and Origin

Example:

```text
origin
 ↓
your GitHub repository

upstream
 ↓
original repository
```

Add upstream:

```bash
git remote add upstream https://github.com/company/project.git
```

Check:

```bash
git remote -v
```

---

# 20. Sync a Fork

```bash
git fetch upstream
git switch main
git merge upstream/main
git push origin main
```

Or:

```bash
git rebase upstream/main
```

---

# 21. Branch Protection

Teams commonly protect:

```text
main
```

Rules may require:

* Pull Request
* approval
* successful CI
* no direct pushes
* branch up to date
* tests passing

This prevents accidental production-breaking changes.

---

# 22. Typical Professional Workflow

```bash
git switch main

git pull --rebase origin main

git switch -c feature/order-api

# write code

git status

git diff

git add .

git commit -m "feat: add order API"

git push -u origin feature/order-api
```

Then:

```text
GitHub
 ↓
Pull Request
 ↓
Review
 ↓
CI
 ↓
Approval
 ↓
Merge
```

After merge:

```bash
git switch main
git pull origin main

git branch -d feature/order-api
```

---

# 23. Interview Questions

### What is Git?

A distributed version control system used to track changes in files.

### What is GitHub?

A platform for hosting Git repositories and collaborating around them.

### What is a Pull Request?

A request to merge changes from one branch into another, usually with code review and CI.

### Is Pull Request part of Git?

No. It is provided by platforms such as GitHub.

### Why use feature branches?

To isolate work and prevent unfinished changes from directly affecting stable branches.

### `git fetch` vs `git pull`?

`fetch` downloads remote information without modifying your working branch.

`pull` fetches and then integrates the changes.

### What is `origin`?

The conventional name for the remote repository from which the repository was cloned.

### Why are small commits useful?

They improve reviewability, debugging, reverting, and collaboration.

---

# 24. Golden Workflow

Remember:

```text
UPDATE
   ↓
BRANCH
   ↓
CODE
   ↓
TEST
   ↓
COMMIT
   ↓
PUSH
   ↓
PULL REQUEST
   ↓
REVIEW
   ↓
CI
   ↓
MERGE
   ↓
DELETE BRANCH
```

This is the workflow you should become comfortable with in real projects.
