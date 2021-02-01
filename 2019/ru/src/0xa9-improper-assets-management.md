API9:2019 Improper Assets Management
====================================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| - | - | - |
| API Specific : Exploitability **3** | Prevalence **3** : Detectability **2** | Technical **2** : Business Specific |
| Old API versions are usually unpatched and are an easy way to compromise systems without having to fight state-of-the-art security mechanisms, which might be in place to protect the most recent API versions. | Outdated documentation makes it more difficult to find and/or fix vulnerabilities. Lack of assets inventory and retire strategies leads to running unpatched systems, resulting in leakage of sensitive data. It’s common to find unnecessarily exposed API hosts because of modern concepts like microservices, which make applications easy to deploy and independent (e.g., cloud computing, k8s). | Attackers may gain access to sensitive data, or even takeover the server through old, unpatched API versions connected to the same database. |

## Is the API Vulnerable?

The API might be vulnerable if:

* The purpose of an API host is unclear, and there are no explicit answers to
  the following questions:
  * Which environment is the API running in (e.g., production, staging, test,
    development)?
  * Who should have network access to the API (e.g., public, internal, partners)?
  * Which API version is running?
  * What data is gathered and processed by the API (e.g., PII)?
  * What's the data flow?
* There is no documentation, or the existing documentation is not updated.
* There is no retirement plan for each API version.
* Hosts inventory is missing or outdated.
* Integrated services inventory, either first- or third-party, is missing or
  outdated.
* Old or previous API versions are running unpatched.

## Example Attack Scenarios

### Scenario #1

After redesigning their applications, a local search service left an old API
version (`api.someservice.com/v1`) running, unprotected, and with access to the
user database. While targeting one of the latest released applications, an
attacker found the API address (`api.someservice.com/v2`). Replacing `v2` with
`v1` in the URL gave the attacker access to the old, unprotected API,
exposing the personal identifiable information (PII) of over 100 Million users.

### Scenario #2

A social network implemented a rate-limiting mechanism that blocks attackers
from using brute-force to guess reset password tokens. This mechanism wasn’t
implemented as part of the API code itself, but in a separate component between
the client and the official API (`www.socialnetwork.com`).
A researcher found a beta API host (`www.mbasic.beta.socialnetwork.com`) that
runs the same API, including the reset password mechanism, but the rate limiting
mechanism was not in place. The researcher was able to reset the password of any
user by using a simple brute-force to guess the 6 digits token.

## How To Prevent

* Inventory all API hosts and document important aspects of each one of them,
  focusing on the API environment (e.g., production, staging, test,
  development), who should have network access to the host (e.g., public,
  internal, partners) and the API version.
* Inventory integrated services and document important aspects such as their
  role in the system, what data is exchanged (data flow), and its sensitivity.
* Document all aspects of your API such as authentication, errors, redirects,
  rate limiting, cross-origin resource sharing (CORS) policy and endpoints,
  including their parameters, requests, and responses.
* Generate documentation automatically by adopting open standards. Include the
  documentation build in your CI/CD pipeline.
* Make API documentation available to those authorized to use the API.
* Use external protection measures such as API security firewalls for all exposed versions of your APIs, not just for the current production version.
* Avoid using production data with non-production API deployments. If this is unavoidable, these endpoints should get the same security treatment as the production ones.
* When newer versions of APIs include security improvements, perform risk analysis to make the decision of the mitigation actions required for the older version: for example, whether it is possible to backport the improvements without breaking API compatibility or you need to take the older version out quickly and force all clients to move to the latest version.

## References

### External

* [CWE-1059: Incomplete Documentation][1]
* [OpenAPI Initiative][2]

[1]: https://cwe.mitre.org/data/definitions/1059.html
[2]: https://www.openapis.org/
