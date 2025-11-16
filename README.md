# AppSwift

Aplicación móvil en SwiftUI que demuestra el criterio de aceptación solicitado: permitir ingresar un número y reportar si es par o impar. El proyecto incluye dos pestañas:

1. **Inicio:** explica el contexto del lenguaje Swift y la actividad.
2. **Paridad:** formulario donde se ingresa un número, se valida y se muestra si es par o impar.

## Requisitos
- Xcode 14 o superior.
- iOS 15.0 o superior.
- Para usar el proyecto en VS Code: Swift toolchain instalada y las extensiones [Swift](https://marketplace.visualstudio.com/items?itemName=sswg.swift-lang) y [SweetPad](https://marketplace.visualstudio.com/items?itemName=sweetpad.sweetpad).

## Estructura del proyecto (SwiftPM)

Ahora el proyecto también se distribuye como paquete Swift para que pueda abrirse y compilarse desde VS Code. La estructura relevante es:

- `Package.swift`: manifiesto SwiftPM con un producto `.iOSApplication` listo para SweetPad.
- `Sources/App`: código fuente principal y recursos (Assets, vistas, etc.).

> El campo `teamIdentifier` del manifiesto está en `Package.swift` y debe reemplazarse con tu Team ID de Apple si deseas firmar para dispositivo físico. Para simulador suele bastar un valor placeholder.

## Ejecución en VS Code con SweetPad
1. Abre la carpeta del repositorio en VS Code.
2. Instala y activa las extensiones **Swift** y **SweetPad**.
3. Asegúrate de que el toolchain de Swift apunte al de Xcode (SweetPad ofrece el comando `SweetPad: Select Xcode Toolchain`).
4. Usa el comando de paleta `SweetPad: Build iOS App` para compilar el producto `AppSwift`. El manifiesto ya declara los recursos y el `Info.plist`.
5. Ejecuta `SweetPad: Run on Simulator` para lanzar la app en un simulador iOS desde VS Code. Si te solicita un Team ID, edita `Package.swift` y vuelve a compilar.

## Ejecución en Xcode
1. Abre `AppSwift.xcodeproj` en Xcode.
2. Selecciona un simulador de iOS.
3. Compila y ejecuta la app (`Cmd + R`).

## ¿Cómo previsualizar la app rápidamente?
Si sólo necesitas ver la interfaz y probar la lógica sin ejecutar todo el simulador, puedes usar los *SwiftUI Previews* integrados en Xcode:

1. Abre `ContentView.swift` y `ParityCheckView.swift`.
2. En la parte derecha del editor de Xcode, haz clic en el botón **Canvas** si no está visible.
3. Pulsa el botón **Resume** o `Option + Cmd + P` para que Xcode renderice la vista.
4. Podrás interactuar con cada pantalla directamente desde la vista previa; introduce valores en el formulario de "Paridad" para comprobar el comportamiento sin levantar la app completa.

> Nota: si la vista previa se detiene, vuelve a presionar **Resume** para recompilar los cambios.

## Estado del repositorio y nueva rama para PR

Se ejecutó `git fsck` para validar que el historial no esté corrupto; no se encontraron errores. Además, se añadió la rama
`pr-ready` apuntando al último commit con todo el contenido de la app. Para generar un Pull Request:

1. Sube tu rama base (por ejemplo, `main`) y la rama `pr-ready` al remoto.
2. Abre el PR comparando `pr-ready` contra tu rama base.

Consulta `docs/GitHealth.md` para ver los comandos exactos utilizados y cómo recrear la rama en caso de ser necesario.
