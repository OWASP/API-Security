# API9:2019 Improper Assets Management

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **3** | Diffusione **3** : Rilevabilità **2** | Tecnico **2** : Specifico per il Business |
| Le vecchie versioni API sono solitamente non patchate e rappresentano un modo semplice per compromettere i sistemi senza dover affrontare i meccanismi di sicurezza più avanzati, che potrebbero essere presenti per proteggere le versioni API più recenti. | La documentazione obsoleta rende più difficile trovare e/o correggere le vulnerabilità. La mancanza di inventario degli asset e di strategie di dismissione porta all'esecuzione di sistemi non aggiornati, con conseguente divulgazione di dati sensibili. È comune trovare host API esposti inutilmente a causa di concetti moderni come i microservizi, che rendono le applicazioni facili da distribuire e indipendenti (ad esempio cloud computing, k8s). | Gli attaccanti possono accedere a dati sensibili, o addirittura prendere il controllo del server tramite vecchie versioni API non patchate collegate allo stesso database. |

## L'API è Vulnerabile?

L'API potrebbe essere vulnerabile se:

* Lo scopo di un host API non è chiaro e non ci sono risposte esplicite alle
  seguenti domande:
    * In quale ambiente è in esecuzione l'API (ad esempio produzione, staging,
      test, sviluppo)?
    * Chi dovrebbe avere accesso di rete all'API (ad esempio pubblico, interno,
      partner)?
    * Quale versione dell'API è in esecuzione?
    * Quali dati vengono raccolti ed elaborati dall'API (ad esempio PII)?
    * Qual è il flusso dei dati?
* Non esiste documentazione, o la documentazione esistente non è aggiornata.
* Non esiste un piano di dismissione per ogni versione API.
* L'inventario degli host è assente o non aggiornato.
* L'inventario dei servizi integrati, di prima o terza parte, è assente o non
  aggiornato.
* Le versioni API vecchie o precedenti sono in esecuzione senza patch.

## Scenari di Attacco di Esempio

### Scenario #1

Dopo aver riprogettato le proprie applicazioni, un servizio di ricerca locale
ha lasciato in esecuzione una vecchia versione API (`api.someservice.com/v1`),
non protetta e con accesso al database degli utenti. Prendendo di mira una delle
applicazioni rilasciate più di recente, un attaccante ha trovato l'indirizzo API
(`api.someservice.com/v2`). Sostituendo `v2` con `v1` nell'URL, l'attaccante ha
ottenuto accesso alla vecchia API non protetta, esponendo le informazioni di
identificazione personale (PII) di oltre 100 milioni di utenti.

### Scenario #2

Un social network ha implementato un meccanismo di rate limiting che blocca gli
attaccanti dall'utilizzo della forza bruta per indovinare i token di reset della
password. Questo meccanismo non era implementato come parte del codice API stesso,
ma in un componente separato tra il client e l'API ufficiale
(`www.socialnetwork.com`). Un ricercatore ha trovato un host API beta
(`www.mbasic.beta.socialnetwork.com`) che esegue la stessa API, incluso il
meccanismo di reset della password, ma il meccanismo di rate limiting non era
presente. Il ricercatore è riuscito a reimpostare la password di qualsiasi utente
utilizzando la semplice forza bruta per indovinare il token a 6 cifre.

## Come Prevenire

* Creare un inventario di tutti gli host API e documentare gli aspetti importanti
  di ognuno, concentrandosi sull'ambiente API (ad esempio produzione, staging,
  test, sviluppo), su chi dovrebbe avere accesso di rete all'host (ad esempio
  pubblico, interno, partner) e sulla versione API.
* Creare un inventario dei servizi integrati e documentare aspetti importanti
  come il loro ruolo nel sistema, quali dati vengono scambiati (flusso di dati)
  e la loro sensibilità.
* Documentare tutti gli aspetti dell'API come autenticazione, errori, redirect,
  rate limiting, policy CORS (cross-origin resource sharing) ed endpoint,
  inclusi i loro parametri, richieste e risposte.
* Generare documentazione automaticamente adottando standard aperti. Includere
  la generazione della documentazione nella pipeline CI/CD.
* Rendere la documentazione API disponibile a coloro che sono autorizzati a
  utilizzare l'API.
* Utilizzare misure di protezione esterne come firewall per la sicurezza delle
  API per tutte le versioni esposte delle API, non solo per la versione in
  produzione attuale.
* Evitare l'uso di dati di produzione con distribuzioni API non di produzione.
  Se ciò è inevitabile, questi endpoint devono ricevere lo stesso trattamento
  di sicurezza di quelli di produzione.
* Quando le versioni più recenti delle API includono miglioramenti di sicurezza,
  eseguire un'analisi del rischio per prendere la decisione sulle azioni di
  mitigazione necessarie per la versione precedente: ad esempio, valutare se è
  possibile applicare i miglioramenti retroattivamente senza compromettere la
  compatibilità API, o se è necessario ritirare rapidamente la versione
  precedente e forzare tutti i client a migrare all'ultima versione.

## Riferimenti

### Esterni

* [CWE-1059: Incomplete Documentation][1]
* [OpenAPI Initiative][2]

[1]: https://cwe.mitre.org/data/definitions/1059.html
[2]: https://www.openapis.org/
