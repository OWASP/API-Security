A2:2019 Broken Authentication
=============================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| -- | -- | -- |
| Access Lvl : Exploitability ? | Prevalence ? : Detectability ? | Technical ? : Business |
| | | |

## Is the API Vulnerable?

## Example Attack Scenarios

## Scenario #1

An attacker using brute-force to find hidden directories, finds a specific
endpoint called `/backoffice` with hardcoded credentials. When accessing this
specific endpoint it would automatically call the API admin which provides the
attacker with all the endpoints, logged in user tokens, load balancer
configurations and much more.

## Scenario #2

An attacker with access to a cloud-based team collaboration tool creates a
private channel with himself in it. Then he starts a call, sharing it in the
private channel: the HTTP request is recorded for later use. Two different users
start a call on a different channel. The attacker grabs the channel id,
replacing it in the previously captured HTTP request. Resending the request
enables attacker to eavesdrop the private call.

## How To Prevent

## References

### OWASP

### External
