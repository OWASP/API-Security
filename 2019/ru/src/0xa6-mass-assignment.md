API6:2019 - Массовое переназначение параметров (Mass assignment)
===========================

| Источники угроз/Векторы атак | Недостатки безопасности | Последствия |
| - | - | - |
| Зависит от API : Сложность эксплуатации **2** | Распространненность **2** : Сложность обнаружения **2** | Технические последствия **2** : Зависит от бизнеса |
| Exploitation usually requires an understanding of the business logic, objects' relations, and the API structure. Exploitation of mass assignment is easier in APIs, since by design they expose the underlying implementation of the application along with the properties’ names. | Modern frameworks encourage developers to use functions that automatically bind input from the client into code variables and internal objects. Attackers can use this methodology to update or overwrite sensitive object’s properties that the developers never intended to expose. | Exploitation may lead to privilege escalation, data tampering, bypass of security mechanisms, and more. |

| Для эксплуатации зачастую требуется понимание бизнес логики, связей между объектами и структура API. Эксплуатация массового переназначения параметров проще реализуема в API, поскольку они изначально предусматривают общедоступность внутренней реализации API и названий свойств объектов. | Современные фреймфорки предлагают разработчикам функции, которые автоматически присваиют переменным и внутренним объектам значения соответствующих параметров из пользовательского ввода. Злоумышленник может использовать эту методологию, чтобы обновите или переназначить критичные свойства объектов, которые разработчик не намеревался делать доступными для пользователя. | Эксплуатация уязвимости может привести к повышению привилегий, злонамеренному изменению данных, обходу мезанизмов щашиты и так далее. |

## Как определить является ли API уязвимым?

Objects in modern applications might contain many properties. Some of these
properties should be updated directly by the client (e.g., `user.first_name` or
`user.address`) and some of them should not (e.g., `user.is_vip` flag).

Объекты в современных приложениях могут иметь большое количество свойств. Некоторые из них могут быть изменены напрямую клиентом (например, `user.first_name` или`user.address`), в то время как изменение других не должно быть доступно (например, флаг `user.is_vip`).

An API endpoint is vulnerable if it automatically converts client parameters
into internal object properties, without considering the sensitivity and the
exposure level of these properties. This could allow an attacker to update
object properties that they should not have access to.

Коненая точка API уязвима, если она автоматически присваивает предоставленные клиентом параметры свойствам внутренних объектов, не учитывая конфиденциальность и уровень доступности этих свойств. Это может позволить злоумышленнику изменить свойства объектов, к которым у него нет доступа.

Examples for sensitive properties:

* **Permission-related properties**: `user.is_admin`, `user.is_vip` should only
  be set by admins.
* **Process-dependent properties**: `user.cash` should only be set internally
  after payment verification.
* **Internal properties**: `article.created_time` should only be set internally
  by the application.

* **Свойства относящиеся к привилегиям**: `user.is_admin`, `user.is_vip` должны определяться только администраторами.
* **Свойства зависящие от процесса**: `user.cash` должны устанавливаться только внутри кода после проверки платежа.
* **Внутренние свойства**: `article.created_time` должны устанавливаться только внутри кода самим приложением.


## Примеры сценариев атаки

## Сценарий #1

A ride sharing application provides a user the option to edit basic information
for their profile. During this process, an API call is sent to
`PUT /api/v1/users/me` with the following legitimate JSON object:

Приложение для совместных поездок позволяет пользователю редактировать базовую информацию своего профиля. В ходе редактирования отправляется следующий запрос `PUT /api/v1/users/me` с корректным JSON объектом в теле запроса:

```json
{"user_name":"inons","age":24}
```

The request `GET /api/v1/users/me` includes an additional credit_balance
property:

Запрос к `GET /api/v1/users/me` включает в себя дополнительное свойство credit_balance:

```json
{"user_name":"inons","age":24,"credit_balance":10}.
```

The attacker replays the first request with the following payload:

Злоумышленник дублирует первый запрос со следующим телом запроса:

```json
{"user_name":"attacker","age":60,"credit_balance":99999}
```

Since the endpoint is vulnerable to mass assignment, the attacker receives
credits without paying.

Поскольку конечная точка API узвима к массовому переназначению параметров, злоумышленник зачисляет деньги на свой баланс, не совершив платежа. 

### Сценарий #2

A video sharing portal allows users to upload content and download content in
different formats. An attacker who explores the API found that the endpoint
`GET /api/v1/videos/{video_id}/meta_data` returns a JSON object with the video’s
properties. One of the properties is `"mp4_conversion_params":"-v codec h264"`,
which indicates that the application uses a shell command to convert the video.

Портал для обмена видео позволяет пользователям загружать и скачивать материалы в разынх форматах. Злоумышленник обследует API и обнаруживает, что конечная точка `GET /api/v1/videos/{video_id}/meta_data` возвращает JSON объект с параметрами видео. Один из параметров `"mp4_conversion_params":"-v codec h264"` дает понять, что приложение использует консольную команду для конвертации видео.

The attacker also found the endpoint `POST /api/v1/videos/new` is vulnerable to
mass assignment and allows the client to set any property of the video object.
The attacker sets a malicious value as follows:
`"mp4_conversion_params":"-v codec h264 && format C:/"`. This value will cause a
shell command injection once the attacker downloads the video as MP4.

Злоумышленник также обнаружил, что конечная точка `POST /api/v1/videos/new` уязвима к массовому переназначению параметров и позволяет клиенту установить значение любого свойства объекта видео. 
Злоумышленник устанавливает следующее значение параметра: `"mp4_conversion_params":"-v codec h264 && format C:/"`. Это значение приведет к инъекции команды операционной системы, как только злоумышленник скачает видео в формате MP4.

## Как предотвратить

* If possible, avoid using functions that automatically bind a client’s input
  into code variables or internal objects.
* Whitelist only the properties that should be updated by the client.
* Use built-in features to blacklist properties that should not be accessed by
  clients.
* If applicable, explicitly define and enforce schemas for the input data
  payloads.

* Если возможно, избегайте использования функций, которые автоматически присваивают переменным и внутренним объектам сооветствующие значения из пользовательского ввода.
* Добавляйте в белые списки только свойства, которые могут быть изменены клиентом.
* Используйте встроенный функционал по добавлению в черный список свойств, к которым клиенты не могут иметь доступ.
* Если это возможно, определите схемы входящих данных и проверяйте входящие данные по ним.

## Ссылки

### Внешние

* [CWE-915: Improperly Controlled Modification of Dynamically-Determined Object Attributes][1]

[1]: https://cwe.mitre.org/data/definitions/915.html
