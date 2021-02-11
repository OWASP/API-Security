API1:2019 Некорректная Авторизация на Уровне Объектов (BOLA)
===========================================

| Источники угроз/Векторы атак | Недостатки безопасности | Последствия |
| - | - | - |
| Зависит от API : Сложность эксплуатации **3** | Распространненность **3** : Сложность обнаружения **2** | Технические последствия **3** : Зависит от бизнеса |
| Злоумышленник может проэксплуатрировать точки входа API уязвимые к некорректной авторизации на уровне объектов, манипулируя идентификатором объекта, отправляемого в запросе. Это может привести к неавторизованному доступу к конфиденциальной информации. Это очень распространненая ситуация среди приложений базирующихся на API, потому что серверная часть не полностью отслеживает состояние клиента, а вместо это полагается на параметры отправляемые клиентом, например, идентификатор объекта, чтобы принять решение к какому объекту осуществляется доступ.| BOLA - наиболее распространенная и несущая наибольшим последствиям атака на API. Авторизация и механизмы контроля доступа в современных приложениях повсеместны и зачастую запутанны. Даже если проверки авторизации реализованы в приложении корректно, разработчики могут забыть добавить эти проверки перед доступом к конфиденциальным данным. Автоматическое статическое и динамическое тестирование как правило не обнаруживает проблемы с управлением доступом. | Неавторизованный доступ может привести к потере и манипулированию данными, а также разглашению данных лицам, не имеющим права доступа к информации. Кроме того неавторизованный доступ может привести к получению полного контроля над учетными записями.|
Attackers can exploit API endpoints that are vulnerable to broken object level authorization by manipulating the ID of an object that is sent within the request. This may lead to unauthorized access to sensitive data. This issue is extremely common in API-based applications because the server component usually does not fully track the client’s state, and instead, relies more on parameters like object IDs, that are sent from the client to decide which objects to access. | This has been the most common and impactful attack on APIs. Authorization and access control mechanisms in modern applications are complex and wide-spread. Even if the application implements a proper infrastructure for authorization checks, developers might forget to use these checks before accessing a sensitive object. Access control detection is not typically amenable to automated static or dynamic testing. | Unauthorized access can result in data disclosure to unauthorized parties, data loss, or data manipulation. Unauthorized access to objects can also lead to full account takeover. |

## Как определить является ли API уязвимым?

Object level authorization is an access control mechanism that is usually
implemented at the code level to validate that one user can only access objects
that they should have access to.
Авторизация на уровне объектов - это механизм управления доступом, реализуемый на уровне кода, с целью проверки того, что пользователь получает доступ только к тем объектам, к которым у него есть доступ.

Every API endpoint that receives an ID of an object, and performs any type of
action on the object, should implement object level authorization checks. The
checks should validate that the logged-in user does have access to perform the
requested action on the requested object.
Каждая точка входа API, получающая идентификатор объекта и выполняющая любое действие с объектом, должна провести проверку авторизации на уровне объекта. Проверка должна удостовериться в том, что текущий пользователь действительно имеет право осуществить запрошенное действие над запрошенным объектом.

Failures in this mechanism typically leads to unauthorized information
disclosure, modification, or destruction of all data.
Некорректная работа этого механизма обычно приводит к неавторизованному разглашению, изменению или уничтожению всех данных.

## Пример сценария атаки

### Сценарий #1

An e-commerce platform for online stores (shops) provides a listing page with
the revenue charts for their hosted shops. Inspecting the browser requests, an
attacker can identify the API endpoints used as a data source for those charts
and their pattern `/shops/{shopName}/revenue_data.json`. Using another API
endpoint, the attacker can get the list of all hosted shop names. With a simple
script to manipulate the names in the list, replacing `{shopName}` in the URL,
the attacker gains access to the sales data of thousands of e-commerce stores.

Торговая онлайн платформа для онлайн магазинов предоставляет страницу с графиками доходов для каждого магазина размещенного на платформе. Злоумышленник, проанализировав отправляемые браузером запросы, может найти точки входа API предоставляющие даннные для графиков и определить формат запросов к ним `/shops/{shopName}/revenue_data.json`. Используя другую точку входа API, злоумышленник может получить список названий всех магазинов, размещенных на платформе. Используя простой скрипт, заменяющий `{shopName}` в URL запроса на названия магазинов, злоумышленник может получить доступ к данным о продажах тысяч онлайн магазинов.

### Сценарий #2

While monitoring the network traffic of a wearable device, the following HTTP
`PATCH` request gets the attention of an attacker due to the presence of a
custom HTTP request header `X-User-Id: 54796`. Replacing the `X-User-Id` value
with `54795`, the attacker receives a successful HTTP response, and is able to
modify other users' account data.

Злоумышленник анализирует сетевой трафик носимого устройства, и HTTP `PATCH` запрос, содержащий нестандартный HTTP заголовок `X-User-Id: 54796`, привлекает его внимание. Изменив значение заголовка `X-User-Id` на `54795`, злоумышленник получает ответ сервера, означающий успешную обработку запроса. Это означает, что злоумышленник может изменять данные учетных записей других пользователей.

## Как предотвратить

* Implement a proper authorization mechanism that relies on the user policies
  and hierarchy.
* Use an authorization mechanism to check if the logged-in user has access to
  perform the requested action on the record in every function that uses an
  input from the client to access a record in the database.
* Prefer to use random and unpredictable values as GUIDs for records’ IDs.
* Write tests to evaluate the authorization mechanism. Do not deploy vulnerable
  changes that break the tests.

* Надлежащим образом внедрить механизм авторизации, основывающийся на иерархии и политиках пользователей
* Использовать механизм авторизации для проверки того, что текущий аутентифицированный пользователь имеет право доступа к запрошенному действию над записью в базе данных в каждой функции, использующей пользовательский ввод для доступа к записи в базе данных.
* Использовать случайно сгенерированные значения, например, GUID в качестве идентификаторов записей в базе данных
* Использовать тесты проверяющие корреткность работы механизма авторизации. Не пропускать уязвимые изменения, которые не проходят тесты.

## Ссылки

### Внешние

* [CWE-284: Improper Access Control][1]
* [CWE-285: Improper Authorization][2]
* [CWE-639: Authorization Bypass Through User-Controlled Key][3]

[1]: https://cwe.mitre.org/data/definitions/284.html
[2]: https://cwe.mitre.org/data/definitions/285.html
[3]: https://cwe.mitre.org/data/definitions/639.html
