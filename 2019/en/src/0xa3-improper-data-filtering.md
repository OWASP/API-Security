A3:2019 Improper Data Filtering
===============================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| - | - | - |
| API Specific : Exploitability **3** | Prevalence **2** : Detectability **2** | Technical **2** : Business Specific |
| Exploitation of improper data filtering is simple, and is usually done by using different clients while sniffing the traffic they produce to analyze the API responses and look for sensitive data exposure that should not be returned to the user. | APIs rely on clients to perform the data filtering. Since APIs are used as data sources, sometimes developers try to implement them in a generic way without thinking about the sensitivity of the exposed data. Automatic tools usually can’t detect this type of vulnerability because it’s hard to differentiate between legitimate data returned from the API and sensitive data that should not be returned without a deep understanding of the application. | Improper Data Filtering commonly leads to exposure of sensitive data. |

## Is the API Vulnerable?

There are two types of Improper Data Filtering:

* **Client Side Data Filtering**: The API returns sensitive data to the client
  by design. This data is usually filtered on the client side before being
  presented to the user. An attacker can easily sniff the traffic and see the
  sensitive data.
* **Filter Manipulation**: the API performs data filtering in an unsafe manner
  based on filters from the client. An attacker can send malicious filters
  causing the API to return sensitive data they should not be exposed to.

One more issue is Improper Query String Parameters validation. It could lead to
DDoS attacks against the server. Widely spread problem is validation of such
query string parameters as `size`, `page`, .etc. Absence of limitation for max,
min values of these parameters might cause performance issues, Internal Server
Errors

## Example Attack Scenarios

### Scenario #1

The mobile team uses the `/api/articles/{articleId}/comments/{commentId}`
endpoint in the articles view to render comments metadata. Sniffing the mobile
application traffic an attacker finds out that other sensitive data related to
comment’s author, is also returned. The endpoint implementation uses a generic
`toJSON()` method on the `User` model, which contains PII, to serialize the
object.

### Scenario #2

An open source team chat solution provides the endpoint `/api/v1/users.list`
which supports two parameters: `query` and `fields`. Using a regular user
account and manipulating both parameters an attacker can enumerate admin
accounts, exposing sensitive information such as the password reset token:
`GET /api/v1/users.list?query={“roles”:{$in:“admin”}}&fields={“services.password.reset”:1, “username”:1”, “email.0”:1}`.
Via password reset, the attacker can takeover one of the admin accounts.

### Scenario #3

We have a MEAN stack application that contains the users list on a UI. List of
users can be retrieved from the server using a following query:
`/dashboard/users?page=1&size=100`. There are limitation on maximum number of
users per page (on UI side) - 200 users. An attacker changes the size parameter
in order to retrieve large number of users, for example 200 000 or more and it
causes performance issues. The same scenario might be used to provoke `Integer Overflow`
or `Buffer Overflow` errors.

## How To Prevent

* Never rely on the client side to perform sensitive data filtering.
* Review the responses from the API to make sure they contain only legitimate
  data.
* Be careful when performing data filtering based on filters from the client.
* Add proper validation for query string parameters and request body on the server
  side.

## References

### OWASP

### External
