API2:2019 Autenticación de Usuario Rota
=======================================

| Amenazas/Vectores de ataque | Debilidades de seguridad | Impactos |
| - | - | - |
| Específico de la API : Explotabilidad **3** | Frecuencia **2** : Detectabilidad **2** | Técnico **3** : Específico del Negocio |
| La autenticación en APIs es un mecanismo complejo y confuso. Ingenieros de software y seguridad pueden tener ideas equivocadas sobre cuáles son los límites de autenticación y cómo implementarla correctamente. Agregado a esto, el mecanismo de autenticación es un objetivo fácil para los atacantes, ya que está expuesto a todo el mundo. Estos dos puntos hacen al componente de autenticación potencialmente vulnerable a muchos exploits. | Existen 2 subproblemas: 1. Falta de mecanismos de protección: Los recursos de APIs que son responsables de la autenticación deben ser tratados de forma diferente a los recursos regulares e implementar capas extra de protección 2. Implementación incorrecta del mecanismo: El mecanismo es usado / implementado sin considerar los vercores de ataque, o es el caso de uso equivocado (p.e., un mecanismo de autenticación diseñado para clientes IoT puede no ser la elección correcta para aplicaciones web). | Atacantes pueden obtener control a cuentas de otros usuarios en el sistema, leer sus datos personales y realizar acciones sensibles en su nombre, como transacciones monetarias y enviar mensajes personales. |

## ¿Es vulnerable la API?

Los recursos y flujos de autenticación son activos que deben ser protegidos. "Olvidé mi contraseña / recuperar contraseña" debe ser tratado de la misma forma que los mecanismos de autenticación.

Una API es vulnerable si:
* Permite el [relleno de credenciales][1] donde el atacante tiene una lista de usuarios y contraseñas válidos.
* Permite a los atacantes realizar ataques de fuerza bruta sobre la misma cuenta de usuario, sin presentar mecanismos de bloqueo de captcha/cuenta.
* Permite contraseñas débiles.
* Envía detalles de autenticación sensibles, como tokens de authenticación y contraseñas en la URL.
* No valida la autenticidad de los tokens.
* Acepta tokens JWT no/débilmente firmados (`"alg":"none"`)/no valida su fecha de expiración.
* Usa contraseñas en texto plano, encriptadas o codificadas con algoritmos de hash débiles.
* Usa claves de encriptación débiles.

## Escenarios de Ataque de Ejemplo

## Escenario #1

[Relleno de credenciales][1] (usando [listas de usuarios/contraseñas conocidas][2]), es un ataque común. 
Si una aplicación no implementa protecciones de ataque automático o de relleno de credenciales, 
la aplicación puede ser usada como un oráculo de contraseñas (probador) para determinar si las credenciales son válidas.

## Escenario #2

Un atacante comienza el flujo de recuperación de contraseña realizando una petición POST a `/api/system/verification-codes`
e incluyendo el nombre de usuario en el cuerpo de la petición. 
A continuación un token SMS con 6 dígitos es enviado al teléfono de la víctima. 
Como la API no implementa una política de límite de peticiones, el atacante puede probar todas las combinaciones posibles usando 
un script multi-hilo contra el recurso `/api/system/verification-codes/{smsToken}` para descubrir el token correcto en unos minutos.

## Cómo prevenir

* Asegurarse que conoce todos los flujos de autenticación posibles a la API (móviles/
  web/links profundos que implementan autenticación en 1 click/etc.)
* Pregúntele a sus ingenieros que flujos ha olvidado.
* Lea acerca de sus mecanismos de autenticación. Asegúrese que entiende qué y cómo son usados. 
  OAuth no es autenticación, tampoco lo son las claves de API.
* No invente la rueda en autenticación, generación de tokens, almacenamiento de contraseñas. Use los estándars.
* Los recursos de recuperación de credenciales/olvio de contraseñas deben ser tratados como recursos de 
  inicio de sesión en términos de protecciones de fuerza bruta, límite de peticiones y de bloqueo.
* Use la [Guía OWASP de Autenticación][3].
* Cuando sea posible, implemente autenticación multi factor.
* Implemente mecanismos anti fuerza bruta para mitigar el relleno de credenciales, ataques de diccionario y 
  ataques de fuerza bruta en sus recursos de autenticación.
  Este mecanismo debe ser más estricto que los mecanismos de límite de peticiones regulares de su API.
* Implemente mecanismos de [bloqueo de cuenta][4] / captcha para prevenir fuerza bruta contra usuarios específicos. 
  Implemente controles de contraseñas débiles.
* Las claves de API no deberían ser usadas para autenticar usuarios, sino para [aplicaciones cliente/autenticación de proyecto][5].

## Referencias

### OWASP

* [Guía OWASP de Administración de Claves][6]
* [Guía OWASP de Autenticación][3]
* [Relleno de Credenciales][1]

### Externas

* [CWE-798: Use of Hard-coded Credentials][7]

[1]: https://www.owasp.org/index.php/Credential_stuffing
[2]: https://github.com/danielmiessler/SecLists
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[4]: https://www.owasp.org/index.php/Testing_for_Weak_lock_out_mechanism_(OTG-AUTHN-003)
[5]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[6]: https://www.owasp.org/index.php/Key_Management_Cheat_Sheet
[7]: https://cwe.mitre.org/data/definitions/798.html
