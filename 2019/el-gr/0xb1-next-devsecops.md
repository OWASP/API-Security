Επόμενα Βήματα για DevSecOps
=========================

Λόγω της σημασίας τους στις σύγχρονες αρχιτεκτονικές εφαρμογών, η δημιουργία ασφαλών API είναι ζωτικής σημασίας. 
Η ασφάλεια δεν μπορεί να παραμεληθεί και θα πρέπει να αποτελεί μέρος ολόκληρου του κύκλου ζωής της ανάπτυξης των APIs. 
Η σάρωση (scanning) και οι ετήσιες δοκιμές διείσδυσης (penetration tests) δεν είναι πλέον αρκετές.

Οι DevSecOps θα πρέπει να συμμετάσχουν στην προσπάθεια ανάπτυξης, διευκολύνοντας τις συνεχείς δοκιμές ασφαλείας 
σε ολόκληρο τον κύκλο ζωής ανάπτυξης λογισμικού. Στόχος τους είναι να ενισχύσουν τον αγωγό ανάπτυξης (development pipeline) με 
αυτοματισμό ασφαλείας (security automation), χωρίς να επηρεάζουν την ταχύτητα ανάπτυξης.

Σε περίπτωση αμφιβολιών, μείνετε ενημερωμένοι και ελέγχετε συχνά το [DevSecOps Manifesto][1].

| | |
|-|-|
| **Κατανοήστε το Μοντέλο Απειλής (Threat Model)** | Οι προτεραιότητες δοκιμών (testing priorities) προέρχονται από ένα μοντέλο απειλής (threat model). Εάν δεν έχετε μοντέλο απειλής, εξετάστε το ενδεχόμενο να χρησιμοποιήσετε το [Πρότυπο Επαλήθευσης Ασφάλειας Εφαρμογών OWASP (OWASP Application Security Verification Standard) (ASVS)][2] και τον [Οδηγό Δοκιμής OWASP (OWASP Testing Guide)][3] ως είσοδο. Η συμμετοχή της ομάδας ανάπτυξης μπορεί να βοηθήσει τους προγραμματιστές να γίνουν περισσότερο ενήμεροι για την ασφάλεια.|
| **Κατανoήστε το SDLC** | Γίνετε μέλος της ομάδας ανάπτυξης για να κατανοήσετε καλύτερα τον Κύκλο Ζωής Ανάπτυξης Λογισμικού. Η συνεισφορά σας στις συνεχείς δοκιμές ασφαλείας θα πρέπει να είναι συμβατή με τα άτομα, τις διαδικασίες και τα εργαλεία που έχουν θεσπιστεί. Όλοι πρέπει να συμφωνήσουν με τη διαδικασία, ώστε να μην υπάρχουν περιττές τριβές ή αντιστάσεις. |
| **Στρατηγικές Testing** | Καθώς η εργασία σας δεν πρέπει να επηρεάζει την ταχύτητα ανάπτυξης του API, θα πρέπει να επιλέξετε με σύνεση την καλύτερη (απλή, ταχύτερη, πιο ακριβή) τεχνική για να επαληθεύσετε τις απαιτήσεις ασφαλείας. Το [Γνωσιακό Πλαίσιο Ασφαλείας OWASP (OWASP Security Knowledge Framework)][4] και το [Πρότυπο Επαλήθευσης Ασφάλειας Εφαρμογών OWASP (OWASP Application Security Verification Standard)][5] μπορούν να αποτελέσουν εξαιρετικές πηγές λειτουργικών και μη λειτουργικών απαιτήσεων ασφαλείας. Υπάρχουν άλλες εξαιρετικές πηγές για [Έργα][6] και [Εργαλεία][7] παρόμοιες με αυτήν που προσφέρει η [Κοινότητα DevSecOps][8].|
| **Επίτευξη Κάλυψης (Coverage) και ακρίβειας (Accuracy)** | Είστε η γέφυρα μεταξύ προγραμματιστών και ομάδων λειτουργιών (operation teams). Για να πετύχετε κάλυψη (coverage), δεν πρέπει να εστιάσετε μόνο στη λειτουργικότητα, αλλά και στην ενορχήστρωση. Εργαστείτε από την αρχή κοντά στις ομάδες ανάπτυξης και λειτουργίας, ώστε να βελτιστοποιήσετε τον χρόνο και την προσπάθειά σας. Θα πρέπει να στοχεύσετε σε μια κατάσταση όπου η βασική ασφάλεια επαληθεύεται συνεχώς. |
| **Επικοινωνήστε με σαφήνεια τα ευρήματα** | Συνεισφέρετε αξία με λιγότερη ή καθόλου τριβή. Παραδώστε τα ευρήματα σας έγκαιρα, μέσα στα εργαλεία που χρησιμοποιούν οι ομάδες ανάπτυξης (όχι αρχεία PDF). Γίνετε μέλος της ομάδας ανάπτυξης για να αντιμετωπίσετε τα ευρήματα. Εκμεταλλευτείτε την ευκαιρία για να τους εκπαιδεύσετε, περιγράφοντας ξεκάθαρα την αδυναμία και πώς μπορεί να γίνει κατάχρηση της, συμπεριλαμβάνοντας ένα σενάριο επίθεσης για να γίνετε κατανοητοί.|

[1]: https://www.devsecops.org/
[2]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[3]: https://www.owasp.org/index.php/OWASP_Testing_Project
[4]: https://www.owasp.org/index.php/OWASP_Security_Knowledge_Framework
[5]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[6]: http://devsecops.github.io/
[7]: https://github.com/devsecops/awesome-devsecops
[8]: http://devsecops.org