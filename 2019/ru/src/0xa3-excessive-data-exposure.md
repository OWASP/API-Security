API3:2019 Предоставление Излишних Данных
=================================

| Источники угроз/Векторы атак | Недостатки безопасности | Последствия |
| - | - | - |
| Зависит от API : Сложность эксплуатации **3** | Распространненность **2** : Сложность обнаружения **2** | Технические последствия **2** : Зависит от бизнеса |
| Exploitation of Excessive Data Exposure is simple, and is usually performed by sniffing the traffic to analyze the API responses, looking for sensitive data exposure that should not be returned to the user. | APIs rely on clients to perform the data filtering. Since APIs are used as data sources, sometimes developers try to implement them in a generic way without thinking about the sensitivity of the exposed data. Automatic tools usually can’t detect this type of vulnerability because it’s hard to differentiate between legitimate data returned from the API, and sensitive data that should not be returned without a deep understanding of the application. | Excessive Data Exposure commonly leads to exposure of sensitive data. |

Предоставление Излишних Данных легко эксплуатировать. Для этого нужно перехватить трафик и проанализировать ответы API на предмет конфиденциальных данных, которые API не должно возвращать пользователю. | API рассчитывает, что клиентское приложение отфильтрует данные отображаемые пользователю. Поскольку API используются в качестве источников данных, иногда разработчики пытаются сделать его общим для всех клиентов, не думая о конфиденциальности данных возвращаемых пользователю. Автоматизированные инструменты зачастую не обнаруживают эту уязвимость, поскольку без детального понимания логики приложения очень трудно определить должно ли API возвращать те или иные данные. | Предоставление Излишних Данных обычно приводит к разглашению конфиденциальных данных. |

## Как определить является ли API уязвимым?

The API returns sensitive data to the client by design. This data is usually
filtered on the client side before being presented to the user. An attacker can
easily sniff the traffic and see the sensitive data.

Если API спроектировано так, что возвращает конфиденциальные данные клиенсткому приложению, которое в свою очередь фильтрует их перед отображением пользователю. Злоумышленник с легкостью может перехватить трафик и увидеть конфиденциальные данные.

## Примеры сценариев атаки

## Сценарий #1

The mobile team uses the `/api/articles/{articleId}/comments/{commentId}`
endpoint in the articles view to render comments metadata. Sniffing the mobile
application traffic, an attacker finds out that other sensitive data related to
comment’s author is also returned. The endpoint implementation uses a generic
`toJSON()` method on the `User` model, which contains PII, to serialize the
object.

Команда мобильного приложения использует точку входа `/api/articles/{articleId}/comments/{commentId}` для отображения метаданных комментариев в представлении статей. Злоумышленник перехватывает трафик от мобильного приложения и находит в ответе дополнительные конфиденциальные данные об авторе комментария. Точка входа реализована так, что использует стандартный метод `toJSON()` на объекте модели `User`, содержащем персональные данные, для сериализации этого объекта.


### Сценарий #2

An IOT-based surveillance system allows administrators to create users with
different permissions. An admin created a user account for a new security guard
that should only have access to specific buildings on the site. Once the
security guard uses his mobile app, an API call is triggered to:
`/api/sites/111/cameras` in order to receive data about the available cameras
and show them on the dashboard. The response contains a list with details about
cameras in the following format:
`{"id":"xxx","live_access_token":"xxxx-bbbbb","building_id":"yyy"}`.
While the client GUI shows only cameras which the security guard should have
access to, the actual API response contains a full list of all the cameras in
the site.

Система видео наблюдения базирующаяся на IOT позволяет администраторам создавать пользователей с различными привилегиями. Администратор создал учетную запись для нового охранника, которая должна иметь доступ только к определенным зданиям на объекте. Когда охранник использует мобильное приложение, оно отправляет запрос в точку входа `/api/sites/111/cameras`, чтобы получить данные о доступных камерах и отобразить их на панели управления. Ответ API содержит список данных о камерах в следующем формате: `{"id":"xxx","live_access_token":"xxxx-bbbbb","building_id":"yyy"}`. Клиентское приложение показывает только те камеры, к которым охранник имеет доступ, однако ответ API содержит полный список камер на объекте.

## Как предотвратить

* Never rely on the client side to filter sensitive data.
* Review the responses from the API to make sure they contain only legitimate
  data.
* Backend engineers should always ask themselves "who is the
  consumer of the data?" before exposing a new API endpoint.
* Avoid using generic methods such as `to_json()` and `to_string()`.
  Instead, cherry-pick specific properties you really want to return
* Classify sensitive and personally identifiable information (PII) that
  your application stores and works with, reviewing all API calls returning such
  information to see if these responses pose a security issue.
* Implement a schema-based response validation mechanism as an extra layer of
  security. As part of this mechanism define and enforce data returned by all
  API methods, including errors.

* Не рассчитывайте, что клиентское приложение отфильтрует данные.
* Проверьте, что ответы API содержат только те данные, которые отображаются клиентским приложением.
* Разработчики серверной части должны всегда задаваться вопросом "Кто получит данные?" перед публикацией новых точек входа API.
* Избегайте использования стандартных методов, например, `to_json()` или `to_string()`. Вместо этого вручную выбирайте свойства объектов, которые вы возвращаете в ответе.
* Классифицируйте критичную информацию и персональные данные, с которыми работает приложение, путем анализа всех вызовов API, возвращающих подобные данные, чтобы определить несут ли эти ответы риски безопасности.
* Внедрите механизм валидации базирующийся на проверке данных по схеме в качестве дополнительного уровня защиты. В рамках этого механизма определите данные возвращаемые каждой точкой входа (в том числе в ошибках) и обеспечьте, что только эти данные возвращаются пользователю.

## Ссылки

### Внешние

* [CWE-213: Intentional Information Exposure][1]

[1]: https://cwe.mitre.org/data/definitions/213.html
