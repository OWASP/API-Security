# API3:2019 Excessive Data Exposure

| Bedrohungsakteure/Angriffsvektoren | Sicherheitslücken | Auswirkungen |
| - | - | - |
| API-spezifisch : Ausnutzbarkeit **3** | Häufigkeit **2** : Erkennbarkeit **2** | Komplexität **2** : Unternehmensspezifisch |
| Die Ausnutzung von übermäßiger Datenfreigabe ist einfach und erfolgt in der Regel durch Sniffing des Datenverkehrs, um die API-Antworten zu analysieren und nach sensiblen Daten zu suchen, die nicht an den Benutzer zurückgegeben werden sollten. |APIs verlassen sich darauf, dass Clients die Datenfilterung durchführen. Da APIs als Datenquellen verwendet werden, versuchen Entwickler manchmal, sie auf generische Weise zu implementieren, ohne an die Sensibilität der offengelegten Daten zu denken. Automatische Tools können diese Art von Schwachstellen in der Regel nicht erkennen, da es schwierig ist, zwischen legitimen Daten, die von der API zurückgegeben werden, und sensiblen Daten, die ohne tiefes Verständnis der Anwendung nicht zurückgegeben werden sollten, zu unterscheiden. | Eine übermäßige Datenexposition führt in der Regel zur Offenlegung sensibler Daten. |

## Ist die API angreifbar?

Die API gibt sensible Daten absichtlich an den Client zurück. Diese Daten werden normalerweise auf der Client-Seite gefiltert, bevor sie dem Benutzer präsentiert werden. Ein Angreifer kann den Datenverkehr leicht ausspähen und die sensiblen Daten sehen.

## Beispiele für Angriffe

### Szenario #1

Das Mobile-Team verwendet den Endpunkt `/api/articles/{articleId}/comments/{commentId}`
in der Artikelansicht, um Metadaten zu Kommentaren zu rendern. Durch das Sniffing des Datenverkehrs der mobilen Anwendung findet ein Angreifer heraus, dass auch andere sensible Daten, die sich auf den Autor des Kommentars beziehen, zurückgegeben werden. Die Implementierung des Endpunkts verwendet eine generische `toJSON()`-Methode des User-Modells, das PII enthält, um das Objekt zu serialisieren.

### Szenario #2

Ein IoT-basiertes Überwachungssystem ermöglicht es Administratoren, Benutzer mit unterschiedlichen Berechtigungen zu erstellen. Ein Administrator erstellt ein Benutzerkonto für einen neuen Sicherheitsmitarbeiter, der nur Zugang zu bestimmten Gebäuden auf dem Gelände haben sollte. Sobald der Sicherheitsmitarbeiter seine mobile App verwendet, wird ein API-Aufruf ausgelöst: /api/sites/111/cameras, um Daten über die verfügbaren Kameras zu erhalten und sie auf dem Dashboard anzuzeigen. Die Antwort enthält eine Liste mit Details über Kameras im folgenden Format: `{"id": "xxx", "live_access_token": "xxxx-bbbbb", "building_id": "yyy"}`. Während die Client-GUI nur Kameras anzeigt, auf die der Sicherheitsmitarbeiter Zugriff haben soll, enthält die tatsächliche API-Antwort eine vollständige Liste aller Kameras auf dem Gelände.

## Vorbeugende Maßnahmen

* Verlassen Sie sich niemals auf die Client-Seite, um sensible Daten zu filtern.
* Überprüfen Sie die Antworten der API, um sicherzustellen, dass sie nur legitime Daten enthalten.
* Backend-Entwickler sollten sich immer fragen "Wer ist der Nutzer der Daten?", bevor sie einen neuen API-Endpunkt freigeben.
* Vermeiden Sie die Verwendung generischer Methoden wie `to_json()` und `to_string()`.
  Wählen Sie stattdessen spezifische Eigenschaften aus, die Sie wirklich zurückgeben möchten.
* Klassifizieren Sie sensible und persönlich identifizierbare Informationen (PII), die Ihre Anwendung speichert und verarbeitet. Überprüfen Sie alle API-Aufrufe, die solche Informationen zurückgeben, um zu sehen, ob diese Antworten ein Sicherheitsproblem darstellen.
* Implementieren Sie einen schema-basierten Response-Validierungsmechanismus als zusätzliche Sicherheitsebene. Im Rahmen dieses Mechanismus definieren und erzwingen Sie die Daten, die von allen API-Methoden zurückgegeben werden, einschließlich Fehler.


## Referenzen

### OWASP

* [CWE-213: Intentional Information Exposure][1]

[1]: https://cwe.mitre.org/data/definitions/213.html
