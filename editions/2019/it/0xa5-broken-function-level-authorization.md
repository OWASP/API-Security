# API5:2019 Broken Function Level Authorization

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **3** | Diffusione **2** : Rilevabilità **1** | Tecnico **2** : Specifico per il Business |
| Lo sfruttamento richiede che l'attaccante invii chiamate API legittime all'endpoint API a cui non dovrebbe avere accesso. Questi endpoint potrebbero essere esposti a utenti anonimi o a utenti normali senza privilegi. È più facile scoprire queste falle nelle API poiché le API sono più strutturate e il modo per accedere a determinate funzioni è più prevedibile (ad esempio sostituendo il metodo HTTP da GET a PUT, o cambiando la stringa "users" nell'URL con "admins"). | I controlli di autorizzazione per una funzione o una risorsa vengono solitamente gestiti tramite configurazione, e a volte a livello di codice. Implementare controlli adeguati può essere un compito complesso, poiché le applicazioni moderne possono contenere molti tipi di ruoli o gruppi e gerarchie utente complesse (ad esempio sotto-utenti, utenti con più di un ruolo). | Tali falle consentono agli attaccanti di accedere a funzionalità non autorizzate. Le funzioni amministrative sono i principali obiettivi di questo tipo di attacco. |

## L'API è Vulnerabile?

Il modo migliore per individuare problemi di Broken Function Level Authorization
è eseguire un'analisi approfondita del meccanismo di autorizzazione, tenendo a
mente la gerarchia degli utenti, i diversi ruoli o gruppi nell'applicazione, e
ponendo le seguenti domande:

* Un utente normale può accedere agli endpoint amministrativi?
* Un utente può eseguire azioni sensibili (ad esempio creazione, modifica o
  cancellazione) a cui non dovrebbe avere accesso semplicemente cambiando il
  metodo HTTP (ad esempio da `GET` a `DELETE`)?
* Un utente del gruppo X può accedere a una funzione che dovrebbe essere esposta
  solo agli utenti del gruppo Y, semplicemente indovinando l'URL e i parametri
  dell'endpoint (ad esempio `/api/v1/users/export_all`)?

Non presumere che un endpoint API sia ordinario o amministrativo solo in base
al percorso URL.

Sebbene gli sviluppatori possano scegliere di esporre la maggior parte degli
endpoint amministrativi sotto un percorso relativo specifico, come `api/admins`,
è molto comune trovare questi endpoint amministrativi sotto altri percorsi
relativi insieme agli endpoint ordinari, come `api/users`.

## Scenari di Attacco di Esempio

### Scenario #1

Durante il processo di registrazione per un'applicazione che consente solo agli
utenti invitati di iscriversi, l'app mobile effettua una chiamata API a
`GET /api/invites/{invite_guid}`. La risposta contiene un JSON con i dettagli
dell'invito, incluso il ruolo dell'utente e il suo indirizzo email.

Un attaccante ha duplicato la richiesta e ha manipolato il metodo HTTP e
l'endpoint in `POST /api/invites/new`. Questo endpoint dovrebbe essere
accessibile solo dagli amministratori tramite la console di amministrazione, che
non implementa controlli di autorizzazione a livello di funzione.

L'attaccante sfrutta la vulnerabilità e si invia un invito per creare un
account amministratore:

```
POST /api/invites/new

{"email":"hugo@malicious.com","role":"admin"}
```

### Scenario #2

Un'API contiene un endpoint che dovrebbe essere esposto solo agli
amministratori — `GET /api/admin/v1/users/all`. Questo endpoint restituisce i
dettagli di tutti gli utenti dell'applicazione e non implementa controlli di
autorizzazione a livello di funzione. Un attaccante che ha appreso la struttura
dell'API fa un tentativo ragionato e riesce ad accedere a questo endpoint, che
espone dettagli sensibili degli utenti dell'applicazione.

## Come Prevenire

La tua applicazione dovrebbe avere un modulo di autorizzazione coerente e
facilmente analizzabile, invocato da tutte le funzioni di business. Spesso,
tale protezione è fornita da uno o più componenti esterni al codice
dell'applicazione.

* Il meccanismo (o i meccanismi) di controllo deve negare l'accesso per
  impostazione predefinita, richiedendo concessioni esplicite a ruoli specifici
  per l'accesso a ogni funzione.
* Verificare gli endpoint API rispetto alle falle di autorizzazione a livello
  di funzione, tenendo a mente la logica di business dell'applicazione e la
  gerarchia dei gruppi.
* Assicurarsi che tutti i controller amministrativi ereditino da un controller
  astratto amministrativo che implementa i controlli di autorizzazione in base
  al gruppo/ruolo dell'utente.
* Assicurarsi che le funzioni amministrative all'interno di un controller
  ordinario implementino controlli di autorizzazione basati sul gruppo e sul
  ruolo dell'utente.

## Riferimenti

### OWASP

* [OWASP Article on Forced Browsing][1]
* [OWASP Top 10 2013-A7-Missing Function Level Access Control][2]
* [OWASP Development Guide: Chapter on Authorization][3]

### Esterni

* [CWE-285: Improper Authorization][4]

[1]: https://www.owasp.org/index.php/Forced_browsing
[2]: https://www.owasp.org/index.php/Top_10_2013-A7-Missing_Function_Level_Access_Control
[3]: https://www.owasp.org/index.php/Category:Access_Control
[4]: https://cwe.mitre.org/data/definitions/285.html
