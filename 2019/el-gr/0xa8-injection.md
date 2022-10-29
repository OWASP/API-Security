API8:2019 Injection
===================

| Παράγοντες Απειλής (Threat agents) / Φορείς Επίθεσης (Attack vectors) | Αδυναμία Ασφαλείας (Security Weakness) | Επιπτώσεις (Impacts) |
| - | - | - |
| Εξαρτώνται από το API : Εκμεταλλευσιμότητα **3** | Επιπολασμός  **2** : Ανιχνευσιμότητα **3** | Τεχνικές Επιπτώσεις **3** : Εξαρτώνται από την Επιχείρηση |
| Οι εισβολείς τροφοδοτούν το API με κακόβουλα δεδομένα μέσω οποιωνδήποτε διαθέσιμων διανυσμάτων έγχυσης (injection vectors) (π.χ. άμεση εισαγωγή (direct input), παράμετροι (parameters), ενσωματωμένες υπηρεσίες (integrated services) κ.λπ.), αναμένοντας να σταλούν τελικώς σε έναν διερμηνέα (interpreter). | Οι ευπάθειες ένεσης είναι πολύ κοινές και εντοπίζονται συχνά σε ερωτήματα SQL, LDAP ή NoSQL, εντολές λειτουργικού συστήματος, αναλυτές XML και ORM. Αυτές οι ευπάθειες είναι εύκολο να εντοπιστούν κατά τον έλεγχο του πηγαίου κώδικα. Οι επιτιθέμενοι μπορούν να χρησιμοποιήσουν σαρωτές και fuzzers για να εντωπίσουν τέτοιες ευπάθειες. | Η έγχυση (injection) μπορεί να οδηγήσει σε αποκάλυψη πληροφοριών και απώλεια δεδομένων. Μπορεί επίσης να οδηγήσει σε DoS ή πλήρη κατάληψη του κεντρικού υπολογιστή. |

## Πότε το API είναι ευάλωτο

Πότε το API είναι ευάλωτο σε ευπάθεια έγχυσης (injection flaw) όταν:

* Τα δεδομένα που παρέχονται από τον πελάτη δεν επικυρώνονται, φιλτράρονται ή απολυμαίνονται (sanitized) από το API.
* Τα δεδομένα που παρέχονται από τον πελάτη χρησιμοποιούνται απευθείας ή συνδέονται με ερωτήματα SQL/NoSQL/LDAP, εντολές λειτουργικού συστήματος, αναλυτές XML και σχεσιακή αντιστοίχιση αντικειμένων (ORM) / χαρτογράφηση εγγράφων αντικειμένου (ODM).
* Τα δεδομένα που προέρχονται από εξωτερικά συστήματα (π.χ. ολοκληρωμένα συστήματα) δεν επικυρώνονται, φιλτράρονται ή απολυμαίνονται από το API.

## Παραδείγματα από Σενάρια Επίθεσης

### Σενάριο #1

Firmware of a parental control device provides the endpoint
`/api/CONFIG/restore` which expects an appId to be sent as a multipart
parameter. Using a decompiler, an attacker finds out that the appId is passed
directly into a system call without any sanitization:

```c
snprintf(cmd, 128, "%srestore_backup.sh /tmp/postfile.bin %s %d",
         "/mnt/shares/usr/bin/scripts/", appid, 66);
system(cmd);
```

The following command allows the attacker to shut down any device with the same
vulnerable firmware:

```
$ curl -k "https://${deviceIP}:4567/api/CONFIG/restore" -F 'appid=$(/etc/pod/power_down.sh)'
```

### Σενάριο #2

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

The attacker intercepted the request and changed `bookingId` query string
parameter as shown below. In this case, the attacker managed to delete another
user's booking:

```
DELETE /api/bookings?bookingId[$ne]=678
```

## Τρόπος Πρόληψης

Η πρόληψη της έγχυσης απαιτεί τη διατήρηση των δεδομένων ξεχωριστά από εντολές και ερωτήματα.

* Εκτελέστε επικύρωση δεδομένων χρησιμοποιώντας μια ενιαία, αξιόπιστη και ενεργά συντηρούμενη βιβλιοθήκη.
* Επικύρωση, φιλτράρισμα και απολύμανση όλων των δεδομένων που παρέχονται από τον πελάτη ή άλλων δεδομένων που προέρχονται από ενσωματωμένα συστήματα.
* Οι ειδικοί χαρακτήρες θα πρέπει να διαφεύγονται(escaped) χρησιμοποιώντας τη συγκεκριμένη σύνταξη διερμηνέα προορισμού.
* Προτιμήστε ένα ασφαλές API που παρέχει μια παραμετροποιημένη διεπαφή.
* Φροντίστε να περιορίσετε τον αριθμό των επιστρεφόμενων εγγραφών για να αποτρέψετε τη μαζική αποκάλυψη σε περίπτωση ένεσης.
* Επικυρώστε τα εισερχόμενα δεδομένα χρησιμοποιώντας επαρκή φίλτρα για να επιτρέπονται μόνο έγκυρες τιμές για κάθε παράμετρο εισόδου.
* Ορίστε τύπους δεδομένων και αυστηρά μοτίβα για όλες τις παραμέτρους συμβολοσειράς.

## Αναφορές (References)

### Αναφορές OWASP

* [OWASP Injection Flaws][1]
* [SQL Injection][2]
* [NoSQL Injection Fun with Objects and Arrays][3]
* [Command Injection][4]

### Εξωτερικές Αναφορές

* [CWE-77: Command Injection][5]
* [CWE-89: SQL Injection][6]

[1]: https://www.owasp.org/index.php/Injection_Flaws
[2]: https://www.owasp.org/index.php/SQL_Injection
[3]: https://www.owasp.org/images/e/ed/GOD16-NOSQL.pdf
[4]: https://www.owasp.org/index.php/Command_Injection
[5]: https://cwe.mitre.org/data/definitions/77.html
[6]: https://cwe.mitre.org/data/definitions/89.html
