API2:2019 Broken User Authentication
====================================

| Παράγοντες Απειλής/Φορείς Επίθεσης | Αδυναμία Ασφαλείας | Επιπτώσεις |
| - | - | - |
| Εξαρτώνται από το API : Εκμεταλλευσιμότητα **3** | Επιπολασμός **2** : Ανιχνευσιμότητα **2** | Τεχνικές **3** : Εξαρτώνται από την Επιχείρηση |
| Ο έλεγχος ταυτότητας στα API είναι ένας πολύπλοκος και μπερδεμένος μηχανισμός. Οι μηχανικοί λογισμικού και ασφάλειας ενδέχεται να έχουν λανθασμένες αντιλήψεις σχετικά με τα όρια του ελέγχου ταυτότητας και πώς να τον εφαρμόσουν σωστά. Επιπλέον, ο μηχανισμός ελέγχου ταυτότητας είναι ένας εύκολος στόχος για τους εισβολείς, καθώς είναι εκτεθειμένος σε όλους. Αυτά τα δύο σημεία καθιστούν το στοιχείο ελέγχου ταυτότητας δυνητικά ευάλωτο σε πολλά exploits. | Υπάρχουν δύο επιμέρους ζητήματα: 1. Έλλειψη μηχανισμών προστασίας: Τα τελικά σημεία API που είναι υπεύθυνα για τον έλεγχο ταυτότητας πρέπει να αντιμετωπίζονται διαφορετικά από τα κανονικά τελικά σημεία και να εφαρμόζουν επιπλέον επίπεδα προστασίας 2. Εσφαλμένη εφαρμογή του μηχανισμού: Ο μηχανισμός χρησιμοποιείται / υλοποιείται χωρίς να λαμβάνονται υπόψη  διανύσματα επίθεσης ή είναι λάθος η περίπτωση χρήσης (π.χ. ένας μηχανισμός ελέγχου ταυτότητας που έχει σχεδιαστεί για πελάτες IoT μπορεί να μην είναι η σωστή επιλογή για εφαρμογές Ιστού). | Οι εισβολείς μπορούν να αποκτήσουν τον έλεγχο των λογαριασμών άλλων χρηστών στο σύστημα, να διαβάσουν τα προσωπικά τους δεδομένα και να εκτελέσουν ευαίσθητες ενέργειες για λογαριασμό τους, όπως συναλλαγές χρημάτων και αποστολή προσωπικών μηνυμάτων. |

## Είναι το API ευάλωτο;

Τα τελικά σημεία και οι ροές ελέγχου ταυτότητας είναι στοιχεία που πρέπει να προστατεύονται. Το "Ξέχασα τον κωδικό πρόσβασης / επαναφορά κωδικού πρόσβασης" θα πρέπει να αντιμετωπίζεται με τον ίδιο τρόπο όπως και οι μηχανισμοί ελέγχου ταυτότητας.

Ένα API είναι ευάλωτο εάν:
* Επιτρέπει [credential stuffing][1] με το οποίο ο εισβολέας έχει μια λίστα με έγκυρα ονόματα χρήστη και κωδικούς πρόσβασης.
* Επιτρέπει στους εισβολείς να εκτελούν επίθεση ωμής βίας (brute force attack) στον ίδιο λογαριασμό χρήστη, χωρίς να παρουσιάζουν μηχανισμό κλειδώματος captcha/λογαριασμού.
* Επιτρέπει αδύναμους κωδικούς πρόσβασης.
* Στέλνει ευαίσθητες λεπτομέρειες ελέγχου ταυτότητας, όπως διακριτικά ταυτότητας και κωδικούς πρόσβασης στη διεύθυνση URL.
* Δεν επικυρώνει την αυθεντικότητα των διακριτικών.
* Αποδέχεται ανυπόγραφα/ασθενώς υπογεγραμμένα διακριτικά JWT (`"alg":"none"`)/δεν επικυρώνει την ημερομηνία λήξης τους.
* Χρησιμοποιεί απλό κείμενο, μη κρυπτογραφημένους ή ασθενώς κατακερματισμένους κωδικούς πρόσβασης.
* Χρησιμοποιεί αδύναμα κλειδιά κρυπτογράφησης.

## Παράδειγμα Σεναρίων Επίθεσης

## Σενάριο #1

[Credential stuffing][1] (using [lists of known usernames/passwords][2]), is a
common attack. If an application does not implement automated threat or
credential stuffing protections, the application can be used as a password
oracle (tester) to determine if the credentials are valid.

## Σενάριο #2

An attacker starts the password recovery workflow by issuing a POST request to
`/api/system/verification-codes` and by providing the username in the request
body. Next an SMS token with 6 digits is sent to the victim’s phone. Because the
API does not implement a rate limiting policy, the attacker can test all
possible combinations using a multi-threaded script, against the
`/api/system/verification-codes/{smsToken}` endpoint to discover the right token
within a few minutes.

## Τρόπος Πρόληψης

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

## Αναφορές

### OWASP

* [OWASP Key Management Cheat Sheet][6]
* [OWASP Authentication Cheatsheet][3]
* [Credential Stuffing][1]

### Εξωτερικές

* [CWE-798: Use of Hard-coded Credentials][7]

[1]: https://www.owasp.org/index.php/Credential_stuffing
[2]: https://github.com/danielmiessler/SecLists
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[4]: https://www.owasp.org/index.php/Testing_for_Weak_lock_out_mechanism_(OTG-AUTHN-003)
[5]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[6]: https://www.owasp.org/index.php/Key_Management_Cheat_Sheet
[7]: https://cwe.mitre.org/data/definitions/798.html
