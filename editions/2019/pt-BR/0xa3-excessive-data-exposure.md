# API3:2019 Excessive Data Exposure

| Agentes/Vetores | Fraquezas de Segurança | Impactos |
| - | - | - |
| Específico da API : Explorabilidade **3** | Prevalência **2** : Detecção **2** | Técnico **2** : Específico do negócio |
| A exploração por excesso de exposição de dados é simples, e usualmente realizada com o monitoramento do tráfego investigando as respostas da API, buscando dados sensíveis que não deveriam ser entregues ao usuário. | APIs confiam em clientes para ações de filtro de informação. Desde que APIs são utilizadas como fonte de informações, algumas vezes os desenvolvedores as implementam de maneira genérica sem considerar o quão sensíveis são os dados que elas expõem. Ferramentas de análise automatizada geralmente não podem detectar este tipo de vulnerabilidade em razão de ser difícil da legitimidade dos dados retornados pela API, e dados considerados sensíveis não devem ser retornado sem uma profunda análise e compreensão da aplicação. | Excesso de exposição de dados geralmente levam ao vazamento de dados sensíveis. |

## A API está vulnerável?

A API retorna dados sensíveis ao cliente por padrão. Este dado então é filtrado no lado do cliente antes de ser apresentado ao usuário. Um atacante pode facilmente investigar o tráfego e enxergar os dados sensíveis.

## Cenários de exemplo de ataques

### Cenário #1

O time de desenvolvimento móvel utiliza o *endpoint* `/api/articles/{articleId}/comments/{commentId}` para exibir metadados dos comentários em artigos. Investigando o tráfego do aplicativo móvel, um atacante encontra outros dados sensíveis relacionados ao autores de comentários que também são entregues. Isto acontece por uma implementação genérica do *endpoint* utilizando o método de serialização `toJson()` ao modelo `User`, que também inclui dados sensíveis.

### Cenário #2

Um sistema de vigilância baseado em IoT permite aos administradores a criação de usuários com diferentes níveis de permissão. Um usuário admin criou uma conta para um novo guarda de segurança que deve ter acesso somente a algumas áreas específicas do prédio. Uma vez que utiliza um aplicativo móvel, uma chamada de API é realizada em `/api/sites/111/cameras` para que sejam recebidas informações a respeito das câmeras disponíveis para apresentação em um painel de controle. A resposta da API contém uma lista com detalhes a respeito das câmeras no seguinte formato: `/api/sites/111/cameras`. Enquanto a interface gráfica exibe apenas as câmeras às quais deveria o guarda ter acesso, a resposta da API contém uma lista de todas as câmeras em uso naquele prédio.


## Como prevenir

* Nunca confie no cliente para filtrar dados sensíveis.
* Revise as respostas da API para ter certeza que elas contenham apenas informações necessárias.
* Engenheiros e arquitetos de *endpoints* sempre devem ser perguntar: quem irá utilizar esta informação? antes de expor um novo *endpoint* de API.
* Tenha cuidado ao utilizar métodos genéricos como `to_json()` e `to_string()`. Ao contrário, seja criterioso com cada propriedade que seja necessário retornar.
* Classifique dados sensíveis e dados pessoais que sua aplicação armazena, revise todas as chamadas de API se estas chamadas podem significar um problema de segurança.
* Implemente respostas com mecanismos baseados em *schema* como uma camada extra de segurança. Aplique o mecanismo e o imponha a todos os dados retornados pela API, inclusive erros.

## Referências

### Externas

* [CWE-213: Intentional Information Exposure][1]

[1]: https://cwe.mitre.org/data/definitions/213.html
