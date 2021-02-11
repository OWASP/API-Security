Риски безопасности API
==================

The [OWASP Risk Rating Methodology][1] was used to do the risk analysis.

[Методология оценки рисков OWASP][1] была использована для анализа рисков.

The table below summarizes the terminology associated with the risk score.

Терминология, относящаяся к оценкам риска, приведена в таблице ниже.

| Threat Agents | Exploitability | Weakness Prevalence | Weakness Detectability | Technical Impact | Business Impacts |
| :-: | :-: | :-: | :-: | :-: | :-: |
| API Specific | Easy: **3** | Widespread **3** | Easy **3** | Severe **3** | Business Specific |
| API Specific | Average: **2** | Common **2** | Average **2** | Moderate **2** | Business Specific |
| API Specific | Difficult: **1** | Difficult **1** | Difficult **1** | Minor **1** | Business Specific |

| Источники угроз | Сложность эксплуатации | Распространненность | Сложность обнаружения | Технические последствия | Последствия для бизнеса |
| :-: | :-: | :-: | :-: | :-: | :-: |
| Зависит от API | Просто: **3** | Широкая **3** | Просто **3** | Тяжелые **3** | Зависит от бизнеса |
| Зависит от API | Средне: **2** | Обычная **2** | Средне **2** | Средние **2** | Зависит от бизнеса |
| Зависит от API | Сложно: **1** | Редкая **1** | Сложно **1** | Незначительные **1** | Зависит от бизнеса |

**Note**: This approach does not take the likelihood of the threat agent into
account. Nor does it account for any of the various technical details associated
with your particular application. Any of these factors could significantly
affect the overall likelihood of an attacker finding and exploiting a particular
vulnerability. This rating does not take into account the actual impact on your
business. Your organization will have to decide how much security risk from
applications and APIs the organization is willing to accept given your culture,
industry, and regulatory environment. The purpose of the OWASP API Security Top
10 is not to do this risk analysis for you.

**Примечание**: Этот подход не принимает во внимание правдопообность источника угроз. Также он не принимает во внимание за различные технические детали вашего конкретного приложения. Любой из этих факторов может значительно повлиять на общую вероятность обнаружения и эксплуатации злоумышленником конкретной уязвимости. Этот система оценки не принимает во внимание фактические последствия для вашего бизнеса. Вашей организации необходимо решить какие риски безопасности, создаваемые приложениями и API, она готова принять с учетом ее культуры безопасности, индустрии и требований регуляторов. Проведение анализа рисков за вас не является целью OWASP API Security Top 10.

## Ссылки

### OWASP

* [OWASP Risk Rating Methodology][1]
* [Article on Threat/Risk Modeling][2]

### Внешние

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
