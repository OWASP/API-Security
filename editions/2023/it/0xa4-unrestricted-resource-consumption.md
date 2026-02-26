# API4:2023 Unrestricted Resource Consumption

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **Media** | Diffusione **Elevata** : Rilevabilità **Facile** | Tecnico **Grave** : Specifico per il Business |
| Lo sfruttamento richiede semplici richieste API. Più richieste concorrenti possono essere effettuate da un singolo computer locale o utilizzando risorse di cloud computing. La maggior parte degli strumenti automatizzati disponibili è progettata per causare DoS tramite elevati volumi di traffico, compromettendo la velocità di servizio delle API. | È comune trovare API che non limitano le interazioni con i client o il consumo di risorse. Richieste API artefatte, come quelle che includono parametri che controllano il numero di risorse da restituire, e l'analisi dello stato/tempo/lunghezza delle risposte dovrebbero consentire l'identificazione del problema. Lo stesso vale per le operazioni in batch. Sebbene gli agenti di minaccia non abbiano visibilità sull'impatto sui costi, questo può essere dedotto dal modello di business/pricing dei fornitori di servizi (ad esempio provider cloud). | Lo sfruttamento può portare a DoS per esaurimento delle risorse, ma può anche causare un aumento dei costi operativi, come quelli legati all'infrastruttura per una maggiore richiesta di CPU, l'aumento delle necessità di storage cloud, ecc. |

## L'API è Vulnerabile?

Soddisfare le richieste API richiede risorse come larghezza di banda di rete,
CPU, memoria e storage. A volte le risorse necessarie sono rese disponibili dai
fornitori di servizi tramite integrazioni API, con addebito per richiesta, come
l'invio di email/SMS/telefonate, la validazione biometrica, ecc.

Un'API è vulnerabile se almeno uno dei seguenti limiti è assente o impostato
in modo inappropriato (ad esempio troppo basso/alto):

* Timeout di esecuzione
* Memoria massima allocabile
* Numero massimo di file descriptor
* Numero massimo di processi
* Dimensione massima del file caricabile
* Numero di operazioni da eseguire in una singola richiesta del client API
  (ad esempio batching GraphQL)
* Numero di record per pagina da restituire in una singola richiesta-risposta
* Limite di spesa per i fornitori di servizi di terze parti

## Scenari di Attacco di Esempio

### Scenario #1

Un social network ha implementato un flusso "password dimenticata" tramite
verifica SMS, consentendo all'utente di ricevere un token monouso via SMS per
reimpostare la password.

Quando un utente clicca su "password dimenticata", una chiamata API viene inviata
dal browser dell'utente all'API back-end:

```
POST /initiate_forgot_password

{
  "step": 1,
  "user_number": "6501113434"
}
```

Poi, in background, una chiamata API viene inviata dal back-end a un'API di
terze parti che si occupa dell'invio degli SMS:

```
POST /sms/send_reset_pass_code

Host: willyo.net

{
  "phone_number": "6501113434"
}
```

Il provider di terze parti, Willyo, addebita $0,05 per questo tipo di chiamata.

Un attaccante scrive uno script che invia la prima chiamata API decine di
migliaia di volte. Il back-end segue e richiede a Willyo di inviare decine di
migliaia di messaggi, causando all'azienda una perdita di migliaia di dollari
in pochi minuti.

### Scenario #2

Un endpoint API GraphQL consente all'utente di caricare un'immagine del profilo.

```
POST /graphql

{
  "query": "mutation {
    uploadPic(name: \"pic1\", base64_pic: \"R0FOIEFOR0xJVA…\") {
      url
    }
  }"
}
```

Una volta completato il caricamento, l'API genera più miniature con dimensioni
diverse basate sull'immagine caricata. Questa operazione grafica utilizza molta
memoria del server.

L'API implementa una protezione tradizionale di rate limiting — un utente non
può accedere all'endpoint GraphQL troppe volte in un breve periodo di tempo.
L'API controlla anche le dimensioni dell'immagine caricata prima di generare
le miniature per evitare di elaborare immagini troppo grandi.

Un attaccante può facilmente aggirare questi meccanismi sfruttando la natura
flessibile di GraphQL:

```
POST /graphql

[
  {"query": "mutation {uploadPic(name: \"pic1\", base64_pic: \"R0FOIEFOR0xJVA…\") {url}}"},
  {"query": "mutation {uploadPic(name: \"pic2\", base64_pic: \"R0FOIEFOR0xJVA…\") {url}}"},
  ...
  {"query": "mutation {uploadPic(name: \"pic999\", base64_pic: \"R0FOIEFOR0xJVA…\") {url}}"},
}
```

Poiché l'API non limita il numero di volte in cui l'operazione `uploadPic` può
essere tentata, la chiamata porterà all'esaurimento della memoria del server e
al Denial of Service.

### Scenario #3

Un fornitore di servizi consente ai client di scaricare file di grandi dimensioni
arbitrarie tramite la propria API. Questi file sono archiviati in un object
storage cloud e non cambiano spesso. Il fornitore di servizi si affida a un
servizio di cache per migliorare le prestazioni e mantenere basso il consumo di
banda. Il servizio di cache memorizza solo file fino a 15GB.

Quando uno dei file viene aggiornato, la sua dimensione aumenta a 18GB. Tutti i
client del servizio iniziano immediatamente a scaricare la nuova versione. Poiché
non erano presenti avvisi sui costi di consumo né un limite massimo di spesa per
il servizio cloud, la fattura mensile successiva aumenta da una media di 13$
a 8.000$.

## Come Prevenire

* Utilizzare una soluzione che faciliti la limitazione di [memoria][1],
  [CPU][2], [numero di riavvii][3], [file descriptor e processi][4] come
  container o codice serverless (ad esempio Lambda).
* Definire e applicare una dimensione massima dei dati su tutti i parametri e
  i payload in ingresso, come lunghezza massima delle stringhe, numero massimo
  di elementi negli array e dimensione massima del file caricabile
  (indipendentemente dal fatto che venga archiviato localmente o nel cloud).
* Implementare un limite alla frequenza con cui un client può interagire con
  l'API in un determinato intervallo di tempo (rate limiting).
* Il rate limiting deve essere calibrato in base alle esigenze di business.
  Alcuni endpoint API potrebbero richiedere policy più restrittive.
* Limitare/ridurre la frequenza con cui un singolo client/utente API può
  eseguire una singola operazione (ad esempio validare un OTP o richiedere il
  recupero della password senza visitare l'URL monouso).
* Aggiungere una corretta validazione lato server per i parametri della query
  string e del corpo della richiesta, in particolare quelli che controllano il
  numero di record da restituire nella risposta.
* Configurare limiti di spesa per tutti i fornitori di servizi/integrazioni API.
  Quando non è possibile impostare limiti di spesa, configurare avvisi di
  fatturazione.

## Riferimenti

### OWASP

* ["Availability" - Web Service Security Cheat Sheet][5]
* ["DoS Prevention" - GraphQL Cheat Sheet][6]
* ["Mitigating Batching Attacks" - GraphQL Cheat Sheet][7]

### Esterni

* [CWE-770: Allocation of Resources Without Limits or Throttling][8]
* [CWE-400: Uncontrolled Resource Consumption][9]
* [CWE-799: Improper Control of Interaction Frequency][10]
* "Rate Limiting (Throttling)" - [Security Strategies for Microservices-based
  Application Systems][11], NIST

[1]: https://docs.docker.com/config/containers/resource_constraints/#memory
[2]: https://docs.docker.com/config/containers/resource_constraints/#cpu
[3]: https://docs.docker.com/engine/reference/commandline/run/#restart
[4]: https://docs.docker.com/engine/reference/commandline/run/#ulimit
[5]: https://cheatsheetseries.owasp.org/cheatsheets/Web_Service_Security_Cheat_Sheet.html#availability
[6]: https://cheatsheetseries.owasp.org/cheatsheets/GraphQL_Cheat_Sheet.html#dos-prevention
[7]: https://cheatsheetseries.owasp.org/cheatsheets/GraphQL_Cheat_Sheet.html#mitigating-batching-attacks
[8]: https://cwe.mitre.org/data/definitions/770.html
[9]: https://cwe.mitre.org/data/definitions/400.html
[10]: https://cwe.mitre.org/data/definitions/799.html
[11]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204.pdf