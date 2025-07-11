# 🏗️ Proyecto Base de Flutter

[![en](https://img.shields.io/badge/lang-en-yellow.svg)](https://github.com/wdavid73/flutter_starter_kit/blob/master/README.md)

Este es un proyecto base en Flutter diseñado como una plantilla para desarrollos futuros. Contiene configuraciones y paquetes esenciales para comenzar nuevos proyectos rápidamente.

---

## 📄 Guía de Ramas (Branches)

Consulta el flujo de trabajo en [BRANCHES.md](BRANCHES.md).

---

## 📌 Requisitos Previos

Asegúrate de tener los siguientes elementos instalados:

- **Flutter** (Si usas FVM, ejecuta `fvm use <version>` para configurar la versión apropiada).
- **Dart**
- **Android Studio o VS Code** (Opcional pero recomendado)
- **Dispositivo físico o emulador configurado**
- **Java Versión 17** (Opcional pero recomendado)

---

## 🚀 Comandos Útiles

| Comando             | Descripción                                                                        |
| ------------------- | ---------------------------------------------------------------------------------- |
| `flutter pub get`   | Descarga las dependencias del proyecto                                             |
| `flutter run`       | Ejecuta la aplicación en el dispositivo/emulador conectado                         |
| `flutter build apk` | Genera un archivo APK para Android                                                 |
| `flutter build ios` | Genera la versión de iOS (requiere macOS)                                          |
| `flutter clean`     | Elimina los archivos generados y limpia la caché                                   |
| `fvm flutter run`   | (Si usas FVM) Ejecuta la aplicación con la versión de Flutter definida en `.fvmrc` |
| `dart fix --apply`  | Aplica automáticamente las correcciones sugeridas                                  |
| `flutter analyze`   | Analiza el código en busca de errores y advertencias                               |
| `flutter test`      | Ejecuta las pruebas unitarias del proyecto                                         |

---

## 📦 Paquetes Utilizados

| Paquete                       | Versión  | Descripción                                                                                                                                      |
| ----------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| `animate_do`                  | ^3.3.4   | Proporciona animaciones simples y listas para usar en Flutter.                                                                                   |
| `dio`                         | ^5.8.0+1 | Cliente HTTP potente y flexible para realizar peticiones a la API.                                                                               |
| `flutter_dotenv`              | ^5.2.1   | Carga las variables de entorno desde un archivo `.env`.                                                                                          |
| `go_router`                   | ^14.7.2  | Enrutador declarativo basado en URL para Flutter.                                                                                                |
| `intl`                        | ^0.19.0  | Soporte para la internacionalización y el formateo de fechas/números.                                                                            |
| `equatable`                   | ^2.0.7   | Simplifica la comparación de objetos sin anular `==`.                                                                                            |
| `flutter_bloc`                | ^9.0.0   | Implementación del patrón BLoC para la gestión del estado en Flutter.                                                                            |
| `hydrated_bloc`               | ^10.0.0  | Implementación del patrón BLoC para la gestión persistente del estado en Flutter.                                                                |
| `flutter_local_notifications` | ^18.0.1  | Muestra notificaciones locales en dispositivos móviles.                                                                                          |
| `image_picker`                | ^1.1.2   | Permite seleccionar imágenes de la galería o la cámara.                                                                                          |
| `formz`                       | ^0.8.0   | Simplifica la validación de formularios en Flutter.                                                                                              |
| `google_fonts`                | ^6.2.1   | Integra fácilmente las fuentes de Google en Flutter.                                                                                             |
| `shared_preferences`          | ^2.5.1   | Proporciona almacenamiento persistente de clave-valor en el dispositivo.                                                                         |
| `flutter_secure_storage`      | ^9.2.4   | Proporciona almacenamiento persistente encriptado de clave-valor en el dispositivo.                                                              |
| `bloc_test`                   | ^10.0.0  | Simplifica las pruebas lógicas de tus Blocs y Cubits de Flutter, permitiéndote verificar fácilmente los estados y efectos secundarios esperados. |
| `mocktail`                    | ^1.0.4   | Facilita la creación de mocks y stubs con una API intuitiva y null-safe para pruebas unitarias en Flutter y Dart.                                |

### 📦 Dependencias de Desarrollo:

| Paquete                   | Versión      | Descripción                                                        |
| ------------------------- | ------------ | ------------------------------------------------------------------ |
| `flutter_test`            | sdk: flutter | Framework de pruebas para aplicaciones Flutter.                    |
| `integration_test`        | sdk: flutter | Framework de pruebas para aplicaciones Flutter.                    |
| `flutter_lints`           | ^5.0.0       | Reglas de linting y buenas prácticas para Flutter.                 |
| `change_app_package_name` | ^1.4.0       | Cambia fácilmente el identificador del paquete de la aplicación.   |
| `flutter_launcher_icons`  | ^0.14.3      | Simplifica la configuración del icono de la aplicación en Flutter. |

_(Puedes agregar más paquetes según sea necesario para tu proyecto base)._

---

## 🔧 Antes de ejecutar tu proyecto

Después de crear tu proyecto Flutter basado en esta plantilla, por favor realiza los siguientes pasos.

### ⚙️ (Opcional) Cómo iniciar el proyecto con FVM

Para comenzar a trabajar en este proyecto, asegúrate de tener FVM (Flutter Version Manager) instalado. Esto asegura que estés utilizando la versión correcta de Flutter según la configuración del proyecto.

#### Pasos para comenzar:

1.  Instalar FVM: Si no tienes FVM instalado, puedes hacerlo ejecutando el siguiente comando:

    ```bash
    dart pub global activate fvm
    ```

2.  Instalar la versión de Flutter para este proyecto: Ejecuta el siguiente comando en la raíz del proyecto para instalar la versión específica de Flutter:

    ```bash
    fvm install <version>
    ```

3.  Usar la versión instalada: Asegúrate de estar utilizando la versión correcta de Flutter con el siguiente comando:

    ```bash
    fvm use <version>
    ```

4.  Verificar la versión de Flutter: Confirma que FVM está utilizando la versión correcta de Flutter con:

    ```bash
    fvm flutter --version
    ```

5.  Crear y configurar el entorno: Una vez que tengas la versión correcta de Flutter, puedes ejecutar el siguiente comando para asegurarte de que todas las dependencias estén actualizadas:

    ```bash
    fvm flutter pub get
    ```

¡Ahora estás listo para comenzar a desarrollar!

### 🌐 1. Variables de entorno

1.  Crea el archivo `.env` basado en el archivo `.env.template`.
2.  Cambia el valor de tu variable `API_URL`.
3.  **(Opcional)** Si usas FVM, localiza el archivo `local.properties` dentro de la carpeta `android` y cambia el valor de `flutter.sdk` a:

    ```
    flutter.sdk=<ruta_de_tu_proyecto>\\.fvm\\versions\\<tu_versión_de_flutter>
    ```

4.  **(Opcional)** Si no tienes una variable en el archivo `.env` cuando lo creas, puedes agregarla así:

    ```
    API_URL=
    ```

5.  **(Opcional)** Si quieres ver la pantalla de onboarding, cambia el valor de `SHOW_ONBOARDING` a `true`.

### ✏️ 2. Cambiar el nombre del paquete

Al crear un proyecto a partir de una plantilla, es necesario cambiar el nombre del paquete de la aplicación para evitar conflictos al subirla a las tiendas de aplicaciones.

- Verifica que el paquete `change_app_package_name` esté en el archivo `pubspec.yaml` en la sección `dev_dependencies`.
- Ejecuta el siguiente comando para obtener todos los paquetes que el proyecto necesita inicialmente:

  ```sh
  flutter pub get
  ```

- Ahora ejecuta el siguiente comando para cambiar el nombre de la aplicación:

  ```sh
  dart run change_app_package_name:main com.<tu_dominio>.<nombre_de_la_aplicación>.
  ```

- **(Opcional)** Si estás usando FVM (Flutter Version Manager), el comando es:

  ```sh
  fvm dart run change_app_package_name:main com.<tu_dominio>.<nombre_de_la_aplicación>.
  ```

- **(Opcional)** Cuando cambies el nombre de la aplicación, recuerda cambiarlo también en el archivo `pubspec.yaml`.
- **(Opcional)** Si quieres cambiar el nombre para mostrar de la aplicación (el nombre que ven los usuarios), debes hacerlo en `AndroidManifest.xml` en `android/app/src/main/AndroidManifest.xml`.

### 3. Cambiar el icono del lanzador de la aplicación (Opcional)

Este paso es opcional. Para cambiar el icono de la aplicación, sigue estos pasos:

- Verifica que el paquete `icons_launcher` esté en el archivo `pubspec.yaml` en la sección `dev_dependencies`.
- En el archivo `pubspec.yaml`, ve a la archivo `icons_launcher.yaml` y especifica la ruta a tu icono de la aplicación en el campo `image_path`.
- Ejecuta el siguiente comando para obtener todos los paquetes que el proyecto necesita inicialmente:

  ```sh
  flutter pub get
  ```

- Ahora ejecuta el siguiente comando para cambiar el icono de la aplicación:

  ```sh
  dart run icons_launcher:create
  ```

- **¡Precaución!** Si cambias la ruta de tu icono de la aplicación, también debes actualizar la ruta en `pubspec.yaml`:

  ```
  flutter:
    assets:
      - assets/icon/  #  Modifica la ruta de tu icono aquí
  ```

- **(Opcional)** Si estás usando FVM (Flutter Version Manager), el comando es:

  ```sh
  fvm dart run icons_launcher:create
  ```

### 4. Cambiar la pantalla de bienvenida (splash screen) de la aplicación (Opcional)

Si quieres cambiar la pantalla de bienvenida de la aplicación, sigue estos pasos:

- Verifica en el archivo `pubspec.yaml` que el paquete `flutter_native_splash` esté en la sección `dependencies`.
- **(Opcional)** Si quieres cambiar el color de la pantalla de bienvenida, haz lo siguiente:

  ```
  flutter_native_splash:
    color: "#252829"  #  Modifica el color de la pantalla de bienvenida aquí
  ```

- Ejecuta el siguiente comando para obtener todos los paquetes que el proyecto necesita inicialmente:

  ```sh
  flutter pub get
  ```

- Ahora ejecuta el siguiente comando para cambiar la pantalla de bienvenida de la aplicación:

  ```sh
  dart run flutter_native_splash:create
  ```

- **(Opcional)** Si estás usando FVM (Flutter Version Manager), el comando es:

  ```sh
  fvm dart run flutter_native_splash:create
  ```

---

## ▶️ Cómo ejecutar el proyecto

### Con Android Studio

1.  Abre el proyecto en **Android Studio**.
2.  Conecta un emulador o un dispositivo físico.
3.  Presiona el botón **Run** o usa el atajo `Shift + F10`.

### Con la línea de comandos

- Si usas FVM:

  ```sh
  fvm flutter pub get
  fvm flutter run
  ```

- Sin FVM:

  ```sh
  flutter pub get
  flutter run
  ```

## 🧪 Entornos (Flavors)

Este proyecto soporta **flavors** para manejar múltiples entornos: `dev`, `staging` y `prod`.

### 📁 Estructura de archivos

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
  # Contiene la configuración de productFlavors
```

## 🌱 Archivos de entorno

Ubicados en /flavors/, cada archivo .env define variables específicas del entorno. Ejemplo:

`flavors/dev.env:`

```
API_URL=https://api.dev.example.com
SHOW_ONBOARDING=true
```

## ▶️ Comandos para ejecutar la app por flavor

```bash
# Desarrollo
flutter run -t lib/main_dev.dart --flavor dev

# Staging
flutter run -t lib/main_staging.dart --flavor staging

# Producción
flutter run -t lib/main_prod.dart --flavor prod
```

## 🏗️ Comandos para compilar builds por flavor

```bash
# APK de desarrollo
fvm flutter build apk -t lib/main_dev.dart --flavor dev

# APK de staging
fvm flutter build apk -t lib/main_staging.dart --flavor staging

# APK de producción
fvm flutter build apk -t lib/main_prod.dart --flavor prod

# AAB de producción (requerido para Play Store)
fvm flutter build appbundle -t lib/main_prod.dart --flavor prod
```

### 📌 Notas

- Asegúrate de haber definido correctamente los `productFlavors` en `android/app/build.gradle`.
- Las variables de entorno se cargan automáticamente usando `flutter_dotenv` basado en el flavor.

## 📦 Crear una compilación (APK o AAB) para Android

Para crear un archivo APK o AAB para Android, sigue estos pasos:

1.  **Generar APK**:
    Ejecuta el siguiente comando para generar un archivo APK:

    ```sh
    flutter build apk
    ```

    Este comando creará el archivo APK en el directorio `build/app/outputs/flutter-apk/`.

2.  **Generar AAB** (Android App Bundle):
    Si quieres generar un AAB (recomendado para la publicación en Google Play Store), usa el siguiente comando:

    ```sh
    flutter build appbundle
    ```

    Este comando creará el archivo AAB en el directorio `build/app/outputs/bundle/release/`.

3.  **Opciones adicionales**:
    Si necesitas firmar el APK o AAB para producción, debes configurar tu `keystore` en el archivo `build.gradle`. Asegúrate de tener un archivo de claves (`keystore`) y agrega la configuración de firma:

    ```groovy
    android {
        signingConfigs {
            release {
                storeFile file("ruta/a/tu/archivo.keystore")
                storePassword "la_contraseña_de_tu_keystore"
                keyAlias "tu_alias_de_clave"
                keyPassword "la_contraseña_de_tu_clave"
            }
        }
        buildTypes {
            release {
                signingConfig signingConfigs.release
            }
        }
    }
    ```

## 🍏 Crear una compilación (IPA) para iOS

Para crear un archivo IPA para iOS, sigue estos pasos:

1. **Requisitos previos**:

   - Asegúrate de tener Xcode instalado en macOS.
   - Debes tener una cuenta de desarrollador de Apple y estar registrado en el Programa de Desarrolladores de Apple.

2. **Generar compilación para iOS**:
   Ejecuta el siguiente comando para generar una compilación para iOS:

   ```sh
   flutter build ios --release
   ```

   Esto compilará la aplicación en modo de lanzamiento para iOS.

3. **Crear IPA**:
   Para crear un archivo IPA (que puedes instalar en un dispositivo o enviar a la App Store), abre el proyecto en Xcode:

   - Abre el archivo `ios/Runner.xcworkspace`.
   - En Xcode, selecciona el dispositivo de destino (puede ser un dispositivo físico o un simulador).
   - Ve a `Product > Archive` para crear el archivo.
   - Una vez que se complete el archivado, se abrirá la ventana del Organizador. Desde allí, puedes exportar el archivo IPA.

4. **Firmar y configurar el perfil**:
   Para publicar la aplicación en la App Store, asegúrate de tener un certificado de firma y un perfil de aprovisionamiento configurados en Xcode.

### 📄 Licencia

Este proyecto está bajo la licencia MIT. Siéntete libre de modificarlo y adaptarlo a tus necesidades.

### 💡 ¡Feliz codificación con Flutter! 🚀

Este `README.md` es claro, modular y adaptable para cualquier proyecto que uses como base. Puedes modificarlo de acuerdo con las necesidades específicas de tu plantilla. 🚀
