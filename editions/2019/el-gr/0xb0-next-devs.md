# Επόμενα Βήματα για Προγραμματιστές

Η εργασία δημιουργίας και συντήρησης ασφαλούς λογισμικού καθώς και η επιδιόρθωση αυτού είναι δύσκολη υπόθεση. 
Το ίδιο ισχύει και για τα APIs.

Πιστεύουμε ότι η εκπαίδευση και η ευαισθητοποίηση είναι βασικοί παράγοντες για τη δημιουργία ασφαλούς λογισμικού. 
Τα υπόλοιπα που απαιτούνται για την επίτευξη του στόχου, εξαρτώνται από τη δημιουργία και τη χρήση επαναλαμβανόμενων
διαδικασιών και τυπικών ελέγχων ασφαλείας.

Το OWASP διαθέτει πολλούς δωρεάν και ανοιχτούς πόρους για την αντιμετώπιση της ασφάλειας από την αρχή του έργου. 
Επισκεφτείτε τη [σελίδα OWASP Projects][1] για την ολοκληρωμένη λίστα των διαθέσιμων έργων.

| | |
|-|-|
| **Εκπαίδευση** | Μπορείτε να ξεκινήσετε να διαβάζετε το [υλικό του OWASP Education Project][2] ανάλογα με το επάγγελμα και το ενδιαφέρον σας. Για πρακτική μάθηση, προσθέσαμε το **crAPI** - **C**ompletely **R**idiculous **API** στον [οδικό μας χάρτη (roadmap)][3]. Εν τω μεταξύ, μπορείτε να εξασκηθείτε στο WebAppSec χρησιμοποιώντας το [OWASP DevSlop Pixi Module][4], μια ευάλωτη υπηρεσία WebApp και API που έχει σκοπό να διδάξει στους χρήστες πώς να δοκιμάζουν σύγχρονες εφαρμογές ιστού και API για ζητήματα ασφάλειας και πώς να γράφουν πιο ασφαλή APIs στο μέλλον. Μπορείτε επίσης να παρακολουθήσετε εκπαιδευτικές συνεδρίες του [Συνεδρίου OWASP AppSec][5] ή να [εγγραφείτε στο τοπικό σας τμήμα][6].
| **Απαιτήσεις Ασφαλείας** | Η ασφάλεια πρέπει να είναι μέρος κάθε έργου (project) από την αρχή. Όταν βρίσκεστε στο στάδιο της εξαγωγής απαιτήσεων (requirements elicitation), είναι σημαντικό να ορίσετε τι σημαίνει "ασφαλές" για το έργο σας. Το OWASP συνιστά να χρησιμοποιείτε το [Πρότυπο Επαλήθευσης Ασφάλειας Εφαρμογών OWASP (ASVS) (OWASP Application Security Verification Standard)][7] ως οδηγό για τον καθορισμό των απαιτήσεων ασφαλείας. Εάν αναθέτετε το έργο σας σε εξωτερικούς συνεργάτες (outsourcing), εξετάστε το [Παράρτημα Σύμβασης Ασφαλούς Λογισμικού OWASP][8], το οποίο θα πρέπει να προσαρμοστεί σύμφωνα με την τοπική νομοθεσία και τους κανονισμούς της.|
| **Αρχιτεκτονική Ασφαλείας** | Η ασφάλεια θα πρέπει να λαμβάνεται υπόψιν σε όλα τα στάδια του έργου. Τα [Σκονάκια Πρόληψης OWASP (OWASP Prevention Cheat Sheets)][9] είναι ένα καλό σημείο εκκίνησης για καθοδήγηση σχετικά με τον τρόπο σχεδιασμού ασφάλειας κατά τη φάση σχεδιασμού / αρχιτεκτονικής. Μεταξύ πολλών άλλων, θα βρείτε το σκονάκι [REST Security Cheat Sheet][10] και το σκονάκι [REST Assessment Cheat Sheet][11].|
| **Τυπικοί Έλεγχοι Ασφαλείας** | Η υιοθέτηση Τυποποιημένων Μηχανισμών Ελέγχων Ασφαλείας (Standard Security Controls) μειώνει τον κίνδυνο εισαγωγής αδυναμιών ασφαλείας κατά την διάρκεια υλοποίησης της λογικής του λογισμικού σας. Παρά το γεγονός ότι πολλά σύγχρονα frameworks διαθέτουν πλέον ενσωματωμένους τυπικούς αποτελεσματικούς ελέγχους, τα [OWASP Proactive Controls][12] σας παρέχουν μια καλή επισκόπηση των στοιχείων ελέγχου ασφαλείας που πρέπει να συμπεριλάβετε στο έργο σας. Το OWASP παρέχει επίσης ορισμένες βιβλιοθήκες και εργαλεία που μπορεί να σας φανούν πολύτιμα, όπως στοιχεία ελέγχου επικύρωσης (validation controls).|
| **Κύκλος Ζωής Ασφαλούς Ανάπτυξης Λογισμικού** | Μπορείτε να χρησιμοποιήσετε το [OWASP Software Assurance Maturity Model (SAMM)][13] για να βελτιώσετε τη διαδικασία κατά τη δημιουργία των APIs. Πολλά ακόμα έργα OWASP είναι διαθέσιμα για να σας βοηθήσουν σε όλες τις διαφορετικές φάσεις ανάπτυξης API, π.χ., το [Έργο Αναθεώρησης Κώδικα OWASP (OWASP Code Review Project)][14]. |

[1]: https://www.owasp.org/index.php/Category:OWASP_Project
[2]: https://www.owasp.org/index.php/OWASP_Education_Material_Categorized
[3]: https://www.owasp.org/index.php/OWASP_API_Security_Project#tab=Road_Map
[4]: https://devslop.co/Home/Pixi
[5]: https://www.owasp.org/index.php/Category:OWASP_AppSec_Conference
[6]: https://www.owasp.org/index.php/OWASP_Chapter
[7]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[8]: https://www.owasp.org/index.php/OWASP_Secure_Software_Contract_Annex
[9]: https://www.owasp.org/index.php/OWASP_Cheat_Sheet_Series
[10]: https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/REST_Security_Cheat_Sheet.md
[11]: https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/REST_Assessment_Cheat_Sheet.md
[12]: https://www.owasp.org/index.php/OWASP_Proactive_Controls#tab=OWASP_Proactive_Controls_2018
[13]: https://www.owasp.org/index.php/OWASP_SAMM_Project
[14]: https://www.owasp.org/index.php/Category:OWASP_Code_Review_Project
