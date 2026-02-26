# API2:2023 Broken Authentication

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **Facile** | Diffusione **Comune** : Rilevabilità **Facile** | Tecnico **Grave** : Specifico per il Business |
| Il meccanismo di autenticazione è un bersaglio facile per gli attaccanti poiché è esposto a tutti. Sebbene alcune problematiche di autenticazione possano richiedere competenze tecniche più avanzate per essere sfruttate, gli strumenti di attacco sono generalmente disponibili. | Le incomprensioni di ingegneri software e di sicurezza riguardo ai confini dell'autenticazione e la complessità intrinseca dell'implementazione rendono questi problemi molto diffusi. Le metodologie per rilevare un'autenticazione compromessa sono disponibili e facili da realizzare. | Gli attaccanti possono ottenere il controllo completo degli account di altri utenti nel sistema, leggere i loro dati personali ed eseguire azioni sensibili per loro conto. È improbabile che i sistemi riescano a distinguere le azioni degli attaccanti da quelle degli utenti legittimi. |

## L'API è Vulnerabile?

Gli endpoint e i flussi di autenticazione sono risorse che devono essere
protette. Inoltre, le funzionalità di "recupero password / reset password"
devono essere trattate allo stesso modo dei meccanismi di autenticazione.

Un'API è vulnerabile se:

* Consente il credential stuffing, in cui l'attaccante utilizza la forza bruta
  con una lista di nomi utente e password validi.
* Consente agli attaccanti di effettuare un attacco a forza bruta sullo stesso
  account utente, senza presentare captcha o meccanismi di blocco dell'account.
* Permette password deboli.
* Invia dettagli di autenticazione sensibili, come token di autenticazione e
  password, nell'URL.
* Consente agli utenti di modificare il proprio indirizzo email, la password
  attuale o di eseguire altre operazioni sensibili senza richiedere la conferma
  della password.
* Non verifica l'autenticità dei token.
* Accetta token JWT non firmati o firmati in modo debole (`{"alg":"none"}`)
* Non verifica la data di scadenza del JWT.
* Utilizza password in chiaro, non cifrate o con hashing debole.
* Utilizza chiavi di cifratura deboli.

Oltre a ciò, un microservizio è vulnerabile se:

* Altri microservizi possono accedervi senza autenticazione.
* Utilizza token deboli o prevedibili per garantire l'autenticazione.

## Scenari di Attacco di Esempio

## Scenario #1

Per autenticare un utente, il client deve inviare una richiesta API come quella
seguente con le credenziali dell'utente:

```
POST /graphql
{
  "query":"mutation {
    login (username:\"<username>\",password:\"<password>\") {
      token
    }
   }"
}
```

Se le credenziali sono valide, viene restituito un token di autenticazione che
dovrà essere fornito nelle richieste successive per identificare l'utente. I
tentativi di accesso sono soggetti a un rate limiting restrittivo: sono
consentite solo tre richieste al minuto.

Per eseguire un attacco a forza bruta sull'account di una vittima, gli
attaccanti sfruttano il batching delle query GraphQL per aggirare il rate
limiting delle richieste, accelerando l'attacco:

```
POST /graphql
[
  {"query":"mutation{login(username:\"victim\",password:\"password\"){token}}"},
  {"query":"mutation{login(username:\"victim\",password:\"123456\"){token}}"},
  {"query":"mutation{login(username:\"victim\",password:\"qwerty\"){token}}"},
  ...
  {"query":"mutation{login(username:\"victim\",password:\"123\"){token}}"},
]
```

## Scenario #2

Per aggiornare l'indirizzo email associato all'account di un utente, i client
devono inviare una richiesta API come quella seguente:

```
PUT /account
Authorization: Bearer <token>

{ "email": "<new_email_address>" }
```

Poiché l'API non richiede agli utenti di confermare la propria identità
fornendo la password attuale, gli attaccanti in grado di sottrarre il token
di autenticazione potrebbero riuscire a prendere il controllo dell'account
della vittima avviando il flusso di reset della password dopo aver aggiornato
l'indirizzo email dell'account.

## Come Prevenire

* Assicurarsi di conoscere tutti i possibili flussi di autenticazione all'API
  (mobile/web/deep link che implementano autenticazione con un clic/ecc.).
  Chiedere agli sviluppatori quali flussi sono stati tralasciati.
* Documentarsi sui meccanismi di autenticazione in uso. Assicurarsi di capire
  cosa sono e come vengono utilizzati. OAuth non è un sistema di autenticazione,
  e nemmeno le API key.
* Non reinventare la ruota nell'autenticazione, nella generazione di token o
  nell'archiviazione delle password. Utilizzare gli standard.
* Gli endpoint di recupero credenziali/reset password devono essere trattati
  come gli endpoint di login in termini di protezione da forza bruta, rate
  limiting e blocco dell'account.
* Richiedere una nuova autenticazione per le operazioni sensibili (ad esempio
  la modifica dell'email del titolare dell'account o del numero di telefono
  per il 2FA).
* Utilizzare l'[OWASP Authentication Cheatsheet][1].
* Dove possibile, implementare l'autenticazione a più fattori.
* Implementare meccanismi anti-forza bruta per mitigare il credential stuffing,
  gli attacchi a dizionario e gli attacchi a forza bruta sugli endpoint di
  autenticazione. Questo meccanismo deve essere più restrittivo dei normali
  meccanismi di rate limiting delle API.
* Implementare meccanismi di [blocco dell'account][2]/captcha per prevenire
  attacchi a forza bruta su utenti specifici. Implementare controlli sulle
  password deboli.
* Le API key non devono essere utilizzate per l'autenticazione degli utenti.
  Devono essere utilizzate solo per l'autenticazione dei [client API][3].

## Riferimenti

### OWASP

* [Authentication Cheat Sheet][1]
* [Key Management Cheat Sheet][4]
* [Credential Stuffing][5]

### Esterni

* [CWE-204: Observable Response Discrepancy][6]
* [CWE-307: Improper Restriction of Excessive Authentication Attempts][7]

[1]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[2]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/04-Authentication_Testing/03-Testing_for_Weak_Lock_Out_Mechanism(OTG-AUTHN-003)
[3]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[4]: https://cheatsheetseries.owasp.org/cheatsheets/Key_Management_Cheat_Sheet.html
[5]: https://owasp.org/www-community/attacks/Credential_stuffing
[6]: https://cwe.mitre.org/data/definitions/204.html
[7]: https://cwe.mitre.org/data/definitions/307.html