# Riscos de Segurança em APIs

Para a análise de risco usámos a [metodologia de avaliação de risco da
OWASP][1].

A tabela seguinte resume a terminologia associada à pontuação correspondente ao
nível de risco.

| Agentes Ameaça | Abuso | Prevalência | Deteção | Impacto Técnico | Impacto Negócio |
| :-: | :-: | :-: | :-: | :-: | :-: |
| Específico da API | Fácil **3** | Predominante **3** | Fácil **3** | Grave **3** | Específico do Negócio |
| Específico da API | Moderado **2** | Comum **2** | Moderado **2** | Moderado **2** | Específico do Negócio |
| Específico da API | Difícil **1** | Incomum **1** | Difícil **1** | Reduzido **1** | Específico do Negócio |

**Nota**: Esta abordagem não toma em consideração a probabilidade do Agente de
Ameaça. Também não toma em consideração nenhum detalhe técnico associado à sua
API. Qualquer um destes fatores podem ter impacto significativo na probabilidade
de um atacante encontrar e abusar duma falha de segurança particular. Estes
indicadores não tomam em consideração o impacto atual no seu negócio. Terá de
ser a sua organização a decidir qual o nível de risco para a segurança das suas
aplicações e APIs que está disposta a aceitar, baseado na cultura, indústria e
regulação a que está sujeita. O propósito do OWASP API Security Top 10 não é
fazer essa análise por si. Uma vez que esta edição não é baseada em dados, a 
prevalência resulta de um consenso entre os membros da equipa.

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
[2]: https://owasp.org/www-community/Threat_Modeling
[3]: https://www.iso.org/iso-31000-risk-management.html
[4]: https://www.iso.org/isoiec-27001-information-security.html
[5]: https://www.nist.gov/cyberframework
[6]: https://www.asd.gov.au/infosec/mitigationstrategies.htm
[7]: https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
[8]: https://www.microsoft.com/en-us/download/details.aspx?id=49168
