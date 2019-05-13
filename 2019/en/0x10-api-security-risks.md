API Security Risks
==================

The [OWASP Risk Rating Methodology][1] was used to do the risk analysis.

The table below summarizes the terminology associated with the risk score.

| Threat Agents | Exploitability | Weakness Prevalence | Weakness Detectability | Technical Impact | Business Impacts |
| :-: | :-: | :-: | :-: | :-: | :-: |
| API Specific | Easy: **3** | Widespread **3** | Easy **3** | Severe **3** | Business Specific |
| API Specific | Average: **2** | Common **2** | Average **2** | Moderate **2** | Business Specific |
| API Specific | Difficult: **1** | Difficult **1** | Difficult **1** | Minor **1** | Business Specific |

**Note**: This approach does not take the likelihood of the threat agent into
account. Nor does it account for any of the various technical details associated
with your particular application. Any of these factors could significantly
affect the overall likelihood of an attacker finding and exploiting a particular
vulnerability. This rating does not take into account the actual impact on your
business. Your organization will have to decide how much security risk from
applications and APIs the organization is willing to accept given your culture,
industry, and regulatory environment. The purpose of the OWASP API Security Top
10 is not to do this risk analysis for you.

[1]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
