API4:2019 Lack of Resources & Rate Limiting
===========================================

| Παράγοντες Απειλής/Φορείς Επίθεσης | Αδυναμία Ασφαλείας | Επιπτώσεις |
| - | - | - |
| Εξαρτώνται από το API : Εκμεταλλευσιμότητα **2** | Επιπολασμός **3** : Ανιχνευσιμότητα **3** | Τεχνικές **2** : Εξαρτώνται από την Επιχείρηση |
| Η εκμετάλλευση (exploitation) απαιτεί απλά αιτήματα API. Δεν απαιτείται έλεγχος ταυτότητας. Πολλαπλές ταυτόχρονες αιτήσεις μπορούν να εκτελεστούν από έναν μόνο τοπικό υπολογιστή ή χρησιμοποιώντας πόρους υπολογιστικού νέφους. | Είναι σύνηθες να βρίσκουμε API που δεν εφαρμόζουν περιορισμό ρυθμού (rate limiting) ή API όπου τα όρια δεν έχουν οριστεί σωστά. | Η εκμετάλλευση (exploitation) μπορεί να οδηγήσει σε DoS, καθιστώντας το API μη ανταποκρινόμενο ή ακόμη και μη διαθέσιμο. |

## Είναι το API ευάλωτο;

Τα αιτήματα API καταναλώνουν πόρους όπως δίκτυο, CPU, μνήμη και αποθήκευση. Το ποσό των πόρων που απαιτούνται για την ικανοποίηση ενός αιτήματος εξαρτάται σε μεγάλο βαθμό από την είσοδο του χρήστη και την επιχειρηματική λογική του τελικού σημείου. Επίσης, λάβετε υπόψη το γεγονός ότι τα αιτήματα από πολλούς πελάτες API ανταγωνίζονται για πόρους. Ένα API είναι ευάλωτο εάν τουλάχιστον ένα από τα ακόλουθα όρια λείπει ή έχει οριστεί ακατάλληλα (π.χ. πολύ χαμηλό/υψηλό):

* Χρονικά όρια εκτέλεσης (Execution timeouts)
* Μέγιστη εκχωρούμενη μνήμη
* Αριθμός περιγραφέων αρχείου (file descriptors)
* Αριθμός διεργασιών (processes)
* Μέγεθος αιτήματος ωφέλιμου φορτίου (Request payload size) (π.χ. μεταφορτώσεις) 
* Αριθμός αιτημάτων ανά πρόγραμμα-πελάτη/πόρο
* Αριθμός εγγραφών ανά σελίδα προς επιστροφή σε μία απάντηση αιτήματος

## Παραδείγματα σεναρίων επίθεσης

### Σενάριο #1

Ένας εισβολέας ανεβάζει μια μεγάλη εικόνα υποβάλλοντας ένα αίτημα POST στο `/api/v1/images`.
Όταν ολοκληρωθεί η μεταφόρτωση, το API δημιουργεί πολλές μικρογραφίες με διαφορετικά μεγέθη.
Λόγω του μεγέθους της μεταφορτωμένης εικόνας, η διαθέσιμη μνήμη εξαντλείται κατά τη δημιουργία 
μικρογραφιών και το API δεν ανταποκρίνεται.

### Σενάριο #2

We have an application that contains the users' list on a UI with a limit of
`200` users per page. The users' list is retrieved from the server using the
following query: `/api/users?page=1&size=200`. An attacker changes the `size`
parameter to `200 000`, causing performance issues on the database. Meanwhile,
the API becomes unresponsive and is unable to handle further requests from this
or any other clients (aka DoS).

The same scenario might be used to provoke Integer Overflow or Buffer Overflow
errors.

## Τρόπος Πρόληψης

* Docker makes it easy to limit [memory][1], [CPU][2], [number of restarts][3],
  [file descriptors, and processes][4].
* Implement a limit on how often a client can call the API within a defined
  timeframe.
* Notify the client when the limit is exceeded by providing the limit number and
  the time at which the limit will be reset.
* Add proper server-side validation for query string and request body
  parameters, specifically the one that controls the number of records to be
  returned in the response.
* Define and enforce maximum size of data on all incoming parameters and
  payloads such as maximum length for strings and maximum number of elements in
  arrays.


## Αναφορές

### OWASP

* [Blocking Brute Force Attacks][5]
* [Docker Cheat Sheet - Limit resources (memory, CPU, file descriptors,
  processes, restarts)][6]
* [REST Assessment Cheat Sheet][7]

### Εξωτερικές

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
