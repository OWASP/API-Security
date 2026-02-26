# Prossimi Passi per gli Sviluppatori

Il compito di creare e mantenere software sicuro, o di correggere quello
esistente, può essere difficile. Le API non fanno eccezione.

Crediamo che l'educazione e la consapevolezza siano fattori chiave per scrivere
software sicuro. Tutto il resto necessario per raggiungere l'obiettivo dipende
dall'**adozione e dall'utilizzo di processi di sicurezza ripetibili e controlli
di sicurezza standard**.

OWASP dispone di numerose risorse gratuite e aperte per affrontare la sicurezza
fin dall'inizio del progetto. Visita la [pagina dei Progetti OWASP][1] per un
elenco completo dei progetti disponibili.

| | |
|-|-|
| **Formazione** | Puoi iniziare consultando i [materiali del Progetto OWASP Education][2] in base alla tua professione e ai tuoi interessi. Per l'apprendimento pratico, abbiamo inserito **crAPI** - **C**ompletely **R**idiculous **API** nella [nostra roadmap][3]. Nel frattempo, puoi esercitarti sulla sicurezza delle WebApp usando il [OWASP DevSlop Pixi Module][4], una WebApp e un servizio API intenzionalmente vulnerabili pensati per insegnare agli utenti come testare la sicurezza delle applicazioni web e delle API moderne, e come scrivere API più sicure in futuro. Puoi anche partecipare alle sessioni di formazione della [Conferenza OWASP AppSec][5] o [unirti al tuo capitolo locale][6]. |
| **Requisiti di Sicurezza** | La sicurezza deve far parte di ogni progetto fin dall'inizio. Quando si raccolgono i requisiti, è importante definire cosa significa "sicuro" per quel progetto. OWASP raccomanda di utilizzare l'[OWASP Application Security Verification Standard (ASVS)][7] come guida per definire i requisiti di sicurezza. Se si esternalizza il lavoro, considera l'[OWASP Secure Software Contract Annex][8], che dovrebbe essere adattato in base alla legge e alla normativa locale. |
| **Architettura di Sicurezza** | La sicurezza deve rimanere una preoccupazione durante tutte le fasi del progetto. Le [OWASP Prevention Cheat Sheets][9] sono un buon punto di partenza per la guida su come progettare la sicurezza nella fase di architettura. Tra i tanti, troverai il [REST Security Cheat Sheet][10] e il [REST Assessment Cheat Sheet][11]. |
| **Controlli di Sicurezza Standard** | Adottare controlli di sicurezza standard riduce il rischio di introdurre debolezze di sicurezza durante la scrittura della propria logica. Nonostante molti framework moderni ora includano controlli standard integrati efficaci, gli [OWASP Proactive Controls][12] offrono una buona panoramica dei controlli di sicurezza che dovresti considerare di includere nel tuo progetto. OWASP fornisce anche alcune librerie e strumenti che potresti trovare utili, come i controlli di validazione. |
| **Secure Software Development Life Cycle** | Puoi utilizzare l'[OWASP Software Assurance Maturity Model (SAMM)][13] per migliorare il processo di sviluppo delle API. Diversi altri progetti OWASP sono disponibili per supportarti nelle diverse fasi di sviluppo delle API, ad esempio il [OWASP Code Review Project][14]. |

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
