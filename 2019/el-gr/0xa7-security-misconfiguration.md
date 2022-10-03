API7:2019 Security Misconfiguration
===================================

| Παράγοντες Απειλής (Threat agents) / Φορείς Επίθεσης (Attack vectors) | Αδυναμία Ασφαλείας (Security Weakness) | Επιπτώσεις (Impacts) |
| - | - | - |
| Εξαρτώνται από το API : Εκμεταλλευσιμότητα **3** | Επιπολασμός **3** : Ανιχνευσιμότητα **3** | Τεχνικές Επιπτώσεις **2** : Εξαρτώνται από την Επιχείρηση |
| Οι εισβολείς συχνά επιχειρούν να βρουν μη επιδιορθωμένα ελαττώματα (unpatched flows), κοινά τελικά σημεία ή μη προστατευμένα αρχεία και καταλόγους για να αποκτήσουν μη εξουσιοδοτημένη πρόσβαση ή γνώση του συστήματος. | Λανθασμένες ρυθμίσεις παραμέτρων ασφαλείας (Security Misconfigurations) μπορούν να υπάρξουν σε οποιοδήποτε επίπεδο της στοίβας API (API stack), από το επίπεδο δικτύου έως το επίπεδο εφαρμογής. Διατίθενται αυτοματοποιημένα εργαλεία για τον εντοπισμό και την εκμετάλλευση εσφαλμένων διαμορφώσεων, όπως περιττές υπηρεσίες ή επιλογές παλαιού τύπου (legacy options). | Οι εσφαλμένες διαμορφώσεις ασφαλείας όχι μόνο εκθέτουν ευαίσθητα δεδομένα χρήστη, αλλά και λεπτομέρειες συστήματος που μπορεί να οδηγήσουν σε πλήρη παραβίαση του διακομιστή. |

## Πότε το API είναι ευάλωτο

Το API μπορεί να είναι ευάλωτο όταν:

* Δεν υπάρχει η κατάλληλη θωράκιση ασφαλείας (security hardening) σε όλα τα 
μέρη της στοίβας της εφαρμογής, ή υπάρχουν λανθασμένες ρυθμίσεις δικαιωμάτων σε υπηρεσίες Cloud. 
* Δεν έχουν εγκατασταθεί οι ενημερωμένες εκδόσεις ασφαλείας, ή τα συστήματα είναι παροχημένα.
* Αχρείαστα χαρακτηριστικά (features) είναι ενεργοποιημένα (για παράδειγμα, το API δέχεται HTTP verbs που δεν χρησιμοποιούνται).
* Δεν υπάρχει Transport Layer Security (TLS).
* Οι οδηγίες ασφαλείας (security directives) δεν στέλνονται στους clients (e.g., [Επικεφαλίδες Ασφαλείας][1]).
* Δεν υπάρχει πολιτική Cross-Origin Resource Sharing (CORS) ή έχει ρυθμιστεί εσφαλμένα.
* Τα μηνύματα σφαλμάτων περιλαμβάνουν το ίχνος στοίβας (stack trace) ή άλλες ευαίσθητες πληροφορίες είναι εκτεθειμένες.

## Παραδείγματα από Σενάρια Επίθεσης

### Σενάριο #1

Ένας εισβολέας βρίσκει το αρχείο `.bash_history` κάτω από τον κεντρικό φάκελο (root folder)
του διακομιστή, το οποίο περιλαμβάνει εντολές που χρησιμοποιήθηκαν από την ομάδα DevOps για να έχει πρόσβαση στο API:

```
$ curl -X GET 'https://api.server/endpoint/' -H 'authorization: Basic Zm9vOmJhcg=='
```

Ένας εισβολέας θα μπορούσε επίσης να βρει άγνωστα τελικά σημεία του API που
χρησιμοποιούνται μόνο απο την ομάδα DevOps και τα οποία δεν είναι τεκμηριωμένα.

### Σενάριο #2

Με στόχο μια συγκεκριμένη υπηρεσία, ένας εισβολέας χρησιμοποιεί μια δημοφιλή μηχανή αναζήτησης για να αναζητήσει
υπολογιστές άμεσα προσβάσιμους από το Διαδίκτυο. Ο εισβολέας βρίσκει έναν διακομιστή που τρέχει ένα δημοφιλές σύστημα
διαχείρισης βάσεων δεδομένων, το οποίο ακούει στην προεπιλεγμένη θύρα.
Ο διακομιστής αυτός χρησιμοποιεί τις προεπιλεγμένες ρυθμίσεις (default configuration), οι οποίες έχουν απενεργοποιημένο
τον έλεγχο ταυτότητας, με αποτέλεσμα ο εισβολέας να απεκτήσει πρόσβαση σε εκατομμύρια εγγραφές με PII,
προσωπικές προτιμήσεις και δεδομένα ελέγχου ταυτότητας.

### Σενάριο #3

Επιθεωρώντας την κίνηση δεδομένων μιας εφαρμογής για κινητά, 
ένας εισβολέας ανακαλύπτει ότι η κίνηση HTTP δεν εκτελείται ολικά κάτω από ένα ασφαλές πρωτόκολλο (π.χ. TLS).
Ο εισβολέας ανακαλύπτει ότι αυτό συμβαίνει ειδικά για τη λήψη εικόνων προφίλ. 
Καθώς η αλληλεπίδραση του χρήστη είναι δυαδική και παρά το γεγονός ότι η υπόλοιπη κίνηση API εκτελείται κάτω από ένα ασφαλές πρωτόκολλο, 
ο εισβολέας βρίσκει ένα μοτίβο στο μέγεθος των απαντήσεων API, 
το οποίο χρησιμοποιεί για να παρακολουθεί τις προτιμήσεις των χρηστών σε σχέση με το περιεχόμενο που εμφανίζεται (π.χ. εικόνες προφίλ).

## Τρόπος Πρόληψης

Ο κύκλος ζωής των API θα πρέπει να περιλαμβάνει τα παρακάτω:

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
