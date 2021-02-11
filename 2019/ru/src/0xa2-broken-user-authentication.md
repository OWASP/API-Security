API2:2019 Некорректная Аутентификация Пользователей
====================================

| Источники угроз/Векторы атак | Недостатки безопасности | Последствия |
| - | - | - |
| Зависит от API : Сложность эксплуатации **3** | Распространненность **2** : Сложность обнаружения **2** | Технические последствия **3** : Зависит от бизнеса |
| Authentication in APIs is a complex and confusing mechanism. Software and security engineers might have misconceptions about what are the boundaries of authentication and how to implement it correctly. In addition, the authentication mechanism is an easy target for attackers, since it’s exposed to everyone. These two points makes the authentication component potentially vulnerable to many exploits. | There are two sub-issues: 1. Lack of protection mechanisms: APIs endpoints that are responsible for authentication must be treated differently from regular endpoints and implement extra layers of protection 2. Misimplementation of the mechanism: The mechanism is used / implemented without considering the attack vectors, or it’s the wrong use case (e.g., an authentication mechanism designed for IoT clients might not be the right choice for web applications). | Attackers can gain control to other users’ accounts in the system, read their personal data, and perform sensitive actions on their behalf, like money transactions and sending personal messages. |
| Аутентификация в API - сложный и запутанный механизм. Разработчики и инженеры безопасности могут иметь неверное представление о том, что входит в понятие аутентификации, и как внедрить ее правильно. Кроме того, механизм аутентификации - простая цель для злоумышленников, поскольку он общедоступен. Все это приводит к тому, что механизм аутентификации потенциально сожержит большое число уязвимостей. | Механизм аутентификации подвержен двум основным проблемам: 1. Отсутствие механизмов защиты: разработчики должны обращать особое внимание на точки входа API отвечающие за аутентификацию и внедрить дополнительные уровни защиты 2. Некорректная реализация механизма: механизм используется или реализован, не принимая во внимание основные векторы атак, или используется механизм не подходящий под текущую ситуацию (например, механизм аутентификации для IoT устройств не подходит для веб приложений). | Злоумышленник может получить контроль над учетными записями других пользователей в системе, получить доступ к их персональным данным, или осуществить критичные действия от их имени, например, отправить денежные переводы или персональные сообщения.|

## Как определить является ли API уязвимым?

Authentication endpoints and flows are assets that need to be protected. “Forgot
password / reset password” should be treated the same way as authentication
mechanisms.
Точки входа отвечающие за аутентификацию и процесс аутентификации - это активы требующие защиты. Необходимо относиться к функционалу восстановления пароля аналогично механизму аутентификации.

An API is vulnerable if it:
* Permits [credential stuffing][1] whereby the attacker has a list of valid
  usernames and passwords.
* Permits attackers to perform a brute force attack on the same user account, without
  presenting captcha/account lockout mechanism.
* Permits weak passwords.
* Sends sensitive authentication details, such as auth tokens and passwords in
  the URL.
* Doesn’t validate the authenticity of tokens.
* Accepts unsigned/weakly signed JWT tokens (`"alg":"none"`)/doesn’t
  validate their expiration date.
* Uses plain text, non-encrypted, or weakly hashed passwords.
* Uses weak encryption keys.

API уязвимо, если:
*  Позволяет [перебор учетных данных][1], при условии, что у злоумышленника есть списки валидных логинов и паролей.
* Позволяет злоумышленнику подбирать пароль к одной и той же учетной записи путем перебора, не требуя ввода CAPTCHA или не блокируя учетную запись.
* Допускает слабые пароли.
* Передает конфиденциальные аутентификационные данные в URL, например, аутентификационные токены или пароли.
* Не проверяет подлинность токенов.
* Не отклоняет JWT токены без подписи или использующие уязвимые алгоритмы подписи (`"alg":"none"`), не проверяет срок действия токена. 
* Хранит пароли в открытом виде или в хэшированном виде с использованием слабых алгоритомов хэширования.
* Использует слабые ключи шифрования.

## Примеры сценариев атаки

## Сценарий #1

[Credential stuffing][1] (using [lists of known usernames/passwords][2]), is a
common attack. If an application does not implement automated threat or
credential stuffing protections, the application can be used as a password
oracle (tester) to determine if the credentials are valid.

[Перебор учетных данных][1] с использованием [списка известных логинов и паролей][2] - распространенная атака. Если в приложении отсутствуют автоматизированные меры защиты от угроз или перебора учетных данных, то оно может быть использовано для определения валидности учетных данных.

## Сценарий #2

An attacker starts the password recovery workflow by issuing a POST request to
`/api/system/verification-codes` and by providing the username in the request
body. Next an SMS token with 6 digits is sent to the victim’s phone. Because the
API does not implement a rate limiting policy, the attacker can test all
possible combinations using a multi-threaded script, against the
`/api/system/verification-codes/{smsToken}` endpoint to discover the right token
within a few minutes.

Злоумышленник начинет восстановление пароля, отправляя POST запрос в точку входа `/api/system/verification-codes` и указывая имя пользователя в теле запроса. Затем одноразовый пароль из 6 цифр отправляется на телефон жертвы. Поскольку API не ограничивает количество запросов, злоумышленник может за несколько минут подобрать корректный одноразовый пароль, перебирая все возможные пароли с помощью скрипта, работающего в мультипоточном режиме и отправляющего запросы на `/api/system/verification-codes/{smsToken}`.

## Как предотвратить?

* Make sure you know all the possible flows to authenticate to the API (mobile/
  web/deep links that implement one-click authentication/etc.)
* Ask your engineers what flows you missed.
* Read about your authentication mechanisms. Make sure you understand what and
  how they are used. OAuth is not authentication, and neither is API keys.
* Don't reinvent the wheel in authentication, token generation, password
  storage. Use the standards.
* Credential recovery/forget password endpoints should be treated as login
  endpoints in terms of brute force, rate limiting, and lockout protections.
* Use the [OWASP Authentication Cheatsheet][3].
* Where possible, implement multi-factor authentication.
* Implement anti brute force mechanisms to mitigate credential stuffing,
  dictionary attack, and brute force attacks on your authentication endpoints.
  This mechanism should be stricter than the regular rate limiting mechanism on
  your API.
* Implement [account lockout][4] / captcha mechanism to prevent brute force
  against specific users. Implement weak-password checks.
* API keys should not be used for user authentication, but for [client app/
  project authentication][5].

* Идентифицируйте все возможные способы аутентификации в API (для мобильных и веб клиентов, deep links обеспечивающие аутентификацию в одно нажатие и так далее).
* Обсудите с разработчиками способы аутентификации, которые вы пропустили.
* Изучите используемые механизмы аутентификации. Изучите что они из себя представляют и как используются. OAuth не используется для аутентификации пользователей, так же как и API ключи.
* Не изобратайте велосипед, когда речь идет об аутентификации, генерации токенов и хранении паролей. Используйте стандарты.
* Внедрите защиту от перебора, ограничение на количество единовременных запросов и временную блокировку учетных записей на точках входа, отвечающих за восстановление учетных данных и пароля, аналогично мерам защиты реализованным на точках входа, используемых для аутентификации.
* Ознакомьтесь с [OWASP Authentication Cheatsheet][3].
* Используйте многофакторную аутентификации, где это возможно.
* Используйте механизмы защиты от перебора учетных данных, перебора по словарю и перебора всех возможных значений на точках входа, отвечающих за аутентификацию. Эти механизмы должны быть использовать более строгие правила по сравнению с механизмом ограничивающим количество запросов в остальных точках входа API.
* Внедрите [блокировку учетных записей][4] или CAPTCHA для предотвращения перебора аутентификационных данных, направленного на единичных пользователей. Внедрите защиту от слабых паролей.
* Не используйте API ключи для аутентификации пользователей. Они должны использоваться для [аутентификации приложений и проектов, являющихся клиентами API][5].

## Ссылки

### OWASP

* [OWASP Key Management Cheat Sheet][6]
* [OWASP Authentication Cheatsheet][3]
* [Credential Stuffing][1]

### Внешние

* [CWE-798: Use of Hard-coded Credentials][7]

[1]: https://www.owasp.org/index.php/Credential_stuffing
[2]: https://github.com/danielmiessler/SecLists
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[4]: https://www.owasp.org/index.php/Testing_for_Weak_lock_out_mechanism_(OTG-AUTHN-003)
[5]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[6]: https://www.owasp.org/index.php/Key_Management_Cheat_Sheet
[7]: https://cwe.mitre.org/data/definitions/798.html
