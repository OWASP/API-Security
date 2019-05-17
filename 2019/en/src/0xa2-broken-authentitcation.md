A2:2019 Broken Authentication
=============================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| - | - | - |
| API Specific : Exploitability **3** | Prevalence **2** : Detectability **2** | Technical **3** : Business Specific |
| Keys are the most popular API authentication mechanism but managing them correctly is not an easy task. Attackers have automatic tools to search for API keys on public repositories or mobile applications. | When authentication is based simply on keys, once the attacker gets access to valid tokens they can perform legitimate API requests. Although access can be logged and monitored, the ability to investigate and identify malicious activity is not a simple task. | The impact greatly depends on access tokens grants and can range from the exposure of sensitive data for a single user to full data access or even control over multiple systems and services. |

## Is the API Vulnerable?

The API is vulnerable if:

* Authentication only relies on access tokens.
* The same access token is valid for multiple APIs or API versions.
* Access tokens are tracked together with the source code on a version control
  system or hard-coded in the client.


## Example Attack Scenarios

## Scenario #1

A mobile application adds smartphone-controlled geolocation, remote start/stop
and lock/unlock capabilities to a vehicle with a compatible remote start unit.
By reverse engineering the mobile application an attacker finds hard-coded admin
credentials which can be used in place of a user's username and password to
communicate with the server endpoint for a target user's account. With these
credentials the attacker can learn the location of a target as well as gain
unauthorized control over the car.

## Scenario #2

A company uses private repositories on a web-based hosting service for version
control. Access tokens to their internal APIs as well as cloud services are
tracked together with the source code and an attacker targeting this company
gains control over the private repository. Using the exposed access tokens the
attacker not only gets access to sensitive data but also control over some
services.

## How To Prevent

* APIs that have access to sensitive data should use an additional form of
  authentication in addition to API keys.
* API keys should have restrictions both for the applications (e.g. mobile app,
  IP address) and the set of APIs they are valid for.
* API keys should be stored on a secure location such as a vault.
* A Configuration Management (CM) tool should be used and a clear configuration
  management process should be defined.

## References

### OWASP

* [OWASP Key Management Cheat Sheet][1]

### External

* [CWE-798: Use of Hard-coded Credentials][2]

[1]: https://www.owasp.org/index.php/Key_Management_Cheat_Sheet
[2]: https://cwe.mitre.org/data/definitions/798.html
