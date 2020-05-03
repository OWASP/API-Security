API6:2019 - Asignación Masiva
=============================

| Amenazas/Vectores de ataque | Debilidades de seguridad | Impactos |
| - | - | - |
| Específico de la API : Explotabilidad **2** | Frecuencia **2** : Detectabilidad **2** | Técnico **2** : Específico del Negocio |
| La explotación usualmente requiere un conocimiento de la lógica de negocio, relaciones de objetos y la estructura de la API.
La explotación de la asignación masiva es más fácil en las API, ya que por diseño exponen la implementación subyacente de la aplicación
junto con los nombres de las propiedades. | Los marcos modernos alientan a los desarrolladores a usar funciones que enlazan
automáticamente la entrada del cliente en variables de código y objetos internos. Los atacantes pueden usar esta metodología para
actualizar o sobrescribir las propiedades de objetos sensibles que los desarrolladores nunca tuvieron la intención de exponer. |
La explotación puede conducir a la escalada de privilegios, la manipulación de datos, eludir los mecanismos de seguridad y más. |

## ¿Es vulnerable la API?

Los objetos en aplicaciones modernas pueden contener muchas propiedades.
Algunas de estas propiedades deben ser actualizadas directamente por el cliente
(ej. `user.first_name` or `user.address`) y algunas no (ej. la bandera `user.is_vip`).

Un recurso de API es vulnerable si convierte automáticamente los parámetros del cliente
en propiedades de objeto interno, sin considerar la sensibilidad y el nivel de
exposición de estas propiedades. Esto podría permitir que un atacante actualice
propiedades de objeto a las que no deberían tener acceso.

Ejemplos de propiedades sensibles:

* **Propiedades relacionadas a permisos**: `user.is_admin`, `user.is_vip` deberían
  ser escritas sólo por administradores.
* **Propiedades dependientes del proceso**: `user.cash` debería ser escrita sólo
  internamente luego de la verificación del pago.
* **Propiedades internas**: `article.created_time` debería ser escrita sólo
  internamente por la aplicación.

## Escenarios de Ataque de Ejemplo

### Escenario #1

Una aplicación de viaje compartido le brinda al usuario la opción de editar
información básica de su perfil. Durante este proceso, se envía una llamada API
a `PUT /api/v1/users/me` con el siguiente objeto JSON legítimo:

```json
{"user_name":"inons","age":24}
```

La petición `GET /api/v1/users/me` incluye una propiedad adicional
credit_balance:

```json
{"user_name":"inons","age":24,"credit_balance":10}.
```

El atacante replica el primer request con el siguiente contenido:

```json
{"user_name":"attacker","age":60,"credit_balance":99999}
```

Como el recurso es vulnerable a asignación masiva, el atacante recibe
crédito sin pagar.

### Escenario #2

Un portal para compartir videos permite a los usuarios cargar y descargar contenido en
diferentes formatos. Un atacante que explora la API descubrió que el recurso
`GET /api/v1/videos/{video_id}/meta_data` devuelve un objeto JSON con las propiedades
del video. Una de las propiedades es `"mp4_conversion_params":"-vcodec h264"`,
que indica que la aplicación usa un comando de shell para convertir el video.

El atacante también descubrió que el recurso `POST /api/v1/videos/new` es vulnerable a
asignación masiva y permite al cliente establecer cualquier propiedad del objeto de video.
El atacante establece un valor malicioso de la siguiente manera:
`"mp4_conversion_params":"-vcódec h264 && format C:/"`. Este valor causará un
inyección de comandos de shell una vez que el atacante descargue el video como MP4.

## Cómo prevenir

* Cuando sea posible, evite usar funciones que enlazan automáticamente una entrada de cliente
  con variables de código u objetos internos.
* Incluya en una lista blanca solo las propiedades que el cliente debe actualizar.
* Utilice las funciones integradas para incluir en la lista negra las propiedades a las que
  no deben acceder los clientes.
* Cuando corresponda, defina explícitamente y haga cumplir esquemas para los datos de entrada.

## Referencias

### Extrernas

* [CWE-915: Improperly Controlled Modification of Dynamically-Determined Object Attributes][1]

[1]: https://cwe.mitre.org/data/definitions/915.html
