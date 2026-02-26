# Rischi di Sicurezza delle API

Per l'analisi dei rischi è stata utilizzata la [Metodologia di Valutazione del
Rischio OWASP][1].

La tabella seguente riassume la terminologia associata al punteggio di rischio.

| Agenti di Minaccia | Sfruttabilità | Diffusione della Debolezza | Rilevabilità della Debolezza | Impatto Tecnico | Impatti sul Business |
| :-: | :-: | :-: | :-: | :-: | :-: |
| Specifico per API | Facile: **3** | Diffusa **3** | Facile **3** | Grave **3** | Specifico per il Business |
| Specifico per API | Media: **2** | Comune **2** | Media **2** | Moderato **2** | Specifico per il Business |
| Specifico per API | Difficile: **1** | Difficile **1** | Difficile **1** | Minore **1** | Specifico per il Business |

**Nota**: Questo approccio non tiene conto della probabilità che l'agente di
minaccia si materializzi, né dei vari dettagli tecnici specifici della tua
applicazione. Ognuno di questi fattori potrebbe influenzare significativamente
la probabilità complessiva che un attaccante trovi e sfrutti una determinata
vulnerabilità. Questa valutazione non considera l'impatto reale sul tuo business.
La tua organizzazione dovrà decidere quale livello di rischio di sicurezza delle
applicazioni e delle API è disposta ad accettare, tenendo conto della propria
cultura, del settore di appartenenza e del contesto normativo. Lo scopo
dell'OWASP API Security Top 10 non è quello di effettuare questa analisi del
rischio al posto tuo. Poiché questa edizione non si basa sui dati, i risultati
sulla diffusione derivano da un consenso tra i membri del team di progetto.

## Riferimenti

### OWASP

* [Metodologia di Valutazione del Rischio OWASP][1]
* [Articolo su Threat/Risk Modeling][2]

### Esterni

* [ISO 31000: Standard di Gestione del Rischio][3]
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