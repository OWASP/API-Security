A3:2019 Improper Data Filtering
===============================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| -- | -- | -- |
| Access Lvl : Exploitability ? | Prevalence ? : Detectability ? | Technical ? : Business |
| Since API are used as data sources, many times while writing the APIs developers try to implement them in a very generic way, without thinking about the sensitivity of the exposed data. They rely on clients to perform the data filtering before showing it to the user. | | Frequently sensitive object properties are exposed such as those holding PII protected by law or regulation (e.g. GDPR), authentication data or meaningful resources relationships. |

## Is the API Vulnerable?

## Example Attack Scenarios

### Scenario #1

The User model implements a toJSON() method to serialize a user object as JSON.
While implementing the `GET /v1/articles/{article_id}/comments/{comment_id}`
endpoint that returns details about a specific comment in an article and basic
details about its author, the developer finds the toJSON() method and decides to
use it (without thinking about the sensitive details it may expose). The mobile
team is using the endpoint in the articles view, rendering only relevant data.
An attacker sniffs the mobile app traffic and finds about the sensitive data
exposure.

### Scenario #2

## How To Prevent

## References

### OWASP

### External
