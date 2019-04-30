A7:2019 Security Misconfiguration
=================================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| -- | -- | -- |
| Access Lvl : Exploitability ? | Prevalence ? : Detectability ? | Technical ? : Business |
| | | |

## Is the API Vulnerable?

## Example Attack Scenarios

### Scenario #1

An attacker finds .bash_history file under the root of the server which has in
its content commands used by DevOps to access the API:
`$ curl -X GET 'https://api.server/endpoint/' -H 'authorization: Basic Zm9vOmJhcg=='`.
An attacker could also find new endpoints on the API that are not documented and
used only by DevOps.

### Scenario #2

To target a specific service, an attacker searches the API hostname on a popular
search engine of computers directly accessible from the Internet. A popular
database management system was running in such host, listening on the default
port. Because the default configuration has authentication disabled by default
and it was kept unchanged the attacker had access to millions of records with
PII, personal preferences and authentication data.

## How To Prevent

## References

### OWASP

### External
