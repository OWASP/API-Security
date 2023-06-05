# API10:2019 Insufficient Logging & Monitoring

| Agentes/Vetores | Fraquezas de Segurança | Impactos |
| - | - | - |
| Específico da API : Explorabilidade **2** | Prevalência **3** : Detecção **1** | Técnico **2** : Específico do negócio |
| Atacantes podem tirar proveito de pouco log e monitoramento para abusar de sistemas sem serem notados. | Sem log e monitoramento, ou log e monitoramento insuficiente, é quase impossível rastrear atividades suspeitas e dar respostas à elas tem tempo hábil. | Sem visibilidade do que está ocorrendo de atividades maliciosas, atacantes possuem tempo para comprometer completamente sistemas. |

## A API está vulnerável?

A API está vulnerável se:

* Não produz qualquer tipo de log, ou se o nível de log não é configurado adequadamente, ou ainda, se as mensagens de log não incluem informações suficientes.
* A integridade do log não é garantida (Ex.: [Injeção de log][1]).
* Logs não estão em contínuo monitoramento.
* A infraestrutura da API não é continuamente monitorada.

## Cenários de exemplo de ataques

### Cenário #1

Chaves de acesso de administração da API são vazados em um repositório público. O proprietário do repositório é notificado por e-mail a respeito do provável vazamento, mas, até que uma ação seja realizada em reposta ao incidente se passaram 48 horas. Em razão de logs insuficientes, a companhia não é capaz de identificar quais informações foram acessadas durante o período por atores maliciosos.

### Cenário #2

Uma plataforma de compartilhamento de vídeos foi atingida por um ataque de *credential stuffing* de larga escala. Mesmo com os logins que falharam sendo logados, não houveram alertas disparados durante o tempo de duração do ataque. Como uma resposta à reclamação dos usuários, os logs de API foram analisados e o ataque foi detectado. A companhia fez um anúncio público solicitando aos seus usuários que façam atualização de suas senhas, e reportam o incidente às autoridades regulatórias.

## Como prevenir

* Faça log de todas tentativas de logon mal sucedidas, acessos negados e erros de validação de entradas de usuários.
* Logs devem ser escritos em um formato apropriado para serem consumidos  por soluções de gerenciamento de logs, e devem incluir detalhes suficientes para ajudar a identificar o ator malicioso.
* Logs devem ser manipulados como dados sensíveis, e sua integridade deve ser garantida tanto em trânsito como em repouso.
* Configure o sistema de monitoramento a monitorar continuamente a infraestrutura, rede e o funcionamento da API.
* Utilize um SIEM (*Security Information and Event Management*) para agregar e gerenciar logs oriundos de todos componentes da arquitetura da API e seus *hosts*.
* Configure painéis de controle e alertas, possibilitando de atividades suspeitas sejam detectadas e respondidas de forma breve.

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
[2]: https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html
[3]: https://owasp.org/www-project-proactive-controls/
[4]: https://github.com/OWASP/ASVS/blob/master/4.0/en/0x15-V7-Error-Logging.md
[5]: https://cwe.mitre.org/data/definitions/223.html
[6]: https://cwe.mitre.org/data/definitions/778.html
