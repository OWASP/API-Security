API9:2019 Control de Acceso Inadecuado
====================================

|Agente/Vector de Ataque | Debilidades de Seguridad | Impacto |
| - | - | - |
| API Específica : Explotabilidad **3** | Prevalencia **3** : Detectabilidad **2** | Técnico **2** : Negocio |
| Las versiones antiguas de API generalmente no tienen las últimas actualizaciones de seguridad y son una manera fácil de comprometer sistemas sin tener que luchar contra los mecanismos de seguridad más modernos, los cuales podrían estar configurados para solo proteger las versiones de las APIs más recientes. | La documentación obsoleta hace que sea más difícil encontrar y / o arreglar vulnerabilidades. La falta de inventario de activos y de estrategias de retiro de los mismos resulta que sistemas estén funcionando aunque no cuenten con las últimas actualizaciones de seguridad, lo que pudiese resultar en la fuga de datos sensibles. Es común encontrar hosts de APIs innecesariamente expuestos debido a conceptos modernos como microservicios, que hacen que las aplicaciones sean independientes y fáciles de desplegar (por ejemplo, computación en la nube, k8s). | Los atacantes pueden obtener acceso a datos sensibles, o incluso tomar el control de un servidor a través del uso de una versión antigua y desactualizada de alguna API conectada a la misma base de datos. |

## ¿La API es Vulnerable?

La API es vulnerable si:

* The purpose of an API host is unclear, and there are no explicit answers to
  the following questions:
  * Which environment is the API running in (e.g., production, staging, test,
    development)?
  * Who should have network access to the API (e.g., public, internal, partners)?
  * Which API version is running?
  * What data is gathered and processed by the API (e.g., PII)?
  * What's the data flow?
* There is no documentation, or the existing documentation is not updated.
* There is no retirement plan for each API version.
* Hosts inventory is missing or outdated.
* Integrated services inventory, either first- or third-party, is missing or
  outdated.
* Old or previous API versions are running unpatched.

## Escenarios de Ataque de Ejemplo

### Escenario #1

Después de rediseñar sus aplicaciones, un servicio de búsqueda dejó una versión antigua de la API (`api.someservice.com/v1`) en ejecución, sin protección y con acceso a la base de datos. Mientras se dirigía a una de las últimas aplicaciones lanzadas, un
atacante encontró la dirección de la API (`api.someservice.com/v2`). Reemplazando `v2` con
`v1` en la URL, el atacante obtuvo acceso a la antigua API desprotegida,
exponiendo la información personal identificable (PII) de más de 100 millones de usuarios.

### Escenario #2

Una red social implementó un mecanismo de limitación de velocidad que bloquea a los atacantes de usar un ataque de fuerza bruta para adivinar tokens de restablecimiento de contraseña. Este mecanismo no fue implementado como parte del código de la API, sino en otro componente entre el cliente y la API oficial (`www.socialnetwork.com`). Un investigador encontró un dominio de una API beta (`www.mbasic.beta.socialnetwork.com`) que corre la misma API, incluyendo el mecanismo de restablecimiento de contraseñas, pero el mecanismo de limitación de velocidad no estaba en su lugar. El investigador fue capaz de restablecer la contraseña de cualquier usuario por medio de la utilización de un simple ataque de fuerza bruta para adivinar un token de 6 dígitos.

## Cómo Prevenir

* Haga un inventario de todos los hosts de sus APIs y documente aspectos
importantes de cada un de ellas, centrándose en el entorno de la API
(por ejemplo, producción, pre-producción, pruebas, desarrollo), quién debe
tener acceso de red al host (por ejemplo, pública, interna, socios) y la versión
de la API.
* Haga un inventario de servicios integrados y documente aspectos importantes
como su propósito en el sistema, qué datos se manejan (flujo de datos) y su
nivel de sensibilidad.
* Documente todos los aspectos de su API, como autenticación, errores,
redireccionamientos, política de límite de velocidad, intercambio de recursos de
origen cruzado (CORS) y métodos expuestos, incluidos sus parámetros,
solicitudes y respuestas.
* Genere la documentación automáticamente por medio de la adopción de estándares
abiertos. Incluya la documentación de compilación en su proceso de
Integración Continua / Despliegue continuo.
* Ponga la documentación de la API a disposición de aquellos autorizados para
usar la API.
* Use medidas de protección externa, como firewalls de seguridad para todas las
versiones expuestas de sus APIs, es decir, no solo para la versión de producción
más actual.
* Evite usar datos de producción con implementaciones de APIs que no sean de
producción. Si esto es inevitable, estos métodos expuestos deben de recibir el
mismo cuidado de seguridad que las que se encuentran en producción.
* Cuando las versiones más recientes de las APIs incluyan mejoras de seguridad,
realice un análisis de riesgo para tomar la decisión de las acciones de
mitigación requeridas para las versiones anteriores: por ejemplo, ver si es
posible hacer esas mejoras de seguridad sin romper la compatibilidad de las APIs
anteriores o ver si necesita remover la versión anterior rápidamente y obligar a
todos los clientes a que solo puedan usar la última versión.

## Referencias

### Externos

* [CWE-1059: Incomplete Documentation][1]
* [OpenAPI Initiative][2]

[1]: https://cwe.mitre.org/data/definitions/1059.html
[2]: https://www.openapis.org/
