# API8:2019 Injection

| Agenti di Minaccia/Vettori di Attacco | Debolezza di Sicurezza | Impatti |
| - | - | - |
| Specifico per API : Sfruttabilità **3** | Diffusione **2** : Rilevabilità **3** | Tecnico **3** : Specifico per il Business |
| Gli attaccanti alimentano l'API con dati malevoli attraverso qualsiasi vettore di injection disponibile (ad esempio input diretto, parametri, servizi integrati, ecc.), aspettandosi che vengano inviati a un interprete. | Le falle di injection sono molto comuni e si trovano spesso in query SQL, LDAP o NoSQL, comandi OS, parser XML e ORM. Queste falle sono facili da scoprire durante la revisione del codice sorgente. Gli attaccanti possono utilizzare scanner e fuzzer. | L'injection può portare a divulgazione di informazioni e perdita di dati. Può anche portare a DoS o alla compromissione totale dell'host. |

## L'API è Vulnerabile?

L'API è vulnerabile alle falle di injection se:

* I dati forniti dal client non vengono validati, filtrati o sanificati dall'API.
* I dati forniti dal client vengono direttamente utilizzati o concatenati in
  query SQL/NoSQL/LDAP, comandi OS, parser XML e Object Relational Mapping
  (ORM)/Object Document Mapper (ODM).
* I dati provenienti da sistemi esterni (ad esempio sistemi integrati) non
  vengono validati, filtrati o sanificati dall'API.

## Scenari di Attacco di Esempio

### Scenario #1

Il firmware di un dispositivo per il controllo parentale fornisce l'endpoint
`/api/CONFIG/restore` che si aspetta di ricevere un appId come parametro
multipart. Utilizzando un decompilatore, un attaccante scopre che l'appId viene
passato direttamente a una chiamata di sistema senza alcuna sanificazione:

```c
snprintf(cmd, 128, "%srestore_backup.sh /tmp/postfile.bin %s %d",
         "/mnt/shares/usr/bin/scripts/", appid, 66);
system(cmd);
```

Il seguente comando consente all'attaccante di spegnere qualsiasi dispositivo
con lo stesso firmware vulnerabile:

```
$ curl -k "https://${deviceIP}:4567/api/CONFIG/restore" -F 'appid=$(/etc/pod/power_down.sh)'
```

### Scenario #2

Un'applicazione con funzionalità CRUD di base per la gestione delle prenotazioni.
Un attaccante riesce a identificare che potrebbe essere possibile un'injection
NoSQL tramite il parametro `bookingId` nella query string della richiesta di
eliminazione di una prenotazione. La richiesta è la seguente:
`DELETE /api/bookings?bookingId=678`.

Il server API utilizza la seguente funzione per gestire le richieste di
eliminazione:

```javascript
router.delete('/bookings', async function (req, res, next) {
  try {
      const deletedBooking = await Bookings.findOneAndRemove({'_id' : req.query.bookingId});
      res.status(200);
  } catch (err) {
     res.status(400).json({error: 'Unexpected error occured while processing a request'});
  }
});
```

L'attaccante ha intercettato la richiesta e modificato il parametro `bookingId`
della query string come mostrato di seguito. In questo caso, l'attaccante è
riuscito a eliminare la prenotazione di un altro utente:

```
DELETE /api/bookings?bookingId[$ne]=678
```

## Come Prevenire

Prevenire l'injection richiede di mantenere i dati separati dai comandi e dalle
query.

* Eseguire la validazione dei dati utilizzando una singola libreria affidabile e
  attivamente mantenuta.
* Validare, filtrare e sanificare tutti i dati forniti dal client, o altri dati
  provenienti da sistemi integrati.
* I caratteri speciali devono essere sottoposti a escape utilizzando la sintassi
  specifica per l'interprete target.
* Preferire un'API sicura che fornisca un'interfaccia parametrizzata.
* Limitare sempre il numero di record restituiti per evitare divulgazioni massive
  in caso di injection.
* Validare i dati in ingresso usando filtri sufficienti per consentire solo valori
  validi per ogni parametro di input.
* Definire tipi di dati e pattern rigorosi per tutti i parametri stringa.

## Riferimenti

### OWASP

* [OWASP Injection Flaws][1]
* [SQL Injection][2]
* [NoSQL Injection Fun with Objects and Arrays][3]
* [Command Injection][4]

### Esterni

* [CWE-77: Command Injection][5]
* [CWE-89: SQL Injection][6]

[1]: https://www.owasp.org/index.php/Injection_Flaws
[2]: https://www.owasp.org/index.php/SQL_Injection
[3]: https://www.owasp.org/images/e/ed/GOD16-NOSQL.pdf
[4]: https://www.owasp.org/index.php/Command_Injection
[5]: https://cwe.mitre.org/data/definitions/77.html
[6]: https://cwe.mitre.org/data/definitions/89.html
