A1:2019 Broken Object Level Access Control
==========================================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| - | - | - |
| API Specific : Exploitability **3** | Prevalence **3** : Detectability **2** | Technical **3** : Business Specific |
| Attackers can exploit API endpoints that are vulnerable to broken object access control by manipulating the ID of an object that is sent in the request. This may lead to unauthorized access to sensitive data. This issue is extremely common in API based applications because the server component usually does not fully track the client’s state, and instead relies more on parameters like object IDs, that are sent from the client to decide which objects to access. | This has been the most common and impactful attack on APIs. Authorization and access control mechanisms in modern applications are complex and wide-spread. Even if the application implements a proper infrastructure for authorization checks, developers might forget to use these checks before accessing a sensitive object. Access control detection is not typically amenable to automated static or dynamic testing. | Unauthorized access can result in data disclosure to unauthorized parties, data loss, or data manipulation. Unauthorized access to objects can also lead to full account takeover. |

## Is the API Vulnerable?

Object access control is a mechanism that is usually implemented at the code
level to validate that one user can access only objects that they should have
access to.

Every API endpoint that receives an ID of an object and performs any type of
action on the object should implement object level access control checks. The
checks should validate that the logged-in user does have access to perform the
requested action on the requested object.

Failures in the mechanism typically leads to unauthorized information
disclosure, modification or destruction of all data.

## Example Attack Scenarios

### Scenario #1

An e-commerce platform for online stores provides a listing page with the
revenue charts for their hosted shops. Inspecting the browser requests, an
attacker identifies the API endpoints used as a data source for those charts
and their pattern `/shops/{shopName}/revenue_data.json`. Using another API
endpoint, the attacker gets the list of all hosted shop names. With a simple
script to iterate over the names in the list, replacing `{shopName}` in the URL,
the attacker gains access to the sales data of thousands of e-commerce stores.

### Scenario #2

While monitoring the network traffic of a wearable device, the following HTTP
`PATCH` request get the attention of an attacker due to the presence of a custom
HTTP request header `X-User-Id: 54796`. Replacing the `X-User-Id` value with
`54795`, the attacker receives a successful HTTP response and is able to modify
other user account data.

## How To Prevent

* Implement a proper access control mechanism that relies on the user policies
  and hierarchy.
* Prefer not to use an ID that has been sent from the client, but instead use an
  ID that is stored in the session object when accessing a database record by
  the record ID.
* Use an access control mechanism to check if the logged in user has access to
  perform the requested action on the record in every function that uses an
  input from the client to access a record in the database.
* Prefer to use random and unpredictable values as GUIDs for records’ IDs.

## References

### OWASP

### External

* [CWE-284: Improper Access Control][1]
* [CWE-285: Improper Authorization][2]
* [CWE-639: Authorization Bypass Through User-Controlled Key][3]

[1]: https://cwe.mitre.org/data/definitions/284.html
[2]: https://cwe.mitre.org/data/definitions/285.html
[3]: https://cwe.mitre.org/data/definitions/639.html
