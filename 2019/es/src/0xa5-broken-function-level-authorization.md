API5:2019 Autorización a nivel de función rota
==============================================

| Amenazas/Vectores de ataque | Debilidades de seguridad | Impactos |
| - | - | - |
| Específico de la API : Explotabilidad **3** | Frecuencia **2** : Detectabilidad **1** | Técnico **2** : Específico del Negocio |
| La explotación requiere que el atacante envíe solicitudes API legítimas un recurso API al que no debería tener acceso. Esos recursos 
pueden quedar expuestos a usuarios anónimos o usuarios regulares sin privilegios. Es más facil descubrir esas falencias en APIs, ya que
las APIs son más estructuradas, y la forma de acceder a ciertas funciones es más predecible (p.e. reemplazando el método HTTP 
de GET a PUT, o cambiando la cadena "users" en la URL a "admins"). | Los controles de autorización para una función o recurso son
usualmente administrados vía la configuración, y a veces a nivel de código. Implementando controles propicios puede ser una tarea confusa,
ya que aplicaciones modernas pueden contener muchos tipos de roles o grupos y jerarquías de usuario complejas(p.e. sub-usuarios,
usuarios con más de un rol). | Estas falencias permiten a los atacantes acceder a funcionalidad no autorizada. Las 
funciones Administrativas son objetivos clave para este tipo de ataque. |

## ¿Es vulnerable la API?

La mejor manera de encontrar problemas de autorización a nivel de función rota 
es realizar un análisis profundo del mecanismo de autorización, teniendo en
cuenta la jerarquía de usuarios, los diferentes roles o grupos en la aplicación
y realizando las siguientes preguntas:

* ¿Puede un usuario regular acceder a recursos administrativos?
* ¿Puede un usuario realizar acciones sensibles (p.e. creación, modificación, 
  o borrado) a las que no debería tener acceso, simplemente cambiando el 
  método HTTP (p.e. de `GET` a `DELETE`)?
* ¿Puede un usuario del grupo X acceder a una función que debería estar expuesta
  sólo a usuarios del grupo Y, simplemente adivinando la URL del recurso y sus 
  parámetros (p.e. `/api/v1/users/export_all`)?

No asuma que un recurso API es regular o administrativo sólo basándose en la 
ruta de la URL.

Mientras los desarrolladores pueden elegir exponer la mayoría de los recursos 
administrativos dentro de una ruta específica, como `api/admins`, is muy común
encontrar esos recursos administrativos dentro de otras rutas relativas junto
con recursos regulares, como `api/users`.

## Escenarios de Ataque de Ejemplo

### Escenario #1

Durante el proceso de registración a una aplicación que permite sólo usuarios 
invitados a unirse, la aplicación móvil dispara una solicitud API a
`GET /api/invites/{invite_guid}`. La respuesta contiene un JSON con detalles
sobre la invitación, incluyendo el rol del usuario y su email.

Un atacante duplica la solicitud y manipula el método HTTP y el recurso a 
`POST /api/invites/new`. Este recurso sólo debería ser accedido por
administradores usando la consola de administración, que no implementa 
controles de autorización a nivel de función.

El atacante explota el error y se envía una invitación a si mismo para crear
una cuenta de administrador:

```
POST /api/invites/new

{“email”:”hugo@malicious.com”,”role”:”admin”}
```

### Escenario #2

Una API contiene un recurso que debería estar expuesto sólo a administradores -
`GET /api/admin/v1/users/all`. Este recurso devuelve los detalles de todos los
usuarios de la aplicación y no implementa controles de autorización a nivel de
función. Un atacante que se aprendió la estructura de la API realiza una 
suposición educada y se las arregla para acceder a este recurso, que expone 
datos sensibles de los usuarios de la aplicación.

## Cómo Prevenir

Su aplicación debería tener una forma consistente y fácil de analizar el módulo
de autorización que es invocado desde todas sus funciones de negocios. 
Frecuentemente, dicha protección es proveída por uno o más componentes externos
al código de la aplicación.

* Los mecanismos de protección deberían denegar todo acceso por defecto, 
  requiriendo autorizaciones explícitas para roles específicos en todas las
  funciones.
* Revise sus recursos API contra fallas de autorización a nivel de función,
  teniendo en cuenta la lógica de negocios de la aplicación y la jerarquía de 
  grupos.
* Asegúrese que todos sus controladores administrativos heredan de un 
  controlador administrativo abstracto que implementa controles de autorización
  basados en el grupo/rol del usuario.
* Asegúrese que las funciones administrativas dentro de controladores regulares
  implementan controles de autorización basados en el grupo y rol del usuario.

## Referencias

### OWASP

* [OWASP Article on Forced Browsing][1]
* [OWASP Top 10 2013-A7-Missing Function Level Access Control][2]
* [OWASP Development Guide: Chapter on Authorization][3]

### External

* [CWE-285: Improper Authorization][4]

[1]: https://www.owasp.org/index.php/Forced_browsing
[2]: https://www.owasp.org/index.php/Top_10_2013-A7-Missing_Function_Level_Access_Control
[3]: https://www.owasp.org/index.php/Category:Access_Control
[4]: https://cwe.mitre.org/data/definitions/285.html
