Elevate Tracking App
====================

Welcome to the Elevate Tracking App! This is a modern, cross-platform mobile application built with Flutter, designed to provide seamless location tracking, user authentication, and real-time data management. Whether you're tracking assets, monitoring routes, or managing user profiles, this app leverages powerful tools like Google Maps and Firebase to deliver a reliable and intuitive experience.

Project Overview
----------------

**Elevate Tracking App** is a Flutter-based project aimed at creating a robust tracking solution. It integrates geolocation services, API calls for backend communication, secure storage for sensitive data, and state management for a responsive UI. The app supports internationalization, image handling, and navigation, making it suitable for global users.

Key goals:

* Provide real-time location tracking with maps.

* Ensure secure user authentication and data persistence.

* Maintain a clean, maintainable codebase with dependency injection and modular architecture.

Tech Stack
-----------

* **Framework**: Flutter (SDK ^3.9.0)

* **State Management**: Flutter Bloc

* **API & Networking**: Retrofit , Pretty Dio Logger

* **Dependency Injection**: Injectable

* **Storage & Security**: Flutter Secure Storage

* **Maps & Location**: Google Maps Flutter, Geolocator

* **Navigation**: Go Router

* **UI Components**: Pinput for PIN inputs, Cached Network Image, Image Picker

* **Backend & Database**: Firebase Core, Cloud Firestore

* **Internationalization**: Flutter Intl for ARB files

* **Utilities**: Equatable, Provider, URL Launcher

* **Testing**: Flutter Test, Bloc Test, Mockito

* **Build Tools**: Build Runner, JSON Serializable, Retrofit Generator, Injectable Generator

Architecture
-------------

The app follows a clean, modular architecture inspired by Clean Architecture principles, emphasizing separation of concerns for better maintainability and testability:

* **Presentation Layer**: Handles UI and user interactions using Flutter widgets and Bloc for state management. Blocs manage business logic, events, and states.

* **Domain Layer**: Contains entities, use cases, and repositories. Equatable is used for immutable data classes.

* **Data Layer**: Manages data sources (local and remote). Retrofit generates API clients for Dio, while Firebase handles real-time database operations. Secure storage and shared preferences manage local data.

* **Dependency Injection**: Powered by Injectable and GetIt for easy service registration and resolution.

* **Navigation**: Go Router handles declarative routing with support for deep links and guards.

* **Error Handling & Logging**: Custom error classes, Dio interceptors, and Logger for debugging.

This structure ensures loose coupling, making it easy to swap components (e.g., replace Firebase with another backend).

Features
---------

* **User Authentication**: Secure login with PIN inputs (via Pinput) and token storage in Flutter Secure Storage.

* **Location Tracking**: Real-time geolocation using Geolocator, displayed on Google Maps.

* **Profile Management**: Upload and manage user images with Image Picker and cached network images.

* **Data Persistence**: Local storage with Flutter Secure Storage and secure keys; cloud sync via Cloud Firestore.

* **Internationalization**: Multi-language support with Flutter Intl and ARB files.

* **API Integration**: RESTful API calls with Retrofit, including request logging.

* **Bottom Sheets & Modals**: Customizable bottom sheets using Solid Bottom Sheet.

* **URL Handling**: Open external links with URL Launcher.

* **Responsive UI**: Adaptive layouts with custom fonts (Inter, Roboto, Outfit, IMFellEnglish) and SVG icons.

Testing
--------

We prioritize quality with a comprehensive testing strategy:

* **Unit Tests**: Cover Blocs, use cases, and repositories using Bloc Test and Mockito.

* **Widget Tests**: Verify UI components with Flutter Test.

* **Mocks**: Network Image Mock for image testing in debug mode.

Folder Structure
-----------------

Here's a high-level overview of the project structure:

```plaintext
├── android/                     # Android-specific files
├── assets/                      
│   ├── images/                 
│   ├── icons/                 
│   └── data/                   
├── ios/                            # iOS-specific files
├── lib/                            # Main Dart source code
│   │   ├── Api/                     # API models and services (Retrofit-generated)
│   │   │
│   │   ├── Core/                  # Utilities, constants, services (e.g., location_manger)
│   │   │
│   │   ├── data/                   # Data layer
│   │   │   ├── local/              # Local data sources (SecureStorage)
│   │   │   ├── remote/          # Remote data sources (Retrofit API clients)
│   │   │   ├── models/          # DTOs and JSON models
│   │   │   └── repositories/   # Repository implementations
│   │   │
│   │   ├── domain/                # Business logic (pure Dart)
│   │   │   ├── entities/           # Domain models
│   │   │   ├── repositories/    # Repository interfaces
│   │   │   └── usecases/         # Use case classes
│   │   │
│   │   ├── generated/             # Auto-generated files (e.g., l10n, JSON serializers)
│   │   │
│   │   ├── presentation/        # UI screens, widgets, view models
│   │   │   ├── auth/            
│   │   │   ├── home/            
│   │   │   ├── location/        
│   │   │   ├── main_home/       
│   │   │   ├── onboarding/   
│   │   │   ├── order_details/   
│   │   │   ├── orders/         
│   │   │   ├── profile/         
│   │
│   ├── main.dart                # App entry point
├── test/                             # Test files
│   ├── unit/                       # Unit tests (use cases, repositories)
│   ├── widget/                  # Widget tests
├── analysis_options.yaml       # Linter and analyzer configuration
├── devtools_options.yaml     # DevTools extension settings
├── firebase.json                    # Firebase configuration
├── pubspec.yaml                  # Project dependencies and metadata
└── README.md                    # Project documentation
```

Contributors
--------------

* [Mohamed Hossam El-Bably](https://github.com/Bablu521)
* [Youssef Mohamed](https://github.com/youssefmdev22)
* [Moaz Osama](https://github.com/moazosama1)
* [Mohamed Naeem](https://github.com/mohamedna3eem)



Screenshots
-----------

| Onboarding                                                                                                                                               | Login                                                                                                                                               | Apply                                                                                                                                           | Application Approved                                                                                                                                               |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img src='assets/screenshots/onboarding.jpg?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/login.jpg?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/apply.gif?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/application_approved.jpg?raw=true' width="150px" height="300px"/> |

| Forget Password                                                                                                                                               | Profile                                                                                                                                              | Edit Profile                                                                                                                                          | Logout                                                                                                                                              |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img src='assets/screenshots/forget_password.gif?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/profile.jpg?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/edit_profile.gif?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/logout.jpg?raw=true' width="150px" height="300px"/> |

| Home                                                                                                                                              | Order Details                                                                                                                                             | User Location                                                                                                                                          | Pick Location                                                                                                                                             |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img src='assets/screenshots/Home.png?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/order_details.gif?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/User location.png?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/Pickup location.png?raw=true' width="150px" height="300px"/> |

| Success Screen                                                                                                                                             | My Orders                                                                                                                                             | My Orders Details                                                                                                                                          |                                                                                                                                              |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <img src='assets/screenshots/Success.png?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/my_orders.gif?raw=true' width="150px" height="300px"/> | <img src='assets/screenshots/my_orders_details.jpg?raw=true' width="150px" height="300px"/> | |

Presentation
--------------

Check out our project presentation: [View Presentation](https://www.canva.com/design/DAGzTS6kvKw/JBF9GjzLm9y-vuv24rk3GA/view?utm_content=DAGzTS6kvKw&utm_campaign=designshare&utm_medium=link2&utm_source=uniquelinks&utlId=hd1d2aab2c0)
