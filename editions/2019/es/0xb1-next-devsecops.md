¿Qué sigue para DevSecOps?
=========================

Debido a su importancia en las arquitecturas de aplicaciones modernas,
desarrollar APIs seguras es fundamental. La seguridad no puede ser descuidada,
y debería ser parte de todo el ciclo de vida del desarrollo de software.
Hacer escaneos y pruebas de penetración anualmente ya no es suficiente.

DevSecOps debería unirse al esfuerzo de desarrollo, facilitando pruebas
continuas de seguridad a lo largo de todo el ciclo de vida del desarrollo de
software. Su meta es mejorar dicho proceso por medio de la automatización sin
sacrificar velocidad de desarrollo.

Ante la duda, manténgase informado y revise el [Manifiesto DevSecOps][1] con
frecuencia.

| | |
|-|-|
| **Comprender el Modelo de Amenazas** | Las pruebas con mayor prioridad provienen de un modelo de amenaza. Si no tiene uno, considere usar [OWASP Application Security Verification Standard (ASVS)][2] y la [Guía de pruebas de OWASP][3] como referencia. Involucrar al equipo de desarrollo puede ayudar a que éste sea más consciente de la seguridad. |
| **Comprender el SDLC** | Únase al equipo de desarrollo para entender mejor el ciclo de vida del desarrollo del software. Su contribución en las pruebas continuas de seguridad debe ser compatible con las personas, los procesos y las herramientas. Todos deberían estar de acuerdo con el proceso para que no haya fricciones o resistencia innecesaria. |
| **Estrategia de pruebas** | Debido a que su trabajo no debe afectar la velocidad de desarrollo, se debe elegir la mejor técnica (simple, rápida y precisa) para verificar los requisitos de seguridad. El [Marco de conocimientos de seguridad de OWASP][4] y el [Estándar de verificación de seguridad de aplicaciones de OWASP][5] pueden ser excelentes fuentes de requisitos funcionales y no funcionales de seguridad. También, existen otras fuentes para [proyectos][6] y [herramientas][7] similares a las que ofrece la [comunidad DevSecOps][8]. |
| **Lograr cobertura y precisión** | Usted es el puente entre los desarrolladores y los equipos de operaciones. Para lograr cobertura, no solo debe concentrarse en la funcionalidad, sino también en la orquestación. Desde el principio, trabaje cerca de los equipos de desarrollo y operaciones para que pueda optimizar su tiempo y esfuerzo. Su meta debe ser llegar a un estado en donde la seguridad esencial se verifique continuamente. |
| **Comunicar claramente los hallazgos** | Aporte valor con la menor fricción posible. Entregue los hallazgos de manera oportuna y dentro de las herramientas que utilizan los equipos de desarrollo (no archivos PDF). Únase al equipo de desarrollo para abordar los hallazgos. Aproveche la oportunidad para educarlos, describiendo claramente la debilidad y cómo se puede abusar de ella, de ser posible incluya un escenario de ataque real. |

[1]: https://www.devsecops.org/
[2]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[3]: https://www.owasp.org/index.php/OWASP_Testing_Project
[4]: https://www.owasp.org/index.php/OWASP_Security_Knowledge_Framework
[5]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[6]: http://devsecops.github.io/
[7]: https://github.com/devsecops/awesome-devsecops
[8]: http://devsecops.org
