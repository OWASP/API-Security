# API5:2019 Broken Function Level Authorization

| Agentes/Vetores | Fraquezas de Segurança | Impactos |
| - | - | - |
| Específico da API : Explorabilidade **3** | Prevalência **2** : Detecção **1** | Técnico **2** : Específico do negócio |
| A exploração requer que o atacante envie chamadas legítimas ao *endpoint* da API ao qual não deveria ter acesso. Estes *endpoints* estão expostos para usuários anônimos ou à usuários regulares e/ou não privilegiados. É fácil encontrar estas falhas uma vez que APIs melhor estruturadas possuem funções mais previsíveis (ex. modificando métodos HTTPS de GET para PUT ou mudando a URL de "users" para "admins"). | Verificações de autorização para uma função ou recurso geralmente são gerenciadas por configuração e em alguns casos a nível de código. Implementar verificações apropriadas pode ser uma tarefa confusa, uma vez que aplicativos modernos podem conter muitos tipos de papéis ou grupos e ainda uma complexa hierarquia de usuários (ex.: sub-usuários, usuários com mais de um papel). | Este tipo de falha pode permitir que atacantes tenham acesso a funções não autorizadas. Funções administrativas geralmente são os alvos deste tipo de ataque. |

## A API está vulnerável?

A melhor maneira de encontrar quebras de função e autorização é executar uma profunda análise do mecanismo de autorização, ao mesmo tempo mantendo em mente a hierarquia de usuário, diferentes papéis ou grupos da aplicação e perguntando-se as seguintes questões:

* Pode um usuário regular acessar *endpoints* administrativos?
* Pode um usuário executar ações sensíveis (ex.: criação, modificação ou exclusão), mesmo apenas alterando o método HTTP (ex.: trocando `GET` para `DELETE`)?
* Pode um usuário do grupo de acesso X acessar uma função que deve ser acessível apenas para usuários do grupo Y apenas adivinhando a URL (ex.:  `/api/v1/users/export_all`)?

Nunca considere apenas a URL como separação de *endpoints* regulares e administrativas.

Uma vez que desenvolvedores podem optar pela exposição de *endpoints* administrativos por um determinado caminho como `api/admins`, também é muito comum encontrar endpoints administrativos em caminhos similares como `api/users`.

## Cenários de exemplo de ataques

### Cenário #1

Durante o processo de registro de uma aplicação que permite apenas usuários convidados se cadastrarem, o aplicativo móvel realiza uma chamada de API para `GET /api/invites/{invite_guid}`. A resposta no formato JSON contém os detalhes sobre o convite, incluindo o papel e endereço de e-mail do usuário.

Um atacante duplica a requisição e, modifica o método HTTP e o *endpoint* para `POST /api/invites/new`. Este *endpoint* deveria ser acessível apenas por administradores utilizando a console administrativa, que não implementa uma autorização de nível de função.

O atacante então explora este problema enviando a si mesmo um convite para criar uma conta administrativa:

```
POST /api/invites/new

{“email”:”hugo@malicious.com”,”role”:”admin”}
```

### Cenário #2

Uma API contém um *endpoint* que deveria estar exposta apenas para administradores: `GET /api/admin/v1/users/all`. Este *endpoint* retorna detalhes sobre todos os usuários e não implementa uma verificação de nível de função. Um atacante que estudou a estrutura da API e consegue encontrar este *endpoint* que expõe detalhes de todos os usuários da aplicação.

## Como prevenir

Sua aplicação deve possuir um consistente módulo de autorização a ser invocado por todas suas funções. Frequentemente este tipo de proteção é provida por um ou mais componentes externos ao código da aplicação.

* O mecanismo de verificação deve negar tudo por padrão, requerendo permissões explícitas para papéis de cada função.
* Revise seus *endpoints* de API para validar falhas de autorização, enquanto mantém em mente a lógica de negócio da aplicação e hierarquia de grupos.
* Certifique-se que todos seus controles administrativos sejam herdados por um *controller* de abstração que implemente as verificações de autorização.
* Tenha certeza que funções administrativas dentro de *controllers* regulares implementem verificação de autorização baseado no usuário, grupos e papéis.

## Referências

### OWASP

* [OWASP Article on Forced Browsing][1]
* [OWASP Top 10 2013-A7-Missing Function Level Access Control][2]
* [OWASP Development Guide: Chapter on Authorization][3]

### Externas

* [CWE-285: Improper Authorization][4]

[1]: https://www.owasp.org/index.php/Forced_browsing
[2]: https://www.owasp.org/index.php/Top_10_2013-A7-Missing_Function_Level_Access_Control
[3]: https://cheatsheetseries.owasp.org/cheatsheets/Access_Control_Cheat_Sheet.html
[4]: https://cwe.mitre.org/data/definitions/285.html
