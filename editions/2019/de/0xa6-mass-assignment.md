# API6:2019 - Mass Assignment

| Bedrohungsakteure/Angriffsvektoren | Sicherheitslücken | Auswirkungen |
| - | - | - |
| API-spezifisch : Ausnutzbarkeit **2** | Häufigkeit **2** : Erkennbarkeit **2** | Komplexität **2** : Unternehmensspezifisch |
| Die Ausnutzung erfordert in der Regel ein Verständnis der Geschäftslogik, der Beziehungen zwischen den Objekten und der API-Struktur. Die Ausnutzung von "Mass Asignment" ist in APIs einfacher, da sie aufgrund ihrer Konzeption die zugrundeliegende Implementierung der Anwendung zusammen mit den Namen der Eigenschaften offenlegen. | Moderne Frameworks ermutigen Entwickler zur Verwendung von Funktionen, die automatisch Eingaben vom Client in Codevariablen und interne Objekte binden. Angreifer können diese Methode nutzen, um die Eigenschaften sensibler Objekte zu aktualisieren oder zu überschreiben, die die Entwickler nie offenlegen wollten. | Die Ausnutzung kann zu einer Ausweitung von Privilegien, Datenmanipulation, Umgehung von Sicherheitsmechanismen und vielem mehr führen. |

## Ist die API angreifbar?

Moderne Anwendungen können viele Objekteigenschaften enthalten. Einige dieser Eigenschaften sollten direkt vom Client aktualisiert werden (z. B. `user.first_name` oder `user.address`), während andere nicht aktualisiert werden sollten (z. B. `user.is_vip-Flag`).

Ein API-Endpunkt ist anfällig, wenn er automatisch Client-Parameter in interne Objekteigenschaften konvertiert, ohne dabei die Sensibilität und das Gefährdungspotential dieser Eigenschaften zu berücksichtigen. Dies könnte einem Angreifer ermöglichen, Objekteigenschaften zu aktualisieren, auf die er keinen Zugriff haben sollte.

Beispiele für sensible Eigenschaften:

* **Permission-related properties**: `user.is_admin`, `user.is_vip` sollte nur nur von Administratoren gesetzt werden.
* **Process-dependent properties**: `user.cash` sollte nur intern gesetzt werden nach der Zahlungsüberprüfung gesetzt werden.
* **Internal properties**: `article.created_time` sollte nur intern gesetzt werden durch die Anwendung gesetzt werden.

## Beispiele für Angriffe

### Szenario #1

Eine Anwendung für Mitfahrgelegenheiten bietet einem Nutzer die Möglichkeit, grundlegende Informationen für sein Profil zu bearbeiten. Während dieses Prozesses wird ein API-Aufruf gesendet an
`PUT /api/v1/users/me` mit dem folgenden legitimen JSON-Objekt:

```json
{"user_name":"inons","age":24}
```

Die Anfrage `GET /api/v1/users/me` enthält eine zusätzlich ein `credit_balance` Attribut:

```json
{"user_name":"inons","age":24,"credit_balance":10}
```

Der Angreifer wiederholt die erste Anfrage mit der folgendem Payload:

```json
{"user_name":"attacker","age":60,"credit_balance":99999}
```

Da der Endpunkt anfällig für "MAss Assignment" ist, erhält der Angreifer Credits, ohne zu bezahlen.

### Szenario #2

Ein Portal zur gemeinsamen Nutzung von Videos ermöglicht es Nutzern, Inhalte hochzuladen und in verschiedenen Formaten herunterzuladen. Ein Angreifer, der die API erforscht, fand heraus, dass der Endpunkt `GET /api/v1/videos/{video_id}/meta_data` ein JSON-Objekt mit den Eigenschaften des Videos zurückgibt. Eine der Eigenschaften ist `"mp4_conversion_params":"-v codec h264"`, was darauf hinweist, dass die Anwendung einen Shell-Befehl zur Konvertierung des Videos verwendet.

Der Angreifer fand auch heraus, dass der Endpunkt `POST /api/v1/videos/new` für "Mass Asignment" anfällig ist und es dem Client ermöglicht, eine beliebige Eigenschaft des Videoobjekts festzulegen. Der Angreifer setzt einen bösartigen Wert wie folgt: `"mp4_conversion_params":"-v codec h264 && format C:/"`. Dieser Wert verursacht eine "Remote Code Execution", sobald der Angreifer das Video als MP4 herunterlädt.

## Vorbeugende Maßnahmen

* Vermeiden Sie nach Möglichkeit die Verwendung von Funktionen, die automatisch die Eingaben eines Benutzers in Variablen oder interne Objekte speicher, ohne diese zu validieren.
* Setzen Sie nur die Eigenschaften auf die Whitelist, die vom Client aktualisiert werden sollen.
* Verwenden Sie integrierte Funktionen, um Eigenschaften, auf die der Client nicht zugreifen darf, zu blockieren.
* Definieren und Erzwingen Sie gegebenenfalls explizit Schemata für die Eingabedaten.

## Referenzen

### Externe Quellen

* [CWE-915: Improperly Controlled Modification of Dynamically-Determined Object Attributes][1]

[1]: https://cwe.mitre.org/data/definitions/915.html
