# Próximos passos para DevSecOps

Considerando sua importância na arquitetura de aplicações modernas, a construção de APIs seguras é crucial. A segurança não pode ser negligenciadas, e deve fazer parte de todo o ciclo de vida de desenvolvendo. Executar verificações e testes de penetração anualmente não é mais suficiente.

DevSecOps deve se juntar aos esforços de desenvolvimento, facilitando a execução de testes contínuos de segurança durante todo o ciclo de desenvolvimento de software. O objetivo é melhorar o *pipeline* de desenvolvimento com automação de segurança, sem contudo impactar negativamente a velocidade do desenvolvimento.

Em caso de dúvidas, mantenha-se informado, e reveja o [Manifesto DevSecOps][1] frequentemente.

| | |
|-|-|
| **Compreensão do modelo de ameaça** | Teste de prioridades vem do modelo da ameaça. Se você não possui um, considere usar os projetos [OWASP Application Security Verification Standard (ASVS)][2], e também [OWASP Testing Guide][3] como entrada. Envolver a equipe de desenvolvimento pode ajudar a torná-los mais conscientes da segurança. |
| **Compreensão do SDLC** | Junte-se ao time de desenvolvimento para melhor compreensão do ciclo de desenvolvimento de software (SDLC - Software Development Life Cycle). Sua contribuição com testes de segurança contínuos deve ser compatível com pessoas, processos e ferramentas. Todos devem concordar com o processo, assim evita-se atritos e resistências. |
| **Estratégias de testes** | Uma vez que seu trabalho não deve impactar negativamente a velocidade do desenvolvimento, você deve escolher com cuidado a melhor (simples, rápida e precisa) técnica de verificação de requisitos de segurança. Consulte os projetos [OWASP Security Knowledge Framework][4] e [OWASP Application Security Verification Standard][5] que podem ser excelentes fontes de requisitos de segurança funcionais e não funcionais. Outras ótimas fontes de consulta são os [projetos][6] e [ferramentas][7] similares ao oferecidos pela [comunidade DevSecOps][8]. |
| **Alcançando cobertura e precisão** | Você é a ponte entre os times de desenvolvimento e operações. Para alcançar cobertura, não dê atenção somente a funcionalidade mas também à orquestração. Trabalhe próximo ao dois times desde o início e assim você consegue otimizar seu tempo e esforço. Você deve também encontrar um momento onde o essencial da segurança seja continuamente verificado. |
| **Comunique claramente problemas** | Contribua com menos ou nenhum atrito. Distribua os problemas encontrados em tempo hábil, utilizando as ferramentas que os times utilizam em sua rotina (nunca documentos PDF). Junte-se ao time de desenvolvimento para a correção de problemas encontrados. Construa oportunidades para educá-los, descrevendo claramente as fraquezas e como estas podem ser exploradas, incluindo cenários de ataques que demonstre cenários reais. |

[1]: https://www.devsecops.org/
[2]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[3]: https://www.owasp.org/index.php/OWASP_Testing_Project
[4]: https://www.owasp.org/index.php/OWASP_Security_Knowledge_Framework
[5]: https://www.owasp.org/index.php/Category:OWASP_Application_Security_Verification_Standard_Project
[6]: http://devsecops.github.io/
[7]: https://github.com/devsecops/awesome-devsecops
[8]: http://devsecops.org
