API4:2019 Falta de Recursos & Límite de Velocidad
=================================================

| Amenazas/Vectores de ataque | Debilidades de seguridad | Impactos |
| - | - | - |
| Específico de la API : Explotabilidad **2** | Frecuencia **3** : Detectabilidad **3** | Técnico **2** : Específico del Negocio |
| La explotación requiere peticiones API simples. La autenticación no es requerida. Múltiples peticiones concurrentes pueden ser realizadas desde una sola computadora local o usando recursos computacionales en la nube. | Es común encontrar APIs que no implementan límites de velocidad o APIs donde los límites no están configurados correctamente. | La explotación puede derivar en Denegación de Servicio, haciendo que la API no responda o que se inhabilite. |

## ¿Es vulnerable la API?

Las peticiones API consumen recursos como red, CPU, memoria y almacenamiento. La
cantidad de recursos requeridos para satisfacer una petición depende en mayor medida
en los datos del usuario y la lógica de negocios del recurso. También, considere el hecho 
de que las peticiones desde múltiples clientes API compiten por los recursos disponibles.
Una API es vulnerable si al menos uno de los siguientes límites es ignorado 
o configurado inapropiadamente (p.e. muy bajo/alto):

* Tiempo de espera de ejecución
* Memoria máxima asignable
* Número de descriptores de archivo
* Número de procesos
* Tamaño de carga de la petición (p.e. cargas de archivos)
* Número de peticiones por cliente/recurso
* Número de registros por página a devolver en una sóla respuesta

## Escenarios de Ataque de Ejemplo

### Escenario #1

Un atacante carga una imagen grande realizando una petición POST a `/api/v1/images`.
Cuando la carga se completa, la API crea múltiples muestras con tamaños diferentes.
Debido al tamaño de la imagen cargada, la memoria disponible se agota durante
la creación de las muestras y la API no responde otras peticiones.

### Escenario #2

Tenemos una aplicación que contiene la lista de usuarios en una interfaz con un límite
de `200` usuarios por página. La lista de usuarios se obtiene del servidor usando
la siguiente consulta: `/api/users?page=1&size=100`. Un atacante cambia el parámetro
`size` a `200 000`, causando problemas de performance en la base de datos. Mientras
tanto, la API no responde y no es capaz que atender las peticiones clientes de éste
ni de otros clientes (o sea, Denegación de Servicio).

El mismo escenario puede usarse para provocar errores de desbordamiento de enteros 
o de desbordamiento de búfer.

## Cómo Prevenir

* Docker hace fácil el límite de [memoria][1], [CPU][2], [número de reinicios][3],
  [descriptores de archivo, y procesos][4].
* Implementar un límite de cuán seguido un cliente puede llamar a la API en un marco de tiempo definido.
* Notificar al cliente cuando el límite es excedido al proveer el número límite y el tiempo 
  en el que el límite será reiniciado.
* Agregar una correcta validación del lado del servidor para parámetros de consulta y del cuerpo de la petición, 
  específicamente aquellos que controlan el número de registros a ser devueltos en la respuesta.
* Defina y aplique un tamaño máximo de datos en todos los parámetros entrantes y cargas, como
  un largo máximo para cadenas y un máximo número de elementos en listas.


## Referencias

### OWASP

* [Blocking Brute Force Attacks][5]
* [Docker Cheat Sheet - Limit resources (memory, CPU, file descriptors,
  processes, restarts)][6]
* [REST Assessment Cheat Sheet][7]

### Externas

* [CWE-307: Improper Restriction of Excessive Authentication Attempts][8]
* [CWE-770: Allocation of Resources Without Limits or Throttling][9]
* “_Rate Limiting (Throttling)_” - [Security Strategies for Microservices-based
  Application Systems][10], NIST

[1]: https://docs.docker.com/config/containers/resource_constraints/#memory
[2]: https://docs.docker.com/config/containers/resource_constraints/#cpu
[3]: https://docs.docker.com/engine/reference/commandline/run/#restart-policies---restart
[4]: https://docs.docker.com/engine/reference/commandline/run/#set-ulimits-in-container---ulimit
[5]: https://www.owasp.org/index.php/Blocking_Brute_Force_Attacks
[6]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/Docker_Security_Cheat_Sheet.md#rule-7---limit-resources-memory-cpu-file-descriptors-processes-restarts
[7]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/REST_Assessment_Cheat_Sheet.md
[8]: https://cwe.mitre.org/data/definitions/307.html
[9]: https://cwe.mitre.org/data/definitions/770.html
[10]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204-draft.pdf
