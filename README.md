# DOCUMENTACIÓN DE VERSIONADO Y RESULTADOS DE LA INVESTIGACIÓN PERTINENTES PARA EL PROYECTO

## TECNOLOGÍAS DE PERSISTENCIA QUE SE UTILIZAN

### Drift+drift_flutter.

En flutter existen varias tecnologías multiplataforma para el uso de SQLite. Pero drift otorga la ventaja de acceso a los archivos en el entorno web. Utiliza una version de sqlite compilada a WASM para que el almacenamiento del navegador este sincronizado con el almacenamiento local que contiene la base de datos.

## VERSIONADO:

- Al instalar drift:
- drift: 2.35.4
- drift_dev: 2.35.3
- drift_flutter: 0.3.1
- path_provider: 2.1.6
- build_runner: 2.17.1
- sqlite3: 3.5.2
- Flutter 3.47.0
- Dart 3.13.0

## Recursos Web: (sqlite3.wasm y drift_worker.js)
Los archivos se encuentran en /web descargados del release drift-2.35.4 en GitHub.
No se utiliza la opción para cifrado ya que no se requiere para este proyecto.
El worker se llama "drift_worker.js" y no "drift_worker.dart.js" como se menciona en la documentación de Drift.

## DISEÑO DE LA BASE LA TABLA TAREAS

| Columna    | Tipo SQLite   | Restricciones                   |
|------------|---------------|---------------------------------|
| id         | INTEGER       | Clave primaria, autoincremental |
| titulo     | TEXT          | NOT NULL                        |
| completada | INTEGER (0/1) | NOT NULL, por defecto 0         |

El id es un entero autoincremental sencillo, para una plataforma de un usuario no se requieren id largos. Además, es autoincremental para no reutilizar id's. Si una nueva utiliza un id eliminada esta no se mostrará.

El titulo es una cadena sencilla, se plantea hacer las validaciones necesarias como titulos vacíos o cadenas de espacios desde el código.

Completada es un booleano, pero sqlite no define a estos, aunque sí trabaja con False/True. En este sentido usamos 0 para False indicando que no está completada y por defecto porque una tarea nueva nunca comienza completada. Se usa 1 para True.

### VALIDACIONES

- El titulo se recorta antes de guardarse
- No hay limite de longitud en el titulo