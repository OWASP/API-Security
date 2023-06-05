# Ρίσκα Ασφαλείας API

Για την ανάλυση κινδύνου χρησιμοποιήθηκε η [Μεθοδολογία Αξιολόγησης Ρίσκου OWASP][1].

Ο παρακάτω πίνακας συνοψίζει την ορολογία που σχετίζεται με τη βαθμολογία κινδύνου.

| Παράγοντες Απειλής (Threat Agents) | Εκμεταλλευσιμότητα (Exploitability) | Επικράτηση Αδυναμίας (Weakness Prevalence) | Ανιχνευσιμότητα Αδυναμίας (Weakness Detectability) | Τεχνικός Αντίκτυπος (Technical Impact) | Επιχειρησιακές Επιπτώσεις (Business Impacts) |
| :-: | :-: | :-: | :-: | :-: | :-: |
| Εξαρτώνται από το API | Εύκολη: **3** | Διαδεδομένη **3** | Εύκολη **3** | Σοβαρός **3** | Εξαρτώνται από την επιχείρηση |
| Εξαρτώνται από το API | Μεσαία: **2** | Κοινή **2** | Μεσαία **2** | Μεσαίος **2** | Εξαρτώνται από την επιχείρηση |
| Εξαρτώνται από το API | Δύσκολη: **1** | Δύσκολη **1** | Δύσκολη **1** | Μικρός **1** | Εξαρτώνται από την επιχείρηση |

Σημείωση: Η παραπάνω προσέγγιση δεν λαμβάνει υπόψη την πιθανότητα του παράγοντα απειλής (likelihood of threat agent). Επίσης δεν λαμβάνει υπόψη καμία από τις διάφορες τεχνικές λεπτομέρειες που σχετίζονται με τη συγκεκριμένη εφαρμογή σας. Οποιοσδήποτε από αυτούς τους παράγοντες θα μπορούσε να επηρεάσει σημαντικά τη συνολική πιθανότητα ο εισβολέας να βρει και να εκμεταλλευτεί μια συγκεκριμένη ευπάθεια. Αυτή η βαθμολογία δεν λαμβάνει υπόψη τον πραγματικό αντίκτυπο στην επιχείρησή σας. Η επιχείρηση/οργανισμός σας θα πρέπει να αποφασίσει πόσο ρίσκο ασφαλείας από τις εφαρμογές και τα APIs είναι διατεθειμένος να αποδεχτεί, δεδομένης της εταιρικής κουλτούρας/πολιτικών, του κλάδου και του ρυθμιστικού περιβάλλοντος. Ο σκοπός του OWASP API Security Top 10 δεν είναι να κάνει αυτήν την ανάλυση κινδύνου για εσάς.

## Αναφορές (References)

### Αναφορές OWASP

* [OWASP Risk Rating Methodology][1]
* [Article on Threat/Risk Modeling][2]

### Εξωτερικές Αναφορές

* [ISO 31000: Risk Management Std][3]
* [ISO 27001: ISMS][4]
* [NIST Cyber Framework (US)][5]
* [ASD Strategic Mitigations (AU)][6]
* [NIST CVSS 3.0][7]
* [Microsoft Threat Modeling Tool][8]

[1]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
[2]: https://www.owasp.org/index.php/Threat_Risk_Modeling
[3]: https://www.iso.org/iso-31000-risk-management.html
[4]: https://www.iso.org/isoiec-27001-information-security.html
[5]: https://www.nist.gov/cyberframework
[6]: https://www.asd.gov.au/infosec/mitigationstrategies.htm
[7]: https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
[8]: https://www.microsoft.com/en-us/download/details.aspx?id=49168
