# ISHelper App

Una aplicación Flutter moderna para facilitar consultas de ciberseguridad y gestión de contactos con potenciales clientes de soluciones Bitdefender.

---

## 📋 Tabla de Contenidos

- [Características](#características)
- [Arquitectura](#arquitectura)
- [Capas de la Aplicación](#capas-de-la-aplicación)
- [Requisitos Previos](#requisitos-previos)
- [Instalación](#instalación)
- [Ejecución](#ejecución)
- [Pruebas](#pruebas)
- [Documentación del Código](#documentación-del-código)
- [Estructura del Proyecto](#estructura-del-proyecto)

---

## ✨ Características

- **Navegación de Fondo**: Interfaz de navegación inferior con 4 secciones principales
- **Formulario de Contacto**: Validación en tiempo real de datos de contacto
- **Gestión de Archivos**: Soporte para carga y procesamiento de archivos PDF
- **Localización**: Soporte completo para español (es-ES)
- **Responsive Design**: Interfaz adaptable a diferentes tamaños de pantalla
- **Gestión de Estado Moderna**: Utiliza BLoC y Cubits para state management
- **Enrutamiento Avanzado**: Implementa GoRouter para navegación moderna

---

## 🏗️ Arquitectura

ISHelper App utiliza una **arquitectura en capas** que sigue patrones CLEAN y MVVM, garantizando código mantenible, testeable y escalable.

```
┌─────────────────────────────────────┐
│         Presentation Layer          │
│  (Screens, Widgets, UI Components)  │
├─────────────────────────────────────┤
│         State Management Layer       │
│  (BLoCs, Cubits, State Classes)    │
├─────────────────────────────────────┤
│         Domain Layer                │
│  (Entities, Use Cases, Contracts)   │
├─────────────────────────────────────┤
│         Data Layer                  │
│  (Services, Repositories, Models)   │
├─────────────────────────────────────┤
│         Core Layer                  │
│  (Utils, Constants, Themes)         │
└─────────────────────────────────────┘
```

---

## 🧱 Capas de la Aplicación

### 1. **Presentation Layer** (`lib/src/view/`)

Responsable de la interfaz de usuario y la interacción del usuario.

**Componentes principales:**
- **Screens**: Pantallas completas de la aplicación
  - `HomeScreen`: Pantalla de inicio con estadísticas
  - `ContactScreen`: Formulario de contacto
  - `SolutionsScreen`: Soluciones disponibles
  - `SupportScreen`: Información de soporte
  - `PDFScreen`: Visor de archivos PDF

- **Widgets**: Componentes reutilizables
  - `NavigationBar`: Barra de navegación inferior
  - `BackgroundVideo`: Video de fondo
  - `DesignedButton`: Botón personalizado
  - `ImageCarousel`: Carrusel de imágenes

- **Utils**: Funciones auxiliares
  - `FileRender`: Renderizado de archivos
  - `PDFRender`: Renderizado de PDFs

```
lib/src/view/
├── app_router.dart          # Configuración de rutas (GoRouter)
├── screens/
│   ├── home_screen.dart     # Pantalla de inicio
│   ├── contact_screen.dart  # Formulario de contacto
│   ├── solutions_screen.dart
│   ├── support_screen.dart
│   ├── pdf_screen.dart
│   └── builder_blocs/       # BLoCs específicos de campos
└── utils/
    ├── file_render.dart
    └── pdf_render.dart
```

### 2. **State Management Layer** (`lib/src/viewmodel/`)

Gestiona el estado de la aplicación utilizando BLoC/Cubit.

**Componentes principales:**
- **Cubits**: Lógica de estado simple
  - `ContactCubit`: Gestión del formulario de contacto
  - `FileCubit`: Gestión de archivos
  - `NavigationIndexCubit`: Control del índice de navegación

- **BLoCs**: Lógica de negocio más compleja
  - `NameBloc`, `EmailBloc`, `PhoneBloc`: Validación de campos
  - `CityBloc`, `CountryBloc`: Selección de ubicación
  - `ContactReasonBloc`, `RequirementBloc`: Razones de contacto

- **States**: Clases que representan los estados
  - `ContactState`: Estado del formulario de contacto
  - `FileState`: Estado de gestión de archivos

- **Formz Inputs**: Validadores de entrada
  - Cada campo tiene su propio validador personalizado
  - Utiliza la librería `formz` para validación

```
lib/src/viewmodel/
├── cubits/
│   ├── contact_cubit.dart      # Gestión de contacto
│   ├── file_cubit.dart         # Gestión de archivos
│   └── navigation_index_cubit.dart
├── states/
│   ├── contact_state.dart
│   └── file_state.dart
└── formz_input/
    ├── city_input.dart
    ├── email_input.dart
    ├── phone_input.dart
    ├── name_lastname_input.dart
    └── models/
        └── file.dart
```

### 3. **Data Layer** (`lib/src/services/`)

Maneja la comunicación con datos externos. Para posibles actualizaciones.

**Componentes principales:**
- **Services**: Abstracciones para operaciones de datos
  - `FileInputService`: Interfaz para operaciones de archivo
  - `PDFFileInputService`: Implementación para archivos PDF

```
lib/src/services/
├── file_input_service.dart      # Interfaz
└── pdf_file_input_service.dart  # Implementación
```

### 4. **Configuration & Theme Layer** (`lib/config/`)

Define la configuración visual y temática de la aplicación.

**Componentes principales:**
- **Themes**: Temas y estilos
  - `AppColors`: Paleta de colores
  - `AppTypography`: Tipografía (Google Fonts - Raleway)
  - `AppInputDecoration`: Estilos de campos de entrada

- **Constants**: Valores constantes

- **Widgets**: Componentes genéricos reutilizables

```
lib/config/
├── constants/
├── themes/
│   ├── app_colors.dart
│   ├── app_typography.dart
│   └── app_input_decoration.dart
└── widgets/
    ├── background_video.dart
    ├── designed_button.dart
    ├── image_carousel.dart
    └── navigation_bar.dart
```

---

## 📋 Requisitos Previos

Para ejecutar ISHelper App, necesitas:

- **Flutter SDK**: Versión 3.10.1 o superior
  - [Descargar Flutter](https://flutter.dev/docs/get-started/install)

- **Dart SDK**: Incluido con Flutter (versión 3.10.1+)

- **Entorno de Desarrollo**:
  - Visual Studio Code con extensión Flutter
  - Android Studio (preferiblemente)

- **Dispositivo o Emulador**:
  - Android 5.0+ (API level 21+)
  - iOS 11.0+

**Verificar la instalación:**
```bash
flutter --version
dart --version
```

---

## 🚀 Instalación

### 1. Clonar el Repositorio

```bash
git clone https://github.com/tu-usuario/ishelper_app.git
cd ishelper_app
```

### 2. Obtener las Dependencias

```bash
flutter pub get
```

Este comando descargará todas las dependencias especificadas en `pubspec.yaml`:

```yaml
dependencies:
  flutter: sdk
  cupertino_icons: ^1.0.8
  video_player: ^2.10.1
  formz: ^0.8.0
  equatable: ^2.0.7
  flutter_bloc: ^9.1.1
  flutter_intl_phone_field: ^0.0.7
  country_code_picker: ^3.4.1
  google_fonts: ^6.3.3
  cached_network_image: ^3.4.1
  webview_flutter: ^4.13.0
  flutter_cached_pdfview: ^0.4.3
  flutter_cache_manager: ^3.3.1
  go_router: ^17.0.1
  share_plus: ^12.0.1
  path_provider: ^2.1.5
  url_launcher: ^6.3.2
```

---

## ▶️ Ejecución

### En Emulador/Dispositivo Físico

#### Listar dispositivos disponibles:
```bash
flutter devices
```

#### Ejecutar la aplicación:
```bash
# Modo debug (por defecto)
flutter run

# Modo release (optimizado)
flutter run --release

# En dispositivo específico
flutter run -d <device-id>
```

#### Con flags útiles:
```bash
# Con hot reload habilitado
flutter run --hot

# Sin análisis de código
flutter run --no-analyze

# Mostrar salida detallada
flutter run -v
```

### Ejecutar en Navegador (Web)

```bash
flutter run -d chrome
```

### Construir APK/AAB (Android)

```bash
# Build APK
flutter build apk --release

# Build App Bundle (para Google Play)
flutter build appbundle --release
```

### Construir IPA (iOS)

```bash
flutter build ios --release
```

---

## 🧪 Pruebas

### Ejecutar Todas las Pruebas

```bash
flutter test
```

### Ejecutar Pruebas Específicas

```bash
# Pruebas de un archivo
flutter test test/src/viewmodel/cubits/contact_cubit_test.dart

# Pruebas con un patrón específico
flutter test --name "ContactCubit"
```

### Pruebas con Cobertura

```bash
# Generar reporte de cobertura
flutter test --coverage

# Ver el reporte en HTML
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Estructura de Pruebas

```
test/
├── src/
│   ├── view/
│   │   └── screens/
│   │       └── builder_blocs/
│   │           ├── city_bloc_test.dart
│   │           ├── contact_reason_bloc_test.dart
│   │           ├── country_bloc_test.dart
│   │           ├── email_bloc_test.dart
│   │           ├── lastname_bloc_test.dart
│   │           ├── name_bloc_test.dart
│   │           ├── phone_bloc_test.dart
│   │           └── requirement_bloc_test.dart
│   └── viewmodel/
│       ├── cubits/
│       │   ├── contact_cubit_test.dart
│       │   └── file_cubit_test.dart
│       └── formz_input/
│           ├── file_input_test.dart
│           └── formz_inputs_test.dart
```

### Pruebas Disponibles

#### BLoCs y Cubits
- `contact_cubit_test.dart`: Pruebas de validación y envío de contacto
- `file_cubit_test.dart`: Pruebas de gestión de archivos

#### Form Inputs
- `formz_inputs_test.dart`: Pruebas de validadores
- `file_input_test.dart`: Pruebas de entrada de archivo


## 📚 Documentación del Código

### Generar Documentación Automática

La aplicación utiliza **DartDoc** para generar documentación a partir de los comentarios de código.

#### Generar documentación HTML:
```bash
dart doc

# O con flutter
flutter pub pub global run dartdoc
```

#### Ver la documentación generada:
```bash
# La documentación se genera en doc/api/
open doc/api/index.html
```

### Comentarios de Documentación

Todos los archivos principales incluyen comentarios DartDoc de alta calidad:

```dart
/// Una breve descripción de la clase.
///
/// Una descripción más detallada que explica:
/// - Qué hace la clase
/// - Cuándo usarla
/// - Cómo funciona
///
/// Ejemplo:
/// ```dart
/// final cubit = ContactCubit();
/// cubit.nameChanged("Juan");
/// ```
///
/// Ver también:
/// - [OtraClase]: Para información relacionada
class MiClase {
  /// Documentación del método
  void miMetodo() {}
}
```

### Archivos Documentados

- ✅ `main.dart` - Punto de entrada
- ✅ `app_router.dart` - Configuración de rutas
- ✅ `contact_cubit.dart` - Gestión de contacto
- ✅ `file_cubit.dart` - Gestión de archivos
- ✅ `home_screen.dart` - Pantalla de inicio

---

## 📁 Estructura del Proyecto

```
ishelper_app/
├── lib/                              # Código fuente principal
│   ├── main.dart                     # Punto de entrada
│   ├── config/                       # Configuración y temas
│   │   ├── constants/                # Constantes
│   │   ├── themes/                   # Temas visuales
│   │   │   ├── app_colors.dart
│   │   │   ├── app_typography.dart
│   │   │   └── app_input_decoration.dart
│   │   └── widgets/                  # Widgets reutilizables
│   │       ├── background_video.dart
│   │       ├── designed_button.dart
│   │       ├── image_carousel.dart
│   │       └── navigation_bar.dart
│   └── src/                          # Lógica de negocio
│       ├── services/                 # Servicios de datos
│       │   ├── file_input_service.dart
│       │   └── pdf_file_input_service.dart
│       ├── view/                     # Capa de presentación
│       │   ├── app_router.dart       # Configuración de rutas
│       │   ├── screens/              # Pantallas
│       │   │   ├── home_screen.dart
│       │   │   ├── contact_screen.dart
│       │   │   ├── solutions_screen.dart
│       │   │   ├── support_screen.dart
│       │   │   ├── pdf_screen.dart
│       │   │   └── builder_blocs/    # BLoCs de validación
│       │   └── utils/                # Utilidades
│       │       ├── file_render.dart
│       │       └── pdf_render.dart
│       └── viewmodel/                # Estado y lógica
│           ├── cubits/               # Cubits
│           │   ├── contact_cubit.dart
│           │   ├── file_cubit.dart
│           │   └── navigation_index_cubit.dart
│           ├── states/               # Clases de estado
│           │   ├── contact_state.dart
│           │   └── file_state.dart
│           └── formz_input/          # Validadores
│               ├── city_input.dart
│               ├── email_input.dart
│               ├── phone_input.dart
│               ├── name_lastname_input.dart
│               ├── country_input.dart
│               ├── country_code_input.dart
│               ├── contact_reason_input.dart
│               ├── requirement_input.dart
│               ├── file_input.dart
│               └── models/
│                   └── file.dart
├── test/                             # Pruebas unitarias
│   └── src/                          # Estructura paralela a lib/src
│       ├── view/
│       │   └── screens/
│       │       └── builder_blocs/    # Pruebas de BLoCs
│       └── viewmodel/
│           ├── cubits/               # Pruebas de Cubits
│           └── formz_input/          # Pruebas de validadores
├── android/                          # Código Android nativo
├── ios/                              # Código iOS nativo
├── web/                              # Código Web
├── windows/                          # Código Windows
├── linux/                            # Código Linux
├── macos/                            # Código macOS
├── assets/                           # Assets (imágenes, videos, etc.)
│   ├── images/
│   ├── video/
│   └── data/
├── pubspec.yaml                      # Dependencias y configuración
├── analysis_options.yaml             # Opciones de análisis
├── devtools_options.yaml             # Opciones de devtools
└── README.md                         # Este archivo
```

---

**Última actualización:** 24 de Diciembre 2025
