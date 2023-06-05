# API1:2019 Broken Object Level Authorization

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **3** | Prevalência **3** : Deteção **2** | Técnico **3** : Específico do Negócio |
| Os atacantes podem abusar dos _endpoints_ vulneráveis da API através da manipulação do identificador dum objeto que é enviado como parte do pedido. Isto pode conduzir ao acesso não autorizado a informação sensível. Este problema é extremamente comum porque os componentes do servidor normalmente não mantém o estado do cliente, baseando-se essencialmente em parâmetros tais como o identificador do objeto que é enviado para decidir qual o objeto a aceder. | Este tem sido o ataque mais comum e com maior impacto em APIs. Os mecanismos de autorização e controlo de acessos em aplicações modernas são complexos e abrangentes. Ainda que a aplicação implemente uma infraestrutura adequada para validação de autorização, os programadores podem esquecer-se de a realizar antes de aceder a informação sensível. A identificação de problemas no controlo de acessos não é de fácil deteção através de análise estática ou dinâmica. | Acesso não autorizado pode resultar na divulgação de informação a entidades não autorizadas, perda ou manipulação de dados. O acesso não autorizado a objetos pode ainda conduzir à usurpação de contas de utilizador. |

## A API é vulnerável?

A autorização de acesso ao nível do objeto é um mecanismo de controlo
tipicamente implementado ao nível do código para validar que um utilizador só
pode aceder aos objetos aos quais tem acesso.

Todos os _endpoints_ duma API que recebem identificadores de objetos e que
executam algum tipo de ação sobre os mesmos, devem implementar verificações de
autorização a esse nível. A verificação de acesso deve validar que o utilizador
com a sessão ativa tem permissão para realizar a ação solicitada sobre o objeto
em questão.

Falhas neste mecanismo tipicamente conduzem à divulgação não autorizada de
informação, modificação ou destruição de todos os dados.

## Exemplos de Cenários de Ataque

### Cenário #1

Uma plataforma de comércio eletrónico para criar lojas online oferece uma página
de listagem com gráficos relativos à receita das lojas. Inspecionando os pedidos
realizados pelo navegador um atacante identifica os _endpoints_ da API usados
para obter os dados a partir dos quais são gerados os gráficos bem como o seu
padrão `/shops/{shopName}/revenue_data.json`. Utilizado outro _endpoint_ da API
o atacante obtém a lista com o nome de todas as lojas. Com recurso a um _script_
simples para substituir `{shopName}` no URL pelos nomes que constam da lista, o
atacante consegue acesso aos dados relativos às vendas de milhares de lojas
online.

### Cenário #2

Monitorizando o tráfego de rede dum dispositivo _wearable_, o pedido HTTP
`PATCH` capta a atenção dum atacante devido à utilização do cabeçalho
não-standard `X-User-ID: 54796`.

Substituindo o valor do cabeçalho `X-User-Id` por `54795` o atacante recebe uma
resposta afirmativa, conseguindo manipular os dados da conta doutro utilizador.

## Como Prevenir

* Implementar um mecanismo de autorização baseado nas políticas de utilizador e
  hierarquia.
* Utilizar um mecanismo de autorização para verificar se o utilizador com sessão
  ativa tem permissão para realizar a ação pretendida sobre o registo. Esta
  verificação deve ser feita por todas as funções que utilizem informação
  fornecida pelo cliente para aceder a um registo na base de dados.
* Utilizar preferencialmente valores aleatórios e não previsíveis (e.g., GUID)
  como identificador para os registos.
* Escrever testes para avaliar o correto funcionamento do mecanismo de
  autorização. Não colocar em produção alterações vulneráveis que não passem nos
  testes.

## Referências

### Externas

* [CWE-284: Improper Access Control][1]
* [CWE-285: Improper Authorization][2]
* [CWE-639: Authorization Bypass Through User-Controlled Key][3]

[1]: https://cwe.mitre.org/data/definitions/284.html
[2]: https://cwe.mitre.org/data/definitions/285.html
[3]: https://cwe.mitre.org/data/definitions/639.html
