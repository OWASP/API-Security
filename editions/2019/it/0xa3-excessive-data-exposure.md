# API3:2019 Excessive Data Exposure

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **3** | Diffusione **2** : Rilevabilità **2** | Tecnico **2** : Specifico per il Business |
| Lo sfruttamento dell'Excessive Data Exposure è semplice e viene solitamente effettuato analizzando il traffico per esaminare le risposte API, cercando esposizioni di dati sensibili che non dovrebbero essere restituite all'utente. | Le API si affidano ai client per il filtraggio dei dati. Poiché le API vengono utilizzate come fonti di dati, a volte gli sviluppatori cercano di implementarle in modo generico senza pensare alla sensibilità dei dati esposti. Gli strumenti automatici di solito non riescono a rilevare questo tipo di vulnerabilità perché è difficile distinguere tra dati legittimi restituiti dall'API e dati sensibili che non dovrebbero essere restituiti senza una comprensione approfondita dell'applicazione. | L'Excessive Data Exposure porta comunemente all'esposizione di dati sensibili. |

## L'API è Vulnerabile?

L'API restituisce dati sensibili al client per design. Questi dati vengono
solitamente filtrati lato client prima di essere presentati all'utente. Un
attaccante può facilmente analizzare il traffico e visualizzare i dati sensibili.

## Scenari di Attacco di Esempio

### Scenario #1

Il team mobile utilizza l'endpoint `/api/articles/{articleId}/comments/{commentId}`
nella visualizzazione degli articoli per mostrare i metadati dei commenti.
Analizzando il traffico dell'applicazione mobile, un attaccante scopre che
vengono restituiti anche altri dati sensibili relativi all'autore del commento.
L'implementazione dell'endpoint utilizza un metodo generico `toJSON()` sul
modello `User`, che contiene PII, per serializzare l'oggetto.

### Scenario #2

Un sistema di sorveglianza basato su IoT consente agli amministratori di creare
utenti con permessi diversi. Un amministratore ha creato un account per una nuova
guardia di sicurezza che dovrebbe avere accesso solo a specifici edifici del
sito. Una volta che la guardia di sicurezza utilizza la sua app mobile, viene
effettuata una chiamata API a: `/api/sites/111/cameras` per ricevere dati sulle
telecamere disponibili e mostrarle nella dashboard. La risposta contiene un
elenco con i dettagli delle telecamere nel seguente formato:
`{"id":"xxx","live_access_token":"xxxx-bbbbb","building_id":"yyy"}`.
Mentre l'interfaccia grafica del client mostra solo le telecamere a cui la
guardia di sicurezza dovrebbe avere accesso, la risposta effettiva dell'API
contiene l'elenco completo di tutte le telecamere del sito.

## Come Prevenire

* Non fare mai affidamento sul lato client per filtrare i dati sensibili.
* Verificare le risposte dell'API per assicurarsi che contengano solo dati
  legittimi.
* Gli ingegneri back-end dovrebbero sempre chiedersi "chi è il consumatore dei
  dati?" prima di esporre un nuovo endpoint API.
* Evitare l'uso di metodi generici come `to_json()` e `to_string()`. Selezionare
  invece specificamente le proprietà che si desidera davvero restituire.
* Classificare le informazioni sensibili e di identificazione personale (PII)
  che l'applicazione archivia e gestisce, esaminando tutte le chiamate API che
  restituiscono tali informazioni per verificare se queste risposte rappresentano
  un problema di sicurezza.
* Implementare un meccanismo di validazione della risposta basato su schema come
  ulteriore livello di sicurezza. Come parte di questo meccanismo, definire e
  applicare i dati restituiti da tutti i metodi API, inclusi gli errori.

## Riferimenti

### Esterni

* [CWE-213: Intentional Information Exposure][1]

[1]: https://cwe.mitre.org/data/definitions/213.html
