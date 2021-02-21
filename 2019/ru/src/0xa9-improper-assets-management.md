API9:2019 Ненадлежащее Управление Активами
====================================

| Источники угроз/Векторы атак | Недостатки безопасности | Последствия |
| - | - | - |
| Зависит от API : Сложность эксплуатации **3** | Распространненность **3** : Сложность обнаружения **2** | Технические последствия **2** : Зависит от бизнеса |
| Old API versions are usually unpatched and are an easy way to compromise systems without having to fight state-of-the-art security mechanisms, which might be in place to protect the most recent API versions. | Outdated documentation makes it more difficult to find and/or fix vulnerabilities. Lack of assets inventory and retire strategies leads to running unpatched systems, resulting in leakage of sensitive data. It’s common to find unnecessarily exposed API hosts because of modern concepts like microservices, which make applications easy to deploy and independent (e.g., cloud computing, k8s). | Attackers may gain access to sensitive data, or even takeover the server through old, unpatched API versions connected to the same database. |

Старые версии API обычно не содержат всех исправлений и могут быть с легкостью скомпрометированы без необходимости обходить новейшие механизмы безопасности, которые с высокой вероятностью используются для защиты последних версий API. | Устаревшая документация усложняет поиск и исправление уязвимостей. Отсутствие инвентаризации активов и стратегии вывода из эксплуатации приводит к функционированию необновленных систем, которые могут быть использованы для кражи критичных данных. Точки входа API зачастую доступны без необходимости на то из-за использования современных подходов типа микро-сервисов, которые позволяют легко разворачить независимые приложения (например, облачные вычисления или kubernetes). | Злоумышленник может получить доступ к критичным данным или даже получить контроль над сервером через старую, необновленную версию API, использующую одну и ту же базу данных. |

## Как определить является ли API уязвимым?

The API might be vulnerable if:

* The purpose of an API host is unclear, and there are no explicit answers to
  the following questions:
  * Which environment is the API running in (e.g., production, staging, test,
    development)?
  * Who should have network access to the API (e.g., public, internal, partners)?
  * Which API version is running?
  * What data is gathered and processed by the API (e.g., PII)?
  * What's the data flow?
* There is no documentation, or the existing documentation is not updated.
* There is no retirement plan for each API version.
* Hosts inventory is missing or outdated.
* Integrated services inventory, either first- or third-party, is missing or
  outdated.
* Old or previous API versions are running unpatched.

API может быть уязвимым если:

* Назначение API ??? (хост АПИ? коряво) неясно, а также нет четких ответов на следующие вопросы:
  * В каком окружении запущено API (например, промышленное, промежуточное (staging), тестовое, разработческое)?
  * Каким должен быть сетевой доступ к API (например, общедоступным, внутренним, для партнеров)?
  * Какая версия API запущена?
  * Какие данные собираются и обрабатываются API (например, персональные данные)?
  * Каков потом движения данных?
* Документация отсутствует или не обновляется.
* Отсутствует план вывода из эксплуатации предыдущих версий API.
* Инвентаризация хостов ??? не проводится, или ее результаты устарели.
* Инвентаризация интегрированных внутренних или сторонних сервисов не проводится, или ее результаты устарели.
* Старые или предыдущие версии API функционируют без обновлений.

## Примеры сценариев атаки

## Сценарий #1

After redesigning their applications, a local search service left an old API
version (`api.someservice.com/v1`) running, unprotected, and with access to the
user database. While targeting one of the latest released applications, an
attacker found the API address (`api.someservice.com/v2`). Replacing `v2` with
`v1` in the URL gave the attacker access to the old, unprotected API,
exposing the personal identifiable information (PII) of over 100 Million users.

После переработки своих приложений локальный поисковый сервис оставил доступ к старой версию API (`api.someservice.com/v1`) без надлежащих мер защиты и с доступом к базе данных пользователей. Тестируя одну из последних выпущенных версий приложения, злоумышленник нашел адрес API (`api.someservice.com/v2`). Заменив `v2` на `v1` в URL, злоумышленник получил доступ к старому незащищенному API, предоставляющему доступ к персональным данным более 100 миллионов пользователей.

### Сценарий #2

A social network implemented a rate-limiting mechanism that blocks attackers
from using brute-force to guess reset password tokens. This mechanism wasn’t
implemented as part of the API code itself, but in a separate component between
the client and the official API (`www.socialnetwork.com`).
A researcher found a beta API host (`www.mbasic.beta.socialnetwork.com`) that
runs the same API, including the reset password mechanism, but the rate limiting
mechanism was not in place. The researcher was able to reset the password of any
user by using a simple brute-force to guess the 6 digits token.

Социальная сеть внедрила механизм ограничения количества запросов, не позволяющий злоумышленнику подобрать токен для сброса пароля. Этот механизм не был внедрен непосредственно в код API, а использовался в качестве отдельного компонента между клиентом и официальным API (`www.socialnetwork.com`).
Исследователь нашел бета версию API (`www.mbasic.beta.socialnetwork.com`), использующую тот же API, включая механизм сброса пароля, но не механизм ограничения количества запросов. Исследователь смог сбросить пароль любого пользователя, перебирая все возможные варианты кода из 6 цифр.

## Как предотвратить

* Inventory all API hosts and document important aspects of each one of them,
  focusing on the API environment (e.g., production, staging, test,
  development), who should have network access to the host (e.g., public,
  internal, partners) and the API version.
* Inventory integrated services and document important aspects such as their
  role in the system, what data is exchanged (data flow), and its sensitivity.
* Document all aspects of your API such as authentication, errors, redirects,
  rate limiting, cross-origin resource sharing (CORS) policy and endpoints,
  including their parameters, requests, and responses.
* Generate documentation automatically by adopting open standards. Include the
  documentation build in your CI/CD pipeline.
* Make API documentation available to those authorized to use the API.
* Use external protection measures such as API security firewalls for all exposed versions of your APIs, not just for the current production version.
* Avoid using production data with non-production API deployments. If this is unavoidable, these endpoints should get the same security treatment as the production ones.
* When newer versions of APIs include security improvements, perform risk analysis to make the decision of the mitigation actions required for the older version: for example, whether it is possible to backport the improvements without breaking API compatibility or you need to take the older version out quickly and force all clients to move to the latest version.

* Проводите инвентаризацию хостов ??? API и документируйте важные аспекты каждого из них: окружение (например, промышленное, промежуточное (staging), тестовое, разработческое), каким должен быть сетевой доступ (например, общедоступным, внутренним, для партнеров) и версию API.
* Проводите инвентаризацию интегрированных сервисов и документируйте важные аспекты каждого из них: роль в системе, какие данные участвую в обмене (потоки данных), какая степень критичности этих данных.
* Документируйте все аспекты API: аутентификацию, ошибки, перенаправления, ограничение количества запросов, политику разделения ресурсов между источниками (CORS) и точки входа, включая параметры, запросы и ответы.
* Создавайте документацию автоматически, используя общедоступные стандарты. Включайте создание документации в CI/CD.
* Предоставьте документацию тем, кто имеет право доступа к API.
* Используйте внешние меры защиты, например, API security firewalls на всех доступных версиях API, а не только на текущей версии в промышленной эксплуатации.
* Избегайте использования данных с промышленной системы в API на базе непромышленного окружения. Если такого использования невозможно избежать, защищайте это API аналогично используемым в промышленной эксплуатации.
* Когда новая версия API включает улучшения, связанные с безопасностью, проводите анализ рисков для принятия решения о действиях по снижению рисков в старых версиях, например, переносу улучшения в старые версии без нарушения совместимости, или отключению старой версии и переводу всех клиентов на последнюю версию.

## Ссылки

### Внешние

* [CWE-1059: Incomplete Documentation][1]
* [OpenAPI Initiative][2]

[1]: https://cwe.mitre.org/data/definitions/1059.html
[2]: https://www.openapis.org/
