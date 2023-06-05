# API4:2019 Lack of Resources & Rate Limiting

| Παράγοντες Απειλής (Threat agents) / Φορείς Επίθεσης (Attack vectors) | Αδυναμία Ασφαλείας (Security Weakness) | Επιπτώσεις (Impacts) |
| - | - | - |
| Εξαρτώνται από το API : Εκμεταλλευσιμότητα **2** | Επικράτηση (Prevalence) **3** : Ανιχνευσιμότητα **3** | Τεχνικές Επιπτώσεις **2** : Εξαρτώνται από την Επιχείρηση |
| Η εκμετάλλευση (exploitation) αυτής της αδυναμίας ασφαλείας απαιτεί μόνο την αποστολή απλών αιτημάτων (requests) στο API. Δεν απαιτείται έλεγχος ταυτότητας. Πολλαπλά ταυτόχρονα αιτήματα (requests) μπορούν να αποσταλούν από έναν μόνο τοπικό υπολογιστή ή χρησιμοποιώντας πόρους υπολογιστικού νέφους (cloud computing). | Είναι σύνηθες να βρίσκουμε API που δεν εφαρμόζουν περιορισμό ρυθμού (rate limiting) ή APIs όπου τα όρια περιορισμού δεν έχουν οριστεί σωστά. | Η εκμετάλλευση (exploitation) μπορεί να οδηγήσει σε επιθέσεις άρνησης υπηρεσιών (DoS), καθιστώντας το API μη ανταποκρινόμενο ή ακόμη και μη διαθέσιμο. |

## Πότε το API είναι ευάλωτο

Τα αιτήματα (requests) API καταναλώνουν πόρους (resources) όπως πόρους δικτύου, επεξεργαστή (CPU), μνήμης και αποθήκευσης. Το ποσό των πόρων που απαιτούνται για την ολοκλήρωση ενός αιτήματος εξαρτάται σε μεγάλο βαθμό από τα δεδομένα εισόδου του χρήστη και την επιχειρηματική λογική (business logic) του τελικού σημείου προορισμού (endpoint). Επίσης, λάβετε υπόψη το γεγονός ότι τα αιτήματα από πολλαπλούς πελάτες API ανταγωνίζονται για τους πόρους του συστήματος. Ένα API είναι ευάλωτο εάν τουλάχιστον ένα από τα ακόλουθα όρια περιορισμού λείπει ή τα όρια περιορισμού δεν έχουν οριστεί καταλλήλως (π.χ. πολύ χαμηλά/υψηλά):

* Χρονικά όρια εκτέλεσης (execution timeouts)
* Μέγιστο ποσό δέσμευσης μνήμης
* Αριθμός περιγραφέων αρχείου (file descriptors)
* Αριθμός διεργασιών (processes)
* Μέγεθος αιτήματος ωφέλιμου φορτίου (request payload size) (π.χ. μεταφορτώσεις (uploads)) 
* Αριθμός αιτημάτων ανά πρόγραμμα-πελάτη/πόρο συστήματος
* Αριθμός εγγραφών ανά σελίδα που περιέχονται σε κάθε απάντηση αιτήματος (request response)

## Παραδείγματα από Σενάρια Επίθεσης

### Σενάριο #1

Ένας εισβολέας ανεβάζει μια μεγάλη εικόνα υποβάλλοντας ένα αίτημα POST στο `/api/v1/images`.
Όταν ολοκληρωθεί η μεταφόρτωση, το API δημιουργεί πολλές μικρογραφίες (thumbnails) με διαφορετικά μεγέθη.
Λόγω του μεγάλου μεγέθους της μεταφορτωμένης εικόνας, η διαθέσιμη μνήμη του συστήματος εξαντλείται κατά τη δημιουργία μικρογραφιών και το API σταματάει να ανταποκρίνεται.

### Σενάριο #2

Έχουμε μια εφαρμογή που περιέχει τη λίστα χρηστών σε μια διεπαφή χρήστη (UI) με όριο 
200 χρήστες ανά σελίδα. Η λίστα των χρηστών ανακτάται από τον διακομιστή (server) χρησιμοποιώντας 
το ακόλουθο ερώτημα: `/api/users?page=1&size=200`. Ένας εισβολέας αλλάζει την παράμετρο 
μεγέθους σε `200 000`, προκαλώντας προβλήματα απόδοσης (performance) στη βάση δεδομένων. 
Τα προβλήματα απόδοσης της βάσης δεδομένων σταματούν το API από το να ανταποκρίνεται και
το API δεν είναι πλέον σε θέση να χειριστεί περαιτέρω αιτήματα από τον τρέχων ή άλλους πελάτες (γνωστό και ως DoS).

Το ίδιο σενάριο μπορεί να χρησιμοποιηθεί για την πρόκληση σφαλμάτων υπερχείλισης ακεραίων (Integer Overflow) ή υπερχείλισης buffer (Buffer Overflow).

## Τρόπος Πρόληψης

* Το Docker διευκολύνει τον περιορισμό της [μνήμης][1], του [επεξεργαστή CPU][2], τον [αριθμό επανεκκινήσεων][3],
  των [περιγραφέων αρχείου (file descriptors), και διεργασιών (processes)][4].
* Εφαρμόστε ένα όριο περιορισμού σχετικά με το πόσο συχνά ένα πρόγραμμα-πελάτης μπορεί να καλεί το API εντός ενός καθορισμένου χρονικού πλαισίου.
* Ειδοποιήστε το πρόγραμμα-πελάτη όταν γίνεται υπέρβαση του ορίου παρέχοντας τον αριθμό ορίου και την ώρα κατά την οποία θα γίνει επαναφορά του ορίου.
* Προσθέστε την κατάλληλη επικύρωση (validation) από την πλευρά του διακομιστή για τις παραμέτρους συμβολοσειράς ερωτήματος (query string) και σώματος αιτήματος (request body), ειδικά αυτή που ελέγχει τον αριθμό των εγγραφών που θα επιστραφούν στην απάντηση.
* Καθορίστε και επιβάλλετε μέγιστο μέγεθος δεδομένων σε όλες τις εισερχόμενες παραμέτρους και ωφέλιμα φορτία (payloads), 
όπως το μέγιστο μήκος για τις συμβολοσειρές (strings) και τον μέγιστο αριθμό στοιχείων σε πίνακες (elements in arrays).


## Αναφορές (References)

### Αναφορές OWASP

* [Blocking Brute Force Attacks][5]
* [Docker Cheat Sheet - Limit resources (memory, CPU, file descriptors,
  processes, restarts)][6]
* [REST Assessment Cheat Sheet][7]

### Εξωτερικές Αναφορές

* [CWE-307: Improper Restriction of Excessive Authentication Attempts][8]
* [CWE-770: Allocation of Resources Without Limits or Throttling][9]
* “_Rate Limiting (Throttling)_” - [Security Strategies for Microservices-based
  Application Systems][10], NIST

[1]: https://docs.docker.com/config/containers/resource_constraints/#memory
[2]: https://docs.docker.com/config/containers/resource_constraints/#cpu
[3]: https://docs.docker.com/engine/reference/commandline/run/#restart-policies---restart
[4]: https://docs.docker.com/engine/reference/commandline/run/#set-ulimits-in-container---ulimit
[5]: https://www.owasp.org/index.php/Blocking_Brute_Force_Attacks
[6]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/Docker_Security_Cheat_Sheet.md#rule-7---limit-resources-memory-cpu-file-descriptors-processes-restarts
[7]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/REST_Assessment_Cheat_Sheet.md
[8]: https://cwe.mitre.org/data/definitions/307.html
[9]: https://cwe.mitre.org/data/definitions/770.html
[10]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204-draft.pdf
