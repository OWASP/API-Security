A4:2019 Improper Resources Limiting or Throttling
=================================================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| -- | -- | -- |
| Access Lvl : Exploitability ? | Prevalence ? : Detectability ? | Technical ? : Business |
| | | |

## Is the API Vulnerable?

## Example Attack Scenarios

### Scenario #1

### Scenario #2

An attacker starts the password recovery workflow, issuing a `POST` request to
`/api/system/verification-codes`, providing the `username` in the request body.
An SMS token with 6 digits is sent to the victim’s phone. Because the API does
not implement a rate limiting policy, with a multi-threat script, the attacker
can test all possible combinations against the
`/api/system/verification-codes/[SMS-TOKEN]` endpoint, discovering the right
token in a few minutes.

## How To Prevent

## References

### OWASP

### External
