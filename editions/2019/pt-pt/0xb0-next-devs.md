# O Que Se Segue Para Programadores

A tarefa de criar e manter software seguro, ou corrigir software existente, pode
ser difícil. O mesmo se verifica em relação às APIs.

Acreditamos que educação e consciencialização são fatores chave para o
desenvolvimento de software seguro. Tudo o mais necessário para alcançar este
objetivo depende da **definição e utilização de processos de segurança
reprodutíveis e do uso de controlos de segurança _standard_**.

A OWASP disponibiliza uma grande quantidade de recursos gratuitos e abertos para
abordar a segurança desde o início dum projeto. Por favor visite a [página dos
projetos OWASP][1] para consulta da lista dos projetos existentes.

| | |
|-|-|
| **Educação** | Pode começar por ler os conteúdos disponibilizados pelos [projetos na categoria OWASP Education][2] de acordo com a sua profissão e interesse. Para uma abordagem mais prática, adicionámos ao nosso plano de trabalho o projeto **crAPI** - **C**ompletely **R**idiculous **API** (API Completamente Ridícula). Enquanto isso, pode praticar segurança de aplicações web usando o [Módulo OWASP DevSlop Pixi][4]: uma WebApp e API intencionalmente vulneráveis com o objetivo de ensinar aos utilizadores como testar a segurança de WebApps modernas e APIs e como desenvolver APIs mais seguras. Poderá também participar nas sessões de treino das [conferências OWASP AppSec][5] ou [juntar-se ao seu grupo OWASP local][6]. |
| **Requisitos de Segurança** | A segurança deve fazer parte de qualquer projeto desde o início. É importante que, durante a fase de identificação de requisitos, seja definido o que é que “seguro” significa no contexto desse projeto. A OWASP recomenda a utilização do [OWASP Application Security Verification Standard (ASVS)][7] como guia para definir os requisitos de segurança. Se estiver a subcontratar, considere ao invés a utilização do [OWASP Secure Software Contract Annex][8], o qual deverá adaptar às leis e regulamentações locais. |
| **Arquitetura de Segurança** | A segurança deve ser uma preocupação durante todas as fases dum projeto. O projeto [OWASP Prevention Cheat Sheets][9] é um bom ponto inicial de orientação sobre como contemplar a segurança durante a fase de arquitetura. Entre outros, o [REST Security Cheat Sheet][10] e o [REST Assessment Cheat Sheet][11] serão seguramente relevantes. |
| **Controlos Standard de Segurança** | A adoção de controlos standard de segurança reduzem o risco de introdução de falhas de segurança durante a implementação da lógica de negócio. Apesar de muitas _frameworks_ modernas já incluírem controlos _standards_, o projeto [OWASP Proactive Controls][12] dá-lhe uma visão sobre que controlos de segurança deve incluir no seu projeto. A OWASP também disponibiliza algumas bibliotecas e ferramentas que pode achar úteis, tais como controlos de validação. |
| **Ciclo de Desenvolvimento de Software Seguro** | Pode usar o [OWASP Software Assurance Maturity Model (SAMM)][13] para melhorar o processo de desenvolvimento de APIs. Tem ainda disponíveis vários outros projetos OWASP para o ajudar durante as várias fases de desenvolvimento de APIs, por exemplo o [OWASP Code Review Project][14]. |

[1]: https://owasp.org/projects/
[2]: https://www.owasp.org/index.php/OWASP_Education_Material_Categorized
[3]: https://www.owasp.org/index.php/OWASP_API_Security_Project#tab=Road_Map
[4]: https://devslop.co/Home/Pixi
[5]: https://owasp.org/events/#global-events
[6]: https://owasp.org/chapters/
[7]: https://owasp.org/www-project-application-security-verification-standard/
[8]: https://owasp.org/www-community/OWASP_Secure_Software_Contract_Annex
[9]: https://owasp.org/www-project-cheat-sheets/
[10]: https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/REST_Security_Cheat_Sheet.md
[11]: https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/REST_Assessment_Cheat_Sheet.md
[12]: https://owasp.org/www-project-proactive-controls/
[13]: https://owasp.org/www-project-samm/
[14]: https://www.owasp.org/index.php/Category:OWASP_Code_Review_Project
