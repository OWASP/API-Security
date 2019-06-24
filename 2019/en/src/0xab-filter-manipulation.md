A11:2019 Filter Manipulation
============================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| - | - | - |
| API Specific : Exploitability **3** | Prevalence **2** : Detectability **2** | Technical **2** : Business Specific |
| Exploitation of Filter Manipulation is usually done by using different clients while sniffing the traffic they produce to analyze the API responses. API requests are then replayed with common values for each filter (e.g. replacing `{"role": "user"}` by `{"role":"admin"}`) | APIs rely on clients to perform the data filtering. Since APIs are used as data sources, sometimes developers try to implement them in a generic way leaving the door open to unauthorized data access through filter manipulation. | Filter Manipulation usually leads to sensitive data exposure. |

## Is the API Vulnerable?

The API performs data filtering in an unsafe manner based on filters from the
client. An attacker can send malicious filters causing the API to return
sensitive data they should not be exposed to.

The API might be vulnerable if:

* Accepts any object property as filter (unless this is a business
  requirement).
* Does not maintain a whitelist of allowed values for each filter.
* Accepts wildcards (e.g. `{"role":"*"}`) as filter.
* API clients are allowed to select what object properties should be included in
  the API server response.

## Example Attack Scenarios

### Scenario #1

An open source team chat solution provides the endpoint `/api/v1/users.list`
which supports two parameters: `query` and `fields`. Using a regular user
account and manipulating the `query` parameter an attacker can enumerate admin
accounts:

```
GET /api/v1/users.list?query={“roles”:{$in:“admin”}}&fields={“username”:1”, “email.0”:1}
```

### Scenario #2

An open source team chat solution provides the endpoint `/api/v1/users.list`
which supports two parameters: `query` and `fields`. Using a regular user
account and manipulating the `fields` parameters an attacker can expose
sensitive information such as password reset tokens:

```
GET /api/v1/users.list?query={“roles”:“user”}&fields={“services.password.reset”:1, “username”:1”, “email.0”:1}
```

Via password reset, the attacker can takeover other users accounts.

## How To Prevent

* Be careful when performing data filtering based on filters from the client.
* Validate that API client is authorized to filter data based on given object
  properties.
* Whenever possible validate given filter values against a whitelist of allowed
  values.
* Avoid using wildcards (e.g. `{"role":"*"}`) as data filter
* Whenever the client should be able to select what object properties should be
  included in the API server response, keep a whitelist of such allowed object
  properties.

## References

### OWASP

### External
