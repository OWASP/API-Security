Дальнейшие шаги для разработчиков
==========================

The task to create and maintain secure software, or fixing existing sofware, can be
difficult. APIs are no different.
Задача создать и поддерживать ПО в безопасном состоянии, или исправить уже существующее ПО может быть сложной, как и API.

We believe that education and awareness are key factors to write secure
software. Everything else required to accomplish the goal, depends on
**establishing and using repeatable security processes and standard security
controls**.
Мы уверены, что обучение и осведомленность являются ключевыми факторами написания безопасного ПО. Все остальное, необходимое для достижения этой цели, зависит от **налаженного и повторяемого процесса безопасности и стандартных мер защиты**.

OWASP has numerous free and open resources to address security since the very
beginning of the project. Please visit the [OWASP Projects page][1] for a
comprehensive list of available projects.
OWASP включает большое количество бесплатных открытых ресурсов по безопасности с самого начала проекта. Пожалуйста ознакомьтесь со [страницей OWASP Projects][1], чтобы получить полный список доступных проектов.

| | |
|-|-|
| **Обучение** | You can start reading [OWASP Education Project materials][2] according to your profession and interest. For hands-on learning, we added **crAPI** - **C**ompletely **R**idiculous **API** on [our roadmap][3]. Meanwhile, you can practice WebAppSec using the [OWASP DevSlop Pixi Module][4], a vulnerable WebApp and API service intent to teach users how to test modern web applications and API's for security issues, and how to write more secure API's in the future. You can also attend [OWASP AppSec Conference][5] training sessions, or [join your local chapter][6]. 
Вы можете начать изучать [метариалы OWASP Education Project][2], в соответствии со своей профессией и интересами. Для получения практических знаний мы добавили **crAPI** - **C**ompletely **R**idiculous **API** в [наш план развития][3]. Тем временем вы можете поправтиковаться в безопасности без приложений, используя [OWASP DevSlop Pixi Module][4] - уязвимое веб приложение и API сервис, направленный на обучение пользователей тестированию современных веб приложений и API на предмет ошибок безопасносьи и написанию более безопасных API в будущем. Вы также можете принять участие в практических сессиях [конференции OWASP AppSec][5] или [присоединиться в вашему локальному отделению OWASP][6]. 
|
| **Требования по безопасности** | Security should be part of every project from the beginning. When doing requirements elicitation, it is important to define what "secure" means for that project. OWASP recommends you use the [OWASP Application Security Verification Standard (ASVS)][7] as a guide for setting the security requirements. If you're outsourcing, consider the [OWASP Secure Software Contract Annex][8], which should be adapted according to local law and regulations. 
Безопасность должна быть частью любого проекта с самого начала. На этапе сбора требований необходимо определить роль безопасности в проекте. OWASP рекомендует использовать [OWASP Application Security Verification Standard (ASVS)][7] в качестве руководства по постановке требований по безопасности. Если вы пользуетесь услугами внешних разработчиков, рассмотрите проект [OWASP Secure Software Contract Annex][8] и адаптируйте его в соответствии с локальными законами и нормативными требованиями.
|
| **Безопасная архитектура** | Security should remain a concern during all the project stages. The [OWASP Prevention Cheat Sheets][9] are a good starting point for guidance on how to design security in during the architecture phase. Among many others, you'll find the [REST Security Cheat Sheet][10] and the [REST Assessment Cheat Sheet][11]. 
Безопасность должна получить должное внимание на всех этапах проекта. [OWASP Prevention Cheat Sheets][9] - хорошая отправная точка по проектированию механизмов безопасности на этапе архитектуры приложения. Среди прочих вы можете ознакомиться с [REST Security Cheat Sheet][10] и [REST Assessment Cheat Sheet][11]. 
|
| **Стандартные меры безопасности** | Adopting Standard Security Controls reduces the risk of introducing security weaknesses while writing your own logic. Despite the fact that many modern frameworks now come with built-in standard effective controls, [OWASP Proactive Controls][12] gives you a good overview of what security controls you should look to include in your project. OWASP also provides some libraries and tools you may find valuable, such as validation controls. 
Внедрение стандартных мер безопасности снижает риск ошибок, связанных с безопасностью, в ходе написания логиик приложений. Не смотря на то что многие современные фреимворки включают в себя стандартные серы безопасности, [OWASP Proactive Controls][12] предоставляет хороший обзор мер безопасности, которые стоит включить с ваш проект. OWASP также предоставляет библиотеки и инструменты, которые могут вам пригодиться, например, механизмы валидации.
|
| **Жизненный цикл разработки безопасного ПО** | You can use the [OWASP Software Assurance Maturity Model (SAMM)][13] to improve the process when building APIs. Several other OWASP projects are available to help you during the different API development phases e.g., the [OWASP Code Review Project][14]. 
Вы можете использовать [OWASP Software Assurance Maturity Model (SAMM)][13] для улучшения процессов создания API. Несколько других проектов OWASP могут помочь вам на различных этапах разработки API, например, [OWASP Code Review Project][14]. 
|

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
