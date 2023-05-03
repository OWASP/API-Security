API8:2023 Lack of Protection from Automated Threats
===================================================

## Is the API Vulnerable?

Automated threats have become more profitable, smarter and harder to protect
from, and APIs are often used as an easy target for them. Traditional
protections, such as rate limiting and captchas become less effective over time.
For example, an attacker who operates bot-nets (for scalping) gets around rate
limiting because they can easily access the API from thousands of location/IP
addresses around the world, in a matter of seconds.

Vulnerable APIs don't necessarily have implementation bugs. They simply expose
a business flow - such as buying a ticket, or posting a comment - without
considering how the functionality could harm the business if used excessively
in an automated manner.

Each industry might have its own specific risks when it comes to automated
threats.

An API endpoint is vulnerable if it exposes a business-sensitive functionality,
and allows an attacker to harm the business by accessing it in an excessive
automated manner.

The [OWASP Automated Threats to Web Applications][1] covers different types of
automated threats and their impact.

## Example Attack Scenarios

### Scenario #1

A technology company announces they are going to release a new gaming console
on Thanksgiving. The product has a very high demand and the stock is limited.
An attacker, operator of a network of automated threats, writes code to
automatically buy the new product and complete the transaction.

On the release day, the attacker runs the code distributed across different IP
addresses and locations. The API doesn't implement the appropriate protection
and allows the attacker to buy the majority of the stock before other
legitimate users.

Later on, the attacker sells the product on another platform for a much higher
price.


### Scenario #2

A ride-sharing app provides a referral program - users can invite their friends
and gain credit for each friend who has joined the app. This credit can be
later used as cash to book rides.

An attacker exploits this flow by writing a script to automate the registration
process, with each new user adding credit to the attacker's wallet.

The attacker can later enjoy free rides or sell the accounts with excessive
credits for cash.

## How To Prevent

The mitigation planning should be done in two layers:

* Business - identify the business flows that might harm the business if they
  are excessively used.
* Engineering - choose the right protection mechanisms to mitigate the business
  risk.

  Some of the protection mechanisms are more simple while others are more
  difficult to implement. The following methods are used to slow down automated
  threats:

  * Device fingerprinting: denying service to unexpected client devices (e.g
    headless browsers) tends to make threat actors use more sophisticated
    solutions, thus more costly for them
  * Human detection: using either captcha or more advanced biometric solutions
    (e.g. typing patterns)
  * Non-human patterns: analyze the user flow to detect non-human patterns
    (e.g.  the user accessed the "add to cart" and "complete purchase"
    functions in less than one second)
  * Consider blocking IP addresses of Tor exit nodes and well-known proxies
* Secure and limit access to APIs that are consumed directly by machines (such
  as developer and B2B APIs). They tend to be an easy target for attackers
  because they often don't implement all the required protection mechanisms.

## References

### OWASP

* [OWASP Automated Threats to Web Applications][1]
* [API10:2019 Insufficient Logging & Monitoring][2]

[1]: https://owasp.org/www-project-automated-threats-to-web-applications/
[2]: https://github.com/OWASP/API-Security/blob/master/2019/en/src/0xaa-insufficient-logging-monitoring.md
