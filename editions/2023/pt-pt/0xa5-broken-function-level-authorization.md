# API5:2023 Broken Function Level Authorization

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **Fácil** | Prevalência **Comum** : Deteção **Fácil** | Técnico **Grave** : Específico Negócio |
| Para abusar deste tipo de falha o atacante tem de realizar pedidos legítimos ao _endpoint_ da API ao qual não é suposto ter acesso como utilizadores anónimos, ordinários ou não privilegiados. _Endpoints_ expostos serão facilmente explorados. | As verificações de autorização para aceder a uma determinada função ou recurso são normalmente geridas por configuração ou ao nível da implementação. A correta implementação destes mecanismos pode tornar-se confusa, uma vez que, as aplicações modernas prevêem vários perfis ou grupos de utilizador, assim como complexos esquemas de hierarquias (e.g. sub-utilizadores, utilizadores com mais do que um perfil). É mais fácil descobrir estas falhas em APIs dado que APIs são mais estruturadas, e aceder a diferentes funções é mais previsível. | Estas falhas permitem aos atacantes aceder de forma não autorizada a certas funcionalidades. As funcionalidades administrativas são o alvo preferencial neste tipo de ataqueo que pode levar a divulgação de dados, perda de dados, ou corrupção de dados. Por último, pode dar aso a uma disrupção de serviço. |

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

Durante o processo de registo para uma aplicação que permite apenas a adesão 
de utilizadores convidados, a aplicação móvel faz uma chamada de API para 
`GET /api/invites/{invite_guid}`. A resposta contém um JSON com detalhes sobre 
o convite, incluindo o perfil do utilizador e o email do utilizador.

Um atacante duplica o pedido e manipula o método HTTP e o _endpoint_ para 
`POST /api/invites/new`. Este _endpoint_ deveria ser usado apenas por 
administradores através da consola de administração. O _endpoint_ não implementa 
verificações de autorização de acesso à função.

O atacante explora a falha e envia um novo convite com privilégios de 
administrador:

```
POST /api/invites/new

{
  "email": "attacker@somehost.com",
  "role":"admin"
}
```

Mais tarde, o atacante usa o convite criado maliciosamente para criar uma conta 
de administrador e obter acesso total ao sistema.

### Cenário #2

Uma API contém um _endpoint_ que deveria ser exposto apenas a administradores - 
`GET /api/admin/v1/users/all`. Este _endpoint_ retorna os detalhes de todos os 
utilizadores da aplicação e não implementa verificações de autorização de acesso 
à função. Um atacante que aprendeu sobre a estrutura da API faz uma suposição 
informada e consegue aceder a este _endpoint_, expondo detalhes sensíveis dos 
utilizadores da aplicação.

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
* Assegurar que todos os controladores administrativos herdam de um controlador
  administrativo base que implementa as verificações de autorização com base no
  grupo/perfil do utilizador.
* Assegurar que funções administrativas num controlador ordinário implementam
  elas próprias as verificações de autorização baseadas no grupo e perfil do
  utilizador.

## Referências

### OWASP

* [Forced Browsing][1]
* "A7: Missing Function Level Access Control", [OWASP Top 10 2013][2]
* [Access Control][3]

### Externas

* [CWE-285: Improper Authorization][4]

[1]: https://owasp.org/www-community/attacks/Forced_browsing
[2]: https://github.com/OWASP/Top10/raw/master/2013/OWASP%20Top%2010%20-%202013.pdf
[3]: https://owasp.org/www-community/Access_Control
[4]: https://cwe.mitre.org/data/definitions/285.html
