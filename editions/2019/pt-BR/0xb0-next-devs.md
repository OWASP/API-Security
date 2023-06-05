# Próximos passos para Desenvolvedores

A tarefa de criar e manter software seguro, ou, corrigir software existente, pode ser uma tarefa difícil. APIs não são diferentes.

Nós acreditamos que a educação e conscientização são fatores chave para escrever software seguro. Tudo o que é necessário para alcançar este objetivo depende de **estabelecer e usar procedimentos de segurança reprodutíveis e padronizar controles de segurança**.

O OWASP possui um grande número de fontes abertas para endereçar a segurança desde o princípio dos projetos. Por favor, visite a [página de projetos do OWASP][1] para uma extensa lista de projetos disponíveis.

| | |
|-|-|
| **Educação** | Você pode iniciar lendo [os materiais de educação do OWASP][2] de acordo com sua área ou interesse. Para aprendizado mão-na-massa, nós adicionamos **crAPI** - **C**ompletely **R**idiculous **API** (API Ridiculamente Vulnerável) em [nosso roadmap][3]. Enquanto isso, você pode praticar segurança de aplicações web utilizando o [OWASP DevSlop Pixi Module][4], um aplicativo web vulnerável e um serviço API com a intenção de ensinar usuário como testar aplicações web modernas e também APIs com relação a problemas de segurança. Você pode também participar das [conferências AppSec do OWASP][5] com sessões de treinamento, ou ainda [juntar-se a seu capítulo local][6]. |
| **Requisitos de Segurança** | Segurança deve fazer parte de qualquer projeto desde o princípio. Ao fazer a escolha de requisitos, é importante definir o que a "segurança" representa para o projeto. O OWASP recomenda o uso do [OWASP Application Security Verification Standard (ASVS)][7] como um guia para atribuir requisitos de segurança. Se você trabalha com *outsourcing*, considere o projeto [OWASP Secure Software Contract Annex][8], o qual deve ser adaptado de acordo com as leis e regulamentos locais. |
| **Arquitetura de Segurança** | Seguraça deve permanecer uma preocupação durante todas as fases de um projeto. O [OWASP Prevention Cheat Sheets][9] é um bom ponto de partida e um guia sobre como o *design* de segurança durante a fase de arquitetura. Junto de vários outros, você encontrará [REST Security Cheat Sheet][10] e também [REST Assessment Cheat Sheet][11] com abordagem de aspetos de APIs. |
| **Controle de Segurança Padrão** | A adoção de padrões de controles de segurança reduzem o risco da introdução de fraquezas durante o desenvolvimento da lógica específica do negócio no software. Fora o fato que frameworks modernos incluírem por padrão controles de segurança efetivos, considere o [OWASP Proactive Controls][12] que entrega uma boa visão geral sobre quais controles de segurança você deve avaliar e incluir em seu projeto. O OWASP também entrega algumas bibliotecas e ferramentas que podem ser úteis, como validação de controles. |
| **Ciclo de Vida do Software Seguro** | Você pode utilizar o [OWASP Software Assurance Maturity Model (SAMM)][13] para melhorar seu processo enquanto constrói APIs. Muitos outros projetos do OWASP possuem valor para ajudá-lo com as diferentes fases do desenvolvimento de suas API, por ex.: o [OWASP Code Review Project][14]. |

[1]: https://www.owasp.org/index.php/Category:OWASP_Project
[2]: https://www.owasp.org/index.php/OWASP_Education_Material_Categorized
[3]: https://www.owasp.org/index.php/OWASP_API_Security_Project#tab=Road_Map
[4]: https://devslop.co/Home/Pixi
[5]: https://www.owasp.org/index.php/Category:OWASP_AppSec_Conference
[6]: https://www.owasp.org/index.php/OWASP_Chapter
[7]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[8]: https://www.owasp.org/index.php/OWASP_Secure_Software_Contract_Annex
[9]: https://www.owasp.org/index.php/OWASP_Cheat_Sheet_Series
[10]: https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/REST_Security_Cheat_Sheet.md
[11]: https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/REST_Assessment_Cheat_Sheet.md
[12]: https://www.owasp.org/index.php/OWASP_Proactive_Controls#tab=OWASP_Proactive_Controls_2018
[13]: https://www.owasp.org/index.php/OWASP_SAMM_Project
[14]: https://www.owasp.org/index.php/Category:OWASP_Code_Review_Project
