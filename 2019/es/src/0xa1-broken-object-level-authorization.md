API1:2019 Autorización a Nivel de Objeto Rota
=============================================

| Amenazas/Vectores de ataque | Debilidades de seguridad | Impactos |
| - | - | - |
| Específico de la API : Explotabilidad **3** | Frecuencia **3** : Detectabilidad **2** | Técnico **3** : Específico del Negocio |
| Atacantes pueden explotar recursos de una API que son vulnerables a una autorización a nivel de objeto rota, al manipular el ID de un objeto que es enviado en una petición. Esto puede derivar en acceso no autorizado a datos sensibles. Este problema es extremadamente común en aplicaciones basadas en API ya que el componente del servidor usualmente no realiza un seguimiento completo del estado del cliente y, en cambio, hace más uso de parámetros como el ID de objeto, que es enviado desde el cliente, para decidir a qué objeto acceder. | Éste ha sido el ataque más común y de mayor impacto en APIs. Los mecanismos de autorización y control de acceso en aplicaciones modernas son complejos y extendidos. Incluso si la aplicación implementa una correcta infraestructura para controles de autorizacion, los desarrolladores podrían olvidarse de usar esos controles antes de permitir el acceso a un objeto sensible. La detección del control de acceso usualmente no es amigable con los tests automáticos o estáticos. | El acceso no autorizado puede resultar en revelación de información a partes no autorizadas, pérdida de datos o manipulación de los mismos. El acceso no autorizado a objetos también puede derivar en la apropiación completa de cuentas. |


## ¿Es vulnerable la API?

La autorización a nivel de objeto es un mecanismo de control de acceso que usualmente
es implementado a nivel de código para validar que un usuario puede acceder sólo a los objetos
a los que debería acceder.

Todo recurso de API que recibe un ID de objeto, y realiza cualquier tipo de
acción en el objeto, debe implementar controles de autorización a nivel de objeto.
Los controles deben validar que el usuario que ha iniciado sesión tiene acceso a realizar
la acción requerida en el objeto indicado.

Las fallas en estos mecanismos típicamente resultan en revelación de información no autorizada,
modificación o destrucción de todos los datos.


## Escenarios de Ataque de Ejemplo

### Escenario #1

Una plataforma de e-commerce para tiendas online (shops) provee una página con una
lista de gráficos de ganancia de sus tiendas alojadas. Inspeccionando las peticiones del navegador,
un atacante puede identificar los recursos de API que son usados como fuente de datos para esos gráficos
y sus patrones `/shops/{shopName}/revenue_data.json`. Usando otro recurso API,
el atacante puede obtener la lista de nombres de todas las tiendas alojadas. Con un script
simple para manipular los nombres en la lista, reemplazando `{shopName}` en la URL,
el atacante puede ganar acceso a la información de ventas de miles de tiendas e-commerce.


### Escenario #2

Monitoreando el tráfico de red de un dispositivo wearable, la siguiente petición
HTTP `PATCH` gana la atención de un atacante debido a la presencia de un encabezado
HTTP personalizado `X-User-Id: 54796`. Reemplazando el valor de `X-User-Id` con `54795`,
el atacante recibe una respuesta HTTP exitosa y es posible modificar datos de
cuentas de otros usuarios.


## Cómo prevenir

* Implementar mecanismos de autorización apropiados que se basen en las políticas
  del usuario y su jerarquía.
* Utilizar un mecanismo de autorización para controlar si el usuario que ha iniciado sesión
  tiene acceso para realizar la acción solicitada en el registro, en toda función que usa un
  dato ingresado por el cliente para acceder a un registro de la base de datos.
* Es preferible usar valores aleatorios e impredecibles como GUIDs para los IDs de los registros.
* Escriba tests para evaluar los mecanismos de autorización. No despliegue cambios vulnerables que rompan los tests.


## Referencias

### Externas

* [CWE-284: Improper Access Control][1]
* [CWE-285: Improper Authorization][2]
* [CWE-639: Authorization Bypass Through User-Controlled Key][3]

[1]: https://cwe.mitre.org/data/definitions/284.html
[2]: https://cwe.mitre.org/data/definitions/285.html
[3]: https://cwe.mitre.org/data/definitions/639.html
