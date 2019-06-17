A4:2019 Lack of Resources & Rate Limiting
=========================================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| - | - | - |
| API Specific : Exploitability **2** | Prevalence **3** : Detectability **3** | Technical **2** : Business Specific |
| Exploitation requires simple API requests. No authentication is required. Multiple concurrent requests can be performed from a single local computer or by using cloud computing resources. | It’s common to find APIs that do not implement rate limiting or APIs where limits are not properly set. | Exploitation may lead to DoS, making the API unresponsive or even unavailable. |

## Is the API Vulnerable?

API requests consume resources such as network, CPU, memory and storage and the
amount of resources required to satisfy a request greatly depends on the user
input and endpoint business logic. Also consider that requests from multiple API
clients compete for resources. An API is vulnerable if at least one of the
following limits is missing or set inappropriately (i.e. too low/high)

* Execution timeouts
* Max allocable memory
* Number of file descriptors
* Number of processes
* Request payload size (e.g. uploads)
* Number of requests per client/resource

## Example Attack Scenarios

### Scenario #1

An attacker uploads a large image by issuing a POST request to `/api/v1/images`.
When the upload is complete, the API creates multiple thumbnails with different
sizes. Due to the size of the uploaded image, available memory is exhausted
during the creation of thumbnails and the API becomes unresponsive.

### Scenario #2

An attacker starts the password recovery workflow by issuing a POST request to
`/api/system/verification-codes` and by providing the username in the request
body. Next an SMS token with 6 digits is sent to the victim’s phone. Because the
API does not implement a rate limiting policy the attacker can test all possible
combinations using a multi-thread script, against the
`/api/system/verification-codes/{smsToken}` endpoint to discover the right token
within a few minutes.

## How To Prevent

* Docker makes it easy to limit [memory][1], [CPU][2], [number of restarts][3],
  [file descriptors and processes][4].
* Implement a limit on how often a client can call the API within a defined
  timeframe.
* Notify the client when the limit is exceeded by providing the limit number and
  the time at which the limit will be reset.

## References

### OWASP

* [Blocking Brute Force Attacks][5]
* [Docker Cheat Sheet - Limit resources (memory, CPU, file descriptors,
  processes, restarts)][6]
* [REST Assessment Cheat Sheet][7]

### External

* [CWE-307: Improper Restriction of Excessive Authentication Attempts][8]
* [CWE-770: Allocation of Resources Without Limits or Throttling][9]
* “_Rate Limiting (Throttling)_” - [Security Strategies for Microservices-based
  Application Systems][10], NIST

[1]: https://docs.docker.com/config/containers/resource_constraints/#memory
[2]: https://docs.docker.com/config/containers/resource_constraints/#cpu
[3]: https://docs.docker.com/engine/reference/commandline/run/#restart-policies---restart
[4]: https://docs.docker.com/engine/reference/commandline/run/#set-ulimits-in-container---ulimit
[5]: https://www.owasp.org/index.php/Blocking_Brute_Force_Attacks
[6]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/Docker_Security_Cheat_Sheet.md#rule-7---limit-resources-memory-cpu-file-descriptors-processes-restarts
[7]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/REST_Assessment_Cheat_Sheet.md
[8]: https://cwe.mitre.org/data/definitions/307.html
[9]: https://cwe.mitre.org/data/definitions/770.html
[10]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204-draft.pdf
