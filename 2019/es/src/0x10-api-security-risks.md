Riesgos de seguridad en APIs
==================

La [Metodología de calificación de riesgo de OWASP][1] se utilizó para hacer el análisis de riesgo.

La siguiente tabla resume la terminología asociada con la puntuación de riesgo.

| Agente/Vector de Ataque	 | Explotabilidad | Prevalencia de Debilidad | Debilidad de Detectabilidad | Impacto Técnico | Impactos de Negocio |
| :-: | :-: | :-: | :-: | :-: | :-: |
| Específico de API | Fácil: **3** | Extendido **3** | Fácil **3** | Grave **3** | Específico de negocio |
| Específico de API | Promedio: **2** | Común **2** | Promedio **2** | Moderado **2** | Específico de negocio |
| Específico de API | Difícil: **1** | Difícil **1** | Difícil **1** | Menor **1** | Específico de negocio |

**Nota**: Esta forma de hacerlo no toma en cuenta la probabilidad del agente de amenaza. Tampoco toma en cuenta ninguno de los diversos detalles técnicos asociados
con una aplicación en particular. Cualquiera de estos factores podría afectar significativamente la probabilidad general de que un atacante encuentre y explote a una vulnerabilidad en particular. Esta calificación no toma en cuenta el impacto real en su negocio. Su organización tendrá que decidir cuánto riesgo de aplicaciones y APIs está dispuesta a aceptar dependiendo de su cultura, industria y entorno regulatorio. El propósito de OWASP API Security Top 10 no es hacer este análisis de riesgo por usted.

## Referencias

### OWASP

* [Metodología de calificación de riesgo de OWASP][1]
* [Artículo sobre amenazas / Modelación de riesgos][2]

### Externos

* [ISO 31000: Estándar de gestión de riesgos][3]
* [ISO 27001: SGSI][4]
* [NIST Cyber ​​Framework (EE. UU.)][5]
* [Mitigaciones estratégicas de ASD (AU)][6]
* [NIST CVSS 3.0][7]
* [Herramienta de modelado de amenazas de Microsoft][8]

[1]: https://www.owasp.org/index.php/OWASP_Risk_Rating_Methodology
[2]: https://www.owasp.org/index.php/Threat_Risk_Modeling
[3]: https://www.iso.org/iso-31000-risk-management.html
[4]: https://www.iso.org/isoiec-27001-information-security.html
[5]: https://www.nist.gov/cyberframework
[6]: https://www.asd.gov.au/infosec/mitigationstrategies.htm
[7]: https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator
[8]: https://www.microsoft.com/en-us/download/details.aspx?id=49168
