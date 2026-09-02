# Jobbiez 💼

<p align="center">
  <img
    src="https://media.licdn.com/dms/image/v2/D562DAQH6MnEJc_8ZbQ/profile-treasury-image-shrink_1280_1280/B56Zj7S2.JHAAg-/0/1756562688058?e=1788919200&v=beta&t=dxQ7-pwdoW3AtysCElU-p8PeS-JZmfamgJZcAW8E86s"
    alt="Jobbiez - Mobile Job Search Application"
    width="900"
  />
</p>

**Jobbiez** adalah aplikasi mobile pencarian kerja yang dirancang untuk membantu pengguna menemukan lowongan pekerjaan yang relevan, melihat informasi pekerjaan secara detail, serta mengelola perjalanan karier dalam satu aplikasi.

Aplikasi ini dibangun menggunakan **Flutter** dengan pendekatan **Clean Architecture** untuk menghasilkan struktur kode yang modular, mudah dikembangkan, dan mudah dipelihara.

> 🎯 **Project Type:** Mobile Application
> 📱 **Platform:** Android
> 🛠️ **Framework:** Flutter
> 💻 **Language:** Dart
> 🏗️ **Architecture:** Clean Architecture

---

## ✨ Features

### 🔍 Job Search

* Mencari lowongan pekerjaan.
* Menampilkan daftar pekerjaan yang tersedia.
* Menampilkan informasi pekerjaan secara detail.
* Membantu pengguna menemukan pekerjaan berdasarkan kebutuhan mereka.

### 📄 Job Details

Pengguna dapat melihat informasi lengkap dari sebuah lowongan pekerjaan, seperti:

* Posisi pekerjaan
* Deskripsi pekerjaan
* Informasi perusahaan
* Persyaratan pekerjaan
* Informasi terkait pekerjaan lainnya

### 👤 Profile

Pengguna dapat mengelola informasi profil mereka sebagai bagian dari perjalanan karier.

### 📎 File & Document

Aplikasi menyediakan kemampuan untuk memilih file dari perangkat yang dapat digunakan dalam proses terkait profil atau pekerjaan.

### ⭐ Rating

Menggunakan rating component untuk memberikan pengalaman interaksi yang lebih baik pada aplikasi.

### 🔐 Secure Storage

Informasi tertentu yang membutuhkan penyimpanan aman menggunakan secure storage.

### 🎨 Modern UI

Menggunakan komponen UI modern dengan dukungan:

* Custom widgets
* Google Fonts
* Shimmer loading
* Responsive layouts
* Material Design

---

## 🏗️ Architecture

Jobbiez menggunakan pendekatan **Clean Architecture** yang memisahkan aplikasi menjadi beberapa layer.

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

Bertanggung jawab terhadap pengambilan dan pengelolaan data.

```text
Data Sources
     ↓
Models
     ↓
Repository Implementation
```

#### Domain Layer

Berisi business logic aplikasi dan tidak bergantung pada framework atau implementasi data tertentu.

```text
Entities / Business Rules
          ↓
      Use Cases
          ↓
    Repository Contract
```

#### Presentation Layer

Menangani UI dan state management aplikasi.

```text
Pages
  ↓
Providers
  ↓
Widgets
```

Struktur ini membuat perubahan pada UI, sumber data, maupun business logic dapat dilakukan secara lebih terisolasi.

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

Dependency utama tersebut tercantum pada `pubspec.yaml` project.

---

## 🔄 Application Flow

Secara umum, alur aplikasi mengikuti pola:

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

Hasil data kemudian dikembalikan melalui layer yang sama hingga akhirnya ditampilkan kembali pada UI.

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

Struktur aktual repository memang memisahkan `common`, `data`, `domain`, dan `presentation`, dengan subfolder khusus untuk datasource, models, repositories, use cases, pages, providers, dan widgets.

---
