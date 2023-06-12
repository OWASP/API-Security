# Sicherheitsrisiken für APIs

Zur Durchführung der Risikoanalyse wurde die [OWASP Risk Rating Methodology][1] verwendet.

Die nachstehende Tabelle fasst die mit der Risikobewertung verbundene Terminologie zusammen.

| Bedrohungsakteure | Ausnutzbarkeit | Schwachstellenprävalenz | Schwachstellendetektierbarkeit | Technische Auswirkungen | Geschäftsauswirkungen |
| :-: | :-: | :-: | :-: | :-: | :-: |
| API-spezifisch | Leicht: **3** | Weit verbreitet **3** | Leicht **3** | Schwer **3** | Unternehmensspezifisch |
| API-spezifisch | Durchschnittlich **2** | Häufig **2** | Durchschnittlich **2** | Mäßig **2** | Unternehmensspezifisch |
| API-spezifisch | Schwer **1** | Schwer **1** | Schwer **1** | Leicht **1** | Unternehmensspezifisch |

**Anmerkung**: Bei diesem Ansatz wird die Wahrscheinlichkeit des Bedrohungserregers nicht berücksichtigt. Er berücksichtigt auch keine der verschiedenen technischen Details, die mit Ihrer speziellen Anwendung verbunden sind. Jeder dieser Faktoren kann die Gesamtwahrscheinlichkeit, dass ein Angreifer eine bestimmte Schwachstelle findet und ausnutzt beeinflussen. Diese Bewertung berücksichtigt nicht die tatsächlichen Auswirkungen auf Ihr
Unternehmen. Ihr Unternehmen muss entscheiden, wie viele Sicherheitsrisiken durch
Anwendungen und APIs das Unternehmen bereit ist, angesichts der Unternehmenskultur, Branche und regulatorischem Umfelds zu akzeptieren. Der Zweck der OWASP API Security Top
10 ist es nicht, diese Risikoanalyse für Sie durchzuführen.

## Referenzen

### OWASP

* [OWASP Risk Rating Methodology][1]
* [Article on Threat/Risk Modeling][2]

### External

* [ISO 31000: Risk Management Std][3]
* [ISO 27001: ISMS][4]
* [NIST Cyber Framework (US)][5]
* [ASD Strategic Mitigations (AU)][6]
* [NIST CVSS 3.0][7]
* [Microsoft Threat Modeling Tool][8]

[1]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
[2]: https://www.owasp.org/index.php/Threat_Risk_Modeling
[3]: https://www.iso.org/iso-31000-risk-management.html
[4]: https://www.iso.org/isoiec-27001-information-security.html
[5]: https://www.nist.gov/cyberframework
[6]: https://www.asd.gov.au/infosec/mitigationstrategies.htm
[7]: https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
[8]: https://www.microsoft.com/en-us/download/details.aspx?id=49168
