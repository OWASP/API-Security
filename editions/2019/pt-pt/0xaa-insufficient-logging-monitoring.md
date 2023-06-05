# API10:2019 Insufficient Logging & Monitoring

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **2** | Prevalência **3** : Deteção **1** | Técnico **2** : Específico Negócio |
| Os atacantes podem tirar partido desta vulnerabilidade para abusar dos sistemas sem ser detetados. | Sem registo de eventos e monitorização, ou com um registo e monitorização insuficientes, é quase impossível detetar atividades suspeitas e responder às mesmas em tempo útil. | Sem visibilidade sobre atividades maliciosas os atacantes têm tempo suficiente para comprometer os sistemas. |

## A API é vulnerável?

A API é vulnerável se:

* Não regista qualquer evento, o tipo de evento registado não é o correto ou os
  registos não incluem detalhe suficiente.
* A integridade do registo de eventos não é assegurada (e.g.,
  [Log Injection][1]).
* Os registos de eventos não são monitorizados.
* A infraestrutura da API não é monitorizada ininterruptamente.

## Exemplos de Cenários de Ataque

### Cenário #1

As _access keys_ duma API de administração foram expostas publicamente num
repositório. O proprietário do repositório foi notificado por email sobre a
potencial divulgação das chaves mas demorou mais de 48h a reagir ao incidente e
a exposição das chaves pode ter permitido o acesso a informação sensível. Devido
ao registo de eventos insuficiente, a empresa não foi capaz de averiguar que
informação havia sido acedida por agentes mal intencionados.

### Cenário #2

Uma plataforma de partilha de vídeo foi alvo um ataque de _credendial stuffing_
em larga escala. Apesar das tentativas de autenticação falhadas serem constarem
do registo de eventos, nenhum alerta foi gerado durante o tempo que o ataque
decorreu. Em reação às queixas dos utilizadores os registos de eventos da API
foram analisados e o ataque foi identificado. A empresa teve que emitir um
comunicado público a pedir aos utilizadores para alterar as suas _passwords_ e
comunicar o incidente às autoridades reguladores.

## Como Prevenir

* Registe todas as tentativas de autenticação falhadas, controlo de acesso
  negados e falhas na validação de dados fornecidos pelo utilizador.
* Os registos de eventos devem usar um formato que permita serem processados por
  ferramentas de gestão de registos e devem incluir detalhe suficiente para
  identificar os agentes maliciosos.
* Os registos de eventos deve ser tratados como informação sensível e a sua
  integridade deve ser assegurada tanto em repouso como em trânsito.
* Configure um sistema de monitorização para a infraestrutura, rede e API.
* Utilize um Sistema de Gestão e Correlação de Eventos de Segurança (SIEM) para
  agregar e gerir os registos de eventos de todos os componentes da API e
  _hosts_.
* Configure visualizações personalizadas sobre os alertas, permitindo que
  atividade suspeita seja detetada e endereçada o mais cedo possível.

## Referências

### OWASP

* [OWASP Logging Cheat Sheet][2]
* [OWASP Proactive Controls: Implement Logging and Intrusion Detection][3]
* [OWASP Application Security Verification Standard: V7: Error Handling and
  Logging Verification Requirements][4]

### Externas

* [CWE-223: Omission of Security-relevant Information][5]
* [CWE-778: Insufficient Logging][6]

[1]: https://owasp.org/www-community/attacks/Log_Injection
[2]: https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Logging_Cheat_Sheet.md
[3]: https://owasp.org/www-project-proactive-controls/
[4]: https://github.com/OWASP/ASVS/blob/master/4.0/en/0x15-V7-Error-Logging.md
[5]: https://cwe.mitre.org/data/definitions/223.html
[6]: https://cwe.mitre.org/data/definitions/778.html
