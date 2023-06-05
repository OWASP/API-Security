# API2:2019 Broken User Authentication

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **3** | Prevalência **2** : Deteção **2** | Técnico **3** : Específico Negócio |
| A autenticação em APIs é um mecanismo complexo e confuso. Engenheiros de software e segurança podem ter conceções erradas com relação ao âmbito da autenticação e como implementá-la corretamente. Por outro lado os mecanismos de autenticação são um alvo fácil para os atacantes uma vez que estão expostos publicamente. Estes dois pontos tornam o componente responsável pela autenticação potencialmente vulnerável a diferentes tipos de abuso. | Podemos dividir os problemas de autenticação em duas partes: 1. Falta de mecanismos de proteção: os _endpoints_ responsáveis pela autenticação devem ser tratados de forma diferente dos demais _endpoints_, implementando camadas de proteção adicionais 2. Falhas na implementação do mecanismo: este é utilizado/implementado sem considerar os vetores de ataque específicos ou baseado em casos de uso desadequados (e.g., um mecanismo de autenticação desenhado para clientes IoT pode não ser a melhor escolha para aplicações web). | Os atacantes podem obter o controlo sobre as contas doutros utilizadores, aceder aos seus dados pessoais e realizar ações sensíveis em seu nome, como por exemplo transferências financeiras ou envio de mensagens pessoais. |

## A API é vulnerável?

Os _endpoints_ e fluxos de autenticação são ativos que carecem de proteção.
Mecanismos de recuperação de _password_ devem ser tratados da mesma forma que os
mecanismos de autenticação.

Uma API é vulnerável se:
* Permite ataques de [_credential stuffing_][1] em que o atacante tem uma lista de
  nomes de utilizador e _passwords_ válidos.
* Permite ataques de força bruta a uma conta de utilizador específica, não
  implementando mecanismos de mitigação como _captcha_ ou bloqueio da conta por
  excesso de tentativas de autenticação falhadas.
* Permite a utilização de _passwords_ fracas.
* Envia informação de autenticação, tal como _tokens_ e _passwords_, no URL.
* Não valida a autenticidade dos _tokens_ de autenticação.
* Aceita _tokens_ JWT sem que estes sejam assinados/usando algoritmos fracos
  `("alg":"none")` ou não valida a sua data de expiração.
* Utiliza _passwords_ em texto, não encriptadas, ou resumos fracos.
* Utiliza chaves de encriptação fracas.

## Exemplos de Cenários de Ataque

### Cenário #1

Ataques de [_Credential Stuffing_][1] utilizando [listas de nomes de utilizador/
_passwords_ conhecidas][2] são bastante comuns. Se uma API não implementa
proteções contra ameaças automatizadas ou Credential Stuffing, esta pode ser
usada como oráculo para identificar se as credenciais são válidas.

### Cenário #2

Um atacante inicia o fluxo de recuperação de _password_, enviando um pedido
`POST` com o nome de utilizador para o _endpoint_
`/api/system/verification-codes`. Um código de 6 dígitos é enviado para o
telefone da vítima. Porque a API não implementa uma política de limitação do
número de pedidos, com recurso a um _script multi-thread_ que envia as
combinações possíveis para o _endpoint_
`/api/system/verification-codes/{smsToken}`, o atacante consegue em poucos
minutos descobrir o código enviado na SMS.

## Como Prevenir

* Certifique-se de que conhece todos os fluxos de autenticação possíveis (e.g.
  móvel/web/_deeplinks_/etc.).
* Pergunte aos engenheiros responsáveis quais os fluxos em falta/não
  identificados.
* Leia sobre os mecanismos de autenticação em uso. Certifique-se que compreende
  quais e como são usados. OAuth não é um mecanismo de autenticação, assim como
  também não o são as API _keys_.
* Não reinvente a roda em termos de autenticação, geração de _tokens_,
  armazenamento de _passwords_. Opte pela utilização de standards.
* _Endpoints_ para recuperação de _password_ devem ser tratados como os
  _endpoints_ de _login_ no que diz respeito à proteção contra ataques de força
  bruta, limitação do número de pedidos e bloqueio de conta.
* Utilize a  [OWASP Authentication Cheatsheet][3].
* Sempre que possível implemente autenticação de múltiplos fatores.
* Implemente mecanismos anti-força bruta para mitigar ataques do tipo
  _credential stuffing_, dicionário e força bruta nos _endpoints_ de
  autenticação. Este mecanismo deve ter configurações mais restritivas do que
  para os demais _endpoints_ da API.
* Implemente [mecanismos de bloqueio de conta][4] / _captcha_ para prevenir
  ataques de força bruta contra utilizadores específicos. Implemente verificação
  da qualidade/força das _passwords_.
* As API _keys_ não devem ser usadas para autenticação dos utilizadores, mas ao
  invés para [autenticação dos clientes da API][5].

## Referências

### OWASP

* [OWASP Key Management Cheat Sheet][6]
* [OWASP Authentication Cheatsheet][3]
* [Credential Stuffing][1]

### Externas

* [CWE-798: Use of Hard-coded Credentials][7]

[1]: https://owasp.org/www-community/attacks/Credential_stuffing
[2]: https://github.com/danielmiessler/SecLists
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[4]: https://github.com/OWASP/wstg/blob/master/document/4-Web_Application_Security_Testing/04-Authentication_Testing/03-Testing_for_Weak_Lock_Out_Mechanism.md
[5]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[6]: https://cheatsheetseries.owasp.org/cheatsheets/Key_Management_Cheat_Sheet.html
[7]: https://cwe.mitre.org/data/definitions/798.html
