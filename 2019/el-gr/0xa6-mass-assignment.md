API6:2019 Mass Assignment
===========================

| Παράγοντες Απειλής/Φορείς Επίθεσης | Αδυναμία Ασφαλείας | Επιπτώσεις |
| - | - | - |
| Εξαρτώνται από το API : Εκμεταλλευσιμότητα **2** | Επιπολασμός **2** : Ανιχνευσιμότητα **2** | Τεχνικές Επιπτώσεις **2** : Εξαρτώνται από την Επιχείρηση |
| Η εκμετάλλευση (exploitation) συνήθως απαιτεί κατανόηση της επιχειρηματικής λογικής (business logic), των σχέσεων των αντικειμένων και της δομής του API.  Η εκμετάλλευση της μαζικής εκχώρησης (Mass Assignment) είναι ευκολότερη στα API, καθώς από το σχεδιασμό τους εκθέτουν την υλοποίηση της εφαρμογής μαζί με τα ονόματα των ιδιοτήτων. | Τα σύγχρονα frameworks ενθαρρύνουν τους προγραμματιστές να χρησιμοποιούν συναρτήσεις (functions) που συνδέουν αυτόματα την είσοδο από τον πελάτη σε μεταβλητές κώδικα και εσωτερικά αντικείμενα. Οι εισβολείς μπορούν να χρησιμοποιήσουν αυτήν τη μεθοδολογία για να ενημερώσουν ή να αντικαταστήσουν τις ιδιότητες ευαίσθητων αντικειμένων που οι προγραμματιστές δεν σκόπευαν ποτέ να εκθέσουν. | Η εκμετάλλευση (exploitation) μπορεί να οδηγήσει σε κλιμάκωση των προνομίων (privilege escalation), παραποίηση δεδομένων (data tampering), παράκαμψη μηχανισμών ασφαλείας και πολλά άλλα. |

## Πότε το API είναι ευάλωτο;

Objects in modern applications might contain many properties. Some of these
properties should be updated directly by the client (e.g., `user.first_name` or
`user.address`) and some of them should not (e.g., `user.is_vip` flag).

An API endpoint is vulnerable if it automatically converts client parameters
into internal object properties, without considering the sensitivity and the
exposure level of these properties. This could allow an attacker to update
object properties that they should not have access to.

Examples for sensitive properties:

* **Permission-related properties**: `user.is_admin`, `user.is_vip` should only
  be set by admins.
* **Process-dependent properties**: `user.cash` should only be set internally
  after payment verification.
* **Internal properties**: `article.created_time` should only be set internally
  by the application.

## Example Attack Scenarios

### Scenario #1

A ride sharing application provides a user the option to edit basic information
for their profile. During this process, an API call is sent to
`PUT /api/v1/users/me` with the following legitimate JSON object:

```json
{"user_name":"inons","age":24}
```

The request `GET /api/v1/users/me` includes an additional credit_balance
property:

```json
{"user_name":"inons","age":24,"credit_balance":10}
```

The attacker replays the first request with the following payload:

```json
{"user_name":"attacker","age":60,"credit_balance":99999}
```

Since the endpoint is vulnerable to mass assignment, the attacker receives
credits without paying.

### Scenario #2

A video sharing portal allows users to upload content and download content in
different formats. An attacker who explores the API found that the endpoint
`GET /api/v1/videos/{video_id}/meta_data` returns a JSON object with the video’s
properties. One of the properties is `"mp4_conversion_params":"-v codec h264"`,
which indicates that the application uses a shell command to convert the video.

The attacker also found the endpoint `POST /api/v1/videos/new` is vulnerable to
mass assignment and allows the client to set any property of the video object.
The attacker sets a malicious value as follows:
`"mp4_conversion_params":"-v codec h264 && format C:/"`. This value will cause a
shell command injection once the attacker downloads the video as MP4.

## Τρόπος Πρόληψης

* If possible, avoid using functions that automatically bind a client’s input
  into code variables or internal objects.
* Whitelist only the properties that should be updated by the client.
* Use built-in features to blacklist properties that should not be accessed by
  clients.
* If applicable, explicitly define and enforce schemas for the input data
  payloads.

## Αναφορές

### Εξωτερικές

* [CWE-915: Improperly Controlled Modification of Dynamically-Determined Object Attributes][1]

[1]: https://cwe.mitre.org/data/definitions/915.html
