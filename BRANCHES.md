# 🚀 Branch Guide for the Project

This document outlines the use of branches within the project and the steps to follow for incorporating changes from feature branches into a base branch (`develop`).

## 📌 Workflow

### 1️⃣ Create the Development Branch (if it doesn't exist)
```sh
git checkout master
git pull origin master
git checkout -b develop
git push origin develop
```

### 2️⃣ Integrate Changes from a Feature Branch to `develop`
To bring changes from a specific branch (`feature-branch`) into `develop`, use:
```sh
git checkout develop
git pull origin develop
git merge feature-branch
git push origin develop
```

### 3️⃣ Delete the Branch After Merging (optional)

```sh
git branch -d feature-branch  # Local
git push origin --delete feature-branch  # Remote
```

---

## 🌿 Branches and Purpose

| Branch                                   | Description                                                         |
|------------------------------------------|---------------------------------------------------------------------|
| `master`                                 | Stable version ready for production.                                |
| `develop`                                | Main branch for integrating new features before moving to `master`  |
| `firebase-implementation`                | Firebase implementation in the project.                             |
| `push-notifications-implementation`      | Implementation of push and local notifications.                     |
| `auto-update-version-app-implementation` | Implementation of auto-incrementing the version with `bumpversion`. |
| `google-sign-in-implementation`          | Implementation of Google Sign-In feature.                           |

---

🚀 Example: Integrating `push-notifications-implementation` and `auto-update-version-app-implementation`

If you want to integrate the changes from both branches into develop, follow these steps:

```sh
git checkout develop
git pull origin develop
git merge push-notifications-implementation
git merge auto-update-version-app-implementation
git push origin develop
```