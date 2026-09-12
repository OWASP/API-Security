# API6:2019 - Mass Assignment

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **2** | Diffusione **2** : Rilevabilità **2** | Tecnico **2** : Specifico per il Business |
| Lo sfruttamento richiede solitamente la comprensione della logica di business, delle relazioni tra oggetti e della struttura dell'API. Il Mass Assignment è più facile da sfruttare nelle API, poiché per design espongono l'implementazione sottostante dell'applicazione insieme ai nomi delle proprietà. | I framework moderni incoraggiano gli sviluppatori a utilizzare funzioni che associano automaticamente l'input del client a variabili di codice e oggetti interni. Gli attaccanti possono utilizzare questa metodologia per aggiornare o sovrascrivere proprietà sensibili degli oggetti che gli sviluppatori non avevano mai inteso esporre. | Lo sfruttamento può portare a escalation di privilegi, manomissione dei dati, aggiramento di meccanismi di sicurezza e altro. |

## L'API è Vulnerabile?

Gli oggetti nelle applicazioni moderne possono contenere molte proprietà. Alcune
di queste proprietà dovrebbero essere aggiornate direttamente dal client (ad
esempio `user.first_name` o `user.address`) e alcune non dovrebbero (ad esempio
il flag `user.is_vip`).

Un endpoint API è vulnerabile se converte automaticamente i parametri del client
in proprietà degli oggetti interni, senza considerare la sensibilità e il livello
di esposizione di queste proprietà. Ciò potrebbe consentire a un attaccante di
aggiornare proprietà degli oggetti a cui non dovrebbe avere accesso.

Esempi di proprietà sensibili:

* **Proprietà legate ai permessi**: `user.is_admin`, `user.is_vip` dovrebbero
  essere impostati solo dagli amministratori.
* **Proprietà dipendenti dal processo**: `user.cash` dovrebbe essere impostato
  solo internamente dopo la verifica del pagamento.
* **Proprietà interne**: `article.created_time` dovrebbe essere impostato solo
  internamente dall'applicazione.

## Scenari di Attacco di Esempio

### Scenario #1

Un'applicazione di ride-sharing offre all'utente la possibilità di modificare
le informazioni di base del proprio profilo. Durante questo processo, una
chiamata API viene inviata a `PUT /api/v1/users/me` con il seguente oggetto JSON
legittimo:

```json
{"user_name":"inons","age":24}
```

La richiesta `GET /api/v1/users/me` include una proprietà aggiuntiva
credit_balance:

```json
{"user_name":"inons","age":24,"credit_balance":10}
```

L'attaccante ripete la prima richiesta con il seguente payload:

```json
{"user_name":"attacker","age":60,"credit_balance":99999}
```

Poiché l'endpoint è vulnerabile al Mass Assignment, l'attaccante riceve crediti
senza pagare.

### Scenario #2

Un portale di condivisione video consente agli utenti di caricare e scaricare
contenuti in diversi formati. Un attaccante che esplora l'API scopre che
l'endpoint `GET /api/v1/videos/{video_id}/meta_data` restituisce un oggetto JSON
con le proprietà del video. Una delle proprietà è
`"mp4_conversion_params":"-v codec h264"`, che indica che l'applicazione utilizza
un comando shell per convertire il video.

L'attaccante trova anche che l'endpoint `POST /api/v1/videos/new` è vulnerabile
al Mass Assignment e consente al client di impostare qualsiasi proprietà
dell'oggetto video. L'attaccante imposta un valore malevolo come segue:
`"mp4_conversion_params":"-v codec h264 && format C:/"`. Questo valore causerà
un'injection di comandi shell nel momento in cui l'attaccante scaricherà il
video in formato MP4.

## Come Prevenire

* Se possibile, evitare l'uso di funzioni che associano automaticamente l'input
  del client a variabili di codice o oggetti interni.
* Utilizzare una whitelist con solo le proprietà che devono essere aggiornate
  dal client.
* Utilizzare le funzionalità integrate per inserire in una blacklist le proprietà
  che non dovrebbero essere accessibili ai client.
* Se applicabile, definire e applicare esplicitamente degli schemi per i payload
  dei dati in input.

## Riferimenti

### Esterni

* [CWE-915: Improperly Controlled Modification of Dynamically-Determined Object Attributes][1]

[1]: https://cwe.mitre.org/data/definitions/915.html
