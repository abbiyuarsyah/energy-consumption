# Energy Cunsumption App

The app is built on the Flutter Framework and utilizes FL Chart as the foundation for implementing graphical charts. To optimize performance, the app leverages Hive for data caching, reducing unnecessary API calls. Additionally, it supports a dark mode for a better user experience.

## How To Run the App 

Follow these steps to set up and contribute to the project:

1. **Clone the Repository**
   
   ```bash
   git clone 
2. **Install Dependencies**
   
   ```bash
   flutter pub get
3. **Install Dependencies**

   ```bash
   flutter run

## Test
This app includes comprehensive testing with two types of tests: widget tests and unit tests. The implemented tests cover various aspects, including data sources, BLoC, extensions, states, and core business logic.

## Folder Structure
This project follows the Clean Code Architecture integrated with Bloc State Management for efficient and scalable application development.
The detailed code structure is outlined below:

```plaintext
lib/
├── core/                         # Contains shared code used across the app.
│   ├── constants/                # Defines app-wide constants, such as strings, and other static values.
│   ├── enums/                    # Contains enumerations used for categorization or state management.
│   ├── extensions/               # Provides custom Dart extensions to add utility methods to existing classes.
│   ├── local_storage/            # Handles local storage logic
│   ├── service_locator/          # Contains the service locator for dependency injection.
│   ├── shared_widget/            # Houses reusable widgets that are shared across multiple features.
│   ├── utils/                    # Utility functions, such as date parsers, formatters, or custom validators.
├── features/                     # Contains the implementation of app features, structured modularly.
│   ├── feature_name/             # Placeholder for a specific feature's code.
│   │   ├── data/                 # Contains data-related code for the feature.
│   │   │   ├── datasources/      # Defines remote and local data sources (e.g., APIs, databases).
│   │   │   ├── models/           # Data models that map JSON responses or database entities.
│   │   │   └── repositories/     # Implements the domain's repository contracts for data management.
│   │   ├── domain/               # Contains business logic and definitions for the feature.
│   │   │   ├── entities/         # Core business objects with only essential fields and properties.
│   │   │   ├── repositories/     # Abstract definitions of the repositories used by the domain layer.
│   │   │   └── use_case/         # Encapsulates specific business logic for the feature.
│   │   └── presentation/         # Handles UI and state management for the feature.
│   │       ├── bloc/             # Bloc files for state management (events, states, blocs).
│   │       ├── pages/            # Flutter screens/pages for this feature.
│   │       └── widgets/          # Reusable UI widgets specific to the feature.
├── app.dart                      # Main app widget that initializes and configures the app.
└── main.dart                     # Application entry point, contains the `main()` function.
```
