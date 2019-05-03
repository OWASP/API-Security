A1:2019 Broken Object Level Access Control
==========================================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| -- | -- | -- |
| Access Lvl : Exploitability ? | Prevalence ? : Detectability ? | Technical ? : Business |
| | | |

## Is the API Vulnerable?

## Example Attack Scenarios

### Scenario #1

An e-commerce platform for online stores provides a listing page with some
revenue charts about their hosted shops.
Inspecting browser requests, an attacker identifies the endpoints used as data
source for those charts and their pattern
`/shops/{shopName}/revenue_data.json`. Using another API endpoint, the attacker
gets the list of all hosted shops names. With a simple script to iterate over
the names in the list, replacing `{shopName}` in the URL, the attacker got
access to sales data of thousands of e-commerce stores.

### Scenario #2

While monitoring a wearable network traffic, the following HTTP `PATCH` request
got attacker’s attention due to the presence of a custom HTTP request header
`X-User-Id: 54796`. Replacing the `X-User-Id` value by `54795`, the attacker got
a successful HTTP response, being able to modify others' account data.

## How To Prevent

## References

### OWASP

### External
