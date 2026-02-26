# API7:2019 Security Misconfiguration

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **3** | Diffusione **3** : Rilevabilità **3** | Tecnico **2** : Specifico per il Business |
| Gli attaccanti tentano spesso di trovare falle non patchate, endpoint comuni, o file e directory non protetti per ottenere accesso non autorizzato o informazioni sul sistema. | La configurazione errata della sicurezza può verificarsi a qualsiasi livello dello stack API, dal livello di rete al livello applicativo. Sono disponibili strumenti automatizzati per rilevare e sfruttare configurazioni errate come servizi non necessari o opzioni legacy. | Le configurazioni errate della sicurezza non solo espongono dati sensibili degli utenti, ma anche dettagli di sistema che possono portare alla compromissione totale del server. |

## L'API è Vulnerabile?

L'API potrebbe essere vulnerabile se:

* Manca un adeguato hardening della sicurezza in qualsiasi parte dello stack
  applicativo, o se i permessi sui servizi cloud sono configurati in modo errato.
* Mancano le patch di sicurezza più recenti, o i sistemi non sono aggiornati.
* Funzionalità non necessarie sono abilitate (ad esempio verbi HTTP).
* Manca il Transport Layer Security (TLS).
* Le direttive di sicurezza non vengono inviate ai client (ad esempio
  [Security Headers][1]).
* Manca o è impostata in modo errato una policy Cross-Origin Resource Sharing
  (CORS).
* I messaggi di errore includono stack trace o vengono esposte altre
  informazioni sensibili.

## Scenari di Attacco di Esempio

### Scenario #1

Un attaccante trova il file `.bash_history` nella directory root del server, che
contiene comandi utilizzati dal team DevOps per accedere all'API:

```
$ curl -X GET 'https://api.server/endpoint/' -H 'authorization: Basic Zm9vOmJhcg=='
```

Un attaccante potrebbe anche trovare nuovi endpoint sull'API utilizzati solo dal
team DevOps e non documentati.

### Scenario #2

Per prendere di mira un servizio specifico, un attaccante utilizza un popolare
motore di ricerca per cercare computer direttamente accessibili da Internet.
L'attaccante trova un host che esegue un popolare sistema di gestione di database
in ascolto sulla porta di default. L'host utilizzava la configurazione di default,
che ha l'autenticazione disabilitata per impostazione predefinita, e l'attaccante
ha ottenuto accesso a milioni di record con PII, preferenze personali e dati di
autenticazione.

### Scenario #3

Analizzando il traffico di un'applicazione mobile, un attaccante scopre che non
tutto il traffico HTTP avviene su un protocollo sicuro (ad esempio TLS). L'attaccante
verifica che ciò sia vero, in particolare per il download delle immagini del
profilo. Poiché l'interazione dell'utente è binaria, nonostante il fatto che il
traffico API avvenga su un protocollo sicuro, l'attaccante individua uno schema
nelle dimensioni delle risposte API, che utilizza per tracciare le preferenze
dell'utente rispetto ai contenuti visualizzati (ad esempio le immagini del
profilo).

## Come Prevenire

Il ciclo di vita dell'API dovrebbe includere:

* Un processo di hardening ripetibile che consenta una distribuzione rapida e
  semplice di un ambiente adeguatamente protetto.
* Un'attività di revisione e aggiornamento delle configurazioni sull'intero
  stack API. La revisione dovrebbe includere: file di orchestrazione, componenti
  API e servizi cloud (ad esempio permessi dei bucket S3).
* Un canale di comunicazione sicuro per tutti gli accessi alle interazioni API e
  agli asset statici (ad esempio immagini).
* Un processo automatizzato per valutare continuamente l'efficacia della
  configurazione e delle impostazioni in tutti gli ambienti.

Inoltre:

* Per evitare che stack trace e altre informazioni preziose vengano inviate agli
  attaccanti, se applicabile, definire e applicare tutti gli schemi dei payload
  di risposta API, incluse le risposte di errore.
* Assicurarsi che l'API sia accessibile solo tramite i verbi HTTP specificati.
  Tutti gli altri verbi HTTP devono essere disabilitati (ad esempio `HEAD`).
* Le API che si prevede vengano accedute da client basati su browser (ad esempio
  il front-end di una WebApp) dovrebbero implementare una corretta policy
  Cross-Origin Resource Sharing (CORS).

## Riferimenti

### OWASP

* [OWASP Secure Headers Project][1]
* [OWASP Testing Guide: Configuration Management][2]
* [OWASP Testing Guide: Testing for Error Codes][3]
* [OWASP Testing Guide: Test Cross Origin Resource Sharing][9]

### Esterni

* [CWE-2: Environmental Security Flaws][4]
* [CWE-16: Configuration][5]
* [CWE-388: Error Handling][6]
* [Guide to General Server Security][7], NIST
* [Let's Encrypt: a free, automated, and open Certificate Authority][8]

[1]: https://www.owasp.org/index.php/OWASP_Secure_Headers_Project
[2]: https://www.owasp.org/index.php/Testing_for_configuration_management
[3]: https://www.owasp.org/index.php/Testing_for_Error_Code_(OTG-ERR-001)
[4]: https://cwe.mitre.org/data/definitions/2.html
[5]: https://cwe.mitre.org/data/definitions/16.html
[6]: https://cwe.mitre.org/data/definitions/388.html
[7]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[8]: https://letsencrypt.org/
[9]: https://www.owasp.org/index.php/Test_Cross_Origin_Resource_Sharing_(OTG-CLIENT-007)
