# API4:2019 Lack of Resources & Rate Limiting

| Bedrohungsakteure/Angriffsvektoren | Sicherheitslücken | Auswirkungen |
| - | - | - |
| API-spezifisch : Ausnutzbarkeit **2** | Häufigkeit **3** : Erkennbarkeit **3** | Komplexität **2** : Unternehmensspezifisch |
| Die Ausnutzung erfordert einfache API-Anfragen. Es ist keine Authentifizierung erforderlich. Mehrere gleichzeitige Anfragen können von einem einzigen lokalen Computer aus oder unter Verwendung von Cloud-Computing-Ressourcen durchgeführt werden. | Es ist üblich, APIs zu finden, die keine Rate-Limitierung implementieren oder APIs, bei denen die Limits nicht ordnungsgemäß gesetzt sind. | Eine Ausnutzung kann zu DoS führen, wodurch die API nicht mehr reagiert oder sogar nicht mehr verfügbar ist. |

## Ist die API angreifbar?

API-Anforderungen verbrauchen Ressourcen wie Netzwerk, CPU, Arbeitsspeicher und Speicherplatz. Die
Menge an Ressourcen, die zur Beantwortung einer Anfrage benötigt wird, hängt stark von der
Eingabe und der Geschäftslogik des Endpunkts ab. Berücksichtigen Sie auch die Tatsache, dass Anfragen von
mehreren API-Clients um die Ressourcen konkurrieren. Eine API ist verwundbar, wenn mindestens eine
der folgenden Grenzwerte fehlt oder unangemessen eingestellt ist (z. B. zu niedrig/hoch):

* Ausführungszeitüberschreitungen
* Maximal zuweisbarer Speicher
* Anzahl der Dateideskriptoren
* Anzahl der Prozesse
* Größe der Nutzlast von Anfragen (z. B. Uploads)
* Anzahl der Anfragen pro Client/Ressource
* Anzahl der Datensätze pro Seite, die in einer einzigen Anfrageantwort zurückgegeben werden sollen

## Beispiele für Angriffe

### Szenario #1

Ein Angreifer lädt ein großes Bild hoch, indem er eine POST-Anfrage an `/api/v1/images` stellt.
Wenn der Upload abgeschlossen ist, erstellt die API mehrere Miniaturbilder mit unterschiedlichen
Größen. Aufgrund der Größe des hochgeladenen Bildes ist der verfügbare Speicher
während der Erstellung der Miniaturansichten erschöpft und die API reagiert nicht mehr.

### Szenario #2

Gegeben ist eine Anwendung, die die Benutzerliste auf einer Benutzeroberfläche mit einer Begrenzung von
200 Benutzer pro Seite anzeigt. Die Benutzerliste wird mit folgender Abfrage vom Server abgerufen: `/api/users?page=1&size=200`. Ein Angreifer ändert den Parameter `size`
Parameter auf `200.000`, was zu Leistungsproblemen in der Datenbank führt. In der Zwischenzeit
reagiert die API nicht mehr und ist nicht mehr in der Lage, weitere Anfragen von diesem
oder anderen Clients zu beantworten (DoS).

Das gleiche Szenario kann verwendet werden, wenn ein Integer oder Buffer Overflow auftritt.

## Vorbeugende Maßnahmen

* Docker macht es einfach [Speicher][1], [CPU][2], [Anzahl der Neustarts][3],
  [Dateideskriptoren und Prozesse][4] zu beschränken.
* Implementieren Sie ein Limit, wie oft ein Client die API innerhalb eines bestimmten
  Zeitrahmen abrufen kann.
* Benachrichtigen Sie den Client, wenn das Limit überschritten wird, indem Sie die Limitnummer und
  den Zeitpunkt, zu dem das Limit zurückgesetzt wird bekanntgeben.
* Hinzufügen einer ordnungsgemäßen serverseitigen Validierung für Query String und Request Body
  Parameter, insbesondere denjenigen, die die Anzahl der in der Antwort zurückzugebenden
  Werte betimmen.
* Definieren und erzwingen Sie die maximale Größe von Daten für alle eingehenden Parameter und
  und Nutzdaten, wie z. B. die maximale Länge für Strings und die maximale Anzahl von Elementen in
  Arrays.


## Referenzen

### OWASP

* [Blocking Brute Force Attacks][5]
* [Docker Cheat Sheet - Limit resources (memory, CPU, file descriptors,
  processes, restarts)][6]
* [REST Assessment Cheat Sheet][7]

### Externe Quellen

* [CWE-307: Improper Restriction of Excessive Authentication Attempts][8]
* [CWE-770: Allocation of Resources Without Limits or Throttling][9]
* “_Rate Limiting (Throttling)_” - [Security Strategies for Microservices-based
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
