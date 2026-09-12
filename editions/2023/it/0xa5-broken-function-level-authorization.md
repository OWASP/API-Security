# API5:2023 Broken Function Level Authorization

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **Facile** | Diffusione **Comune** : Rilevabilità **Facile** | Tecnico **Grave** : Specifico per il Business |
| Lo sfruttamento richiede che l'attaccante invii chiamate API legittime a un endpoint API a cui non dovrebbe avere accesso come utente anonimo o come utente normale senza privilegi. Gli endpoint esposti saranno facilmente sfruttati. | I controlli di autorizzazione per una funzione o una risorsa vengono solitamente gestiti tramite configurazione o a livello di codice. Implementare controlli adeguati può essere un compito complesso, poiché le applicazioni moderne possono contenere molti tipi di ruoli, gruppi e gerarchie utente complesse (ad esempio sotto-utenti o utenti con più di un ruolo). È più facile scoprire queste falle nelle API poiché le API sono più strutturate e l'accesso a funzioni diverse è più prevedibile. | Tali falle consentono agli attaccanti di accedere a funzionalità non autorizzate. Le funzioni amministrative sono i principali obiettivi di questo tipo di attacco e possono portare a divulgazione di dati, perdita di dati o corruzione di dati. In ultima analisi, può portare a interruzioni del servizio. |

## L'API è Vulnerabile?

Il modo migliore per individuare problemi di Broken Function Level Authorization
è eseguire un'analisi approfondita del meccanismo di autorizzazione tenendo a
mente la gerarchia degli utenti, i diversi ruoli o gruppi nell'applicazione, e
ponendo le seguenti domande:

* Un utente normale può accedere agli endpoint amministrativi?
* Un utente può eseguire azioni sensibili (ad esempio creazione, modifica o
  eliminazione) a cui non dovrebbe avere accesso semplicemente cambiando il
  metodo HTTP (ad esempio da `GET` a `DELETE`)?
* Un utente del gruppo X può accedere a una funzione che dovrebbe essere esposta
  solo agli utenti del gruppo Y, semplicemente indovinando l'URL e i parametri
  dell'endpoint (ad esempio `/api/v1/users/export_all`)?

Non presumere che un endpoint API sia ordinario o amministrativo solo in base
al percorso URL.

Sebbene gli sviluppatori possano scegliere di esporre la maggior parte degli
endpoint amministrativi sotto un percorso relativo specifico, come `/api/admins`,
è molto comune trovare questi endpoint amministrativi sotto altri percorsi
relativi insieme agli endpoint ordinari, come `/api/users`.

## Scenari di Attacco di Esempio

### Scenario #1

Durante il processo di registrazione per un'applicazione che consente solo agli
utenti invitati di iscriversi, l'app mobile effettua una chiamata API a
`GET /api/invites/{invite_guid}`. La risposta contiene un JSON con i dettagli
dell'invito, incluso il ruolo dell'utente e il suo indirizzo email.

Un attaccante duplica la richiesta e manipola il metodo HTTP e l'endpoint in
`POST /api/invites/new`. Questo endpoint dovrebbe essere accessibile solo dagli
amministratori tramite la console di amministrazione. L'endpoint non implementa
controlli di autorizzazione a livello di funzione.

L'attaccante sfrutta la vulnerabilità e invia un nuovo invito con privilegi
di amministratore:

```
POST /api/invites/new

{
  "email": "attacker@somehost.com",
  "role":"admin"
}
```

In seguito, l'attaccante utilizza l'invito artefatto per creare un account
amministratore e ottenere accesso completo al sistema.

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

* [Forced Browsing][1]
* "A7: Missing Function Level Access Control", [OWASP Top 10 2013][2]
* [Access Control][3]

### Esterni

* [CWE-285: Improper Authorization][4]

[1]: https://owasp.org/www-community/attacks/Forced_browsing
[2]: https://github.com/OWASP/Top10/raw/master/2013/OWASP%20Top%2010%20-%202013.pdf
[3]: https://owasp.org/www-community/Access_Control
[4]: https://cwe.mitre.org/data/definitions/285.html