# Fondos App

A Flutter template project with essential configurations and packages to quickly start new projects.

## Features

- Multi-platform support (Web, Android, iOS, Desktop)
- Clean Architecture implementation
- State management with BLoC
- Dependency injection with GetIt
- Internationalization support
- Secure storage
- SVG support
- Form validation
- Routing with GoRouter
- Custom splash screen
- Custom fonts (Inter)
- Asset management
- Environment configuration
- Unit and integration testing setup

## Dependencies

### Core

- `flutter`: ^3.6.0
- `flutter_bloc`: ^9.0.0
- `get_it`: ^8.0.3
- `go_router`: ^15.1.3
- `google_fonts`: ^6.2.1

### UI/UX

- `animate_do`: ^4.2.0
- `flutter_svg`: ^2.0.17
- `shimmer`: ^3.0.0
- `fluentui_system_icons`: ^1.1.273

### State Management

- `equatable`: ^2.0.7
- `formz`: ^0.8.0
- `hydrated_bloc`: ^10.0.0

### Storage

- `flutter_secure_storage`: ^9.2.4
- `shared_preferences`: ^2.5.1
- `path_provider`: ^2.1.5

### Internationalization

- `flutter_localizations`
- `intl`

## Architecture

The project follows Clean Architecture principles with:

- BLoC pattern for state management
- Repository pattern for data access
- Dependency injection using GetIt
- Feature-based organization

## Getting Started

### Prerequisites

- Flutter SDK (^3.6.0)
- Dart SDK (^3.6.0)
- FVM (Flutter Version Management)

### Setup

1. Clone the repository
2. Install dependencies:

```bash
fvm flutter pub get
```

### Running the App

#### Web

```bash
fvm flutter run -d chrome
```

#### Android

```bash
fvm flutter run -d android
```

#### iOS

```bash
fvm flutter run -d ios
```

### Building the App

#### Web

```bash
fvm flutter build web
```

#### Android

```bash
fvm flutter build apk --release
fvm flutter build appbundle --release
```

#### iOS

```bash
fvm flutter build ios --no-codesign --release
```

### Testing

Run unit tests:

```bash
fvm flutter test
```

Run integration tests:

```bash
fvm flutter test --platform chrome test/integration_test/
```

## Development

The project includes development tools and configurations:

- Code generation with `flutter_gen`
- Environment configuration with `.env.template`
- Native splash screen customization
- Font configuration
- Asset management
- Linting with `flutter_lints`

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
