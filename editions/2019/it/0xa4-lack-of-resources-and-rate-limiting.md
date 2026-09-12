# API4:2019 Lack of Resources & Rate Limiting

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **2** | Diffusione **3** : Rilevabilità **3** | Tecnico **2** : Specifico per il Business |
| Lo sfruttamento richiede semplici richieste API. Non è richiesta autenticazione. Più richieste concorrenti possono essere effettuate da un singolo computer locale o utilizzando risorse di cloud computing. | È comune trovare API che non implementano il rate limiting o API in cui i limiti non sono impostati correttamente. | Lo sfruttamento può portare a DoS, rendendo l'API non reattiva o addirittura non disponibile. |

## L'API è Vulnerabile?

Le richieste API consumano risorse come rete, CPU, memoria e storage. La quantità
di risorse necessarie per soddisfare una richiesta dipende in larga misura
dall'input dell'utente e dalla logica di business dell'endpoint. È necessario
considerare anche il fatto che le richieste di più client API competono per le
risorse. Un'API è vulnerabile se almeno uno dei seguenti limiti è assente o
impostato in modo inappropriato (ad esempio troppo basso/alto):

* Timeout di esecuzione
* Memoria massima allocabile
* Numero di file descriptor
* Numero di processi
* Dimensione del payload della richiesta (ad esempio caricamenti)
* Numero di richieste per client/risorsa
* Numero di record per pagina da restituire in una singola risposta alla richiesta

## Scenari di Attacco di Esempio

### Scenario #1

Un attaccante carica un'immagine di grandi dimensioni inviando una richiesta POST
a `/api/v1/images`. Una volta completato il caricamento, l'API crea più
miniature di dimensioni diverse. A causa delle dimensioni dell'immagine caricata,
la memoria disponibile si esaurisce durante la creazione delle miniature e l'API
diventa non reattiva.

### Scenario #2

Un'applicazione contiene la lista degli utenti nell'interfaccia grafica con un
limite di `200` utenti per pagina. La lista degli utenti viene recuperata dal
server tramite la seguente query: `/api/users?page=1&size=200`. Un attaccante
modifica il parametro `size` impostandolo a `200 000`, causando problemi di
prestazioni nel database. Nel frattempo, l'API diventa non reattiva e non è in
grado di gestire ulteriori richieste da questo o da qualsiasi altro client
(alias DoS).

Lo stesso scenario potrebbe essere utilizzato per provocare errori di Integer
Overflow o Buffer Overflow.

## Come Prevenire

* Docker semplifica la limitazione di [memoria][1], [CPU][2],
  [numero di riavvii][3], [file descriptor e processi][4].
* Implementare un limite alla frequenza con cui un client può chiamare l'API
  in un determinato intervallo di tempo.
* Notificare al client quando il limite viene superato, fornendo il numero del
  limite e il momento in cui il limite verrà reimpostato.
* Aggiungere una corretta validazione lato server per i parametri della query
  string e del corpo della richiesta, in particolare quelli che controllano il
  numero di record da restituire nella risposta.
* Definire e applicare una dimensione massima dei dati su tutti i parametri e
  i payload in ingresso, come lunghezza massima delle stringhe e numero massimo
  di elementi negli array.

## Riferimenti

### OWASP

* [Blocking Brute Force Attacks][5]
* [Docker Cheat Sheet - Limit resources (memory, CPU, file descriptors,
  processes, restarts)][6]
* [REST Assessment Cheat Sheet][7]

### Esterni

* [CWE-307: Improper Restriction of Excessive Authentication Attempts][8]
* [CWE-770: Allocation of Resources Without Limits or Throttling][9]
* "_Rate Limiting (Throttling)_" - [Security Strategies for Microservices-based
  Application Systems][10], NIST

[1]: https://docs.docker.com/config/containers/resource_constraints/#memory
[2]: https://docs.docker.com/config/containers/resource_constraints/#cpu
[3]: https://docs.docker.com/engine/reference/commandline/run/#restart-policies---restart
[4]: https://docs.docker.com/engine/reference/commandline/run/#set-ulimits-in-container---ulimit
[5]: https://www.owasp.org/index.php/Blocking_Brute_Force_Attacks
[6]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/Docker_Security_Cheat_Sheet.md#rule-7---limit-resources-memory-cpu-file-descriptors-processes-restarts
[7]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/REST_Assessment_Cheat_Sheet.md
[8]: https://cwe.mitre.org/data/definitions/307.html
[9]: https://cwe.mitre.org/data/definitions/770.html
[10]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204-draft.pdf
