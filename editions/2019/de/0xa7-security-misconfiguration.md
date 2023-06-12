# API7:2019 Security Misconfiguration

| Bedrohungsakteure/Angriffsvektoren | Sicherheitslücken | Auswirkungen |
| - | - | - |
| API-spezifisch : Ausnutzbarkeit **3** | Häufigkeit **3** : Erkennbarkeit **3** | Komplexität **2** : Unternehmensspezifisch |
| Angreifer versuchen oft, ungepatchte Schwachstellen, gemeinsame Endpunkte oder ungeschützte Dateien und Verzeichnisse zu finden, um sich unbefugten Zugriff auf das System zu verschaffen oder Kenntnisse über das System zu erlangen. | Eine Sicherheitskonfiguration kann auf jeder Ebene des API-Stacks unsicher sein, von der Netzwerkebene bis zur Anwendungsebene. Es gibt automatisierte Tools, die dazu dienen, Fehlkonfigurationen wie unnötige Dienste oder veraltete Optionen zu erkennen und auszunutzen. | Unsichere Sicherheitskonfigurationen können nicht nur sensible Benutzerdaten, sondern auch Systemdetails preisgeben, die zu einer vollständigen Kompromittierung des Servers führen können. |

## Ist die API angreifbar?

Die API könnte anfällig sein, wenn:

* Es fehlt eine angemessene Sicherheitshärtung, sei es auf einer beliebigen Ebene des Anwendungs-Stacks oder wenn die Berechtigungen für Cloud-Services falsch konfiguriert sind.
* Die neuesten Sicherheitspatches fehlen oder das System veraltet ist.
* Unnötige Funktionen aktiviert sind (z. B. HTTP-Methoden).
* Keine Transport Layer Security (TLS) eingesetzt wird.
* Sicherheitsrichtlinien werden den Clients nicht übermittelt (z. B. [Security Headers][1]).
* Eine Cross-Origin Resource Sharing (CORS)-Richtlinie fehlt oder falsch konfiguriert ist.
* Fehlermeldungen, Stack-Traces enthalten oder andere sensible Informationen offengelegt werden.

## Beispiele für Angriffe

### Szenario #1

Ein Angreifer findet die Datei `.bash_history` unter dem Stammverzeichnis des Servers, die Befehle enthält, die vom DevOps-Team für den Zugriff auf die API verwendet werden:

```
$ curl -X GET 'https://api.server/endpoint/' -H 'authorization: Basic Zm9vOmJhcg=='
```
Ein Angreifer könnte auch neue Endpunkte für die API identifizieren, die nur vom
DevOps-Team verwendet werden und nicht dokumentiert sind.

### Szenario #2

Um einen bestimmten Dienst ins Visier zu nehmen, verwendet ein Angreifer eine beliebte Suchmaschine, um nach Computern zu suchen. Der Angreifer fand einen Host, auf dem ein beliebtes Datenbankmanagementsystem auf dem Standardport läuft. Der Host verwendete die Standardkonfiguration, bei der die Authentifizierung standardmäßig deaktiviert ist. Der Angreifer erlangte Zugriff auf Millionen von Datensätzen mit personenbezogenen Daten, persönlichen Präferenzen und Authentifizierungsdaten.

### Szenario #3

Bei der Untersuchung des Datenverkehrs einer mobilen Anwendung stellt ein Angreifer fest, dass nicht der gesamte HTTP-Verkehr über ein sicheres Protokoll (z. B. TLS) abgewickelt wird. Der Angreifer findet dies insbesondere für den Download von Profilbildern herraus. Da die Daten binär kodiert sind, findet der Angreifer, ein Muster in der Größe der API-Antworten, das er nutzt, um die Präferenzen der Benutzer bezüglich des dargestellten Inhalts (z. B. Profilbilder) auszulesen.

## Vorbeugende Maßnahmen

Der API-Lebenszyklus sollte Folgendes umfassen:

* Ein wiederholbarer Härtungsprozess, der zu einer schnellen und einfachen Bereitstellung einer ordnungsgemäß gehärteten Umgebung führt.
* Die Überprüfung und Aktualisierung von Konfigurationen für den gesamten API-Stack. Die Überprüfung sollte Folgendes umfassen: Orchestrierungsdateien, API-Komponenten und Cloud-Dienste (z. B. S3-Bucket-Berechtigungen).
* Ein sicherer Kommunikationskanal für alle API-Interaktionen, einschließlich des Zugriffs auf statische Assets (z. B. Bilder).
* Ein automatisierter Prozess zur kontinuierlichen Bewertung der Effektivität der Konfiguration und Einstellungen in allen Umgebungen.

Darüber hinaus:

* Um zu verhindern, dass Exception-Traces und andere wertvolle Informationen an Angreifer zurückgesendet werden, sollten, falls zutreffend, alle API-Antwort-Schemata definiert und erzwungen werden, einschließlich Fehlermeldungen.
* Stellen Sie sicher, dass auf die API nur mit den angegebenen HTTP-Verben zugegriffen werden kann. Alle anderen HTTP-Verben sollten deaktiviert werden (z. B. `HEAD`).
* APIs, auf die von browserbasierten Clients zugegriffen werden soll (z. B. WebApp Front-End), sollten eine angemessene Cross-Origin Resource Sharing (CORS)-Richtlinie implementieren.

## Referenzen

### OWASP

* [OWASP Secure Headers Project][1]
* [OWASP Testing Guide: Configuration Management][2]
* [OWASP Testing Guide: Testing for Error Codes][3]
* [OWASP Testing Guide: Test Cross Origin Resource Sharing][9]

### Externe Quellen

* [CWE-2: Environmental Security Flaws][4]
* [CWE-16: Configuration][5]
* [CWE-388: Error Handling][6]
* [Guide to General Server Security][7], NIST
* [Let’s Encrypt: a free, automated, and open Certificate Authority][8]

[1]: https://www.owasp.org/index.php/OWASP_Secure_Headers_Project
[2]: https://www.owasp.org/index.php/Testing_for_configuration_management
[3]: https://www.owasp.org/index.php/Testing_for_Error_Code_(OTG-ERR-001)
[4]: https://cwe.mitre.org/data/definitions/2.html
[5]: https://cwe.mitre.org/data/definitions/16.html
[6]: https://cwe.mitre.org/data/definitions/388.html
[7]: https://csrc.nist.gov/publications/detail/sp/800-123/final
[8]: https://letsencrypt.org/
[9]: https://www.owasp.org/index.php/Test_Cross_Origin_Resource_Sharing_(OTG-CLIENT-007)
