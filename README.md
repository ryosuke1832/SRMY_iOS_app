## GitHub Workflow Guide for Team Members

### ✅ Branching & Pull Request Workflow

In this project, we use a simple GitHub workflow where **no one pushes directly to `main`**.  
All changes should go through a **Pull Request (PR)**. You can **merge your own PRs without approval**.

---

### 🔧 Basic Workflow

1. **Create a new branch**
   ```bash
   git checkout -b feature/your-task
   ```

2. **Make changes & commit**
   ```bash
   git add .
   git commit -m "Describe your changes"
   ```

3. **Push to GitHub**
   ```bash
   git push origin feature/your-task
   ```

4. **Create a Pull Request on GitHub**
   - Base branch should be `main`
   - If you want a review, assign someone as a **Reviewer**

5. **Review and Merge the PR (by yourself)**
   - Approval is not required — **you can merge it yourself**
   - You can delete the branch after merging

6. **Pull the latest `main` branch**
   ```bash
   git checkout main
   git pull origin main
   ```

---

### 📌 Branch Naming Convention

| Type        | Example                   | Description                    |
|-------------|---------------------------|--------------------------------|
| Feature     | `feature/login-page`      | New features                   |
| Bug fix     | `fix/button-bug`          | Bug fixes                      |
| Docs update | `docs/update-readme`      | README or documentation edits  |

---

### 💡 Notes

- The `main` branch is protected. **Direct pushes are blocked**
- Using PRs helps track changes clearly
- Feel free to request a review, but it's not required

---
