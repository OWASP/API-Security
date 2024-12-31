# API9:2019 Improper Assets Management

| Bedrohungsakteure/Angriffsvektoren | Sicherheitslücken | Auswirkungen |
| - | - | - |
| API-spezifisch : Ausnutzbarkeit **3** | Häufigkeit **3** : Erkennbarkeit **2** | Komplexität **2** : Unternehmensspezifisch |
| Alte API-Versionen sind in der Regel nicht gepatcht und bieten daher eine einfache Möglichkeit, Systeme zu kompromittieren, ohne sich mit modernsten Sicherheitsmechanismen auseinandersetzen zu müssen, die zum Schutz der neuesten API-Versionen implementiert wurden. | Veraltete Dokumentation erschwert die Suche nach Schwachstellen und die Behebung dieser. Das Fehlen einer Übersicht aller Systeme und einer Abschalt-Strategie führt zu ungepatchten Systemen, was zu einer Offenlegung sensibler Daten führen kann. Es ist häufig anzutreffen, dass API-Hosts unnötigerweise exponiert werden, da moderne Konzepte wie Microservices eine einfache Bereitstellung und Unabhängigkeit von Anwendungen ermöglichen (z. B. Cloud Computing, k8s). | Angreifer können über alte, ungepatchte API-Versionen, die mit derselben Datenbank verbunden sind, Zugriff auf sensible Daten erlangen oder sogar den Server übernehmen. |

## Ist die API angreifbar?

Die API könnte verwundbar sein, wenn:

* Der Zweck eines API-Hosts unklar ist und es keine klaren Antworten auf folgende Fragen gibt:
    * In welcher Umgebung wird die API ausgeführt (z. B. Produktion, Staging, Test, Entwicklung)?
    * Wer sollte Netzwerkzugriff auf die API haben (z. B. öffentlich, intern, Partner)?
    * Welche API-Version wird ausgeführt?
    * Welche Daten werden von der API erfasst und verarbeitet (z. B. PII)?
    * Wie verläuft der Datenfluss?
* Es gibt keine Dokumentation oder die vorhandene Dokumentation ist veraltet.
* Es gibt keinen Plan zur Ausmusterung jeder API-Version.
* Die Dienstübericht der Hosts fehlt oder ist veraltet.
* Die Übersicht der integrierten Dienste, sowohl von Erst- als auch von Drittanbietern, fehlt oder ist veraltet.
* Alte oder frühere API-Versionen werden ungepatcht ausgeführt.

## Beispiele für Angriffe

### Szenario #1

Nach der Neugestaltung ihrer Anwendungen ließ ein lokaler Suchdienst eine alte API-Version (`api.someservice.com/v1`) weiterlaufen, ohne Schutz und mit Zugriff auf die Benutzerdatenbank. Während eines Angriffs auf eine der neuesten veröffentlichten Anwendungen fand ein Angreifer die API-Adresse (`api.someservice.com/v2`). Durch das Ersetzen von `v2` in der URL durch `v1` erhielt der Angreifer Zugriff auf die alte, ungeschützte API und konnte personenbezogene Daten (PII) von über 100 Millionen Nutzern offenlegen.

### Szenario #2

Ein soziales Netzwerk hat einen Mechanismus zum Rate-Limiting eingeführt, der Angreifer daran hindert, mittels Brute-Force-Attacken zurückgesetzte Passwort-Token zu erraten. Dieser Mechanismus wurde nicht als Teil des API-Codes selbst implementiert, sondern in einer separaten Komponente zwischen dem Client und der offiziellen API (`www.socialnetwork.com`).
Ein Forscher fand einen Beta-API-Host (`www.mbasic.beta.socialnetwork.com`), der dieselbe API ausführte, einschließlich des Mechanismus zum Zurücksetzen des Passworts, aber der Mechanismus zum Rate-Limiting war nicht implementiert. Der Forscher konnte das Passwort jedes Benutzers zurücksetzen, indem er mittels einer einfachen Brute-Force-Methode den 6-stelligen Token erraten hat.

## Vorbeugende Maßnahmen

* Inventarisieren Sie alle API-Hosts und dokumentieren Sie wichtige Aspekte. Konzentrieren Sie sich dabei auf die API-Umgebung (z. B. Produktion, Staging, Test, Entwicklung), wer Netzwerkzugriff auf den Host haben sollte (z. B. öffentlich, intern, Partner) und die API-Version.
* Inventarisieren Sie integrierte Dienste und dokumentieren Sie wichtige Aspekte wie ihre Rolle im System, welche Daten ausgetauscht werden (Datenfluss) und ihre Sensibilität.
* Dokumentieren Sie alle Aspekte Ihrer API wie Authentifizierung, Fehler, Umleitungen, Ratenbegrenzung, Cross-Origin Resource Sharing (CORS)-Richtlinien und Endpunkte, einschließlich ihrer Parameter, Anfragen und Antworten.
* Generieren Sie die Dokumentation automatisch durch die Annahme von offenen Standards. Fügen Sie den Dokumentationsaufbau in Ihre CI/CD-Pipeline ein.
* Stellen Sie die API-Dokumentation nur denjenigen zur Verfügung, die berechtigt sind, die API zu nutzen.
* Verwenden Sie externe Schutzmaßnahmen wie API-Sicherheits-Firewalls für alle freigegebenen Versionen Ihrer APIs, nicht nur für die aktuelle Produktionsversion.
* Vermeiden Sie die Verwendung von Produktionsdaten bei nicht-produktionsbezogenen API-Bereitstellungen. Wenn dies unvermeidlich ist, sollten diese Endpunkte die gleiche Sicherheitsbehandlung wie die Produktionsendpunkte erhalten.
* Wenn neuere Versionen von APIs Sicherheitsverbesserungen enthalten, führen Sie eine Risikoanalyse durch, um die Entscheidung über die erforderlichen Maßnahmen zur Risikominderung für die ältere Version zu treffen: zum Beispiel, ob es möglich ist, die Verbesserungen rückwärtskompatibel zu machen, ohne die API-Kompatibilität zu beeinträchtigen, oder ob Sie schnell zur älteren Version wechseln und alle Clients zwingen müssen, zur neuesten Version zu wechseln.

## Referenzen

### Externe Quellen

* [CWE-1059: Incomplete Documentation][1]
* [OpenAPI Initiative][2]

[1]: https://cwe.mitre.org/data/definitions/1059.html
[2]: https://www.openapis.org/
