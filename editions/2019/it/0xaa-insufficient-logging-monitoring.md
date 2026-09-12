# API10:2019 Insufficient Logging & Monitoring

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **2** | Diffusione **3** : Rilevabilità **1** | Tecnico **2** : Specifico per il Business |
| Gli attaccanti approfittano della mancanza di logging e monitoraggio per abusare dei sistemi senza essere notati. | Senza logging e monitoraggio, o con logging e monitoraggio insufficienti, è quasi impossibile tracciare attività sospette e rispondervi in modo tempestivo. | Senza visibilità sulle attività malevole in corso, gli attaccanti hanno tutto il tempo necessario per compromettere completamente i sistemi. |

## L'API è Vulnerabile?

L'API è vulnerabile se:

* Non produce alcun log, il livello di logging non è impostato correttamente, o
  i messaggi di log non includono dettagli sufficienti.
* L'integrità dei log non è garantita (ad esempio [Log Injection][1]).
* I log non vengono monitorati continuamente.
* L'infrastruttura API non viene monitorata continuamente.

## Scenari di Attacco di Esempio

### Scenario #1

Le chiavi di accesso di un'API amministrativa sono state divulgate in un
repository pubblico. Il proprietario del repository è stato notificato via email
della potenziale divulgazione, ma ha impiegato più di 48 ore per agire
sull'incidente, e l'esposizione delle chiavi di accesso potrebbe aver consentito
l'accesso a dati sensibili. A causa di un logging insufficiente, l'azienda non
è in grado di valutare a quali dati hanno avuto accesso gli attori malevoli.

### Scenario #2

Una piattaforma di condivisione video è stata colpita da un attacco di
credential stuffing "su larga scala". Nonostante i tentativi di login falliti
fossero registrati nei log, durante l'arco temporale dell'attacco non è stato
attivato alcun alert. In risposta alle lamentele degli utenti, i log dell'API
sono stati analizzati e l'attacco è stato rilevato. L'azienda ha dovuto fare un
annuncio pubblico chiedendo agli utenti di reimpostare le proprie password e
segnalare l'incidente alle autorità di regolamentazione.

## Come Prevenire

* Registrare tutti i tentativi di autenticazione falliti, gli accessi negati e
  gli errori di validazione dell'input.
* I log devono essere scritti in un formato adatto per essere consumato da una
  soluzione di gestione dei log e devono includere dettagli sufficienti per
  identificare l'attore malevolo.
* I log devono essere gestiti come dati sensibili e la loro integrità deve essere
  garantita sia a riposo che in transito.
* Configurare un sistema di monitoraggio per monitorare continuamente
  l'infrastruttura, la rete e il funzionamento dell'API.
* Utilizzare un sistema SIEM (Security Information and Event Management) per
  aggregare e gestire i log di tutti i componenti dello stack API e degli host.
* Configurare dashboard e alert personalizzati, consentendo di rilevare e
  rispondere prima alle attività sospette.

## Riferimenti

### OWASP

* [OWASP Logging Cheat Sheet][2]
* [OWASP Proactive Controls: Implement Logging and Intrusion Detection][3]
* [OWASP Application Security Verification Standard: V7: Error Handling and
  Logging Verification Requirements][4]

### Esterni

* [CWE-223: Omission of Security-relevant Information][5]
* [CWE-778: Insufficient Logging][6]

[1]: https://www.owasp.org/index.php/Log_Injection
[2]: https://www.owasp.org/index.php/Logging_Cheat_Sheet
[3]: https://www.owasp.org/index.php/OWASP_Proactive_Controls
[4]: https://github.com/OWASP/ASVS/blob/master/4.0/en/0x15-V7-Error-Logging.md
[5]: https://cwe.mitre.org/data/definitions/223.html
[6]: https://cwe.mitre.org/data/definitions/778.html
