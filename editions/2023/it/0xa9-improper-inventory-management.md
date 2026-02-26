# API9:2023 Improper Inventory Management

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **Facile** | Diffusione **Elevata** : Rilevabilità **Media** | Tecnico **Moderato** : Specifico per il Business |
| Gli agenti di minaccia ottengono solitamente accesso non autorizzato tramite vecchie versioni API o endpoint lasciati in esecuzione senza patch e con requisiti di sicurezza più deboli. In alcuni casi sono disponibili exploit. In alternativa, possono accedere a dati sensibili tramite una terza parte con cui non c'è alcuna ragione di condividere dati. | La documentazione obsoleta rende più difficile trovare e/o correggere le vulnerabilità. La mancanza di inventario degli asset e di strategie di dismissione porta all'esecuzione di sistemi non aggiornati, con conseguente divulgazione di dati sensibili. È comune trovare host API esposti inutilmente a causa di concetti moderni come i microservizi, che rendono le applicazioni facili da distribuire e indipendenti (ad esempio cloud computing, K8S). Una semplice ricerca con Google Dorking, l'enumerazione DNS o l'utilizzo di motori di ricerca specializzati per vari tipi di server (webcam, router, server, ecc.) connessi a Internet sarà sufficiente per scoprire i target. | Gli attaccanti possono accedere a dati sensibili, o addirittura prendere il controllo del server. A volte diverse versioni/distribuzioni API sono connesse allo stesso database con dati reali. Gli agenti di minaccia possono sfruttare endpoint deprecati disponibili in vecchie versioni API per accedere a funzioni amministrative o sfruttare vulnerabilità note. |

## L'API è Vulnerabile?

La natura frammentata e interconnessa delle API e delle applicazioni moderne
pone nuove sfide. È importante che le organizzazioni abbiano non solo una buona
comprensione e visibilità delle proprie API e dei propri endpoint, ma anche di
come le API condividono o archiviano dati con terze parti esterne.

Eseguire più versioni di un'API richiede risorse di gestione aggiuntive da parte
del provider API e amplia la superficie di attacco.

Un'API ha un "<ins>punto cieco documentale</ins>" se:

* Lo scopo di un host API non è chiaro e non ci sono risposte esplicite alle
  seguenti domande:
    * In quale ambiente è in esecuzione l'API (ad esempio produzione, staging,
      test, sviluppo)?
    * Chi dovrebbe avere accesso di rete all'API (ad esempio pubblico, interno,
      partner)?
    * Quale versione dell'API è in esecuzione?
* Non esiste documentazione o la documentazione esistente non è aggiornata.
* Non esiste un piano di dismissione per ogni versione API.
* L'inventario degli host è assente o non aggiornato.

La visibilità e l'inventario dei flussi di dati sensibili svolgono un ruolo
importante come parte di un piano di risposta agli incidenti, nel caso in cui
si verifichi una violazione dal lato della terza parte.

Un'API ha un "<ins>punto cieco sui flussi di dati</ins>" se:

* Esiste un "flusso di dati sensibili" in cui l'API condivide dati sensibili
  con una terza parte e:
    * Non esiste una giustificazione o approvazione di business per il flusso
    * Non esiste un inventario o visibilità del flusso
    * Non esiste una visibilità approfondita su quale tipo di dati sensibili
      viene condiviso

## Scenari di Attacco di Esempio

### Scenario #1

Un social network ha implementato un meccanismo di rate limiting che blocca gli
attaccanti dall'utilizzo della forza bruta per indovinare i token di reset della
password. Questo meccanismo non era implementato come parte del codice API stesso,
ma in un componente separato tra il client e l'API ufficiale
(`api.socialnetwork.owasp.org`). Un ricercatore ha trovato un host API beta
(`beta.api.socialnetwork.owasp.org`) che esegue la stessa API, incluso il
meccanismo di reset della password, ma il meccanismo di rate limiting non era
presente. Il ricercatore è riuscito a reimpostare la password di qualsiasi utente
utilizzando la semplice forza bruta per indovinare il token a 6 cifre.

### Scenario #2

Un social network consente agli sviluppatori di app indipendenti di integrarsi
con esso. Come parte di questo processo, viene richiesto il consenso all'utente
finale, in modo che il social network possa condividere le informazioni personali
dell'utente con l'app indipendente.

Il flusso di dati tra il social network e le app indipendenti non è
sufficientemente restrittivo o monitorato, consentendo alle app indipendenti di
accedere non solo alle informazioni dell'utente ma anche alle informazioni private
di tutti i suoi amici.

Una società di consulenza sviluppa un'app malevola e riesce a ottenere il
consenso di 270.000 utenti. A causa della falla, la società di consulenza riesce
ad accedere alle informazioni private di 50.000.000 di utenti. In seguito, la
società di consulenza vende le informazioni per scopi malevoli.

## Come Prevenire

* Creare un inventario di tutti gli <ins>host API</ins> e documentare gli
  aspetti importanti di ognuno, concentrandosi sull'ambiente API (ad esempio
  produzione, staging, test, sviluppo), su chi dovrebbe avere accesso di rete
  all'host (ad esempio pubblico, interno, partner) e sulla versione API.
* Creare un inventario dei <ins>servizi integrati</ins> e documentare aspetti
  importanti come il loro ruolo nel sistema, quali dati vengono scambiati
  (flusso di dati) e la loro sensibilità.
* Documentare tutti gli aspetti dell'API come autenticazione, errori, redirect,
  rate limiting, policy CORS (cross-origin resource sharing) ed endpoint,
  inclusi i loro parametri, richieste e risposte.
* Generare documentazione automaticamente adottando standard aperti. Includere
  la generazione della documentazione nella pipeline CI/CD.
* Rendere la documentazione API disponibile solo a coloro che sono autorizzati
  a utilizzare l'API.
* Utilizzare misure di protezione esterne come soluzioni specifiche per la
  sicurezza API per tutte le versioni esposte delle API, non solo per la
  versione in produzione attuale.
* Evitare l'uso di dati di produzione con distribuzioni API non di produzione.
  Se ciò è inevitabile, questi endpoint devono ricevere lo stesso trattamento
  di sicurezza di quelli di produzione.
* Quando le versioni più recenti delle API includono miglioramenti di sicurezza,
  eseguire un'analisi del rischio per informare le azioni di mitigazione
  necessarie per le versioni precedenti. Ad esempio, valutare se è possibile
  applicare i miglioramenti retroattivamente senza compromettere la
  compatibilità API, o se è necessario ritirare rapidamente la versione
  precedente e forzare tutti i client a migrare all'ultima versione.

## Riferimenti

### Esterni

* [CWE-1059: Incomplete Documentation][1]

[1]: https://cwe.mitre.org/data/definitions/1059.html