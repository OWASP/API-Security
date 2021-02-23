API7:2019 Ошибки Настроек Безопасности
===================================

| Источники угроз/Векторы атак | Недостатки безопасности | Последствия |
| - | - | - |
| Зависит от API : Сложность эксплуатации **3** | Распространненность **3** : Сложность обнаружения **3** | Технические последствия **2** : Зависит от бизнеса |
| Attackers will often attempt to find unpatched flaws, common endpoints, or unprotected files and directories to gain unauthorized access or knowledge of the system. | Security misconfiguration can happen at any level of the API stack, from the network level to the application level. Automated tools are available to detect and exploit misconfigurations such as unnecessary services or legacy options. | Security misconfigurations can not only expose sensitive user data, but also system details that may lead to full server compromise. |

| Злоумышленники часто пытаются найти незакрытые уязвимости, распространенные точки входа или незащищенные файлы и папки, чтобы получить информацию о системе или неавторизованный доступ к ней. | Ошибка настроек безопасности может произойти на любом уровне API: от сетевого уровня до уровня приложения. Существуют автоматизированные инструменты для обнаружения и эксплуатации таких ошибок конфигурации, как ненужные (забытые) сервисы или использование устаревших параметров. | Ошибки настроек безопасности могут не только раскрыть конфиденциальные данные пользователей, но и данные о системе, что потенциально может привести к её полной компрометации. |

## Как определить, является ли API уязвимым?

The API might be vulnerable if:

* Appropriate security hardening is missing across any part of the application
  stack, or if it has improperly configured permissions on cloud services.
* The latest security patches are missing, or the systems are out of date.
* Unnecessary features are enabled (e.g., HTTP verbs).
* Transport Layer Security (TLS) is missing.
* Security directives are not sent to clients (e.g., [Security Headers][1]).
* A Cross-Origin Resource Sharing (CORS) policy is missing or improperly set.
* Error messages include stack traces, or other sensitive information is
  exposed.

API уязвим, если:
* Должные настройки безопасности отсутствуют на каком-либо уровне приложения, а также если права доступа к облачным сервисам некорректно настроены.
* Используется устаревшая система, или не установлены новейшие исправления по безопасности.
* Активен излишний функционал (например, неиспользуемые HTTP методы).
* Не используется протокол TLS (Transport Layer Security).
* Директивы безопасности не отправляются клиентским приложениям (например, [Заголовки Безопасности][1]).
* Политика разделения ресурсов между источниками (Cross-Origin Resource Sharing) отсутствует или некорректно настроена.
* Сообщения об ошибках включают детальную информацию или раскрывают критичные данные.

## Примеры сценариев атаки

## Сценарий #1

An attacker finds the `.bash_history` file under the root directory of the
server, which contains commands used by the DevOps team to access the API:

```
$ curl -X GET 'https://api.server/endpoint/' -H 'authorization: Basic Zm9vOmJhcg=='
```

An attacker could also find new endpoints on the API that are used only by the
DevOps team and are not documented.

Злоумышленник в корне директории сервера находит файл `.bash_history`, содержащий команды, которые использовала команда DevOps для доступа к API:

```
$ curl -X GET 'https://api.server/endpoint/' -H 'authorization: Basic Zm9vOmJhcg=='
```

Злоумышленник также может найти другие незадокументированные точки входа API, используемые только командой DevOps.

### Сценарий #2

To target a specific service, an attacker uses a popular search engine to search
for  computers directly accessible from the Internet. The attacker found a host
running a popular database management system, listening on the default port. The
host was using the default configuration, which has authentication disabled by
default, and the attacker gained access to millions of records with PII,
personal preferences, and authentication data.

Для атаки на конкретный сервис злоумышленник использует популярный поисковик, чтобы найти компьютеры, напрямую доступные из сети Интернет. Злоумышленник находит сервер, на котором запущена популярная система управления базой данных, доступная на стандартном порте. На сервере используется стандартная конфигурация, не предполагающая аутентификации, что позволяет злоумышленнику получить доступ к миллионам записей с персональными данными, личными предпочтениями и аутентификационными данными.

### Сценарий #3

Inspecting traffic of a mobile application an attacker finds out that not all
HTTP traffic is performed on a secure protocol (e.g., TLS). The attacker finds
this to be true, specifically for the download of profile images. As user
interaction is binary, despite the fact that API traffic is performed on a
secure protocol, the attacker finds a pattern on API responses size, which he
uses to track user preferences over the rendered content (e.g., profile images).

Анализируя трафик мобильного приложения, злоумышленник обнаруживает, что не весь HTTP трафик защищен (например, с помощью TLS). В частности, не защищено скачивание изображений профиля. Поскольку взаимодействие пользователя с приложением бинарно (да или нет, свайп влево или вправо, и так далее), несмотря на шифрование трафика, злоумышленник может найти закономерности в параметрах ответов API (например, размер ответа на свайп влево больше, чем на свайп вправо), которые он в свою очередь может использовать для отслеживания действий и предпочтений пользователя.

## Как предотвратить

The API life cycle should include:

* A repeatable hardening process leading to fast and easy deployment of a
  properly locked down environment.
* A task to review and update configurations across the entire API stack. The
  review should include: orchestration files, API components, and cloud services
  (e.g., S3 bucket permissions).
* A secure communication channel for all API interactions access to static
  assets (e.g., images).
* An automated process to continuously assess the effectiveness of the
  configuration and settings in all environments.

Жизненный цикл API должен включать в себя:

* Повторяемый процесс усиления настроек безопасности, ведущий к более быстрому и простому развертыванию должным образом защищенного окружения.
* Задачу по обзору и обновлению конфигурации на всех уровнях API. Обзор должен включать в себя файлы оркестрации, компоненты API и облачных сервисов (например, права доступа в S3 bucket).
* Защищенный канал связи при доступе к статическим ресурсам.
* Автоматизированный процесс, проводящий постоянную оценку эффективности настроек и параметров во всех окружениях.

Furthermore:

* To prevent exception traces and other valuable information from being sent
  back to attackers, if applicable, define and enforce all API response payload
  schemas including error responses.
* Ensure API can only be accessed by the specified HTTP verbs. All other HTTP
  verbs should be disabled (e.g. `HEAD`).
* APIs expecting to be accessed from browser-based clients (e.g., WebApp
  front-end) should implement a proper Cross-Origin Resource Sharing (CORS)
  policy.

Кроме того:

* Для предотвращения отправки злоумышленникам подробных сообщений об ошибках и другой критичной информации, если это возможно, определите схемы данных всех ответов API и обеспечьте проверку этих ответов по схемам, включая сообщения об ошибках.
* Убедитесь, что API доступно только с использованием заданного списка HTTP методов. Любые другие методы HTTP должны быть отключены (например, `HEAD`).
* API, клиентами которых подразумеваются браузерные клиентские приложения, должны иметь корректно настроенную политику разделения ресурсов между источниками (Cross-Origin Resource Sharing).

## Ссылки

### OWASP

* [OWASP Secure Headers Project][1]
* [OWASP Testing Guide: Configuration Management][2]
* [OWASP Testing Guide: Testing for Error Codes][3]
* [OWASP Testing Guide: Test Cross Origin Resource Sharing][9]

### Внешние

* [CWE-2: Environmental Security Flaws][4]
* [CWE-16: Configuration][5]
* [CWE-388: Error Handling][6]
* [Guide to General Server Security][7], NIST
* [Let’s Encrypt: a free, automated, and open Certificate Authority][8]

[1]: https://www.owasp.org/index.php/OWASP_Secure_Headers_Project
[2]: https://www.owasp.org/index.php/Testing_for_configuration_management
[3]: https://www.owasp.org/index.php/Testing_for_Error_Code_(OTG-ERR-001)
[4]: https://cwe.mitre.org/data/definitions/2.html
[5]: https://cwe.mitre.org/data/definitions/16.html
[6]: https://cwe.mitre.org/data/definitions/388.html
[7]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[8]: https://letsencrypt.org/
[9]: https://www.owasp.org/index.php/Test_Cross_Origin_Resource_Sharing_(OTG-CLIENT-007)
