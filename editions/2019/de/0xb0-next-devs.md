# Was kommt als Nächstes für Entwickler?

Die Aufgabe, sichere Software zu erstellen und zu pflegen oder bestehende Software zu reparieren, kann
schwierig sein. Bei APIs ist das nicht anders.

Wir glauben, dass Fortbildung und Bewusstsein die Schlüsselfaktoren für das Schreiben sicherer
Software sind. Alles andere, was erforderlich ist, um das Ziel zu erreichen, hängt ab von
**Einführung und Verwendung von wiederholbaren Sicherheitsprozessen und standardisierten Sicherheitskontrollen**.

OWASP hat seit Beginn des Projekts zahlreiche freie und offene Ressourcen zum Thema Sicherheit
vorgestellt. Bitte besuchen Sie die [OWASP-Projektseite][1] für eine umfassende Liste der verfügbaren Projekte.

| | |
|-|-|
| **Bildung** | Sie können je nach Beruf und Interesse mit dem Lesen von [OWASP Education Project materials][2] beginnen. Für praktisches Lernen haben wir **crAPI** - **C**ompletely **R**idiculous **API** auf [unsere Roadmap][3] gesetzt. In der Zwischenzeit können Sie WebAppSec mit dem [OWASP DevSlop Pixi Module][4] üben, einem verwundbaren WebApp- und API-Service, der Benutzern beibringen soll, wie man moderne Webanwendungen und APIs auf Sicherheitsprobleme testet und wie man in Zukunft sicherere APIs schreibt. Sie können auch an den Schulungssitzungen der [OWASP AppSec Conference][5] teilnehmen oder [Ihrem lokalen Verband beitreten][6]. |
| **Sicherheitsanforderungen** | Sicherheit sollte von Anfang an Teil eines jeden Projekts sein. Bei der Anforderungserhebung ist es wichtig zu definieren, was "sicher" für dieses Projekt bedeutet. OWASP empfiehlt, den [OWASP Application Security Verification Standard (ASVS)][7] als Leitfaden für die Festlegung der Sicherheitsanforderungen zu verwenden. Wenn Sie ein Projekt auslagern, sollten Sie den [OWASP Secure Software Contract Annex][8] verwenden, der entsprechend den lokalen Gesetzen und Vorschriften angepasst werden sollte. |
| **Sicherheitsarchitektur** | Sicherheit sollte während aller Projektphasen ein Thema bleiben. Die [OWASP Prevention Cheat Sheets][9] sind ein guter Ausgangspunkt für Anleitungen, wie man Sicherheit schon in der Architekturphase einplant. Unter vielen anderen finden Sie das [REST Security Cheat Sheet][10] und das [REST Assessment Cheat Sheet][11]. |
| **Standard-Sicherheitskontrollen** | Die Übernahme von Standard-Sicherheitskontrollen verringert das Risiko, beim Schreiben Ihrer eigenen Logik Sicherheitslücken einzuführen. Trotz der Tatsache, dass viele moderne Frameworks mittlerweile über eingebaute effektive Standardkontrollen verfügen, gibt [OWASP Proactive Controls][12] einen guten Überblick darüber, welche Sicherheitskontrollen Sie in Ihr Projekt einbauen sollten. OWASP stellt auch einige Bibliotheken und Tools zur Verfügung, die für Sie nützlich sein können, wie z.B. Validierungskontrollen. |
| **Secure Software Development Life Cycle** | Sie können das [OWASP Software Assurance Maturity Model (SAMM)][13] verwenden, um den Prozess bei der Erstellung von APIs zu verbessern. Mehrere andere OWASP-Projekte stehen zur Verfügung, um Sie in den verschiedenen Phasen der API-Entwicklung zu unterstützen, z. B. das [OWASP Code Review Project][14]. |

[1]: https://www.owasp.org/index.php/Category:OWASP_Project
[2]: https://www.owasp.org/index.php/OWASP_Education_Material_Categorized
[3]: https://www.owasp.org/index.php/OWASP_API_Security_Project#tab=Road_Map
[4]: https://devslop.co/Home/Pixi
[5]: https://www.owasp.org/index.php/Category:OWASP_AppSec_Conference
[6]: https://www.owasp.org/index.php/OWASP_Chapter
[7]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[8]: https://www.owasp.org/index.php/OWASP_Secure_Software_Contract_Annex
[9]: https://www.owasp.org/index.php/OWASP_Cheat_Sheet_Series
[10]: https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/REST_Security_Cheat_Sheet.md
[11]: https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/REST_Assessment_Cheat_Sheet.md
[12]: https://www.owasp.org/index.php/OWASP_Proactive_Controls#tab=OWASP_Proactive_Controls_2018
[13]: https://www.owasp.org/index.php/OWASP_SAMM_Project
[14]: https://www.owasp.org/index.php/Category:OWASP_Code_Review_Project
