API5:2019 Некорректная Авторизация на Уровне Функций
=============================================

| Источники угроз/Векторы атак | Недостатки безопасности | Последствия |
| - | - | - |
| Зависит от API : Сложность эксплуатации **3** | Распространненность **2** : Сложность обнаружения **1** | Технические последствия **2** : Зависит от бизнеса |
| Exploitation requires the attacker to send legitimate API calls to the API endpoint that they should not have access to. These endpoints might be exposed to anonymous users or regular, non-privileged users. It’s easier to discover these flaws in APIs since APIs are more structured, and the way to access certain functions is more predictable (e.g., replacing the HTTP method from GET to PUT, or changing the “users” string in the URL to "admins"). | Authorization checks for a function or resource are usually managed via configuration, and sometimes at the code level. Implementing proper checks can be a confusing task, since modern applications can contain many types of roles or groups and complex user hierarchy (e.g., sub-users, users with more than one role). | Such flaws allow attackers to access unauthorized functionality. Administrative functions are key targets for this type of attack. |

| Эксплуатация уязвимости предполагает, что злоумышленник может успешно отправить запросы в точки входа API, к которым у него не должно быть доступа. Эти точки входа могут быть доступны любому неаутентифицированному пользователю или аутентифицированному пользователю, не имеющему достаточных привилегий. Подобную ошибку легче обнаружить в API (по сравнению с традиционными приложениями), поскольку API более структурированы, а порядок доступа к определенным функциям более предсказуем (например, изменив метод HTTP запроса с GET на PUT, или изменив строку “users” в URL запроса на "admins"). | Проверки авторизации функции или ресурса обычно определяются на уровне конфигурации, иногда на уровне кода. Проведение проверок надлежащим образом - непростая и неоднозначная задача, поскольку современные приложения могут использовать много типов ролей и групп, а также иметь сложную иерархию пользователей (например, под-пользователи или пользователи с несколькими ролями). | Подобные ошибки позволяют злоумышленнику получить доступ к функционалу, минуя авторизацию. Административный функционал - ключевая цель атак этого типа. |

## Как определить является ли API уязвимым?

The best way to find broken function level authorization issues is to perform
deep analysis of the authorization mechanism, while keeping in mind the user
hierarchy, different roles or groups in the application, and asking the
following questions:
Лучший способ найти проблемы с некорректной авторизацией на уровне объектов - провести глубокий анализ механизма авторизации, учитывая иерархию пользователей, различные роли и группы внутри приложения, а также задав себе следующие вопросы:

* Can a regular user access administrative endpoints?
* Can a user perform sensitive actions (e.g., creation, modification, or
  erasure) that they should not have access to by simply changing the HTTP
  method (e.g., from `GET` to `DELETE`)?
* Can a user from group X access a function that should be exposed only to users
  from group Y, by simply guessing the endpoint URL and parameters (e.g.,
  `/api/v1/users/export_all`)?

* Может ли обычный пользователь получить доступ к административным точкам входа?
* Может ли пользователь совершить критичные действия (например, создать. изменить или удалить объект), к которым у него не должно быть доступа, просто изменив метод HTTP запроса (например, с `GET` на `DELETE`)?
* Может ли пользователь из группы Х получить доступ к точке входа, доступной только пользователям из группы Y, просто угадав URL и параметры этой точки входа (например,  `/api/v1/users/export_all`)?

Don’t assume that an API endpoint is regular or administrative only based on the
URL path.

While developers might choose to expose most of the administrative endpoints
under a specific relative path, like `api/admins`, it’s very common to find
these administrative endpoints under other relative paths together with regular
endpoints, like `api/users`.

Неверно предполагать, что точка входа API является обычной или административной только на основании пути URL.

Зачастую разработчики открывают доступ к административным точкам входа по определенному относительному пути, например, `api/admins`. Однако очень часто административные точки входа находятся по другим относительным путям вместе с обычными точками входа, например, `api/users`.

## Примеры сценариев атаки

## Сценарий #1

During the registration process to an application that allows only invited users
to join, the mobile application triggers an API call to
`GET /api/invites/{invite_guid}`. The response contains a JSON with details
about the invite, including the user’s role and the user’s email.

В ходе процесса регистрации в приложении, которое позволяет регистрироваться только приглашенным пользователям, мобильное приложение отправляет следующий запрос к API `GET /api/invites/{invite_guid}`. Ответ содержит JSON с деталями приглашения, включая роль пользователя и его электронную почту.

An attacker duplicated the request and manipulated the HTTP method and endpoint
to `POST /api/invites/new`. This endpoint should only be accessed by
administrators using the admin console, which does not implement function level
authorization checks.

The attacker exploits the issue and sends himself an invite to create an
admin account:

Злоумышленник может дублировать запрос, изменив HTTP метод и точку входа на `POST /api/invites/new`. Только администраторы должны иметь доступ к этой точке входа через интерфейс администрирования, однако он не проводит проверки авторизации на уровне функций.

Проэксплуатировав уязвимость, злоумышленник может отправить себе приглашение с ролью администратора:

```
POST /api/invites/new

{“email”:”hugo@malicious.com”,”role”:”admin”}
```

### Сценарий #2

An API contains an endpoint that should be exposed only to administrators -
`GET /api/admin/v1/users/all`. This endpoint returns the details of all the
users of the application and does not implement function-level authorization
checks. An attacker who learned the API structure takes an educated guess and
manages to access this endpoint, which exposes sensitive details of the users of
the application.

API содержит точку входа, которая должна быть доступна только администраторам `GET /api/admin/v1/users/all`. Эта точка входа возвращает данные всех пользователей и не проводит проверки авторизации на уровне функции. Злоумышленник, изучив структуру API, подбирает URL и получает доступ к точке входа, которая возвращает критичные данные пользователей приложения.

## Как предотвратить

Your application should have a consistent and easy to analyze authorization
module that is invoked from all your business functions. Frequently, such
protection is provided by one or more components external to the application
code.

В вашем приложении должен быть согласованный и легко анализируемый модуль авторизации, вызываемый всеми бизнес функциями. Зачастую такая защита предоставляется одной или несколькими компонентами вне кода приложения.

* The enforcement mechanism(s) should deny all access by default, requiring
  explicit grants to specific roles for access to every function.
* Review your API endpoints against function level authorization flaws, while
  keeping in mind the business logic of the application and groups hierarchy.
* Make sure that all of your administrative controllers inherit from an
  administrative abstract controller that implements authorization checks based
  on the user’s group/role.
* Make sure that administrative functions inside a regular controller implements
  authorization checks based on the user’s group and role.

* Механизм обеспечивающий выполнение проверок авторизации должен запрещать весь доступ по умолчанию и требовать наличия определенных ролей для доступа к каждой из функций.
* Проверьте все точки входа API на предмет некорректной авторизации на уровне функций, принимая во внимание бизнес логику приложения и иерархию групп.
* Убедитесь, что все административные контроллеры наследуют абстрактный административный контроллер, в котором реализованы проверки авторизации на базе пользовательских групп и ролей.
* Убедитесь, что административные функции внутри обычных контроллеров, проводят проверки авторизации на базе пользовательских групп и ролей.

## Ссылки

### OWASP

* [OWASP Article on Forced Browsing][1]
* [OWASP Top 10 2013-A7-Missing Function Level Access Control][2]
* [OWASP Development Guide: Chapter on Authorization][3]

### Внешние

* [CWE-285: Improper Authorization][4]

[1]: https://www.owasp.org/index.php/Forced_browsing
[2]: https://www.owasp.org/index.php/Top_10_2013-A7-Missing_Function_Level_Access_Control
[3]: https://www.owasp.org/index.php/Category:Access_Control
[4]: https://cwe.mitre.org/data/definitions/285.html
