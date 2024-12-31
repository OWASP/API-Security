# API6:2023 Unrestricted Access to Sensitive Business Flows

| Threat agents/Attack vectors | Security Weakness | Impacts |
| - | - | - |
| API Specific : Exploitability **Easy** | Prevalence **Widespread** : Detectability **Average** | Technical **Moderate** : Business Specific |
| Exploitation usually involves understanding the business model backed by the API, finding sensitive business flows, and automating access to these flows, causing harm to the business. | Lack of a holistic view of the API in order to fully support business requirements tends to contribute to the prevalence of this issue. Attackers manually identify what resources (e.g. endpoints) are involved in the target workflow and how they work together. If mitigation mechanisms are already in place, attackers need to find a way to bypass them. | In general technical impact is not expected. Exploitation might hurt the business in different ways, for example: prevent legitimate users from purchasing a product, or lead to inflation in the internal economy of a game. |

## Is the API Vulnerable?

When creating an API Endpoint, it is important to understand which business flow
it exposes. Some business flows are more sensitive than others, in the sense
that excessive access to them may harm the business.

Common examples of sensitive business flows and risk of excessive access
associated with them:

* Purchasing a product flow - an attacker can buy all the stock of a high-demand
  item at once and resell for a higher price (scalping)
* Creating a comment/post flow - an attacker can spam the system
* Making a reservation - an attacker can reserve all the available time slots
  and prevent other users from using the system

The risk of excessive access might change between industries and businesses.
For example - creation of posts by a script might be considered as a risk of
spam by one social network, but encouraged by another social network.

An API Endpoint is vulnerable if it exposes a sensitive business flow, without
appropriately restricting the access to it.

## Example Attack Scenarios

### Scenario #1

A technology company announces they are going to release a new gaming console on
Thanksgiving. The product has a very high demand and the stock is limited. An
attacker writes code to automatically buy the new product and complete the
transaction.

On the release day, the attacker runs the code distributed across different IP
addresses and locations. The API doesn't implement the appropriate protection
and allows the attacker to buy the majority of the stock before other legitimate
users.

Later on, the attacker sells the product on another platform for a much higher
price.

### Scenario #2

An airline company offers online ticket purchasing with no cancellation fee. A
user with malicious intentions books 90% of the seats of a desired flight.

A few days before the flight the malicious user canceled all the tickets at
once, which forced the airline to discount the ticket prices in order to fill
the flight.

At this point, the user buys herself a single ticket that is much cheaper than
the original one.

### Scenario #3

A ride-sharing app provides a referral program - users can invite their friends
and gain credit for each friend who has joined the app. This credit can be later
used as cash to book rides.

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
    difficult to implement. The following methods are used to slow down
    automated
    threats:

    * Device fingerprinting: denying service to unexpected client devices (e.g
      headless browsers) tends to make threat actors use more sophisticated
      solutions, thus more costly for them
    * Human detection: using either captcha or more advanced biometric solutions
      (e.g. typing patterns)
    * Non-human patterns: analyze the user flow to detect non-human patterns
      (e.g. the user accessed the "add to cart" and "complete purchase"
      functions in less than one second)
    * Consider blocking IP addresses of Tor exit nodes and well-known proxies

    Secure and limit access to APIs that are consumed directly by machines (such
    as developer and B2B APIs). They tend to be an easy target for attackers
    because they often don't implement all the required protection mechanisms.

## References

### OWASP

* [OWASP Automated Threats to Web Applications][1]
* [API10:2019 Insufficient Logging & Monitoring][2]

[1]: https://owasp.org/www-project-automated-threats-to-web-applications/
[2]: https://owasp.org/API-Security/editions/2019/en/0xaa-insufficient-logging-monitoring/

