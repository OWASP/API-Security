# API1:2023 Autorización de Nivel de Objeto Rota

| Agentes de Amenaza/Vectores de Ataque | Debilidad de Seguridad | Impactos |
| - | - | - |
| Específico de APIs : Explotabilidad **Fácil** | Prevalencia **Generalizada** : Detectabilidad **Fácil** | Técnico **Moderado** : Específico del Negocio |
| Los atacantes pueden explotar endpoints de API vulnerables a autorización de nivel de objeto rota manipulando el ID de un objeto enviado dentro de la solicitud. Los IDs de objeto pueden ser cualquier cosa, desde enteros secuenciales, UUIDs o cadenas de texto genéricas. Independientemente del tipo de dato, son fáciles de identificar en el destino de la solicitud (parámetros de ruta o cadena de consulta), en los encabezados de la solicitud o incluso como parte del cuerpo de la solicitud. | Este problema es extremadamente común en aplicaciones basadas en API porque el componente del servidor generalmente no rastrea completamente el estado del cliente y, en su lugar, depende de parámetros como IDs de objeto enviados desde el cliente para decidir qué objetos se pueden acceder. La respuesta del servidor suele ser suficiente para determinar si la solicitud fue exitosa. | El acceso no autorizado a los objetos de otros usuarios puede resultar en la divulgación de datos a partes no autorizadas, pérdida de datos o manipulación de datos. En ciertas circunstancias, el acceso no autorizado a objetos también puede llevar al secuestro completo de cuentas. |

## ¿Es la API Vulnerable?

La autorización a nivel de objeto es un mecanismo de control de acceso que generalmente se implementa a nivel de código para validar que un usuario solo pueda acceder a los objetos sobre los cuales tiene permisos.

Cada endpoint de API que recibe un ID de objeto y realiza cualquier acción sobre él debe implementar verificaciones de autorización a nivel de objeto. Estas verificaciones deben validar que el usuario autenticado tiene permisos para realizar la acción solicitada sobre el objeto en cuestión.

Las fallas en este mecanismo suelen llevar a la divulgación no autorizada de información, modificación o destrucción de datos.

Comparar el ID de usuario de la sesión actual (por ejemplo, extrayéndolo de un token JWT) con el parámetro de ID vulnerable no es una solución suficiente para resolver la **Autorización de Nivel de Objeto Rota (BOLA)**. Este enfoque solo abordaría un subconjunto limitado de casos.

En el caso de BOLA, es normal que el usuario tenga acceso al endpoint/función vulnerable de la API. La violación ocurre a nivel de objeto, al manipular el ID. Si un atacante logra acceder a un endpoint/función de API al que no debería tener acceso, se trata más bien de un caso de [Autorización de Nivel de Función Rota][5] (BFLA) en lugar de BOLA.

## Escenarios de Ataque Ejemplo

### Escenario #1

Una plataforma de comercio electrónico para tiendas en línea proporciona una página con gráficos de ingresos de las tiendas alojadas. Inspeccionando las solicitudes del navegador, un atacante puede identificar los endpoints de API utilizados como fuente de datos para esos gráficos y su patrón:  
`/shops/{shopName}/revenue_data.json`.  

Usando otro endpoint de API, el atacante puede obtener la lista de todas las tiendas alojadas. Con un simple script para manipular los nombres en la lista, reemplazando `{shopName}` en la URL, el atacante obtiene acceso a los datos de ventas de miles de tiendas en línea.

### Escenario #2

Un fabricante de automóviles ha habilitado el control remoto de sus vehículos a través de una API móvil para la comunicación con el teléfono del conductor. La API permite al conductor encender y apagar el motor, así como bloquear y desbloquear las puertas de forma remota.  

Como parte de este flujo, el usuario envía el **Número de Identificación del Vehículo (VIN)** a la API.  
La API no valida si el VIN representa un vehículo perteneciente al usuario autenticado, lo que conduce a una vulnerabilidad BOLA.  
Un atacante puede acceder a vehículos que no le pertenecen.

### Escenario #3

Un servicio de almacenamiento de documentos en línea permite a los usuarios ver, editar, almacenar y eliminar sus documentos. Cuando un usuario elimina un documento, se envía una mutación de GraphQL con el ID del documento a la API:

```
POST /graphql
{
  "operationName":"deleteReports",
  "variables":{
    "reportKeys":["<DOCUMENT_ID>"]
  },
  "query":"mutation deleteReports($siteId: ID!, $reportKeys: [String]!) {
    {
      deleteReports(reportKeys: $reportKeys)
    }
  }"
}
```


Dado que el documento con el ID proporcionado se elimina sin verificaciones adicionales de permisos, un usuario puede eliminar los documentos de otro usuario.

## Cómo Prevenirlo

* Implementa un mecanismo de autorización adecuado que se base en las políticas y jerarquía de usuarios.
* Usa el mecanismo de autorización para verificar si el usuario autenticado tiene permisos para realizar la acción solicitada en el registro, en cada función que utilice un dato de entrada del cliente para acceder a un registro en la base de datos.
* Prefiere el uso de valores aleatorios e impredecibles, como GUIDs, para los IDs de los registros.
* Escribe pruebas para evaluar la vulnerabilidad del mecanismo de autorización. No implementes cambios que hagan que estas pruebas fallen.

**Nota**

* Usar GUID/UUID en lugar de identificadores predecibles ayuda a mitigar los ataques de enumeración de objetos. Sin embargo, una vez que un identificador válido se divulga —ya sea a través de otro endpoint, exposición excesiva de datos, registros (logs) u otra vulnerabilidad—, debe tratarse como información pública.

* Las decisiones de autorización nunca deben basarse en el secreto o la impredecibilidad de los identificadores de objeto. Cada solicitud debe verificar de forma independiente que el usuario autenticado está autorizado para acceder al objeto solicitado.

## Referencias

### OWASP

* [Guía de Autorización][1]
* [Guía de Automatización de Pruebas de Autorización][2]

### Externas

* [CWE-285: Autorización Incorrecta][3]
* [CWE-639: Evasión de Autorización a través de Claves Controladas por el Usuario][4]

[1]: https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html
[2]: https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Testing_Automation_Cheat_Sheet.html
[3]: https://cwe.mitre.org/data/definitions/285.html
[4]: https://cwe.mitre.org/data/definitions/639.html
[5]: ./0xa5-broken-function-level-authorization.md

