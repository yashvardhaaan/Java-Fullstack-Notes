# 02 — Working Directory, Staging Area & Commits

> **Goal:** Understand exactly what happens from the moment you modify a file until that change becomes a Git commit.

This is the most important practical Git workflow:

```text
Working Directory
        ↓
     git add
        ↓
   Staging Area
        ↓
   git commit
        ↓
 Local Repository
```

If you understand this properly, commands like `status`, `add`, `commit`, `diff`, and `restore` become much easier.

---

# 1. The Three Important Areas of Git

Git can be understood through three main areas.

```text
┌──────────────────────┐
│  Working Directory   │
│  Your actual files   │
└──────────┬───────────┘
           │
        git add
           ↓
┌──────────────────────┐
│    Staging Area      │
│  Changes selected    │
│  for next commit     │
└──────────┬───────────┘
           │
       git commit
           ↓
┌──────────────────────┐
│ Local Repository     │
│    Git history       │
└──────────────────────┘
```

These three areas are fundamental to Git.

---

# 2. Working Directory

The **working directory** is the project you are actually working on.

For example:

```text
SeatForge/
├── src/
│   ├── main/
│   └── test/
├── pom.xml
└── README.md
```

You open these files in IntelliJ and modify them.

For example:

```java
public class UserService {

    public User getUser(Long id) {
        return repository.findById(id);
    }
}
```

You modify it:

```java
public class UserService {

    public User getUser(Long id) {
        return repository.findById(id)
                .orElseThrow();
    }
}
```

At this point:

```text
Working Directory
        ↓
UserService.java has changed
```

Git has **not created a commit** yet.

---

# 3. Checking the Current State

Run:

```bash
git status
```

You might see:

```text
On branch main

Changes not staged for commit:
    modified: src/main/java/UserService.java
```

This means:

```text
File changed
    ↓
Git detected the change
    ↓
Change is NOT staged
```

---

# 4. What Does "Modified" Mean?

Suppose your last commit contained:

```java
return repository.findById(id);
```

Your working file now contains:

```java
return repository.findById(id)
        .orElseThrow();
```

Git compares your current working file against the version recorded in Git.

Because they differ:

```text
HEAD version
     │
     │ comparison
     ↓
Working version
     │
     ↓
MODIFIED
```

---

# 5. `git diff`

To see exactly what changed:

```bash
git diff
```

Example:

```diff
- return repository.findById(id);
+ return repository.findById(id)
+         .orElseThrow();
```

The symbols mean:

```text
- removed
+ added
```

---

# 6. Why `git diff` Is Important

Before staging changes, use:

```bash
git diff
```

This helps you answer:

> "What exactly am I about to commit?"

This is especially useful before committing production code.

A good habit:

```bash
git status
git diff
```

Then decide what should be committed.

---

# 7. The Staging Area

The staging area is where you select changes for the next commit.

Suppose you changed:

```text
UserService.java
UserController.java
PaymentService.java
```

But you only want to commit:

```text
UserService.java
```

You can do:

```bash
git add UserService.java
```

Now:

```text
Working Directory
├── UserService.java       staged
├── UserController.java    unstaged
└── PaymentService.java    unstaged
```

This is one of the reasons Git has a staging area.

---

# 8. Why Not Commit Everything Automatically?

Because a single working session can contain multiple unrelated changes.

Example:

```text
You are working on authentication.

You changed:
    UserService.java
    AuthController.java

You also accidentally changed:
    README.md
    PaymentService.java
```

You probably don't want:

```bash
git add .
git commit -m "Authentication"
```

to include unrelated changes.

Instead:

```bash
git add UserService.java
git add AuthController.java
git commit -m "Add authentication logic"
```

This creates a clean commit.

---

# 9. `git add`

Basic syntax:

```bash
git add <file>
```

Example:

```bash
git add UserService.java
```

Multiple files:

```bash
git add UserService.java AuthController.java
```

Directory:

```bash
git add src/
```

Everything:

```bash
git add .
```

---

# 10. What Does `git add` Actually Do?

This is an important internal concept.

Many beginners think:

> "`git add` sends my files into Git."

Not exactly.

Git maintains an **index**, commonly called the **staging area**.

Conceptually:

```text
Working File
     │
     │ git add
     ↓
Git Index
     │
     │ git commit
     ↓
Commit
```

The index represents what the next commit should contain.

Therefore:

> `git add` updates the Git index with the version of the file you want included in the next commit.

The index is stored inside the repository, traditionally as:

```text
.git/index
```

We'll study the index in more detail in the Git internals files.

---

# 11. Staging Does Not Mean Committing

This distinction is extremely important.

```bash
git add UserService.java
```

does **not** create a commit.

It only stages the change.

You still need:

```bash
git commit -m "Update user service"
```

The workflow is:

```text
Modify file
    ↓
git add
    ↓
Staged
    ↓
git commit
    ↓
Committed
```

---

# 12. Checking Staged Changes

After:

```bash
git add UserService.java
```

run:

```bash
git status
```

You may see:

```text
Changes to be committed:
    modified: UserService.java
```

Now the change is staged.

To see the staged difference:

```bash
git diff --staged
```

or:

```bash
git diff --cached
```

Both inspect staged changes.

---

# 13. Two Types of `git diff`

This distinction is very useful.

### `git diff`

Shows:

```text
Working Directory
        ↓
Staging Area
```

In other words:

> What have I changed that I have NOT staged?

---

### `git diff --staged`

Shows:

```text
Staging Area
        ↓
HEAD / Last Commit
```

In other words:

> What exactly am I about to commit?

---

# 14. Important Mental Model

Think of it like this:

```text
                 HEAD
                  │
                  │
             Last commit
                  ↑
                  │
       git diff --staged
                  │
                  │
             STAGING
                  ↑
                  │
             git diff
                  │
                  │
          WORKING DIRECTORY
```

This model is extremely useful.

---

# 15. Creating a Commit

Once your changes are staged:

```bash
git commit -m "Add user authentication"
```

Git creates a new commit.

Example:

```text
A ─── B ─── C
          ↑
        HEAD
```

Before the commit:

```text
A ─── B
      ↑
     HEAD
```

After the commit:

```text
A ─── B ─── C
          ↑
         HEAD
```

The new commit becomes the current point in history.

---

# 16. What Happens Internally During `git commit`?

Conceptually, several things happen.

Suppose:

```text
UserService.java
```

was staged.

Git has the content represented as an object.

Git then creates a tree representing the project directory structure.

Then Git creates a commit object containing information such as:

```text
tree <tree-hash>
parent <previous-commit-hash>
author <author-information>
committer <committer-information>

Add user authentication
```

Conceptually:

```text
Commit
  │
  ├── parent → previous commit
  │
  └── tree
       ├── UserService.java → blob
       ├── UserController.java → blob
       └── ...
```

We'll go much deeper into this in:

```text
03-commits-history-and-git-internals.md
```

---

# 17. Commit Messages

Good:

```bash
git commit -m "Add JWT authentication"
```

Bad:

```bash
git commit -m "changes"
```

Bad:

```bash
git commit -m "update"
```

Good commit messages describe the change.

Examples:

```text
Add user registration endpoint
Fix JWT expiration handling
Add PostgreSQL configuration
Implement payment service
Fix null pointer in UserService
```

---

# 18. Atomic Commits

A good commit should ideally represent **one logical change**.

Bad:

```text
Commit:
"Update everything"

Changes:
- Authentication
- Payment
- README
- Database
- UI
```

Better:

```text
Commit 1:
Add JWT authentication

Commit 2:
Add payment service

Commit 3:
Update database configuration

Commit 4:
Update README
```

This makes history easier to understand and revert.

---

# 19. `git status`

`git status` is one of the commands you'll use constantly.

Use it when:

* You don't know what changed.
* You don't know what is staged.
* You don't know what branch you're on.
* You want to check before committing.
* You want to understand Git's current state.

Example:

```bash
git status
```

Typical output:

```text
On branch feature/auth

Changes to be committed:
    modified: AuthService.java

Changes not staged for commit:
    modified: README.md

Untracked files:
    AuthController.java
```

This tells you three things:

```text
STAGED
AuthService.java

UNSTAGED
README.md

UNTRACKED
AuthController.java
```

---

# 20. Untracked Files

Suppose you create:

```text
PaymentService.java
```

Git hasn't seen this file before.

Run:

```bash
git status
```

You may see:

```text
Untracked files:
    PaymentService.java
```

Git knows the file exists, but it isn't currently part of the tracked project state.

Stage it:

```bash
git add PaymentService.java
```

Now it becomes staged.

---

# 21. Tracked vs Untracked

### Untracked

Git isn't currently tracking the file.

```text
new-file.java
```

### Tracked

Git knows about the file through its repository/index/history.

```text
UserService.java
```

A tracked file can still be:

```text
modified
staged
committed
deleted
```

---

# 22. `.gitignore`

Some files should never be committed.

For a Java/Spring Boot project, examples include:

```text
target/
.idea/
*.iml
.env
*.log
```

Create:

```text
.gitignore
```

Example:

```gitignore
target/
.idea/
*.iml
.env
*.log
```

Then:

```bash
git status
```

ignored files won't normally appear as untracked files.

---

# 23. Why `.gitignore` Matters

You don't want to commit:

```text
passwords
API keys
environment variables
compiled files
IDE configuration
logs
temporary files
```

For example:

```text
.env
```

might contain:

```text
DATABASE_PASSWORD=secret
JWT_SECRET=secret
```

Never commit secrets.

---

# 24. `git restore`

Suppose you modified:

```text
UserService.java
```

but you don't want your changes anymore.

You can restore the working file:

```bash
git restore UserService.java
```

Conceptually:

```text
Current working file
        ↓
discard changes
        ↓
version from index/HEAD
```

Be careful:

> This can discard uncommitted work.

---

# 25. Unstage a File

Suppose:

```bash
git add UserService.java
```

but you changed your mind.

You can unstage it:

```bash
git restore --staged UserService.java
```

This does **not normally delete your modifications**.

It moves the file out of the staging area.

Conceptually:

```text
Staged
  ↓
git restore --staged
  ↓
Unstaged
```

---

# 26. Practical Workflow

Use this workflow in your projects.

### Step 1 — Check status

```bash
git status
```

### Step 2 — Inspect changes

```bash
git diff
```

### Step 3 — Stage relevant files

```bash
git add src/main/java/UserService.java
```

### Step 4 — Inspect staged changes

```bash
git diff --staged
```

### Step 5 — Commit

```bash
git commit -m "Update user service"
```

### Step 6 — Verify

```bash
git status
```

---

# 27. Real Spring Boot Example

Suppose you're developing SeatForge.

You modify:

```text
src/main/java/
├── controller/
│   └── UserController.java
├── service/
│   └── UserService.java
└── repository/
    └── UserRepository.java
```

You also accidentally modify:

```text
README.md
```

You want only the user feature.

Run:

```bash
git status
```

Then:

```bash
git diff
```

Stage only the relevant files:

```bash
git add src/main/java/controller/UserController.java
git add src/main/java/service/UserService.java
git add src/main/java/repository/UserRepository.java
```

Check:

```bash
git diff --staged
```

Commit:

```bash
git commit -m "Add user management"
```

Now your README change remains unstaged.

This is a clean Git workflow.

---

# 28. Common Beginner Mistakes

## Mistake 1 — Thinking `git add` commits

Wrong:

```text
git add = commit
```

Correct:

```text
git add
→ staging

git commit
→ repository history
```

---

## Mistake 2 — Always using `git add .`

This isn't inherently wrong, but blindly doing:

```bash
git add .
```

can stage things you didn't intend to commit.

Before using it, inspect:

```bash
git status
```

and:

```bash
git diff
```

---

## Mistake 3 — Not reviewing staged changes

Before important commits:

```bash
git diff --staged
```

This helps prevent accidental commits.

---

## Mistake 4 — Huge commits

Avoid:

```text
"Final project changes"
```

with hundreds of unrelated modifications.

Prefer small logical commits.

---

# 29. Interview Questions

### Q1. What is the difference between working directory, staging area, and repository?

**Answer:**

```text
Working Directory
→ Current files being edited.

Staging Area
→ Changes selected for the next commit.

Repository
→ Stored Git history containing commits and related objects.
```

---

### Q2. What does `git add` do?

`git add` updates the Git index/staging area with the current contents of selected files so those changes can be included in the next commit.

---

### Q3. Does `git add` create a commit?

No.

```text
git add
→ staging

git commit
→ commit creation
```

---

### Q4. Difference between `git diff` and `git diff --staged`?

```text
git diff
→ unstaged changes

git diff --staged
→ staged changes
```

---

### Q5. What is a commit?

A commit is a recorded point in Git history containing metadata and a reference to the project's directory tree.

---

### Q6. What is `.git`?

`.git` is the repository's internal directory containing Git metadata, references, objects, configuration, and the index.

---

### Q7. What is `.gitignore`?

`.gitignore` specifies files and patterns that Git should normally ignore when detecting untracked files.

---

### Q8. What is an untracked file?

A file that exists in the working directory but isn't currently tracked by Git.

---

# 30. Hands-On Practice

Create a test repository.

```bash
mkdir git-practice
cd git-practice
git init
```

Create:

```text
app.txt
```

Put:

```text
Hello Git
```

inside it.

Check:

```bash
git status
```

Stage:

```bash
git add app.txt
```

Check:

```bash
git status
```

Commit:

```bash
git commit -m "Add app file"
```

Modify `app.txt`:

```text
Hello Git
Learning Git deeply
```

Run:

```bash
git diff
```

Stage:

```bash
git add app.txt
```

Run:

```bash
git diff --staged
```

Commit:

```bash
git commit -m "Update app file"
```

Finally:

```bash
git log
```

You should now have:

```text
Commit 2
   ↓
Commit 1
```

---

# 31. Commands to Remember

```bash
git status
git diff
git diff --staged

git add <file>
git add .

git commit -m "message"

git restore <file>
git restore --staged <file>

git log
```

---

# 32. 20/80 Summary

If you remember only the most important concepts from this file:

```text
Working Directory
        ↓
    git add
        ↓
Staging Area / Index
        ↓
   git commit
        ↓
Local Repository
```

And:

```text
git status
→ What is Git's current state?

git diff
→ What did I change but haven't staged?

git diff --staged
→ What am I about to commit?

git add
→ Select changes for next commit.

git commit
→ Record a new point in Git history.

git restore
→ Discard/restore working-tree changes.

git restore --staged
→ Unstage changes.
```

The key mental model:

> **You edit files in the Working Directory, select changes in the Staging Area, and permanently record those selected changes as commits in the Repository.**
