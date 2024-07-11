# API1:2023 Broken Object Level Authorization

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **Fácil** | Prevalência **Predominante** : Deteção **Fácil** | Técnico **Moderado** : Específico do Negócio |
| Os atacantes podem explorar *endpoints* de API vulneráveis a *broken object-level authorization* ao manipular o ID de um objeto enviado no pedido. Os IDs de objetos podem ser números inteiros sequenciais, UUIDs ou *strings* genéricas. Independentemente do tipo de dado, são fáceis de identificar no alvo do pedido (parâmetros do caminho ou da *string* de consulta), cabeçalhos do pedido ou até mesmo como parte do conteúdo do pedido. | Este problema é extremamente comum em aplicações baseadas em API porque o componente do servidor geralmente não acompanha completamente o estado do cliente e, em vez disso, confia mais em parâmetros como IDs de objetos, que são enviados pelo cliente para decidir a quais objetos aceder. A resposta do servidor geralmente é suficiente para entender se o pedido foi bem sucedido. | O acesso não autorizado a objetos de outros utilizadores pode resultar na divulgação de dados a partes não autorizadas, perda de dados ou manipulação de dados. Em certas circunstâncias, o acesso não autorizado a objetos também pode resultar na apropriação completa da conta. |

## A API é vulnerável?

A autorização de acesso ao nível do objeto é um mecanismo de controlo que 
geralmente é implementado ao nível do código para validar que um utilizador só 
pode aceder aos objetos aos quais deveria ter permissão para aceder.

Cada *endpoint* de API que recebe um ID de um objeto e realiza alguma ação sobre
o objeto deve implementar verificações de autorização ao nível do objeto. As 
verificações devem validar que o utilizador autenticado tem permissões para 
realizar a ação solicitada sobre o objeto alvo.

As falhas neste mecanismo geralmente conduzem à divulgação não autorizada de 
informações, modificação ou destruição de todos os dados.

Comparar o ID do utilizador da sessão atual (e.g. ao extraí-lo do token JWT) com
o parâmetro de ID vulnerável não é uma solução suficiente para resolver a falha 
de Broken Object Level Authorization (BOLA). Esta abordagem pode endereçar 
apenas um pequeno subconjunto de casos.

No caso de BOLA, é por design que o utilizador tem acesso ao *endpoint*/função 
da API vulnerável. A violação ocorre ao nível do objeto, através da manipulação 
do ID. Se um atacante conseguir aceder a um *endpoint*/função da API ao qual não
deveria ter acesso - este é um caso de [Broken Function Level Authorization][5] 
(BFLA) em vez de BOLA.

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

Um fabricante de automóveis habilitou o controlo remoto dos seus veículos 
através de uma API para comunicação com o telemóvel do condutor. A API permite 
ao condutor iniciar e parar o motor e trancar e destrancar as portas 
remotamente. Como parte deste processo, o utilizador envia o Número de 
Identificação do Veículo (VIN) para a API. No entanto, a API não valida se o VIN 
representa um veículo que pertence ao utilizador autenticado, o que resulta numa 
vulnerabilidade de BOLA. Um atacante pode aceder a veículos que não lhe 
pertencem.

### Cenário #3

Um serviço de armazenamento de documentos online permite aos utilizadores 
visualizar, editar, armazenar e eliminar os seus documentos. Quando um documento 
de um utilizador é eliminado, é enviada uma mutação GraphQL com o ID do 
documento para a API.

```
POST /graphql
{
  "operationName":"deleteReports",
  "variables":{
    "reportKeys":["<DOCUMENT_ID>"]
  },
  "query":"mutation deleteReports($siteId: ID!, $reportKeys: [String]!) {
    {
      deleteReports(reportKeys: $reportKeys)
    }
  }"
}
```

Uma vez que o documento com o ID fornecido é eliminado sem quaisquer 
verificações adicionais de permissão, um utilizador pode conseguir eliminar o 
documento de outro utilizador.

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

### OWASP

* [Authorization Cheat Sheet][1]
* [Authorization Testing Automation Cheat Sheet][2]

### Externas

* [CWE-285: Improper Authorization][3]
* [CWE-639: Authorization Bypass Through User-Controlled Key][4]

[1]: https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html
[2]: https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Testing_Automation_Cheat_Sheet.html
[3]: https://cwe.mitre.org/data/definitions/285.html
[4]: https://cwe.mitre.org/data/definitions/639.html
[5]: ./0xa5-broken-function-level-authorization.md
