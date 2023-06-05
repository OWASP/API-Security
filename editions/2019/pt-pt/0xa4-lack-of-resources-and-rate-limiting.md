# API4:2019 Lack of Resources & Rate Limiting

| Agentes Ameaça/Vetores Ataque | Falha Segurança | Impactos |
| - | - | - |
| Específico da API : Abuso **2** | Prevalência **3** : Deteção **3** | Técnico **2** : Específico Negócio |
| Para abusar destas falhas basta realizar pedidos simples à API. Não é necessária autenticação. Múltiplos pedidos concorrentes podem ser realizados por um único computador ou fazendo uso de recursos computacionais na nuvem. | É comum encontrar APIs que não limitam o número de pedidos ou que usam limites desajustados. | O abuso destas falhas pode conduzir à negação de serviço (DoS), deixando a API incapaz de satisfazer outros pedidos ou mesmo indisponível. |

## A API é vulnerável?

Os pedidos a uma API consomem recursos tais como largura de banda, processador,
memória e armazenamento. A quantidade de recursos necessária para satisfazer um
pedido depende essencialmente da informação enviada pelo utilizador e da lógica
de negócio implementa pelo _endpoint_. Deve ainda ter-se em consideração que os
pedidos de diferentes clientes concorrem entre si por estes recursos. A API é
vulnerável se pelo menos um dos seguintes limites não está definido ou foi
configurado com um valor desajustado (e.g. demasiado baixo/alto):

* Tempo máximo de execução
* Quantidade máxima de memória alocada
* Número de ficheiros abertos
* Número de processos
* Tamanho do pedido (e.g., uploads)
* Número de pedidos por cliente/recurso
* Número de registos por página devolvidos numa única resposta a um pedido

## Exemplos de Cenários de Ataque

### Cenário #1

Um atacante carrega uma imagem de grandes dimensões realizando um pedido `POST`
para o _endpoint_ `/api/v1/images`. Após concluir o carregamento a API cria
várias miniaturas de diferentes dimensões. Devido à dimensão da imagem carregada
a memória disponível é esgotada durante a criação das miniaturas e a API fica
indisponível.

### Cenário #2

Uma aplicação apresenta uma listagem de utilizadores até ao limite de 200 por
página. A lista dos utilizadores é obtida por meio dum pedido ao _endpoint_
`/api/users?page=1&size=200`. Um atacante altera o valor do parâmetro `size`
de `200` para `200000`, causando problemas de performance no servidor de base de
dados. Enquanto se verificam estes problemas de performance a API fica
indisponível e incapaz de satisfazer pedidos de qualquer utilizador (DoS).

O mesmo cenário pode ser usado para provocar erros do tipo _Integer Overflw_ ou
_Buffer Overflow_.

## Como Prevenir

* Tecnologias como Docker tornam mais fácil a definição de limites de
  [memória][1], [processador][2], [número de _restarts_][3],
  [número de ficheiros abertos e processos][4].
* Limitar o número máximo de pedidos à API, por cliente, dentro dum determinado
  período de tempo.
* Notificar o cliente quando o limite de pedidos foi excedido, informando o
  valor desse limite e o tempo restante para poder voltar a realizar novos
  pedidos.
* Validar de forma adequada os parâmetros enviados na _query string_ e corpo do
  pedido, em particular aqueles que controlam o número de registos a retornar na
  resposta.
* Definir e forçar um tamanho máximo de dados para todos os parâmetros e dados
  de entrada, tais como comprimento máximo para os texto ou número máximo de
  elementos duma lista.

## Referências

### OWASP

* [Blocking Brute Force Attacks][5]
* [Docker Cheat Sheet - Limit resources (memory, CPU, file descriptors,
  processes, restarts)][6]
* [REST Assessment Cheat Sheet][7]

### Externas

* [CWE-307: Improper Restriction of Excessive Authentication Attempts][8]
* [CWE-770: Allocation of Resources Without Limits or Throttling][9]
* "_Rate Limiting (Throttling)_" - [Security Strategies for Microservices-based
  Application Systems][10], NIST

[1]: https://docs.docker.com/config/containers/resource_constraints/#memory
[2]: https://docs.docker.com/config/containers/resource_constraints/#cpu
[3]: https://docs.docker.com/engine/reference/commandline/run/#restart-policies---restart
[4]: https://docs.docker.com/engine/reference/commandline/run/#set-ulimits-in-container---ulimit
[5]: https://owasp.org/www-community/controls/Blocking_Brute_Force_Attacks
[6]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/Docker_Security_Cheat_Sheet.md#rule-7---limit-resources-memory-cpu-file-descriptors-processes-restarts
[7]: https://github.com/OWASP/CheatSheetSeries/blob/3a8134d792528a775142471b1cb14433b4fda3fb/cheatsheets/REST_Assessment_Cheat_Sheet.md
[8]: https://cwe.mitre.org/data/definitions/307.html
[9]: https://cwe.mitre.org/data/definitions/770.html
[10]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-204-draft.pdf
