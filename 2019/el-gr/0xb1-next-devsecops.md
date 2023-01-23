Επόμενα Βήματα για DevSecOps
=========================

Λόγω της σημασίας τους στις σύγχρονες αρχιτεκτονικές εφαρμογών, η δημιουργία ασφαλών API είναι ζωτικής σημασίας. 
Η ασφάλεια δεν μπορεί να παραμεληθεί και θα πρέπει να αποτελεί μέρος ολόκληρου του κύκλου ζωής της ανάπτυξης. 
Η σάρωση (scanning) και οι ετήσιες δοκιμές διείσδυσης (penetration tests) δεν είναι πλέον αρκετές.

Οι DevSecOps θα πρέπει να συμμετάσχουν στην προσπάθεια ανάπτυξης, διευκολύνοντας τις συνεχείς δοκιμές ασφαλείας 
σε ολόκληρο τον κύκλο ζωής ανάπτυξης λογισμικού. Στόχος τους είναι να ενισχύσουν τον αγωγό ανάπτυξης με 
αυτοματισμό ασφαλείας, χωρίς να επηρεάζουν την ταχύτητα ανάπτυξης.

Σε περίπτωση αμφιβολιών, μείνετε ενημερωμένοι και ελέγχετε συχνά το [DevSecOps Manifesto][1].

| | |
|-|-|
| **Κατανοήστε το Μοντέλο Απειλής** | Testing priorities come from a threat model. If you don't have one, consider using [OWASP Application Security Verification Standard (ASVS)][2], and the [OWASP Testing Guide][3] as an input. Involving the development team may help to make them more security-aware. |
| **Κατανoήστε το SDLC** | Join the development team to better understand the Software Development Life Cycle. Your contribution on continuous security testing should be compatible with people, processes, and tools. Everyone should agree with the process, so that there's no unnecessary friction or resistance. |
| **Στρατηγικές Testing** | As your work should not impact the development speed, you should wisely choose the best (simple, fastest, most accurate) technique to verify the security requirements. The [OWASP Security Knowledge Framework][4] and [OWASP Application Security Verification Standard][5] can be great sources of functional and nonfunctional security requirements. There are other great sources for [projects][6] and [tools][7] similar to the one offered by the [DevSecOps community][8]. |
| **Επίτευξη Κάλυψης (Coverage) και ακρίβειας (Accuracy)** | You're the bridge between developers and operations teams. To achieve coverage, not only should you focus on the functionality, but also the orchestration. Work close to both development and operations teams from the beginning so you can optimize your time and effort. You should aim for a state where the essential security is verified continuously. |
| **Επικοινωνήστε με σαφήνεια τα ευρήματα** | Συνεισφέρετε αξία με λιγότερη ή καθόλου τριβή. Παραδώστε τα ευρήματα σας έγκαιρα, μέσα στα εργαλεία που χρησιμοποιούν οι ομάδες ανάπτυξης (όχι αρχεία PDF). Γίνετε μέλος της ομάδας ανάπτυξης για να αντιμετωπίσετε τα ευρήματα. Εκμεταλλευτείτε την ευκαιρία για να τους εκπαιδεύσετε, περιγράφοντας ξεκάθαρα την αδυναμία και πώς μπορεί να γίνει κατάχρηση της, συμπεριλαμβάνοντας ένα σενάριο επίθεσης για να γίνετε κατανοητοί.|

[1]: https://www.devsecops.org/
[2]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[3]: https://www.owasp.org/index.php/OWASP_Testing_Project
[4]: https://www.owasp.org/index.php/OWASP_Security_Knowledge_Framework
[5]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[6]: http://devsecops.github.io/
[7]: https://github.com/devsecops/awesome-devsecops
[8]: http://devsecops.org
