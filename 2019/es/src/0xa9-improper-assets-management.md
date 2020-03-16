API9:2019 Control de Acceso Inapropiado
====================================

|Agente/Vector de Ataque | Debilidades de Seguridad | Impacto |
| - | - | - |
| API Específica : Explotabilidad **2** | Prevalencia **3** : Detectabilidad **1** | Técnico **2** : Negocio |
| Old API versions are usually unpatched and are an easy way to compromise systems without having to fight state-of-the-art security mechanisms, which might be in place to protect the most recent API versions. | Outdated documentation makes it more difficult to find and/or fix vulnerabilities. Lack of assets inventory and retire strategies leads to running unpatched systems, resulting in leakage of sensitive data. It’s common to find unnecessarily exposed API hosts because of modern concepts like microservices, which make applications easy to deploy and independent (e.g., cloud computing, k8s). | Attackers may gain access to sensitive data, or even takeover the server through old, unpatched API versions connected to the same database. |

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
atacante encontró la dirección de la API (`api.someservice.com / v2`). Reemplazando `v2` con
`v1` en la URL, el atacante obtuvo acceso a la antigua API desprotegida,
exponiendo la información personal identificable (PII) de más de 100 millones de usuarios.

### Escenario #2

Una red social implementó un mecanismo de limitación de velocidad que bloquea a los atacantes de usar un ataque de fuerza bruta para adivinar tokens de restablecimiento de contraseña. Este mecanismo no fue implementado como parte del código de la API, sino en otro componente entre el cliente y la API oficial (`www.socialnetwork.com`).

Un investigador encontró un dominio de una API beta (`www.mbasic.beta.socialnetwork.com`) que corre la misma API, incluyendo el mecanismo de restablecimiento de contraseñas, pero el mecanismo de limitación de velocidad no estaba en su lugar. El investigador fue capaz de restablecer la contraseña de cualquier usuario por medio de la utilización de un simple ataque de fuerza bruta para adivinar un token de 6 dígitos.

## Cómo Prevenir

* Inventory all API hosts and document important aspects of each one of them,
  focusing on the API environment (e.g., production, staging, test,
  development), who should have network access to the host (e.g., public,
  internal, partners) and the API version.
* Inventory integrated services and document important aspects such as their
  role in the system, what data is exchanged (data flow), and its sensitivity.
* Document all aspects of your API such as authentication, errors, redirects,
  rate limiting, cross-origin resource sharing (CORS) policy and endpoints,
  including their parameters, requests, and responses.
* Generate documentation automatically by adopting open standards. Include the
  documentation build in your CI/CD pipeline.
* Make API documentation available to those authorized to use the API.
* Use external protection measures such as API security firewalls for all exposed versions of your APIs, not just for the current production version.
* Avoid using production data with non-production API deployments. If this is unavoidable, these endpoints should get the same security treatment as the production ones.
* When newer versions of APIs include security improvements, perform risk analysis to make the decision of the mitigation actions required for the older version: for example, whether it is possible to backport the improvements without breaking API compatibility or you need to take the older version out quickly and force all clients to move to the latest version.

## Referencias

### Externos

* [CWE-1059: Incomplete Documentation][1]
* [OpenAPI Initiative][2]

[1]: https://cwe.mitre.org/data/definitions/1059.html
[2]: https://www.openapis.org/
