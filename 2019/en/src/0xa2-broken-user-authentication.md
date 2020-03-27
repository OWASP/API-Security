API2:2019 Broken User Authentication
====================================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| - | - | - |
| API Specific : Exploitability **3** | Prevalence **2** : Detectability **2** | Technical **3** : Business Specific |
| Authentication in APIs is a complex and confusing mechanism. Software and security engineers might have misconceptions about what are the boundaries of authentication and how to implement it correctly. In addition, the authentication mechanism is an easy target for attackers, since it’s exposed to everyone. These two points makes the authentication component potentially vulnerable to many exploits. | There are two sub-issues: 1. Lack of protection mechanisms: APIs endpoints that are responsible for authentication must be treated differently from regular endpoints and implement extra layers of protection 2. Misimplementation of the mechanism: The mechanism is used / implemented without considering the attack vectors, or it’s the wrong use case (e.g., an authentication mechanism designed for IoT clients might not be the right choice for web applications). | Attackers can gain control to other users’ accounts in the system, read their personal data, and perform sensitive actions on their behalf, like money transactions and sending personal messages. |

## Is the API Vulnerable?

Authentication endpoints and flows are assets that need to be protected. “Forgot
password / reset password” should be treated the same way as authentication
mechanisms.

An API is vulnerable if it:
* Permits [credential stuffing][1] whereby the attacker has a list of valid
  usernames and passwords.
* Permits attackers to perform a brute force attack on the same user account, without
  presenting captcha/account lockout mechanism.
* Permits weak passwords.
* Sends sensitive authentication details, such as auth tokens and passwords in
  the URL.
* Doesn’t validate the authenticity of tokens.
* Accepts unsigned/weakly signed JWT tokens (`"alg":"none"`)/doesn’t
  validate their expiration date.
* Uses plain text, non-encrypted, or weakly hashed passwords.
* Uses weak encryption keys.

## Example Attack Scenarios

## Scenario #1

[Credential stuffing][1] (using [lists of known usernames/passwords][2]), is a
common attack. If an application does not implement automated threat or
credential stuffing protections, the application can be used as a password
oracle (tester) to determine if the credentials are valid.

## Scenario #2

An attacker starts the password recovery workflow by issuing a POST request to
`/api/system/verification-codes` and by providing the username in the request
body. Next an SMS token with 6 digits is sent to the victim’s phone. Because the
API does not implement a rate limiting policy, the attacker can test all
possible combinations using a multi-threaded script, against the
`/api/system/verification-codes/{smsToken}` endpoint to discover the right token
within a few minutes.

## How To Prevent

* Make sure you know all the possible flows to authenticate to the API (mobile/
  web/deep links that implement one-click authentication/etc.)
* Ask your engineers what flows you missed.
* Read about your authentication mechanisms. Make sure you understand what and
  how they are used. OAuth is not authentication, and neither is API keys.
* Don't reinvent the wheel in authentication, token generation, password
  storage. Use the standards.
* Credential recovery/forget password endpoints should be treated as login
  endpoints in terms of brute force, rate limiting, and lockout protections.
* Use the [OWASP Authentication Cheatsheet][3].
* Where possible, implement multi-factor authentication.
* Implement anti brute force mechanisms to mitigate credential stuffing,
  dictionary attack, and brute force attacks on your authentication endpoints.
  This mechanism should be stricter than the regular rate limiting mechanism on
  your API.
* Implement [account lockout][4] / captcha mechanism to prevent brute force
  against specific users. Implement weak-password checks.
* API keys should not be used for user authentication, but for [client app/
  project authentication][5].

## References

### OWASP

* [OWASP Key Management Cheat Sheet][6]
* [OWASP Authentication Cheatsheet][3]
* [Credential Stuffing][1]

### External

* [CWE-798: Use of Hard-coded Credentials][7]

[1]: https://www.owasp.org/index.php/Credential_stuffing
[2]: https://github.com/danielmiessler/SecLists
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[4]: https://www.owasp.org/index.php/Testing_for_Weak_lock_out_mechanism_(OTG-AUTHN-003)
[5]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[6]: https://www.owasp.org/index.php/Key_Management_Cheat_Sheet
[7]: https://cwe.mitre.org/data/definitions/798.html
