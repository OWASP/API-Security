Дальнейшие шаги для DevSecOps
=========================

Due to their importance in modern application architectures, building secure
APIs is crucial. Security cannot be neglected, and it should be part of the
whole development life cycle. Scanning and penetration testing yearly are no
longer enough.
Создание безопасных API критически важно из-за их роли в архитектуре современных приложений. Безопасностью нельзя пренебрегать, она должна быть частью всего жизненного цикла разработки. Уже недостаточно проводить сканирование и тестирование на проникновение раз в год.

DevSecOps should join the development effort, facilitating continuous security
testing across the entire software development life cycle. Their goal is to
enhance the development pipeline with security automation, and without impacting
the speed of development.

In case of doubt, stay informed, and review, the [DevSecOps Manifesto][1] often.

DevSecOps должны присоединиться к работе по разработке и обеспечить непрерывное тестирование безопасности на всем жизненном цикле разработки ПО. Их цель - усовершенствовать процесс разработки, автоматизировав проверки безопасности, не влияя на скорость разработки.

| | |
|-|-|
| **Понимание модели угроз** | Testing priorities come from a threat model. If you don't have one, consider using [OWASP Application Security Verification Standard (ASVS)][2], and the [OWASP Testing Guide][3] as an input. Involving the development team may help to make them more security-aware. 
Приоритеты при тестировании исходят из модели угроз. Если у вас ее нет, рассмотрите использование [OWASP Application Security Verification Standard (ASVS)][2] и [OWASP Testing Guide][3] для начала ее составления. Включение команды разработки может помочь им быть более осведомленными в сфере безопасности.
|
| **Понимание жизненного цикла разработки ПО** | Join the development team to better understand the Software Development Life Cycle. Your contribution on continuous security testing should be compatible with people, processes, and tools. Everyone should agree with the process, so that there's no unnecessary friction or resistance. 
Объединитесь с командой разработки для лучшего понимания жизненного цикла разработки ПО. Ваше содействие в части непрерывного тестирования безопасности должно гармонировать с людьми, процессами и инструментами. Все должны быть согласны с процессом для предотвращения ненужных разногласий и сопротивления.
|
| **Стратегии тестирования** | As your work should not impact the development speed, you should wisely choose the best (simple, fastest, most accurate) technique to verify the security requirements. The [OWASP Security Knowledge Framework][4] and [OWASP Application Security Verification Standard][5] can be great sources of functional and nonfunctional security requirements. There are other great sources for [projects][6] and [tools][7] similar to the one offered by the [DevSecOps community][8]. 
Поскольку ваша работа не должна влиять на скорость разработки, вам необходимо продуманно выбрать наилучшие (простые, быстрые и наиболее точные) подходы к проверке требований по безопасности. [OWASP Security Knowledge Framework][4] и [OWASP Application Security Verification Standard][5] - отличные источники функциональных и нефункциональных требований по безопасности. Существуют также другие отличные [проекты][6] и [инструменты][7], аналогичные предлагаемым [сообществом DevSecOps][8]. 
|
| **Достижение покрытия и точности** | You're the bridge between developers and operations teams. To achieve coverage, not only should you focus on the functionality, but also the orchestration. Work close to both development and operations teams from the beginning so you can optimize your time and effort. You should aim for a state where the essential security is verified continuously. 
Вы соединяете команды разработки и эксплуатации. Чтобы достичь покрытия нужно сфокусироваться не только на функциональности, но и на оркестрации. Работайте совместно с командами разработки и эксплуатации с самого начала, чтобы оптимизировать свои трудозатраты. Вы должны стремиться к состоянию, когда основы безопасности непрерывно проверяются.
|
| **Четко описывайте найденные уязвимости** | Contribute value with less or no friction. Deliver findings in a timely fashion, within the tools development teams are using (not PDF files). Join the development team to address the findings. Take the opportunity to educate them, clearly describing the weakness and how it can be abused, including an attack scenario to make it real. 
Приносите пользу, избегая конфликтов. Передавайте команде разработки информацию о найденных уязвимостях своевременно, с помощью инструментов, используемых командой разработки. Помогите команде разработки разобрать найденные уязвимости. Постарайтесь обучить их, четко объяснив выявленные недостатки и процесс их эксплуатации, включая реальный сценарий атаки.
|

[1]: https://www.devsecops.org/
[2]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[3]: https://www.owasp.org/index.php/OWASP_Testing_Project
[4]: https://www.owasp.org/index.php/OWASP_Security_Knowledge_Framework
[5]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[6]: http://devsecops.github.io/
[7]: https://github.com/devsecops/awesome-devsecops
[8]: http://devsecops.org
