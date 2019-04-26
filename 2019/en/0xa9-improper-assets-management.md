A9:2019 Improper Assets Management
==================================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| -- | -- | -- |
| Access Lvl : Exploitability ? | Prevalence ? : Detectability ? | Technical ? : Business |
| | | |

## Is the API Vulnerable?

## Example Attack Scenarios

### Scenario #1

After redesigning their apps, a local search service left an old API version
running, unprotected and with access to the user database
(`api.someservice.com/v1`). While targeting one of the latest released apps an
attacker got the API address (`api.someservice.com/v2`). Replacing `v2` by `v1`
in the url gave the attacker access to the old and unprotected API, exposing
over 100 Million user’s personal identifiable information (PII).

## How To Prevent

## References

### OWASP

### External

