# API6:2023 Unrestricted Access to Sensitive Business Flows

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **Facile** | Diffusione **Elevata** : Rilevabilità **Media** | Tecnico **Moderato** : Specifico per il Business |
| Lo sfruttamento implica solitamente la comprensione del modello di business supportato dall'API, l'identificazione dei flussi di business sensibili e l'automazione dell'accesso a questi flussi, causando danno al business. | La mancanza di una visione complessiva dell'API tale da supportare pienamente i requisiti di business tende a contribuire alla diffusione di questo problema. Gli attaccanti identificano manualmente le risorse (ad esempio gli endpoint) coinvolte nel flusso target e il modo in cui interagiscono tra loro. Se sono già presenti meccanismi di mitigazione, gli attaccanti devono trovare un modo per aggirarli. | In generale non si prevede un impatto tecnico. Lo sfruttamento potrebbe danneggiare il business in diversi modi, ad esempio: impedire agli utenti legittimi di acquistare un prodotto, o provocare inflazione nell'economia interna di un gioco. |

## L'API è Vulnerabile?

Quando si crea un endpoint API, è importante capire quale flusso di business
espone. Alcuni flussi di business sono più sensibili di altri, nel senso che
un accesso eccessivo ad essi può danneggiare il business.

Esempi comuni di flussi di business sensibili e rischi associati a un accesso
eccessivo:

* Flusso di acquisto di un prodotto — un attaccante può comprare tutto lo stock
  di un articolo molto richiesto in una volta e rivenderlo a un prezzo più alto
  (scalping)
* Flusso di creazione di un commento/post — un attaccante può inondare il
  sistema di spam
* Flusso di prenotazione — un attaccante può prenotare tutte le fasce orarie
  disponibili e impedire ad altri utenti di utilizzare il sistema

Il rischio di accesso eccessivo può variare tra settori e aziende. Ad esempio,
la creazione di post tramite script potrebbe essere considerata un rischio di
spam da un social network, ma incoraggiata da un altro.

Un endpoint API è vulnerabile se espone un flusso di business sensibile senza
limitarne adeguatamente l'accesso.

## Scenari di Attacco di Esempio

### Scenario #1

Un'azienda tecnologica annuncia il lancio di una nuova console da gioco per il
Giorno del Ringraziamento. Il prodotto ha una domanda molto elevata e le scorte
sono limitate. Un attaccante scrive del codice per acquistare automaticamente
il nuovo prodotto e completare la transazione.

Il giorno del lancio, l'attaccante esegue il codice distribuito su diversi
indirizzi IP e posizioni. L'API non implementa la protezione adeguata e consente
all'attaccante di acquistare la maggior parte delle scorte prima degli altri
utenti legittimi.

In seguito, l'attaccante rivende il prodotto su un'altra piattaforma a un
prezzo molto più alto.

### Scenario #2

Una compagnia aerea offre l'acquisto di biglietti online senza costi di
cancellazione. Un utente malintenzionato prenota il 90% dei posti di un volo
desiderato.

Pochi giorni prima del volo, l'utente malintenzionato cancella tutti i biglietti
contemporaneamente, costringendo la compagnia aerea a scontare i prezzi per
riempire il volo.

A questo punto, l'utente acquista un singolo biglietto a un prezzo molto più
basso rispetto all'originale.

### Scenario #3

Un'app di ride-sharing offre un programma di referral — gli utenti possono
invitare i propri amici e ottenere credito per ogni amico che si iscrive
all'app. Questo credito può essere successivamente utilizzato come denaro per
prenotare corse.

Un attaccante sfrutta questo flusso scrivendo uno script che automatizza il
processo di registrazione, con ogni nuovo utente che aggiunge credito al
portafoglio dell'attaccante.

L'attaccante può in seguito usufruire di corse gratuite o vendere gli account
con crediti eccessivi in cambio di denaro.

## Come Prevenire

La pianificazione delle misure di mitigazione deve essere effettuata su due
livelli:

* Business — identificare i flussi di business che potrebbero danneggiare
  l'azienda se utilizzati in modo eccessivo.
* Tecnico — scegliere i meccanismi di protezione adeguati per mitigare il
  rischio di business.

    Alcuni meccanismi di protezione sono più semplici da implementare, altri
    più complessi. I seguenti metodi vengono utilizzati per rallentare le
    minacce automatizzate:

    * Device fingerprinting: negare il servizio a dispositivi client inattesi
      (ad esempio browser headless) tende a spingere gli attaccanti a utilizzare
      soluzioni più sofisticate, quindi più costose per loro
    * Rilevamento umano: utilizzo di captcha o soluzioni biometriche più
      avanzate (ad esempio pattern di digitazione)
    * Pattern non umani: analizzare il flusso dell'utente per rilevare pattern
      non umani (ad esempio l'utente ha acceduto alle funzioni "aggiungi al
      carrello" e "completa acquisto" in meno di un secondo)
    * Considerare il blocco degli indirizzi IP dei nodi di uscita Tor e dei
      proxy più noti

    Proteggere e limitare l'accesso alle API consumate direttamente da macchine
    (come le API per sviluppatori e B2B). Tendono a essere un facile bersaglio
    per gli attaccanti perché spesso non implementano tutti i meccanismi di
    protezione necessari.

## Riferimenti

### OWASP

* [OWASP Automated Threats to Web Applications][1]
* [API10:2019 Insufficient Logging & Monitoring][2]

[1]: https://owasp.org/www-project-automated-threats-to-web-applications/
[2]: https://owasp.org/API-Security/editions/2019/en/0xaa-insufficient-logging-monitoring/