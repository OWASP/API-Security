¿Qué sigue para los desarrolladores?
==========================

La tarea de crear y mantener software seguro, o reparar el software actual,
puede ser difícil. Las APIs no son diferentes.

Creemos que la educación y la conciencia son factores clave para desarrollar
software seguro. Todo lo demás que es requerido para lograr el objetivo
depende de **establecer y usar procesos de seguridad repetibles y controles
estándares de seguridad**.

OWASP tiene numerosos recursos gratuitos y abiertos para abordar el tema de la
seguridad desde que inicia un proyecto. Visite la
[página de proyectos de OWASP][1] para obtener una lista completa de los
proyectos disponibles.

| | |
|-|-|
| **Educación** | Puede comenzar a leer [Materiales del proyecto educativo de OWASP][2] de acuerdo con su profesión e interés. Para el aprendizaje práctico, agregamos **crAPI** - **API** **C**ompletamente **R**ídicula en [nuestro plan de trabajo][3]. Mientras tanto, puede practicar WebAppSec utilizando el [Módulo OWASP DevSlop Pixi][4], un servicio vulnerable de WebApp y API con el fin de enseñar a los usuarios cómo probar aplicaciones web modernas y APIs para identificar problemas de seguridad y para aprender a desarrollar APIs más seguras. También puede asistir a las sesiones de capacitación [Conferencia de AppSec de OWASP][5] o [unirse al capítulo local][6]. |
| **Requisitos de seguridad** | La seguridad debe ser parte de cada proyecto desde el principio. Al obtener los requerimientos, es importante definir qué significa "seguro" para ese proyecto en particular. OWASP recomienda utilizar el [Estándar de verificación de seguridad de aplicaciones (ASVS) de OWASP][7] como guía para definir los requerimientos de seguridad. Si usted está subcontratando, considere el [Anexo del contrato de software seguro de OWASP][8], el cual debería ser adaptado a las leyes y regulaciones locales. |
| **Arquitectura de seguridad** | La seguridad debe de tomarse en cuenta durante todas las etapas del proyecto. Las [Hojas de trucos de prevención de OWASP][9] son un buen punto de partida para obtener orientación sobre cómo diseñar la seguridad durante la fase de arquitectura. Entre muchas otras, usted encontrará la [Hoja de referencia de seguridad REST][10] y la [Hoja de referencia de evaluación REST][11]. |
| **Controles estándares de seguridad** | La adopción de controles estándares de seguridad reduce el riesgo de introducir debilidades de seguridad al escribir su propia lógica. A pesar del hecho de que muchos frameworks modernos ahora vienen con controles estándares incorporados de una manera efectiva, [Controles proactivos OWASP][12] le brinda una buena visión general de los controles de seguridad que debería incluir en su proyecto. OWASP también proporciona algunas librerías y herramientas que le pueden servir, como la de controles de validación. |
| **Ciclo de vida del desarrollo sguro de software** | Puede usar el [Modelo de madurez de garantía de software de OWASP (SAMM)][13] para mejorar el proceso al momento de crear APIs. Además, otros proyectos de OWASP están disponibles para ayudarle durante las diferentes fases de desarrollo de APIs, por ejemplo, el [Proyecto de revisión de código de OWASP][14]. |

[1]: https://www.owasp.org/index.php/Category:OWASP_Project
[2]: https://www.owasp.org/index.php/OWASP_Education_Material_Categorized
[3]: https://www.owasp.org/index.php/OWASP_API_Security_Project#tab=Road_Map
[4]: https://devslop.co/Home/Pixi
[5]: https://www.owasp.org/index.php/Category:OWASP_AppSec_Conference
[6]: https://www.owasp.org/index.php/OWASP_Chapter
[7]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[8]: https://www.owasp.org/index.php/OWASP_Secure_Software_Contract_Annex
[9]: https://www.owasp.org/index.php/OWASP_Cheat_Sheet_Series
[10]: https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/REST_Security_Cheat_Sheet.md
[11]: https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/REST_Assessment_Cheat_Sheet.md
[12]: https://www.owasp.org/index.php/OWASP_Proactive_Controls#tab=OWASP_Proactive_Controls_2018
[13]: https://www.owasp.org/index.php/OWASP_SAMM_Project
[14]: https://www.owasp.org/index.php/Category:OWASP_Code_Review_Project
