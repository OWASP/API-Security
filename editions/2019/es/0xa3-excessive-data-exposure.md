API3:2019 Exposición de Datos Excesiva
======================================

| Amenazas/Vectores de ataque | Debilidades de seguridad | Impactos |
| - | - | - |
| Específico de la API : Explotabilidad **3** | Frecuencia **2** : Detectabilidad **2** | Técnico **2** : Específico del Negocio |
| La explotación de la Exposición de Datos Excesiva es simple, y usualmente es realizada inspeccionando el tráfico para analizar las respuestas de la API, buscando exposiciones de datos sensibles que no deberían ser devueltos al usuario. | Las APIs delegan en los clientes la realización de filtrado de datos. Como las APIs son usadas como fuentes de datos, a veces los desarrolladores intentan implementarlas de una manera genérica sin pensar sobre la sensibilidad de los datos expuestos. Las herramientas automáticas usualmente no pueden detectar este tipo de vulnerabilidad, ya que es difícil diferenciar entre datos legítimos devueltos por la API y datos sensibles que no deberían ser devueltos, sin un profundo conocimiento de la aplicación. | La Exposición de Datos Excesiva comúnmente deriva en la exposición de datos sensibles. |

## ¿Es vulnerable la API?

La API devuelve datos sensibles al cliente por ser diseñada de esta manera.
Estos datos son usualmente filtrados del lado del cliente antes de ser presentados al usuario.
Un atacante puede inspeccionar el tráfico fácilmente y ver los datos sensibles.

## Escenarios de Ataque de Ejemplo

### Escenario #1

El equipo móvil usa el recurso `/api/articles/{articleId}/comments/{commentId}`
en la vista de artículos para mostrar metadatos de comentarios.
Inspeccionando el tráfico de la aplicación móvil, un atacante descubre que otros datos sensibles
relacionados al autor del comentario también son devueltos. La implementación del recurso utiliza un método
`toJSON()` en el modelo `User`, que contiene PII, al serializar el objeto.

### Escenario #2

Un sistema de vigilancia basado en IoT permite a los administradores crear usuarios con diferentes permisos.
Un administrador creó una cuenta de usuario para un nuevo guardia de seguridad que debería tener acceso
solo a edificios específicos del lugar. Una vez que el guardia de seguridad utiliza su aplicación móvil,
una llamada a API es disparada a: `/api/sites/111/cameras` para recibir información sobre las cámaras disponibles
y mostrarlas en el panel de control. La respuesta contiene una lista con detalles sobre las cámaras en el
siguiente formato: `{"id":"xxx","live_access_token":"xxxx-bbbbb","building_id":"yyy"}`.
Mientras la GUI del cliente solo muestra las cámaras a las que el guardia de seguridad debería tener acceso,
la respuesta de la API contiene una lista completa de todas las cámaras en el lugar.

## Cómo prevenir

* Nunca delegue en el cliente el filtrado de datos sensibles.
* Revise las respuestas de la API para asegurarse que contienen solo datos legítimos.
* Los ingenieros de backend deberían preguntarse siempre: "Quién es el consumidor de esta información" antes de exponer un nuevo recurso de API
* Evitar el uso de métodos genéricos como `to_json()` y `to_string()`.
  En cambio, seleccione una a una las propiedades específicas que realmente quiere devolver.
* Clasifique la información sensible y personalmente identificable
  (PII por las siglas en inglés de Personally Identifable Information)
  que su aplicación almacena y utiliza, revisando todas las llamadas API que devuelvan dicha información
  para ver si esas respuestas pueden convertirse en un problema de seguridad.
* Implemente un mecanismo de validación de respuesta basado en esquemas como una capa de seguridad adicional. Ya que parte de este mecanismo define y asegura los datos devueltos por todos los métodos API, incluyendo los errores.


## Referencias

### Externas

* [CWE-213: Intentional Information Exposure][1]

[1]: https://cwe.mitre.org/data/definitions/213.html
