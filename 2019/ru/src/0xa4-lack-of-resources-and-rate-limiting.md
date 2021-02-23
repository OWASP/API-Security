API4:2019 Отсутствие Ограничений на Количество Запросов и Потребляемые Ресурсы
===========================================

| Источники угроз/Векторы атак | Недостатки безопасности | Последствия |
| - | - | - |
| Зависит от API : Сложность эксплуатации **2** | Распространненность **3** : Сложность обнаружения **3** | Технические последствия **2** : Зависит от бизнеса |
| Exploitation requires simple API requests. No authentication is required. Multiple concurrent requests can be performed from a single local computer or by using cloud computing resources. | It’s common to find APIs that do not implement rate limiting or APIs where limits are not properly set. | Exploitation may lead to DoS, making the API unresponsive or even unavailable. |

| Для эксплуатации необходимы простые запросы к API. Аутентификация не требуется. Злоумышленник может единовременно отправить большое количество запросов, используя локальный компьютер или облачную систему вычислений. | Часто API не ограничивают количество запросов, или эти ограничения настроены некорректно. | Эксплуатация может привести к отказу в обслуживании, выражающемся в долгом времени ответа или полной недоступности API. |

## Как определить является ли API уязвимым?

API requests consume resources such as network, CPU, memory, and storage. The
amount of resources required to satisfy a request greatly depends on the user
input and endpoint business logic. Also, consider the fact that requests from
multiple API clients compete for resources. An API is vulnerable if at least one
of the following limits is missing or set inappropriately (e.g., too low/high):

* Execution timeouts
* Max allocable memory
* Number of file descriptors
* Number of processes
* Request payload size (e.g., uploads)
* Number of requests per client/resource
* Number of records per page to return in a single request response

Запросы к API потребляют ресурсы, например, пропускную способность канала, процессорное время, оперативную память и место в хранилище данных. Количество ресурсов, потребляемых для ответа на запрос к API, во многом зависит от пользовательского ввода и бизнес логики точки входа. Кроме того, нужно принимать во внимание то, что запросы от различных клиентов API используют ресурсы совместно. API уязвимо, если хотя бы одно из следующих ограничений отсутствует или имеет некорректное значение (например, слишком высокое или низкое):

* Максимальное время ожидания выполнения 
* Максимальный объем выделяемой памяти
* Количество файловых дескрипторов
* Количество процессов
* Размер полезной нагрузки запроса (например, размер загружаемого файла)
* Количество запросов на одного клиента или ресурс
* Количество записей из базы данных, возвращаемых в ответе на один запрос

## Примеры сценариев атаки

## Сценарий #1

An attacker uploads a large image by issuing a POST request to `/api/v1/images`.
When the upload is complete, the API creates multiple thumbnails with different
sizes. Due to the size of the uploaded image, available memory is exhausted
during the creation of thumbnails and the API becomes unresponsive.

Злоумышленник загружает большое изображение, отправив POST запрос на `/api/v1/images`. После завершения загрузки, API создает миниатюры изображения разного размера. Во время создания миниатюр приложение использует всю доступную память и перестает отвечать на запросы из-за большого размера загруженного изображения.

### Сценарий #2

We have an application that contains the users' list on a UI with a limit of
`200` users per page. The users' list is retrieved from the server using the
following query: `/api/users?page=1&size=100`. An attacker changes the `size`
parameter to `200 000`, causing performance issues on the database. Meanwhile,
the API becomes unresponsive and is unable to handle further requests from this
or any other clients (aka DoS).

The same scenario might be used to provoke Integer Overflow or Buffer Overflow
errors.

Рассмотрим приложение, отображающее список пользователей в пользовательском интерфейсе с ограничением `200` штук на страницу. Для получения списка пользователей приложение отправляет следующий запрос на сервер: `/api/users?page=1&size=100`. Злоумышленник увеличивает `size` до `200 000`, что приводит к проблемам произвоительности в базе данных. API перестает отвечать на запросы и больше не может обработать запросы текущего или любого другого клиента (отказ в обслуживании).

Аналогичный сценарий может быть использован для обнаружения ошибок переполнения буфера или целочисленного переполнения.

## Как предотвратить

* Docker makes it easy to limit [memory][1], [CPU][2], [number of restarts][3],
  [file descriptors, and processes][4].
* Implement a limit on how often a client can call the API within a defined
  timeframe.
* Notify the client when the limit is exceeded by providing the limit number and
  the time at which the limit will be reset.
* Add proper server-side validation for query string and request body
  parameters, specifically the one that controls the number of records to be
  returned in the response.
* Define and enforce maximum size of data on all incoming parameters and
  payloads such as maximum length for strings and maximum number of elements in
  arrays.

* Docker легко позволяет ограничить [объем памяти][1], [процессорное время][2], [количество перезапусков][3],
  [файловые дескрипторы и процессы][4].
* Определите ограничение того, как часто один клиент может вызывать метод API в заданный промежуток времени.
* Уведомите клиента, когда ограничение превышено, предоставив ему значение ограничения и время, когда ограничение будет сброшено.
* Добавьте соответствующие проверки параметров строки запроса и тела запроса на стороне сервера, в особенности контролирующих количество записей возвращаемых в запросе.
* Определите и контролируйте максимальный размер данных, содержащихся во всех входящих параметрах и полезных нагрузках, например, максимальную длину строки или максимальное количество элементов массива.

## Ссылки

### OWASP

* [Blocking Brute Force Attacks][5]
* [Docker Cheat Sheet - Limit resources (memory, CPU, file descriptors,
  processes, restarts)][6]
* [REST Assessment Cheat Sheet][7]

### Внешние

* [CWE-307: Improper Restriction of Excessive Authentication Attempts][8]
* [CWE-770: Allocation of Resources Without Limits or Throttling][9]
* “_Rate Limiting (Throttling)_” - [Security Strategies for Microservices-based
  Application Systems][10], NIST

[1]: https://docs.docker.com/config/containers/resource_constraints/#memory
[2]: https://docs.docker.com/config/containers/resource_constraints/#cpu
[3]: https://docs.docker.com/engine/reference/commandline/run/#restart-policies---restart
[4]: https://docs.docker.com/engine/reference/commandline/run/#set-ulimits-in-container---ulimit
[5]: https://www.owasp.org/index.php/Blocking_Brute_Force_Attacks
[6]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/Docker_Security_Cheat_Sheet.md#rule-7---limit-resources-memory-cpu-file-descriptors-processes-restarts
[7]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/REST_Assessment_Cheat_Sheet.md
[8]: https://cwe.mitre.org/data/definitions/307.html
[9]: https://cwe.mitre.org/data/definitions/770.html
[10]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204-draft.pdf
