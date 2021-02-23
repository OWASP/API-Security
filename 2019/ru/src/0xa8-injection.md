API8:2019 Инъекции
===================

| Источники угроз/Векторы атак | Недостатки безопасности | Последствия |
| - | - | - |
| Зависит от API : Сложность эксплуатации **3** | Распространненность **2** : Сложность обнаружения **3** | Технические последствия **3** : Зависит от бизнеса |
| Attackers will feed the API with malicious data through whatever injection vectors are available (e.g., direct input, parameters, integrated services, etc.), expecting it to be sent to an interpreter. | Injection flaws are very common and are often found in SQL, LDAP, or NoSQL queries, OS commands, XML parsers, and ORM. These flaws are easy to discover when reviewing the source code. Attackers can use scanners and fuzzers. | Injection can lead to information disclosure and data loss. It may also lead to DoS, or complete host takeover. |

| Злоумышленник может отправить в API любые данные через любой доступный вектор инъекции (например, прямой ввод, параметры, интегрированные сервисы и так далее), предполагая, что они будут перенаправлены в интерпретатор. | Ошибки приводящие к инъекциям, очень распространены и пресущи SQL, LDAP и NoSQL запросам, командам на операционной системе, XML парсерам и ORM. Подобные ошибки легко обнаруживаются в ходе анализа исходного кода. Злоумышленники могут использовать сканеры и фаззеры. | Инъекции могут привести к разглашению или уничтожению данных, отказу в обслуживании или получению злоумышленником полного контроля на сервером. |

## Как определить, является ли API уязвимым?

The API is vulnerable to injection flaws if:

* Client-supplied data is not validated, filtered, or sanitized by the API.
* Client-supplied data is directly used or concatenated to SQL/NoSQL/LDAP
  queries, OS commands, XML parsers, and Object Relational Mapping (ORM)/Object
  Document Mapper (ODM).
* Data coming from external systems (e.g., integrated systems) is not validated,
  filtered, or sanitized by the API.

API уязвим к инъекциям, если:

* Данные, поступившие от пользователя, не валидируются, не фильтруются или не очищаются на стороне API.
* Данные, поступившие от пользователя, конкатенируются или используются в неизменном виде в SQL/NoSQL/LDAP запросах, командах на операционной системе, XML парсерах, ORM (Object Relational Mapping) или ODM (Object Document Mapper).
* Данные поступающие из внешних систем (например, интегрированных систем) не валидируются, не фильтруются или не очищаются на стороне API.

## Примеры сценариев атаки

## Сценарий #1

Firmware of a parental control device provides the endpoint
`/api/CONFIG/restore` which expects an appId to be sent as a multipart
parameter. Using a decompiler, an attacker finds out that the appId is passed
directly into a system call without any sanitization:

Прошивка устройства контроля за детьми предоставляет точку входа `/api/CONFIG/restore`, которая ожидает запроса с multipart параметром appId. Используя декомпилятор, злоумышленник обнаруживает, что appId передается непосредственно в вызов команды на операционной системе без предварительной очистки:

```c
snprintf(cmd, 128, "%srestore_backup.sh /tmp/postfile.bin %s %d",
         "/mnt/shares/usr/bin/scripts/", appid, 66);
system(cmd);
```

The following command allows the attacker to shut down any device with the same
vulnerable firmware:

Следующая команда позволяет злоумышленнику отключить любое устройство с уязвимой прошивкой:

```
$ curl -k "https://${deviceIP}:4567/api/CONFIG/restore" -F 'appid=$(/etc/pod/power_down.sh)'
```

### Сценарий #2

We have an application with basic CRUD functionality for operations with
bookings. An attacker managed to identify that NoSQL injection might be possible
through `bookingId` query string parameter in the delete booking request. This
is how the request looks like: `DELETE /api/bookings?bookingId=678`.

The API server uses the following function to handle delete requests:

Рассмотрим приложение с базовым CRUD функционалом для операций с бронированиями. Злоумышленник обнаружил NoSQL инъекцию через параметр `bookingId` в запросе на удаление бронирования. Запрос выглядит следующим образом: `DELETE /api/bookings?bookingId=678`.

Сервер API обрабатывает запросы на удаление с помощью следующей функции:


```javascript
router.delete('/bookings', async function (req, res, next) {
  try {
      const deletedBooking = await Bookings.findOneAndRemove({'_id' : req.query.bookingId});
      res.status(200);
  } catch (err) {
     res.status(400).json({error: 'Unexpected error occured while processing a request'});
  }
});
```

The attacker intercepted the request and changed `bookingId` query string
parameter as shown below. In this case, the attacker managed to delete another
user's booking:

Злоумышленник перехватывает запрос и изменяет параметр `bookingId`, как продемонстрировано ниже. В этом случае злоумышленник может удалить бронирование, принадлежащее другому пользователю:

```
DELETE /api/bookings?bookingId[$ne]=678
```

## Как предотвратить

Preventing injection requires keeping data separate from commands and queries.

* Perform data validation using a single, trustworthy, and actively maintained
  library.
* Validate, filter, and sanitize all client-provided data, or other data coming
  from integrated systems.
* Special characters should be escaped using the specific syntax for the target
  interpreter.
* Prefer a safe API that provides a parameterized interface.
* Always limit the number of returned records to prevent mass disclosure in case
  of injection.
* Validate incoming data using sufficient filters to only allow valid values for
  each input parameter.
* Define data types and strict patterns for all string parameters.

Для предотвращения инъекций необходимо отделять данные от команд и запросов.

* Валидируйте данные, используя одну доверенную и активно поддерживаемую библиотеку.
* Валидируйте, фильтруйте и очищайте все данные, получаемые от клиентов или интегрированных систем.
* Специальные символы должны быть экранированы, используя синтаксис целевого интерпретатора.
* Отдайте предпочтение безопасному API, предоставляющему параметризированный интерфейс.
* Всегда ограничивайте количество возвращаемых записей, чтобы предотратить массовую утечку данных в случае инъекции.
* Валидируйте входящие данные с помощью надлежащих фильтров, допуская только подходящие значения каждого из входящих параметров.
* Определите тип данных и строгую модель данных для всех строковых параметров.

## Ссылки

### OWASP

* [OWASP Injection Flaws][1]
* [SQL Injection][2]
* [NoSQL Injection Fun with Objects and Arrays][3]
* [Command Injection][4]

### Внешние

* [CWE-77: Command Injection][5]
* [CWE-89: SQL Injection][6]

[1]: https://www.owasp.org/index.php/Injection_Flaws
[2]: https://www.owasp.org/index.php/SQL_Injection
[3]: https://www.owasp.org/images/e/ed/GOD16-NOSQL.pdf
[4]: https://www.owasp.org/index.php/Command_Injection
[5]: https://cwe.mitre.org/data/definitions/77.html
[6]: https://cwe.mitre.org/data/definitions/89.html
