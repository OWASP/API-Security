# Risques de sécurité des API

La [méthodologie d'évaluation de risques OWASP][1] a été utilisée pour effectuer l'analyse de risques.

La table ci-dessous résume la terminologie associée au niveau de risque.

| Facteurs de menace | Exploitabilité | Prévalence de la faille | Détectabilité de la faille | Impact technique | Impact organisationnel |
| :-: | :-: | :-: | :-: | :-: | :-: |
| Spécifique API | Facile: **3** | Répandu **3** | Facile **3** | Sévère **3** | Spécifique à l'organisation |
| Spécifique API | Moyen: **2** | Commune **2** | Moyenne **2** | Modéré **2** | Spécifique à l'organisation |
| Spécifique API | Difficile: **1** | Difficile **1** | Difficile **1** | Mineure **1** | Spécifique à l'organisation |

**Note**: Cette approche ne prend pas en compte la probabilité du facteur de
menace. Elle ne prend pas non plus en compte les différents détails techniques
spécifiques à votre application. Ces facteurs pourraient modifier de manière
significative la probabilité globale qu'un attaquant trouve et exploite une
vulnérabilité particulière. Cette évaluation ne prend pas en compte l'impact
réel sur votre activité. Votre organisation devra décider quel niveau de risque
de sécurité elle est prête à accepter pour vos applications et vos API en
fonction de votre culture, votre secteur d'activité et votre environnement
réglementaire. L'objet du projet OWASP API Security Top 10 n'est pas d'effectuer
cette analyse de risques à votre place.

## Références

### OWASP

* [OWASP Risk Rating Methodology][1]
* [Article on Threat/Risk Modeling][2]

### Externes

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
