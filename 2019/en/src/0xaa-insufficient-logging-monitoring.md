API10:2019 Insufficient Logging & Monitoring
============================================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| - | - | - |
| API Specific : Exploitability **2** | Prevalence **3** : Detectability **1** | Technical **2** : Business Specific |
| Attackers take advantage of lack of logging and monitoring to abuse systems without being noticed. | Without logging and monitoring, or with insufficient logging and monitoring, it is almost impossible to track suspicious activities and respond to them in a timely fashion. | Without visibility over on-going malicious activities, attackers have plenty of time to fully compromise systems. |

## Is the API Vulnerable?

The API is vulnerable if:

* It does not produce any logs, the logging level is not set correctly, or log
  messages do not include enough detail.
* Log integrity is not guaranteed (e.g., [Log Injection][1]).
* Logs are not continuously monitored.
* API infrastructure is not continuously monitored.

## Example Attack Scenarios

### Scenario #1

Access keys of an administrative API were leaked on a public repository. The
repository owner was notified by email about the potential leak, but took more
than 48 hours to act upon the incident, and access keys exposure may have
allowed access to sensitive data. Due to insufficient logging, the company is
not able to assess what data was accessed by malicious actors.

### Scenario #2

A video-sharing platform was hit by a “large-scale” credential stuffing attack.
Despite failed logins being logged, no alerts were triggered during the timespan
of the attack. As a reaction to user complaints, API logs were analyzed and the
attack was detected. The company had to make a public announcement asking users
to reset their passwords, and report the incident to regulatory authorities.

## How To Prevent

* Log all failed authentication attempts, denied access, and input validation
  errors.
* Logs should be written using a format suited to be consumed by a log
  management solution, and should include enough detail to identify the
  malicious actor.
* Logs should be handled as sensitive data, and their integrity should be
  guaranteed at rest and transit.
* Configure a monitoring system to continuously monitor the infrastructure,
  network, and the API functioning.
* Use a Security Information and Event Management (SIEM) system to aggregate and
  manage logs from all components of the API stack and hosts.
* Configure custom dashboards and alerts, enabling suspicious activities to be
  detected and responded to earlier.

## References

### OWASP

* [OWASP Logging Cheat Sheet][2]
* [OWASP Proactive Controls: Implement Logging and Intrusion Detection][3]
* [OWASP Application Security Verification Standard: V7: Error Handling and
  Logging Verification Requirements][4]

### External

* [CWE-223: Omission of Security-relevant Information][5]
* [CWE-778: Insufficient Logging][6]

[1]: https://www.owasp.org/index.php/Log_Injection
[2]: https://www.owasp.org/index.php/Logging_Cheat_Sheet
[3]: https://www.owasp.org/index.php/OWASP_Proactive_Controls
[4]: https://github.com/OWASP/ASVS/blob/master/4.0/en/0x15-V7-Error-Logging.md
[5]: https://cwe.mitre.org/data/definitions/223.html
[6]: https://cwe.mitre.org/data/definitions/778.html
