A9:2019 Improper Assets Management
==================================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| - | - | - |
| API Specific : Exploitability **3** | Prevalence **3** : Detectability **2** | Technical **2** : Business Specific |
| Old API versions are usually unpatched and are an easy way to compromise systems without having to fight state of the art security mechanisms that might be in place to protect the most recent API versions. | Outdated documentation makes it more difficult to find and/or fix vulnerabilities. Lack of assets inventory and retire strategies leads to running unpatched systems and leakage of sensitive data. | Attackers may gain access to sensitive data or even takeover the server through old, unpatched API versions connected to the same database. |

## Is the API Vulnerable?

The API is vulnerable if:

* There is no documentation or the existing documentation is not updated.
* There is no retirement plan for each API version.
* Hosts inventory is missing or outdated.
* Old or previous API versions are running unpatched.

## Example Attack Scenarios

### Scenario #1

After redesigning their applications, a local search service left an old API
version (`api.someservice.com/v1`) running, unprotected and with access to the
user database. While targeting one of the latest released applications an
attacker got the API address (`api.someservice.com/v2`). Replacing `v2` with
`v1` in the URL gave the attacker access to the old and unprotected API,
exposing the personal identifiable information (PII) of over 100 Million user.

## How To Prevent

* Document all aspects of your API such as authentication, errors, redirects,
  rate limiting, cross-origin resource sharing (CORS) policy and endpoints,
  including their parameters, requests and responses.
* Include documentation of your code review practice.
* Generate documentation automatically by adopting open standards. Include the
  documentation build in your CI/CD pipeline.
* Make API documentation generally available.

## References

### OWASP

### External

* [CWE-1059: Incomplete Documentation][1]
* [OpenAPI Initiative][2]

[1]: https://cwe.mitre.org/data/definitions/1059.html
[2]: https://www.openapis.org/
