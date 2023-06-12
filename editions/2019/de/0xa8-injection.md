# API8:2019 Injection

| Bedrohungsakteure/Angriffsvektoren | Sicherheitslücken | Auswirkungen |
| - | - | - |
| API-spezifisch : Ausnutzbarkeit **3** | Häufigkeit **2** : Erkennbarkeit **3** | Komplexität **3** : Unternehmensspezifisch |
| Angreifer füttern die API mit bösartigen Daten über alle verfügbaren Injektionsvektoren (z. B. direkte Eingabe, Parameter, integrierte Dienste usw.) und erwarten, dass diese an einen Interpreter gesendet werden. | Injection-Fehler sind sehr häufig und werden oft in SQL-, LDAP- oder NoSQL-Abfragen, Betriebssystembefehlen, XML-Parsern und ORM gefunden. Diese Schwachstellen sind bei der Überprüfung des Quellcodes leicht zu entdecken. Angreifer können Scanner und Fuzzer verwenden. | Ein "Injection"-Angriff kann zur Offenlegung von Informationen und zum Datenverlust führen. Es kann auch zu DoS oder einer vollständigen Übernahme des Hosts kommen. |

## Ist die API angreifbar?

Die API ist anfällig für Injection-Angriffe, wenn:

* Die von den Clients gelieferten Daten nicht von der API validiert, gefiltert oder bereinigt werden.
* Die von den Clients gelieferten Daten direkt für SQL/NoSQL/LDAP-Abfragen, OS-Befehle, XML-Parser und Object Relational (ORM) / Object Document Mapping (ODM) verwendet oder konkateniert werden.
* Daten von externen Systemen (z.B. integrierten Systemen) nicht von der API validiert, gefiltert oder bereinigt werden.

## Beispiele für Angriffe

### Szenario #1

Die Firmware einer Kindersicherungseinrichtung stellt den Endpunkt
`/api/CONFIG/restore` zur Verfügung, der die Übermittlung einer appId als Multipart
Parameter erwartet. Mit Hilfe eines Decompilers findet ein Angreifer heraus, dass die appId
direkt in einen Systemaufruf ohne jegliche Validierung übergeben wird:

```c
snprintf(cmd, 128, "%srestore_backup.sh /tmp/postfile.bin %s %d",
         "/mnt/shares/usr/bin/scripts/", appid, 66);
system(cmd);
```

Mit dem folgenden Befehl kann der Angreifer jedes Gerät mit der gleichen
verwundbaren Firmware ausschalten:

```
$ curl -k "https://${deviceIP}:4567/api/CONFIG/restore" -F 'appid=$(/etc/pod/power_down.sh)'
```

### Szenario #2

Wir haben eine Anwendung mit grundlegenden CRUD-Funktionen für Operationen mit
Buchungen. Ein Angreifer konnte herausfinden, dass eine NoSQL-Injection möglich ist, welche
durch den Query-String-Parameter `bookingId` in der Anfrage zum Löschen von Buchungen besteht. Die Anfrage sieht folgendermaßen aus: `DELETE /api/bookings?bookingId=678`.

Der API-Server verwendet die folgende Funktion zur Bearbeitung von Löschanfragen:

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

Der Angreifer hat die Anfrage abgefangen und den Abfrageparameter `bookingId` wie unten gezeigt geändert. In diesem Fall gelang es dem Angreifer, die Buchung eines anderen Benutzers zu löschen:

```
DELETE /api/bookings?bookingId[$ne]=678
```

## Vorbeugende Maßnahmen

Um Injection-Angriffe zu verhindern müssen Daten von Befehlen und Abfragen getrennt werden.

* Führen Sie eine Datenvalidierung mit einer einzigen, vertrauenswürdigen und aktiv gepflegten
Bibliothek durch.
* Validieren, filtern und bereinigen Sie alle vom Client bereitgestellten Daten oder andere Daten, die
von integrierten Systemen kommen.
* Sonderzeichen sollten unter Verwendung der spezifischen Syntax für den Zielinterpreter
escaped werden.
* Bevorzugen Sie eine sichere API, die eine parameterisierte Schnittstelle bereitstellt.
* Begrenzen Sie immer die Anzahl der zurückgegebenen Datensätze, um einen Datenverlust im Falle von erfolgreichen Injection-Angriffen zu verhindern.
* Validieren Sie eingehende Daten mithilfe ausreichender Filter, um nur gültige Werte für jeden Eingabeparameter zuzulassen.
* Definieren Sie Datentypen und strenge Muster für alle String-Parameter.

## Referenzen

### OWASP

* [OWASP Injection Flaws][1]
* [SQL Injection][2]
* [NoSQL Injection Fun with Objects and Arrays][3]
* [Command Injection][4]

### Externe Quellen

* [CWE-77: Command Injection][5]
* [CWE-89: SQL Injection][6]

[1]: https://www.owasp.org/index.php/Injection_Flaws
[2]: https://www.owasp.org/index.php/SQL_Injection
[3]: https://www.owasp.org/images/e/ed/GOD16-NOSQL.pdf
[4]: https://www.owasp.org/index.php/Command_Injection
[5]: https://cwe.mitre.org/data/definitions/77.html
[6]: https://cwe.mitre.org/data/definitions/89.html
