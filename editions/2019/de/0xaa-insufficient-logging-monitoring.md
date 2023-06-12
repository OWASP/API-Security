# API10:2019 Insufficient Logging & Monitoring

| Bedrohungsakteure/Angriffsvektoren | Sicherheitslücken | Auswirkungen |
| - | - | - |
| API-spezifisch : Ausnutzbarkeit **2** | Häufigkeit **3** : Erkennbarkeit **1** | Komplexität **2** : Unternehmensspezifisch |
| Angreifer nutzen die fehlende Protokollierung und Überwachung aus, um Systeme unbemerkt zu missbrauchen. | Ohne Protokollierung und Überwachung oder mit unzureichender Protokollierung und Überwachung ist es fast unmöglich, verdächtige Aktivitäten zu verfolgen und rechtzeitig darauf zu reagieren. | Ohne Einblick in laufende bösartige Aktivitäten haben Angreifer genügend Zeit, um Systeme vollständig zu kompromittieren. |

## Ist die API angreifbar?

Die API ist angreifbar, wenn:

* Sie keine keine Protokolle erzeugt, die Protokollierungsstufe nicht korrekt eingestellt ist oder die Protokoll Nachrichten nicht genügend Details enthalten.
* Die Integrität der Protokolle nicht gewährleistet ist(z. B. [Log Injection][1]).
* Die Protokolle nicht kontinuierlich überwacht werden.
* Die API-Infrastruktur nicht kontinuierlich überwacht wird.

## Beispiele für Angriffe

### Szenario #1

Die Zugriffsschlüssel einer administrativen API wurden in einem öffentlichen Repository veröffentlicht. Der
Repository-Eigentümer wurde per E-Mail über das mögliche Datenleck informiert, brauchte aber mehr als
48 Stunden, um auf den Vorfall zu reagieren. Die Veröffentlichung der Zugangsschlüssel hat eventuell
Zugang zu sensiblen Daten ermöglicht. Aufgrund der unzureichenden Protokollierung kann das Unternehmen nicht beurteilen, auf welche Daten zugegriffen wurde.

### Szenario #2

Eine Video-Sharing-Plattform wurde von einem "groß angelegten" Credential Stuffing-Angriff getroffen.
Obwohl fehlgeschlagene Anmeldungen protokolliert wurden, wurde in der Zeitspanne des Angriffs kein Alarm ausgelöst.
Als Reaktion auf Nutzerbeschwerden wurden die API-Protokolle analysiert und der Angriff wurde entdeckt. Das Unternehmen musste eine öffentliche Ankündigung machen, in der es die Nutzer aufforderte ihre Passwörter zurückzusetzen. Außerdem musste das Unternehmen den Vorfall den Aufsichtsbehörden melden.

## Vorbeugende Maßnahmen

* Protokollieren Sie alle fehlgeschlagenen Authentifizierungsversuche, verweigerten Zugriff und Eingabevalidierungsfehler.
* Die Protokolle sollten in einem Format geschrieben werden, das von einer Log-Management-Lösung verarbeitet werden kann, und sie sollten genügend Details enthalten, um den Angreifer zu identifizieren.
* Protokolle sollten als sensible Daten behandelt werden, und ihre Integrität sollte stets gewährleistet sein.
* Konfigurieren Sie ein Überwachungssystem zur kontinuierlichen Überwachung der Infrastruktur, des Netzwerks und der Funktionsweise der API.
* Verwenden Sie ein Security Information and Event Management (SIEM), um Protokolle aller Komponenten der API und der Hosts zu sammeln und zu verwalten.
* Konfigurieren Sie benutzerdefinierte Dashboards und Warnmeldungen, um verdächtige Aktivitäten zu erkennen und darauf reagieren zu können.

## Referenzen

### OWASP

* [OWASP Logging Cheat Sheet][2]
* [OWASP Proactive Controls: Implement Logging and Intrusion Detection][3]
* [OWASP Application Security Verification Standard: V7: Error Handling and
  Logging Verification Requirements][4]

### Externe Quellen

* [CWE-223: Omission of Security-relevant Information][5]
* [CWE-778: Insufficient Logging][6]

[1]: https://www.owasp.org/index.php/Log_Injection
[2]: https://www.owasp.org/index.php/Logging_Cheat_Sheet
[3]: https://www.owasp.org/index.php/OWASP_Proactive_Controls
[4]: https://github.com/OWASP/ASVS/blob/master/4.0/en/0x15-V7-Error-Logging.md
[5]: https://cwe.mitre.org/data/definitions/223.html
[6]: https://cwe.mitre.org/data/definitions/778.html

