A7:2019 Security Misconfiguration
=================================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| - | - | - |
| API Specific : Exploitability **3** | Prevalence **3** : Detectability **3** | Technical **2** : Business Specific |
| Attackers will often attempt to find unpatched flaws, common endpoints or unprotected files and directories to gain unauthorized access or knowledge of the system. | Security misconfiguration can happen at any level of the API stack from the network to the application level. Automated tools are available to detect and exploit misconfigurations such as unnecessary services or legacy options. | Security misconfigurations can expose not only sensitive user data but also system details what may lead to full server compromise. |

## Is the API Vulnerable?

The API might be vulnerable if:

* Appropriate security hardening is missing across any part of the application
  stack or if it has improperly configured permissions on cloud services.
* The latest security patches are missing or the systems are out of date.
* Unnecessary features are enabled (e.g. HTTP verbs).
* Transport Layer Security (TLS) is missing.
* Security directives are not sent to clients (e.g. [Security Headers][1]).
* A Cross-Origin Resource Sharing (CORS) policy is missing or improperly set.
* Error messages include stack traces or other sensitive information is exposed.

## Example Attack Scenarios

### Scenario #1

An attacker finds the `.bash_history` file under the root of the server which
contains commands used by the DevOps team to access the API:

```
$ curl -X GET 'https://api.server/endpoint/' -H 'authorization: Basic Zm9vOmJhcg=='
```

An attacker could also find new endpoints on the API that are used only by the
DevOps team and not documented.

### Scenario #2

To target a specific service, an attacker uses a popular search engine to search
for  computers directly accessible from the Internet. The attacker found a host
running a popular database management system listening on the default port. The
host was using the default configuration which has authentication disabled by
default and the attacker gained access to millions of records with PII, personal
preferences and authentication data.

### Scenario #3

Inspecting traffic of a mobile application an attacker finds out that not all
HTTP traffic is performed on a secure protocol (i.e TLS). The attacker finds
this to be true specifically for the download of  profile images. As user
interaction is binary, despite the fact that API traffic is performed on a
secure protocol, the attacker finds a pattern on API responses size which he
uses to track user preferences over the rendered content (profile images).

## How To Prevent

The API lifecycle should include:

* A repeatable hardening process leading to fast and easy deployment of a
  properly locked down environment.
* A task to review and update configurations across the entire API stack. The
  review should include API components and cloud services (e.g. S3 bucket
  permissions).
* A secure communication channel for all API interactions access to static
  assets (e.g. images).
* An automated process to continuously assess the effectiveness of the
  configuration and settings in all environments.

## References

### OWASP

* [OWASP Secure Headers Project][1]
* [OWASP Testing Guide: Configuration Management][2]
* [OWASP Testing Guide: Testing for Error Codes][3]

### External

* [CWE-2: Environmental Security Flaws][4]
* [CWE-16: Configuration][5]
* [CWE-388: Error Handling][6]
* [Guide to General Server Security][7], NIST
* [Let’s Encrypt: a free, automated, and open Certificate Authority][8]

[1]: https://www.owasp.org/index.php/OWASP_Secure_Headers_Project
[2]: https://www.owasp.org/index.php/Testing_for_configuration_management
[3]: https://www.owasp.org/index.php/Testing_for_Error_Code_(OTG-ERR-001)
[4]: https://cwe.mitre.org/data/definitions/2.html
[5]: https://cwe.mitre.org/data/definitions/16.html
[6]: https://cwe.mitre.org/data/definitions/388.html
[7]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[8]: https://letsencrypt.org/
