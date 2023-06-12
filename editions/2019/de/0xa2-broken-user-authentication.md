# API2:2019 Broken User Authentication

| Bedrohungsakteure/Angriffsvektoren | Sicherheitslücken | Auswirkungen |
| - | - | - |
| API-spezifisch : Ausnutzbarkeit **3** | Häufigkeit **2** : Erkennbarkeit **2** | Komplexität **3** : Unternehmensspezifisch |
| Die Authentifizierung in APIs ist ein komplexer und unübersichtlicher Prozess. Softwareentwickler haben möglicherweise falsche Vorstellungen darüber, wo die Einschränkungen der Authentifizierung liegen und wie man sie richtig implementiert. Darüber hinaus ist der Authentifizierungsmechanismus ein leichtes Ziel für Angreifer, da er für jeden zugänglich ist. Diese beiden Punkte machen die Authentifizierungskomponente anfällig für zahlreiche Angriffe. | Es gibt zwei Unterpunkte: 1. Fehlende Schutzmechanismen: API-Endpunkte, die für die Authentifizierung zuständig sind, müssen anders behandelt werden als normale Endpunkte und zusätzliche Schutzmechanismen implementieren. 2. Falsche Implementierung des Verfahrens: Der Prozess der Authentifizierung wird verwendet/implementiert, ohne die Angriffsvektoren zu berücksichtigen, oder es ist der falsche Anwendungsfall (z. B. ist ein Authentifizierungsmechanismus, der für IoT-Clients entwickelt wurde, möglicherweise nicht die richtige Wahl für Webanwendungen) implementiert worden. | Angreifer können die Kontrolle über die Konten anderer Benutzer im System übernehmen, ihre persönlichen Daten auslesen und sensiblen Aktionen in deren Namen ausführen, wie Geld transferieren oder persönlichen Nachrichten versenden.

## Ist die API angreifbar?

Endpunkte für die Authentifizierungs sind sensible Funktionen, die geschützt werden müssen. "Passwort
vergessen / zurücksetzen" sollte genauso behandelt werden wie Authentifizierungsmechanismen.

Eine API ist verwundbar, wenn sie folgendes zulässt:
* Wenn diese [credential stuffing][1] zulässt. Hierbei versucht sich in Angreifer mit einer
  Liste geklauter Zugangsdaten einzuloggen.
* Wenn diese es Angreifern erlaubt, einen Brute-Force-Angriff auf dasselbe Benutzerkonto durchzuführen,
  ohne ein Captcha-Mechanismus oder eine Sperrfunktion für das Konto implementieren.
* Wenn die API unsichere Passwörter erlaubt.
* Sensible Anmeldeinformationen, wie Auth-Tokens und Passwörter, in der URL sendet.
* Die Authentizität von Tokens nicht validiert.
* Unsignierte/schwach signierte JWT-Tokens ("alg":"none") akzeptiert oder deren Ablaufdatum nicht validiert.
* Passwörter im Klartext speichert oder schwache Hash-Funktion für Passwörter benutzt.
* Schwache Verschlüsselungsschlüssel verwendet.

## Beispiele für Angriffe

### Szenario #1

[Credential stuffing][1] (durch Verwendung von [Listen mit bekannten Benutzernamen/Passwörtern][2])
ist ein häufiger Angriff. Wenn eine Anwendung keine automatischen Schutzmaßnahmen gegen Bedrohungen
oder Credential Stuffing implementiert, kann die Anwendung als Passwort-Oracle (Tester) verwendet werden,
um zu bestimmen, ob die Anmeldeinformationen gültig sind.

### Szenario #2

Ein Angreifer startet den Passwort-Wiederherstellungs-Prozess, indem er eine POST-Anfrage an
`/api/system/verification-codes` sendet und den Benutzernamen im Anfrage-Body bereitstellt.
Als nächstes wird ein SMS-Token mit 6 Ziffern an das Telefon des Opfers gesendet. Da die API keine Policy
zur Begrenzung der Abfragerate implementiert, kann der Angreifer alle möglichen Kombinationen mit
einem mehrthreadigen Skript gegen das Endpunkt `/api/system/verification-codes/{smsToken}` testen, um
innerhalb weniger Minuten das richtige Token zu entdecken.

## Vorbeugende Maßnahmen

* Es sollte sichergestellt werden, dass alle Methoden zur Authentifizierung einer API bekannt sind (Mobile/Web/Deep Links, die eine Ein-Klick-Authentifizierung).
* Es sollte mit den Software-Entwicklern abgestimmt werden ob es noch weitere Methoden zur Authentifizierung gibt.
* Informieren Sie sich die genutzen Authentifizierungsmechanismen. Stellen Sie sicher, dass Sie verstehen, was und
  wie diese verwendet werden. OAuth ist keine Authentifizierung und API-Schlüssel auch nicht.
* Erfinde Sie das Rad nicht neu in Bezug auf Authentifizierung, Token-Generierung und Passwort-Speicherung. Verwenden Sie
  die anerkannten Standards.
* Endpunkte für Passwort-Vergeßen Funktion sollten in Bezug auf Brute-Force Angriffe, Begrenzung der Abfragerate und Sperrmechanismen wie Login-Endpunkte behandelt werden.
* Benutzen Sie das [OWASP Authentication Cheatsheet][3].
* Implementieren Sie Multi-Faktor-Authentifizierung, sofern dies möglich ist.
* Implementieren SIe Anti-Brute-Force-Mechanismen, um Credential Stuffing, Dictionary-Attacken und Brute-Force-Angriffe auf die Authentifizierungs-Endpunkte zu erschweren. Dieser Mechanismus sollte restriktiver sein als die reguläre Begrenzung der Abfragerate der API.
* Implementieren Sie [Accountsperren][4] oder Captchas um Brute-Force-Angriffe auf bestimmte Benutzer zu verhindern.
  Prüfen sie alle Passwörter auf schwache Passwörter.
* API-Schlüssel sollten nicht für die Benutzerauthentifizierung verwendet werden, sondern für [client app/
  project authentication][5].

## Referenzen

### OWASP

* [OWASP Key Management Cheat Sheet][6]
* [OWASP Authentication Cheatsheet][3]
* [Credential Stuffing][1]

### Externe Quellen

* [CWE-798: Use of Hard-coded Credentials][7]

[1]: https://www.owasp.org/index.php/Credential_stuffing
[2]: https://github.com/danielmiessler/SecLists
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[4]: https://www.owasp.org/index.php/Testing_for_Weak_lock_out_mechanism_(OTG-AUTHN-003)
[5]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[6]: https://www.owasp.org/index.php/Key_Management_Cheat_Sheet
[7]: https://cwe.mitre.org/data/definitions/798.html
