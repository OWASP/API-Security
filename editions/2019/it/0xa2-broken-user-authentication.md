# API2:2019 Broken User Authentication

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **3** | Diffusione **2** : Rilevabilità **2** | Tecnico **3** : Specifico per il Business |
| L'autenticazione nelle API è un meccanismo complesso e spesso frainteso. Gli ingegneri software e di sicurezza possono avere idee errate su quali siano i confini dell'autenticazione e su come implementarla correttamente. Inoltre, il meccanismo di autenticazione è un bersaglio facile per gli attaccanti poiché è esposto a tutti. Questi due fattori rendono il componente di autenticazione potenzialmente vulnerabile a molti tipi di exploit. | Esistono due sotto-problemi: 1. Mancanza di meccanismi di protezione: gli endpoint API responsabili dell'autenticazione devono essere trattati diversamente dagli endpoint ordinari e implementare livelli aggiuntivi di protezione. 2. Implementazione errata del meccanismo: il meccanismo viene utilizzato/implementato senza considerare i vettori di attacco, oppure è il caso d'uso sbagliato (ad esempio un meccanismo di autenticazione progettato per client IoT potrebbe non essere la scelta giusta per le applicazioni web). | Gli attaccanti possono ottenere il controllo degli account di altri utenti nel sistema, leggere i loro dati personali ed eseguire azioni sensibili per loro conto, come transazioni economiche e invio di messaggi personali. |

## L'API è Vulnerabile?

Gli endpoint e i flussi di autenticazione sono risorse che devono essere
protette. Le funzionalità di "recupero password / reset password" devono essere
trattate allo stesso modo dei meccanismi di autenticazione.

Un'API è vulnerabile se:
* Permette il [credential stuffing][1] in cui l'attaccante dispone di una lista
  di nomi utente e password validi.
* Consente agli attaccanti di effettuare un attacco a forza bruta sullo stesso
  account utente, senza presentare captcha o meccanismi di blocco dell'account.
* Permette password deboli.
* Invia dettagli di autenticazione sensibili, come token di autenticazione e
  password, nell'URL.
* Non verifica l'autenticità dei token.
* Accetta token JWT non firmati o firmati in modo debole (`"alg":"none"`)/non
  ne verifica la data di scadenza.
* Utilizza password in chiaro, non cifrate o con hashing debole.
* Utilizza chiavi di cifratura deboli.

## Scenari di Attacco di Esempio

## Scenario #1

Il [credential stuffing][1] (usando [liste di username/password noti][2]) è un
attacco comune. Se un'applicazione non implementa protezioni automatizzate contro
le minacce o il credential stuffing, l'applicazione può essere utilizzata come
oracolo di password per determinare se le credenziali sono valide.

## Scenario #2

Un attaccante avvia il flusso di recupero password inviando una richiesta POST a
`/api/system/verification-codes` e fornendo il nome utente nel corpo della
richiesta. Successivamente, un token SMS a 6 cifre viene inviato al telefono
della vittima. Poiché l'API non implementa una policy di rate limiting,
l'attaccante può testare tutte le combinazioni possibili usando uno script
multi-thread contro l'endpoint `/api/system/verification-codes/{smsToken}`
per scoprire il token corretto in pochi minuti.

## Come Prevenire

* Assicurarsi di conoscere tutti i possibili flussi di autenticazione all'API
  (mobile/web/deep link che implementano autenticazione con un clic/ecc.)
* Chiedere agli sviluppatori quali flussi sono stati tralasciati.
* Documentarsi sui meccanismi di autenticazione in uso. Assicurarsi di capire
  cosa sono e come vengono utilizzati. OAuth non è un sistema di autenticazione,
  e nemmeno le API key.
* Non reinventare la ruota nell'autenticazione, nella generazione di token, o
  nell'archiviazione delle password. Utilizzare gli standard.
* Gli endpoint di recupero credenziali/password dimenticata devono essere
  trattati come gli endpoint di login in termini di protezione da forza bruta,
  rate limiting e blocco dell'account.
* Utilizzare l'[OWASP Authentication Cheatsheet][3].
* Dove possibile, implementare l'autenticazione a più fattori.
* Implementare meccanismi anti-forza bruta per mitigare il credential stuffing,
  gli attacchi a dizionario e gli attacchi a forza bruta sugli endpoint di
  autenticazione. Questo meccanismo deve essere più restrittivo dei normali
  meccanismi di rate limiting delle API.
* Implementare meccanismi di [blocco dell'account][4]/captcha per prevenire
  attacchi a forza bruta su utenti specifici. Implementare controlli sulle
  password deboli.
* Le API key non devono essere utilizzate per l'autenticazione degli utenti, ma
  per l'[autenticazione delle app client/progetto][5].

## Riferimenti

### OWASP

* [OWASP Key Management Cheat Sheet][6]
* [OWASP Authentication Cheatsheet][3]
* [Credential Stuffing][1]

### Esterni

* [CWE-798: Use of Hard-coded Credentials][7]

[1]: https://www.owasp.org/index.php/Credential_stuffing
[2]: https://github.com/danielmiessler/SecLists
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[4]: https://www.owasp.org/index.php/Testing_for_Weak_lock_out_mechanism_(OTG-AUTHN-003)
[5]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[6]: https://www.owasp.org/index.php/Key_Management_Cheat_Sheet
[7]: https://cwe.mitre.org/data/definitions/798.html
