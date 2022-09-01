API7:2019 Security Misconfiguration
===================================

| Παράγοντες Απειλής (Threat agents) / Φορείς Επίθεσης (Attack vectors) | Αδυναμία Ασφαλείας (Security Weakness) | Επιπτώσεις (Impacts) |
| - | - | - |
| Εξαρτώνται από το API : Εκμεταλλευσιμότητα **3** | Επιπολασμός **3** : Ανιχνευσιμότητα **3** | Τεχνικές Επιπτώσεις **2** : Εξαρτώνται από την Επιχείρηση |
| Οι εισβολείς συχνά επιχειρούν να βρουν μη επιδιορθωμένα ελαττώματα (unpatched flows), κοινά τελικά σημεία ή μη προστατευμένα αρχεία και καταλόγους για να αποκτήσουν μη εξουσιοδοτημένη πρόσβαση ή γνώση του συστήματος. | Λανθασμένες ρυθμίσεις παραμέτρων ασφαλείας (Security Misconfigurations) μπορούν να υπάρξουν σε οποιοδήποτε επίπεδο της στοίβας API (API stack), από το επίπεδο δικτύου έως το επίπεδο εφαρμογής. Διατίθενται αυτοματοποιημένα εργαλεία για τον εντοπισμό και την εκμετάλλευση εσφαλμένων διαμορφώσεων, όπως περιττές υπηρεσίες ή επιλογές παλαιού τύπου (legacy options). | Οι εσφαλμένες διαμορφώσεις ασφαλείας όχι μόνο εκθέτουν ευαίσθητα δεδομένα χρήστη, αλλά και λεπτομέρειες συστήματος που μπορεί να οδηγήσουν σε πλήρη παραβίαση του διακομιστή. |

## Πότε το API είναι ευάλωτο

Το API μπορεί να είναι ευάλωτο αν:

* Δεν υπάρχει η κατάλληλη θωράκιση ασφαλείας (security hardening) σε όλα τα 
μέρη της στοίβας της εφαρμογής, ή υπάρχουν λάθος ρυθμίσεις δικαιωμάτων σε υπηρεσίες Cloud. 
* Δεν έχουν εγκατασταθεί οι ενημερωμένες εκδόσεις ασφαλείας, ή τα συστήματα είναι παροχημένα.
* Άχρηστες δυνατότητες (features) είναι ενεργοποιημένες (για παράδειγμα, HTTP verbs που δεν χρησιμοποιούνται).
* Δεν υπάρχει Transport Layer Security (TLS).
* Security directives are not sent to clients (e.g., [Security Headers][1]).
* A Cross-Origin Resource Sharing (CORS) policy is missing or improperly set.
* Error messages include stack traces, or other sensitive information is
  exposed.

## Παραδείγματα Σεναρίων Επίθεσης

### Σενάριο #1

An attacker finds the `.bash_history` file under the root directory of the
server, which contains commands used by the DevOps team to access the API:

```
$ curl -X GET 'https://api.server/endpoint/' -H 'authorization: Basic Zm9vOmJhcg=='
```

An attacker could also find new endpoints on the API that are used only by the
DevOps team and are not documented.

### Σενάριο #2

To target a specific service, an attacker uses a popular search engine to search
for  computers directly accessible from the Internet. The attacker found a host
running a popular database management system, listening on the default port. The
host was using the default configuration, which has authentication disabled by
default, and the attacker gained access to millions of records with PII,
personal preferences, and authentication data.

### Σενάριο #3

Inspecting traffic of a mobile application an attacker finds out that not all
HTTP traffic is performed on a secure protocol (e.g., TLS). The attacker finds
this to be true, specifically for the download of profile images. As user
interaction is binary, despite the fact that API traffic is performed on a
secure protocol, the attacker finds a pattern on API responses size, which he
uses to track user preferences over the rendered content (e.g., profile images).

## Τρόπος Πρόληψης

The API life cycle should include:

* A repeatable hardening process leading to fast and easy deployment of a
  properly locked down environment.
* A task to review and update configurations across the entire API stack. The
  review should include: orchestration files, API components, and cloud services
  (e.g., S3 bucket permissions).
* A secure communication channel for all API interactions access to static
  assets (e.g., images).
* An automated process to continuously assess the effectiveness of the
  configuration and settings in all environments.

Furthermore:

* To prevent exception traces and other valuable information from being sent
  back to attackers, if applicable, define and enforce all API response payload
  schemas including error responses.
* Ensure API can only be accessed by the specified HTTP verbs. All other HTTP
  verbs should be disabled (e.g. `HEAD`).
* APIs expecting to be accessed from browser-based clients (e.g., WebApp
  front-end) should implement a proper Cross-Origin Resource Sharing (CORS)
  policy.

## Αναφορές

### OWASP

* [OWASP Secure Headers Project][1]
* [OWASP Testing Guide: Configuration Management][2]
* [OWASP Testing Guide: Testing for Error Codes][3]
* [OWASP Testing Guide: Test Cross Origin Resource Sharing][9]

### Εξωτερικές

* [CWE-2: Environmental Security Flaws][4]
* [CWE-16: Configuration][5]
* [CWE-388: Error Handling][6]
* [Guide to General Server Security][7], NIST
* [Let’s Encrypt: a free, automated, and open Certificate Authority][8]

[1]: https://www.owasp.org/index.php/OWASP_Secure_Headers_Project
[2]: https://www.owasp.org/index.php/Testing_for_configuration_management
[3]: https://www.owasp.org/index.php/Testing_for_Error_Code_(OTG-ERR-001)
[4]: https://cwe.mitre.org/data/definitions/2.html
[5]: https://cwe.mitre.org/data/definitions/16.html
[6]: https://cwe.mitre.org/data/definitions/388.html
[7]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[8]: https://letsencrypt.org/
[9]: https://www.owasp.org/index.php/Test_Cross_Origin_Resource_Sharing_(OTG-CLIENT-007)
