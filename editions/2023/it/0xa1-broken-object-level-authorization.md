# API1:2023 Broken Object Level Authorization

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **Facile** | Diffusione **Elevata** : Rilevabilità **Facile** | Tecnico **Moderato** : Specifico per il Business |
| Gli attaccanti possono sfruttare gli endpoint API vulnerabili alla Broken Object Level Authorization manipolando l'ID di un oggetto inviato nella richiesta. Gli ID degli oggetti possono essere qualsiasi cosa: interi sequenziali, UUID o stringhe generiche. Indipendentemente dal tipo di dato, sono facilmente identificabili nel target della richiesta (percorso o parametri della query string), nelle intestazioni della richiesta, o anche come parte del payload della richiesta. | Questo problema è estremamente comune nelle applicazioni basate su API perché il componente server di solito non tiene traccia completamente dello stato del client e si affida invece a parametri come gli ID degli oggetti, inviati dal client per decidere a quali oggetti accedere. La risposta del server è generalmente sufficiente per capire se la richiesta è andata a buon fine. | L'accesso non autorizzato agli oggetti di altri utenti può comportare la divulgazione di dati a soggetti non autorizzati, la perdita di dati o la loro manipolazione. In determinate circostanze, l'accesso non autorizzato agli oggetti può portare anche alla compromissione totale dell'account. |

## L'API è Vulnerabile?

L'autorizzazione a livello di oggetto è un meccanismo di controllo degli accessi
che viene solitamente implementato a livello di codice per verificare che un
utente possa accedere solo agli oggetti per i quali ha i permessi necessari.

Ogni endpoint API che riceve un ID di un oggetto ed esegue qualsiasi azione su
di esso dovrebbe implementare controlli di autorizzazione a livello di oggetto.
I controlli devono verificare che l'utente autenticato abbia i permessi per
eseguire l'azione richiesta sull'oggetto richiesto.

Le carenze in questo meccanismo portano tipicamente a divulgazione non
autorizzata di informazioni, modifica o distruzione di tutti i dati.

Confrontare l'ID utente della sessione corrente (ad esempio estraendolo dal
token JWT) con il parametro ID vulnerabile non è una soluzione sufficiente per
risolvere la Broken Object Level Authorization (BOLA). Questo approccio potrebbe
coprire solo un sottoinsieme ristretto di casi.

Nel caso di BOLA, è per design che l'utente avrà accesso all'endpoint/funzione
API vulnerabile. La violazione avviene a livello di oggetto, manipolando l'ID.
Se un attaccante riesce ad accedere a un endpoint/funzione API a cui non
dovrebbe avere accesso, si tratta di un caso di [Broken Function Level
Authorization][5] (BFLA) e non di BOLA.

## Scenari di Attacco di Esempio

### Scenario #1

Una piattaforma di e-commerce per negozi online fornisce una pagina con i grafici
delle entrate per i negozi ospitati. Analizzando le richieste del browser, un
attaccante identifica gli endpoint API usati come fonte dati per quei grafici e
il loro schema: `/shops/{shopName}/revenue_data.json`. Utilizzando un altro
endpoint API, l'attaccante ottiene la lista di tutti i nomi dei negozi ospitati.
Con un semplice script che manipola i nomi nella lista, sostituendo `{shopName}`
nell'URL, l'attaccante ottiene accesso ai dati di vendita di migliaia di negozi.

### Scenario #2

Un produttore di automobili ha abilitato il controllo remoto dei propri veicoli
tramite un'API mobile per la comunicazione con lo smartphone del conducente.
L'API consente al conducente di avviare e spegnere il motore da remoto e di
bloccare e sbloccare le portiere. Come parte di questo flusso, l'utente invia
il Numero di Identificazione del Veicolo (VIN) all'API.
L'API non verifica che il VIN corrisponda a un veicolo appartenente all'utente
autenticato, il che porta a una vulnerabilità BOLA. Un attaccante può accedere
a veicoli che non gli appartengono.

### Scenario #3

Un servizio di archiviazione documenti online consente agli utenti di
visualizzare, modificare, archiviare ed eliminare i propri documenti. Quando un
documento viene eliminato, una mutazione GraphQL con l'ID del documento viene
inviata all'API.

```
POST /graphql
{
  "operationName":"deleteReports",
  "variables":{
    "reportKeys":["<DOCUMENT_ID>"]
  },
  "query":"mutation deleteReports($siteId: ID!, $reportKeys: [String]!) {
    {
      deleteReports(reportKeys: $reportKeys)
    }
  }"
}
```

Poiché il documento con l'ID specificato viene eliminato senza ulteriori
verifiche sui permessi, un utente potrebbe essere in grado di eliminare il
documento di un altro utente.

## Come Prevenire

* Implementare un meccanismo di autorizzazione adeguato che si basi sulle policy
  e sulla gerarchia degli utenti.
* Utilizzare il meccanismo di autorizzazione per verificare che l'utente
  autenticato abbia il permesso di eseguire l'azione richiesta sul record in
  ogni funzione che utilizza un input dal client per accedere a un record nel
  database.
* Preferire l'uso di valori casuali e imprevedibili come GUID per gli ID dei
  record.
* Scrivere test per valutare la vulnerabilità del meccanismo di autorizzazione.
  Non rilasciare modifiche che causino il fallimento dei test.

**Nota**

* Utilizzare GUID/UUID al posto di identificatori prevedibili aiuta a mitigare gli attacchi di enumerazione degli oggetti. Tuttavia, una volta che un identificatore valido viene divulgato—che sia tramite un altro endpoint, un'eccessiva esposizione dei dati, il logging o un'altra vulnerabilità—esso deve essere considerato un'informazione pubblica.

* Le decisioni di autorizzazione non devono mai basarsi sulla segretezza o sull'imprevedibilità degli identificatori degli oggetti. Ogni richiesta deve verificare in modo indipendente che l'utente autenticato sia autorizzato ad accedere all'oggetto richiesto.

## Riferimenti

### OWASP

* [Authorization Cheat Sheet][1]
* [Authorization Testing Automation Cheat Sheet][2]

### Esterni

* [CWE-285: Improper Authorization][3]
* [CWE-639: Authorization Bypass Through User-Controlled Key][4]

[1]: https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html
[2]: https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Testing_Automation_Cheat_Sheet.html
[3]: https://cwe.mitre.org/data/definitions/285.html
[4]: https://cwe.mitre.org/data/definitions/639.html
[5]: ./0xa5-broken-function-level-authorization.md