# 🛠️ Flutter Development & Code Review SOP (Part 2)

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Code Quality](https://img.shields.io/badge/Code_Quality-A+-brightgreen?style=for-the-badge)](.)

**Focus:** `Feature Implementation` | `Quality Control` | `Code Review Standards`

*Ensuring code moves from a developer's machine to a high-quality Pull Request*



---



## 📋 Table of Contents

| # | Section | Description |
|:-:|:--------|:------------|
| 1 | [🌿 Branching Strategy](#-branching-strategy-gitflow-lite) | GitFlow Lite conventions |
| 2 | [🏗️ Feature Development](#️-feature-development-workflow) | Lead-Approved development pattern |
| 3 | [🔍 Code Review Checklist](#-the-lead-code-review-checklist) | The 4 Pillars of code review |
| 4 | [🤖 Pre-PR Automation](#-automation-the-pre-pr-check) | Magic command before every PR |
| 5 | [📦 PR Template](#-pull-request-template) | Standard PR format |
| 6 | [🚀 Interview Pitch](#-how-to-pitch-part-2-to-the-cto) | Presenting to leadership |



---
---



# 🌿 Branching Strategy (GitFlow Lite)

To ensure the `main` branch is always stable and ready for client demos, every developer must follow this branching convention:


## Branch Types

| Branch Type | Naming Convention | Purpose |
|:------------|:------------------|:--------|
| **Feature** | `feat/[jira-id]-short-desc` | New features or UI components |
| **Bug Fix** | `fix/[jira-id]-short-desc` | Fixing a bug in a current sprint |
| **Hotfix** | `hotfix/urgent-issue` | Emergency fixes directly to production |


## Command

    git checkout -b feat/SAM-101-login-logic


### 📝 Examples

- `feat/SAM-101-login-logic`
- `fix/SAM-202-overflow-home`
- `hotfix/crash-on-launch`



---
---



# 🏗️ Feature Development Workflow

Before a developer considers a task "Done," they must follow the **Lead-Approved Pattern**:


## The 4-Step Pattern

**Step 1** — Model Creation

Use `json_serializable` or `Freezed` for data safety.

    @freezed
    class User with _$User {
      factory User({
        required String id,
        required String name,
      }) = _User;
    }


**Step 2** — Logic Layer

Implement business logic in a `Bloc` or `Controller`.

⚠️ **No logic allowed in the UI/View.**


**Step 3** — UI Implementation

Use the **Manifesto Extensions** for styling:

    Text(
      'Welcome',
      style: context.textTheme.headlineMedium,
    )


**Step 4** — Self-QA

Run the app on both devices to check for overflows:

| Platform | Device Type |
|:---------|:------------|
| Android | Small-screen (e.g., Pixel 4a) |
| iOS | Large-screen (e.g., iPhone 15 Pro Max) |



---
---



# 🔍 The "Lead" Code Review Checklist

As a Training Lead, you (or your senior devs) will review code based on these **4 Pillars**. Any PR failing these is sent back for refactoring.


## The 4 Pillars

| Pillar | What We Check For |
|:-------|:------------------|
| **🏛️ Architecture** | Is the logic strictly separated from the UI? Are Repositories used? |
| **⚡ Performance** | Are there unnecessary `setState` calls? Are heavy widgets `const`? |
| **📖 Readability** | Are variable names descriptive? (Avoid `var a;` → use `var userList;`) |
| **🛡️ Safety** | Are null-checks handled? Are controllers properly disposed of? |


### ❌ Common Rejection Reasons

- Business logic inside `build()` method
- Missing `const` constructors on stateless widgets
- Unused imports or variables
- Controllers not disposed in `dispose()` method
- Hardcoded strings instead of constants



---
---



# 🤖 Automation: The Pre-PR Check

To save your time as a Lead, developers must run this "Magic Command" before requesting a review. If these fail, the PR is rejected automatically.


## The Magic Command

    dart format . && flutter analyze && flutter test


### What It Does

| Command | Purpose |
|:--------|:--------|
| `dart format .` | Formats all Dart files consistently |
| `flutter analyze` | Checks for linting errors and warnings |
| `flutter test` | Runs all unit and widget tests |


### 🚨 Lead Note

If `flutter analyze` shows even **one** warning, the developer must fix it.

**We maintain zero-warning codebases.**



---
---



# 📦 Pull Request Template

Every PR in Bitbucket/GitHub should include this summary to help the reviewer:


## Template

    ### 📝 Description
    - Fixed the login overflow issue.
    - Added dependency injection for AuthService.

    ### 📸 UI Changes
    - [Link to screenshot/video of the feature]

    ### ✅ Checklist
    - [x] Ran `flutter analyze`
    - [x] No memory leaks detected in DevTools
    - [x] Verified on Android and iOS


## Required Attachments

| Type | When Required |
|:-----|:--------------|
| 📸 Screenshot | Any UI change |
| 🎥 Screen Recording | Animations or flows |
| 📊 Performance Metrics | Heavy features |



---
---



# 🚀 How to Pitch "Part 2" to the CTO

When presenting this SOP to leadership, emphasize the **ROI** and **risk mitigation**:


## The Pitch

> *"Sir, Part 1 was about starting right. **Part 2 is about staying right.** By enforcing this Code Review SOP, I ensure that no 'trash code' enters our repository. This prevents the technical debt that usually causes projects to slow down or fail in the final weeks. This is how I guarantee our 100% completion rate."*


## Key Points to Highlight

- ✅ **Consistency** — Every developer follows the same pattern
- ✅ **Quality Gate** — No code enters `main` without review
- ✅ **Automation** — Pre-PR checks catch issues early
- ✅ **Documentation** — PR template creates audit trail



---
---



# 🎯 Final Interview Checklist

The "Winning" Mindset for your interview:


## The 3 C's

| # | Principle | How to Demonstrate |
|:-:|:----------|:-------------------|
| 1 | **Confidence** | You have the SOPs, the Manifesto, and the Technical Answers |
| 2 | **Professionalism** | Talk about "Systems" and "ROI," not just "Widgets" |
| 3 | **Closing** | Ask a strategic question at the end |


## 💡 The Power Question

When they ask *"Do you have any questions?"*, respond with:

> *"What is the biggest technical bottleneck currently stopping the team from delivering faster? I'd like to address that in my first week."*


## 🎯 Why This Works

- Shows you're **solution-oriented**
- Demonstrates **proactive thinking**
- Positions you as a **problem solver**, not just an employee



---



**🎉 You are fully armed for this interview, Ilham. You've got this!**
