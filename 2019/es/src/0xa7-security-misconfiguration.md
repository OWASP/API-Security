API7:2019 Configuración incorrecta de seguridad
===================

|Agente/Vector de Ataque | Debilidades de Seguridad | Impacto |
| - | - | - |
| API Específica : Explotabilidad **3** | Prevalencia **3** : Detectabilidad **3** | Técnico **2** : ¿Negocio? |
| Los atacantes a menudo intentarán encontrar fallas que no han sido actualizadas, métodos comunes que estén expuestos o archivos y directorios desprotegidos para obtener acceso no autorizado o conocimiento del sistema. | La configuración incorrecta de seguridad puede ocurrir en cualquier nivel de la pila de API, desde el nivel de red hasta el nivel de aplicación. Hay herramientas automatizadas que están disponibles para detectar y explotar configuraciones incorrectas, como servicios innecesarios u opciones obsoletas. | Las configuraciones incorrectas de seguridad no solo pueden exponer datos confidenciales del usuario, sino también detalles del sistema que pueden llevar a un compromiso total del servidor. |


## ¿La API es Vulnerable?

La API puede ser vulnerable si:

* Falta fortificación apropiada de seguridad en cualquier parte de la pila de la aplicación, o si tiene permisos incorrectamente configurados en los servicios en la nube.
* Faltan los últimos parches de seguridad o los sistemas están desactualizados.
* Se habilitan funciones innecesarias (por ejemplo, verbos HTTP).
* Falta la seguridad de la capa de transporte (TLS).
* Las directivas de seguridad no se envían a los clientes (por ejemplo, [Encabezados de seguridad][1]).
* Falta una política de intercambio de recursos de origen cruzado (CORS) o está configurada incorrectamente.
* Los mensajes de error incluyen rastros de la pila u otra información confidencial está expuesta.


## Ejemplos de escenarios de ataque

### Escenario #1

Un atacante encuentra el archivo `.bash_history` en el directorio raíz del
servidor, que contiene comandos utilizados por el equipo de DevOps para acceder a la API:

```
$ curl -X GET 'https: //api.server/endpoint/' -H 'autorización: Basic Zm9vOmJhcg=='
```

Un atacante también podría encontrar nuevos métodos expuestos por la API que solo son utilizados por el equipo de DevOps y no están documentados.

### Escenario #2

Para atacar a un servicio en específico, un atacante utiliza un motor de búsqueda popular para buscar computadoras que son directamente accesibles desde Internet. El atacante encontró un host ejecutando un sistema de gestión de base de datos popular, escuchando por el puerto predeterminado. El host estaba usando la configuración predeterminada, la cual tiene la autenticación deshabilitada por defecto, y el atacante obtuvo acceso a millones de registros con Información Personal Identificable (PII), preferencias personales y datos de autenticación.

### Escenario #3
Al inspeccionar el tráfico de una aplicación móvil, un atacante descubre que no todo
el tráfico HTTP se realiza utilizando un protocolo seguro (por ejemplo, TLS). El atacante encuentra que esto es cierto, específicamente para la descarga de imágenes de perfil. Debido a que la interacción con el usuario es binaria, a pesar del hecho de que el tráfico de la API se realiza por medio de un protocolo seguro, el atacante encuentra un patrón en el tamaño de las respuestas de la API, las cuales utiliza para rastrear las preferencias del usuario sobre el contenido que se representa (por ejemplo, imágenes de perfil).

## Cómo se previene
El ciclo de vida de la API debe de incluir:
* Un proceso de fortificación repetible que lleve hacia una implementación
rápida y fácil en un ambiente debidamente aislado.
* Una tarea para revisar y actualizar configuraciones en toda la pila de la API.
La revisión debe incluir: archivos de orquestación, componentes de la API y
servicios en la nube (por ejemplo, permisos en una cubeta S3).
* Un canal de comunicación seguro para todas las interacciones de la API
  cuando ésta accede a los activos estáticos (por ejemplo, imágenes).
* Un proceso automatizado para evaluar continuamente la efectividad de la
   configuración y ajustes en todos los ambientes.

Además:

* Para evitar que los rastros de excepción y otro tipo de información valiosa
sea enviada a los atacantes, solo si aplica, defina y aplique un estándar a todas las respuestas de la API, incluyendo las respuestas de errores.
* Asegúrese de que solo los verbos HTTP especificados puedan acceder a la API.
Todos los demás verbos HTTP deben de deshabilitarse (por ejemplo, HEAD).
* Las APIs que esperan ser accedidas desde clientes basados en navegador
(por ejemplo, front-end de una aplicación web) deben implementar una política
adecuada de intercambio de recursos de origen cruzado (CORS).


## Referencias

### OWASP

* [OWASP Secure Headers Project][1]
* [OWASP Testing Guide: Configuration Management][2]
* [OWASP Testing Guide: Testing for Error Codes][3]
* [OWASP Testing Guide: Test Cross Origin Resource Sharing][9]


### Externos

* [CWE-2: Environmental Security Flaws][4]
* [CWE-16: Configuration][5]
* [CWE-388: Error Handling][6]
* [Guide to General Server Security][7], NIST
* [Let’s Encrypt: a free, automated, and open Certificate Authority][8]

[1]: https://www.owasp.org/index.php/OWASP_Secure_Headers_Project
[2]: https://www.owasp.org/index.php/Testing_for_configuration_management
[3]: https://www.owasp.org/index.php/Testing_for_Error_Code_(OTG-ERR-001)
[4]: https://cwe.mitre.org/data/definitions/2.html
[5]: https://cwe.mitre.org/data/definitions/16.html
[6]: https://cwe.mitre.org/data/definitions/388.html
[7]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[8]: https://letsencrypt.org/
[9]: https://www.owasp.org/index.php/Test_Cross_Origin_Resource_Sharing_(OTG-CLIENT-007)
