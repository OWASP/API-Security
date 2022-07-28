API6:2019 Mass Assignment
===========================

| Παράγοντες Απειλής (Threat agents) / Φορείς Επίθεσης (Attack vectors) | Αδυναμία Ασφαλείας (Security Weakness) | Επιπτώσεις (Impacts) |
| - | - | - |
| Εξαρτώνται από το API : Εκμεταλλευσιμότητα **2** | Επιπολασμός **2** : Ανιχνευσιμότητα **2** | Τεχνικές Επιπτώσεις **2** : Εξαρτώνται από την Επιχείρηση |
| Η εκμετάλλευση (exploitation) συνήθως απαιτεί κατανόηση της επιχειρηματικής λογικής (business logic), των σχέσεων των αντικειμένων και της δομής του API.  Η εκμετάλλευση της μαζικής εκχώρησης (Mass Assignment) είναι ευκολότερη στα API, καθώς από το σχεδιασμό τους εκθέτουν την υλοποίηση της εφαρμογής μαζί με τα ονόματα των ιδιοτήτων (properties' names). | Τα σύγχρονα frameworks ενθαρρύνουν τους προγραμματιστές να χρησιμοποιούν συναρτήσεις (functions) που συνδέουν αυτόματα την είσοδο από τον API client σε μεταβλητές κώδικα και εσωτερικά αντικείμενα. Οι εισβολείς μπορούν να χρησιμοποιήσουν αυτήν τη μεθοδολογία για να ενημερώσουν ή να αντικαταστήσουν τις ιδιότητες ευαίσθητων αντικειμένων (object properties) που οι προγραμματιστές δεν σκόπευαν ποτέ να εκθέσουν. | Η εκμετάλλευση (exploitation) μπορεί να οδηγήσει σε κλιμάκωση των προνομίων (privilege escalation), παραποίηση δεδομένων (data tampering), παράκαμψη μηχανισμών ασφαλείας και πολλά άλλα. |

## Πότε το API είναι ευάλωτο;

Τα αντικείμενα (objects) στις σύγχρονες εφαρμογές μπορεί να περιέχουν πολλές ιδιότητες (properties). 
Ορισμένες από αυτές τις ιδιότητες θα πρέπει να ενημερωθούν απευθείας από τον API client 
(π.χ. `user.first_name` ή `user.address`) και ορισμένες από αυτές όχι (π.χ. `user.is_vip`).

Ένα τελικό σημείο API είναι ευάλωτο εάν μετατρέπει αυτόματα τις παραμέτρους του προγράμματος-πελάτη σε ιδιότητες εσωτερικού αντικειμένου, χωρίς να λαμβάνεται υπόψη η ευαισθησία και το επίπεδο έκθεσης αυτών των ιδιοτήτων. Αυτό θα μπορούσε να επιτρέψει σε έναν εισβολέα να ενημερώσει τις ιδιότητες αντικειμένων (object properties) στις οποίες δεν θα έπρεπε να έχει πρόσβαση.

Παραδείγματα για ευαίσθητες ιδιότητες (properties):

* **Ιδιότητες που σχετίζονται με δικαιώματα**: Τα `user.is_admin`, `user.is_vip` θα πρέπει να ορίζονται μόνο από διαχειριστές.
* **Ιδιότητες που εξαρτώνται από κάποια διαδικασία (process)**: Το `user.cash` θα πρέπει να οριστεί εσωτερικά μόνο μετά την επαλήθευση πληρωμής.
* **Εσωτερικές ιδιότητες**: Το `article.created_time` θα πρέπει να οριστεί εσωτερικά και μόνο από την εφαρμογή.

## Παραδείγματα Σεναρίων Επίθεσης

### Σενάριο #1

Μια εφαρμογή κοινής χρήσης διαδρομής (ride sharing) παρέχει στον χρήστη την επιλογή να επεξεργαστεί βασικές πληροφορίες για το προφίλ του. 
Κατά τη διάρκεια αυτής της διαδικασίας, αποστέλλεται μια κλήση API στο
`PUT /api/v1/users/me` με το ακόλουθο νόμιμο αντικείμενο JSON:

```json
{"user_name":"inons","age":24}
```

Το αίτημα `GET /api/v1/users/me` περιλαμβάνει μια πρόσθετη ιδιότητα credit_balance:

```json
{"user_name":"inons","age":24,"credit_balance":10}
```

Ο εισβολέας επαναλαμβάνει το πρώτο αίτημα με το ακόλουθο payload:
```json
{"user_name":"attacker","age":60,"credit_balance":99999}
```

Δεδομένου ότι το τελικό σημείο είναι ευάλωτο σε μαζική εκχώρηση (Mass Assignment), ο εισβολέας λαμβάνει πιστώσεις χωρίς να πληρώσει.

### Σενάριο #2

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

* Εάν είναι δυνατόν, αποφύγετε τη χρήση συναρτήσεων που δεσμεύουν αυτόματα την είσοδο ενός προγράμματος-πελάτη σε μεταβλητές κώδικα ή εσωτερικά αντικείμενα.
* Δημιουργήστε μια λίστα επιτρεπόμενων (whitelist) ιδιοτήτων μόνο με τις ιδιότητες που πρέπει να ενημερωθούν από τον πελάτη (API client).
* Χρησιμοποιήστε ενσωματωμένες δυνατότητες του framework σας για να δημιουργήσετε μια μαύρη λίστα ιδιοτήτων που δεν πρέπει να έχουν πρόσβαση οι πελάτες (API clients).
* Εάν είναι εφικτό, ορίστε και επιβάλλετε ρητά σχήματα (schemas) για τα payloads δεδομένων εισόδου.

## Αναφορές

### Εξωτερικές

* [CWE-915: Improperly Controlled Modification of Dynamically-Determined Object Attributes][1]

[1]: https://cwe.mitre.org/data/definitions/915.html
