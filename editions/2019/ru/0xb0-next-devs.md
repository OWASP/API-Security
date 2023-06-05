# Дальнейшие шаги для разработчиков

Задача по созданию и поддержке ПО в безопасном состоянии, или исправлению уже существующего ПО может быть сложной. То же верно и для API.

Мы уверены, что обучение и осведомленность являются ключевыми факторами написания безопасного ПО. Все остальное, необходимое для достижения этой цели, зависит от **налаженного и повторяемого процесса безопасности и стандартных мер защиты**.

OWASP включает большое количество бесплатных открытых ресурсов по безопасности с самого начала проекта. Пожалуйста ознакомьтесь со [страницей OWASP Projects][1], чтобы получить полный список доступных проектов.

| | |
|-|-|
| **Обучение** | Вы можете начать изучать [материалы OWASP Education Project][2], в соответствии со своей профессией и интересами. Для получения практических знаний мы добавили **crAPI** - **C**ompletely **R**idiculous **API** в [наш план развития][3]. Тем временем вы можете попрактиковаться в безопасности веб приложений, используя [OWASP DevSlop Pixi Module][4] - уязвимое веб приложение с API сервисом, направленное на обучение пользователей тестированию современных веб приложений и API на предмет ошибок безопасности и написанию более безопасных API в будущем. Вы также можете принять участие в практических сессиях [конференции OWASP AppSec][5] или [присоединиться в вашему локальному отделению OWASP][6]. |
| **Требования по безопасности** | Безопасность должна быть частью любого проекта с самого начала. На этапе сбора требований необходимо определить роль безопасности в проекте. OWASP рекомендует использовать [OWASP Application Security Verification Standard (ASVS)][7] в качестве руководства по постановке требований безопасности. Если вы пользуетесь услугами внешних разработчиков, рассмотрите проект [OWASP Secure Software Contract Annex][8] и адаптируйте его в соответствии с локальными законами и нормативными требованиями. |
| **Безопасная архитектура** | Безопасность должна получить должное внимание на всех этапах проекта. [OWASP Prevention Cheat Sheets][9] - хорошая отправная точка по проектированию механизмов безопасности на этапе архитектуры приложения. Среди прочего вы можете ознакомиться с [REST Security Cheat Sheet][10] и [REST Assessment Cheat Sheet][11]. |
| **Стандартные меры безопасности** | Внедрение стандартных мер безопасности снижает риск ошибок, связанных с безопасностью, в ходе написания логики приложения. Несмотря на то, что многие современные фреймворки включают в себя стандартные меры безопасности, [OWASP Proactive Controls][12] предоставляет хороший обзор мер безопасности, которые стоит включить в ваш проект. OWASP также предоставляет библиотеки и инструменты, которые могут вам пригодиться, например, механизмы валидации. |
| **Жизненный цикл разработки безопасного ПО** | Вы можете использовать [OWASP Software Assurance Maturity Model (SAMM)][13] для улучшения процессов создания API. Несколько других проектов OWASP могут помочь вам на различных этапах разработки API, например, [OWASP Code Review Project][14]. |

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
