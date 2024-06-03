# Risques de sécurité des API

La [méthodologie d'évaluation des risques de l'OWASP][1] a été utilisée pour effectuer l'analyse des risques.

La table ci-dessous résume la terminologie associée au "score" de risque.

| Facteur de menace | Exploitabilité | Prévalence de la faiblesse | Détectabilité de la faiblesse | Impact technique | Impacts organisationnel |
| :-: | :-: | :-: | :-: | :-: | :-: |
| Spécifique à l'API | Facile: **3** | Répandue **3** | Facile **3** | Sévère **3** | Spécifique à l'organisation |
| Spécifique à l'API | Moyenne: **2** | Commune   **2** | Moyenne **2** | Modéré **2** | Spécifique à l'organisation |
| Spécifique à l'API | Difficile: **1** | Difficile **1** | Difficile **1** | Mineur **1** | Spécifique à l'organisation |


**Note**: Cette approche ne prend pas en compte la probabilité de la menace. Elle ne tient pas non plus compte des divers détails techniques spécifiques à votre application. L'un de ces facteurs pourrait affecter significativement la probabilité globale qu'un attaquant trouve et exploite une vulnérabilité particulière. Cette notation ne prend pas en compte l'impact réel sur votre entreprise. Votre organisation devra décider du niveau de risque de sécurité des applications et des API que l'organisation est prête à accepter compte tenu de votre culture, de votre secteur et de votre environnement réglementaire. Le but du OWASP API Security Top 10 n'est pas de faire cette analyse de risque pour vous. Comme cette édition n'est pas basée sur des données, la prévalence résulte d'un consensus entre les membres de l'équipe.

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

[1]: https://owasp.org/www-project-risk-assessment-framework/
[2]: https://owasp.org/www-community/Threat_Modeling
[3]: https://www.iso.org/iso-31000-risk-management.html
[4]: https://www.iso.org/isoiec-27001-information-security.html
[5]: https://www.nist.gov/cyberframework
[6]: https://www.asd.gov.au/infosec/mitigationstrategies.htm
[7]: https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
[8]: https://www.microsoft.com/en-us/download/details.aspx?id=49168
