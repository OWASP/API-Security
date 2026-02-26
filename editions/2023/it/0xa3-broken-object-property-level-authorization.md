# API3:2023 Broken Object Property Level Authorization

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **Facile** | Diffusione **Comune** : Rilevabilità **Facile** | Tecnico **Moderato** : Specifico per il Business |
| Le API tendono a esporre endpoint che restituiscono tutte le proprietà degli oggetti. Questo vale in particolare per le REST API. Per altri protocolli come GraphQL, potrebbe essere necessario costruire richieste ad hoc per specificare quali proprietà devono essere restituite. Identificare queste proprietà aggiuntive che possono essere manipolate richiede più impegno, ma esistono alcuni strumenti automatizzati che possono aiutare in questo compito. | Analizzare le risposte dell'API è sufficiente per identificare informazioni sensibili nelle rappresentazioni degli oggetti restituiti. Il fuzzing viene solitamente usato per identificare proprietà aggiuntive (nascoste). La possibilità di modificarle dipende dalla costruzione di una richiesta API e dall'analisi della risposta. Potrebbe essere necessaria un'analisi degli effetti collaterali se la proprietà bersaglio non viene restituita nella risposta API. | L'accesso non autorizzato a proprietà private/sensibili degli oggetti può comportare divulgazione di dati, perdita di dati o corruzione di dati. In determinate circostanze, l'accesso non autorizzato alle proprietà degli oggetti può portare a escalation di privilegi o alla compromissione parziale/totale dell'account. |

## L'API è Vulnerabile?

Quando si consente a un utente di accedere a un oggetto tramite un endpoint API,
è importante verificare che l'utente abbia accesso alle specifiche proprietà
dell'oggetto a cui sta cercando di accedere.

Un endpoint API è vulnerabile se:

* Espone proprietà di un oggetto che sono considerate sensibili e non dovrebbero
  essere lette dall'utente. (precedentemente denominato: "[Excessive
  Data Exposure][1]")
* Consente a un utente di modificare, aggiungere e/o eliminare il valore di una
  proprietà sensibile di un oggetto a cui l'utente non dovrebbe avere accesso
  (precedentemente denominato: "[Mass Assignment][2]")

## Scenari di Attacco di Esempio

### Scenario #1

Un'app di incontri consente agli utenti di segnalare altri utenti per
comportamenti inappropriati. Come parte di questo flusso, l'utente fa clic su
un pulsante "segnala" e viene attivata la seguente chiamata API:

```
POST /graphql
{
  "operationName":"reportUser",
  "variables":{
    "userId": 313,
    "reason":["offensive behavior"]
  },
  "query":"mutation reportUser($userId: ID!, $reason: String!) {
    reportUser(userId: $userId, reason: $reason) {
      status
      message
      reportedUser {
        id
        fullName
        recentLocation
      }
    }
  }"
}
```

L'endpoint API è vulnerabile perché consente all'utente autenticato di accedere
a proprietà sensibili dell'oggetto utente segnalato, come "fullName" e
"recentLocation", che non dovrebbero essere accessibili ad altri utenti.

### Scenario #2

Una piattaforma di marketplace online, che consente a un tipo di utenti
("host") di affittare il proprio appartamento a un altro tipo di utenti
("ospiti"), richiede che l'host accetti una prenotazione effettuata da un
ospite prima di addebitare il costo del soggiorno.

Come parte di questo flusso, una chiamata API viene inviata dall'host a
`POST /api/host/approve_booking` con il seguente payload legittimo:

```
{
  "approved": true,
  "comment": "Check-in is after 3pm"
}
```

L'host ripete la richiesta legittima e aggiunge il seguente payload malevolo:

```
{
  "approved": true,
  "comment": "Check-in is after 3pm",
  "total_stay_price": "$1,000,000"
}
```

L'endpoint API è vulnerabile perché non viene verificato se l'host dovrebbe
avere accesso alla proprietà interna dell'oggetto - `total_stay_price`, e
all'ospite verrà addebitato un importo superiore a quello dovuto.

### Scenario #3

Un social network basato su brevi video applica filtri restrittivi sui contenuti
e censura. Anche se un video caricato viene bloccato, l'utente può modificare
la descrizione del video tramite la seguente richiesta API:

```
PUT /api/video/update_video

{
  "description": "a funny video about cats"
}
```

Un utente frustrato può ripetere la richiesta legittima e aggiungere il
seguente payload malevolo:

```
{
  "description": "a funny video about cats",
  "blocked": false
}
```

L'endpoint API è vulnerabile perché non viene verificato se l'utente dovrebbe
avere accesso alla proprietà interna dell'oggetto - `blocked`, e l'utente può
modificare il valore da `true` a `false` e sbloccare i propri contenuti bloccati.

## Come Prevenire

* Quando si espone un oggetto tramite un endpoint API, assicurarsi sempre che
  l'utente debba avere accesso alle proprietà dell'oggetto che si espongono.
* Evitare l'uso di metodi generici come `to_json()` e `to_string()`. Selezionare
  invece specificamente le proprietà dell'oggetto che si desidera restituire.
* Se possibile, evitare l'uso di funzioni che associano automaticamente l'input
  del client a variabili di codice, oggetti interni o proprietà degli oggetti
  ("Mass Assignment").
* Consentire modifiche solo alle proprietà degli oggetti che devono essere
  aggiornate dal client.
* Implementare un meccanismo di validazione della risposta basato su schema come
  ulteriore livello di sicurezza. Come parte di questo meccanismo, definire e
  applicare i dati restituiti da tutti i metodi API.
* Mantenere le strutture dati restituite al minimo indispensabile, in base ai
  requisiti funzionali/di business per l'endpoint.

## Riferimenti

### OWASP

* [API3:2019 Excessive Data Exposure - OWASP API Security Top 10 2019][1]
* [API6:2019 - Mass Assignment - OWASP API Security Top 10 2019][2]
* [Mass Assignment Cheat Sheet][3]

### Esterni

* [CWE-213: Exposure of Sensitive Information Due to Incompatible Policies][4]
* [CWE-915: Improperly Controlled Modification of Dynamically-Determined Object Attributes][5]

[1]: https://owasp.org/API-Security/editions/2019/en/0xa3-excessive-data-exposure/
[2]: https://owasp.org/API-Security/editions/2019/en/0xa6-mass-assignment/
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Mass_Assignment_Cheat_Sheet.html
[4]: https://cwe.mitre.org/data/definitions/213.html
[5]: https://cwe.mitre.org/data/definitions/915.html