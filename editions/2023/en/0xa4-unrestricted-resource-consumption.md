# API4:2023 Unrestricted Resource Consumption

| Threat agents/Attack vectors | Security Weakness | Impacts |
| - | - | - |
| API Specific : Exploitability **Average** | Prevalence **Widespread** : Detectability **Easy** | Technical **Severe** : Business Specific |
| Exploitation requires simple API requests. Multiple concurrent requests can be performed from a single local computer or by using cloud computing resources. Most of the automated tools available are designed to cause DoS via high loads of traffic, impacting APIs’ service rate. | It's common to find APIs that do not limit client interactions or resource consumption. Crafted API requests, such as those including parameters that control the number of resources to be returned and performing response status/time/length analysis should allow identification of the issue. The same is valid for batched operations. Although threat agents don't have visibility over costs impact, this can be inferred based on service providers’ (e.g. cloud provider) business/pricing model. | Exploitation can lead to DoS due to resource starvation, but it can also lead to operational costs increase such as those related to the infrastructure due to higher CPU demand, increasing cloud storage needs, etc. |

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

A social network implemented a “forgot password” flow using SMS verification,
enabling the user to receive a one time token via SMS in order to reset their
password.

Once a user clicks on "forgot password" an API call is sent from the user's
browser to the back-end API:

```
POST /initiate_forgot_password

{
  "step": 1,
  "user_number": "6501113434"
}
```

Then, behind the scenes, an API call is sent from the back-end to a 3rd party
API that takes care of the SMS delivering:

```
POST /sms/send_reset_pass_code

Host: willyo.net

{
  "phone_number": "6501113434"
}
```

The 3rd party provider, Willyo, charges $0.05 per this type of call.

An attacker writes a script that sends the first API call tens of thousands of
times. The back-end follows and requests Willyo to send tens of thousands of
text messages, leading the company to lose thousands of dollars in a matter of
minutes.

### Scenario #2

A GraphQL API Endpoint allows the user to upload a profile picture.

```
POST /graphql

{
  "query": "mutation {
    uploadPic(name: \"pic1\", base64_pic: \"R0FOIEFOR0xJVA…\") {
      url
    }
  }"
}
```

Once the upload is complete, the API generates multiple thumbnails with
different sizes based on the uploaded picture. This graphical operation takes a
lot of memory from the server.

The API implements a traditional rate limiting protection - a user can't access
the GraphQL endpoint too many times in a short period of time. The API also
checks for the uploaded picture's size before generating thumbnails to avoid
processing pictures that are too large.

An attacker can easily bypass those mechanisms, by leveraging the flexible
nature of GraphQL:

```
POST /graphql

[
  {"query": "mutation {uploadPic(name: \"pic1\", base64_pic: \"R0FOIEFOR0xJVA…\") {url}}"},
  {"query": "mutation {uploadPic(name: \"pic2\", base64_pic: \"R0FOIEFOR0xJVA…\") {url}}"},
  ...
  {"query": "mutation {uploadPic(name: \"pic999\", base64_pic: \"R0FOIEFOR0xJVA…\") {url}}"},
}
```

Because the API does not limit the number of times the `uploadPic` operation can
be attempted, the call will lead to exhaustion of server memory and Denial of
Service.

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
  [CPU][2], [number of restarts][3], [file descriptors, and processes][4] such
  as Containers / Serverless code (e.g. Lambdas).
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
