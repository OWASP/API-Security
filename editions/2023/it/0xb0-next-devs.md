# Prossimi Passi per gli Sviluppatori

Il compito di creare e mantenere applicazioni sicure, o di correggere quelle
esistenti, può essere difficile. Non è diverso per le API.

Crediamo che l'educazione e la consapevolezza siano fattori chiave per scrivere
software sicuro. Tutto il resto necessario per raggiungere l'obiettivo dipende
dall'**adozione e dall'utilizzo di processi di sicurezza ripetibili e controlli
di sicurezza standard**.

OWASP fornisce numerose risorse gratuite e aperte per aiutarti ad affrontare la
sicurezza. Visita la [pagina dei Progetti OWASP][1] per un elenco completo dei
progetti disponibili.

| | |
|-|-|
| **Formazione** | L'[Application Security Wayfinder][2] dovrebbe darti una buona panoramica dei progetti disponibili per ogni fase del Software Development LifeCycle (SDLC). Per l'apprendimento pratico puoi iniziare con [OWASP **crAPI** - **C**ompletely **R**idiculous **API**][3] o [OWASP Juice Shop][4]: entrambi hanno API intenzionalmente vulnerabili. Il [Progetto OWASP Vulnerable Web Applications Directory][5] fornisce un elenco curato di applicazioni intenzionalmente vulnerabili: vi troverai diverse altre API vulnerabili. Puoi anche partecipare alle sessioni di formazione della [Conferenza OWASP AppSec][6] o [unirti al tuo capitolo locale][7]. |
| **Requisiti di Sicurezza** | La sicurezza deve far parte di ogni progetto fin dall'inizio. Quando si definiscono i requisiti, è importante definire cosa significa "sicuro" per quel progetto. OWASP raccomanda di utilizzare l'[OWASP Application Security Verification Standard (ASVS)][8] come guida per definire i requisiti di sicurezza. Se si esternalizza il lavoro, considera l'[OWASP Secure Software Contract Annex][9], che dovrebbe essere adattato in base alla legge e alla normativa locale. |
| **Architettura di Sicurezza** | La sicurezza deve rimanere una preoccupazione durante tutte le fasi del progetto. La [Serie di Cheat Sheet OWASP][10] è un buon punto di partenza per la guida su come progettare la sicurezza nella fase di architettura. Tra i tanti, troverai il [REST Security Cheat Sheet][11] e il [REST Assessment Cheat Sheet][12], nonché il [GraphQL Cheat Sheet][13]. |
| **Controlli di Sicurezza Standard** | Adottare controlli di sicurezza standard riduce il rischio di introdurre debolezze di sicurezza durante la scrittura della propria logica. Sebbene molti framework moderni dispongano ora di controlli standard integrati efficaci, gli [OWASP Proactive Controls][14] offrono una buona panoramica dei controlli di sicurezza che dovresti considerare di includere nel tuo progetto. OWASP fornisce anche alcune librerie e strumenti che potresti trovare utili, come i controlli di validazione. |
| **Secure Software Development Life Cycle** | Puoi utilizzare l'[OWASP Software Assurance Maturity Model (SAMM)][15] per migliorare i tuoi processi di sviluppo delle API. Diversi altri progetti OWASP sono disponibili per supportarti nelle diverse fasi di sviluppo delle API, ad esempio la [OWASP Code Review Guide][16]. |

[1]: https://owasp.org/projects/
[2]: https://owasp.org/projects/#owasp-projects-the-sdlc-and-the-security-wayfinder
[3]: https://owasp.org/www-project-crapi/
[4]: https://owasp.org/www-project-juice-shop/
[5]: https://owasp.org/www-project-vulnerable-web-applications-directory/
[6]: https://owasp.org/events/
[7]: https://owasp.org/chapters/
[8]: https://owasp.org/www-project-application-security-verification-standard/
[9]: https://owasp.org/www-community/OWASP_Secure_Software_Contract_Annex
[10]: https://cheatsheetseries.owasp.org/
[11]: https://cheatsheetseries.owasp.org/cheatsheets/REST_Security_Cheat_Sheet.html
[12]: https://cheatsheetseries.owasp.org/cheatsheets/REST_Assessment_Cheat_Sheet.html
[13]: https://cheatsheetseries.owasp.org/cheatsheets/GraphQL_Cheat_Sheet.html
[14]: https://owasp.org/www-project-proactive-controls/
[15]: https://owasp.org/www-project-samm/
[16]: https://owasp.org/www-project-code-review-guide/