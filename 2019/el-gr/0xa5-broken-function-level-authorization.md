API5:2019 Broken Function Level Authorization
=============================================

| Παράγοντες Απειλής/Φορείς Επίθεσης | Αδυναμία Ασφαλείας | Επιπτώσεις |
| - | - | - |
| Εξαρτώνται από το API : Εκμεταλλευσιμότητα **3** | Επιπολασμός **2** : Ανιχνευσιμότητα **1** | Τεχνικές **2** : Εξαρτώνται από την Επιχείρηση |
| Η εκμετάλλευση (exploitation) απαιτεί από τον εισβολέα να στέλνει νόμιμες κλήσεις API στο τελικό σημείο API στο οποίο δεν θα πρέπει να έχει πρόσβαση. Αυτά τα τελικά σημεία ενδέχεται να εκτίθενται σε ανώνυμους χρήστες ή σε τακτικούς, μη προνομιούχους χρήστες. Είναι πιο εύκολο να ανακαλύψετε αυτά τα ελαττώματα στα API, καθώς τα API είναι πιο δομημένα και ο τρόπος πρόσβασης σε ορισμένες λειτουργίες είναι πιο προβλέψιμος (π.χ. αντικατάσταση της μεθόδου HTTP από GET σε PUT ή αλλαγή της συμβολοσειράς "χρήστες" στη διεύθυνση URL σε "διαχειριστές" ). | Η διαχείριση των ελέγχων εξουσιοδότησης για μια λειτουργία ή έναν πόρο γίνεται συνήθως μέσω διαμόρφωσης και μερικές φορές σε επίπεδο κώδικα. Η εφαρμογή σωστών ελέγχων μπορεί να είναι μια μπερδεμένη εργασία, καθώς οι σύγχρονες εφαρμογές μπορεί να περιέχουν πολλούς τύπους ρόλων ή ομάδων και πολύπλοκη ιεραρχία χρηστών (π.χ. υποχρήστες, χρήστες με περισσότερους από έναν ρόλους). | Τέτοια ελαττώματα επιτρέπουν στους εισβολείς να έχουν πρόσβαση σε μη εξουσιοδοτημένη λειτουργικότητα. Οι διοικητικές λειτουργίες (administrative functions) είναι βασικοί στόχοι για αυτόν τον τύπο επίθεσης. |

## Είναι το API ευάλωτο;

Ο καλύτερος τρόπος για να βρείτε ζητήματα εξουσιοδότησης σε επίπεδο κατεστραμμένων συναρτήσεων (Broken Function Level Authorization) είναι να πραγματοποιήσετε βαθιά ανάλυση του μηχανισμού εξουσιοδότησης, λαμβάνοντας παράλληλα υπόψη την ιεραρχία των χρηστών, διαφορετικούς ρόλους ή ομάδες στην εφαρμογή και θέτοντας τις ακόλουθες ερωτήσεις:

* Μπορεί ένας τακτικός χρήστης να έχει πρόσβαση στα τελικά σημεία διαχείρισης;
* Μπορεί ένας χρήστης να εκτελέσει ευαίσθητες ενέργειες (π.χ. δημιουργία, τροποποίηση ή διαγραφή) στις οποίες δεν θα έπρεπε να έχει πρόσβαση αλλάζοντας απλώς τη μέθοδο HTTP (π.χ. από "GET" σε "DELETE");
* Μπορεί ένας χρήστης από την ομάδα Χ να αποκτήσει πρόσβαση σε μια συνάρτηση που θα πρέπει να εκτίθεται μόνο σε χρήστες από την ομάδα Υ, μαντεύοντας απλώς τη διεύθυνση URL του τελικού σημείου και τις παραμέτρους (π.χ. `/api/v1/users/export_all`);

Μην υποθέτετε ότι ένα τελικό σημείο API είναι κανονικό ή διαχειριστικό μόνο με βάση τη διαδρομή URL.

Ενώ οι προγραμματιστές ενδέχεται να επιλέξουν να εκθέσουν τα περισσότερα από τα τελικά σημεία διαχείρισης σε μια συγκεκριμένη σχετική διαδρομή, όπως `api/admins`, είναι πολύ συνηθισμένο να βρίσκουμε αυτά τα τελικά σημεία διαχείρισης σε άλλες σχετικές διαδρομές μαζί με κανονικά τελικά σημεία, όπως `api/users`.

## Παραδείγματα Σεναρίων Επίθεσης

### Σενάριο #1

During the registration process to an application that allows only invited users
to join, the mobile application triggers an API call to
`GET /api/invites/{invite_guid}`. The response contains a JSON with details
about the invite, including the user’s role and the user’s email.

An attacker duplicated the request and manipulated the HTTP method and endpoint
to `POST /api/invites/new`. This endpoint should only be accessed by
administrators using the admin console, which does not implement function level
authorization checks.

The attacker exploits the issue and sends himself an invite to create an
admin account:

```
POST /api/invites/new

{“email”:”hugo@malicious.com”,”role”:”admin”}
```

### Σενάριο #2

An API contains an endpoint that should be exposed only to administrators -
`GET /api/admin/v1/users/all`. This endpoint returns the details of all the
users of the application and does not implement function-level authorization
checks. An attacker who learned the API structure takes an educated guess and
manages to access this endpoint, which exposes sensitive details of the users of
the application.

## Τρόπος Πρόληψης

Your application should have a consistent and easy to analyze authorization
module that is invoked from all your business functions. Frequently, such
protection is provided by one or more components external to the application
code.

* The enforcement mechanism(s) should deny all access by default, requiring
  explicit grants to specific roles for access to every function.
* Review your API endpoints against function level authorization flaws, while
  keeping in mind the business logic of the application and groups hierarchy.
* Make sure that all of your administrative controllers inherit from an
  administrative abstract controller that implements authorization checks based
  on the user’s group/role.
* Make sure that administrative functions inside a regular controller implements
  authorization checks based on the user’s group and role.

## Αναφορές

### OWASP

* [OWASP Article on Forced Browsing][1]
* [OWASP Top 10 2013-A7-Missing Function Level Access Control][2]
* [OWASP Development Guide: Chapter on Authorization][3]

### Εξωτερικές

* [CWE-285: Improper Authorization][4]

[1]: https://www.owasp.org/index.php/Forced_browsing
[2]: https://www.owasp.org/index.php/Top_10_2013-A7-Missing_Function_Level_Access_Control
[3]: https://www.owasp.org/index.php/Category:Access_Control
[4]: https://cwe.mitre.org/data/definitions/285.html
