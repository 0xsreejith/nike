# Nike App - MVVM Architecture

This Flutter project follows the MVVM (Model-View-ViewModel) architecture pattern with a modular folder structure.

## Folder Structure

```
lib/
├── core/                          # Core functionality shared across the app
│   ├── app/                       # App-level widgets and configuration
│   │   └── app_widget.dart        # Main app widget with routing
│   ├── base/                      # Base classes
│   │   └── base_view_model.dart   # Base ViewModel class
│   ├── constants/                 # App constants
│   │   └── app_constants.dart     # Application-wide constants
│   ├── services/                  # Core services
│   │   └── api_service.dart       # HTTP API service
│   ├── theme/                     # App theming
│   │   └── app_theme.dart         # Light and dark themes
│   └── utils/                     # Utility classes
│       └── result.dart            # Result wrapper for async operations
├── features/                      # Feature modules
│   ├── auth/                      # Authentication feature
│   │   ├── models/                # Data models
│   │   │   └── user_model.dart    # User data model
│   │   ├── repositories/          # Data repositories
│   │   │   └── auth_repository.dart # Auth data operations
│   │   ├── viewmodels/            # ViewModels
│   │   │   └── auth_view_model.dart # Auth business logic
│   │   └── views/                 # UI Views
│   │       └── login_view.dart    # Login screen
│   └── home/                      # Home feature
│       └── views/                 # UI Views
│           └── home_view.dart     # Home screen
└── main.dart                      # App entry point
```

## Architecture Components

### Core Layer
- **Constants**: Application-wide constants and configuration
- **Services**: Core services like API client, storage, etc.
- **Theme**: App theming and styling
- **Utils**: Utility classes and helper functions
- **Base Classes**: Base classes that other components extend

### Feature Layer
Each feature follows the same structure:
- **Models**: Data models and entities
- **Repositories**: Data access layer
- **ViewModels**: Business logic and state management
- **Views**: UI components

## Key Features

### MVVM Pattern
- **Model**: Data models and repositories
- **View**: UI widgets and screens
- **ViewModel**: Business logic and state management using Provider

### Modular Design
- Features are self-contained modules
- Easy to add new features
- Clear separation of concerns

### State Management
- Uses Provider for state management
- BaseViewModel provides common functionality
- Result wrapper for handling async operations

### Error Handling
- Centralized error handling in BaseViewModel
- Result pattern for success/error states
- User-friendly error messages

## Getting Started

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run
   ```

## Adding New Features

To add a new feature:

1. Create a new folder in `features/`
2. Follow the structure: `models/`, `repositories/`, `viewmodels/`, `views/`
3. Extend `BaseViewModel` for your ViewModel
4. Use the `Result` class for async operations
5. Register your ViewModel in `main.dart` if needed

## Dependencies

- `provider`: State management
- `http`: HTTP client for API calls
- `shared_preferences`: Local storage

## Best Practices

- Keep ViewModels focused on business logic
- Use repositories for data access
- Handle errors gracefully with the Result pattern
- Follow the single responsibility principle
- Use meaningful names for files and classes 