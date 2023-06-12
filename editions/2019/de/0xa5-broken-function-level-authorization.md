# API5:2019 Broken Function Level Authorization

| Bedrohungsakteure/Angriffsvektoren | Sicherheitslücken | Auswirkungen |
| - | - | - |
| API-spezifisch : Ausnutzbarkeit **3** | Häufigkeit **2** : Erkennbarkeit **1** | Komplexität **2** : Unternehmensspezifisch |
| Um eine Schwachstelle auszunutzen, muss der Angreifer legitime API-Aufrufe an einen Endpunkt senden, auf den er eigentlich keinen Zugriff haben sollte. Diese Endpunkte könnten für anonyme oder nicht privilegierte Benutzer zugänglich sein. Es ist einfacher, solche Schwachstellen in APIs zu entdecken, da sie besser strukturiert sind und der Weg, um auf bestimmte Funktionen zuzugreifen, vorhersehbarer ist (z. B. indem man die HTTP-Methode von GET auf PUT ändert oder den Teil `users` in der URL in `admins` ändert). | Berechtigungsprüfungen für eine Funktion oder Ressource werden in der Regel über die Konfiguration und manchmal auch auf Code-Ebene verwaltet. Die Implementierung geeigneter Prüfungen kann eine verwirrende Aufgabe sein, da moderne Anwendungen viele Arten von Rollen oder Gruppen und komplexe Benutzerhierarchien (z. B. Unterbenutzer, Benutzer mit mehr als einer Rolle) enthalten können. | Solche Schwachstellen ermöglichen es Angreifern, auf nicht autorisierte Funktionen zuzugreifen. Verwaltungsfunktionen sind wichtige Ziele für diese Art von Angriffen. |

## Ist die API angreifbar?

Die beste Möglichkeit, um Schwachstellen in der Funktionsautorisierung zu finden, besteht darin, eine tiefgreifende Analyse des Autorisierungsmechanismus durchzuführen, wobei die Benutzerhierarchie, verschiedene Rollen oder Gruppen in der Anwendung berücksichtigt werden und die folgenden Fragen gestellt werden:

* Kann ein normaler Benutzer auf administrative Endpunkte zugreifen?
* Kann ein Benutzer sensible Aktionen (z. B. Erstellung, Änderung oder Löschung) durchführen, auf die er keinen Zugriff haben sollte, indem er einfach die HTTP-Methode ändert (z. B. von `GET` auf `DELETE`)?
* Kann ein Benutzer aus Gruppe X auf eine Funktion zugreifen, die nur Benutzern aus Gruppe Y zugänglich sein sollte, indem er einfach die Endpunkt-URL und Parameter errät (z. B. `/api/v1/users/export_all`)?

Nehmen Sie nicht an, dass ein API-Endpunkt nur aufgrund des URL-Pfads ein regulärer oder administrativer Endpunkt ist.

Obwohl Entwickler dazu neigen, die meisten administrativen Endpunkte unter einem bestimmten relativen Pfad wie `api/admins` zu platzieren, ist es sehr häufig, dass diese administrativen Endpunkte zusammen mit regulären Endpunkten unter anderen relativen Pfaden wie `api/users` zu finden sind.

## Beispiele für Angriffe

### Szenario #1

Während des Registrierungsprozesses für eine Anwendung, die nur eingeladenen Nutzern die Teilnahme erlaubt beitreten können, löst die mobile Anwendung einen API-Aufruf aus an `GET /api/invites/{invite_guid}`.
Die Antwort enthält ein JSON mit Details über die Einladung, einschließlich der Rolle des Benutzers und seiner E-Mail.

Ein Angreifer duplizierte die Anfrage und manipulierte die HTTP-Methode und den Endpunkt zu `POST /api/invites/new`. Dieser Endpunkt sollte nur von Administratoren
Administratoren zugreifen, die die Verwaltungskonsole verwenden, die keine Funktions Berechtigungsprüfungen implementiert.

Der Angreifer nutzt das Problem aus und sendet sich selbst eine Einladung zur Erstellung eines
Administratorkonto zu erstellen:

```
POST /api/invites/new

{“email”:”hugo@malicious.com”,”role”:”admin”}
```

### Szenario #2

Eine API enthält einen Endpunkt, der nur für Administratoren zugänglich sein sollte - `GET /api/admin/v1/users/all`. Dieser Endpunkt liefert die Details aller Benutzer der Anwendung zurück und führt keine Berechtigungsprüfungen auf Funktionsebene durch. Ein Angreifer, der die Struktur der API kennt, errät den Zugriff auf diesen Endpunkt und erlangt dadurch Zugang zu sensiblen Details der Anwendungsnutzer.

## Vorbeugende Maßnahmen

Ihre Anwendung sollte ein konsistentes und leicht analysierbares Autorisierungsmodul haben, das von allen Geschäftsfunktionen aufgerufen wird. Häufig wird diese Sicherheit durch eine oder mehrere Komponenten außerhalb des Anwendungscodes bereitgestellt.

* Die Durchsetzungsmechanismen sollten standardmäßig jeden Zugriff verweigern und explizite Genehmigungen für bestimmte Rollen für den Zugriff auf jede Funktion erfordern.
* Überprüfen Sie Ihre API-Endpunkte auf Mängel bei der Autorisierung auf Funktionsebene und berücksichtigen Sie dabei die Geschäftslogik der Anwendung und die Hierarchie der Gruppen.
* Stellen Sie sicher, dass alle Ihre administrativen Controller von einem abstrakten administrativen Controller erben, der Berechtigungsprüfungen auf Grundlage der Gruppe/Rolle des Benutzers implementiert.
* Stellen Sie sicher, dass administrative Funktionen innerhalb eines regulären Controllers Berechtigungsprüfungen auf Grundlage der Gruppe und Rolle des Benutzers implementieren.

## References

### OWASP

* [OWASP Article on Forced Browsing][1]
* [OWASP Top 10 2013-A7-Missing Function Level Access Control][2]
* [OWASP Development Guide: Chapter on Authorization][3]

### Externe Quellen

* [CWE-285: Improper Authorization][4]

[1]: https://www.owasp.org/index.php/Forced_browsing
[2]: https://www.owasp.org/index.php/Top_10_2013-A7-Missing_Function_Level_Access_Control
[3]: https://www.owasp.org/index.php/Category:Access_Control
[4]: https://cwe.mitre.org/data/definitions/285.html
