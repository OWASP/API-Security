# API2:2023 Broken Authentication

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **Fácil** | Prevalência **Comum** : Deteção **Fácil** | Técnico **Grave** : Específico Negócio |
| O mecanismo de autenticação é um alvo fácil para os atacantes, uma vez que está exposto a todos. Embora possam ser necessárias competências técnicas mais avançadas para explorar alguns problemas de autenticação, geralmente existem ferramentas de exploração disponíveis. | As conceções erradas dos engenheiros de software e de segurança sobre os limites da autenticação e a complexidade inerente da implementação tornam os problemas de autenticação prevalentes. Metodologias para detetar *broken authentication* estão disponíveis e são fáceis de criar. | Os atacantes podem obter controlo total das contas de outros utilizadores no sistema, ler os seus dados pessoais e realizar ações sensíveis em seu nome. Os sistemas têm pouca probabilidade de conseguir distinguir as ações dos atacantes das ações legítimas dos utilizadores. |

## A API é vulnerável?

Os _endpoints_ e fluxos de autenticação são ativos que carecem de proteção. Além 
disso, mecanismos de recuperação de _password_ devem ser tratados da mesma forma 
que os mecanismos de autenticação.

Uma API é vulnerável se:

* Permite ataques de _credential stuffing_, onde o atacante utiliza força bruta
  com uma lista de nomes de utilizador e palavras-passe válidos.
* Permite ataques de força bruta a uma conta de utilizador específica, não
  implementando mecanismos de mitigação como _captcha_ ou bloqueio da conta por
  excesso de tentativas de autenticação falhadas.
* Permite a utilização de _passwords_ fracas.
* Envia informação de autenticação, tal como _tokens_ e _passwords_, no URL.
* Permite que os utilizadores alterem o seu endereço de email, _password_ atual 
  ou realizem outras operações sensíveis sem pedir a confirmação da _password_.
* Não valida a autenticidade dos _tokens_ de autenticação.
* Aceita _tokens_ JWT sem que estes sejam assinados/usando algoritmos fracos
  `("alg":"none")`
* Não valida a data de expiração dos _tokens_ JWT.
* Utiliza _passwords_ em texto, não encriptadas, ou resumos fracos.
* Utiliza chaves de encriptação fracas.

Além disso, um microsserviço é vulnerável se:

* Outros microsserviços podem aceder a ele sem autenticação
* Utiliza tokens fracos ou previsíveis para impor autenticação

## Exemplos de Cenários de Ataque

## Cenário #1

Para realizar a autenticação do utilizador, o cliente tem de enviar um pedido de 
API como o exemplo abaixo, com as credenciais do utilizador:

```
POST /graphql
{
  "query":"mutation {
    login (username:\"<username>\",password:\"<password>\") {
      token
    }
   }"
}
```

Se as credenciais forem válidas, é devolvido um token de autenticação que deve 
ser fornecido em pedidos subsequentes para identificar o utilizador. A 
quantidade de tentativas de login está sujeita a uma limitação temporal 
restritiva: apenas três pedidos são permitidos por minuto.

Para efetuar login por força bruta com a conta de uma vítima, os atores 
maliciosos aproveitam o agrupamento de consultas GraphQL para contornar a 
limitação temporal restritiva de pedidos, acelerando o ataque:

```
POST /graphql
[
  {"query":"mutation{login(username:\"victim\",password:\"password\"){token}}"},
  {"query":"mutation{login(username:\"victim\",password:\"123456\"){token}}"},
  {"query":"mutation{login(username:\"victim\",password:\"qwerty\"){token}}"},
  ...
  {"query":"mutation{login(username:\"victim\",password:\"123\"){token}}"},
]
```

## Cenário #2

Para atualizar o endereço de email associado à conta de um utilizador, os 
clientes devem enviar um pedido API como o exemplo abaixo:

```
PUT /account
Authorization: Bearer <token>

{ "email": "<new_email_address>" }
```

Devido à API não exigir que os utilizadores confirmem a sua identidade 
fornecendo a sua _password_ atual, atores maliciosos que consigam colocar-se 
numa posição de roubar o token de autenticação podem conseguir assumir a conta 
da vítima ao iniciar o processo de redefinição de senha após atualizar o 
endereço de email da conta da vítima.

## Como Prevenir

* Certifique-se de que conhece todos os fluxos de autenticação possíveis (e.g.
  móvel/web/_deeplinks_/etc.). Pergunte aos engenheiros responsáveis quais os
  fluxos em falta/não identificados.
* Leia sobre os mecanismos de autenticação em uso. Certifique-se que compreende
  quais e como são usados. OAuth não é um mecanismo de autenticação, assim como
  também não o são as API _keys_.
* Não reinvente a roda em termos de autenticação, geração de _tokens_,
  armazenamento de _passwords_. Opte pela utilização de standards.
* _Endpoints_ para recuperação de _password_ devem ser tratados como os
  _endpoints_ de _login_ no que diz respeito à proteção contra ataques de força
  bruta, limitação do número de pedidos e bloqueio de conta.
* Exija nova autenticação para operações sensíveis (e.g. alterar o
  endereço de email do proprietário da conta/número de telefone para
  autenticação de dois fatores).
* Utilize a [OWASP Authentication Cheatsheet][1].
* Sempre que possível implemente autenticação de múltiplos fatores.
* Implemente mecanismos anti-força bruta para mitigar ataques do tipo
  _credential stuffing_, dicionário e força bruta nos _endpoints_ de
  autenticação. Este mecanismo deve ter configurações mais restritivas do que
  para os demais _endpoints_ da API.
* Implemente [mecanismos de bloqueio de conta][2] / _captcha_ para prevenir
  ataques de força bruta contra utilizadores específicos. Implemente verificação
  da qualidade/força das _passwords_.
* As API _keys_ não devem ser usadas para autenticação dos utilizadores. Apenas
  devem ser usadas para autenticação dos [clientes da API][3].

## Referências

### OWASP

* [Authentication Cheat Sheet][1]
* [Key Management Cheat Sheet][4]
* [Credential Stuffing][5]

### Externas

* [CWE-204: Observable Response Discrepancy][6]
* [CWE-307: Improper Restriction of Excessive Authentication Attempts][7]

[1]: https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
[2]: https://owasp.org/www-project-web-security-testing-guide/latest/4-Web_Application_Security_Testing/04-Authentication_Testing/03-Testing_for_Weak_Lock_Out_Mechanism(OTG-AUTHN-003)
[3]: https://cloud.google.com/endpoints/docs/openapi/when-why-api-key
[4]: https://cheatsheetseries.owasp.org/cheatsheets/Key_Management_Cheat_Sheet.html
[5]: https://owasp.org/www-community/attacks/Credential_stuffing
[6]: https://cwe.mitre.org/data/definitions/204.html
[7]: https://cwe.mitre.org/data/definitions/307.html
