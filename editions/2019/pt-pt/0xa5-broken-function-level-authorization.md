# API5:2019 Broken Function Level Authorization

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **3** | Prevalência **2** : Deteção **1** | Técnico **2** : Específico Negócio |
| Para abusar deste tipo de falha o atacante tem de realizar pedidos legítimos ao _endpoint_ da API ao qual não é suposto ter acesso. Estes _endpoints_ podem estar disponíveis para utilizadores anónimos, ordinários ou não privilegiados. É fácil identificar estas falhas em APIs uma vez que  estas são mais estruturada, sendo a forma de acesso a certas funcionalidades mais previsível (e.g., utilizar o método HTTP `PUT` ao invés de `GET` ou substituir a palavra "user" por "admin" no URL). | As verificações de autorização para aceder a uma determinada função ou recurso são normalmente geridas por configuração e às vezes ao nível da implementação. A correta implementação destes mecanismos pode tornar-se confusa, uma vez que, as aplicações modernas prevêem vários perfis ou grupos de utilizador, assim como complexos esquemas de hierarquia (e.g., sub-utilizadores, utilizadores com mais do que um perfil). | Estas falhas permitem aos atacantes aceder de forma não autorizada a certas funcionalidades. As funcionalidades administrativas são o alvo preferencial neste tipo de ataque. |

## A API é vulnerável?

A melhor forma de identificar falhas de verificação de autorização de acesso a
funções é através duma análise detalhada do mecanismo de autorização, devendo
ter-se em consideração o esquema de hierarquia de utilizadores, diferentes
perfis ou grupos e questionando continuamente:

* Utilizadores ordinários podem aceder aos _endpoints_ de administração?
* Os utilizadores podem realizar ações sensíveis (e.g. criar, modificar ou
  apagar) para as quais não deveriam ter acesso, alterando simplesmente o método
  HTTP (e.g. alterando de `GET` para `DELETE`)?
* Um utilizador do grupo X pode aceder a uma função reservada ao grupo Y,
  adivinhando o URL do _endpoint_ e os parâmetros (e.g.
  `/api/v1/users/export_all`)?

Nunca assuma o tipo dum _endpoint_, normal ou administrativo, apenas com base no
URL.

Apesar dos programadores poderem ter decidido expor a maioria dos _endpoints_
administrativos sob um mesmo prefixo, e.g. `api/admins`, é comum encontrarem-se
_endpoints_ administrativos sob outros prefixos, misturados com _endpoints_
ordinários e.g. `api/users`.

## Exemplos de Cenários de Ataque

### Cenário #1

Durante o processo de registo numa aplicação que apenas permite o registo de
utilizadores por convite, é realizado um pedido `GET` ao _endpoint_
`/api/invites/{invite_guid}`. A resposta em formato JSON contém detalhes sobre o
convite, incluindo o perfil de utilizador e o seu endereço de email.
Um atacante duplica o pedido e altera o método HTTP e o _endpoint_ do medido
para `POST /api/invites/new`. Esta funcionalidade deveria estar apenas
disponível para administradores através da consola de administração, uma vez que
o _endpoint_ não implementa verificações de autorização de acesso à função.

O atacante abusa da falha e envia para si próprio um convite para criar uma
conta de administrador:

```
POST /api/invites/new

{“email”:”hugo@malicious.com”,”role”:”admin”}
```

### Cenário #2

Uma API implementa um _endpoint_ que é suposto estar apenas disponível para
administradores - `GET /api/admin/v1/users/all`. Este _endpoint_ devolve os
detalhes de todos os utilizadores da aplicação e não realiza qualquer
verificação de autorização de acesso à função. Com base no conhecimento
adquirido sobre a estrutura da API um atacante consegue prever com um elevado
grau de certeza o URL do _endpoint_, ganhado acesso ao dados sensíveis de todos
os utilizadores da aplicação.

## Como Prevenir

A sua API deve usar um módulo de autorização consistente e fácil de analisar, o
qual deve ser invocado por todas as funções de negócio. Frequentemente, este
tipo de proteção é oferecido por um ou mais componentes externos à lógica
aplicacional.

* Por omissão todos os acesso devem ser negados, exigindo que permissões
  específicas sejam concedidas a perfis específicos para acesso a cada função.
* Rever todos os _endpoints_ à procura de falhas ao nível da verificação de
  autorização de acesso a funções, tendo sempre em consideração a lógica de
  negócio da aplicação e hierarquia dos grupos.
* Assegurar que todos os controladores administrativos herdam dum controlador
  administrativo base que implementa as verificações de autorização com base no
  grupo/perfil do utilizador.
* Assegurar que funções administrativas num controlador ordinário implementam
  elas próprias as verificações de autorização baseadas no grupo e perfil do
  utilizador.

## Referências

### OWASP

* [OWASP Article on Forced Browsing][1]
* [OWASP Top 10 2013-A7-Missing Function Level Access Control][2]
* [OWASP Development Guide: Chapter on Authorization][3]

### Externas

* [CWE-285: Improper Authorization][4]

[1]: https://owasp.org/www-community/attacks/Forced_browsing
[2]: https://www.owasp.org/index.php/Top_10_2013-A7-Missing_Function_Level_Access_Control
[3]: https://owasp.org/www-community/Access_Control
[4]: https://cwe.mitre.org/data/definitions/285.html
