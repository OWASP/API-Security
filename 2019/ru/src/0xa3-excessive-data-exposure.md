API3:2019 Excessive Data Exposure
=================================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| - | - | - |
| API Specific : Exploitability **3** | Prevalence **2** : Detectability **2** | Technical **2** : Business Specific |
| Exploitation of Excessive Data Exposure is simple, and is usually performed by sniffing the traffic to analyze the API responses, looking for sensitive data exposure that should not be returned to the user. | APIs rely on clients to perform the data filtering. Since APIs are used as data sources, sometimes developers try to implement them in a generic way without thinking about the sensitivity of the exposed data. Automatic tools usually can’t detect this type of vulnerability because it’s hard to differentiate between legitimate data returned from the API, and sensitive data that should not be returned without a deep understanding of the application. | Excessive Data Exposure commonly leads to exposure of sensitive data. |

## Is the API Vulnerable?

The API returns sensitive data to the client by design. This data is usually
filtered on the client side before being presented to the user. An attacker can
easily sniff the traffic and see the sensitive data.

## Example Attack Scenarios

### Scenario #1

The mobile team uses the `/api/articles/{articleId}/comments/{commentId}`
endpoint in the articles view to render comments metadata. Sniffing the mobile
application traffic, an attacker finds out that other sensitive data related to
comment’s author is also returned. The endpoint implementation uses a generic
`toJSON()` method on the `User` model, which contains PII, to serialize the
object.

### Scenario #2

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

## How To Prevent

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


## References

### External

* [CWE-213: Intentional Information Exposure][1]

[1]: https://cwe.mitre.org/data/definitions/213.html
