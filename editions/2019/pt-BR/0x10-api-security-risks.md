# Riscos de Segurança de API

A [Metodologia de Avaliação de Risco do OWASP][1] foi adotada para a análise dos riscos de API. 

A tabela abaixo resume a terminologia associada à pontuação de risco.

| Agentes de Ameaça | Explorabilidade | Prevalência da Fraqueza | Detecção da Fraqueza | Impacto Técnico | Impacto ao Negócio |
| :-: | :-: | :-: | :-: | :-: | :-: |
| Específico da API | Fácil: **3** | Difundida **3** | Fácil **3** | Severo **3** | Específico do negócio |
| Específico da API | Média: **2** | Comum **2** | Média **2** | Moderado **2** | Específico do negócio |
| Específico da API | Difícil: **1** | Difícil **1** | Difícil **1** | Menor **1** | Específico do negócio |

**Nota**: Esta abordagem não leva em consideração um agente de ameaça interno. Também não considera detalhes técnicos associados à sua aplicação em específico. Estes são fatores que podem afetar de maneira significativa a probabilidade de um atacante encontrar e explorar vulnerabilidades específicas. Esta classificação também não avalia impactos ao seu negócio. Sua organização terá que decidir quanto risco de segurança de aplicativos e APIs que a organização está disposta a aceitar, dada sua cultura, indústria e ambiente regulatório. O propósito do OWASP API Security top 10 não é desenvolver uma análise de risco por você.

## Referências

### OWASP

* [OWASP Risk Rating Methodology][1]
* [Article on Threat/Risk Modeling][2]

### Externas

* [ISO 31000: Risk Management Std][3]
* [ISO 27001: ISMS][4]
* [NIST Cyber Framework (US)][5]
* [ASD Strategic Mitigations (AU)][6]
* [NIST CVSS 3.0][7]
* [Microsoft Threat Modeling Tool][8]

[1]: https://owasp.org/www-project-risk-assessment-framework/
[2]: https://owasp.org/www-community/Application_Threat_Modeling
[3]: https://www.iso.org/iso-31000-risk-management.html
[4]: https://www.iso.org/isoiec-27001-information-security.html
[5]: https://www.nist.gov/cyberframework
[6]: https://www.asd.gov.au/infosec/mitigationstrategies.htm
[7]: https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
[8]: https://www.microsoft.com/en-us/download/details.aspx?id=49168
