# API3:2019 Excessive Data Exposure

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **3** | Prevalência **2** : Deteção **2** | Técnico **2** : Específico Negócio |
| Abusar desta falha de segurança é simples e tipicamente passa pela inspeção do tráfego de rede para analisar as respostas da API em busca de dados que não devessem ser devolvidos ao utilizador. | As APIs delegam nos clientes a responsabilidade de filtrar os dados. Uma vez que as APIs são usadas como fonte de dados, com frequência os programadores procuram fazer implementações genéricas sem ter em consideração a relevância dos dados expostos. Regra geral as ferramentas automáticas não conseguem detetar este tipo de vulnerabilidade por ser difícil distinguir dados legítimos retornados pela API doutros sensíveis que não deveriam ser expostos. Esta tarefa exige um profundo conhecimento da aplicação. | _Excessive Data Exposure_ tipicamente conduz à exposição de dados sensíveis. |

## A API é vulnerável?

Quando a API devolve dados sensíveis aos clientes. Estes dados são normalmente
filtrados pelo cliente antes de serem apresentados ao utilizador. Um atacante
pode facilmente inspecionar o tráfego de rede e aceder aos dados sensíveis.

## Exemplos de Cenários de Ataque

### Cenário #1

A equipa de desenvolvimento móvel usa o _endpoint_
`/api/articles/{articleId}/comments/{commentId}` na interface de visualização
dos artigos para apresentar os detalhes dos comentários. Inspecionando o tráfego
de rede da aplicação móvel, um atacante descobre que outros dados sensíveis
relacionados com o autor do comentário fazem ainda parte da resposta da API. O
método `toJSON()`, pertencente ao modelo `User`, é usado na implementação do
endpoint para preparar os dados a retornar, o qual inclui informação pessoal.

### Cenário #2

Um sistema de vigilância baseado em IoT permite aos utilizadores com perfil de
administrador criar outros utilizadores com diferentes permissões. Um
administrador cria uma conta de utilizador para um segurança recém-chegado, o
qual apenas tem acesso a câmaras específicas instaladas no edifício. A aplicação
móvel usada pelo segurança realiza um pedido ao _endpoint_
`/api/sites/111/cameras` para obter os dados relativos às câmaras a mostrar na
interface. A resposta contém a lista com os detalhes das câmaras no formato
`{"id":"xxx","live_access_token":"xxxx-bbbbb","building_id":"yyy"}`. Embora na
interface apenas seja possível ver as câmaras às quais o guarda tem acesso, a
resposta da API inclui informação sobre todas as câmaras instaladas.

## Como Prevenir

* Nunca delegar no cliente a responsabilidade de filtrar os dados.
* Rever as respostas da API, certificando-se que apenas incluem dados legítimos.
* Os engenheiros responsáveis devem questionar-se sempre sobre “quem são os
  consumidores dos dados” antes de exporem um _endpoint_.
* Evitar a utilização de métodos genéricos tais como `to_json()` e
  `to_string()`. Pelo contrário, escolher uma-a-uma as propriedades que
  realmente devem ser devolvidas na resposta.
* Classificar a informação sensível e pessoal (PII) que a API armazena e
  manipula, revendo todos as chamadas à API onde esta informação é devolvida por
  forma a avaliar se existe algum risco para a segurança.
* Utilizar schemas para validar as respostas da API enquanto camada adicional de
  segurança. Como parte desta abordagem, definir e assegurar a validação das
  respostas do diferentes métodos HTTP, incluindo erros.

## Referências

### Externas

* [CWE-213: Intentional Information Exposure][1]

[1]: https://cwe.mitre.org/data/definitions/213.html
