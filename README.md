# counter_uikit

Aplicación de ejemplo para iOS, construida con **UIKit**, pensada para quienes empiezan en el desarrollo iOS.

La app muestra un contador en pantalla y un botón **"Incrementar"**. Cada vez que se pulsa el botón:

- El número del contador aumenta en 1.
- El color del texto cambia: **azul** si el número es par y **rojo** si es impar.

## Objetivos de aprendizaje

Con este proyecto se practican los siguientes conceptos:

- Crear una interfaz **por código** (sin diseñar la pantalla en el Storyboard).
- Usar **Auto Layout** con `NSLayoutConstraint` y anchors.
- Separar las responsabilidades con el patrón **MVC** (Modelo-Vista-Controlador).
- Usar el patrón **Target-Action** para responder a los toques del usuario.
- Seguir el **ciclo de vida** de un `UIViewController` (`loadView`, `viewDidLoad`).
- Manejar **varios entornos** (QA / PRD) con archivos `.xcconfig`.

## Estructura del proyecto

```
counter_uikit/
├── QA.xcconfig                      # Variables del entorno de pruebas
├── PRD.xcconfig                     # Variables del entorno de producción
└── counter_uikit/
    ├── AppDelegate.swift            # Punto de entrada de la aplicación
    ├── SceneDelegate.swift          # Gestiona la ventana (escena) de la app
    ├── Info.plist                   # Configuración de la app (lee variables de los .xcconfig)
    ├── Assets.xcassets              # Iconos, colores e imágenes
    ├── LaunchScreen.storyboard      # Pantalla de arranque
    ├── Controlador/
    │   └── CounterViewController.swift   # Lógica de la pantalla (estado y acciones)
    └── Vista/
        ├── CounterView.swift             # Parte gráfica: label, botón y constraints
        └── Main.storyboard               # Storyboard inicial que carga CounterViewController
```

## Arquitectura (MVC)

| Capa | Archivo | Responsabilidad |
| --- | --- | --- |
| Modelo | `count` (propiedad en el controlador) | Guarda el valor actual del contador. |
| Vista | `Vista/CounterView.swift` | Crea los elementos visuales, les da estilo y los coloca con Auto Layout. Expone `update(count:)` para refrescarse. |
| Controlador | `Controlador/CounterViewController.swift` | Asigna `CounterView` como su vista, conecta el botón y actualiza el modelo y la vista al pulsar. |

Flujo al pulsar el botón:

```
Usuario pulsa "Incrementar"
        │
        ▼
CounterViewController.incrementTapped()
        │  count += 1
        ▼
CounterView.update(count:)  →  cambia el texto y el color del label
```

## Entornos: QA y PRD

El proyecto tiene dos configuraciones de compilación, y cada una usa su propio archivo `.xcconfig`:

| Variable | QA | PRD |
| --- | --- | --- |
| `API_BASE_URL` | `https://qa.google.com` | `https://google.com` |
| `APP_DISPLAY_NAME` | `MiApp QA` | `MiApp PRD` |
| `PRODUCT_BUNDLE_IDENTIFIER` | `com.google.miapp.qa` | `com.google.miapp.prd` |

El `Info.plist` lee estas variables (`$(API_BASE_URL)`, `$(APP_DISPLAY_NAME)`). Al arrancar, el controlador imprime en consola la URL del entorno activo:

```swift
let url = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL")
```

> Nota: en un `.xcconfig`, `//` se interpreta como comentario. Por eso la URL se escribe como `https:/$()/...`.

## Requisitos

- Xcode con el SDK de iOS 27.2 o superior.
- Simulador o dispositivo con iOS 27.2+.

## Cómo ejecutar

1. Abre `counter_uikit.xcodeproj` en Xcode.
2. Selecciona un esquema:
   - **counter_uikit**
   - **MIApp QA**: usa la configuración de QA.
3. Elige un simulador y pulsa **Run** (⌘R).
4. Pulsa **"Incrementar"** y observa cómo cambian el número y el color.
5. Revisa la consola de Xcode para ver la `API_BASE_URL` del entorno activo.

## Autor

Salvador Lopez, curso de Desarrollo de Aplicaciones iOS Básico (Netec, 2026).
