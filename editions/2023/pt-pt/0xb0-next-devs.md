# O Que Se Segue Para Programadores

A tarefa de criar e manter aplicações seguras, ou corrigir aplicações 
existentes, pode ser difícil. Não é diferente para as APIs.

Acreditamos que educação e consciencialização são fatores chave para o
desenvolvimento de software seguro. Tudo o mais necessário para alcançar este
objetivo depende da **definição e utilização de processos de segurança
reprodutíveis e do uso de controlos de segurança _standard_**.

A OWASP disponibiliza uma grande quantidade de recursos gratuitos e abertos para
abordar a segurança. Por favor visite a [página dos projetos OWASP][1] para 
consulta da lista dos projetos existentes.

| | |
|-|-|
| **Educação** | O [Application Security Wayfinder][2] deve oferecer uma boa ideia sobre quais projetos estão disponíveis para cada etapa/fase do Ciclo de Vida do Desenvolvimento de Software (SDLC). Para aprendizagem prática/treino, pode começar com [OWASP **crAPI** - **C**ompletely **R**idiculous **API**][3] ou [OWASP Juice Shop][4]: ambos possuem APIs intencionalmente vulneráveis. O [OWASP Vulnerable Web Applications Directory Project][5] fornece uma lista curada de aplicações intencionalmente vulneráveis: lá encontrará várias outras APIs vulneráveis. Também pode participar em sessões de treino da [OWASP AppSec Conference][6] ou [juntar-se ao seu chapter local][7]. |
| **Requisitos de Segurança** | A segurança deve fazer parte de qualquer projeto desde o início. É importante que, durante a fase de identificação de requisitos, seja definido o que é que “seguro” significa no contexto desse projeto. A OWASP recomenda a utilização do [OWASP Application Security Verification Standard (ASVS)][8] como guia para definir os requisitos de segurança. Se estiver a subcontratar, considere ao invés a utilização do [OWASP Secure Software Contract Annex][9], o qual deverá adaptar às leis e regulamentações locais. |
| **Arquitetura de Segurança** | A segurança deve ser uma preocupação durante todas as fases dum projeto. O projeto [OWASP Prevention Cheat Sheets][10] é um bom ponto inicial de orientação sobre como contemplar a segurança durante a fase de arquitetura. Entre outros, o [REST Security Cheat Sheet][11] e o [REST Assessment Cheat Sheet][12] serão seguramente relevantes, como também o [GraphQL Cheat Sheet][13]. |
| **Controlos Standard de Segurança** | A adoção de controlos standard de segurança reduzem o risco de introdução de falhas de segurança durante a implementação da lógica de negócio. Apesar de muitas _frameworks_ modernas já incluírem controlos standard, o projeto [OWASP Proactive Controls][14] dá-lhe uma boa visão sobre que controlos de segurança deve incluir no seu projeto. A OWASP também disponibiliza algumas bibliotecas e ferramentas que pode achar úteis, tais como controlos de validação. |
| **Ciclo de Desenvolvimento de Software Seguro** | Pode usar o [OWASP Software Assurance Maturity Model (SAMM)][15] para melhorar o processo de desenvolvimento de APIs. Tem ainda disponíveis vários outros projetos OWASP para o ajudar durante as várias fases de desenvolvimento de APIs, por exemplo o [OWASP Code Review Guide][16]. |

[1]: https://owasp.org/projects/
[2]: https://owasp.org/projects/#owasp-projects-the-sdlc-and-the-security-wayfinder
[3]: https://owasp.org/www-project-crapi/
[4]: https://owasp.org/www-project-juice-shop/
[5]: https://owasp.org/www-project-vulnerable-web-applications-directory/
[6]: https://owasp.org/events/
[7]: https://owasp.org/chapters/
[8]: https://owasp.org/www-project-application-security-verification-standard/
[9]: https://owasp.org/www-community/OWASP_Secure_Software_Contract_Annex
[10]: https://cheatsheetseries.owasp.org/
[11]: https://cheatsheetseries.owasp.org/cheatsheets/REST_Security_Cheat_Sheet.html
[12]: https://cheatsheetseries.owasp.org/cheatsheets/REST_Assessment_Cheat_Sheet.html
[13]: https://cheatsheetseries.owasp.org/cheatsheets/GraphQL_Cheat_Sheet.html
[14]: https://owasp.org/www-project-proactive-controls/
[15]: https://owasp.org/www-project-samm/
[16]: https://owasp.org/www-project-code-review-guide/
