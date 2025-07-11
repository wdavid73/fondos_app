# 🏗️ Flutter Base Project

[![es](https://img.shields.io/badge/lang-es-yellow.svg)](https://github.com/wdavid73/flutter_starter_kit/blob/master/README.es.md)

This is a base project in Flutter designed as a template for future developments. It contains essential configurations and packages to quickly start new projects.

---

## 📄 Branch Guide

Refer to the workflow in [BRANCHES.md](BRANCHES.md).

---

## 📌 Prerequisites

Make sure you have the following installed:

- **Flutter** (If using FVM, run `fvm use <version>` to configure the appropriate version).
- **Dart**
- **Android Studio or VS Code** (Optional but recommended)
- **Physical device or emulator configured**
- **Java Version 17** (Optional but recommended)

---

## 🚀 Useful Commands

| Command             | Description                                                              |
| ------------------- | ------------------------------------------------------------------------ |
| `flutter pub get`   | Download project dependencies                                            |
| `flutter run`       | Runs the application on the connected device/emulator                    |
| `flutter build apk` | Generate an APK file for Android                                         |
| `flutter build ios` | Generate iOS version (requires macOS)                                    |
| `flutter clean`     | Deletes generated files and clears cache                                 |
| `fvm flutter run`   | (If using FVM) Runs the app with the Flutter version defined in `.fvmrc` |
| `dart fix --apply`  | Automatically apply suggested fixes                                      |
| `flutter analyze`   | Analyze the code for errors and warnings                                 |
| `flutter test`      | Runs the project's unit tests                                            |

---

## 📦 Packages Used

| Package                       | Version  | Description                                                                                                                 |
| ----------------------------- | -------- | --------------------------------------------------------------------------------------------------------------------------- |
| `animate_do`                  | ^3.3.4   | Provides simple and ready-to-use animations in Flutter.                                                                     |
| `dio`                         | ^5.8.0+1 | Powerful and flexible HTTP client for making API requests.                                                                  |
| `flutter_dotenv`              | ^5.2.1   | Loads environment variables from a `.env` file.                                                                             |
| `go_router`                   | ^14.7.2  | Declarative URL-based router for Flutter.                                                                                   |
| `intl`                        | ^0.19.0  | Support for internationalization and formatting of dates/numbers.                                                           |
| `equatable`                   | ^2.0.7   | Simplifies object comparison without overriding `==`.                                                                       |
| `flutter_bloc`                | ^9.0.0   | BLoC pattern implementation for state management in Flutter.                                                                |
| `hydrated_bloc`               | ^10.0.0  | BLoC pattern implementation for persistent state management in Flutter.                                                     |
| `flutter_local_notifications` | ^18.0.1  | Displays local notifications on mobile devices.                                                                             |
| `image_picker`                | ^1.1.2   | Allows selecting images from the gallery or camera.                                                                         |
| `formz`                       | ^0.8.0   | Simplifies form validation in Flutter.                                                                                      |
| `google_fonts`                | ^6.2.1   | Easily integrates Google Fonts into Flutter.                                                                                |
| `shared_preferences`          | ^2.5.1   | Provides persistent key-value storage on the device.                                                                        |
| `flutter_secure_storage`      | ^9.2.4   | Provides Encrypted persistent key-value storage on the device.                                                              |
| `bloc_test`                   | ^10.0.0  | Simplifies logic testing of your Flutter Blocks and Cubits, allowing you to easily verify expected states and side effects. |
| `mocktail`                    | ^1.0.4   | Facilitates the creation of mocks and stubs with an intuitive and null-safe API for unit testing in Flutter and Dart.       |

### 📦 Development Dependencies:

| Package                   | Version      | Description                                   |
| ------------------------- | ------------ | --------------------------------------------- |
| `flutter_test`            | sdk: flutter | Testing framework for Flutter applications.   |
| `integration_test`        | sdk: flutter | Testing framework for Flutter applications.   |
| `flutter_lints`           | ^5.0.0       | Linting rules and best practices for Flutter. |
| `change_app_package_name` | ^1.4.0       | Easily changes the app's package identifier.  |
| `flutter_launcher_icons`  | ^0.14.3      | Simplifies app icon configuration in Flutter. |

_(You can add more packages as needed for your base project)._

---

## 🔧 Before running your project

After creating your Flutter project based on this template, please perform the following steps.

### ⚙️ (Optional) How to start the project with FVM

To start working on this project, make sure you have FVM (Flutter Version Manager) installed. This ensures that you are using the correct version of Flutter according to the project configuration.

#### Steps to get started:

1.  Install FVM: If you do not have FVM installed, you can do so by running the following command:

    ```bash
    dart pub global activate fvm
    ```

2.  Install the version of Flutter for this project: Run the following command in the root of the project to install the specific version of Flutter:

    ```bash
    fvm install <version>
    ```

3.  Use the installed version: Make sure you are using the correct version of Flutter with the following command:

    ```bash
    fvm use <version>
    ```

4.  Verify the Flutter version: Confirm that FVM is using the correct version of Flutter with:

    ```bash
    fvm flutter --version
    ```

5.  Create and configure the environment: Once you have the correct Flutter version, you can run the following command to make sure all dependencies are up to date:

    ```bash
    fvm flutter pub get
    ```

Now you are ready to start developing!

### 🌐 1. Environment variables

1.  Create the `.env` file based on the `.env.template` file.
2.  Change the value of your `API_URL` variable.
3.  **(Optional)** If you use FVM, locate the `local.properties` file inside the `android` folder and change the value of `flutter.sdk` to:

    ```
    flutter.sdk=<path_your_project>\\.fvm\\versions\\<your_flutter_version>
    ```

4.  **(Optional)** If you don't have a variable in the `.env` file when you create it, you can add it like this:

    ```
    API_URL=
    ```

5.  **(Optional)** If you want to see the onboarding screen, change the value of `SHOW_ONBOARDING` to `true`.

### ✏️ 2. Change package name

When creating a project from a template, it's necessary to change the app's package name to avoid conflicts when uploading to app stores.

- Verify that the `change_app_package_name` package is in the `pubspec.yaml` file in the `dev_dependencies` section.
- Run the following command to get all the packages that the project needs initially:

  ```sh
  flutter pub get
  ```

- Now run the following command to change the app's name:

  ```sh
  dart run change_app_package_name:main com.<your_domain>.<app_name>.
  ```

- **(Optional)** If you are using FVM (Flutter Version Manager), the command is:

  ```sh
  fvm dart run change_app_package_name:main com.<your_domain>.<app_name>.
  ```

- **(Optional)** When you change the app name, remember to also change it in the `pubspec.yaml` file.
- **(Optional)** If you want to change the app's display name (the name shown to users), you must do so in `AndroidManifest.xml` at `android/app/src/main/AndroidManifest.xml`.

### 3. Change app launcher icon (Optional)

This step is optional. To change the app icon, follow these steps:

- Verify that the `icons_launcher ` package is in the `pubspec.yaml` in the `dev_dependencies` section.
- In the `pubspec.yaml`, go to the `icons_launcher.yaml` file and specify the path to your app icon in the `image_path` field.
- Run the following command to get all the packages that the project needs initially:

  ```sh
  flutter pub get
  ```

- Now run the following command to change the icon of the app:

  ```sh
  dart run icons_launcher:create
  ```

- **Caution!** If you change the path of your app icon, you must also update the path in `pubspec.yaml`:

  ```
  flutter:
    assets:
      - assets/icon/  #  Modify the path of your icon here
  ```

- **(Optional)** If you are using FVM (Flutter Version Manager), the command is:

  ```sh
  fvm dart run icons_launcher:create
  ```

### 4. Change the app splash screen (Optional)

If you want to change the app's splash screen, follow these steps:

- Verify in the `pubspec.yaml` file that the `flutter_native_splash` package is in the `dependencies` section.
- **(Optional)** If you want to change the color of the splash screen, do the following:

  ```
  flutter_native_splash:
    color: "#252829"  #  Modify the splash screen color here
  ```

- Run the following command to get all the packages that the project needs initially:

  ```sh
  flutter pub get
  ```

- Now run the following command to change the splash screen of the app:

  ```sh
  dart run flutter_native_splash:create
  ```

- **(Optional)** If you are using FVM (Flutter Version Manager), the command is:

  ```sh
  fvm dart run flutter_native_splash:create
  ```

---

## ▶️ How to Run the Project

### With Android Studio

1.  Open the project in **Android Studio**.
2.  Connect an emulator or a physical device.
3.  Press the **Run** button or use the shortcut `Shift + F10`.

### With Command Line

- If you use FVM:

  ```sh
  fvm flutter pub get
  fvm flutter run
  ```

- Without FVM:

  ```sh
  flutter pub get
  flutter run
  ```

## 🧪 Environments (Flavors)

This project supports **flavors** for managing multiple environments: `dev`, `staging`, and `prod`.

### 📁 File Structure

```bash
/lib/
  main_dev.dart
  main_staging.dart
  main_prod.dart

/flavors/
  dev.env
  staging.env
  prod.env

/android/app/build.gradle
  # Contains productFlavors configuration
```

## 🌱 Environment files

Located in `/flavors/`, each `.env` file defines environment-specific variables. Example

`flavors/.env.dev:`

```
API_URL=https://api.dev.example.com
SHOW_ONBOARDING=true
```

## ▶️ Run app by flavor

```bash
# Development
fvm flutter run -t lib/main_dev.dart --flavor dev

# Staging
fvm flutter run -t lib/main_staging.dart --flavor staging

# Production
fvm flutter run -t lib/main_prod.dart --flavor prod
```

## 🏗️ Build APK or AAB by flavor

```bash
# Development APK
fvm flutter build apk -t lib/main_dev.dart --flavor dev

# Staging APK
fvm flutter build apk -t lib/main_staging.dart --flavor staging

# Production APK
fvm flutter build apk -t lib/main_prod.dart --flavor prod

# Production AAB (required for Play Store)
fvm flutter build appbundle -t lib/main_prod.dart --flavor prod
```

### 📌 Notas

- Make sure `productFlavors` are properly configured in `android/app/build.gradle`.
- Environment variables are loaded automatically via `flutter_dotenv` depending on the selected flavor.

## 📦 Create Build (APK or AAB) for Android

To create an APK or AAB file for Android, follow these steps:

1.  **Generate APK**:
    Run the following command to generate an APK file:

    ```sh
    flutter build apk
    ```

    This command will create the APK file in the `build/app/outputs/flutter-apk/` directory.

2.  **Generate AAB** (Android App Bundle):
    If you want to generate an AAB (recommended for Google Play Store release), use the following command:

    ```sh
    flutter build appbundle
    ```

    This command will create the AAB file in the `build/app/outputs/bundle/release/` directory.

3.  **Additional options**:
    If you need to sign the APK or AAB for production, you must configure your `keystore` in the `build.gradle` file. Make sure you have a key file (`keystore`) and add the signing configuration:

    ```groovy
    android {
        signingConfigs {
            release {
                storeFile file("path/to/your.keystore")
                storePassword "your_keystore_password"
                keyAlias "your_key_alias"
                keyPassword "your_key_password"
            }
        }
        buildTypes {
            release {
                signingConfig signingConfigs.release
            }
        }
    }
    ```

## 🍏 Create Build (IPA) for iOS

To create an IPA file for iOS, follow these steps:

1.  **Prerequisites**:

- Make sure you have Xcode installed on macOS.
- You must have an Apple developer account and be registered in the Apple Developer Program.

2. **Generate Build for iOS**:
   Run the following command to generate a build for iOS:

   ```sh
   flutter build ios --release
   ```

   This will compile the application in release mode for iOS.

3. **Create IPA**:
   To create an IPA file (which you can install on a device or submit to the App Store), open the project in Xcode:

- Open the `ios/Runner.xcworkspace` file.
- In Xcode, select the target device (it can be a physical device or a simulator).
- Go to `Product > Archive` to create the archive.
- Once archiving is complete, the Organizer window will open. From there, you can export the IPA file.

4.  **Sign and configure the profile**:
    To publish the app to the App Store, make sure you have a signing certificate and provisioning profile configured in Xcode.

### 📄 License

This project is under the MIT license. Feel free to modify it and adapt it to your needs.

### 💡 Happy coding with Flutter! 🚀

This `README.md` is clear, modular, and adaptable for any project you use as a base. You can modify it according to the specific needs of your template. 🚀
