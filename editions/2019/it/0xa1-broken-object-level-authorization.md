# API1:2019 Broken Object Level Authorization

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **3** | Diffusione **3** : Rilevabilità **2** | Tecnico **3** : Specifico per il Business |
| Gli attaccanti possono sfruttare gli endpoint API vulnerabili alla Broken Object Level Authorization manipolando l'ID di un oggetto inviato nella richiesta. Ciò può portare all'accesso non autorizzato a dati sensibili. Questo problema è estremamente comune nelle applicazioni basate su API perché il componente server di solito non tiene traccia completamente dello stato del client e si affida invece a parametri come gli ID degli oggetti, inviati dal client per decidere a quali oggetti accedere. | Questo è stato l'attacco più comune e impattante sulle API. I meccanismi di autorizzazione e controllo degli accessi nelle applicazioni moderne sono complessi e capillarmente diffusi. Anche se l'applicazione implementa una corretta infrastruttura per i controlli di autorizzazione, gli sviluppatori potrebbero dimenticarsi di utilizzare questi controlli prima di accedere a un oggetto sensibile. Il rilevamento dei problemi di controllo degli accessi non si presta tipicamente a test statici o dinamici automatizzati. | L'accesso non autorizzato può comportare la divulgazione di dati a soggetti non autorizzati, la perdita di dati o la loro manipolazione. L'accesso non autorizzato agli oggetti può portare anche alla compromissione totale dell'account. |

## L'API è Vulnerabile?

L'autorizzazione a livello di oggetto è un meccanismo di controllo degli accessi
che viene solitamente implementato a livello di codice per verificare che un
utente possa accedere solo agli oggetti a cui dovrebbe avere accesso.

Ogni endpoint API che riceve un ID di un oggetto ed esegue qualsiasi tipo di
azione su di esso dovrebbe implementare controlli di autorizzazione a livello di
oggetto. I controlli devono verificare che l'utente autenticato abbia effettivamente
accesso per eseguire l'azione richiesta sull'oggetto richiesto.

Le carenze in questo meccanismo portano tipicamente a divulgazione non
autorizzata di informazioni, modifica o distruzione di tutti i dati.

## Scenari di Attacco di Esempio

### Scenario #1

Una piattaforma di e-commerce per negozi online fornisce una pagina con i grafici
delle entrate per i negozi ospitati. Analizzando le richieste del browser, un
attaccante identifica gli endpoint API usati come fonte dati per quei grafici e
il loro schema `/shops/{shopName}/revenue_data.json`. Utilizzando un altro
endpoint API, l'attaccante ottiene la lista di tutti i nomi dei negozi ospitati.
Con un semplice script che manipola i nomi nella lista, sostituendo `{shopName}`
nell'URL, l'attaccante ottiene accesso ai dati di vendita di migliaia di negozi.

### Scenario #2

Durante il monitoraggio del traffico di rete di un dispositivo indossabile,
una richiesta HTTP `PATCH` attira l'attenzione di un attaccante per la presenza
di un header HTTP personalizzato `X-User-Id: 54796`. Sostituendo il valore
`X-User-Id` con `54795`, l'attaccante riceve una risposta HTTP di successo ed
è in grado di modificare i dati dell'account di altri utenti.

## Come Prevenire

* Implementare un meccanismo di autorizzazione adeguato che si basi sulle policy
  e sulla gerarchia degli utenti.
* Utilizzare un meccanismo di autorizzazione per verificare che l'utente
  autenticato abbia il permesso di eseguire l'azione richiesta sul record in
  ogni funzione che utilizza un input dal client per accedere a un record nel
  database.
* Preferire l'uso di valori casuali e imprevedibili come GUID per gli ID dei
  record.
* Scrivere test per valutare il meccanismo di autorizzazione. Non rilasciare
  modifiche vulnerabili che causino il fallimento dei test.

## Riferimenti

### Esterni

* [CWE-284: Improper Access Control][1]
* [CWE-285: Improper Authorization][2]
* [CWE-639: Authorization Bypass Through User-Controlled Key][3]

[1]: https://cwe.mitre.org/data/definitions/284.html
[2]: https://cwe.mitre.org/data/definitions/285.html
[3]: https://cwe.mitre.org/data/definitions/639.html
