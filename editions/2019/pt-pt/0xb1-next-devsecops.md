# O que Se Segue Para DevSecOps

Dada a sua importância na arquitetura das aplicações modernas, desenvolver APIs
seguras é crucial. A segurança não pode ser negligenciada e deve estar presente
durante todo o clico de vida do desenvolvimento. Já não basta a execução de
_scanners_ ou a realização de testes de penetração anualmente.

A equipa de DevSecOps deve fazer parte do esforço de desenvolvimento
contribuindo para a realização de testes de segurança, de forma continuada,
durante todo o ciclo de vida do desenvolvimento. Deve ter como objetivo melhorar
a _pipeline_ de desenvolvimento com automação de segurança e sem influenciar
negativamente no ritmo do desenvolvimento.

Em caso de dúvida mantenha-se informado e reveja o [Manifesto DevSecOps][1] com
frequência.



| | |
|-|-|
| **Compreenda o Modelo de Ameaças** | As prioridades relativamente ao que deve ser testado têm origem no modelo de ameaças. Se não tem um, considere usar o [OWASP Application Security Verification Standard (ASVS)][2] e o [OWASP Testing Guide][3] como base. Envolver a equipa de desenvolvimento na elaboração do modelo de ameaças pode torná-la mais consciente para questões relacionadas com segurança. |
| **Compreenda o Ciclo de Vida do Desenvolvimento do Software** | Reúna a equipa de desenvolvimento para melhor compreender o ciclo de vida do desenvolvimento do software. O seu contributo para a realização continua de testes de segurança deve ser compatível com as pessoas, processos e ferramentas. Todos devem concordar com o processo, de forma a não provocar atrito ou resistência desnecessários. |
| **Estratégias de Teste** | Sendo que o seu trabalho não deve condicionar o ritmo de desenvolvimento, deverá escolher cuidadosamente a melhor (mais simples, rápida e precisa) técnica para verificar os requisitos de segurança. A [OWASP Security Knowledge Framework][4] e o [OWASP Application Security Verification Standard][5] podem ser importantes fontes de requisitos de segurança funcionais e não-funcionais. Existem outras fontes relevantes onde poderá encontrar [projetos][6] e [ferramentas][7] como aquelas disponibilizadas pela [comunidade DevSecOps][8]. |
| **Procure Alcançar Cobertura e Precisão** | Você é a ponte entre as equipas de desenvolvimento e operações. Para alcançar cobertura, deve não só focar-se na funcionalidade, mas também na orquestração. Trabalhe junto de ambas as equipas desde o início por forma a otimizar o seu tempo e esforço. Deve almejar um estado em que o essencial da segurança é verificado de forma continua. |
| **Comunique as Falhas de Forma Clara** | Entregue valor evitando qualquer atrito. Comunique as falhas identificadas atempadamente, usando as ferramentas que a equipa de desenvolvimento já utiliza (e não através de ficheiros PDF). Junte-se à equipa de desenvolvimento para resolver as falhas identificadas. Aproveite a oportunidade para educar os elementos da equipa de desenvolvimento, descrevendo de forma clara a falha e como esta pode ser abusada, incluindo um cenário de ataque para a tornar mais real. |

[1]: https://www.devsecops.org/
[2]: https://owasp.org/www-project-application-security-verification-standard/
[3]: https://owasp.org/www-project-web-security-testing-guide/
[4]: https://owasp.org/www-project-security-knowledge-framework/
[5]: https://owasp.org/www-project-application-security-verification-standard/
[6]: http://devsecops.github.io/
[7]: https://github.com/devsecops/awesome-devsecops
[8]: http://devsecops.org
