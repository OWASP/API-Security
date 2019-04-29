A3:2019 Improper Data Filtering
===============================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| -- | -- | -- |
| Access Lvl : Exploitability ? | Prevalence ? : Detectability ? | Technical ? : Business |
| Since API are used as data sources, many times while writing the APIs developers try to implement them in a very generic way, without thinking about the sensitivity of the exposed data. They rely on clients to perform the data filtering before showing it to the user. | | Frequently sensitive object properties are exposed such as those holding PII protected by law or regulation (e.g. GDPR), authentication data or meaningful resources relationships. |

## Is the API Vulnerable?

## Example Attack Scenarios

### Scenario #1

The mobile team uses the `/api/articles/{articleId}/comments/{commendId}`
endpoint in the articles view to render some comments metadata. Sniffing the
mobile app traffic an attacker finds out that other sensitive data is also
returned. The endpoint implementation uses a generic `toJSON()` method on the
`User` model to serialize the object.

### Scenario #2

An open source team chat solution provides the endpoint `/api/v1/users.list`
which supports two parameters: `query` and `fields`. Using a regular user
account and manipulating both parameters an attacker can enumerate `admin`
accounts, exposing sensitive information such as the password reset token: `GET
/api/v1/users.list?query={“roles”:{$in:“admin”}}&fields={“services.password.reset”:1, “username”:1”, “email.0”:1}`.
Via password reset, the attacker can takeover one of the `admin` accounts.

## How To Prevent

## References

### OWASP

### External
