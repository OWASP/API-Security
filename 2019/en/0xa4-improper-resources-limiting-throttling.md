A4:2019 Improper Resources Limiting or Throttling
=================================================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| -- | -- | -- |
| Access Lvl : Exploitability ? | Prevalence ? : Detectability ? | Technical ? : Business |
| | | |

## Is the API Vulnerable?

## Example Attack Scenarios

### Scenario #1

An attacker uploads a large image, issuing a `POST` request to `/api/v1/images`.
When the upload is complete, the API creates multiple thumbnails with different
sizes. Due to the size of the uploaded image, available memory is exhausted
during the thumbnails creation and the API becomes unresponsive.

### Scenario #2

An attacker starts the password recovery workflow, issuing a `POST` request to
`/api/system/verification-codes`, providing the `username` in the request body.
An SMS token with 6 digits is sent to the victim’s phone. Because the API does
not implement a rate limiting policy, with a multi-threat script, the attacker
can test all possible combinations against the
`/api/system/verification-codes/{smsToken}` endpoint, discovering the right
token in a few minutes.

## How To Prevent

## References

### OWASP

### External
