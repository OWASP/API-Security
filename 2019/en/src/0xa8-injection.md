A8:2019 Injection
=================

| Threat agents/Attack vectors | Security Weakness | Impacts |
| - | - | - |
| API Specific : Exploitability **3** | Prevalence **2** : Detectability **3** | Technical **3** : Business Specific |
| Attackers will feed the API with hostile data through whatever injection vectors are available (e.g. direct input, parameters, integrated services, etc.) expecting it to e sent to an interpreter. | Injection flaws are very common and often found in SQL, LDAP or NoSQL queries, OS commands, XML parsers and ORM. These flaws are easy to discover when reviewing the source code. Attackers can use scanners and fuzzers. | Injection can lead to information disclosure and data loss. It may also lead to DoS or complete host takeover. |

## Is the API Vulnerable?

The API is vulnerable to injection flaws if:

* Client-supplied data is not validated, filtered or sanitized by the API.
* Client-supplied data is directly used or concatenated to SQL/NoSQL/LDAP
  queries, OS commands, XML parsers. and Object Relational Mapping (ORM)/Object
  Document Mapper (ODM).
* Data coming from external systems (e.g. integrated systems) is not validated,
  filtered or sanitized by the API.

## Example Attack Scenarios

### Scenario #1

Inspecting the web browser network traffic an attacker identifies the following
API request responsible to start the recovery password workflow:

```
POST /api/accounts/recovery
{"username": "john@somehost.com"}
```

The attacker replays the request with a different payload

```
POST /api/account/recovery
{"email": "john@somehost.com';WAITFOR DELAY '0:0:5'--"}
```

This time the response took ~5 seconds confirming the API is vulnerable to SQL
injection. Exploiting this vulnerability the attacker was able to gain
unauthorized access to the system.

### Scenario #2

Firmware of a parental control device provides the endpoint
`/api/CONFIG/restore` which expects an appId to be sent as a multipart
parameter. Using a decompiler an attacker finds out that the appId is passed
directly into a system call without any sanitization:

```c
snprintf(cmd, 128, "%srestore_backup.sh /tmp/postfile.bin %s %d",
         "/mnt/shares/usr/bin/scripts/", appid, 66);
system(cmd);
```

The following command allows the attacker to shutdown any device with the same
vulnerable firmware:

```
$ curl -k "https://${deviceIP}:4567/api/CONFIG/restore" -F 'appid=$(/etc/pod/power_down.sh)'
```

### Scenario #3

We have an application with basic CRUD functionality for operations with
bookings. An attacker managed to identify that NoSQL injection might be possible
through `bookingId` query string parameter in the delete booking request. This
is how the request looks like: `DELETE /api/bookings?bookingId=678`.

The API server uses the following function to handle delete requests:

```javascript
router.delete('/bookings', async function (req, res, next) {
  try {
      const deletedBooking = await Bookings.findOneAndRemove({'_id' : req.query.bookingId});
      res.status(200);
  } catch (err) {
     res.status(400).json({error: 'Unexpected error occured while processing a request'});
  }
});
```

Attacker intercepted the request and changed `bookingId` query string parameter
as below, the attacker managed to delete another user booking:

```
DELETE /api/bookings?bookingId[$ne]=678
```

## How To Prevent

Preventing injection requires keeping data separate from commands and queries.

* Perform data validation using a single, trustworthy, actively maintained
  library.
* Validate, filter and sanitize all client-provided data or other data coming
  from integrated systems.
* Special characters should be escaped using the specific syntax for the target
  interpreter.
* Prefer a safe API which provides a parameterized interface.
* Always limit the number of returned records to prevent mass disclosure in case
  of injection.
* Validate incoming data using sufficient filters to only allow valid values for
  each input parameter.

## References

### OWASP

* [OWASP Injection Flaws][1]
* [SQL Injection][2]
* [NoSQL Injection Fun with Objects and Arrays][3]
* [Command Injection][4]

### External

* [CWE-77: Command Injection][5]
* [CWE-89: SQL Injection][6]
* [HOW TO: Command Injection, HackerOne][7]

[1]: https://www.owasp.org/index.php/Injection_Flaws
[2]: https://www.owasp.org/index.php/SQL_Injection
[3]: https://www.owasp.org/images/e/ed/GOD16-NOSQL.pdf
[4]: https://www.owasp.org/index.php/Command_Injection
[5]: https://cwe.mitre.org/data/definitions/77.html
[6]: https://cwe.mitre.org/data/definitions/89.html
[7]: https://www.hackerone.com/blog/how-to-command-injections
