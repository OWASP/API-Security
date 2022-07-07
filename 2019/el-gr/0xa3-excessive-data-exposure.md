API3:2019 Excessive Data Exposure
=================================

| Παράγοντες Απειλής/Φορείς Επίθεσης | Αδυναμία Ασφαλείας | Επιπτώσεις |
| - | - | - |
| Εξαρτώνται από το API : Εκμεταλλευσιμότητα **3** | Επιπολασμός **2** : Ανιχνευσιμότητα **2** | Τεχνικές **2** : Εξαρτώνται από την Επιχείρηση |
| Η εκμετάλλευση της υπερβολικής έκθεσης δεδομένων (Excessive Data Exposure) είναι απλή και συνήθως γίνεται παρατηρώντας την κίνηση των δεδομένων για ανάλυση των αποκρίσεων του API, αναζητώντας έκθεση σε ευαίσθητα δεδομένα που δεν πρέπει να επιστραφούν στον χρήστη. | Τα API βασίζονται σε προγράμματα-πελάτες για την εκτέλεση του φιλτραρίσματος δεδομένων. Δεδομένου ότι τα API χρησιμοποιούνται ως πηγές δεδομένων, μερικές φορές οι προγραμματιστές προσπαθούν να τα εφαρμόσουν με γενικό τρόπο χωρίς να σκέφτονται την ευαισθησία των εκτεθειμένων δεδομένων. Τα αυτόματα εργαλεία συνήθως δεν μπορούν να εντοπίσουν αυτόν τον τύπο ευπάθειας, επειδή είναι δύσκολο να γίνει διάκριση μεταξύ των νόμιμων δεδομένων που επιστρέφονται από το API και των ευαίσθητων δεδομένων που δεν πρέπει να επιστραφούν χωρίς βαθιά κατανόηση της εφαρμογής. | Η υπερβολική έκθεση δεδομένων οδηγεί συνήθως σε έκθεση ευαίσθητων δεδομένων. |

## Είναι το API ευάλωτο;

Το API επιστρέφει ευαίσθητα δεδομένα στο πρόγραμμα-πελάτη βάσει σχεδίασης. Αυτά τα δεδομένα συνήθως φιλτράρονται από την πλευρά του προγράμματος-πελάτη πριν παρουσιαστούν στον χρήστη. Ένας εισβολέας μπορεί εύκολα να παρατηρήσει την κίνηση και να δει τα ευαίσθητα δεδομένα.

## Παραδείγματα Σεναρίων Επίθεσης

### Σενάριο #1

The mobile team uses the `/api/articles/{articleId}/comments/{commentId}`
endpoint in the articles view to render comments metadata. Sniffing the mobile
application traffic, an attacker finds out that other sensitive data related to
comment’s author is also returned. The endpoint implementation uses a generic
`toJSON()` method on the `User` model, which contains PII, to serialize the
object.

### Σενάριο #2

An IOT-based surveillance system allows administrators to create users with
different permissions. An admin created a user account for a new security guard
that should only have access to specific buildings on the site. Once the
security guard uses his mobile app, an API call is triggered to:
`/api/sites/111/cameras` in order to receive data about the available cameras
and show them on the dashboard. The response contains a list with details about
cameras in the following format:
`{"id":"xxx","live_access_token":"xxxx-bbbbb","building_id":"yyy"}`.
While the client GUI shows only cameras which the security guard should have
access to, the actual API response contains a full list of all the cameras in
the site.

## Τρόπος Πρόληψης

* Never rely on the client side to filter sensitive data.
* Review the responses from the API to make sure they contain only legitimate
  data.
* Backend engineers should always ask themselves "who is the
  consumer of the data?" before exposing a new API endpoint.
* Avoid using generic methods such as `to_json()` and `to_string()`.
  Instead, cherry-pick specific properties you really want to return
* Classify sensitive and personally identifiable information (PII) that
  your application stores and works with, reviewing all API calls returning such
  information to see if these responses pose a security issue.
* Implement a schema-based response validation mechanism as an extra layer of
  security. As part of this mechanism define and enforce data returned by all
  API methods, including errors.


## Αναφορές

### Εξωτερικές

* [CWE-213: Intentional Information Exposure][1]

[1]: https://cwe.mitre.org/data/definitions/213.html
