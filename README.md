# Jobbiez 💼

<p align="center">
  <img
    src="https://media.licdn.com/dms/image/v2/D562DAQH6MnEJc_8ZbQ/profile-treasury-image-shrink_1280_1280/B56Zj7S2.JHAAg-/0/1756562688058?e=1788919200&v=beta&t=dxQ7-pwdoW3AtysCElU-p8PeS-JZmfamgJZcAW8E86s"
    alt="Jobbiez - Mobile Job Search Application"
    width="900"
  />
</p>

**Jobbiez** is a mobile job search application designed to help users discover relevant job opportunities, view detailed job information, and manage their career journey in one application.

The application is built using **Flutter** with a **Clean Architecture** approach to provide a modular, scalable, and maintainable codebase.

> 🎯 **Project Type:** Mobile Application
> 📱 **Platform:** Android
> 🛠️ **Framework:** Flutter
> 💻 **Language:** Dart
> 🏗️ **Architecture:** Clean Architecture

---

## ✨ Features

### 🔍 Job Search

* Search for job opportunities.
* Display available job listings.
* View detailed job information.
* Help users find jobs based on their needs.

### 📄 Job Details

Users can view detailed information about a job opportunity, including:

* Job position
* Job description
* Company information
* Job requirements
* Other relevant job information

### 👤 Profile

Users can manage their profile information as part of their career journey.

### 📎 File & Document

The application provides the ability to select files from the device that can be used for profile- or job-related processes.

### ⭐ Rating

Uses a rating component to provide a better interactive experience within the application.

### 🔐 Secure Storage

Certain information that requires secure storage is stored using secure storage.

### 🎨 Modern UI

Uses modern UI components with support for:

* Custom widgets
* Google Fonts
* Shimmer loading
* Responsive layouts
* Material Design

---

## 🏗️ Architecture

Jobbiez uses a **Clean Architecture** approach that separates the application into multiple layers.

```text
lib/
│
├── common/
│   └── Shared utilities & common components
│
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
│
├── domain/
│   ├── repositories/
│   └── usecases/
│
├── presentation/
│   ├── pages/
│   ├── providers/
│   └── widgets/
│
├── injection.dart
└── main.dart
```

### Layer Responsibilities

#### Data Layer

Responsible for retrieving and managing data.

```text
Data Sources
     ↓
Models
     ↓
Repository Implementation
```

#### Domain Layer

Contains the application's business logic and remains independent of specific frameworks or data implementations.

```text
Entities / Business Rules
          ↓
      Use Cases
          ↓
    Repository Contract
```

#### Presentation Layer

Handles the application's UI and state management.

```text
Pages
  ↓
Providers
  ↓
Widgets
```

This structure allows changes to the UI, data sources, or business logic to be made in a more isolated and maintainable manner.

---

## 🛠️ Tech Stack

| Technology                 | Usage                                   |
| -------------------------- | --------------------------------------- |
| **Flutter**                | Mobile application framework            |
| **Dart**                   | Programming language                    |
| **Provider**               | State management                        |
| **GetIt**                  | Dependency injection                    |
| **HTTP**                   | API communication                       |
| **Dartz**                  | Functional programming & error handling |
| **Equatable**              | Value equality                          |
| **Flutter Secure Storage** | Secure local storage                    |
| **Image Picker**           | Selecting images                        |
| **File Picker**            | Selecting files                         |
| **Google Fonts**           | Typography                              |
| **Shimmer**                | Loading placeholder                     |
| **Flutter Rating Bar**     | Rating component                        |
| **Dotted Border**          | Custom UI component                     |
| **Intl Phone Field**       | Phone number input                      |

These main dependencies are listed in the project's `pubspec.yaml`.

---

## 🔄 Application Flow

In general, the application follows this pattern:

```text
User
 │
 ▼
Presentation Layer
 │
 │  User Interaction
 ▼
Provider / State Management
 │
 ▼
Domain Layer
 │
 │  Use Case
 ▼
Repository
 │
 ▼
Data Layer
 │
 ├── Remote Data Source
 └── Local Data Source
 │
 ▼
API / Local Storage
```

The resulting data is then returned through the same layers until it is ultimately displayed in the UI.

---

## 📁 Project Structure

```text
lib/
│
├── common/
│   └── ...
│
├── data/
│   ├── datasources/
│   │   └── ...
│   │
│   ├── models/
│   │   └── ...
│   │
│   └── repositories/
│       └── ...
│
├── domain/
│   ├── repositories/
│   │   └── ...
│   │
│   └── usecases/
│       └── ...
│
├── presentation/
│   ├── pages/
│   │   └── ...
│   │
│   ├── provider/
│   │   └── ...
│   │
│   └── widgets/
│       └── ...
│
├── injection.dart
└── main.dart
```

The actual repository structure separates `common`, `data`, `domain`, and `presentation`, with dedicated subfolders for data sources, models, repositories, use cases, pages, providers, and widgets.

---
