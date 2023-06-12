# API1:2019 Broken Object Level Authorization

| Bedrohungsakteure/Angriffsvektoren | Sicherheitslücken | Auswirkungen |
| - | - | - |
| API-spezifisch : Ausnutzbarkeit **3** | Häufigkeit **3** : Erkennbarkeit **2** | Komplexität **3** : Unternehmensspezifisch |
| Angreifer können API-Endpunkte ausnutzen, die anfällig für eine fehlerhafte Autorisierung auf Objektebene sind, indem sie die ID eines Objekts manipulieren, die innerhalb des Requests gesendet wird. Dies kann zu einem unberechtigten Zugriff auf sensible Daten führen. Dieses Problem tritt bei API-basierten Anwendungen häufig auf, da die Serverkomponente in der Regel nicht den vollständigen Status des Clients verfolgt und stattdessen stärker auf Parameter wie Objekt-IDs angewiesen ist, die vom Client gesendet werden, um zu entscheiden, auf welche Objekte zugegriffen werden soll. | Dies ist der häufigste und folgenreichste Angriff auf APIs. Autorisierungs- und Zugriffskontrollmechanismen in modernen Anwendungen sind komplex und weit verbreitet. Selbst wenn die Anwendung eine angemessene Infrastruktur für Autorisierungsprüfungen implementiert, können Entwickler vergessen, diese Prüfungen vor dem Zugriff auf ein sensibles Objekt durchzuführen. Die Erkennung von Zugriffskontrollen ist in der Regel nicht durch automatisierte statische oder dynamische Tests möglich. | Unbefugter Zugriff kann zur Offenlegung von Daten an Unbefugte, zu Datenverlust oder Datenmanipulation führen. Unbefugter Zugriff auf Objekte kann auch zu einer vollständigen Übernahme des Kontos führen. |

## Ist die API angreifbar?

Die Autorisierung auf Objektebene ist ein Zugriffskontrollmechanismus, der in der Regel auf Codeebene implementiert wird, um sicherzustellen, dass ein Benutzer nur auf die Objekte zugreifen kann, auf die er Zugriff haben sollte.

Jeder API-Endpunkt, der die ID eines Objekts empfängt und irgendeine Art von Aktion mit dem Objekt ausführt, sollte Berechtigungsprüfungen auf Objektebene implementieren. Diese Prüfungen sollten validieren, dass der eingeloggte Benutzer die Berechtigung hat, die angeforderte Aktion an dem angeforderten Objekt durchzuführen.

Versagen dieses Mechanismus führt in der Regel zur unberechtigten Offenlegung, Änderung oder Zerstörung aller Daten.

## Beispiele für Angriffe

### Szenario #1

Ein E-Commerce-Plattform für Online-Shops bietet eine Auflistungsseite mit Umsatzdiagrammen für die von ihr gehosteten Shops. Durch Untersuchung der Browseranfragen kann ein Angreifer die API-Endpunkte identifizieren, die als Datenquelle für diese Diagramme dienen und deren Muster `/shops/{shopName}/revenue_data.json` ist. Über einen anderen API-Endpunkt kann der Angreifer eine Liste aller gehosteten Shopnamen abrufen. Mithilfe eines einfachen Skripts, das die Namen in der Liste manipuliert und `{shopName}` in der URL ersetzt, erhält der Angreifer Zugang zu den Verkaufsdaten von Tausenden von E-Commerce-Shops.

### Szenario #2

Beim Überwachen des Netzwerkverkehrs eines Wearable fällt einem Angreifer eine HTTP PATCH-Anfrage auf, die einen benutzerdefinierten HTTP-Anfrageheader mit dem Namen X-User-Id: 54796 enthält. Durch Ersetzen des X-User-Id-Werts durch 54795 erhält der Angreifer eine erfolgreiche HTTP-Antwort und kann die Kontodaten anderer Benutzer ändern.

## Vorbeugende Maßnahmen

* Implementierung eines angemessenen Autorisierungsmechanismus, der auf den Benutzerrichtlinien und der Benutzerhierarchie basiert.
* Verwenden Sie einen Autorisierungsmechanismus, um zu überprüfen, ob der eingeloggte Benutzer berechtigt ist, die angeforderte Aktion für den Datensatz in jeder Funktion auszuführen, die eine Eingabe vom Client verwendet, um auf einen Datensatz in der Datenbank zuzugreifen.
* Verwenden Sie zufällige und nicht vorhersehbare GUIDs als IDs für Datensätze, wo immer möglich.
* Schreiben Sie Tests, um den Autorisierungsmechanismus zu bewerten. Veröffentlichen Sie keine anfälligen Änderungen, die die Tests brechen.

## Referenzen

### OWASP

* [CWE-284: Improper Access Control][1]
* [CWE-285: Improper Authorization][2]
* [CWE-639: Authorization Bypass Through User-Controlled Key][3]

[1]: https://cwe.mitre.org/data/definitions/284.html
[2]: https://cwe.mitre.org/data/definitions/285.html
[3]: https://cwe.mitre.org/data/definitions/639.html
