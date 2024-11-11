API10:2019 Registro y Monitoreo Insuficiente
============================================

|Agente/Vector de Ataque | Debilidades de Seguridad | Impacto |
| - | - | - |
| API Específica : Explotabilidad **2** | Prevalencia **3** : Detectabilidad **1** | Técnico **2** : Negocio |
| Los atacantes se pueden aprovechar de la falta de registro y monitoreo para abusar sistemas sin ser detectados. | Sin registro y monitoreo, o sin suficiente registro y monitoreo, es casi imposible detectar actividades sospechosas y responder a ellas a tiempo. | Sin la visibilidad sobre constantes actividades maliciosas, los atacantes tienen tiempo suficiente para comprometer sistemas.|

## ¿Es vulnerable la API?

La API es vulnerable si:

* No produce ningún tipo de registro, el nivel del registro no es el correcto, o
 los mensajes de registro no incluyen detalles suficientes.
* La integridad del registro no está garantizada
(e.g., [Inyección de Registro][1]).
* Los registros no son continuamente monitoreados.
* La infraestructura de la API no es continuamente monitoreada.

## Ejemplos de escenarios de ataque

### Escenario #1
Las llaves de acceso de una API administrativa fueron comprometidas en un
repositorio público. El dueño del repositorio fue notificado vía correo
electrónico sobre la posible fuga, pero tomó más de 48 horas para actuar de
acuerdo al incidente y dicha fuga pudo haber causado acceso a datos sensibles.
Debido a la falta de registros, la compañía no es capaz de verificar qué datos
fueron accedidos por los atacantes.

### Escenario #2
Una plataforma para compartir vídeos fue afectada a “gran escala” por un ataque
de relleno automático de credenciales. A pesar de que intentos fallidos de
inicio de sesión se estaban registrando, ninguna alerta se activó durante el
periodo del ataque. Como reacción a las quejas de los usuarios, los registros
de la API fueron analizados y el ataque fue detectado. La compañía tuvo que
realizar un anuncio público pidiendo a los usuarios que restablezcan sus
contraseñas y reportó el incidente a las autoridades regulatorias.  

## Cómo Prevenir
* Registrar todos los fallos de intentos de autenticación, acceso denegado y
errores de validación de entrada.
* Los registros deben de ser escritos usando un formato adecuado para el consumo
de una solución de gestión de registros y debe incluir detalle suficiente para
identificar al actor malicioso.
* Los registros deben de manejarse como datos sensibles y su integridad debe de
ser garantizada durante reposo y tránsito.
* Configurar un sistema de monitoreo para continuamente monitorear la
infraestructura, red y la API funcionando.
* Usar un sistema de gestión de información y eventos de seguridad (SIEM) para
agregar y administrar registros de todos los componentes de la pila API y los
hosts.
* Configurar paneles personalizados y alertas, permitiendo que actividades
sospechosas sean detectadas y respondidas más temprano.


## Referencias

### OWASP

* [OWASP Logging Cheat Sheet][2]
* [OWASP Proactive Controls: Implement Logging and Intrusion Detection][3]
* [OWASP Application Security Verification Standard: V7: Error Handling and Logging Verification Requirements][4]

### Externos

* [CWE-223: Omission of Security-relevant Information][5]
* [CWE-778: Insufficient Logging][6]

[1]: https://www.owasp.org/index.php/Log_Injection
[2]: https://www.owasp.org/index.php/Logging_Cheat_Sheet
[3]: https://www.owasp.org/index.php/OWASP_Proactive_Controls
[4]: https://github.com/OWASP/ASVS/blob/master/4.0/en/0x15-V7-Error-Logging.md
[5]: https://cwe.mitre.org/data/definitions/223.html
[6]: https://cwe.mitre.org/data/definitions/778.html
