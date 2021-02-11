API10:2019 Недостаточное логирование и мониторинг
============================================

| Источники угроз/Векторы атак | Недостатки безопасности | Последствия |
| - | - | - |
| Зависит от API : Сложность эксплуатации **2** | Распространненность **3** : Сложность обнаружения **1** | Технические последствия **2** : Зависит от бизнеса |
| Attackers take advantage of lack of logging and monitoring to abuse systems without being noticed. | Without logging and monitoring, or with insufficient logging and monitoring, it is almost impossible to track suspicious activities and respond to them in a timely fashion. | Without visibility over on-going malicious activities, attackers have plenty of time to fully compromise systems. |

| Злоумышленник пользуется отсутствием логирования и мониторинга для незаметной эксплуатации систем. | Отсутствующие или недостаточные логирование и мониторинг не позволяют отследить подозрительную активность и своевременно отреагировать на нее. | Без наблюдения за происходящей злонамеренной активностью у злоумышленника есть достуточно времени для полной компрометации систем. |

## Как определить является ли API уязвимым?

The API is vulnerable if:

* It does not produce any logs, the logging level is not set correctly, or log
  messages do not include enough detail.
* Log integrity is not guaranteed (e.g., [Log Injection][1]).
* Logs are not continuously monitored.
* API infrastructure is not continuously monitored.

API уязвимос если:

* Оно не генерирует логи, уровень логирования некорректно установлен, или соощения в логах не достаточно детальны.
* Не обеспечивается целостность логов (например, [Инъекция в логи][1]).

## Примеры сценариев атаки

## Сценарий #1

Access keys of an administrative API were leaked on a public repository. The
repository owner was notified by email about the potential leak, but took more
than 48 hours to act upon the incident, and access keys exposure may have
allowed access to sensitive data. Due to insufficient logging, the company is
not able to assess what data was accessed by malicious actors.

Ключ доступа к административному API утекли через общедоступный репозиторий. Владелец репозитория был уведомлен о потенциальной утечке по электронной почте, но отреагировал на инцидент более чем через 48 часов, в связи с чем утечка ключей могла привести к получению доступа к критичным данным. Из-за недостаточного логирования компания не в состоянии оценить, к каким данным злоумыленники смогли получить доступ.

### Сценарий #2

A video-sharing platform was hit by a “large-scale” credential stuffing attack.
Despite failed logins being logged, no alerts were triggered during the timespan
of the attack. As a reaction to user complaints, API logs were analyzed and the
attack was detected. The company had to make a public announcement asking users
to reset their passwords, and report the incident to regulatory authorities.

Платформа обмена видео подверглась масштабной (credential stuffing) атаке по перебору учетных данных. Не смотря на логирование неуспешных попыток входа, уведомление об атаке не последовало в течение всего хода атаки. Логи были проанализированы и атака обнаружена во время разбора обращения пользователя. Компании пришлось публично попросить пользователей сменить пароли и отправить отчет об атаке в регулирующие органы.

## Как предотвратить

* Log all failed authentication attempts, denied access, and input validation
  errors.
* Logs should be written using a format suited to be consumed by a log
  management solution, and should include enough detail to identify the
  malicious actor.
* Logs should be handled as sensitive data, and their integrity should be
  guaranteed at rest and transit.
* Configure a monitoring system to continuously monitor the infrastructure,
  network, and the API functioning.
* Use a Security Information and Event Management (SIEM) system to aggregate and
  manage logs from all components of the API stack and hosts.
* Configure custom dashboards and alerts, enabling suspicious activities to be
  detected and responded to earlier.

* Логируйте все неудачные попытки входа, отказы в доступе и ошибки валидации входящих данных.
* Логи должны быть представлены в формате, позволяющем обрабатывать их с помощью систем управления логами, и должны включать достаточное количество деталей, позволяющих идентифицировать злоумышленника
* Логи должны считаться критичными данными, а их целостность должна быть обеспечена в их передаче и хранении.
* Настройте систему мониторинга для постоянного контроля инфраструктуры, сети и функционирующих API.
* Используйте систему управления информацией и событиями безопасности (SIEM), чтобы агрегировать и управлять логами всех компонентов на всех уровнях API и хостов API ???.
* Настройте персональные уведомления и панели управления для скорейшего обнаружения и реагирования на подозрительную активность.

## Ссылки

### OWASP

* [OWASP Logging Cheat Sheet][2]
* [OWASP Proactive Controls: Implement Logging and Intrusion Detection][3]
* [OWASP Application Security Verification Standard: V7: Error Handling and
  Logging Verification Requirements][4]

### Внешние

* [CWE-223: Omission of Security-relevant Information][5]
* [CWE-778: Insufficient Logging][6]

[1]: https://www.owasp.org/index.php/Log_Injection
[2]: https://www.owasp.org/index.php/Logging_Cheat_Sheet
[3]: https://www.owasp.org/index.php/OWASP_Proactive_Controls
[4]: https://github.com/OWASP/ASVS/blob/master/4.0/en/0x15-V7-Error-Logging.md
[5]: https://cwe.mitre.org/data/definitions/223.html
[6]: https://cwe.mitre.org/data/definitions/778.html
