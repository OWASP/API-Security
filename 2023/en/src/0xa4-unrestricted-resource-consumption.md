API4:2023 Unrestricted Resource Consumption
===========================================

## Is the API Vulnerable?

Satisfying API requests requires resources such as network bandwidth, CPU,
memory, and storage. Sometimes required resources are made available by service
providers via API integrations, and paid for per request, such as sending
emails/SMS/phone calls, biometrics validation, etc.

An API is vulnerable if at least one of the following limits is missing or set
inappropriately (e.g. too low/high):

* Execution timeouts
* Maximum allocable memory
* Maximum number of file descriptors
* Maximum number of processes
* Maximum upload file size
* Number of operations to perform in a single API client request (e.g. GraphQL
  batching)
* Number of records per page to return in a single request-response
* Third-party service providers' spending limit

## Example Attack Scenarios

### Scenario #1

An attacker uploads a large image by issuing a POST request to /api/v1/images.
When the upload is complete, the API creates multiple thumbnails with different
sizes. Due to the size of the uploaded image, available memory is exhausted
during the creation of thumbnails and the API becomes unresponsive.

### Scenario #2

In order to activate a credit card the following API request should be issued
providing the last four digits printed on it (only users with physical access
to the card should be able to perform such operation):

```
POST /graphql

{
  "query": "mutation {
    validateOTP(token: \"abcdef\", card: \"123456\") {
      authToken
    }
  }"
}
```

Bad actors will be able to perform the credit card activation without physical
access to it, crafting a request like the one below:

```
POST /graphql

[
  {"query": "mutation {activateCard(token: \"abcdef\", card: \"0000\") {authToken}}"},
  {"query": "mutation {activateCard(token: \"abcdef\", card: \"0001\") {authToken}}"},
  ...
  {"query": "mutation {activateCard(token: \"abcdef\", card: \"9999\") {authToken}}"}
}
```

Because the API does not limit the number of times the activateCard operation
can be attempted, one of the mutations will succeed.

### Scenario #3

A service provider allows clients to download arbitrarily large files using its
API. These files are stored in cloud object storage and they don't change that
often. The service provider relies on a cache service to have a better service
rate and to keep bandwidth consumption low. The cache service only caches files
up to 15GB.

When one of the files gets updated, its size increases to 18GB. All service
clients immediately start pulling the new version. Because there were no
consumption cost alerts, nor a maximum cost allowance for the cloud service,
the next monthly bill increases from US$13, on average, to US$8k.

## How To Prevent

* Use a solution that makes it easy to limit [memory][1],
  [CPU][2], [number of restarts][3], [file descriptors, and processes][4] such as Containers / Serverless code (e.g. Lambdas).
* Define and enforce a maximum size of data on all incoming parameters and
  payloads, such as maximum length for strings, maximum number of elements in
  arrays, and maximum upload file size (regardless of whether it is stored
  locally or in cloud storage).
* Implement a limit on how often a client can interact with the API within a
  defined timeframe (rate limiting).
* Rate limiting should be fine tuned based on the business needs. Some API
  Endpoints might require stricter policies.
* Limit/throttle how many times or how often a single API client/user can
  execute a single operation (e.g. validate an OTP, or request password
  recovery without visiting the one-time URL).
* Add proper server-side validation for query string and request body
  parameters, specifically the one that controls the number of records to be
  returned in the response.
* Configure spending limits for all service providers/API integrations. When
  setting spending limits is not possible, billing alerts should be configured
  instead.

## References

### OWASP

* ["Availability" - Web Service Security Cheat Sheet][5]
* ["DoS Prevention" - GraphQL Cheat Sheet][6]
* ["Mitigating Batching Attacks" - GraphQL Cheat Sheet][7]

### External

* [CWE-770: Allocation of Resources Without Limits or Throttling][8]
* [CWE-400: Uncontrolled Resource Consumption][9]
* [CWE-799: Improper Control of Interaction Frequency][10]
* "Rate Limiting (Throttling)" - [Security Strategies for Microservices-based
  Application Systems][11], NIST

[1]: https://docs.docker.com/config/containers/resource_constraints/#memory
[2]: https://docs.docker.com/config/containers/resource_constraints/#cpu
[3]: https://docs.docker.com/engine/reference/commandline/run/#restart
[4]: https://docs.docker.com/engine/reference/commandline/run/#ulimit
[5]: https://cheatsheetseries.owasp.org/cheatsheets/Web_Service_Security_Cheat_Sheet.html#availability
[6]: https://cheatsheetseries.owasp.org/cheatsheets/GraphQL_Cheat_Sheet.html#dos-prevention
[7]: https://cheatsheetseries.owasp.org/cheatsheets/GraphQL_Cheat_Sheet.html#mitigating-batching-attacks
[8]: https://cwe.mitre.org/data/definitions/770.html
[9]: https://cwe.mitre.org/data/definitions/400.html
[10]: https://cwe.mitre.org/data/definitions/799.html
[11]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204.pdf
